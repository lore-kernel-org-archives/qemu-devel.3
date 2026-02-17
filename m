Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82784E63F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 07:13:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsFGW-0006Zo-6X; Tue, 17 Feb 2026 02:13:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vsFG4-0006Mv-P4; Tue, 17 Feb 2026 02:12:34 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vsFG3-0003nI-Ce; Tue, 17 Feb 2026 02:12:32 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61H3QQEa2643792; Tue, 17 Feb 2026 07:12:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=6ELXBU
 xs/l1zmhZ2pOkDLd9hnS2MMKour97fVDXHGYE=; b=sGSCiB2/8rzLk+CM3TK/Yl
 0Lvz0WFh2WS6jZhqJtGFIv1X3MmOQ8R/zO3SLcogidlQR32AfGgd9zujQRBadzYT
 C/hrqHsHWs/zhsyfj7mbQPjRO05jRyjPm6Re0Np6gtM9lOlURiiRM9wuKgqEjM/q
 Ehv9h85h8pGGBAXC96Hwmdt7LXavX1HdfTOiY8SwC3THHum4szaxSMsWa721DJTS
 bg00MrKsSsAvXME103UzoeSZcJFyhbib+8HIiVbH854YXVPxdgnXEvePx3/UJdDr
 CobLKveyqq0H/2Jci8ITI8+mbqGf5ntOkr3yfAfzPhxQJQFc3iL6JazmOtJ+jh4g
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj4ka2re-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Feb 2026 07:12:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61H35JAa017792;
 Tue, 17 Feb 2026 07:12:21 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb289fvg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Feb 2026 07:12:21 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61H7CH5H26608104
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Feb 2026 07:12:17 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EA59720043;
 Tue, 17 Feb 2026 07:12:16 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7F9772004B;
 Tue, 17 Feb 2026 07:12:15 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.109.199.210])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 17 Feb 2026 07:12:15 +0000 (GMT)
Date: Tue, 17 Feb 2026 12:42:13 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH v2 5/9] pnv/mpipl: Preserve CPU registers after crash
Message-ID: <aZQUatl4mkouE-tu@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20251206055648.1908734-1-adityag@linux.ibm.com>
 <20251206055648.1908734-6-adityag@linux.ibm.com>
 <b35e15b0-6677-4fda-b687-50affe40c678@linux.ibm.com>
 <4d47c1b4-47d3-44a4-b189-2401b5176b93@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d47c1b4-47d3-44a4-b189-2401b5176b93@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA1OCBTYWx0ZWRfX/qzUj0UoALy4
 8Mf/SonP/HIZWhWkVQNKJ4QNSKG3wp0sjXHX0k1Dqr33xKPNIfcbhvW5r9/kZz6g5YX5qPk2myw
 ZsTuCrtanLWp8kABBr2tvFc+jPGlVXlkJV56VnYrKZeRWqm9F8tMhKexthMIKhBog+137mz1fsL
 YiCayhop4BWEpjor8yukPeLGXIluFylHWJXzy3VwvE3uOEIC4ZiT03P0iVavcF5INkKmCeezKl9
 rhJf6UGI5jK0WOUG6FiYinKvNlgJ/NTYROrTX4HiZowJb5w6Rw+szF//kgkg2d75ZQu8DtZe1tc
 KsVK5M27h9gpvfzTKBeudMFXtAsono9bJwgR9OtTmF4B9Qt2VGaCl0dJ5Vb4Z+7LUsvT7ByUmQ2
 ZvDmdxp/t/56lBQ2VaomGkOyJi+3cjjpNk2GLI3VqWfuxr/wlJoKOSUksCzpPjUy3fUJtdl40g7
 sdoEGsqhWsM3wz2E3Lw==
X-Proofpoint-ORIG-GUID: 01p2dLGz1DVh0dWDjJSJ6aCqNIgN9bJO
X-Proofpoint-GUID: 01p2dLGz1DVh0dWDjJSJ6aCqNIgN9bJO
X-Authority-Analysis: v=2.4 cv=M7hA6iws c=1 sm=1 tr=0 ts=699414d5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=28rbkFGKs0NOtsuNU2wA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170058
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 26/01/19 01:19PM, Hari Bathini wrote:
> 
> 
> > <...snip...>
> On 19/01/26 1:17 pm, Hari Bathini wrote:
> > >   typedef struct MpiplPreservedState MpiplPreservedState;
> 
> > > +typedef struct MpiplRegDataHdr MpiplRegDataHdr;
> > > +typedef struct MpiplRegEntry MpiplRegEntry;
> > > +typedef struct MpiplProcDumpArea MpiplProcDumpArea;
> 
> > > +typedef struct MpiplPreservedState MpiplPreservedState;
> 
> btw, the above typedef is already available from a previous patch..

Will remove this duplicate.

> 
> > > +typedef struct MpiplPreservedCPUState MpiplPreservedCPUState;
> > > +
> > >   /* Following offsets are copied from skiboot source code */
> > >   /* Use 768 bytes for SPIRAH */
> > >   #define SPIRAH_OFF      0x00010000
> > > @@ -46,6 +52,8 @@ typedef struct MpiplPreservedState MpiplPreservedState;
> > >   #define __packed             __attribute__((packed))
> > 
> > > +#define NUM_REGS_PER_CPU 34 /*(32 GPRs, NIP, MSR)*/
> > > +
> > 
> > Any limitation with saving the other SPRs? At least, LR is one other
> > relevant SPR that needs to be saved for some meaningful context..

Few registers are not implemented in QEMU. But LR should be possible,
will add more registers that can be added Hari.

Thanks,
- Aditya G

> 
> - Hari

