Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA45BD2C12D
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 15:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8LMO-0003II-Ml; Tue, 05 Nov 2024 10:20:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t8LMM-0003Hr-Uo
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 10:20:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t8LMJ-00030X-II
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 10:20:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730820041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ez5XIPS/9nLywHyEN+4ZGYnLUoQKzwv29VN8i+r1xIk=;
 b=CKcZf30PlxHImfgr5sKPZGo2jgmqrk08ZFtiOcD59TrK75BQo8wV7J9dzoIkLd/8VD1uN+
 az1Q1DZMaKtduUKSgJtdoQMGLZsrSMtFKz/cZ80R9VYCHxwcDTC2QbTCox+z6B8KWm2kUk
 VFIYDAgBRAnO08WmOhtEM6s7CgoCkAI=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-9jDUOZplN4aQaGfhL1DCWQ-1; Tue, 05 Nov 2024 10:20:39 -0500
X-MC-Unique: 9jDUOZplN4aQaGfhL1DCWQ-1
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-718107b2091so4179739a34.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 07:20:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730820039; x=1731424839;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ez5XIPS/9nLywHyEN+4ZGYnLUoQKzwv29VN8i+r1xIk=;
 b=X5GV2i5juUj7xkUwEvLvVHT5CnH5R4fj5Ecu65teI5/1IWvtAmJrf6DxlGfnBhaV0H
 zlxGj9ldYGaa0RbirrCRkWDOQjmLKbfRra/I9YrSNKBTAraY+yAwmeKcFRuPk0Y+5wcq
 6JNyfp3zp5Zg5Y1QexW/cL64EM8Cf7LGBRp9owU4HzAPgu8lRhwU3EX0mSPlV4s7krwG
 n4zaf5rZ3Klo3Jwn28fx/3vrZdi9j6iD/pFRTIl44JkpgmlhIbj9jnjXndgt+rHBOmg4
 uRV1edufGD4Q7r3wuBzsLl5HXuVGHTKA8Z1O2VrCcPbKtTMpzRPZ8CCC7Tmsr4qw5ILU
 YQmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXb9frMwLHwgLytHs79EI3wCNpRdazIP6jOsRJEVJBcCdMQJpnlLjagwt+6S3UCRbNAo5nC5L7PFI90@nongnu.org
X-Gm-Message-State: AOJu0Ywl6qbptAhsc821RTiqJnYich1m7NSRIQY4kKSZedwJ6z06lbA6
 xQDpBaMIi484331UCSTfIvpiMij2UmohPFHKJoes9SFZ66XVimjzNJFQY4ViQMofXygBg3iiLLC
 PolYkrSVLSAQ6LxUnQNmu4hKGgns9oDX1ElIQ1wLLH01bgS2gs5o3
X-Received: by 2002:a05:6830:710c:b0:713:67f6:bcbd with SMTP id
 46e09a7af769-7186811b691mr31143634a34.9.1730820038907; 
 Tue, 05 Nov 2024 07:20:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4QlXXKd/6YNq68Xh1kWnjKmN+XYgVht3RkNfCH6zU0CO0x5RiPOiP9N7pkNbU2UjIuAW3fA==
X-Received: by 2002:a05:6830:710c:b0:713:67f6:bcbd with SMTP id
 46e09a7af769-7186811b691mr31143608a34.9.1730820038634; 
 Tue, 05 Nov 2024 07:20:38 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7189cc69c5dsm2482410a34.20.2024.11.05.07.20.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 07:20:37 -0800 (PST)
Date: Tue, 5 Nov 2024 10:20:35 -0500
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 2/2] vfio/migration: Add
 vfio_save_block_precopy_empty_hit trace event
Message-ID: <Zyo3w6RdIr0nLV0t@x1n>
References: <cover.1730750959.git.maciej.szmigiero@oracle.com>
 <44a769267d406e10fd122786f0153b5fa2697500.1730750959.git.maciej.szmigiero@oracle.com>
 <0aa77f89-fe28-47d1-8125-e98dff928e98@redhat.com>
 <4a4c2bc2-693a-4379-a444-2cb8fdf1f6b5@maciej.szmigiero.name>
 <d722992f-6886-4ad4-9d60-2acc61604739@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d722992f-6886-4ad4-9d60-2acc61604739@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Nov 05, 2024 at 01:51:31PM +0100, Cédric Le Goater wrote:
> On 11/5/24 13:20, Maciej S. Szmigiero wrote:
> > On 5.11.2024 08:56, Cédric Le Goater wrote:
> > > On 11/4/24 22:29, Maciej S. Szmigiero wrote:
> > > > From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> > > > 
> > > > This way it is clearly known when there's no more data to send for that
> > > > device.
> > > > 
> > > > Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> > > > ---
> > > >   hw/vfio/migration.c           | 8 ++++++++
> > > >   hw/vfio/trace-events          | 1 +
> > > >   include/hw/vfio/vfio-common.h | 1 +
> > > >   3 files changed, 10 insertions(+)
> > > > 
> > > 
> > > Reviewed-by: Cédric Le Goater <clg@redhat.com>
> > 
> > Thanks, will you pick up these two patches or
> > is Peter supposed to do it?

When there's dependency, we can discuss how to merge. But I suppose all
standalone hw/vfio/* patches should by default go via Cédric.

> 
> I will send a small PR at the end of the day.

Thanks!

-- 
Peter Xu


