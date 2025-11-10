Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F13CCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 14:50:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vITDf-000235-Ic; Mon, 10 Nov 2025 09:50:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vITDb-0001yw-CA
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 09:50:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vITDX-0008D5-Kw
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 09:50:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762786201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ppLoESKO0e7C16zvgGhDv3duI4oVDW6l32sCD07y5xg=;
 b=TN18WYxVznvKGJhBQ4z+39AlPj8ZSWty0NbDi94bE6tr4Ehe10wsL/ydEvR9OLaaalgF12
 7Cj5Fd7dn8rKxrcaZCNcq9drIPjeB8RF4cnmyfcyOs5NACBgbw04WBav4zxPiP8J3fWLtZ
 QsofxgRU5fSaJBPwkEvexqVktwZzrSU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-NIH_H-pDMW-TBnALWbVvHA-1; Mon, 10 Nov 2025 09:50:00 -0500
X-MC-Unique: NIH_H-pDMW-TBnALWbVvHA-1
X-Mimecast-MFC-AGG-ID: NIH_H-pDMW-TBnALWbVvHA_1762786199
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477171bbf51so20864715e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 06:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762786199; x=1763390999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ppLoESKO0e7C16zvgGhDv3duI4oVDW6l32sCD07y5xg=;
 b=qoUoguRkIZrtKcLGoM1TxV6etRLNWshbsGdQGvKb62o5/C2/dY+ikWRC2tDQBcQG4Y
 SC7t74xul6SxdRp7w+vuSKCJWd2IAwvpvMSdIvjHkSRkzB1qxM97Ky3FbilO2u1pHW2d
 mDb1LIMKrErI/yTeNtReaOx0CBueDXIOH/hx5vshgpFh1NGYZYKFcr/NBoh2BLmy8jF6
 kXhBo8txhGDzqVMhRs6aHHooTjmocunuh1/MdKy/8BIDxfmpNba8zvIj+SKECp8srSDw
 JLCe4Tg8t871paNV95e0ZyYwEWpyMAhIpkor8Xet2QrH9XYpYtZC/+at7UOdMs+wD9YV
 gg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762786199; x=1763390999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ppLoESKO0e7C16zvgGhDv3duI4oVDW6l32sCD07y5xg=;
 b=k6E50X9GMygD6DM+i9MN4r3PxR57Gp1Bii4gc/txbUaWGWZghvkdZuygbmVmo8aOVz
 ITP0gwIYjwZUXOnul/QD/EOjbPPoQ7a1PToR8/zg5+vERjl6mM4uBxOUkpLmyyA680yJ
 MVCxLHt2Ww7fYkAXiW+s/R+X+yCm8KmCn0Bmk99SFaT/A5gWwxeY6tbo6isM6joqM31n
 o+7WwCkR+F0bhbdlwmaGbBzFeDBNwGWVTxHAQ4ujpPve7YlxR+dc2WmeIbu166LRjyMI
 8Tq6YDO48kqiRTnJlL5EEoQNF9tL4T4EWe2u8T4rwJxVGAKk+PTQNgjdk6SA0lf8L9Ee
 YO5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzzngaZ1PKVbq7mdIl+KqSN6A7ZjINFs/vDmDxSAqIuwhau1YqDxEk081tZIcwWFVis5znMeE5KHae@nongnu.org
X-Gm-Message-State: AOJu0Yyckc+6Lvt69YnLz0pHFGnX6MrWCNxnFuuyQFpLsSZwOUAQajAs
 yHSUZhd6rUY6n0MLHKtWX5WPviUQxFR8wDjpsnX65DAvolyabgBrZxCGguJE49SBiTcOYaKCJjV
 LIrNIMWUexWp0txvaOxeXqKYsSMD5O2tkFF9hwWV1X3XgcbS4y9wkMx97
X-Gm-Gg: ASbGncszPkyDx1juJsT7LiQzUHgb0mCPLjw8vfxtFSSYVN4BbdZG27RxvMNd9ylBOyQ
 7YK8d5MJo5vpi7bC4xkjjV+vJQloNbEQUB5ehHPxvwQ8kTLE3+kCC3hwFd8t4E2WO0WwFb6ypUd
 jXRPjMsm4zIzPTaucyYvOEvy6O45ZblVPiImCERBxef8aqBOTULYFAty9eFBkCw9aXxzAE1Rjez
 OHedw5CaxL/x1IRsEPK8y3c0pulLs/tGX1+ksnc1lyswxgVt9UDUy+h8tN+x/P7DZXNWyPc22kZ
 PGJYQszoVskGNyjzetfLCPysDNm6XrCWG+r6P26iowwDPX3qe8PAOz9thZ3pkAdl3A==
X-Received: by 2002:a05:600c:46d5:b0:477:4345:7c5c with SMTP id
 5b1f17b1804b1-47773297851mr76176275e9.38.1762786199109; 
 Mon, 10 Nov 2025 06:49:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLB9VxLqPtw8N0iK7sDC6Oy4PzP87JIwzyu9lVpm6qMtwU7GSsILWnZ4P2uY158ZDJWajpJg==
