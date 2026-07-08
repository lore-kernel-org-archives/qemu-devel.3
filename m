Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AEBFC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 15:02:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whTnJ-0000Tt-3F; Wed, 08 Jul 2026 11:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1whTnG-0000MU-De
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 11:02:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1whTnD-0003hR-Gh
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 11:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783522949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sm67NC5o62t37KkceLNb2tcO/fP+rNojU2StTy8VQS8=;
 b=SooJ9S1ZAoG/9yfNBAhY9gN8sZ7umyNdCShmf8PZat+ZuG18+XF6TUfJxNabB+zzWGLtkU
 KdII6KjyOx1PDW5PV0zkvjSZWmOS13ggVwqTYJd+b5b+QaWttxFcYWXpr38ykG8QzV8BYM
 kzMngmvgc4cMiZCHlNqiElLdTKWb54I=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-mZSN8vhqOcOfYE4R6tnXaw-1; Wed, 08 Jul 2026 11:02:27 -0400
X-MC-Unique: mZSN8vhqOcOfYE4R6tnXaw-1
X-Mimecast-MFC-AGG-ID: mZSN8vhqOcOfYE4R6tnXaw_1783522947
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e9a2b95b5so170959685a.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 08:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783522947; x=1784127747; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sm67NC5o62t37KkceLNb2tcO/fP+rNojU2StTy8VQS8=;
 b=Cjtbbbf9X7XObGmkr1Dws25ME8AM0vNVL7pXiOSlHLr35WhtizUn4TjdtM1wkn7pS4
 zUfFY9hgp2vf0qRpCXz30G/ufka0dPtkYI+kSqJqw48i9Kqm8bBojBeiW9b7KLlzM0mW
 vy52w73cQOl/xcxKRNLWbxYD8OliVe1dYBctFBSoP/ZfQGZxu8yFqXq1xGsYQdeirLJh
 +WQkSbojZSu3bFjsWuIGOWy8NKm5t9oSclNrfa4WTu7IU7AXWwd0pJxLuy8UjxE8WRvG
 n4H14oSzEBFjXDbpxJePQlaxuXoJLLxkQmHT/D4bnc+yX9trOnmSSN+SAxgNNloYe75Z
 Rj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783522947; x=1784127747;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sm67NC5o62t37KkceLNb2tcO/fP+rNojU2StTy8VQS8=;
 b=GtNKViHRadI8fWq1pVc2Zko0E4gXlvSIQccz5wjp+FAEsIo8vXd7wuVMHMA75m58f8
 I6WrVlFHLicpdKqBU5xAxx3fXeQdwt2JQecH+lu+KunwZYbCWHv4Xf4qmjbo9MQqyHJr
 BlUUafrPUjBh3wHCe5ujC0vmMQeRUii64hlSFaMX0nChb+pwsvFjDQrgO9/1HLRMVi/a
 G6AsJTc+wxRAxRUaoZC2vz2sB/CtW6JGrt2f/p48srtVGKlfgIKLyLmx+mF0PxyrADNO
 e8Pmo6g2B4c9UQmmP+LpDcDz5eOPb8ZNLs99NamJbDVZEc815un23L1Q3m/SDP2FN/9M
 10ew==
X-Gm-Message-State: AOJu0Yw1IVcbB/OPfbvSJpZ6+JbCHKu6V9uHdsLjeqLJS0ERkT5kXcxu
 p5HAlm+v7Z16vROrons4j9b1yQblbGB/cLltJSuqJZ2GsVVcAR8ecDWP4RfSvIEbPeiHw6HBWId
 RcdYU8O28T3Zjqp8EhTdb2Z0MRTSGP1ifNwqzz8Fd+AikO7RKZERmVO3b
