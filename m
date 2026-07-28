Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7352C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 14:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woist-0005Jz-VL; Tue, 28 Jul 2026 10:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1woiss-0005JJ-Nw
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 10:34:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1woisq-0008M9-1V
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 10:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785249255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qArjsjIQU1lq2Ykf7SAMUFMtBbSfJkNEpAzhQotRVLg=;
 b=ebWzZzWjP/c61Q+Pk0KP+36idoBBBjxcizPGGC7TvJi9Ggooh8T8KTQTIsFVZdZOpa4BaO
 A32wmEHgC4Y12dhLI3dpDHHYxuM8j7rr21ONaMyGmh3m8CDuSc9qlA98YyVaWH86Wc+4ed
 OTiG6pvyw8mzgIwwiYtATuMaHdNOFqo=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-S0v9-G4SOraus9uaz4ONmQ-1; Tue, 28 Jul 2026 10:34:13 -0400
X-MC-Unique: S0v9-G4SOraus9uaz4ONmQ-1
X-Mimecast-MFC-AGG-ID: S0v9-G4SOraus9uaz4ONmQ_1785249252
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-97715f83b77so185211241.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 07:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785249252; x=1785854052; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qArjsjIQU1lq2Ykf7SAMUFMtBbSfJkNEpAzhQotRVLg=;
 b=aOtMOz8QdOV31mvxbEYDFPj72PsscmB8eYPS5AcKojRygTPbZAGq23ZwHllQcQgHU6
 YDp3amF78qpnuvXa+LWP+a5HbC6qPd3RLgmLk6W5IBxUMH0GlQHwzE+nbJ7h5b+RM4C7
 pVPn87AWWhHOM7uGa4WpO8AccC+4w5WEoxgS0aQ4lVR2SWwuVbWr1jtRhlqQ8incI+N8
 eZW5+7DWUhr+j/oJ1U9q+9ozUaUoAvbIoV/QDFII37GI+CvjtOC2x1G3FrRAHbNAx3kE
 1tn/Qk57hsuxTFa4Ss8OmBPAQLQ4VwBPB1S+XLh3a5WtkvWW8wkZq3z1ExVVt40yuaBe
 UwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785249252; x=1785854052;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qArjsjIQU1lq2Ykf7SAMUFMtBbSfJkNEpAzhQotRVLg=;
 b=ffevY63Zzhjqi98j98JV5ujk6LT/Rw0ztrC4y2WZCx51d1NTii3wJYKTUTQK97rt2k
 W6Ys25oKTcRva0u7QVe6z/WfnAHedTao8+5uyHAk9B0YL53hKZzNtUe14AMGPFdGZXa4
 CYxrEnRnyhq0p9gLhGoq40R/iKYcqWiB7eEP3j8HLyERwshp51BHanxnu61f5RLnqxjS
 qAWQGkHwmsPNAAD0lqLQzFmwV201JBj/ETUO2gvuok1EdrpySIwxMopcAzDBPgmFkh5W
 hkFweIDDnP4yXcjiR06WmRQJD74OXzGfdUEVuVpYBdCMleiyXXFGEpsNZZeChfma7lIM
 sSSQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpO88kogbs+94QPSyHTmM0juISaS5D/Jii74RcOHBqGro3s06BVTh7jEoU4K1OYzmyRcNVsi4r6hoe8@nongnu.org
X-Gm-Message-State: AOJu0YxtweI3VzfMvWAY4yvpO5+wqEl/gtiE75ZFdHeSmjKvjfW6E+YP
 JY7agoyobSr904SXlAeuDojRgxIPW92uiZwMp5uXeUlSGEjRZBzGyOadBvoZ+VYqAdjOJI9jIwH
 CI4xJ+y9zhYVTzAKncJVCkU0MB71krdV/pZLzkvNzl17UcmV17aIFVotY
X-Gm-Gg: AR+sD11G9OdwupR/gT62rwZw81LMkBprQDhVyV2pm6qvqeUh8FKYyQ3wzxc8XwQSefS
 ZmE4gRf935zNBZKh8LXSEWMrs9a1EEOfGY/8uXrwHMn5obbF/56HUClomsbPaF8T8ZU56qDsGOn
 MbUy8nJu0p3nhhBRfQaKwnpDSjzu+mJIkwihjCZG37Sskx3Ml1ECxhdegRuhFT8nde8niLFdIrp
 GrOyDE8Bqljvnzt2bRtraiFwbZ7ppkkWMST57ncw2MYpnkXxmp2x6z07oM3E7/6PJYGstsG9ab1
 IU9UaXEncXf0Uf8+VIX5/+3tp6K8V9v6WvL+qys5BNF06Imq5qMEnbxVCCoiSYuwl7/KHjqp0e9
 FKKQUrFFCNUY6BGbblTRqfaZ/7Vc/Hd1xU8zn0Cm55ZQ4XTDtVRF21cTNNFw=
X-Received: by 2002:a05:6102:a50:b0:738:d6c:7104 with SMTP id
 ada2fe7eead31-7549c7802dbmr1285355137.0.1785249252261; 
 Tue, 28 Jul 2026 07:34:12 -0700 (PDT)
