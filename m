Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E49CA9EBB
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 21:10:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFHqx-0007T0-SO; Fri, 09 Oct 2026 17:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xFHqs-0007SM-2y; Fri, 09 Oct 2026 17:10:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xFHqq-00024D-H7; Fri, 09 Oct 2026 17:10:01 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699K5ZLG900329; Fri, 9 Oct 2026 21:09:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=LqjJ3l
 C1GVrPmJn9VUsyZc9E/VIVLiVcjiNk1hHO6wA=; b=mWtkDyRiXw7xWihIqgDxES
 5zfDDdXOKM3Pf80FmxmJ3wrEs0P7yQLX0UMdhFsFCSHdAgLMtAaWdD1gWhGIaHzB
 1up3YqsVxuh91ZWbnlJi10j2yiT8eZMzkofZuICriAZDX0UzH52LNt8E4sywjFV8
 t7N++XPurG/0tZaDzrKzLHXeSpyfwJ4yFXWXjvMRpnY8AW3iC4jhU3B5pab93dzV
 g3kuqlzB/AM4CvcZnPKXunoqSkDoADwwM3NrS+WYwJgUVpzzRCnuduSpino1g/pe
 h+oWawrE3uun5rCtEocUTRBczorlrD5pOVntJfBbz7YznOdxcPG8cHxtK5csicUg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h74tdgv62-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 21:09:56 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 699KI4mp1366875; Fri, 9 Oct 2026 21:09:56 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h5s352eb0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 21:09:56 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 699L9sS064291076
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 9 Oct 2026 21:09:54 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CA0205805A;
 Fri,  9 Oct 2026 21:09:54 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4193758054;
 Fri,  9 Oct 2026 21:09:53 +0000 (GMT)
Received: from [9.61.5.156] (unknown [9.61.5.156])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  9 Oct 2026 21:09:53 +0000 (GMT)
Message-ID: <d7892f64-bb8f-433c-a389-1ff5cb99b33c@linux.ibm.com>
Date: Fri, 9 Oct 2026 17:09:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] s390: mark features that depend on deprecated
 features as deprecated
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: Hendrik Brueckner <brueckner@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-stable@nongnu.org
References: <20261009185559.144750-1-walling@linux.ibm.com>
Content-Language: en-US
From: Eric Farman <farman@linux.ibm.com>
Autocrypt: addr=farman@linux.ibm.com; keydata=
 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
 y8m0x6unNti2MZIUMy0m2gcE
In-Reply-To: <20261009185559.144750-1-walling@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA4NCBTYWx0ZWRfX58VDDl/IF6oV
 z913dkr8S21badTzqWNo7gH0ckSnzYS1JHtY4CYhjTeZrD86Jy5NFkx89gKx1cQSbOW41jQCYUV
 2ov2QxcyXykHp7sX1rlvtehpD2nDgmuIDYU3X6Gq+kGmF8KENFiMcq1jnjz4Z47BC1Mi8MEWE4P
 uJvS3mJO+r2zpgPzi52E3cumfmPKL5atPSW4fHplRpy9EK2KSAtPWqd6Pb65SnbRXMymVaLy8e3
 j3zoE5oXFWDy608ChwbmQ1tYr7yGt6Yj5v83MWgWCqpv56cKyj2Kg+5WbreiWHlbZafs9KbBigY
 WgPLEZ+VdUk+jU+NNEfPmoU6tOPmV0WdNWD6BICZ8JifZc3xwJy7dXTzM1ufUfu2RWzifWBziRB
 be33jfPQBhtqheXCZwdqH5EI9L2iAgof4MW2QT0Idl7+GWA5/KgFVcez4+b+dpNjGywAAYVztYA
 KEO6hOtRDcAHSYW9kMA==
X-Authority-Analysis: v=2.4 cv=FqWQbGrq c=1 sm=1 tr=0 ts=6ac95824 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=iOi4lI3mKpNaXigUpt0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: pkpQYFwJ5QNMg7hNaI-yno9XPi-9n3eN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA4NCBTYWx0ZWRfX+1R7mIeaYnER
 QhoISaTWfGhWW3TURc7Fku8gfCwbv5gVf0vnyIOyfScQz1CkYj+ldBQGp+G7KZVpsv01a2opEB5
 H4ADd2uB9gG1IOOi4oWVC51l8a0RQVM=
X-Proofpoint-ORIG-GUID: pkpQYFwJ5QNMg7hNaI-yno9XPi-9n3eN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090084
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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



On 10/9/26 2:55 PM, Collin Walling wrote:
> Changelog:
>    v2
>      - updated loop structure to restart and check if previous dependencies
>         need to be accounted for
>      - added fixes tag to patch #2
> 
> Description:
> 
> When the CPU model deprecated-features work was completed in QEMU, features that
> have a dependency on a deprecated feature were not themselves marked deprecated.
> This patch series corrects that oversight.
> 
> Specifically, ineff_nc_tx depends on te, which has been deprecated. When a user
> starts a VM with deprecated features disabled, QEMU currently emits:
> 
>      warning: 'ineff_nc_tx' requires 'te'
> 
> With these patches, query-cpu-model-expansion includes ineff_nc_tx in the
> deprecated-props array alongside the other deprecated features:
> 
> {
>    "return": {
>      "deprecated-props": [
>        "ineff_nc_tx",
>        "bpb",
>        "te",
>        "cte",
>        "csske"
>      ],
>      "model": {
>        "name": "gen17a-base",
>        "props": { ... }
>      }
>    }
> }
> 
> libvirt uses this response to determine which features to disable when the
> deprecated_features=on|off attribute is set. With these patches, ineff_nc_tx
> will be disabled along with the other deprecated features. The result can be
> verified with virsh domcapabilities:
> 
> $ virsh domcapabilities --disable-deprecated-features \
>      --xpath "/domainCapabilities/cpu/mode[@name='host-model']/feature[@policy='disable']"
> <feature policy="disable" name="bpb"/>
> <feature policy="disable" name="csske"/>
> <feature policy="disable" name="cte"/>
> <feature policy="disable" name="ineff_nc_tx"/>
> <feature policy="disable" name="te"/>
> 
> Collin L. Walling (2):
>    target/s390x: externalize feat dependency array
>    target/s390x: mark feats dependent on deprecated feats as deprecated
> 
>   target/s390x/cpu_features.c | 139 ++++++++++++++++++++++++++++++++++++
>   target/s390x/cpu_features.h |   4 ++
>   target/s390x/cpu_models.c   | 133 ++--------------------------------
>   3 files changed, 148 insertions(+), 128 deletions(-)
> 

For the series:

Reviewed-by: Eric Farman <farman@linux.ibm.com>

I'll pick this up and toss it in our CI for a few days. Thank you!!


