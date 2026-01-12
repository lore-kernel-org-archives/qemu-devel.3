Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85918D26D97
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 09:59:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfEhY-0002F0-O8; Mon, 12 Jan 2026 04:59:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vfEhW-0002EZ-Cr
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 04:59:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vfEhU-0004uT-H2
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 04:59:06 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60BLHIYL012192;
 Mon, 12 Jan 2026 09:59:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=PAck7m
 0vH3L98o1j2Raeg0MyDjSdkH2WOd3JIKN3VLM=; b=L/vLBtz+yd0k7trzDMIcjC
 a+ekr/gulqO3nBRKWA2GO9VnfF9zyX/1adfGp10LIlQSY7tHjeoI91t1fQYaPERy
 vO+IridHmCm4uzQwHgGhkIDQIMK25dxTr9BG0EODkS8ilOV9MRxmBnK36cmYEqQr
 lb2k5dNwMb1a56SV7Eq55HtETYV8vdbKwOPYPwCI2+UJMnnaouXi/nQqL3/Zm545
 thK3lYEeDTRa/JMH12mInXfoM+fcXSzFEwSQNtnDKrNwK/1dL2aHhuxXwN/DoWsM
 xZlJC+u7/kj8HKJPu8Hr6pgqDF5VAeeyiadG7sPSMjI8oujAFR/d/495O600v84g
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkc6gxe69-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Jan 2026 09:59:00 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60C9x0Pt024342;
 Mon, 12 Jan 2026 09:59:00 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkc6gxe66-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Jan 2026 09:59:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60C7RrSm031245;
 Mon, 12 Jan 2026 09:58:59 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bm3t1cxq3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Jan 2026 09:58:59 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60C9wwKU23396972
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Jan 2026 09:58:59 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CD31B5804B;
 Mon, 12 Jan 2026 09:58:58 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EE39658063;
 Mon, 12 Jan 2026 09:58:55 +0000 (GMT)
Received: from [9.43.47.93] (unknown [9.43.47.93])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 12 Jan 2026 09:58:55 +0000 (GMT)
Message-ID: <b60bf0c8-d19f-4c61-8619-4bc947e6adaf@linux.ibm.com>
Date: Mon, 12 Jan 2026 15:28:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] target/ppc: Fix env->quiesced migration
Content-Language: en-GB
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, peterx@redhat.com, Fabian Vogt <fvogt@suse.de>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>
References: <20260109123519.28703-1-farosas@suse.de>
 <20260109123519.28703-2-farosas@suse.de>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260109123519.28703-2-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: D03i-kT0gROo1x1msuPpNUodCqCtSTGG
X-Proofpoint-ORIG-GUID: 00e8fzENNHb8PZwDpxwIFUKj_KzvreWM
X-Authority-Analysis: v=2.4 cv=TaibdBQh c=1 sm=1 tr=0 ts=6964c5e4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=p0WdMEafAAAA:8 a=VnNF1IyMAAAA:8
 a=IThRqtzJEr2E7FWt-b4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA3NyBTYWx0ZWRfXymRqernh29uu
 6bDrSfTZC0uBkbNEo288zzotZmeqa5NvLvoOLtG+JNYmIVeoUcdKPnyMh8gqThovCYzXAN6TRJF
 kfWn6CQ0JJR1b5eMTNfaV3ZaToU7eGXLTMBla5QxuHWKmBBhObvV1ZSp4ECVfsH6rT/GFjMNcGu
 tRKjLvvLh54lV/mHK6gHbyuCfACDs5Y8xSf13v5pEsY3K+INGCgx+0YeB9f81eDO+U6L4z7Kar3
 9kfY2oK+6b6jCXWfY9Cz443in4ywDIhNkxDuRZn7hHPQl455R0F5ew0P/dIq879bQ34S6yO/fLe
 Ho/VJMDFxnNU6wLhAWG5QV3lHKpkD3gSgYr+NuFDM2Kx2rcfmtvV1KhZaMWkoG7skSr0uQzc1Cb
 371VW5EU6FlkgRLzb9JwaN8q2f6RAqwIr6Riu0vtWUK8YVxILRNMRzEe/SGsDqguCa4HrpJzlwT
 RVJfph4YRbZA5X3M5Tg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601120077
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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



On 09/01/26 6:05 pm, Fabiano Rosas wrote:
> The commit referenced (from QEMU 10.0) has changed the way the pseries
> machine marks a cpu as quiesced. Previously, the cpu->halted value
> from QEMU common cpu code was (incorrectly) used. With the fix, the
> env->quiesced variable starts being used, which improves on the
> original situation, but also causes a side effect after migration:
> 
> The env->quiesced is set at reset and never migrated, which causes the
> destination QEMU to stop delivering interrupts and hang the machine.
> 
> To fix the issue from this point on, start migrating the env->quiesced
> value.
> 
> For QEMU versions < 10.0, sending the new element on the stream would
> cause migration to be aborted, so add the appropriate compatibility
> property to omit the new subsection.
> 
> Independently of this patch, all migrations from QEMU versions < 10.0
> would result in a hang since the older QEMU never migrates
> env->quiesced. This is bad because it leaves machines already running
> on the old QEMU without a migration path into newer versions.
> 
> As a workaround, use a few heuristics to infer the new value of
> env->quiesced based on cpu->halted, LPCR and PSSCR bits that are
> usually set/cleared along with quiesced.
> 
> Note that this was tested with -cpu power9 and -machine ic-mode=xive
> due to another bug affecting migration of XICS guests. Tested both
> forward and backward migration and savevm/loadvm from 9.2 and 10.0.
> 
> Also tested loadvm of a savevm image that contains a mix of cpus both
> halted and not halted.
> 
> Reported-by: Fabian Vogt<fvogt@suse.de>
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/3079
> Fixes: fb802acdc8b ("ppc/spapr: Fix RTAS stopped state")
> Signed-off-by: Fabiano Rosas<farosas@suse.de>

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

and Queued.

