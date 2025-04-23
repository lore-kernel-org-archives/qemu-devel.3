Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA1FFC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 16:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7dGw-0002Xy-FP; Wed, 23 Apr 2025 12:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1u7dGs-0002WB-Kk
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 12:48:27 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1u7dGq-0005R7-NI
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 12:48:26 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-30beedb99c9so1023561fa.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 09:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745426902; x=1746031702; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uQS+oR9s8FG/Q5RPJOqhZ2ex/ZXUmEGeaT5QJ6emN/U=;
 b=Luqps2+Xs9AFlqFWikS9XVUmTolTsAroY6kOCL950leiNiz4wN/lxJubtIypKGKQTy
 zjC9dB1nBArpZeudUTaYa+90sMKWi1zKIrF2MvpYTTRfDu55BqHJ368UzO/Rffwx0nxD
 YySnjT5EZGKEbNE6bvisrp4e+0iiI8hmGurMGfL/5cj3PnU1EGM7HodiiyNho83aypmU
 uIf/AfETOrXbgRZV4Ojzoz7mm4vodzhsgjK3QYVK6XVkYVyIauglowLVtD/A3ymTbrWt
 i8ruOUy6d864maWqLrpcjgGnkIOkJkws0H/yXwW+HKqQ23nTP6+hSOoErM7inYMlouDx
 mHSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745426902; x=1746031702;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uQS+oR9s8FG/Q5RPJOqhZ2ex/ZXUmEGeaT5QJ6emN/U=;
 b=FW1kqLCcSj5iknsbcTQQ/VMBj9etygDL0Jf09pbk+Gfi8YjkdkQZKOVntTl8Ax9k8F
 31tBoIB+hpdDVLKgdrfbL29Pl1IwlWywsjN5yvgZsTeuw1Waom88EUJ3YrLBKfsb5EY8
 VKwYIjts1hLqjY/VaDhjedKLfrcOmXtclaGqiOW+veKdwOPypXF2To0bC0NRgjtM5c9Q
 o5eoPdXrhbtZxhIGm3QbTzjSUKJXTsTygiGrJxcFW3DNpPiw9fjoeWmZoFtjf/qERjaE
 EOhyDpYda5XGtSMHYUtvYyD4iBFUO2sBI+vGYLG1f72E307rCRiHcLP+cTMHOAiGeLf8
 nJlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRyWvTQoJQzFjdwb3945wNStp96mMljids0z8j7TsrltaqwZDb4pCGGby23KcrOG63kNtNoffE5mDw@nongnu.org
X-Gm-Message-State: AOJu0Yy5r1HGVpqc1w+9wM3mj2u3o2Wn79EP/ies36oigjjt+JHKUCv+
 /ghy25ynkZR4Bk6i2WfiU5YKWwFVOdrWAWGIg/1sv4PaNpWDjJNz
X-Gm-Gg: ASbGncsXR1PsLtkHRVIsR/WWN8/ruqnUwUra3BZ5Cmam53XZPS6hFKryYrh+eDwo1+x
 cxbtZqYp3Um6uq1hJN7+nF2V/qH6+QoIIOYbn0nlp7L/JFF3clfkvdT5vYY2Y8LF+4KB9vUqZjT
 0qcck//kRjcgYD26Tucu/x2VXqif3K6ZtNGRHor+pUojmwHu2SbO5gZwgMdSDaNy6w5qSb3mimy
 /9pB/MqGUwcpDoL3eK8cO/zuxZHIql7q58jGF0aptrs3JPV01E4/s0AFP6OgZMKuKJSJzjW2SAC
 x51xmczyP+6HxTstxCEj+fPBGuY+QG2t6gTnD4PS6NYs8iwyxxHjRkwBHsm9NuyIQwFschI7piX
 4gW+jPWt4U7Rv
X-Google-Smtp-Source: AGHT+IH7O1iiDddCO89yvZWH7Be7H2ryLRucKswHDEdPt9gWFhhsHNxHjpkzMogRjLrNlf6lejAH5w==
X-Received: by 2002:a2e:ab19:0:b0:30b:d5ed:55c7 with SMTP id
 38308e7fff4ca-3109057628emr72700781fa.36.1745426901514; 
 Wed, 23 Apr 2025 09:48:21 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3109075f28dsm19415671fa.6.2025.04.23.09.48.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 09:48:20 -0700 (PDT)
Date: Wed, 23 Apr 2025 18:48:19 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: Aleksandr Partanen <alex.pentagrid@gmail.com>, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org, Paul Durrant <paul@xen.org>,
 Anthony PERARD <anthony@xenproject.org>
Subject: Re: [PATCH] xen: mapcache: Fix finding matching entry
Message-ID: <aAkZ04aPs7XGBiOM@zapote>
References: <20250410144604.214977-1-alex.pentagrid@gmail.com>
 <alpine.DEB.2.22.394.2504181638300.785180@ubuntu-linux-20-04-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2504181638300.785180@ubuntu-linux-20-04-desktop>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Apr 18, 2025 at 04:39:04PM -0700, Stefano Stabellini wrote:
> On Thu, 10 Apr 2025, Aleksandr Partanen wrote:
> > If we have request without lock and hit unlocked or invalid
> > entry during the search, we remap it immediately,
> > even if we have matching entry in next entries in bucket.
> > This leads to duplication of mappings of the same size,
> > and to possibility of selecting the wrong element
> > during invalidation and underflow it's entry->lock counter
> > 
> > Signed-off-by: Aleksandr Partanen <alex.pentagrid@gmail.com>
> 
> Hi Aleksandr, thanks for the patch, it looks correct to me.
> 
> Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
> 
> 
> Edgar, would you be able to give it a look as well to make sure?


Looks good to me too, thanks!

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>




> 
> 
> > ---
> >  hw/xen/xen-mapcache.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
> > index 698b5c53ed..2c8f861fdb 100644
> > --- a/hw/xen/xen-mapcache.c
> > +++ b/hw/xen/xen-mapcache.c
> > @@ -376,12 +376,12 @@ tryagain:
> >  
> >      entry = &mc->entry[address_index % mc->nr_buckets];
> >  
> > -    while (entry && (lock || entry->lock) && entry->vaddr_base &&
> > -            (entry->paddr_index != address_index || entry->size != cache_size ||
> > +    while (entry && (!entry->vaddr_base ||
> > +            entry->paddr_index != address_index || entry->size != cache_size ||
> >               !test_bits(address_offset >> XC_PAGE_SHIFT,
> >                   test_bit_size >> XC_PAGE_SHIFT,
> >                   entry->valid_mapping))) {
> > -        if (!free_entry && !entry->lock) {
> > +        if (!free_entry && (!entry->lock || !entry->vaddr_base)) {
> >              free_entry = entry;
> >              free_pentry = pentry;
> >          }
> > -- 
> > 2.39.5
> > 

