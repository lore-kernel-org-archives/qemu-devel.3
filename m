Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B412FC369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 20:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAaQ0-0002pH-Mp; Thu, 01 May 2025 16:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uAaPz-0002nW-Aw
 for qemu-devel@nongnu.org; Thu, 01 May 2025 16:22:03 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uAaPx-0007wC-GF
 for qemu-devel@nongnu.org; Thu, 01 May 2025 16:22:03 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2295d78b45cso19046905ad.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 13:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746130919; x=1746735719; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=F7bWiW4bRsnks3rl9OHy6axsrNrN4JteSqAxTGYEvLA=;
 b=TUOTxlvDqcQ1HhhiyuplAuPs9E1eKaa6M3nRxGZ3iXOH5n/sIvvEtDmdTJB7Fdvh0H
 zaQEfydwE2oTTMKXjaXSsEf7pIyveTRQ2crUzjJMWpSzvZzQYQ6eQctET3J6KP41Ovw2
 bvBr4UalxgnN6gwVicLhtBTRXP+MK8uYsJjAZBG4NDSFgRx8NAzJLKWRoeoFBfdQ7j+x
 xbgFnk0PjF0p+xIVitSOqarcIFPEDR1+6REkF+4c4+LrXc50be5TBIEZwKTYehfCnzB/
 mg+Kphf2zNGpMx1O/Agvs/g4c7LlLIsnECgUGhlNAqgiXl9XAPk/8jSGqmRagkyfG3ag
 NekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746130919; x=1746735719;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F7bWiW4bRsnks3rl9OHy6axsrNrN4JteSqAxTGYEvLA=;
 b=D/3OGi+aTWybtVvWpS8Hx5skOMg50LWaejisNJ/OmMXR9fc93nvmIF5BYtOCQOjDT2
 6J3iOcuxQj3cd5qWzZvxHQYYgRLrQjiFL4/G5CgEe5tMmDNjoS810Bpa5pUgAxnCNY1h
 wcKFZIg7spGxYF1XhYL9+0oNxfuo0lD93eY4B963vXd5Q5Vl0YueN6qby/4fB4IAUgJn
 KSSqYv/3sXdcmVpMe3AyPBB9VDPlIGYe1wuG8tojrPNqZgnmQv21RgCCs8Py2TYJjEti
 az8Cr5KZpc/yBrRWZR/ARKLFH3+TqpkHGr7J33A31t6+c4Y3o4/F7MsorGfNswH7dE3c
 5NlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQKggpN1/x3TC0kKEZV3StA4jv5Od6yeqP1TUpYkyf6Z7hlrlni3yTnUoFk6Irm0+KBBQSfryYkCVE@nongnu.org
X-Gm-Message-State: AOJu0YzvDZZ4/h6rRPCRKs+U5bLBnMPENe5g3yJrVcbVjfXGEoIpcccB
 aMkS9OaSH3xxo6sECtTJHon3PZUZDBfiwUODcMGSk3m1wpJObsHR
X-Gm-Gg: ASbGncs5ZoJ6nio9yXVtxTzjOtsJRf05LOHwVwMVON9ek2G8L0Fffrpfyd6qycXzsdu
 sdJfEjuctA1DGoxMMcBZ7XYUDlXhFyidKRpSbZPJNavKQxlA7DN9jAMfz8jWzDL1KAy3srgflh+
 TtBDlufCHB5h+CyJ6YcMBMMasm5UPx8h1B/IDOSpHG37+jJk3qGwXGNdtEaTf0Z234B3kfvixg9
 S/8dVubYWVO9sdXC6BsWW5d5o7ZyHfUn4rqRkq3TEAphaZv4nUqF04azPzp+rLNNK7YchCWJ3cb
 goUQAnXDQ1DrW1cDNMVmhhKjpv4UIK7exOKCcSaVB2EL