X-Gm-Gg: AfdE7cnplCx2g3At5SKxhABAEz8MTaAeBeu/3cckoZ6QMorPbYzw6xl0p2iNPO9H83q
 GzEVfOOh0Y0dSurK0EXnfk2KFqTusluCXonh2oJD9+8NhM9VnnUUT77HFCpqn1yi4njri1teED6
 CXlZXIlFAFzY5baxVW5xXb9eGKaRnpuQnM5lJWFQ+6WCdBqgxQE1LaLRKY2CbnJTkTlPJaX/YHc
 fhKOP+EpS+7ysgLVB4O1neh6GYLjsYZB+Kaxb2CEApgZXNOMCSPASQe4fCuwY+1T2rh4uvWBU4M
 zmwCDusqm6TKtWNfdsfSQaFG+U3kyxxvCbk9WlQR/pYT4926dV1Jx+UFfWYZ4kus88yfH8xYD4O
 ahbllROiRaDXFMaxLe9Yb243g642OF3RIFJ4Ge2Yj837AH5Wj1ZJUEPOXqB7KkgIxk62qKA==
X-Received: by 2002:a05:620a:1d05:b0:92e:6a8d:38ba with SMTP id
 af79cd13be357-92ecf6c7189mr246278585a.56.1783522946742; 
 Wed, 08 Jul 2026 08:02:26 -0700 (PDT)
X-Received: by 2002:a05:620a:1d05:b0:92e:6a8d:38ba with SMTP id
 af79cd13be357-92ecf6c7189mr246271885a.56.1783522945896; 
 Wed, 08 Jul 2026 08:02:25 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92e90c923c4sm1465921985a.24.2026.07.08.08.02.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 08:02:24 -0700 (PDT)
Date: Wed, 8 Jul 2026 11:02:17 -0400
From: Peter Xu <peterx@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, pbonzini@redhat.com,
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com
Subject: Re: [RFC PATCH v2 6/7] migration: add support for fault thread to
 load pages from disk
Message-ID: <ak5meTFBIDCAyYF8@x1.local>
References: <20260630081940.611092-1-aadeshveer07@gmail.com>
 <20260630081940.611092-7-aadeshveer07@gmail.com>
 <akwRqYY3vfzafZ_X@x1.local>
 <CA++cPvJ2N_oke1iMP083MDKxeV-YoKDZuWFtAfwoYKwoR65ocA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA++cPvJ2N_oke1iMP083MDKxeV-YoKDZuWFtAfwoYKwoR65ocA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jul 08, 2026 at 08:01:34PM +0530, Aadeshveer Singh wrote:
> > > +static bool postcopy_mapped_ram_load_page(MigrationIncomingState *mis,
> > > +                                          RAMBlock *rb, ram_addr_t rb_offset,
> > > +                                          uint64_t haddr, int channel,
> > > +                                          Error **errp)
> > > +{
> > > +    void *place_source = mis->postcopy_tmp_pages[channel].tmp_huge_page;
> > > +    size_t page;
> > > +    size_t read;
> > > +
> > > +    page = rb_offset / qemu_ram_pagesize(rb);
> >
> > Yes, here it is correct to use qemu_ram_pagesize().
> >
> > > +
> > > +    if (bitmap_test_and_clear_atomic(rb->pending_bmap, page, 1)) {
> > > +        if (test_bit(page, rb->file_bmap)) {
> >
> > We'll need to be careful here when you add huge page support, because
> > file_bmap so far is guest-psize based.  This line will start to break for
> > huge pages, I am not sure if this is the bug you hit when developing huge
> > page support, maybe yes?
> >
> > Not sure how you resolved it there if this is the case, but one idea is
> > when postcopy-ram is enabled, you can convert the per-guest-psize bitmap
> > into per-host-psize bitmap (when any bit set within the huge page range,
> > set the bit in the new bitmap), then here it will be correct.
> >
> 
> For hugepages, I replaced this test_bit() with a ranged check. I felt
> changing the semantics of file_bmap for when postcopy-ram is enabled

When support huge pages, in previous patch if you will already switch to
using ramblock page size for pending_bmap then I think we should indeed be
good here.

With that, actually file_bmap to be guest-psize is definitely
better.. please ignore my above suggestion on bitmap conversions.  We just
need to loop over all the bits of the huge page, when the bit is clear,
instead of UFFDIO_ZEROPAGE, we should just do memset(0) for 4k (the tmp
page may have been non-zero prefilled).

I'll wait to see the new version when huge page support is there.

Thanks,

-- 
Peter Xu