X-Received: by 2002:a05:600c:46d5:b0:477:4345:7c5c with SMTP id
 5b1f17b1804b1-47773297851mr76175985e9.38.1762786198674; 
 Mon, 10 Nov 2025 06:49:58 -0800 (PST)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4775ce211d8sm338343245e9.11.2025.11.10.06.49.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 06:49:58 -0800 (PST)
Date: Mon, 10 Nov 2025 15:49:57 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>, shan.gavin@gmail.com,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, mchehab+huawei@kernel.org,
 gengdongjiu1@gmail.com, mst@redhat.com, anisinha@redhat.com,
 peter.maydell@linaro.org, pbonzini@redhat.com
Subject: Re: [PATCH v3 4/8] acpi/ghes: Extend acpi_ghes_memory_errors() to
 support multiple CPERs
Message-ID: <20251110154957.5c481df7@fedora>
In-Reply-To: <cc07dfc9-f58a-4654-8854-c16a2e85fecd@redhat.com>
References: <20251105114453.2164073-1-gshan@redhat.com>
 <20251105114453.2164073-5-gshan@redhat.com>
 <20251105141455.000052f0@huawei.com>
 <cc07dfc9-f58a-4654-8854-c16a2e85fecd@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 6 Nov 2025 13:15:52 +1000
Gavin Shan <gshan@redhat.com> wrote:

> Hi Jonathan and Igor,
> 
> On 11/6/25 12:14 AM, Jonathan Cameron wrote:
> > On Wed,  5 Nov 2025 21:44:49 +1000
> > Gavin Shan <gshan@redhat.com> wrote:
> >   
> >> In the situation where host and guest has 64KiB and 4KiB page sizes,
> >> one problematic host page affects 16 guest pages. we need to send 16
> >> consective errors in this specific case.
> >>
> >> Extend acpi_ghes_memory_errors() to support multiple CPERs after the
> >> hunk of code to generate the GHES error status is pulled out from
> >> ghes_gen_err_data_uncorrectable_recoverable(). The status field of
> >> generic error status block is also updated accordingly if multiple
> >> error data entries are contained in the generic error status block.
> >>
> >> Signed-off-by: Gavin Shan <gshan@redhat.com>  
> > Hi Gavin,
> > 
> > Mostly fine, but a few comments on the defines added and a
> > question on what the multiple things are meant to mean?
> >   
> 
> Thanks for your review and comments, replies as below.
> 
> >> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> >> index a9c08e73c0..527b85c8d8 100644
> >> --- a/hw/acpi/ghes.c
> >> +++ b/hw/acpi/ghes.c
> >> @@ -57,8 +57,12 @@
> >>   /* The memory section CPER size, UEFI 2.6: N.2.5 Memory Error Section */
> >>   #define ACPI_GHES_MEM_CPER_LENGTH           80
> >>   
> >> -/* Masks for block_status flags */
> >> -#define ACPI_GEBS_UNCORRECTABLE         1
> >> +/* Bits for block_status flags */
> >> +#define ACPI_GEBS_UNCORRECTABLE           0
> >> +#define ACPI_GEBS_CORRECTABLE             1
> >> +#define ACPI_GEBS_MULTIPLE_UNCORRECTABLE  2
> >> +#define ACPI_GEBS_MULTIPLE_CORRECTABLE    3  
> > 
> > So this maps to the bits in block status.
> > 
> > I'm not actually sure what these multiple variants are meant to tell us.
> > The multiple error blocks example referred to by the spec is a way to represent
> > the same error applying to multiple places.  So that's one error, many blocks.
> > I have no idea if we set these bits in that case.
> > 
> > Based on a quick look I don't think linux even takes any notice.  THere
> > are defines in actbl1.h but I'm not seeing any use made of them.
> >   
> 
> I hope Igor can confirm since it was suggested by him.
> 
> It's hard to understand how exactly these multiple variants are used from the
> spec. In ACPI 6.5 Table 18.11, it's explained as below.
> 
> Bit [2] - Multiple Uncorrectable Errors: If set to one, indicates that more
> than one uncorrectable errors have been detected.
> 
> I don't see those multiple variants have been used by Linux. So I think it's
> safe to drop them.

even though example describes 'same' error at different components,
the bit fields descriptions doesn't set any limits on what 'more than one' means. 

Also from guest POV it's multiple different pages that we are reporting here
as multiple CPERs.
It seems to me that setting *_MULTIPLE_* here is correct thing to do.


> >> +#define ACPI_GEBS_ERROR_DATA_ENTRIES      4  
> > 
> > This is bits 4-13 and the define isn't used. I'd drop it.
> >   
> 
> The definition is used in acpi_ghes_memory_errors() of this patch. However,
> I don't see it has been used by Linux. This field isn't used by Linux to determine
> the total number of error entries. So I think I can drop it either if Igor is ok.
> 
> Thanks,
> Gavin
> 
> 
> 


