Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00304D1A61D
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 13:31:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veCa8-00046Z-4z; Fri, 09 Jan 2026 08:31:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1veCa0-00044n-Ld; Fri, 09 Jan 2026 08:31:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1veCZx-0001w7-LN; Fri, 09 Jan 2026 08:31:04 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 608Le8cD024133;
 Fri, 9 Jan 2026 13:30:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:sender:subject:to; s=pp1; bh=Z473VuK09/6ZCuNeUOUMJD/
 QKcCLw4ICuF6kgtegzGU=; b=VVVlXh7x7Po3OAs3G7IPlC96dlMylhDj8ZytRFQ
 mvnBrLOYN7QzFJCoFdm6yTvEcSxsomsxk9liYsZUxI5tyAzHrempGRApCgHVUsPj
 jQF2yFc1wM0iprt1zWdMCZN1Gecp0/kOHHKxRi33pWTfg+GWJecqnf4DJ5af9yVM
 1XqpMpZbhg00L2VdeBqiRYgob/9Xn2vt5Ti2kbPC0srkDEEtqm8iTfmumXVy3uEk
 FsiRTa+t0cvBl3EcSuxWPlu2u4t9AqJr1JkbCTV53bj2uD91Dx2VmV6SZcgPMIKO
 EEkDXD/UCFmogR/ba3+7FQJTXloQwswVUyp/HHSGyxN/1UQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betu6kerh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Jan 2026 13:30:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 609BE9B3019341;
 Fri, 9 Jan 2026 13:30:56 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bfg51mqra-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Jan 2026 13:30:56 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 609DUqxM34603422
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 9 Jan 2026 13:30:52 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5BBDA2004E;
 Fri,  9 Jan 2026 13:30:52 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 416922004D;
 Fri,  9 Jan 2026 13:30:52 +0000 (GMT)
Received: from vela (unknown [9.111.82.184])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri,  9 Jan 2026 13:30:52 +0000 (GMT)
Received: from brueckner by vela with local (Exim 4.99)
 (envelope-from <brueckner@linux.ibm.com>) id 1veCZn-00000000H1C-2nXQ;
 Fri, 09 Jan 2026 14:30:51 +0100
Date: Fri, 9 Jan 2026 14:30:51 +0100
From: Hendrik Brueckner <brueckner@linux.ibm.com>
To: Zhuoying Cai <zycai@linux.ibm.com>
Cc: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, brueckner@linux.ibm.com, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
Subject: Re: [PATCH v7 06/29] s390x/diag: Refactor address validation check
 from diag308_parm_check
Message-ID: <aWEDC7pIILszKpdC@linux.ibm.com>
References: <20251208213247.702569-1-zycai@linux.ibm.com>
 <20251208213247.702569-7-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208213247.702569-7-zycai@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QbNrf8bv c=1 sm=1 tr=0 ts=69610311 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=P_NoP72qeY4FxnBEVQMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: k7u2GVsLqrbIBsiQOJKJboLz_p1Dxihg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA5OSBTYWx0ZWRfX9krhlgTNsXWd
 Sjz2etlh65d1x3QglZ1b2+apcY02CT31YqnaCs1cvtd8rZ9R+YjsR2bCF5udtFAKL5DU+LtdaO/
 /Zr0Cwzc5Uc3ccU7ElqZKaz7l+Dd5LO8ozfWd9C8dcnmlJdzWSb0G0Zdmj2+pWZwRJjLLG9ctPF
 v6lgZYo9zOoPO+C4iYHdFLpiJ3SnM4Ch9AzHiihafl8dQdqIKuO9d3YSSh/YWtERjmY3d0HS8QH
 n+PAOcRx0m2hI1dYc78xKbUs/xA20lG4emLA6to49DnPpAaOrDTLWsTSKEtdG9+yZu2UBm0M6Jq
 +FbCc8n1OmC184KBtBOKcxWj7O//FQvtQryTLUbXYr3h/aZhYd59H5StCwqaku0Txj2ctuiOAGY
 NSi0AjjF65qJRu56Z1KGAtiwMsrGYonGUQ0nB7cRozNBIMKPVDzmdIN9y1rmzD0AKbDluKprjux
 M5fzea5qDYdlCL3BBwg==
X-Proofpoint-GUID: k7u2GVsLqrbIBsiQOJKJboLz_p1Dxihg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_04,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601090099
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=brueckner@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On Mon, Dec 08, 2025 at 04:32:23PM -0500, Zhuoying Cai wrote:
> Create a function to validate the address parameter of DIAGNOSE.
> 
> Refactor the function for reuse in the next patch, which allows address
> validation in read or write operation of DIAGNOSE.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  target/s390x/diag.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index a35d808fd7..a347be7633 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -26,6 +26,12 @@
>  #include "qemu/error-report.h"
>  
>  
> +static inline bool diag_parm_addr_valid(uint64_t addr, size_t size, bool write)
> +{
> +    return address_space_access_valid(&address_space_memory, addr,
> +                                      size, write, MEMTXATTRS_UNSPECIFIED);
> +}
> +
>  int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3)
>  {
>      uint64_t func = env->regs[r1];
> @@ -65,9 +71,7 @@ static int diag308_parm_check(CPUS390XState *env, uint64_t r1, uint64_t addr,
>          s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>          return -1;
>      }
> -    if (!address_space_access_valid(&address_space_memory, addr,
> -                                    sizeof(IplParameterBlock), write,
> -                                    MEMTXATTRS_UNSPECIFIED)) {
> +    if (!diag_parm_addr_valid(addr, sizeof(IplParameterBlock), write)) {
>          s390_program_interrupt(env, PGM_ADDRESSING, ra);
>          return -1;
>      }

Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>

