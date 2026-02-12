Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 899DFEE369C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 15:51:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqYxo-0001Ya-03; Thu, 12 Feb 2026 10:50:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1vqYxm-0001Y5-Gz; Thu, 12 Feb 2026 10:50:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1vqYxk-00062b-Uz; Thu, 12 Feb 2026 10:50:42 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61C8QuVM2503229; Thu, 12 Feb 2026 15:50:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=cwcWni
 R+Pa23FFE+okaIuPHFM/39WxVe2NKjb+AzdWw=; b=nzReZ7dz4McDu/CerlZpeN
 6FwdM2qGpVFAr/M+sGtNuTV+7sPFMIs/tUrXrqdv2woda0oM4w5hsgDEl48znWqv
 rLwqMk1FvWkamc4SYKnCr/N8NdVpg79imQm0kV9dMfrdpJbKLRuvvWhXPG1dnQC0
 O3542OmNS5t8lL20kl8G/YiMCmU5xH7cFUSpCVdBUNrwKC9T2KglDPbsgSPyAw11
 RN4nQlDKl9QBpWCEowL95hUKjU3NcurKykScu9m7qEPzQo3Llh7Yf8BYd48bOQ4r
 7pQcHFys+Vij4V9wiuL4IftzysJRy9wexqVK/cO0Llr+PMVvor5NuQt5MvKj1yPA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696vc3nu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Feb 2026 15:50:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61CE2H9S012626;
 Thu, 12 Feb 2026 15:50:37 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6h7kjygt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Feb 2026 15:50:37 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61CFoV5857606576
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Feb 2026 15:50:31 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4235920040;
 Thu, 12 Feb 2026 15:50:31 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1D2B320043;
 Thu, 12 Feb 2026 15:50:31 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.52.198.210])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Feb 2026 15:50:31 +0000 (GMT)
Date: Thu, 12 Feb 2026 16:50:29 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Aby Sam Ross <abysamross@ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, farman@linux.ibm.com,
 alifm@linux.ibm.com, Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic
 <pasic@linux.ibm.com>
Subject: Re: [PATCH v2] s390x/pci: prevent null pointer dereference during
 zpci hot unplug
Message-ID: <20260212165029.206ae722.pasic@linux.ibm.com>
In-Reply-To: <8e983aa64ebeaad9897496199ca80cfb7e0bf003.1770877629.git.abysamross@ibm.com>
References: <192dc45c-5bc2-4bfa-8e6f-8a140e23d88a@linux.ibm.com>
 <8e983aa64ebeaad9897496199ca80cfb7e0bf003.1770877629.git.abysamross@ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dIw7LU5c3TjQYXUVWAQ1e7uqYVavBPQC
X-Proofpoint-ORIG-GUID: dIw7LU5c3TjQYXUVWAQ1e7uqYVavBPQC
X-Authority-Analysis: v=2.4 cv=JdWxbEKV c=1 sm=1 tr=0 ts=698df6cd cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=bKdKHDsPvUGMU6Y6MEAA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDEyMSBTYWx0ZWRfX1xgT2rQfCNZN
 ma72ecoAx1oap7JX2qihkdkq5y+FrjfaMwagNKIaO+v2Nsrm8d96eS6lgaZEhv/AZGmjgEm/6AG
 I4UyuQP+bGyNInZ+p83mSh6v6dbGc8RAQEia514fC3pPc7WtnPZLYmUcHqlk3N3Yy44rjOarJwa
 CmB0LsH6W00KpcyU0NEo99DUvvsnFluVPBRtp2I4Kjlx1Vt97SRMVAhxD747IiuwVRQstDFATYe
 VfFnMGsZzQsnnj3C0x6mDcChcGIoiyONniQs0U6S3qjC5E0Nl0ij2rTA88cB3ntFSmCoI8blHHW
 T8MaS5GtZPNJzwcTnZZYLddfQasJyk3aTYUGIa54CnA5Bq6Fs7o1FHfrqEvGXIIAa7DBKVZKeiQ
 2zEMjx/4QqHuJcAChvmGyR9uga+a5gpk/QQ8YvQuo3rUv6xizGN5sXyp9zsMZ/K/NaUjtCJwpOx
 HUlKPtqSwIRpmKzu5/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_04,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602120121
Received-SPF: pass client-ip=148.163.158.5; envelope-from=pasic@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On Thu, 12 Feb 2026 06:47:36 -0500
Aby Sam Ross <abysamross@ibm.com> wrote:

> vfio-pci hostdev realize during zpci hot plug fails (in `vfio_pci_realize()`)
> if the vfio group file in `/dev/vfio/` lacks appropriate permissions and the
> hostdev[/properties] addition doesn't reach the point where it could be
> associated with previously added zpci device (in `s390_pcihost_plug()`).
> As a result, zpci iommu pointer remains null. The zpci hot unplug following the
> failed hostdev addition assumes zpci iommu pointer was assigned and tries to
> make use of it to end the dma count resulting in a null pointer dereference.
> In the non-hotplug scenario, `qdev_unplug()` for the zpci device is not called
> after hostdev addition failure and this issue is not encountered.


Maybe add a word or two why the other dereferences of pbdev->iommu
not guarded by a null check are safe.

I think we have:
* s390_pci_sclp_deconfigure
* s390_pci_msix_init
* s390_pcihost_reset
* s390_pci_device_reset
* mpcifc_service_call
* stpcifc_service_call
* s390_pci_read_base

and more. My guess is that the device never gets into a state where
these operations are permissible, and the code makes sure
those functions won't be called on a device that has
pbdev->iommu == NULL. But that is just my guess.

DISCLAIMER: I didn't look at this properly, just asking based
on a quick look. Some of these may contain explicit or implicit
checking...

Regards,
Halil

> 
> Fixes: 37fa32de7073 ("s390x/pci: Honor DMA limits set by vfio")
> 
> Signed-off-by: Aby Sam Ross <abysamross@ibm.com>
> Acked-by: Eric Farman <farman@linux.ibm.com>
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Reviewed-by: Farhan Ali <alifm@linux.ibm.com>

