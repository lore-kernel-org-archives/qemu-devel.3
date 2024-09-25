Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 396EECF9C7A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 15:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stTdI-0002PY-Bb; Wed, 25 Sep 2024 11:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1stTdG-0002Ow-Lv
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 11:08:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1stTdE-0008Nt-PH
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 11:08:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727276922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vw4+VOZtZ5/QPeqIgByRwRB8leOllhKEDoiZi7+/ZGo=;
 b=NH94LKZaDdf93il9BO1NCKkgHXIOru3PT4WcGjpcYbhy/JnE8QhoecTy2GttmiiMEuc94D
 44oAbKLlXp+dmM5jcxN0pL3ONmHYUAjhGscxOqQ4cOe+YTTBMSZamme/+/QUySEI6NMwLe
 P1hPq1HHXSUomGDMPLwAboIi6gWUK6U=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-SSWJYPJ5M_SJClkLRU-vdw-1; Wed, 25 Sep 2024 11:08:38 -0400
X-MC-Unique: SSWJYPJ5M_SJClkLRU-vdw-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-718ea25967eso7714411b3a.2
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 08:08:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727276917; x=1727881717;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vw4+VOZtZ5/QPeqIgByRwRB8leOllhKEDoiZi7+/ZGo=;
 b=e5ZOLYYsGPuecRVbkNF9ldnFGBVaEnvxlKJnOaX2HtOVY9ke4rnuDa4iaYmrKjfvOW
 sRHa9rilYve3zgjnmcTeTef/JBAOfVaSA2AQ+s7PORCRvSjPPA9tgNhd7gppL6gcfB/8
 Va5rGpHMp87OZpVlPxUoY8ZWYInWv8j3xxpSLS/fDjn0kE28gnDZotxbB74oY4wHpdkg
 5gx0klbbOqP+e1pqH63Cljrn4dRzdwXjlBdGeAOitP6UEoRCaGmp8x6MXz3tkjxYdhBh
 SRJd/bGweGpCtc40gic8ou1RWNCl5yxMBHWdHOJqKho7ilKLp+Jr4joK3VWRMhV7eogZ
 QrLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVK1tPpvpg/3Nv9PLeSDLuAjSA7xpQ5nJHUAjkw87zC0KPOzpRvo9FoH6a+KqPnaHgmeO0smZdZ2wkq@nongnu.org
X-Gm-Message-State: AOJu0Yzjo7X/kkL/v/Q4TIN/v1bPIqkdFcXnaLtmEfJOSRBzjnrhv7w9
 D/6meyfqpmbLN9Edg6HtC1bPgtKuzgJJCLpbw5zByz7fkhiMFOQkUyndmZb68NUv1IJ1dF6Vmcp
 yB8FLBkBBrMpaWNGyhEej2UnPeaTys0E0ECwIFqtB9skjIJRAdIB5
X-Received: by 2002:a05:6a21:1690:b0:1cf:339e:a8d1 with SMTP id
 adf61e73a8af0-1d4c6f3445amr2455051637.10.1727276917204; 
 Wed, 25 Sep 2024 08:08:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGedfQRbqZkQZ06e8nfB7irxihaWzOA2L9hYXFn6e1zxT4gAqUZRz1ZT9CrCxz7bwn9cbpSWQ==
X-Received: by 2002:a05:6a21:1690:b0:1cf:339e:a8d1 with SMTP id
 adf61e73a8af0-1d4c6f3445amr2455009637.10.1727276916841; 
 Wed, 25 Sep 2024 08:08:36 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e6b7c5c06fsm2895016a12.55.2024.09.25.08.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 08:08:36 -0700 (PDT)
Date: Wed, 25 Sep 2024 11:08:31 -0400
From: Peter Xu <peterx@redhat.com>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: Michael Galaxy <mgalaxy@akamai.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "yu.zhang@ionos.com" <yu.zhang@ionos.com>,
 "elmar.gerdes@ionos.com" <elmar.gerdes@ionos.com>,
 zhengchuan <zhengchuan@huawei.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Xiexiangyou <xiexiangyou@huawei.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "lixiao (H)" <lixiao91@huawei.com>,
 "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
 Wangjialin <wangjialin23@huawei.com>
Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
Message-ID: <ZvQnbzV9SlXKlarV@x1n>
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
 <Zs4z7tKWif6K4EbT@x1n>
 <20240827165643-mutt-send-email-mst@kernel.org>
 <027c4f24-f515-4fdb-8770-6bf2433e0f43@akamai.com>
 <84c74f1a95a648b18c9d41b8c5ef2f60@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <84c74f1a95a648b18c9d41b8c5ef2f60@huawei.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.108,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Sep 23, 2024 at 01:04:17AM +0000, Gonglei (Arei) wrote:
