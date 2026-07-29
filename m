Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17032C53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 14:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp55B-00010p-87; Wed, 29 Jul 2026 10:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wp55A-00010h-8N
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 10:16:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wp557-0001oF-VY
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 10:16:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785334584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sXW5hs3y2YAQhtjGALA4YL/Yh60k03mu7P9ikrQeMEg=;
 b=IL6011xNhjgC7eunvnPSnCVi7r1Vgfzav3fd6QgUHqxGWF6nvziuZGIjZKLivTYZqSxQ7e
 +Vt0yUr6OGdiH0S+Jd9beaWP3Rnv/u6I9fE39H1WicjIgh4qsCy3WGDXzQmBcjgdJeR4A2
 UmVDoCCkE7hWC4GJjyTn4G607zcmOxg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-HRFQtIrqNqajL_LRa-q0Aw-1; Wed, 29 Jul 2026 10:16:23 -0400
X-MC-Unique: HRFQtIrqNqajL_LRa-q0Aw-1
X-Mimecast-MFC-AGG-ID: HRFQtIrqNqajL_LRa-q0Aw_1785334582
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c0408254aso4509581cf.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 07:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785334582; x=1785939382; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sXW5hs3y2YAQhtjGALA4YL/Yh60k03mu7P9ikrQeMEg=;
 b=YKg9E6EEFtuJMUd5HXDJM8h14f8QT6oHGceBjd7O2ecfDzW4+JLAgqHJuwaLvd5XGa
 YmQukNB7xGyRb0RpQLxhH5hz6+P3OUkdfClIScgu8m7VntYMtfANe61bU05H6ghLG2vc
 aEpELykNO02ItQ1NZYP7zrfxNVQMpKmh75/SLOu4O32CSAWkP4Ad37OtlS3rJn8+J9sn
 nmHNF6PTNKSD8DU0dprYhDk/EUqi1guT9HELkB8We8GnbW+4+CocgIjGPbD9ci0nsr9R
 h7PsQ5Nwxvn550V48V5RV5jy/5zNiKYVuJg2e7dGY7nNpXbrydJc9xzqb6gJuLb1b5Z6
 2YHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785334582; x=1785939382;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sXW5hs3y2YAQhtjGALA4YL/Yh60k03mu7P9ikrQeMEg=;
 b=iRLVAH2lLNFIIRN3ztb3IrEdU75jMsQezHWbt23nB/K7RxCQ1MM3Mq3m74MsIuOOlc
 JxBfq0uJj3xE5Gyy0PpeVY8eM5HZbGOzwgCyWeTYRKH9e1YWPaQLK0evn8ggju1UcQpv
 CIRnIT9cxB/YWghyn4sI829Oef8vpgNJx9sYfcc1a9z63yp/XfCoeZEI7uf7DzOSsKIY
 i5g4NqrrtKnY75l7qS2YfaVM5vppFrdmP6uX+QvlyyCIaqm7LsM+/4hu6eYqKFKv+f8Y
 5tZZbATcMNYnUVpovPwpXOLS4TErKNR4MUw0mcTQfRkB2rYIebNx6DUHt5UjSuJfBQBU
 ijeg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpYDb70gFFRI7ZiczA2BN1kk4OaVq4QLW75GbvcSZiQcLqfC6vezacSiYXXtODAAZPLaE1X+pC3YmZ0@nongnu.org
X-Gm-Message-State: AOJu0Yzl3BN4FtTH1RoEklw43nbcZWMM0Byecr/DKiVjJh3oevW55viT
 DzEFRleFVkySzotBj9klq0UaZLCLY1rNGtiFCKtilnYTf7p3zZsdcxGa64FHEROONL0MTawgQOI
 /2K1cyKlyrG1A62FVrho2SQcFc4kVler2ZwOMTYzf6LP2C1i+rIqJ5eSO
X-Gm-Gg: AR+sD13tFLBZj2w85FhVD02c2Tn8AGn2Q69CTsdVTGo/oAMVbkkASZq7VbHIwiBUKBb
 ix2fRvNzUI6XRW+GhySv/rKuKX0dBEgCkZNqP7cUoQfuY5zMWKnmsrB8MLLVKEZF+7KRoYybBrs
 qH7+wpWeKBSO13xPcKSBM3R/oPU8MgpR+uEa8XsN+oK8FsBKqV98U0H6k6yHbQoU45efp6hX9lX
 nz4T1cg+LMi7zB2kW24CWjz9JpDLeI0ayVw4ipWxi0PdDVWqZri+9h8p7JUmvxroav13ixXccg4
 1JLXd8KGAudvERk5ynBL4IpEZugUFkJ9rMe7qTzMJUwBtQSFM/KoE8evwCTzyo7RqYk8YGgAn6n
 QzQrLrvz3OkGDUk/Yidw9FLJlMYM=
