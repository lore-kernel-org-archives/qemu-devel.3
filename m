Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C459CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 11:29:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQO4e-0002Ql-EB; Fri, 22 May 2026 07:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wQO4d-0002QX-Hh; Fri, 22 May 2026 07:29:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wQO4b-0007JA-U5; Fri, 22 May 2026 07:29:51 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M7SUix789447; Fri, 22 May 2026 11:29:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=0N5qFd0OyyiIrArieIAf4nfoZeNIZx
 VykPhvnnNhC7c=; b=OmJL1jGAs66nWGc+XuZkYjOzIN7z/p/2LUP7aSW7sd4QGQ
 TL39T6maABYEKOCyL5Uwx+rZW5AjjQXKBH6W0ZS7Dxu5FLXiG9dPzwN2zZvvFbhr
 6Wa4Z7vdNWVCcfAEo8NSWSiyOiSea+8Qlg7zdTygpXQIbmdi2JskrdpL4IQhcZ0U
 g8prO8ehRqeG9Azke7okEufMHNBmI78qbFx/dD0Fl5ceGAxEc5Q6Tebfnsztg5JP
 08YKluB0NoKlZ7SLWWCoSqL8vR7Vtp0NUaBVNfInCtr4ZMNg+hFQbKlBgN1APzsD
 EidMbP9WIHqze8XiKsAXYxwSF5BAu40vqpXAIqfA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb8t5qs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 May 2026 11:29:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64MBO6Mb014286;
 Fri, 22 May 2026 11:29:47 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e739w8s4e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 May 2026 11:29:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64MBThcJ30474836
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 May 2026 11:29:43 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3BAD020043;
 Fri, 22 May 2026 11:29:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 388C720040;
 Fri, 22 May 2026 11:29:41 +0000 (GMT)
Received: from mac.bl1-in.ibm.com (unknown [9.124.216.126])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 22 May 2026 11:29:40 +0000 (GMT)
Date: Fri, 22 May 2026 16:59:37 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Miles Glenn <milesg@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>,
 Misbah Anjum N <misanjum@linux.ibm.com>
Subject: Re: [PATCH 0/2] ppc/pnv: Make Power11 as the default CPU
Message-ID: <20260522164309.470506c2-b8-amachhiw@linux.ibm.com>
Mail-Followup-To: Aditya Gupta <adityag@linux.ibm.com>, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Miles Glenn <milesg@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>,
 Misbah Anjum N <misanjum@linux.ibm.com>
References: <20260521200844.1449023-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521200844.1449023-1-adityag@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDExMSBTYWx0ZWRfX+UkPOFfATXcA
 gaYq7wpTJebEGtmC8plmgCAMwlp1jQE9Ft4K6KzHrNfYvofvhVIXotiZFJPcQ2JoemhQb3LtZUH
 rdv6iX6j0SZ5btHG3co9w8J4o5WkEA8Tt3S0Jx4bH8UTmNVxPDHFhOI+22hgSapOK5NF2zduxAF
 D+j9tLiCDd4SDOCumXul4K2sEEnVY6LX4qFVMh0ZKNw7kUenJTJxzvoSsAu6un0CY04UkeNWuDH
 JR/pUI7hjp9YE5u+nAFexHba2x9jjgiRpiDrEZKaFE99VL3j5BY2ZQ67CCM0+qAds31sp7flPei
 26oBATtpCGBtQR7bdt2yqOoV59XibRdLQI8a9ES4kkWI69GiOZeA0L8yOw+nIgxkr4HgNF/eP3q
 0CQSBswP9gATEcHpyqYWUateRe4YkMhoFLw4yPynrXNoafWLqYq3vj7I4GbMnF0BgiM+2RoBJ/m
 hH5QZoijNDgUkmWZf9A==
X-Proofpoint-GUID: aesWJcPz_2LEuvQQOvrDwk-oZB9kVeea
X-Proofpoint-ORIG-GUID: eJdLydV_w15CwvHbNTSSaeYZAQcBvpjG
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a103e2c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=i0h0DvZQZo2f9Fd42IUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220111
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

Thanks for the patches.

On 2026/05/22 01:38 AM, Aditya Gupta wrote:
> Overview
> ========
> 
> Power11 is the newest supported Power processor merged last year.
> Make it the default processor for PSeries and PowerNV.

I gave the patches a try and I see the default CPU without the patches is
Power10 while with the patches, the default CPU becomes as Power11.

PowerNV:
========
  Without the patches:
  --------------------
  # cat /proc/cpuinfo
  processor	: 0
  cpu		: POWER10, altivec supported
  clock		: 3800.000000MHz
  revision	: 2.0 (pvr 0080 1200)

  timebase	: 512000000
  platform	: PowerNV
  model		: IBM PowerNV (emulated by qemu)
  machine	: PowerNV IBM PowerNV (emulated by qemu)
  firmware	: OPAL
  MMU		: Radix

  With the patches:
  -----------------
  # cat /proc/cpuinfo
  processor	: 0
  cpu		: Power11, altivec supported
  clock		: 3800.000000MHz
  revision	: 18.0 (pvr 0082 1200)

  platform	: PowerNV
  model		: IBM PowerNV (emulated by qemu)
  machine	: PowerNV IBM PowerNV (emulated by qemu)
  firmware	: OPAL
  MMU		: Radix

pSeries:
========

  Without the patches:
  --------------------
  # cat /proc/cpuinfo
  processor	: 0
  cpu		: POWER10 (architected), altivec supported
  clock		: 1000.000000MHz
  revision	: 2.0 (pvr 0080 1200)

  timebase	: 512000000
  platform	: pSeries
  model		: IBM pSeries (emulated by qemu)
  machine	: CHRP IBM pSeries (emulated by qemu)
  MMU		: Radix

  With the patches:
  -----------------
  # cat /proc/cpuinfo
  processor	: 0
  cpu		: Power11 (architected), altivec supported
  clock		: 1000.000000MHz
  revision	: 18.0 (pvr 0082 1200)

  timebase	: 512000000
  platform	: pSeries
  model		: IBM pSeries (emulated by qemu)
  machine	: CHRP IBM pSeries (emulated by qemu)
  MMU		: Radix

Also, the changes look good to me. Hence:

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Tested-by: Amit Machhiwal <amachihw@linux.ibm.com>

Thanks,
Amit

