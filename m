Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD288C5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 16:50:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuYch-0001To-2s; Thu, 13 Aug 2026 12:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikhilks@linux.ibm.com>)
 id 1wuYcf-0001Oz-DT
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 12:49:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikhilks@linux.ibm.com>)
 id 1wuYcd-0006Ak-Qf
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 12:49:41 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67DFX55D1630294
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 16:49:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=aMEWLm
 Of778SdfE1swPDjq29xHKrYZZXxwjFZ16z7do=; b=lSfqOZBbv+9egOPrwGBgqS
 AaGwbwqhd0Y3fdKPlUtaife1u8vNhZY9IPFTuv6UyOJNJNbRG/hnmD6K66GBXqFM
 8e93Mhh9ZNcHAipxi4JTSbsHae3UiIjA3MNDfQlDduF+eqVoYTQ5P0jfWB6Yq7QL
 nf+hR8Rbw6ZqIAqUuzU2NSyWDpshuY1yXmXF2495Z9ng+L+wUD1Qd9Ch+o8ZPpDZ
 n7gmPlO5TzfXZpFsdgUX72QlwuKtykhpBOLcrJGaINQUqHJBdiroi6/ZuKV8Fo++
 JXyyFXmyayBbnQ0II01S74Xe6Ym+TgdkIE1kDnP4hrr+pBxwiGtbxQWnffuYa6KA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb2419rh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 16:49:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67DGfOFt022867
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 16:49:37 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsk3t8b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 16:49:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67DGnZYB42467662
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 16:49:35 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6FF642004B
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 16:49:35 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E4FC020040
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 16:49:34 +0000 (GMT)
Received: from [9.43.103.247] (unknown [9.43.103.247])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 16:49:34 +0000 (GMT)
Message-ID: <5ae721cc-d0d7-4cdd-9312-73a6fd6eaaa0@linux.ibm.com>
Date: Thu, 13 Aug 2026 22:19:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] ppc/spapr: Advertise RTAS error injection call
 support via FDT property
To: qemu-devel@nongnu.org
References: <20260520095446.64206-1-nnmlinux@linux.ibm.com>
 <20260520095446.64206-5-nnmlinux@linux.ibm.com>
Content-Language: en-US
From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
In-Reply-To: <20260520095446.64206-5-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7df5a2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=3ec0P_QH1TykPd80vQYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDExOSBTYWx0ZWRfXzkWAY8f/H/1q
 7ZclvJx/6jS4Nz+UmFM3FziIiuBEoeueuKzauZmumj0z4spJgxm7YR44Oqw0YI9MVZ5+bFTPgTq
 S8eDE13xAIHP9y3+xBbjS4MHj9E+qjnXU4N0k7KbXl7QSbV325TssmPufSbHaEp43juyPXkM3OQ
 0l2V3MKu76/N0d4O3Z01tUXYXEp3t+hIvvdaF1BsW5YcFiREN7jSKeH5pejnYy9V3tDEEIp6QKi
 c/WBq/1YVOZND4IoOVdvTfnQWwlQBagfwDL8IDCVw3Q6gfgh4GBkTkRnz2h9/tqR59dCfp5giiG
 y7DknHvrUKYfvACtxCAjH6Yef4dKif1adJzJJ5ShFNdiLQWgwG+TyQ1mGiWgJ2uGFkV/KK4tSX/
 rneigBEtJ8lOanj8URTnCX7hU1B27DMyGsWrrSpCZpOYA/3jnLbsif+IHvlST8Et4ugCVaSQsla
 veaCYiydIzQiKx9PyJw==
X-Proofpoint-ORIG-GUID: CXB-pCrAJCWkMHossnerqMa5XTqJmqiX
X-Proofpoint-GUID: CXB-pCrAJCWkMHossnerqMa5XTqJmqiX
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDExOSBTYWx0ZWRfX3+J9JOqX1RGb
 5d+BBPzhvQXAKj+Ka2g1yUKufBy64DMTLGCgF5YnMUK9tkSABKxBi01ut/2njXbxsEia7ZXpFMG
 in6fUK3ltY8hKRObsYoV8g5hzFodHiQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130119
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=nikhilks@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 20/05/26 15:24, Narayana Murty N wrote:
>   static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
>   {
>       MachineState *ms = MACHINE(spapr);
>       int rtas;
> +    size_t size_tokens = 0;
> +    g_autofree char *errinject_tokens;


Hi Narayana,

It would be safer to initialize `errinject_tokens` to `NULL`:
     g_autofree char *errinject_tokens = NULL;

Thanks
~ Nikhil