X-Received: by 2002:a05:622a:5918:b0:527:e2d4:b0bb with SMTP id
 d75a77b69052e-52b2adcfb98mr19072941cf.28.1785334582034; 
 Wed, 29 Jul 2026 07:16:22 -0700 (PDT)
X-Received: by 2002:a05:622a:5918:b0:527:e2d4:b0bb with SMTP id
 d75a77b69052e-52b2adcfb98mr19072531cf.28.1785334581514; 
 Wed, 29 Jul 2026 07:16:21 -0700 (PDT)
Received: from x1.local (67-208-31-164.ip.tor.radiant.net. [67.208.31.164])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-529e2d826fbsm19026391cf.14.2026.07.29.07.16.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 07:16:20 -0700 (PDT)
Date: Wed, 29 Jul 2026 10:16:18 -0400
From: Peter Xu <peterx@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alexandr Moshkov <dtalexundeer@yandex-team.ru>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Stefano Garzarella <sgarzare@redhat.com>,
 =?utf-8?B?6rmA7Iq57KSR?= <seungjung0711@gmail.com>
Subject: Re: [PATCH] vhost/migration: Fix incorrect size used in
 inflight->addr in VMSD
Message-ID: <amoLMvYlUCZYwHB2@x1.local>
References: <20260728153942.1891677-1-peterx@redhat.com>
 <77c2f243-498f-4f2f-9dfd-1ccb2c9aa94b@yandex-team.ru>
 <20260729041953-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260729041953-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jul 29, 2026 at 04:49:13AM -0400, Michael S. Tsirkin wrote:
> On Wed, Jul 29, 2026 at 12:25:05PM +0500, Alexandr Moshkov wrote:
> > 
> > On 7/28/26 20:39, Peter Xu wrote:
> > > It was overlooked that VMSTATE_VBUFFER_UINT64() won't really work with an
> > > uint64_t, as vmstate core only treats the size as 32bits, and maximum
> > > INT32_MAX (see vmstate_size()).
> > > 
> > > Considering that we do not need real 64bits for the size, stick with the 2G
> > > limit, converting the size field into 32bits.
> > > 
> > > Since we can't touch the wire protocol on migration from an old QEMU, we
> > > can't directly modify the type of size to uint32_t.  Instead, we need to
> > > introduce a temporary variable for this extremely rare issue __size_32bits
> > > to be used only for VMSTATE_VBUFFER_UINT32().  Document it and name it
> > > weird enough so people won't get confused on having two size variables.
> > > 
> > > Remove VMSTATE_VBUFFER_UINT64() altogether, because it was never going to
> > > be used right.  It means QEMU will only support 2G max for VMS_VBUFFER.
> > > 
> > > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3675
> > > Reported-by: 김승중 <seungjung0711@gmail.com>
> > > Cc: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > Cc: Fabiano Rosas <farosas@suse.de>
> > > Fixes: 3a80ff0721 ("vhost: add vmstate for inflight region with inner buffer")
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > > 
> > > PS1: I only did smoke test as I'm not fluent with vhost inflight feature.
> > > Please kindly try it out if possible. In general, migrations from older
> > > QEMU should work even after applied.  One can also treat this as partly-RFC
> > > from that.
> > 
> > It looks like inflight migration is broken:
> > 
> > qemu-system-x86_64: Missing section footer for
> > 0000:00:02.0:00.0:00.0/vhost-user-blk
> > migrate_error error=load of migration failed: Invalid argument: Section
> > footer error, section_id: 53
> > qemu-system-x86_64: load of migration failed: Invalid argument: Section
> > footer error, section_id: 53
> > 
> > As far as I understand this happen because __size_32bits not initialized on
> > source - it's never set. So vmstate_size() reads 0, and zero-lenght buffer
> > is written into migration stream.
> > The destination then allocates the correct buffer but reads 0 bytes from the
> > stream, leaving unconsumed data and causing the section footer check to
> > fail.
> > 
> > It can be fixed with adding pre_save (or pre_save_errp) to
> > vmstate_vhost_inflight_region_buffer that initialize __size_32bits from
> > size:
> > 
> > static int vhost_inflight_buffer_pre_save(void *opaque)
> > {
> >     struct vhost_inflight *inflight = opaque;
> >     /* Only used in VMSTATE_VBUFFER_UINT32() */
> >     inflight->__size_32bits = inflight->size;
> >     return 0;
> > }

Thanks for the testing and report, Alexandr.  Obviously I only kept in mind
of the cross-binary case..  I'll see if I'll respin with the fix or
something different.

> 
> At which point I ask whether open coding all this mess
> is so much better.
> 
> 
> Way I look at it, vmstate machinery had an API of storing size in u64
> that it failed to implement correctly. Why not fix it?

I explained in my reply to Fabiano:

https://lore.kernel.org/qemu-devel/amoHbVsgzkYclCt2@x1.local/

Thanks,

-- 
Peter Xu


