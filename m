Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 548A8D41179
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 11:58:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgLz8-00034D-O3; Thu, 15 Jan 2026 06:57:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vgLz7-00032n-6n
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 06:57:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vgLz5-00049M-GY
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 06:57:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768478271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2NSD+Ip1g3G1zmN7jbM7btgV7gzBtMjsmaTu2CJ19LU=;
 b=gMQjS45Wj1UDzu4GDLQ1JSOF2nQE97DFJy6IPVE1hd4Q2qM8qQin+zrPLVUUerisVdbS3u
 QJxR+iGExJweYxP9fpOto5wJBzMY2LK8UtNQfp8C/xeliLBsNrgiN1ZLGDAFv6Pjy1rL5t
 qwpEatM74D+6bkjRQmEOH3LxVRLvpOQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-3eFuSFYUMQi9dr7MNrjYbw-1; Thu, 15 Jan 2026 06:57:49 -0500
X-MC-Unique: 3eFuSFYUMQi9dr7MNrjYbw-1
X-Mimecast-MFC-AGG-ID: 3eFuSFYUMQi9dr7MNrjYbw_1768478269
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-430fe16b481so429796f8f.3
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 03:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768478268; x=1769083068; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2NSD+Ip1g3G1zmN7jbM7btgV7gzBtMjsmaTu2CJ19LU=;
 b=BU5XaI7yWwby+HEYzcm2vUAfBjSAD/Zzh0hD2GjIAH1m2DyP2ud1ax0z1f4Bsp9yqQ
 fqRom50YpZVje6ba7w14Grf8SdPUtsegaVSrhNKdQkOn6QpDmCI03wpYq5EQDPAqcqCF
 orzmTKsRi2T2ctbHn2txrLAnRLot833IN/AM4KfeqxBH0mn3GnXdf8oLT180NXahMtVC
 MWkBIRd/lJNVBvAbjCGBXi+HowetolouQEeSVTreuHvdqgkaGARDG8hQgVgJzmImD3yB
 NtNKFenQWee+5UpKcWhkIWJcY8mISiV9gm9aLLEOpOOxew6nWWuAKuNwCrRBPj/T4B7p
 vf0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768478268; x=1769083068;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2NSD+Ip1g3G1zmN7jbM7btgV7gzBtMjsmaTu2CJ19LU=;
 b=kNKdv89CF3wgKUNFyL+zIWDZdeef4y5y3ZXkmNaVSPPKwMjvsktxSbYD1Q9dEMeCTz
 cmxtZXREjP7j00XNDyuK3RfRHFjcBZ4QXrytFOpNSeQP5tIvcxilO1SpkHU58wNDULk/
 7gdUs7+TlTSIUwFqaXrXkQTaSzmtGi2SeYTTQlbrXKYkxZdREfUyWD8w7W9yXFWVVQNy
 T252uP8nw3RsbCFgAAxtm8hIctefidQjEuoZS2pVbuvI10vqWigSQdCHQ4/8qK5fSnXS
 FRSuCLE+prf/OyTuS6B6T+sO0QWpT0bBvtTiw2/7RJLaxcEW384dX+DijfABOHwv82uB
 Jfvw==
X-Gm-Message-State: AOJu0Yz6QJbL8/YUIvwa8ujjcMRM44gjKqzx+MWxbEC984irFM/95KsP
 cNOpxyr8FKQrPWlvyovZQJ0UY1+JXfwGgkyef3LEQgAFtvByLYCos9/21UI+Hqc4mYaXELPc+v+
 bO5wCeoW5aSabOAZKwq9OoaXE/ajbiLid4vfllwGtfUD7mnYtX0o4rp/VQb7A5crGo9XV/W/uFj
 zO4P0S+scwUOm7vxw9hiJQc2UYk442X/HJZQy3InWlOA==
X-Gm-Gg: AY/fxX4ehhOV4TApQW8TOmOqVsyxdQ7z0YjwsK+R4S4UkleOdu2yV1e4pe+0ceP1j9r
 StX12llzcqtXSwgzpvmrLUl1coEaql3rqnXLJ+jVvAgk32Lesy7fraHNv2Z+kdy+uKarsmzVAWY
 duahRam1MH/AaxqR7cYUoT/3PmhAWe8iDF+ZsKqmasn8tlEh7PRFdqGl0DxHR3myxDyRSX4vB/Z
 hNnetAarhiNoKdr5oioCmA/9o3PG9DV18iE/q4km8FEgMFTS1caBWnE
X-Received: by 2002:a05:600c:6487:b0:480:1a22:fce8 with SMTP id
 5b1f17b1804b1-4801a22fd9cmr19688675e9.26.1768478268145; 
 Thu, 15 Jan 2026 03:57:48 -0800 (PST)
X-Received: by 2002:a05:600c:6487:b0:480:1a22:fce8 with SMTP id
 5b1f17b1804b1-4801a22fd9cmr19688355e9.26.1768478267761; Thu, 15 Jan 2026
 03:57:47 -0800 (PST)
MIME-Version: 1.0
References: <20260106203320.2110372-1-peterx@redhat.com>
 <20260106203320.2110372-3-peterx@redhat.com>
 <CAE8KmOz9XtaEY+LMD9CCCR_bMXe04chGHdvuwVqsYRNe+AtUJg@mail.gmail.com>
 <aV6UhNJzQLnDaJvO@x1.local>
 <CAE8KmOzPHTf6eaufn3dWTJJ2nsifdxZzwENK2hD_LZLGiE-pcQ@mail.gmail.com>
 <aWe35LsGn_68MIUu@x1.local>
In-Reply-To: <aWe35LsGn_68MIUu@x1.local>
From: Prasad Pandit <ppandit@redhat.com>
Date: Thu, 15 Jan 2026 17:27:30 +0530
X-Gm-Features: AZwV_QgsTT3Gf6JbY3tPcUUIVy2wVQ3s9s8__bwcpjbsjLjrznQR0TubDEMl_rg
Message-ID: <CAE8KmOwgSyVYBsUjsY07ynKU3YUYn=2pmSCxZnKT9=nQVor7kA@mail.gmail.com>
Subject: Re: [PATCH 2/2] tests/migration-test: Remove
 postcopy_recovery_fail_stage from MigrateCommon
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Lukas Straub <lukasstraub2@web.de>, Juraj Marcin <jmarcin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 14 Jan 2026 at 21:06, Peter Xu <peterx@redhat.com> wrote:
> > * Let's make it fail_stage in both places then?
>
> Could you explain what's the 2nd place to use it besides the parameter in
> test_postcopy_recovery_common()?
===
tests/qtest/migration/framework.c:
    static void postcopy_recover_fail(QTestState *from, QTestState *to,
                                       PostcopyRecoveryFailStage stage)
===
This one. ^^

Thank you.
---
  - Prasad


