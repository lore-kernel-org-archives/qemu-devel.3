Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 628DCC5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 11:34:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvvbw-0007EN-QR; Mon, 17 Aug 2026 07:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wvvbl-00079k-A5; Mon, 17 Aug 2026 07:34:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wvvbi-0005Ew-UG; Mon, 17 Aug 2026 07:34:25 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HBGN133727939; Mon, 17 Aug 2026 11:34:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=gTGwEq
 8G8irvWWNOm/PcxgnsCARQ6N2Dd47j7VvO8+8=; b=Il3Zh9wxpRc6aUUg1jzFl6
 JDL2A8i6anSVm2KEAL9Ae/p+NvfaDSB1AV0W9M8n9kaAj1fXkxQnzQQt9jN2gVjJ
 M3293IopPAQUz8s7jUPIOvKzex86DjTPkz4hBQDd58kRHocdHrjrugvC/f3gH45x
 u0tkK5Azx41JCMGyZu/sN3aNxg5C9dy16iG/HU9h0N67i9c0ZtyS5jUm9RfGrrk7
 Olj7mVzZlUAaLoo+T3kcr43Vdvuzj0Unn5D8fIyU1KDPUJzwjjT4PUnbNy6LptdL
 /DxW9oW/D1yr6DJrl1l6Ev+NZCa2LiO3ECOYYZWBTXDAguW6N8VHSK+A0xDjK4Qg
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fu4j018-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 11:34:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HBQHHj004729;
 Mon, 17 Aug 2026 11:34:17 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ng5mec-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 11:34:17 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67HBYDSO49742096
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Aug 2026 11:34:13 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 78CC52004B;
 Mon, 17 Aug 2026 11:34:13 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EB5EF20040;
 Mon, 17 Aug 2026 11:34:11 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 17 Aug 2026 11:34:11 +0000 (GMT)
Date: Mon, 17 Aug 2026 17:03:48 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, npiggin@gmail.com,
 harshpb@linux.ibm.com, aik@ozlabs.ru, amachhiw@linux.ibm.com
Subject: Re: [PATCH] target/ppc: Add lower bound check for watchdogNumber
Message-ID: <20260817165901.b9ff4441-8a-amachhiw@linux.ibm.com>
Mail-Followup-To: Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org, 
 qemu-devel@nongnu.org, npiggin@gmail.com, harshpb@linux.ibm.com, aik@ozlabs.ru
References: <20260817105854.437724-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260817105854.437724-1-rathc@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: nnsPsEeIE5kBVEVrXqwPZ36yU-kGJ2-m
X-Authority-Analysis: v=2.4 cv=NLLlPU6g c=1 sm=1 tr=0 ts=6a82f1ba cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=p0WdMEafAAAA:8
 a=VnNF1IyMAAAA:8 a=cCKD8EcQpzVDzIzrGIkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA4NyBTYWx0ZWRfX1G1CHsDVepvP
 XL3P49JWNsAkMxA7vRS3LrW3ER+Ul6Ek0MprNUwmTRqQ7Ya0CKdapi8Xq2m/VzOYDb+Qmr4Lz8o
 jMfOffF3rXD+t5VGrEP6DE37gL0jR00=
X-Proofpoint-ORIG-GUID: TuMIgfb6kwy2qhdxW7KFp5tKFXVtDHfk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA4NyBTYWx0ZWRfXydNSHTu9O4p5
 UzCtYopENiGiLRQZZKl8WxflwD2GdOKUVm6RIxEsqZXgIs44LzSiy9KJPCiWCkYaE8K9GypSITJ
 HDASpwmfOWj+hA86hQV/p2R8dGtuo8oirmEOv9ZL8cuGMC/xqGsasRl0O5beg/MbzP0Gu5WMw0q
 kaUG9cQ2fPN2QTMjhqDIPdomc/fW/uFZUOIKfDpG7PXzfRDx0L4mSIQZYLYByzDr4AWp42oydd0
 edzC6ADx2axFJAyT4Illv+OQzAYhPN0xp5ep6CPfyNceMxK+xBkCZcQqeNc2HVCc65zASfs/40A
 I3vpJZALbn0Li0B1EUKHtrfvFNrxVuXnHTlL3TSqZ8MK1XqgaGtFplVtBYpvwAMoPUHKNs56CVX
 RwrusKCa7ebNMWuPSYnt5vpY0X/afoEUGlTHRVVmTJaJQCXMH2AQ1Pvaiep1BsD/jDTR0toQyht
 BV4uKsigydi7xjAqvsg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 clxscore=1011 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170087
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026/08/17 04:28 PM, Chinmay Rath wrote:
> Add missing lower bound check for H_WATCHDOG H_CALL's watchdogNumber parameter
> as per PAPR documentation ver 12.10.00 section 14.15.5 'H_WATCHDOG'.
> 
> Closes : https://gitlab.com/qemu-project/qemu/-/work_items/3600
> 

