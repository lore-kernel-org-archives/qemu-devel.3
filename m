Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14DE8C369C4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 18:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u57qL-00064W-5r; Wed, 16 Apr 2025 14:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u57qF-00063d-GH
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 14:50:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u57qD-0001nq-1j
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 14:50:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744829429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DT/PtrHkjVnX7raTAKshZaoX5HNaQDviCZNsrUW0lLQ=;
 b=Kcg5f3Z+F3v9EcrvDwpseyix6QiRLExveRav9ubAbRh62cZ2Awsr34K2DA2Xv/Gvoe07W/
 k3O58+XxKacNuqtZ1sglvI5+i2A0xK0lu+q8Q8POGKZYOA0sbkpUNRmv0h6rrzI1HQ6spf
 Hm2b+ANu3UYFWXtON3vuATxXpuG5dzM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-p-wJkfJZNgyiyoE3Yihf3g-1; Wed, 16 Apr 2025 14:50:23 -0400
X-MC-Unique: p-wJkfJZNgyiyoE3Yihf3g-1
X-Mimecast-MFC-AGG-ID: p-wJkfJZNgyiyoE3Yihf3g_1744829422
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43d01024089so57436475e9.1
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 11:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744829422; x=1745434222;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DT/PtrHkjVnX7raTAKshZaoX5HNaQDviCZNsrUW0lLQ=;
 b=nzkVioobvk01vUJmHR7Ehn9erjHxQrH2Pt8QLqSeoz8srrZJV76p8t7WPIg+cSxIbu
 bkGOtG5xvlr2q3565Xz3SCPKvrnBOahQCvLzvqozqeFuRErfuneIBtdkFPxKwQvRtzX3
 ww3mDFSKEOOzKqtJCfrCm/M/kwFmAOkT5clJN1ZMa+2X5G5OuxQYP5Cx7r7UYCZ6twQv
 ou2HffP8CdzwddbNAUvsiVbud1KaN8/WwnHI05fGIdat866ovQcBxFkweFULyr6FeaPp
 Hq2UZr0Z2DD99KHEQJ2Z+RY6RcLFIw7MYWAopr0TR37kuDWNwYBr9HDx2BtoZot66FVn
 Iz6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYCCyNZZ/aWaU6UX7Vq7C4+v/FxQ/zi/eJho2DQpZ4aBDtyFxhx4wubHVoVsFAdu3LlAtPZO86qkzA@nongnu.org
X-Gm-Message-State: AOJu0YwBeoEaCg1z52LOgKinjQPIH/otEsv0ZAtelOOcWuwFvN0H1AVu
 MXJiG+Vk7Fc2nMleD4oO/Z8Gxbf/TMTPDVjQ8axlYVkbknGcAkvB6m5MbCIWQLD8VUn1gkmtZ9d
 lesGlfQpuQ7M5ZGc6co3WrayOzmB6NQ7i4BZDr+/NGCIFE1KFSrt0BO2plupH
X-Gm-Gg: ASbGncuzDyapIsaXrsmzPDFIHUHw+vRwMXosuq2vS0ME5qcm1+tL2+48Z3sq9LM0dAQ
 6nO6PiznsYRLt0QIl3nEO8TEruhdadPmYqMMVkoINbPqY941B24LpQxtiNAab5eh++tCGIgzmB1
 DJx+Q+BzuvvY+NuWQVB+/8/nlmpQ3u0k4WFTxYXSjbXdmp0uqJe8oarK3xrZfY88IeEYujZBSn5
 MlwqPmBEuswCixjyLbOkAFL8Fd8GEB8KWY++jnodoyt6uKdHCVIW2EU7xMJ32JIQVFWLEln4lut
 sQQ2Tw==
X-Received: by 2002:a05:600c:1e12:b0:43c:e481:3353 with SMTP id
 5b1f17b1804b1-4405d6276a5mr32704325e9.17.1744829422123; 
 Wed, 16 Apr 2025 11:50:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1d/sqrci68FzlIdwNyLUWyUFSG5BveIH80uF8cIaVZ4xL3m5LTRbXFxHMjjCGRSC7Yyk0Wg==
