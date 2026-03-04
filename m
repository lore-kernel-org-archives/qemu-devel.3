Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40814EFCE4B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 21:54:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxuA3-0001wj-MZ; Wed, 04 Mar 2026 16:53:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxu9z-0001wH-QA
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 16:53:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxu9w-00017F-J7
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 16:53:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772661213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7s4K94cv2LV330Z2NbpFVpmuFH3/JxkTPb+z10ngAmQ=;
 b=ZLvaqXYoupS0+CvS4o2SQFFj0i8JWnnQx5e3DemJy8ERAyx9kDNRrmFXh/FCtpFtgZu2W/
 0+39nrSCwQU7OJiBKCgbv8HLAG65PSLJ5CuOGFYy8MT11Ft8y3IKwvGVAJ2MMq6hiqjAvQ
 GcruIYJxqswlUHh57rWX8E30iEnA7No=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-yUpDlcVsOQeMy0o8urqDiQ-1; Wed, 04 Mar 2026 16:53:31 -0500
X-MC-Unique: yUpDlcVsOQeMy0o8urqDiQ-1
X-Mimecast-MFC-AGG-ID: yUpDlcVsOQeMy0o8urqDiQ_1772661211
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8c70d16d5a9so4178141485a.3
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 13:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772661211; x=1773266011; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7s4K94cv2LV330Z2NbpFVpmuFH3/JxkTPb+z10ngAmQ=;
 b=D/quCWwBylLj9wXrkT/jLYf0vzLQo/dXuxmpyCBCrkjHoyqZtKC1l8nI8zVab0rwHN
 uG5WIfwoWI4D/pJh8FwcWs5VRy7TzisT+Ol/l8PeoR0u2QG4oMchtmSwOXfrkCnkPlok
 fp9v9BU5aygf2bfTWMfIsJQY0kSFv2EfAKE5LH+DIjNC0E1abgMm56WIwkyV0RNzcz0P
 3noQrKaYZxjuNSx7ifc7xWry2qZLaL8Ox3NU7/Ibd9DzVZ0k6Wr68NXcjA9adR9czAoJ
 T1kt5sFTDWIIp3AikBlkdLTfSjQSEPG6cZa4Mtj3rSEKbFqJ29ISof5KoXXLwlbuwcXK
 Q7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772661211; x=1773266011;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7s4K94cv2LV330Z2NbpFVpmuFH3/JxkTPb+z10ngAmQ=;
 b=uvOF+1g18Q1rFwEmaiHG0RzMN4SrH2KwjY5ql/ALu+O9mY1/RuC5fO8gVuvgWkqMVY
 QWlxbh4nymct1r2p6UFxMKbT/hexi1OgPHGJB+zAtw3D13KdJg+L/VBCInBxJBDvHzWP
 xzvs9yQ+4Rx5RiTUC2XkhQvuNmS8RmHOz3ily+mUwhhQj+CvShXn9EatZFyrWqNbFNGr
 l/MEaeLdwLWgZxp1JAe1zxNzm4tw6vAsUJezvY6UCCy/jWTc5tebv/OP2H1OqociKBR6
 RFs1q4eBvh1HAwqY8aKCShDOV4gMyL5YHPyhtq1SZFWVnxNkZl7/yXdfHWHWgw9UQ5wW
 PO3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3oKmUphna/WVJA2JF78oByZWemMy9QfUP2VZl+acko70vdLTQPwMCxt+ygfNXv5eb1bQqUX4gA/CQ@nongnu.org
X-Gm-Message-State: AOJu0YzEeI5QThTkjaRNwwi2fw28kt1FUeyMgdVJI2bvBE+lAt56hTt8
 yiPnidnuPEAeeVOu8bWP1RfBPZuJG0u8/qsrvtvwY5p5K3s4ESWqI6wl8eTGJTMPGv9I3G1bMb8
 BBCYeUyKDxsOuhFTErMpRd342KSoaBEUHBsLlLvzpp15LlR4Cw8v9RGIL
X-Gm-Gg: ATEYQzxyJlb7pMCe8Ls7AyZ+bEVRmYEZkrcyXT3e+fgSe0+FXh905sY20tqjfqtsPnW
 56WvYwUmJ0tCcepLQDxwbo062qyoLFhOeeLMfugb1WTUbX53mum1jORbRYP7FgIHbB51dLJKuAR
 afPP1/Wt8CUOO9RgjNZ3AuBDQCP4Gob8r6uSej2Qqn4o4NxwAjwXk9C86QaYPTblci64X3bW0Mw
 NcAj03fr0r6098IH+rmzzwLlo80R6wqg+4hpRaIi0UD5OIIL9aJL/aVfJnLDi1zD+qtuXLISFaZ
 Krk/7gMXSexRHGdKyre5JGihSSqTXhd4rIDJiPII0SSwc8xt4ic6Z5JEk1A7tkw/2PWrqV2Kauu
 Oi2aU+YQtb/3z5QW+mzAHLSNHq1kjkarkLVrduVR/IYpcQDfJBGH5wqWg+dpXarj4yrU125TcFy
 UWZdCWHg==