Nit: This newline is not needed.

> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>  hw/watchdog/spapr_watchdog.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/watchdog/spapr_watchdog.c b/hw/watchdog/spapr_watchdog.c
> index 5b3f50de3a..5d7478e833 100644
> --- a/hw/watchdog/spapr_watchdog.c
> +++ b/hw/watchdog/spapr_watchdog.c
> @@ -145,7 +145,7 @@ static target_ulong h_watchdog(PowerPCCPU *cpu,
>  
>      switch (operation) {
>      case PSERIES_WDTF_OP_START:
> -        if (watchdogNumber > ARRAY_SIZE(spapr->wds)) {
> +        if (watchdogNumber < 1 || watchdogNumber > ARRAY_SIZE(spapr->wds)) {
>              return H_P2;
>          }
>          if (timeoutInMs <= WDT_MIN_TIMEOUT) {
> @@ -170,7 +170,8 @@ static target_ulong h_watchdog(PowerPCCPU *cpu,
>      case PSERIES_WDTF_OP_STOP:
>          if (watchdogNumber == PSERIES_WDT_STOP_ALL) {
>              ret = watchdog_stop_all(spapr);
> -        } else if (watchdogNumber <= ARRAY_SIZE(spapr->wds)) {
> +        } else if (watchdogNumber > 0 &&
> +                   watchdogNumber <= ARRAY_SIZE(spapr->wds)) {
>              ret = watchdog_stop(watchdogNumber,
>                                  &spapr->wds[watchdogNumber - 1]);
>          } else {

Nit: The bounds check in OP_STOP uses a positive-selection guard
(watchdogNumber > 0 && watchdogNumber <= ARRAY_SIZE(...)) with the error
in the trailing else, which reads differently from the negative guards
used in OP_START and OP_QUERY_LPM. Consider flipping it to match:

  } else if (watchdogNumber < 1 ||
             watchdogNumber > ARRAY_SIZE(spapr->wds)) {
      return H_P2;
  } else {
      ret = watchdog_stop(watchdogNumber,
                          &spapr->wds[watchdogNumber - 1]);
  }

> @@ -184,7 +185,7 @@ static target_ulong h_watchdog(PowerPCCPU *cpu,
>          trace_spapr_watchdog_query(args[0]);
>          break;
>      case PSERIES_WDTF_OP_QUERY_LPM:
> -        if (watchdogNumber > ARRAY_SIZE(spapr->wds)) {
> +        if (watchdogNumber < 1 || watchdogNumber > ARRAY_SIZE(spapr->wds)) {
>              return H_P2;
>          }

Suggestion (follow-up patch): After this fix lands, it may be worth
extracting a small helper to avoid the repeated bounds expression across
OP_START, OP_STOP, and OP_QUERY_LPM:

  static inline bool watchdog_number_valid(target_ulong n,
                                           SpaprMachineState *spapr)
  {
      return n >= 1 && n <= ARRAY_SIZE(spapr->wds);
  }

The three call sites then become a uniform !watchdog_number_valid(...)
or watchdog_number_valid(...) expression, the bounds are defined in
exactly one place, and any future change to the valid range (e.g. a
dynamic wds size) has a single point of update. Not a blocker for this
patch — just a clean-up worth a separate patch.

Thanks,
Amit

