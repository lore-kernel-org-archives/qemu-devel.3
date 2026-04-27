Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EEE0FF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 15:16:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHNgK-0006EQ-NV; Mon, 27 Apr 2026 11:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wHNgB-00066p-TP; Mon, 27 Apr 2026 11:15:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wHNgA-00047A-9T; Mon, 27 Apr 2026 11:15:23 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63R9I8Mq1950188; Mon, 27 Apr 2026 15:15:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=2eKaeFmP6JhtFJ2zEfd3bizXYuhIH/wJG0L4jCloKp0=; b=fA/rXTv0JPCE
 xoNTuuvl6zyi2dVH15z19ZGjZy884Ay8wtewdR1hXEb0ldBA7ZujfwOH939XgZkK
 Wd+WyLD1K5iIVBX8248+SVCelXFMta6zZ/RI5AiT4sdkq0TMiqNL22IxnIcyROUy
 74AR19igYj7d4DUHOE9OmxUWSG+6TW9hdqMK71fVQv6fLP849pSBKvXaLLxqqfMJ
 FWZdS8qIN7RwWu5WanxGTrNJOB365gYjfdqdFlqx0mLcEIKqwI+5qYv/XWCqBrTr
 CXSXScfH9bp/G9SMlVSAcBocYyWriHEuJCkjNwzzIRCVHrRGE8XYmRoZ0HrcUq1m
 EsP03XpFiw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drk1jgfct-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Apr 2026 15:15:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63RF8lfI011055;
 Mon, 27 Apr 2026 15:15:18 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsamy5fq6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Apr 2026 15:15:18 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63RFFITn31195792
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Apr 2026 15:15:18 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EDB7858052;
 Mon, 27 Apr 2026 15:15:17 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B3E5458056;
 Mon, 27 Apr 2026 15:15:17 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 Apr 2026 15:15:17 +0000 (GMT)
Message-ID: <eae5d998c4e74ca3a5a7dffeb5c1947416c34809.camel@linux.ibm.com>
Subject: Re: [PATCH] tests/functional/ppc/test_ppe42: Fix warning from the
 latest version of pylint
From: Miles Glenn <milesg@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org
Date: Mon, 27 Apr 2026 10:15:17 -0500
In-Reply-To: <20260427080731.389061-1-thuth@redhat.com>
References: <20260427080731.389061-1-thuth@redhat.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE1OCBTYWx0ZWRfXxZ+FH+jW/qtw
 w5PsK87qekozafgOsldmLAuOiYKPacg1ajk/aWQOREo5+7n1EjrFX39d01fSDCDQWlu7UgAfz+H
 rzS1vuG/dEmjj/FOs6K6yRZHYRcvD5Ya6ahjvvLVL2izifDStVYHRJH3eb3NLlCsVGJllrw/Jk1
 aUavJQTuhGORkO72e7OVQYRpma39s+eCguCUfo8QjSz20UeBXekfbRABm+XUCdYB6PpXOfpJfJ+
 DH7mUpSu8vsERz/x26H6CUHGa1Nf3/OJi0RD7dlsjMSBaSVqWSa2xwNOk6iO55JWT9y5clW1xXf
 /VUIwKHgTTuzLCnrhA2uyRR3d1lI7jhOZWUc3VKk/r9BBwFOo9x0BtvfoLe+HyngS7jnVvi0qD+
 wuGd6mMTAW63gJwbqJHdWVN496AVurdv/XJD3e8btZQEYvGP4Y81meFMOw2+s6vcdeCyFG7kKny
 7jZEHOWr1FAGkU4GTwQ==
X-Proofpoint-GUID: fy7QF06zqgy8G0w15UqRDyza8A1a7Q2n
X-Proofpoint-ORIG-GUID: fy7QF06zqgy8G0w15UqRDyza8A1a7Q2n
X-Authority-Analysis: v=2.4 cv=MohiLWae c=1 sm=1 tr=0 ts=69ef7d87 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Y2srl_wmaKG8ylNe:21 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=vdZ6ATVBunjTvf1_9BEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 clxscore=1011 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270158
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

Thanks,

Glenn

On Mon, 2026-04-27 at 10:07 +0200, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The pylint from Fedora 44 found a new issue in this test:
> 
>  tests/functional/ppc/test_ppe42.py:63:20: W0101: Unreachable code (unreachable)
> 
> And indeed, the "break" is unreachable since the previous self.fail()
> always aborts immediately. Thus let's remove the "break" to make pylint
> happy again.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/functional/ppc/test_ppe42.py | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tests/functional/ppc/test_ppe42.py b/tests/functional/ppc/test_ppe42.py
> index 7b360a40a54..53958a7938d 100755
> --- a/tests/functional/ppc/test_ppe42.py
> +++ b/tests/functional/ppc/test_ppe42.py
> @@ -60,7 +60,6 @@ def _wait_pass_fail(self, timeout):
>                      self.log.debug(f"Execution stopped: {e}")
>                      self.log.debug("Exiting due to test failure")
>                      self.fail("Failure detected!")
> -                    break
>              else:
>                  self.fail("Timed out waiting for test completion.")
>  


