Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3472ACAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 16:27:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1oni-0006F9-FK; Thu, 25 Sep 2025 12:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1v1ond-0006Ep-Rh; Thu, 25 Sep 2025 12:26:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1v1onQ-0004eF-4y; Thu, 25 Sep 2025 12:26:29 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PELkRo023754;
 Thu, 25 Sep 2025 16:26:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=I5H/n9
 3WHpngXVzqHOX1oYBgWrx847iqcD59i8p3uKI=; b=i2yf8+s0iBW3RZZ5IciCAA
 3fDbvbqZu0UnxxRSDaW1v9oK0a5CNAey5abS+0/qKjFWO3bVFdd6hVZ3dQ28b6vN
 fkUCDJRa9AqDky35HZe4LScewKiudErOd3VPG7DnevY8vyy7srrseRlzEniw7EdJ
 OpwEZOf+sIqoFOsxo4VjxpD83u4AesEKENrX2t6ReFIB4l+WxJu23c/TrEFVh2e1
 w2EzTfBCnnWaWhibzHqW0x3C5SCxnAdjFcC0MMh4qrHHtts+RzQYSGUphrY/8tUx
 Nj2vC2jiSoQKvkglqHALVCNmG4XxXXZCOgzW+Cb3oOW5UwqOn8Zt0/YNfjHrPBNA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499n0jxu3h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 16:26:02 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58PGHGYW022477;
 Thu, 25 Sep 2025 16:26:02 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499n0jxu3d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 16:26:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58PEGrbJ030336;
 Thu, 25 Sep 2025 16:26:01 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49a9a1emnh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 16:26:01 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58PGPx6n33292650
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Sep 2025 16:25:59 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B071F58054;
 Thu, 25 Sep 2025 16:25:59 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B71A15805A;
 Thu, 25 Sep 2025 16:25:56 +0000 (GMT)
Received: from [9.124.219.9] (unknown [9.124.219.9])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 25 Sep 2025 16:25:56 +0000 (GMT)
Message-ID: <bd1a0b9c-62b8-4f99-9721-ab88b22f2dae@linux.ibm.com>
Date: Thu, 25 Sep 2025 21:55:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/9] target/ppc: IBM PPE42 exception flags and regs
To: Glenn Miles <milesg@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@redhat.com, npiggin@gmail.com,
 harshpb@linux.ibm.com, thuth@redhat.com, richard.henderson@linaro.org
References: <20250918182731.528944-1-milesg@linux.ibm.com>
 <20250918182731.528944-4-milesg@linux.ibm.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <20250918182731.528944-4-milesg@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzMyBTYWx0ZWRfX7ntqMJNWpOhD
 hlnBRnFSkMrnyNEw8FSb4q+zFEeEjncEMNAmDpAEoZyfcN3G1gHKQm406EYvfiD74enAN0FsYh5
 EBq1M44/qq179roazCZ1g5+D+PfPvUh1rOXYFR8IN1o1eHJPXje5cL14PC22uFCOFmWHahhniwm
 GEEbLS87WksALKJlRk2yW5FHivhkbqtVuIkl+32ZXz5xSJOz0SnHzIomgn1fxxug9iO7uY6bCsZ
 TRFKD0pERIjKm//rKPOOXk1gZGguTgZxBn85Pcne1NItTwg4mLCxJWCxcnMonQwhWO/FBqJ6OF3
 8aqzUO7HqJKEPDQxVClRV6F/VeRPx6DJzpCfK9bL01TFBF9Q+N3XLRVDiAtKiykUI6+Kyrwdhxk
 nBpqUPpt
X-Authority-Analysis: v=2.4 cv=TOlFS0la c=1 sm=1 tr=0 ts=68d56d1a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=v9f-Hb-qk-_uyW1wNzkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: N7KKsOeM0bg1XUnStYe1qaamkH1Gr-ux
X-Proofpoint-GUID: QgrEJpEJtADCDSfkrE-W9sOdqTjmeomX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200033
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


On 9/18/25 23:57, Glenn Miles wrote:
> Introduces flags and register definitions needed
> for the IBM PPE42 exception model.
>
> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>   target/ppc/cpu.h | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
>
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 8e13ce41a9..787020f6f9 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -220,6 +220,8 @@ typedef enum powerpc_excp_t {
>       POWERPC_EXCP_POWER10,
>       /* POWER11 exception model           */
>       POWERPC_EXCP_POWER11,
> +    /* PPE42 exception model            */
> +    POWERPC_EXCP_PPE42,
>   } powerpc_excp_t;
>   
>   /*****************************************************************************/
> @@ -760,6 +762,31 @@ FIELD(MSR, SIBRCA, MSR_SIBRCA7, 8)
>   #define ESR_VLEMI PPC_BIT(58) /* VLE operation                          */
>   #define ESR_MIF   PPC_BIT(62) /* Misaligned instruction (VLE)           */
>   
> +/* PPE42 Interrupt Status Register bits */
> +#define PPE42_ISR_SRSMS0  PPC_BIT_NR(48) /* Sys Reset State Machine State 0   */
> +#define PPE42_ISR_SRSMS1  PPC_BIT_NR(49) /* Sys Reset State Machine State 1   */
> +#define PPE42_ISR_SRSMS2  PPC_BIT_NR(50) /* Sys Reset State Machine State 2   */
> +#define PPE42_ISR_SRSMS3  PPC_BIT_NR(51) /* Sys Reset State Machine State 3   */
> +#define PPE42_ISR_EP      PPC_BIT_NR(53) /* MSR[EE] Maskable Event Pending    */
> +#define PPE42_ISR_PTR     PPC_BIT_NR(56) /* Program Interrupt from trap       */
> +#define PPE42_ISR_ST      PPC_BIT_NR(57) /* Data Interrupt caused by store    */
> +#define PPE42_ISR_MFE     PPC_BIT_NR(60) /* Multiple Fault Error              */
> +#define PPE42_ISR_MCS0    PPC_BIT_NR(61) /* Machine Check Status bit0         */
> +#define PPE42_ISR_MCS1    PPC_BIT_NR(62) /* Machine Check Status bit1         */
> +#define PPE42_ISR_MCS2    PPC_BIT_NR(63) /* Machine Check Status bit2         */
> +FIELD(PPE42_ISR, SRSMS, PPE42_ISR_SRSMS3, 4)
> +FIELD(PPE42_ISR, MCS, PPE42_ISR_MCS2, 3)
> +
> +/* PPE42 Machine Check Status field values */
> +#define PPE42_ISR_MCS_INSTRUCTION             0
> +#define PPE42_ISR_MCS_DATA_LOAD               1
> +#define PPE42_ISR_MCS_DATA_PRECISE_STORE      2
> +#define PPE42_ISR_MCS_DATA_IMPRECISE_STORE    3
> +#define PPE42_ISR_MCS_PROGRAM                 4
> +#define PPE42_ISR_MCS_ISI                     5
> +#define PPE42_ISR_MCS_ALIGNMENT               6
> +#define PPE42_ISR_MCS_DSI                     7
> +
>   /* Transaction EXception And Summary Register bits                           */
>   #define TEXASR_FAILURE_PERSISTENT                (63 - 7)
>   #define TEXASR_DISALLOWED                        (63 - 8)