X-Received: by 2002:a05:620a:1990:b0:8c7:eb5:8528 with SMTP id
 af79cd13be357-8cd5aec67edmr429161185a.1.1772661210962; 
 Wed, 04 Mar 2026 13:53:30 -0800 (PST)
X-Received: by 2002:a05:620a:1990:b0:8c7:eb5:8528 with SMTP id
 af79cd13be357-8cd5aec67edmr429158385a.1.1772661210444; 
 Wed, 04 Mar 2026 13:53:30 -0800 (PST)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-149.dsl.bell.ca. [174.91.117.149])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-899f8ad5b8asm99266496d6.0.2026.03.04.13.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 13:53:29 -0800 (PST)
Date: Wed, 4 Mar 2026 16:53:28 -0500
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: farosas@suse.de, "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, alifm@linux.ibm.com,
 "open list:virtio-ccw" <qemu-s390x@nongnu.org>
Subject: Re: [PATCH v2 16/16] migration/vmstate-types: move to new migration
 APIs
Message-ID: <aaip2CvQicudpdOC@x1.local>
References: <20260220210214.800050-1-vsementsov@yandex-team.ru>
 <20260220210214.800050-17-vsementsov@yandex-team.ru>
 <aacS1YUD0xesMufw@x1.local>
 <842c669b-21f0-4a17-bf4f-f2723f0e5466@yandex-team.ru>
 <aaiGCalvQNX3WQxl@x1.local>
 <23c33857-65a8-4f4b-b933-f7e2e86f7ab2@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <23c33857-65a8-4f4b-b933-f7e2e86f7ab2@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
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

On Wed, Mar 04, 2026 at 11:06:01PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> [add s390 channel maintainers]
> 
> On 04.03.26 22:20, Peter Xu wrote:
> > On Wed, Mar 04, 2026 at 10:15:01PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > The only problem is that we don't have error_append() function)
> > 
> > I definitely wanted to type error_prepend() when replying... :(
> > 
> > I think it might be better when putting upfront / prepend, say, the
> > original error should look like this, which is weird to me:
> > 
> >    "XXX != YYY NAME"
> > 
> > (maybe even no space???)
> > 
> > With append (when doing that, we may also want to add a comma and some "0x"
> > prefix?), it can be:
> > 
> >    "NAME: XXX != YYY"
> > 
> 
> 
> Hmm. I'm now trying to find, where this .err_hint is set to not-NULL.. Don't see...
> 
> O, I see them:
> 
> in hw/s390x/css.c

Ouch.. This is the 2nd time in exactly the same day I saw a feature
introduced into migration core with an use case only in s390's css.c file,
which only works for very limited use case but likely not usable for the
rest...  The other one is VMS_NULLPTR_MARKER..

https://lore.kernel.org/all/aahgfLaybfjOpsX1@x1.local/#t

> 
> const char err_hint_devno[] = "Devno mismatch, tried to load wrong section!"
>     " Likely reason: some sequences of plug and unplug  can break"
>     " migration for machine versions prior to  2.7 (known design flaw).";
> 
> const VMStateDescription vmstate_subch_dev = {
>     .name = "s390_subch_dev",
>     .version_id = 1,
>     .minimum_version_id = 1,
>     .post_load = subch_dev_post_load,
>     .pre_save = subch_dev_pre_save,
>     .fields = (const VMStateField[]) {
>         VMSTATE_UINT8_EQUAL(cssid, SubchDev, "Bug!"),   <<<<<<<<<
>         VMSTATE_UINT8_EQUAL(ssid, SubchDev, "Bug!"),    <<<<<<<<<
>         VMSTATE_UINT16(migrated_schid, SubchDev),
>         VMSTATE_UINT16_EQUAL(devno, SubchDev, err_hint_devno),   <<<<<<<<
> 
> 
> 
> "Bug" hints are obviously useless.
> 
> About err_hint_devno.. Doesn't seem a good reason to have this .err_hint
> field and the whole logic, including extra parameter to several vmstate
> macros through the whole code base. And at least mention about 2.7 looks
> not relevant today.
> 
> I'd replace definition of err_hint_devno by a comment, and drop the whole
> .err_hint feature.
> 
> What do you think?

Yes, I'd agree.

-- 
Peter Xu