> Hi,
> 
> > -----Original Message-----
> > From: Michael Galaxy [mailto:mgalaxy@akamai.com]
> > Sent: Monday, September 23, 2024 3:29 AM
> > To: Michael S. Tsirkin <mst@redhat.com>; Peter Xu <peterx@redhat.com>
> > Cc: Gonglei (Arei) <arei.gonglei@huawei.com>; qemu-devel@nongnu.org;
> > yu.zhang@ionos.com; elmar.gerdes@ionos.com; zhengchuan
> > <zhengchuan@huawei.com>; berrange@redhat.com; armbru@redhat.com;
> > lizhijian@fujitsu.com; pbonzini@redhat.com; Xiexiangyou
> > <xiexiangyou@huawei.com>; linux-rdma@vger.kernel.org; lixiao (H)
> > <lixiao91@huawei.com>; jinpu.wang@ionos.com; Wangjialin
> > <wangjialin23@huawei.com>
> > Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
> > 
> > Hi All,
> > 
> > I have met with the team from IONOS about their testing on actual IB
> > hardware here at KVM Forum today and the requirements are starting to make
> > more sense to me. I didn't say much in our previous thread because I
> > misunderstood the requirements, so let me try to explain and see if we're all on
> > the same page. There appears to be a fundamental limitation here with rsocket,
> > for which I don't see how it is possible to overcome.
> > 
> > The basic problem is that rsocket is trying to present a stream abstraction, a
> > concept that is fundamentally incompatible with RDMA. The whole point of
> > using RDMA in the first place is to avoid using the CPU, and to do that, all of the
> > memory (potentially hundreds of gigabytes) need to be registered with the
> > hardware *in advance* (this is how the original implementation works).
> > 
> > The need to fake a socket/bytestream abstraction eventually breaks down =>
> > There is a limit (a few GB) in rsocket (which the IONOS team previous reported
> > in testing.... see that email), it appears that means that rsocket is only going to
> > be able to map a certain limited amount of memory with the hardware until its
> > internal "buffer" runs out before it can then unmap and remap the next batch
> > of memory with the hardware to continue along with the fake bytestream. This
> > is very much sticking a square peg in a round hole. If you were to "relax" the
> > rsocket implementation to register the entire VM memory space (as my
> > original implementation does), then there wouldn't be any need for rsocket in
> > the first place.

Yes, some test like this can be helpful.

And thanks for the summary.  That's definitely helpful.

One question from my side (as someone knows nothing on RDMA/rsocket): is
that "a few GBs" limitation a software guard?  Would it be possible that
rsocket provide some option to allow user opt-in on setting that value, so
that it might work for VM use case?  Would that consume similar resources
v.s. the current QEMU impl but allows it to use rsockets with no perf
regressions?

> 
> Thank you for your opinion. You're right. RSocket has encountered difficulties in 
> transferring large amounts of data. We haven't even figured it out yet. Although
> in this practice, we solved several problems with rsocket.
> 
> In our practice, we need to quickly complete VM live migration and the downtime 
> of live migration must be within 50 ms or less. Therefore, we use RDMA, which is 
> an essential requirement. Next, I think we'll do it based on Qemu's native RDMA 
> live migration solution. During this period, we really doubted whether RDMA live 
> migration was really feasible through rsocket refactoring, so the refactoring plan 
> was shelved.

To me, 50ms guaranteed is hard.  I'm personally not sure how much RDMA
helps if that's only about the transport.

I meant, at least I feel like someone would need to work out some general
limitations, like:

https://wiki.qemu.org/ToDo/LiveMigration#Optimize_memory_updates_for_non-iterative_vmstates
https://lore.kernel.org/all/20230317081904.24389-1-xuchuangxclwt@bytedance.com/

I also remember we always have outliers that when save()/load() device
states it can simply be slower (takes 100ms or more on a single device; I
think it's normally has kernel/kvm involved).  That one device can already
break the rule, even if happens rarely.

We also haven't looked into multiple other issues during downtime:

  - vm start/stop will invoke notifiers, and notifiers can (in some cases)
    take quite some time to finish

  - some features may enlarge downtime in an unpredictable way, but so far
    we don't yet have full control of it, e.g. pause-before-switchover for
    block layers

There can be other stuff floating, just to provide some examples.  All
these cases I mentioned above are not relevant to transport on its own.

Thanks,

-- 
Peter Xu


