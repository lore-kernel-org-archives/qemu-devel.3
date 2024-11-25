Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8D6D59D72
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 21:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFgZ2-0006Fa-3t; Mon, 25 Nov 2024 16:24:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tFgYy-00067W-LX
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 16:24:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tFgYw-0001KU-Qq
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 16:24:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732569845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DiiNhnmCqRXILNTTZhFH17rdtH6YHk+47ieUdFgN2Ic=;
 b=f7VSJfqJBukJKA8Qbh2a2w+kYIJ6qIk1HpEvDtzRVqMUrSgjKXgPIzSup05+RoFtw6zQZE
 YHWEgaoSXrQu8uOL+O06CZZxZlPpuWcCC/+p6b8gJ7lFqHDDn6qcbGUOonWLtTh/U/9SoK
 20BW75d6s/sxlK+XK8JmhFAeZxGOEmM=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-5j7WKpG6PUy6JCwx3MLHjQ-1; Mon, 25 Nov 2024 16:24:03 -0500
X-MC-Unique: 5j7WKpG6PUy6JCwx3MLHjQ-1
X-Mimecast-MFC-AGG-ID: 5j7WKpG6PUy6JCwx3MLHjQ
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-841963a1fb4so161337439f.2
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 13:24:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732569843; x=1733174643;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DiiNhnmCqRXILNTTZhFH17rdtH6YHk+47ieUdFgN2Ic=;
 b=rzEDIjwMn7jNU4L1gbRWG5fgMpQhAuGyUGhlI9SMC2IFLyqXo881+kl+TqJShKdTMf
 IE9EAmFWgqt2HfiimAhxx89u4ZdBSSUNYRPCXHruTzxIFjFLS69+9Dfc8wWeMRekjW0o
 5gNAWqgmlpWO91eUvfIuh294yrKq/FReiHTMivj6W8WW4Ox6I2fydUWCN2gZbiSqdxbR
 YYugmoud8ulMrAnfB3KvKcsHvvFiUK+ULnJlzyES9CYJ1bWFr0ZIqcaJHahyRqRHAYBD
 QxDxkPUO0XfLYqOc3IzZ7gx0j6xkpAhVsb4diq5FznAG12LeZcBeWbjIn34FcbQB+hQx
 mHbA==
X-Gm-Message-State: AOJu0Yz0SSiaitM5FP+pH9b/FIC0wPmc23RKGbq5I9yn2p7L9wp22mZB
 n0R3zfH12B33fABGQNfYSsNWj/ng7N2Yy20QEUWyvCSfKTtubDxx+CxjEPcrFfXNaGSpek727cX
 tvrwbNvSFmAQFQrYkL88je9vzfZovFSvtgDOQ9on2P763ByUkc4yj
X-Gm-Gg: ASbGncuRjYs8jB8rmq8ekh2wda/NLnk8WpfY52a3xTWiv2zmqTel8ggIFmUH+FTFNLP
 QXyWKYSBQlPSADuzM9soldYie/7A86Ov+ZB98cXoZj/mB4qcwVjLdTrDpgMIqDQYOLEtYpNr/0U
 EUmE0ilAsESerVi/WvB3nfDL5yPpl+qdjYraopFvKA4rf6vPtbz131u3KVW9QQo7okv5I2srxOC
 VD+QQLxFL69ArKWaZ8+j3DPWgTPtoQ74PHwePIoIlFLTQhigU3oHhvVlxTMZylMo+WOUXtdyomn
 VFCzKhpp/0w=
X-Received: by 2002:a05:6602:29d4:b0:83a:a746:68a6 with SMTP id
 ca18e2360f4ac-83ecdc611d1mr1739093439f.5.1732569842873; 
 Mon, 25 Nov 2024 13:24:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5uObW3sl65PYqEe9FKQa5yDLvhmYU0CmH2ipOooC5jPVKKCU1QvTJ/EopesFCnvMKxarMrw==
X-Received: by 2002:a05:6602:29d4:b0:83a:a746:68a6 with SMTP id
 ca18e2360f4ac-83ecdc611d1mr1739091839f.5.1732569842611; 
 Mon, 25 Nov 2024 13:24:02 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e1cfe5060bsm2368959173.65.2024.11.25.13.24.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 13:24:02 -0800 (PST)
Date: Mon, 25 Nov 2024 16:23:59 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 00/22] tests/qtest: migration-test refactoring
Message-ID: <Z0Tq723fXUn81KoC@x1n>
References: <20241113194630.3385-1-farosas@suse.de> <Z0TlE9PNsTR5CWKO@x1n>
 <874j3vnhbc.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874j3vnhbc.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.93,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Nov 25, 2024 at 06:18:15PM -0300, Fabiano Rosas wrote:
> > One thing we could do (but you can decide which you prefer..) is you can
> > respin with the initial 18 patches, then we may get it in in the 1st 10.0
> > pull.  It may conflict with some other series for sure, but it's
> > unavoidable with such changes one way or another..
> 
> I can put them on top of migration-next, sure. As I said previously,
> just point me at any conflicting series and I can provide a rebase.

I didn't queue anything yet for -next.  So far this series looks like the
closest to be queued first there.  So I suppose if you repost you can base
onto the master branch.

-- 
Peter Xu


