Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA860FD4F11
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 18:01:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w01Nm-0003YA-N7; Tue, 10 Mar 2026 14:00:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w01Ni-0003Xi-KG
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 14:00:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w01Ng-0007WM-Fv
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 14:00:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773165630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qOh/lwP4gpZdTqNhhT+bRsz3Non+rnlJtT/sA346NOo=;
 b=EHsVilP7qKhvsF+4dJ12SDSCgHjxpL5ksihCYNFrdZkWwM6x4FckjA3S3ntiQ8bFz/ox2l
 vj0QYx5Dd+QL0mIGwhifaSrQgVhFo/AZ5/VA29aaAdg/vSseozWluMjIXOIyRJX9OwMIDv
 OW11olV0+KYayYQo4RXMST7WRfNhZcE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-xcTx37J7Nnmxw3S_p31HbQ-1; Tue, 10 Mar 2026 14:00:29 -0400
X-MC-Unique: xcTx37J7Nnmxw3S_p31HbQ-1
X-Mimecast-MFC-AGG-ID: xcTx37J7Nnmxw3S_p31HbQ_1773165628
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8cd773dd409so434320285a.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 11:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773165628; x=1773770428; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qOh/lwP4gpZdTqNhhT+bRsz3Non+rnlJtT/sA346NOo=;
 b=EbPWGjjt28jBOV+0kBABjZzBUbaeV334TTViWG8mrjTd+gKrOO7cibMpcUnb+hH6IE
 6Bhh9mLwebFS7Y/JW9z55AbBjGKVM+GaFJsBdAmCSOKtAH2vJkElQ+qoQG7sHJaNPMRw
 3WDYVrP8g4jJV8+SYWz3ZKxtBXU2pXv5e/+E1q3O9P71DG7YmKLxtuosj8lWLkG6H8pU
 mcwxmuW6sKtCWPTmXDpymnEaoT4P79AwES+aa9JXwOTXuRHrcik7yKkMYGw2mcWyfJgE
 W44WrO4Nreq7/m6hJnPJt34icMNGAK19ULb5rAQpdq6x2gROi5NFPlsBwZps9QzpAtuD
 nLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773165628; x=1773770428;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qOh/lwP4gpZdTqNhhT+bRsz3Non+rnlJtT/sA346NOo=;
 b=Lk4pkZqTH8BiRBxNgAS+h/gpce+T4tub7mNaCmmnM+gYURY0b816skptSqCDqY8NZU
 ypfghvDqeqPKl8M36lGmq7hRTIBBKUeYK9pdu/VBfkGMk+0B/kZEYmniWalljtFFpBVl
 hv0yFGKxzEHa6eWHLYQJw1fOSWYtz1Ykclcb95RAsRAn6XdLCzmHo6oDPIYM5Xv89xEd
 65AWgX/kxHJBeu+SfTlupVeEcP23EE8YOGXMLqlgjcg2Nn5FXSwGBmYcaKT3iDSaf/Gq
 UDnMTSpsTMdlBUChJTzmAwaj4rtQMOJuFCnPOV9BVlT9qCz5wHg1KTmL4RVSTX9csqkU
 lOTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9KTj1uyYuPcb9YQk6xC7QrdzPSWsyJ2o7ehUdmSODekNIpCVo89ZddZ1VfR5zOYNxbUxtP3oQVtr9@nongnu.org
X-Gm-Message-State: AOJu0YyM0Ex6vz/HGSTlwo/6O0we09VTG8hAk/P+Pc2EpxE5pYHLjIlG
 vmajNMgTijDBjPdchjVhoXbZ5i2vRuL8r5J5ndNWUiL+QU7otUR+MZshuRbzbC34D+jq2pzty9k
 kk+j4i4AxW7e8OnVLtM0WWX1De2PB9lGA4s+XJKRlVyDo6Bbeeoornz/B