X-Received: by 2002:a05:6102:a50:b0:738:d6c:7104 with SMTP id
 ada2fe7eead31-7549c7802dbmr1285326137.0.1785249251641; 
 Tue, 28 Jul 2026 07:34:11 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-97774c8f725sm7526928241.5.2026.07.28.07.34.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 07:34:10 -0700 (PDT)
Date: Tue, 28 Jul 2026 10:34:08 -0400
From: Peter Xu <peterx@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, mst@redhat.com,
 richard.henderson@linaro.org, alex@shazbot.org, berrange@redhat.com,
 philmd@mailo.com, david@kernel.org, clg@redhat.com,
 pbonzini@redhat.com, phrdina@redhat.com, jugraham@redhat.com,
 liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn, shan.gavin@gmail.com
Subject: Re: [PATCH v4 2/3] system/memory: Use qemu_ram_move() for directly
 accessible regions
Message-ID: <ami94CmeBNRKy_es@x1.local>
References: <20260727032649.145381-1-gshan@redhat.com>
 <20260727032649.145381-3-gshan@redhat.com>
 <CAFEAcA9_tDRAd97z4UtNhFPK+fMbq37LJhWTSmD5cueo61hvvg@mail.gmail.com>
 <0a384d67-fc56-4a21-9d0e-25f218a45228@redhat.com>
 <CAFEAcA9HbTSj9cJfv8o=jYSuPhScr-RVKWCos4kpUJ+T1S6g5Q@mail.gmail.com>
 <13333e56-3725-4550-849c-9035f6925213@oss.qualcomm.com>
 <CAFEAcA9X7SNUvQpwXA2_xReUERB-eBETty3g32-PD=MVk536sg@mail.gmail.com>
 <2322668a-20a3-4a6b-8d7f-c04ddfef84f1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2322668a-20a3-4a6b-8d7f-c04ddfef84f1@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jul 28, 2026 at 08:23:48PM +1000, Gavin Shan wrote:
> On 7/28/26 7:35 PM, Peter Maydell wrote:
> > On Tue, 28 Jul 2026 at 10:22, Philippe Mathieu-Daudé
> > <philmd@oss.qualcomm.com> wrote:
> > > 
> > > On 28/7/26 11:01, Peter Maydell wrote:
> > > > On Tue, 28 Jul 2026 at 04:01, Gavin Shan <gshan@redhat.com> wrote:
> > > > > 
> > > > > On 7/27/26 10:51 PM, Peter Maydell wrote:
> > 
> > 
> > > > > > > +    test = (uintptr_t)src | (uintptr_t)dst | n;
> > > > > > > +    len = test & -test;
> > > > > > 
> > > > > > What is this doing? I am not a fan of clever bit twiddling
> > > > > > that isn't commented to explain itself. Readers of the code
> > > > > > shouldn't have to go off and search for an explanation of what
> > > > > > is going on.
> > > > > > 
> > > > > 
> > > > > The following comments will be added for (v5).
> > > > > 
> > > > >        /*
> > > > >         * Maximal length of aligned access that are determined by @src,
> > > > >         * @dst and @n
> > > > >         */
> > > > 
> > > > What I mean is more that it ought to say why "x & -x"
> > > > achieves that goal.
> > > 
> > > Hmm isn't "x & -x" restricted to power of 2? Here we have no garanty
> > > @test is, because we have no garanty @n is. Ah, this is catched by
> > > the 'len != n' check and returns after calling memmove(). Indeed not
> > > very clear notation. Again:
> > > 
> > >     ...
> > > 
> > >     /* Overlapping buffers, unaligned or oversized access */
> > >     if (!QEMU_IS_ALIGNED((uintptr_t)src | (uintptr_t)dst, n)) {
> > >         memmove(dst, src, n);
> > >         return;
> > >     }
> > > 
> > >     switch (n) {
> > >     ...
> > 
> > I'm not inherently against the bit twiddling (QEMU_IS_ALIGNED
> > on a variable length will do a division, maybe we care?);
> > I just want that if we do use a bit-twiddling trick that we
> > explain why it does the thing we want it to do.

I think the bit ops should be more efficient. I plan to queue v5 with a
fixup, v5 here:

https://lore.kernel.org/qemu-devel/20260728031731.286666-1-gshan@redhat.com/

Fixup:

diff --git a/system/physmem.c b/system/physmem.c
index fbe7df2391..2f37cbeb07 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3162,13 +3162,18 @@ void qemu_ram_move(void *dst, const void *src, size_t n)
 {
     uintptr_t test, len;

-    if (src == dst || n == 0) {
+    if (n == 0) {
         return;
     }

     /*
-     * Maximal length of aligned access that are determined by @src,
-     * @dst and @n
+     * Calculate "the lowest set bit" over @src, @dst and @n, result put
+     * into @len (which guarantees a power-of-two).  With that and the
+     * later check (len!=n), it makes sure that we will only do the atomic
+     * ops when:
+     *
+     * (1) @n is a power-of-two
+     * (2) @src and @dst addresses are both aligned to @n
      */
     test = (uintptr_t)src | (uintptr_t)dst | n;
     len = test & -test;

Does it look ok to all of you?

Thanks,

-- 
Peter Xu