X-Received: by 2002:a05:600c:1e12:b0:43c:e481:3353 with SMTP id
 5b1f17b1804b1-4405d6276a5mr32703985e9.17.1744829421709; 
 Wed, 16 Apr 2025 11:50:21 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae96c184sm18060921f8f.30.2025.04.16.11.50.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 11:50:20 -0700 (PDT)
Date: Wed, 16 Apr 2025 14:50:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Cc: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org, marcel.apfelbaum@gmail.com,
 alex.williamson@redhat.com, vasant.hegde@amd.com,
 suravee.suthikulpanit@amd.com, santosh.shukla@amd.com,
 Wei.Huang2@amd.com, joao.m.martins@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH 02/18] amd_iommu: Add helper function to extract the DTE
Message-ID: <20250416144817-mutt-send-email-mst@kernel.org>
References: <20250414020253.443831-1-alejandro.j.jimenez@oracle.com>
 <20250414020253.443831-3-alejandro.j.jimenez@oracle.com>
 <4a7a8eff-dd21-49b7-9d2a-449ae0424eb2@amd.com>
 <49e7c66f-6527-4ae1-b712-10921c538d5a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49e7c66f-6527-4ae1-b712-10921c538d5a@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Apr 16, 2025 at 09:29:23AM -0400, Alejandro Jimenez wrote:
> 
> 
> On 4/16/25 7:36 AM, Sairaj Kodilkar wrote:
> > 
> > 
> > On 4/14/2025 7:32 AM, Alejandro Jimenez wrote:
> > Hi Alejandro,
> > 
> > > Extracting the DTE from a given AMDVIAddressSpace pointer structure is a
> > > common operation required for syncing the shadow page tables. Implement a
> > > helper to do it and check for common error conditions.
> > > 
> > > Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> > > ---
> > >   hw/i386/amd_iommu.c | 47 ++++++++++++++++++++++++++++++++++++++++-----
> > >   1 file changed, 42 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> > > index 5f9b95279997..22d648c2e0e3 100644
> > > --- a/hw/i386/amd_iommu.c
> > > +++ b/hw/i386/amd_iommu.c
> > > @@ -77,6 +77,20 @@ typedef struct AMDVIIOTLBEntry {
> > >       uint64_t page_mask;         /* physical page size  */
> > >   } AMDVIIOTLBEntry;
> > > +/*
> > > + * These 'fault' reasons have an overloaded meaning since they are
> > > not only
> > > + * intended for describing reasons that generate an IO_PAGE_FAULT
> > > as per the AMD
> > > + * IOMMU specification, but are also used to signal internal errors
> > > in the
> > > + * emulation code.
> > > + */
> > > +typedef enum AMDVIFaultReason {
> > > +    AMDVI_FR_DTE_RTR_ERR = 1,           /* Failure to retrieve DTE */
> > > +    AMDVI_FR_DTE_V,                     /* DTE[V] = 0 */
> > > +    AMDVI_FR_DTE_TV,                    /* DTE[TV] = 0 */
> > > +} AMDVIFaultReason;
> > > +
> > > +static int amdvi_as_to_dte(AMDVIAddressSpace *as, uint64_t *dte);
> > > +
> > 
> > No need to have this function declaration as it is a static function.
> > 
> 
> I am adding a forward declaration since this function will be used by
> several other new and existing functions throughout the series, and this
> avoids having to keep moving the function definition. I do the same for many
> other functions in later patches, since it is more practical than constantly
> moving definitions around to guarantee ordering constraints. That approach
> would create patches with large diffs but non-functional changes due to code
> movement alone, makes it harder to parse the changes that actually matter,
> harder to rebase and resolve conflicts, etc...
> 
> Alejandro

You can add forward declarations temporarily to simplify review.  But in
the end, I prefer seeing code without forward declarations, with
functions ordered sensibly by order of calls, rather than spread
randomly all over the place.



> > 
> > Regards
> > Sairaj Kodilkar


