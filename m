Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4896EC3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 13:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ9jp-0005oJ-8Z; Wed, 31 Jul 2024 09:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sZ9jl-0005ZT-NJ; Wed, 31 Jul 2024 09:51:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sZ9jj-00014H-1Z; Wed, 31 Jul 2024 09:51:29 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46VCsq7K005910;
 Wed, 31 Jul 2024 13:51:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
 :from:to:cc:subject:message-id:references:content-type
 :in-reply-to:content-transfer-encoding:mime-version; s=pp1; bh=1
 Mo6Bd4QbkzmGJll/GA45IMUOwskmKarbJ8fozx/RQ4=; b=jqkW+zoWSY4xCCcfA
 QiAqAWThUmX4pYVSUUegiG6AeaFPPiXMl5g9Jn/5koRKtuNtVLl91p3ueF4L4uvH
 4+B1IzCjiwJD2oN5VCGL+LLO2E15m+l1MDPOiGV59YqW19ScxfKaDW9n/iGU8AHu
 CdVkATIzb/FHKI9b+rMSIMl8xve/HhpY/guh1LwllUcN+jhGSIOvwdR85+jkRakO
 1vgA443eWKV66586rfT2wyApwVAIE7Oc8fyqkWXHz+EKe4Pq/XkTnA8n0iCYGZMn
 tvFl1mWc7VCPboWjPxC26uXTziAnP8a7KezNT9Ytuc63DvloSYUnkAGdqaTQbKJa
 +kI8g==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40qhkf8tuc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jul 2024 13:51:16 +0000 (GMT)
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46VDpGSY014141;
 Wed, 31 Jul 2024 13:51:16 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40qhkf8tu9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jul 2024 13:51:16 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46VB5G0l007483; Wed, 31 Jul 2024 13:51:15 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40nb7uc0m8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jul 2024 13:51:15 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46VDp8fn20382066
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Jul 2024 13:51:10 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9F9A22005A;
 Wed, 31 Jul 2024 13:51:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 611FD20040;
 Wed, 31 Jul 2024 13:51:06 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.109.199.72])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 31 Jul 2024 13:51:06 +0000 (GMT)
Date: Wed, 31 Jul 2024 19:21:01 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?utf-8?B?RnLDqWTDqXJpYw==?= Barrat <fbarrat@linux.ibm.com>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [RFC PATCH] hw/ppc: Implement -dtb support for PowerNV
Message-ID: <fenybu4ixflehyc64kt4s73nqderhkl6xcik5gvgopot23dg75@e4asgghuctp3>
References: <20240731132235.887918-1-adityag@linux.ibm.com>
 <Zqo9SOG_t-iI9xW4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zqo9SOG_t-iI9xW4@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9q9EZLMQhQpwH6JQC91_U8_m3lwM5yJ8
X-Proofpoint-ORIG-GUID: lRs65imfXOaXwc82js627kzlAoNAEPxB
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_08,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=466
 impostorscore=0 mlxscore=0 bulkscore=0 spamscore=0 suspectscore=0
 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407310098
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hi Daniel,

Thank you for the review.

On 24/07/31 02:34PM, Daniel P. Berrangé wrote:
> On Wed, Jul 31, 2024 at 06:52:35PM +0530, Aditya Gupta wrote:
> > Currently any device tree passed with -dtb option in QEMU, was ignored
> > by the PowerNV code.
> > 
> > Read and pass the passed -dtb to the kernel, thus enabling easier
> > debugging with custom DTBs.
> > 
> > The existing behaviour when -dtb is 'not' passed, is preserved as-is.
> > 
> > But when a '-dtb' is passed, it completely overrides any dtb nodes or
> > changes QEMU might have done, such as '-append' arguments to the kernel
> > (which are mentioned in /chosen/bootargs in the dtb), hence add warning
> > when -dtb is being used
> > 
> > Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> > 
> > ---
> > This is an RFC patch, and hence might not be the final implementation,
> > though this current one is a solution which works
> > ---
> > ---
> >  hw/ppc/pnv.c | 29 ++++++++++++++++++++++++++---
> >  1 file changed, 26 insertions(+), 3 deletions(-)
> > 
> > diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> > index 3526852685b4..12cc909b9e26 100644
> > --- a/hw/ppc/pnv.c
> > +++ b/hw/ppc/pnv.c
> > @@ -714,6 +714,8 @@ static void pnv_reset(MachineState *machine, ShutdownCause reason)
> >      PnvMachineState *pnv = PNV_MACHINE(machine);
> >      IPMIBmc *bmc;
> >      void *fdt;
> > +    FILE *fdt_file;
> > +    uint32_t fdt_size;
> >  
> >      qemu_devices_reset(reason);
> >  
> > @@ -736,10 +738,31 @@ static void pnv_reset(MachineState *machine, ShutdownCause reason)
> >          }
> >      }
> >  
> > -    fdt = pnv_dt_create(machine);
> > +    if (machine->dtb) {
> > +        warn_report("with manually passed dtb, some options like '-append'"
> > +                " might ignored and the dtb passed will be used as-is");
> 
> Check whether append is actually set, and report an fatal error in
> that case. 

Got it.

Though there might be more options which might get ignored, such as
maybe even -device options, as whatever QEMU adds to it's device tree,
that will get ignored, and only the device nodes present in passed DTB
will be used.

> 
> >  
> > -    /* Pack resulting tree */
> > -    _FDT((fdt_pack(fdt)));
> > +        fdt = g_malloc0(FDT_MAX_SIZE);
> > +
> > +        /* read the file 'machine->dtb', and load it into 'fdt' buffer */
> > +        fdt_file = fopen(machine->dtb, "r");
> > +        if (fdt_file != NULL) {
> > +            fdt_size = fread(fdt, sizeof(char), FDT_MAX_SIZE, fdt_file);
> > +            if (ferror(fdt_file) != 0) {
> > +                error_report("Could not load dtb '%s'",
> > +                             machine->dtb);
> > +                exit(1);
> > +            }
> > +
> > +            /* mark end of the fdt buffer with '\0' */
> > +            ((char *)fdt)[fdt_size] = '\0';
> > +        }
> 
> Preferrable to use g_file_get_contents()

Sure, thanks, didn't know that !

Thanks,
Aditya Gupta

> 
> > +    } else {
> > +        fdt = pnv_dt_create(machine);
> > +
> > +        /* Pack resulting tree */
> > +        _FDT((fdt_pack(fdt)));
> > +    }
> >  
> >      qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
> >      cpu_physical_memory_write(PNV_FDT_ADDR, fdt, fdt_totalsize(fdt));
> > -- 
> > 2.45.2
> > 
> > 
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 

