Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE5E7E8784E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 17:11:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnJmo-00012z-TA; Tue, 03 Feb 2026 12:01:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vnJml-00010s-8V
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 12:01:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vnJmi-0008Pc-CJ
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 12:01:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770138110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VTYIdMQvP3PzeqbZebN6Gxe2xSw6GE8j1PqDnAGQ4Jw=;
 b=epnLXvMcYxjgZfC6xNAlz9LFmAtB46UP5hy/W9xVkvCNfCQe4up/Dkd4ek/SRnJQd+r1rW
 9SniSZY7IBPMM5K+GN4KMcnB9cvfGCK984hhzk+9Z2Eah13broWO1gB6v9OOxPiv4H7bAU
 LYcWjC67WBIy37Ow4kGZflkVKM7a+vg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-p_Se8ikBMxuqxfNhCdZr6A-1; Tue, 03 Feb 2026 12:01:48 -0500
X-MC-Unique: p_Se8ikBMxuqxfNhCdZr6A-1
X-Mimecast-MFC-AGG-ID: p_Se8ikBMxuqxfNhCdZr6A_1770138107
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4802bb29400so73015375e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 09:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770138107; x=1770742907; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VTYIdMQvP3PzeqbZebN6Gxe2xSw6GE8j1PqDnAGQ4Jw=;
 b=Jsi3ir683TF3CZ18MpNCdcHDnfy/WJwETwI2dZ24xQ5DMiq0KONFxSHbpFHp5gWoFb
 +Z3FwqLEIcqP6CVNTgGJf6GUAM4HNyIQTOxihWPl6HjpcgcJKI/ytB1UyGyoKInJzyT7
 tqRJQC0cmOc/vXUHF8dn2EypROLRlthkiAVbcXxJM3POxOZTv3ggIvDpWABRYZa+wxIA
 pHsvtms9nPiCCHEaViDV3DpA4sDzviNSZNVB7xlGlAeGqEFkFxR2IUqvzGwGYj/98QWI
 L7/SIdik8bBJRXQ+T/AvnAIak7yWOJ8aMoeASQ7n4Fy7vBI9ABGIYOCXTXdf+lsrJaNl
 GeKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770138107; x=1770742907;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VTYIdMQvP3PzeqbZebN6Gxe2xSw6GE8j1PqDnAGQ4Jw=;
 b=AMx/godwwdm26Hkpgaxsdr+stZWjo4UlXlRWzLAbFMjFtjReaJyrgalHeZIOUySpL5
 4OPQzNzTMtmIKubMSHqXoXc7kG0Dax8KYI7+mATVp2wUYD0U7BYoqjkv4LD1WpZjGNTw
 zRVnKi/hJzGnUuJJmtmq+YcUZXfcg1T3JG80YRTSsZqNp3zZh3XsTdtdDR3e0tOloOWx
 J36+fB0y8x0ODp7UCl7IEb8VPit0rHIrQ8fIFrD7PvBwdR81rExWZrIaQAfxEStxmMAs
 YX5RD2q/rrsjIxBOtkA6TEsEJyRGaQ8Dbo0NV0wjRGld0KjQ+BNkNHIUkP7YVG7D1EyG
 xLug==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7tVjUzoPb7dqryxPExZfxDY+H593LUo9FAC/FhoFpu5Jl1hVd90/83aom4P25KHPDlv9CK75ey+Ho@nongnu.org
X-Gm-Message-State: AOJu0YxCjp30Bd3fmXOi0mjREY5XSvaNoa1oW16LWs3Mx0sAcgoU5xiS
 g+Ms2CClgQHJzuSsHJDw7fku+Cfez32ySjWsR0xeC1FJWVy8CFEiB59nPw2Sd2q4Czl4oB4b5fI
 B36FKjoWcvMkdxbh8ixoO7dK4MTQ0i4A9S2NLDbW42vLJtai/07c1p7Ot
X-Gm-Gg: AZuq6aJGRf5OK1P0iAe89/86ZCjami8L1JOYCV0+rarQr+a09gRzxN3eSoJQ6wNC0Df
 fBQN1fzqLbg6a9fTTgFw4vcBnk7BzG+9GBJL3akxi+0vaYMr6YYcPiuozERsqqzhIALRBUX0A36
 5/uFyMh3Qk0J81dL4RzGYgwPDJwQcFAxK1hJKv2UKd1TD/j1yMsTAGZT2D1xKYPV/uhrJEtaLOH
 pNa/jvvso6JdYw2s5Sip2SkhqUOofIhAKNTjg2Mw8oX4qAm/WC8xLKOjuc1+VkRO8bVt9GGtVEy
 RzvqkhdjQA2kdRfR8xErmivccTkQt0q6/DuCoVnEGVueY6bLcQslpAYjzJ2TTqQ6ARtwuW9/GRp
 iGsMEZ+2XCrsOWtiJjxmzjcNbcs46tGztgw==
X-Received: by 2002:a05:600c:19cd:b0:480:32da:f338 with SMTP id
 5b1f17b1804b1-4830e940b2cmr4315805e9.14.1770138107427; 
 Tue, 03 Feb 2026 09:01:47 -0800 (PST)
X-Received: by 2002:a05:600c:19cd:b0:480:32da:f338 with SMTP id
 5b1f17b1804b1-4830e940b2cmr4315155e9.14.1770138106813; 
 Tue, 03 Feb 2026 09:01:46 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4830516a0a0sm73893265e9.15.2026.02.03.09.01.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 09:01:45 -0800 (PST)
Date: Tue, 3 Feb 2026 12:01:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Wafer Xie <wafer@jaguarmicro.com>
Cc: eperezma@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org,
 leiyang@redhat.com, sgarzare@redhat.com, angus.chen@jaguarmicro.com
Subject: Re: [PATCH v4 0/4] Add Split indirect descriptors for SVQ
Message-ID: <20260203120023-mutt-send-email-mst@kernel.org>
References: <20251231103615.9987-1-wafer@jaguarmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251231103615.9987-1-wafer@jaguarmicro.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Dec 31, 2025 at 06:36:15PM +0800, Wafer Xie wrote:
> 
> This patch series adds support for VIRTIO split indirect descriptors.
> The feature is VIRTIO_RING_F_INDIRECT_DESC.
> 
> Eugenio hs submitted a patch: vhost: accept indirect descriptors in shadow virtqueue
> https://lists.nongnu.org/archive/html/qemu-devel/2025-12/msg00056.html
> Therefore, this patch must be applied first.

Thanks for the patches but i could not apply them.
This posting is corrupted. Pls post as a thread and without corrupting
patches.


