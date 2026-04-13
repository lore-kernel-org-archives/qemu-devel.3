Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2438CF531CE
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 23:08:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCQNl-0007nG-W6; Mon, 13 Apr 2026 19:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1wCQNk-0007mm-3v; Mon, 13 Apr 2026 19:07:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1wCQNi-0006KR-DL; Mon, 13 Apr 2026 19:07:51 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63DLIxaq1843616; Mon, 13 Apr 2026 23:07:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=iTWxKK
 mfzi7v7uLCrt6Sy51SBagZ3krmGK+V4aq+yno=; b=LLoU0WYTcB78MuljAtWFM/
 AC/CGCV27CmX4zZ7wcMG+9hF8o937GspnJoANKxnjR0qIOEp/quQGTG233fWlRQM
 oIK9X5POS5I9Ug0jVcnkl6+j7cdd65MlTt0TJ+64T+OPXrqMm84rlAbY8xgRHhAS
 3/d1ThYJUDV9hQlD9A4mbXSQDKHw2z36wm54aCAjVJ1W2n6hW2/zxqzqJTLRYFyC
 s0UF/nwb6hWS90wtUpANTWQAXRdV+uR+DzNQpQxi6CGAzpYdfQ4MmLXLc/VDlHlT
 xJpaVdc8bZDh1jrM2IVDEsOXVR1XyQFjHOz/woK7eV0FD53Vd3m3PwYWw84pEzVw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89mg8r6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Apr 2026 23:07:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63DM0IZo003514;
 Mon, 13 Apr 2026 23:07:44 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg1mn75tg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Apr 2026 23:07:44 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63DN7hpI13763096
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Apr 2026 23:07:43 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 208C758074;
 Mon, 13 Apr 2026 23:07:43 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B76655806E;
 Mon, 13 Apr 2026 23:07:41 +0000 (GMT)
Received: from [9.61.251.241] (unknown [9.61.251.241])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 13 Apr 2026 23:07:41 +0000 (GMT)
Message-ID: <a5acb8ad-7bb0-4bf2-99a7-e6908325e1af@linux.ibm.com>
Date: Mon, 13 Apr 2026 19:07:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 19/30] pc-bios/s390-ccw: Add signature verification
 for secure IPL in audit mode
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, pierrick.bouvier@linaro.org,
 david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com
References: <20260402221453.1602899-1-zycai@linux.ibm.com>
 <20260402221453.1602899-20-zycai@linux.ibm.com>
Content-Language: en-US
From: Joshua Daley <jdaley@linux.ibm.com>
In-Reply-To: <20260402221453.1602899-20-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDIyNCBTYWx0ZWRfX4fe3Oyl8jgdl
 uTeMCp/YvxV3opP0DYkPO67jcJdqVLZCEv6bLifpIzQEJ1VOivk1o8tYv9LZkOXinvIw9Z72iQd
 9xk58TQ/zCQUQYcqXagEiUNdoFra6D3XlgknVsEDkhfrg6DPBpyN39lkjCh2ac6VSQ97s4eQWK3
 yqpG4LaUMMvp/meCgPtHoFG0WCwBd+nQejRgvsqoWUqdaUlZQ783WLEC4YUxdkuh/luSYpWHId+
 szdybYTS/XXn9Jy4QFnRuS4OfH/mVfd58kQI3V5kZt+ThBORAWEuxP1gcqc3ZQlJVvSIimDxGHK
 gQ5WxqJttSWGoA1OvrGFybV1EWYhl0I2LWLTfzikKg9UyXm62zsFxOQEVn2cuVCdq4wwAfhr5qZ
 WB/rUvM5+Lri+c+ruIoYO1V1gl6Wv6KxRfN4BzT/eMGnkdTnthmyLjU0kjxqd4W0+DRaTFRBWBS
 vCj2W7+17TXOScIOiiQ==
X-Authority-Analysis: v=2.4 cv=eJ4jSnp1 c=1 sm=1 tr=0 ts=69dd7741 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=_dQeQU3nbEALQTGVxrIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: az4DjVZvVNJFQei57m-CRBzVvqEyWCF-
X-Proofpoint-ORIG-GUID: az4DjVZvVNJFQei57m-CRBzVvqEyWCF-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604130224
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jdaley@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On 4/2/2026 6:14 PM, Zhuoying Cai wrote:
> Enable secure IPL in audit mode, which performs signature verification,
> but any error does not terminate the boot process. Only warnings will be
> logged to the console instead.
> 
> Add a comp_len variable to store the length of a segment in
> zipl_load_segment. comp_len variable is necessary to store the
> calculated segment length and is used during signature verification.
> Return the length on success, or a negative return code on failure.
> 
> Secure IPL in audit mode requires at least one certificate provided in
> the key store along with necessary facilities (Secure IPL Facility,
> Certificate Store Facility and secure IPL extension support).
> 
> Note: Secure IPL in audit mode is implemented for the SCSI scheme of
> virtio-blk/virtio-scsi devices.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   docs/system/s390x/secure-ipl.rst |  35 +++
>   pc-bios/s390-ccw/Makefile        |   2 +-
>   pc-bios/s390-ccw/bootmap.c       |  36 +++-
>   pc-bios/s390-ccw/bootmap.h       |  11 +
>   pc-bios/s390-ccw/main.c          |   6 +
>   pc-bios/s390-ccw/s390-ccw.h      |  27 +++
>   pc-bios/s390-ccw/sclp.c          |  37 ++++
>   pc-bios/s390-ccw/sclp.h          |   6 +
>   pc-bios/s390-ccw/secure-ipl.c    | 359 +++++++++++++++++++++++++++++++
>   pc-bios/s390-ccw/secure-ipl.h    | 110 ++++++++++
>   10 files changed, 626 insertions(+), 3 deletions(-)
>   create mode 100644 pc-bios/s390-ccw/secure-ipl.c
>   create mode 100644 pc-bios/s390-ccw/secure-ipl.h
> 
> diff --git a/docs/system/s390x/secure-ipl.rst b/docs/system/s390x/secure-ipl.rst
> index 0a02f171b4..3a19b72085 100644
> --- a/docs/system/s390x/secure-ipl.rst
> +++ b/docs/system/s390x/secure-ipl.rst
> @@ -18,3 +18,38 @@ Note: certificate files must have a .pem extension.
>   .. code-block:: shell
>   
>       qemu-system-s390x -machine s390-ccw-virtio,boot-certs.0.path=/.../qemu/certs,boot-certs.1.path=/another/path/cert.pem ...
> +
> +
> +IPL Modes
> +=========
> +Multiple IPL modes are available to differentiate between the various IPL
> +configurations. These modes are mutually exclusive and enabled based on the
> +``boot-certs`` option on the QEMU command line.
> +
Add a newline before this paragraph for consistency with the other sections. :)

> +Normal Mode
> +-----------
> +
> +The absence of certificates will attempt to IPL a guest without secure IPL
> +operations. No checks are performed, and no warnings/errors are reported.
> +This is the default mode.
> +
> +Configuration:
> +
> +.. code-block:: shell
> +
> +    qemu-system-s390x -machine s390-ccw-virtio ...
> +

