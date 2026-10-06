Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00FE2CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMtF-0000SR-NP; Wed, 07 Oct 2026 04:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xEHRA-00043m-Qy; Tue, 06 Oct 2026 22:31:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xEHR2-0000gX-K6; Tue, 06 Oct 2026 22:31:16 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 696EZZTE2778136; Tue, 6 Oct 2026 16:48:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=qeXaJt
 vJosRtWBEtX92Ye/KJV8yhw2OJWzrSY3Qqhug=; b=BZvNSzh1okuVdRarWRePuI
 A5EI3QBhMZEFOhftlS3ZQhKf7XdD5e0T4ruCMtyPyFXgMvkuMvZZPI6cnJKfsoXu
 AgZNUPzT2UPY83cIeoZue3pmaAkzKkR8OiE9KdoU00MvOcxa3kH5r5EhtVFZ3QHD
 oo9Dqxo8AX2t7cPbxdlW0Qi9FTYJ89wAvIef8e84Q8oYWbBJmT5/FDaAR2T0QEAI
 Y0Ly9fUbTFy2te41gmKwVEa2SWJzjbHj+aPlFru4zJjQvI2aCUZltJj3ffgurvGY
 uLIc/ZMkmyoePXF1Z/mOqBvdlcBS1WyIe6oZhXdv7xft9pGAWOvvvbfRywbcTc8Q
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2r4g0cs0-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 16:48:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 696EHTdH424953; Tue, 6 Oct 2026 16:48:41 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3eqyajap-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 16:48:41 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 696GmdBU34144816
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Oct 2026 16:48:39 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 98D6058059;
 Tue,  6 Oct 2026 16:48:39 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 874A958055;
 Tue,  6 Oct 2026 16:48:38 +0000 (GMT)
Received: from [9.61.15.56] (unknown [9.61.15.56])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Oct 2026 16:48:38 +0000 (GMT)
Message-ID: <50bca01c-e4aa-42ae-adc6-04e0b425d56d@linux.ibm.com>
Date: Tue, 6 Oct 2026 12:48:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 15/17] s390x/pci: Provide each zpci device with a
 unique stable bus "path"
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20261006001643.420929-1-kshk@linux.ibm.com>
 <20261006001643.420929-16-kshk@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20261006001643.420929-16-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TOPQ2Fla c=1 sm=1 tr=0 ts=6ac52669 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=1OaBWXuRFuCUTItNd-0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA2NiBTYWx0ZWRfXxuwztkWuRaks
 JIgZVgSG9P6G6VM6aESE//M+hc17vJQAmNL9dilSs3cmdXcEtgpR6+jScNZYgdSJtLynvah8HnX
 vbXw0Q/wEKIFFLltGJpcJMetuuPysEWLCXz+DpZfCB0Nj5WltqcQD1cBFqwgx82eVtgi6VmFSTZ
 MAo/vzewEL4tyHrRFYOu+Ew7eanLn22sk2N+l2u7uiewJvUEdqKI3iK6A/EMsPsp60ylJGsZNiF
 Jo4fY0Z2ATDpAUOPoWZFsDQ45Mga7EDw0Lb3t2RirzixwrV3VKUzg61lQ1PvAuyOHBW9AEq3fH1
 9v3/LiASZQDUEpn03Z25njk5aTTdRdr2GX18kj7q+bVlJZvum6PJkfP2/rPgNV3C7f7E2i6oZq6
 4Pr3/MDIO9IVRCztt+A4FLP0SCYsoCw0Lqe+CjoM8lUcK4hO/uZxqfRMGruxNh6oQ+E6zvztG+Y
 wUFmxZE0wK6OTZ3UmKg==
X-Proofpoint-GUID: _swBcMHL0o3hwS6fAi6OzbymgrCmYZmK
X-Proofpoint-ORIG-GUID: _swBcMHL0o3hwS6fAi6OzbymgrCmYZmK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA2NiBTYWx0ZWRfX/xS4BT2iKnFt
 3mguRCFuXPdRz+ewv8Sb21IO2cTZKARakcLQCwFNNn4XHQWgVtVKFOhsZwo670CATSavaT9eprg
 0mThNGaHzOalVr7rdM+VGF479s6JJFo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_04,2026-10-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060066
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

On 10/5/26 8:16 PM, Konstantin Shkolnyy wrote:
> This is necessary for the follow-on migration support. The new unique
> UID-based bus "path" is used as part of idstr in the migration stream,
> making idstr unique and instance_id always 0.
> 
> For migration to succeed, (idstr+instance_id) must match those generated
> during QEMU start. Without unique idstr, QEMU will generate variable
> instance_id to distinguish devices, and that instance_id can change
> if a device is unplugged and plugged back, preventing migration.

I suppose technically any pre-11.2 machine might not have this path, but
at this point we don't even allow any zpci migration and won't allow
zpci migration to any pre-11.2 machine with the next patch -- so that
should be OK.

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>