X-Gm-Gg: ATEYQzw05KF9Dw0F4wkJ5BXACRaWuMg/nSFJgkketLiQtqfPGrJ8HT457Oni/zszpqI
 in6Iq+WQ3qbZHalsxE0m+FwchXvy/MfdMOa5XW1uSaOH5aM+TAq42b11wlBZisluj9c01fROTd6
 L3asLLyyr2fCuEY6PEz8lamlshWlZRRj7A+wJNZwyF5McAN0bV6etmzGTA8a+xVRW2M3EFxhFs9
 K31eCkcJ9j3SndC4/HUllb/Pqk6bbjCzsT6kNO1+N02IAdXC9yvI/h5I/lxDXuD28mMEfHl41zD
 yUH0CjNdYpISiGRXfO48rzo3LJnMoaIBw2eAeG/LlvK4FXs8T9+AmQ2IUrpiMimyqAymNlVwaH8
 ruXEg7OyYwv20jw==
X-Received: by 2002:a05:620a:8782:b0:8cd:7c98:87c2 with SMTP id
 af79cd13be357-8cd7c988bc0mr897337085a.60.1773165628159; 
 Tue, 10 Mar 2026 11:00:28 -0700 (PDT)
X-Received: by 2002:a05:620a:8782:b0:8cd:7c98:87c2 with SMTP id
 af79cd13be357-8cd7c988bc0mr897330385a.60.1773165627544; 
 Tue, 10 Mar 2026 11:00:27 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cda136f7f0sm2005085a.44.2026.03.10.11.00.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 11:00:26 -0700 (PDT)
Date: Tue, 10 Mar 2026 14:00:23 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alexandr Moshkov <dtalexundeer@yandex-team.ru>, qemu-devel@nongnu.org,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2] vmstate: fix subsection load name check
Message-ID: <abBcN2B4QNBT_Oh9@x1.local>
References: <20260302070626.613396-1-dtalexundeer@yandex-team.ru>
 <87y0k5136i.fsf@suse.de>
 <714e4329-6001-4c77-b004-ed7beb11c154@yandex-team.ru>
 <e81360d5-cab4-47a4-840b-7d948b51a5c0@yandex-team.ru>
 <CAFEAcA-m+CZPUchGsh6QU4gm1dO-FP0m1w5gu6sn56wUXBbRAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-m+CZPUchGsh6QU4gm1dO-FP0m1w5gu6sn56wUXBbRAQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Mar 10, 2026 at 01:39:04PM +0000, Peter Maydell wrote:
> On Tue, 10 Mar 2026 at 13:28, Alexandr Moshkov
> <dtalexundeer@yandex-team.ru> wrote:
> > Hi, this breaks migration for s390x and ppc64:
> >
> > qemu-system-s390x: Missing section footer for qemu-s390-flic
> >
> > Thanks for reply! It happens because "qemu-s390-flic" vmsd has "qemu-s390-flic-full" subsection. I'm not sure if we can change the names of the existing subsections. Peter, what do you think?
> >
> > It seems to be a bigger problem that the migration framework does not document the names for subsections in any way. At the same time, the code implies that at least the names should be a substring with its parent. There is even such a code comment `subsection name has to be "section_name/a"`, that seems to imply the presence of /.
> >
> > Also I tried to put together a list of devices whose separator in subsections is not /:
> 
> > or-irq
> 
> This one and probably some of the others are my mistake, I think.
> I think this is because:
>  * the migration code imposes a constraint on the subsection names
>  * the migration documentation does not mention this constraint
>  * the migration code does not effectively enforce this constraint
>    (e.g. by asserting when the vmstate with a bad name is registered)
> 
> My assumption when writing that code was very likely that the
> name of the subsection didn't have to have any relation to
> the name of its parent subsection (after all, the migration
> code knows it is a subsection, so if it needed to have the
> name on the wire be "parentname/subsectionname" it could construct
> that itself), and since it all just worked I never noticed the
> mistake...

Indeed, we can do better on the 2nd/3rd bullets.. so we should document it
in struct VMStateDescription definition, and enforce it when registering
new VMSDs.

One thing to double check with Alexandr on this one:

> They using `_`, `-` or `.` as separator

Does it mean we also can't simply whitelist all these characters (including
"/"), because it won't always work?

For example in your case, it's "virtio-blk" being the parent VMSD, "virtio"
being the child VMSD, followed with a subsection belongs to virtio-blk.
We want to make that subsection be recognizable as virtio-blk's.

Then if we treat "-" also to be a separator, then "virtio" will still
mis-recognize virtio-blk's as its own (because its name is "virtio-blk/..."
hence it also satisfies the "virtio" check)?

Thanks,

-- 
Peter Xu


