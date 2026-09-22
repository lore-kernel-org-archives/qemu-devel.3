Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F9BC98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 17:46:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x94ZL-0001nK-D9; Tue, 22 Sep 2026 13:46:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1x94Yx-0001m9-TZ; Tue, 22 Sep 2026 13:45:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1x94Yv-0008Db-3i; Tue, 22 Sep 2026 13:45:51 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MF5lh03071299; Tue, 22 Sep 2026 17:45:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=cfWTvP1T+ZiohLpYQyROc/5n1O6+av
 9Ju5lf8O7Zhf8=; b=HS0mUkdB3hsBJvYgDVni+3DJjkd1pUSmXqFJrmCpuHQmC1
 up/+M5msUaEI4oB87Q8dbVp+tx0jR7TfUfzHtposaG5nffZRHqENUUblOIkIaiQp
 ixKFJBli4oFFIelCkrPX0OTcgw6vUMM6+uORuOy99wiQmEzus2X8mb5b2B+p0sgm
 6X07grShA7f/u7ck1ZDZpnyQuSdd++TwKunzKMgpxaCoNvV4zAvAx3gsXRUkg89g
 g0MVkzG4EJJCQrPGzqRJ29vedHJehg6meMuIulDR4d53ETUp9z6zt/sZFHvOGomt
 FrD/3h7CGr/Vt5jWKxfcv+h4rJe+3UG31Fuqck2w==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1q7h2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 17:45:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MEm5kR1738260; Tue, 22 Sep 2026 17:45:44 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gu5bkddru-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 17:45:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68MHjeTL38994194
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2026 17:45:40 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CBA3D20043;
 Tue, 22 Sep 2026 17:45:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4D4DF20040;
 Tue, 22 Sep 2026 17:45:37 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.111.70.254])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 22 Sep 2026 17:45:36 +0000 (GMT)
Date: Tue, 22 Sep 2026 23:15:34 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Aniket Sahu <asahu1x@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, peterx@redhat.com,
 farosas@suse.de, npiggin@gmail.com, milesg@linux.ibm.com,
 harshpb@linux.ibm.com, rathc@linux.ibm.com,
 anushree.mathur@linux.ibm.com, misanjum@linux.ibm.com,
 gautam@linux.ibm.com, thuth@redhat.com, amachhiw@linux.ibm.com
Subject: Re: [PATCH v3 2/2] tests/functional/ppc64: extend ppc64 powernv net
 device tests
Message-ID: <arK-kW-11OlcDBRY@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260921081010.31778-1-asahu1x@linux.ibm.com>
 <20260921081010.31778-3-asahu1x@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921081010.31778-3-asahu1x@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: eKcni0eyCbhW3G2U3G9BsxSJk7vaAM_o
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab2bec9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=gbOv8vlnZcgnT89JuzEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI1OCBTYWx0ZWRfX+vAnrT8WGhuZ
 IvF1Qt5DgCgMeiKanQDiOaIVi9R2kA+PXXtpdP/jefR0rRos1I1ksQHXqPDzIHdAdtRjlpFwHxn
 MbEy/11x1xM3N69lP4zEEPBzHbrnErQ=
X-Proofpoint-GUID: tf5MUEe2EnWKmf0jdHRYmoPugX-LpH4v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI1OCBTYWx0ZWRfX1uvyEjza3Ivj
 X9Zu5YMmfxgRbq0961AvYO6uQMiistfy3G/zYaRnMWfqQbFg894ncsLagwMobOahuWBAwKfVKnW
 EUhxA/Ptvu9NBD60Dga5P3aIZmbpT6JXQtwmL8UWoJWFyp+5Q9DyCiw4D0trNwKjAQxvBYLG9rq
 FsEeE39/vZgU6kG0BIrghElKzsdR67heehk/Xwuexg+JQwMEWvWPzbWqIkpmdgeLZ8nfoc9zvWV
 qMx2SAD/EhfQAXsISx59ZXSF+OcXqrU/8AjlGNHtoV+1MS5hboQtWEo9pKTULj0jDx9U9fh+FjX
 YW1gy3BuYHEFR9F72TYiNcZe2yAIeyRyetTO7U1wIDk3JkBQq7koWZsH43vTh+r6HBrv5d66k85
 Zp6sRQBBGgqqtVEAacER5erbjPSxnS9n9vl4cpz4wNdhJMitil/THKuWzlam29HtSEvaA0bmQzG
 2Kdxe2Plg7mlv/mHh2A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220258
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On 26/09/21 01:40PM, Aniket Sahu wrote:
> Added console checks as the probe log lines will appear before the
> S14Silence-console init scripts.
> 
> Signed-off-by: Aniket Sahu <asahu1x@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

> ---
>  tests/functional/ppc64/test_powernv.py | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/functional/ppc64/test_powernv.py b/tests/functional/ppc64/test_powernv.py
> index f3e05e4d38..200fd2c894 100755
> --- a/tests/functional/ppc64/test_powernv.py
> +++ b/tests/functional/ppc64/test_powernv.py
> @@ -201,9 +201,12 @@ def do_test_ppc64_powernv(self, proc):
>  
>          self.wait_for_console_pattern("CPU: " + proc + " generation processor")
>          self.wait_for_console_pattern("INIT: Starting kernel at ")
> +        # NVMe, e1000e, and xHCI are probed synchronously by the kernel
> +        # during PCI enumeration, after OPAL hands off to Linux.
> +        self.wait_for_console_pattern("nvme nvme0")
> +        self.wait_for_console_pattern("e1000e")
> +        self.wait_for_console_pattern("xhci_hcd")
>          self.wait_for_console_pattern("Run /sbin/init as init process")
> -        # Device detection output driven by udev probing is sometimes cut off
> -        # from console output, suspect S14silence-console init script.

Verified the probe order is correct.

Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>

Thanks,
- Aditya G


