Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 255F9F9B612
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 11:02:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFVKj-0005fx-17; Wed, 22 Apr 2026 07:01:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wFVKW-0005f0-5j; Wed, 22 Apr 2026 07:01:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wFVKU-0008Uo-0Y; Wed, 22 Apr 2026 07:01:15 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63MAdV4R176920; Wed, 22 Apr 2026 11:01:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=DcrWaapeo0zMefvXiOEdD6dwCGqvPX
 xRJUurIvoZfow=; b=OH081xvDP5GtMcRENRgkTO98n4rwNsYFKNCG8JOV7iQn8g
 38hNwbWX/Q+opSbE09hNz4/oTqeUZeKcra5lJQ2sT+XfRypy5Sw5MbRd3ZOsFvBS
 Lgq1xYlRlCyirRskPEsLyKRNEJO6eAUUdtLgpHWDrjrE2E/JG8XXjvE5L6rZCrFP
 UCJ9aOHreuIemUQM0SHcFtI3iMLJ03HVMSXQxIWGhTlVA7y+Xmc1IDQswn1dU+WT
 p/kEHK8d2KFQmsuSg6x2fX+btSjHfq0VL8BPhzjQJWtuCpWtYTsvMas7N9jGOAYN
 VX57ZIxOGpJ/Cl+t1Mk3xYtbuXPkk02WFi4csJbQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu6auws-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Apr 2026 11:01:10 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63MAoR3C030412;
 Wed, 22 Apr 2026 11:01:09 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjkxswhh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Apr 2026 11:01:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63MB16AK43843964
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Apr 2026 11:01:06 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2F42D20043;
 Wed, 22 Apr 2026 11:01:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ADA7520040;
 Wed, 22 Apr 2026 11:01:03 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.123.12.247])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 22 Apr 2026 11:01:03 +0000 (GMT)
Date: Wed, 22 Apr 2026 16:31:01 +0530
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Zexiang Zhang <chan9yan9@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Miles Glenn <milesg@linux.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH 1/2] ppc/pnv_phb3: Error out on invalid config access
Message-ID: <aeigOUZJBkLgLJrl@shivang.upadyay>
References: <20260326190438.734239-1-adityag@linux.ibm.com>
 <20260326190438.734239-2-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326190438.734239-2-adityag@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDEwMyBTYWx0ZWRfX5o6I9Wjrm36Y
 sliPTPtsGEK0TKHrw6TiJL39+H4nZmZqD7kIITrCU4WthwDDjNpYXSZSUd6kiEkPPC20+0BYKF8
 so8JRdPNBw6sXBhfZPuZD9H043+fns6pSCPFV6yBpChJnpO7Iggh9xim6L56BFlGlwUgnchK3eO
 rUO7zDEWTetKsbwcEj3Hy5qZvvUp2TwlaU8uhgFMLlU+RRAx27R6tsLBrQ1zGySYhSD9MnUDjg8
 rFm9Cr+Pf9nXG1It06trTHhr48Q3ruJ04K0Mg0z5/zTc7D2OaywGQswCQzPUXYl567d/EvtUKv1
 +xRU6Oj1jYT+FvNPexF/sdY5qzQK4v2q2ckPKmNta7mQkHgHMIf0YKL7+r6lVMu2o8LpjE9GCcg
 QWYwAo4luzmC+9ayq/VzGeXLIMGh1dtUp3dcgAFWijEiRQNWkHc8kRDHz+CZyegoJPTqFx1SDLS
 L7Pzh8NUOp7vhXKWo8Q==
X-Proofpoint-ORIG-GUID: s8u_PUlONwTtFjDTvpPdTBWW-BaG8yQz
X-Proofpoint-GUID: iUxBiVONE1QYKptldicdt9UJLdB57OVn
X-Authority-Analysis: v=2.4 cv=BYfoFLt2 c=1 sm=1 tr=0 ts=69e8aa76 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=sWKEhP36mHoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22
 a=AJnj2I0kFmQSZKuwUD4A:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1011 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220103
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=shivangu@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

Hi Aditya,

On Fri, Mar 27, 2026 at 12:34:37AM +0530, Aditya Gupta wrote:
>      /* Special case configuration data */
>      if ((off & 0xfffc) == PHB_CONFIG_DATA) {
> +        if (size > 4) {
> +            phb3_error(phb, "Invalid config access, offset: 0x%"PRIx64" size: %d",
> +                      off, size);
> +            return;
> +        }

As per my understanding, this patch moves the check on assert early for pnv case.
If the `pci_host_config_xxx_common` doesnt support this >4 size access, can we apply the
logging change there directly, and maybe lift the assert?

~Shivang.

