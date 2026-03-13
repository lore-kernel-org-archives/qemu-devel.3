Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD217106FD91
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:42:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0wDU-0004Ye-Pk; Fri, 13 Mar 2026 02:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1w0wDR-0004Xw-Ou; Fri, 13 Mar 2026 02:41:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1w0wDO-0006cL-Vj; Fri, 13 Mar 2026 02:41:45 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62CGUUfL2664770; Fri, 13 Mar 2026 06:41:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=pYfM7peJZA5YZXZPUGEQlep25bs2mD
 9iM9JBovXRtBA=; b=WKp85uy9aCenLCqyFVdxLkqXAs+DC4BAjxfRwEwNbNMoZ4
 e51QkKsaZRsSSinCHy5ZFU1tjxm5YBjK6046xuQsaXMhX+7ksMycIJvkws2A7E77
 r0CdyZR/87Q2TCTFP6xWT9yoY/CFDVTihkn/tF179nCvcB+8MWf1oHB49Pv8stK1
 aY6Q/i8O+dcKTcLkmwlWsA6P5NgiIyMQBLnBis+a/u5jys4NlQZ0rtzLmDotWPO1
 jiSoRox8MOq1W68OHbSoVFggy1XK1Y3DLKEzWuqk8oNOetPgCmbVE+ERNOLSzA9E
 3MDZ12Sw4IKlraYOoWrprlvfBcKWJBL2erpXNqew==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh98e71f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Mar 2026 06:41:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62D5DmM4008835;
 Fri, 13 Mar 2026 06:41:37 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cuha75k8y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Mar 2026 06:41:37 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62D6fXs149545616
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2026 06:41:33 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7254320043;
 Fri, 13 Mar 2026 06:41:33 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0ADD520040;
 Fri, 13 Mar 2026 06:41:31 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.217.239])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 13 Mar 2026 06:41:30 +0000 (GMT)
Date: Fri, 13 Mar 2026 12:11:29 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, npiggin@gmail.com,
 milesg@linux.ibm.com, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-stable@nongnu.org
Subject: Re: [PATCH v2] ppc/pnv: fix dumpdtb option
Message-ID: <abOxbwS8nGIC6aT3@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260311143549.118720-1-shivangu@linux.ibm.com>
 <abOq6LFmRLmQOZGE@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abOq6LFmRLmQOZGE@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=M+pA6iws c=1 sm=1 tr=0 ts=69b3b1a2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8 a=5aa4pgdBarSE5MfEfWwA:9
 a=CjuIK1q_8ugA:10 a=cvBusfyB2V15izCimMoJ:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: A00iJTfzTEbSjKJQzt9MzG88YoZ3lOJx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA1MSBTYWx0ZWRfX00FMOORTXJ98
 ijqqoiYv7Al8/dBph8dMdbuPojd3RW8jcv1ccILFJmSrwkkRgL7K6gexpPkvINH1SGudbuV8Ymn
 oayOoG03Ry+G6Q5doJxdNP/JgZ+4LaC541ueipwXPQJb8iWf3wTmbFM8k0TR53Cb3RexjK6berm
 TIeGos2NDUKuF0Q0je9p70YwMbwiPwGZPeaom5jAejfLFWDld8hkRmQHA+9n5TDyUu6ZK7vTWr7
 fmoeXGPh1kkyBZXGhMWf8yOjVVk6owuBNFAqbcdIUsSJNUSm7lvwBXJ/1Wr2RoD037hh3BLWEbQ
 NMsDbSpIU/y5sOBys9GaczMp/pO+BN47ZSc0CeEbK3Sp1HeM3p1WFWwFciWXuPXuRxqFYOAbPhJ
 wBtuHeq2gRZLjKKDzhziFLeWCYpEYFRCjrYe1CdItThdC0uYZyl8jRxWdX1NIhu6DQAtYy33yBs
 z4Du1UC0FKDts8qJ7kg==
X-Proofpoint-ORIG-GUID: FKe_ptJYoCp_X8bEUawubugOhD9UU5Ps
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_03,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603130051
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 26/03/13 11:45AM, Aditya Gupta wrote:
> On 26/03/11 08:05PM, Shivang Upadhyay wrote:
> > The '-machine dumpdtb' command line option stopped working on
> > PowerPC/pnv systems after recent design change [1].
> > 
> > Fixing this by generating fdt blob in `pnv_init`.
> > 
> > [1] https://lore.kernel.org/qemu-devel/20250206151214.2947842-1-peter.maydell@linaro.org/
> > 
> > Cc: Aditya Gupta <adityag@linux.ibm.com>
> > Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> > Cc: Peter Maydell <peter.maydell@linaro.org>
> > Cc: BALATON Zoltan <balaton@eik.bme.hu>
> > Cc: qemu-stable@nongnu.org
> > Fixes: 8fd2518ef2f8d34 ("hw: Centralize handling of -machine dumpdtb option")
> > Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> > 
> > <...snip...>
> > 
> >  static ISABus *pnv_chip_power8_isa_create(PnvChip *chip, Error **errp)
> > @@ -1261,6 +1243,11 @@ static void pnv_init(MachineState *machine)
> >      if (pmc->i2c_init) {
> >          pmc->i2c_init(pnv);
> >      }
> > +
> > +    if (!machine->fdt) {
> > +        machine->fdt = pnv_dt_create(machine);
> > +        _FDT((fdt_pack(machine->fdt)));
> > +    }
> 
> This if check is not needed, pnv_init is only called once during start,
> and machine->fdt will always be NULL, so we can just assign machine->fdt
> directly.

Just noticed this can happen if dtb is passed, please ignore this
comment.

The patch looks good to me, will test and give rb.

Thanks,
- Aditya G

> 
> Rest all looks fine to me.
> 
> Thanks,
> - Aditya G
> 
> 

