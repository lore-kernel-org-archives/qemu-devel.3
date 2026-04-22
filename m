Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C60CDF9EDC5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 12:44:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFWwV-000216-VJ; Wed, 22 Apr 2026 08:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wFWwR-0001xh-1f; Wed, 22 Apr 2026 08:44:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wFWwP-00038F-H7; Wed, 22 Apr 2026 08:44:30 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63MC1L6x878106; Wed, 22 Apr 2026 12:44:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=89jJKFMUgIHKQ11XHc2SdyY7ZEDCaGScBoL48lZuKoA=; b=iolh/EghdM9g
 CJnI3yRo5Z5qT7nJiGy6H0RuGtPDgt8blI48LEzuMzUd0zvsXfjPxTUcO1Cm+aWg
 ANusvzbmeDokzYuVsB6WB6o5+Bzirwy/FP4wbwxcLN9RHktC0yh0IB3fD0pdaX1r
 4ZuaXLJpDmwaihlV+7PDFALQhBa3jGgDwXGuQIAQizN2Kmni7tLsXJCfb4LVH7f/
 n0hOlSlG00HCb5Vvr9j5rBEYLez3EaEOVZhi1ORrT20vF529tt8HZDhv75Q7e10n
 KbQXnprQy8B9cFzBCk+3vMK8ilfJFZp/BUH/ztiIzpptZiu6QhCfbKtr/eSUu1Fo
 W4XRHoStLw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu23g9r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Apr 2026 12:44:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63MCZIWr009689;
 Wed, 22 Apr 2026 12:44:23 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjkxt842-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Apr 2026 12:44:23 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63MCiMrK38601296
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Apr 2026 12:44:22 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 619055803F;
 Wed, 22 Apr 2026 12:44:22 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7921D58055;
 Wed, 22 Apr 2026 12:44:21 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 22 Apr 2026 12:44:21 +0000 (GMT)
Message-ID: <baa2ce88b3554a6434415c8e78281bb221953196.camel@linux.ibm.com>
Subject: Re: [PATCH 0/8] target/ppc: Forbid to use legacy ldst_phys() API
From: Miles Glenn <milesg@linux.ibm.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, BALATON Zoltan
 <balaton@eik.bme.hu>,
 Nicholas Piggin <npiggin@gmail.com>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>
Date: Wed, 22 Apr 2026 07:44:21 -0500
In-Reply-To: <20260319111936.68041-1-philmd@linaro.org>
References: <20260319111936.68041-1-philmd@linaro.org>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDExOCBTYWx0ZWRfX/JS91OLd4Eza
 Q3NGHm8RYqxLUayU5o/3uANQoJ17VNzPgjDdidyI0E+5y2xXENQBXDI04L/8oIBEjdA+99/mDaE
 OFFAKXMsGcacEQWcDoirEUqkRLUt+TpdapvgSoU9IIGvdvALqo7C0vEqzblkX/3Hrx9GUKEezaV
 v+hFC58Tu07BgrQRL2pSrymnOX38b5/jEMiDRZqg76rxG1rlVceln8E1jwU3tUVdb8O7NZUQOVQ
 rOAdzhh55ZZXDHVnYeATZf9f4eBuqUS8LdhfrXAlE6IsrKIV+4piVqajABKfUzT6lRcmZS68GG1
 dbg6BaDVHI5o+8ofcZvXaWY8x1EUjcHh/0iLRNZMHpFi9aXHa8jEpldG9Mps9jrOCSPaKPhNvHc
 vczNla3CCAIFuY0IHBWCsFdJ5eqq18sWastXMHvw3uQifdAwuF2LZq2cx89ehl0ddmjpKIg0dsE
 /v80GkNWS6FGBAA9lXw==
X-Proofpoint-ORIG-GUID: THHtA1YjjoXQPcqkEhYoK5Rng_csG3NH
X-Proofpoint-GUID: WfIISZnP3XFT1Yze3vtg-p8qnafDcxvQ
X-Authority-Analysis: v=2.4 cv=XMUAjwhE c=1 sm=1 tr=0 ts=69e8c2a9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=FbiGK3ctOxS2QG3a_X0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220118
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Acked-by: Glenn Miles <milesg@linux.ibm.com>

Thanks,

Glenn

On Thu, 2026-03-19 at 12:19 +0100, Philippe Mathieu-Daudé wrote:
> Replace legacy ld/st_phys() by address_space_ld/st()
> then lock the target again further legacy API uses.
> 
> Philippe Mathieu-Daudé (8):
>   hw/ppc/spapr: Un-inline rtas_load/store() helpers
>   target/ppc: Factor common ppc_load_epr() helper out
>   target/ppc/mmu: Remove unused hash32_store_hpte() helpers
>   target/ppc/mmu: Restrict hash32_load_hpte() helpers scope
>   target/ppc/mmu: Replace legacy ld/st_phys() -> address_space_ld/st()
>   hw/ppc/pegasos: Introduce rtas_ldl() / rtas_stl() helpers
>   hw/ppc/pegasos: Replace legacy ld/st_phys() -> address_space_ld/st()
>   configs/targets: Restrict the legacy ldst_phys() API on PPC
> 
>  configs/targets/ppc-softmmu.mak |  1 +
>  include/hw/ppc/spapr.h          | 18 ++-------
>  target/ppc/cpu.h                |  2 +
>  target/ppc/mmu-hash32.h         | 32 ----------------
>  hw/ppc/pegasos.c                | 67 +++++++++++++++++++--------------
>  hw/ppc/spapr_rtas.c             | 15 ++++++++
>  target/ppc/cpu.c                |  9 +++++
>  target/ppc/excp_helper.c        |  3 +-
>  target/ppc/kvm.c                |  2 +-
>  target/ppc/mmu-hash32.c         | 24 +++++++++++-
>  10 files changed, 93 insertions(+), 80 deletions(-)
> 


