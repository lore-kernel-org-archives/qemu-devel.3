Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE58D0D178
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 22:41:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdcDG-000815-FH; Wed, 07 Jan 2026 17:41:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1vdcDE-0007ro-Mn; Wed, 07 Jan 2026 17:41:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1vdcDA-000520-El; Wed, 07 Jan 2026 17:41:08 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 607ILnpP011316;
 Wed, 7 Jan 2026 22:41:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=IighSi
 2Y01/+R9IxddofvkM8PuqsaY7Za2lwHOVUjQc=; b=N/cGWE8uTWW2vYXX5prQ2B
 xWWMXo5vogmwNmyT/o06HMhIyL+bWMrbG8u1wzft1FCFweZ+7wwmuoj6ujY66D0g
 Op4ifzLg+RP660DU+pq0zArQSSnR5wXB9Pcf6iGIH0Mshx9yx+UVJS0VrlZuC05k
 9pvZVJZukldmN2/pRAQ29IT5hl/mMYdaW4yOtlq+ZNxJxRZumQMWg2l2YWUwmcRS
 ERQzPrs4JKfuqC98ax34jfj5UntR/ZoJxDqV2J0EggZjpWSZ4jVr869J9xstMx1D
 Z460emHruKEddDLe3gXq/nLXw2KlP2AAlaKY1cVSOGarzFBGOQv8WnxtSO0b3i2Q
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4berhkagy5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Jan 2026 22:41:02 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 607LH8GS012568;
 Wed, 7 Jan 2026 22:41:01 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bffnjkmxh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Jan 2026 22:41:01 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 607Mf00x30147192
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 Jan 2026 22:41:00 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 23C3358055;
 Wed,  7 Jan 2026 22:41:00 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7D3075804B;
 Wed,  7 Jan 2026 22:40:58 +0000 (GMT)
Received: from [9.12.68.85] (unknown [9.12.68.85])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Wed,  7 Jan 2026 22:40:58 +0000 (GMT)
Message-ID: <865377a5-5b82-425e-a564-62f26ebbcdb2@linux.ibm.com>
Date: Wed, 7 Jan 2026 17:40:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/29] s390x/diag: Introduce DIAG 320 for Certificate
 Store Facility
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20251208213247.702569-1-zycai@linux.ibm.com>
 <20251208213247.702569-6-zycai@linux.ibm.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <20251208213247.702569-6-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=P4s3RyAu c=1 sm=1 tr=0 ts=695ee0fe cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=9sbbnPnA3YTnYZ4fKE8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: tyekEp5zESVgSovMPQVtWuqStUsfO2ct
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDE3NyBTYWx0ZWRfX8UqpU2u18dYi
 FId8oqrwY2MJxmCgVYtQzqlMTqI4Fiu814gKZjFco+plRk4pGg4oL81A0zTfYQGHmrMKLn1EcVc
 d9UOQklxprKYYl4N5eWakNHREq1ww8RBbDjoJIVVoD4qKm/ExAaxF90Hjz7VvoUNw/ggn3QstD1
 ocq/pvBrjKFnH5nIKQyEfg4kUZagBnCQ4gjst4zKS4VZcIyT/uFojbggYF+eada8dRm6Z86vjPQ
 QYPGbVqPDt5V+2Q5edh6UspGPfU1tabpiR+ILxc6eMCd4s88ZON7H449yVt0bO5yR+MzFkHoKit
 oPne4F1dVR4NDnR6xmG93TjnmqKnahlXp6XKIsxkCUUAtagMnwi7E8fH0a8qu4rTMCszimh817Q
 Sn8ahDu6Gy5TLzpCObz7pHpx9EjLAI6Zc2hgJxRMLyOEW7wUFci8xUvHgN+uclMWb4fvId+i22e
 LkUDarNUNnEkAZnYNWA==
X-Proofpoint-GUID: tyekEp5zESVgSovMPQVtWuqStUsfO2ct
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_04,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601070177
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
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

On 12/8/25 16:32, Zhuoying Cai wrote:
> DIAGNOSE 320 is introduced to support Certificate Store (CS)
> Facility, which includes operations such as query certificate
> storage information and provide certificates in the certificate
> store.
> 
> Currently, only subcode 0 is supported with this patch, which is
> used to query the Installed Subcodes Mask (ISM).
> 
> This subcode is only supported when the CS facility is enabled.
> 
> Availability of CS facility is determined by byte 134 bit 5 of the
> SCLP Read Info block. Byte 134's facilities cannot be represented
> without the availability of the extended-length-SCCB, so add it as
> a check for consistency.
> 
> Note: secure IPL is not available for Secure Execution (SE) guests,
> as their images are already integrity protected, and an additional
> protection of the kernel by secure IPL is not necessary.
> 
> This feature is available starting with the gen16 CPU model.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Reviewed-by: Collin Walling <walling@linux.ibm.com>
> Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
> ---

[...]

> +
> +void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
> +{
> +    S390CPU *cpu = env_archcpu(env);
> +    uint64_t subcode = env->regs[r3];
> +    uint64_t addr = env->regs[r1];
> +
> +    if (env->psw.mask & PSW_MASK_PSTATE) {
> +        s390_program_interrupt(env, PGM_PRIVILEGED, ra);
> +        return;
> +    }
> +
> +    if (!s390_has_feat(S390_FEAT_CERT_STORE)) {
> +        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> +        return;
> +    }
> +
> +    if ((subcode & ~0x000ffULL) || (r1 & 1)) {
> +        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> +        return;
> +    }
> +

Nit: merge the above two ifs since they both have the same output.

This does not bar my r-b, but wanted to make note of it.

-- 
Regards,
  Collin