X-Google-Smtp-Source: AGHT+IHlnqOZGR10lQx5RUe7HeSnm/NAMouxKfBunI57Mx1V7PBcF+jSOHJZiAV3AzeNMLkfJf//hw==
X-Received: by 2002:a17:903:2303:b0:223:6180:1bf7 with SMTP id
 d9443c01a7336-22e1033eecamr5319415ad.42.1746130919440; 
 Thu, 01 May 2025 13:21:59 -0700 (PDT)
Received: from smc-140338-bm01 ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1094180esm356985ad.235.2025.05.01.13.21.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 13:21:58 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 1 May 2025 20:21:56 +0000
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: anisa.su887@gmail.com, qemu-devel@nongnu.org, nifan.cxl@gmail.com,
 dave@stgolabs.net, linux-cxl@vger.kernel.org,
 Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH 3/9] cxl/type3: Add dsmas_flags to CXLDCRegion struct
Message-ID: <aBPV80J9TULzRslk@fanair.local>
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
 <20250317164204.2299371-4-anisa.su887@gmail.com>
 <20250424114259.000000a0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424114259.000000a0@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pl1-x62c.google.com
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

On Thu, Apr 24, 2025 at 11:42:59AM +0100, Jonathan Cameron wrote:
> On Mon, 17 Mar 2025 16:31:30 +0000
> anisa.su887@gmail.com wrote:
> 
> > From: Anisa Su <anisa.su@samsung.com>
> > 
> > Add dsmas_flags field to DC Region struct in preparation for next
> > command, which returns the dsmas flags in the response.
> > 
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > ---
> >  hw/mem/cxl_type3.c          | 2 ++
> >  include/hw/cxl/cxl_device.h | 1 +
> >  2 files changed, 3 insertions(+)
> > 
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index 731497ebda..452a0c101a 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -237,6 +237,8 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
> >                                            ct3d->dc.regions[i].len,
> >                                            false, true, region_base);
> >              ct3d->dc.regions[i].dsmadhandle = dsmad_handle - 1;
> > +            CDATDsmas *dsmas = (CDATDsmas *) table[cur_ent + CT3_CDAT_DSMAS];
> > +            ct3d->dc.regions[i].dsmas_flags = dsmas->flags;
> 
Hi Jonathan,
Thanks for the feedback.
> This is relying to much on the ordering of creating fields in
> ct3_build_cdat_entries_for_mr().
I am not sure whether I understand this clearly.
In current qemu implemtation, each mr (ram,pmem or dc region) will have the
whole set of cdat table entries (dsmas, dslbis0-3, etc), so as long as we point
to the right table entry, we can get the table correctly.
What do you mean "the ordering of creating fields"?
> 
> I'd rather you just stored the information flags is built from in CXLDCRegion
> and then built the field that is wonderfully called 'Note' in the DC region
This sentence is kind of broken for me, not totally clear what you are
suggesting :-(. Can you explain more?
Are you suggesting not directly take dsmas->flags as dsmas_flags, but
use bit op to generate the value used in Table 7-66 in cxl spec 3.2?
> configuration in 6.2 spec.   I've sent a mail to see if we can clean that
6.2 spec???
> 'what is the field called' question for future spec releases.
> 
> Whilst the flag definitions cross refer the CDAT spec, the actual locations
> of those flags matches, but doesn't cross refer so maybe in the future
> we will have other flags in here and locations might not match.
For the flags stored in dsmas table, do we expect there can be more than those
defined in Table 7-66 in spec 3.2?

Fan

> 
> >  
> >              cur_ent += CT3_CDAT_NUM_ENTRIES;
> >              region_base += ct3d->dc.regions[i].len;
> > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > index bebed04085..81b826f570 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -609,6 +609,7 @@ typedef struct CXLDCRegion {
> >      uint8_t flags;
> >      unsigned long *blk_bitmap;
> >      uint64_t supported_blk_size_bitmask;
> > +    uint8_t dsmas_flags;
> >  } CXLDCRegion;
> >  
> >  typedef struct CXLSetFeatureInfo {
> 

