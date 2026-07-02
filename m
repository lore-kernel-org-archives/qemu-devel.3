Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39263C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 03:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf7lH-0002Jf-CS; Wed, 01 Jul 2026 23:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wf7lA-0002J4-V5; Wed, 01 Jul 2026 23:06:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wf7l9-0007Pb-7W; Wed, 01 Jul 2026 23:06:40 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6621L6X62451719; Thu, 2 Jul 2026 03:06:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=05avRo
 DrnWugvQBjOh1HNCi8dSZF31FzFVUB0x8aGKk=; b=V5q2rW2eN4O+Tw06pswUlA
 bWQ+4RDi3Ga2ji3e3RS6OMuUbY2XOdC/N7vB6BWHCLm5NfZknEu3w2GIUbUmWhre
 ygCd+OL/wQJ9jcssnbH25RAgVu5Ihbv88hheJ6fqvZui4ZWdmGcANbg/rpelvrdw
 xwGq34g4sMUMx9s/zA/9f403SMxenSxQ4AlP/bs/mB2pkT+GffAv1IofelGijgpg
 XKvMZ9yNvQnEF7YgzExI/5HCsWAuMZrcDPExiygpwE+zDZCoI8Amn3rYS1k0FhRd
 3gKNvTGJpnA1/Q7l/X0mzI0rhL6yCw40vdTSWF/127gBJTkBxPrO6n86XRQPwzog
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n5ytrt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 03:06:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66234rCR024437;
 Thu, 2 Jul 2026 03:06:33 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2gj1ch-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 03:06:33 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66236WuP55116164
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Jul 2026 03:06:32 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 56A5058043;
 Thu,  2 Jul 2026 03:06:32 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6A3F458053;
 Thu,  2 Jul 2026 03:06:30 +0000 (GMT)
Received: from [9.61.65.1] (unknown [9.61.65.1])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Jul 2026 03:06:30 +0000 (GMT)
Message-ID: <1622a0a2-9aed-4d5c-b5c4-a488d20e16b5@linux.ibm.com>
Date: Wed, 1 Jul 2026 23:06:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 35/35] docs/system/s390x: Add secure IPL documentation
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260701204922.1320349-1-zycai@linux.ibm.com>
 <20260701204922.1320349-36-zycai@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260701204922.1320349-36-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAyNiBTYWx0ZWRfX9hjD5OCf/gke
 9KrifbiU51lcxEZHBsX/nTlXRS+yxoWz4v28ZMBihqJ2UZVBTEmSp8Lq4k35HhXRYSrX62NkLI6
 4qttOSGM4fNccEWH5ZrIorzTIeR1ag0Q76A/GXm1E7ur5hRTYoCdV7R5meMPr/o27kHRxFhG5Ni
 npG1wdk4F4VavZC5HVmLEIIOuULH3/ilAAqiSTnu0ZkcAeTiAUVOrIEmFd3kz4PFuIBvJdPsQxU
 cfnqGJCdyFOiPYD3VPGVuqzn7Tr9yZQpBgz60qGmfmZpkxzx7c1aRyQVF+BQBhrniVQZGAL4MhD
 zyKcIK10kmNv2SzxYO2nU2Ei9ty4k8Sl11soGl6rD073U7a34E19L4K+itqzrbGSEwuT/Pl7kfR
 XdcgKNVwABdpPNIA+ScigSI4jFMi0oc7RtkHfBCeV05HsHApVGHRXLIpGVp4JsCtwQ9XUQtxICQ
 cPNXEgpg3R7xIkSIefQ==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a45d5ba cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=q5T4S90kAAAA:8 a=ZDNXcwnr0mxCMg5SBeIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=LnBBZQxPVJ0Z7KJyRdxh:22
X-Proofpoint-ORIG-GUID: bdqfJ16ZkJvm3jfykRbzTrJ-2Ye2TF1c
X-Proofpoint-GUID: bdqfJ16ZkJvm3jfykRbzTrJ-2Ye2TF1c
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAyNiBTYWx0ZWRfX5FlntDlCHZny
 iPGOUSXKy4vhuqY1yKmeiGb/cFtTSio7zCJcmMUFKOTcmnu07h72Ld95csW+1vqEKYnM9uf1fsF
 U6M6E9kGv+taKlth+QTObwF0NtVhSCw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020026
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 7/1/26 4:49 PM, Zhuoying Cai wrote:
> Add documentation for secure IPL
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Reviewed-by: Joshua Daley <jdaley@linux.ibm.com>
> ---

...

> +Constraints
> +-----------
> +
> +The following constraints apply when attempting to boot an s390x guest in secure
> +mode:
> +
> +- z16 or "qemu" CPU model
> +- certificates must be in X.509 PEM format
> +- only support for SCSI scheme of virtio-blk/virtio-scsi devices
> +- a boot device must be specified
> +- any unsupported devices (e.g., ECKD and VFIO) or non-eligible devices (e.g.,
> +  network) will cause the entire boot process terminating early with an error

to terminate early, with an...

> +  logged to the console.
> +
> +
> +Secure IPL Quickstart
> +---------------------
> +
> +Build QEMU with gnutls enabled
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +.. code-block:: shell
> +
> +    ./configure … --enable-gnutls
> +
> +Generate certificate (e.g. via certtool)
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +A private key is required before generating a certificate. This key must be kept
> +secure and confidential.
> +
> +Use an RSA private key for signing.
> +
> +.. code-block:: shell
> +
> +    certtool --generate-privkey > key.pem
> +
> +A self-signed certificate requires the organization name. Use the ``cert.info``
> +template to pre-fill values and avoid interactive prompts from certtool.
> +
> +.. code-block:: shell
> +
> +    cat > cert.info <<EOF
> +    cn = "My Name"
> +    expiration_days = 36500

Maybe the example should be more realistic, like 365 days?

With those changes (reminder, check for 80 columns):

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

