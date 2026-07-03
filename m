Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A29BC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 13:24:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfdsa-0002mb-S9; Fri, 03 Jul 2026 09:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wfdsY-0002lx-2h; Fri, 03 Jul 2026 09:24:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wfdsW-0002ly-JW; Fri, 03 Jul 2026 09:24:25 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6636IXKQ1761319; Fri, 3 Jul 2026 13:24:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Z2trtg
 qGl4UHz1wgFGntqw+u9PlPLMIA6z0MifvqRsQ=; b=rfCqlkYPCXmAMFZIQJtuVJ
 XRsQzqcw664PH1/5ZSncVk0nuNp99CNhYh2d4dDtjA/xkbpUJp4rHTrqQnkW21xn
 Z4EVlrUhyM5TJCoPWdaWTAwHQZ/PBAyLXHHCSveCJCOBQ5G7zCVHC+uCKhZNEEZe
 nxsJAhpsKGnWwilstvOxiwd5xB301kjQcaXSXBWqKxysTma8DXLI6mF8nNx9uQI6
 oojH6tysMp+Nvumktm3viuEOKTu2DnvTaCGFKSXAx1MB0xjF4o3qLenziCwoL3hB
 e1xEFvGJBhv73vheoqwy0ByHp0lYH4iCs02YYxBqXQT9BQu4wKwE9KXNh4iviuXQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mk70jg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 13:24:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 663DJcs8010125;
 Fri, 3 Jul 2026 13:24:18 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhyrsvs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 13:24:18 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 663DOHwt16908994
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jul 2026 13:24:17 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7A61258054;
 Fri,  3 Jul 2026 13:24:17 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9CD295803F;
 Fri,  3 Jul 2026 13:24:15 +0000 (GMT)
Received: from [9.61.65.1] (unknown [9.61.65.1])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jul 2026 13:24:15 +0000 (GMT)
Message-ID: <f851d058-0d86-4ce1-936d-642cecd57552@linux.ibm.com>
Date: Fri, 3 Jul 2026 09:24:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 01/33] Add boot-certs to s390-ccw-virtio machine type
 option
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260703022933.1805010-1-zycai@linux.ibm.com>
 <20260703022933.1805010-2-zycai@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260703022933.1805010-2-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEzMSBTYWx0ZWRfXy7R4gyRSeQVu
 ZoxWDJc8WHcEf2r1DsdoDcXT5Efd58EKFwX82Y9ehPGSlCDwvFYgYO5xf6yioZdVmY4WkaCfTuo
 fcM/rQ1YOq/2jg/vg1Gkzl3mDV0UaOSCvDaRpcZvCPlkB9cFPbKbarUV+ng0ajaXM7QKkcbDfB3
 sJXqxfm3bRYx5in4zeQLqhLKyNXWa0mv26xGo8FEUPX3rbg/7WuSFwDpiQeZjzF7BQrQcOimeSV
 K3EhiUl81tlpcUgInfuiOZ5Qn5aYGlwYJunGocZIHror8TreAD54Q684Rt+AwFWY4GAXHXrybH0
 opgoyebg+vAUfUv8SELvx480CkUngoIqmccEFGZW1o/Q35d6jPNdIcqixsCELo5aR/Qk7AxN2wk
 qNsgM73kJ4ym1foT+ll60E0nDXgkxGWZTnxP3veAH3o5elNJ9jewZbiA5leDiRX6vOMg3j3PBWC
 hHFq30+pTyxkUHK+yKA==
X-Proofpoint-GUID: X-Qdu8NzeC0oumclz0BI5plwC7-oa6uh
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a47b803 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=3DdCJpMjheTVoNFGPu8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEzMSBTYWx0ZWRfX7QYSN5UWC40y
 42Ay1j4m6QQ3AR+nBIqklu3U7HVaoiubaKbg44eusJeQmSIC/Z7YWaxwjVIC5ztCgHMiotPKLPw
 aNXk0JbX9KsVDHp1F9zDG0dEx2FHue0=
X-Proofpoint-ORIG-GUID: X-Qdu8NzeC0oumclz0BI5plwC7-oa6uh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030131
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 7/2/26 10:28 PM, Zhuoying Cai wrote:
> Introduce a new `boot-certs` machine type option for the s390-ccw-virtio
> machine. This allows users to specify one or more certificate file paths
> or directories to be used during secure boot.
> 
> Each entry is specified using the syntax:
> 	boot-certs.<index>.path=/path/to/cert.pem
> 
> Multiple paths can be specify using array properties:
> 	boot-certs.0.path=/path/to/cert.pem,
> 	boot-certs.1.path=/path/to/cert-dir,
> 	boot-certs.2.path=/path/to/another-dir...
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>

(re-sending because I accidentally dropped most of to/cc)

Verified that latest machine allows boot-cert and secure-boot
but both are fenced for older machines.

Thanks for fixing!

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

