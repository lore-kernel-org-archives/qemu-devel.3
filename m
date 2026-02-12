Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8AD4EEA84C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 19:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqcJe-0003yI-GI; Thu, 12 Feb 2026 14:25:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1vqcJc-0003xC-94; Thu, 12 Feb 2026 14:25:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1vqcJa-0001nt-IR; Thu, 12 Feb 2026 14:25:27 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61CISlMo130324; Thu, 12 Feb 2026 19:25:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=rghqQH
 c3SfNncOSkVQMPbOT0lQhJ1o8LwJCpEhk3SVc=; b=plNtmmzQSKV9vwTlPxFgbx
 xNU6BQ3MPPRJj724xNHj/wkKU6Zjah/bD0PnNuyeLo5B54Oixb04NdFm2N3ZVcBX
 0eSnxwBis1dC+BuKv95D6uEX7+xm5yQBoVYJGPVKnD5Go9i2juA+lwDJEK05w4ar
 iUWkVU+GpIEdn2qjSPDA0BDRrWlGG6FQcVZp03Wnns8OMjyyQATa3fO3kR3V370g
 J0yI1SPacXaEFVyNmjeI5dByq8ndmpeF0o5wCfJ/GKNdvqGSYZik8hdhSSTIf2/F
 BtXqd58zSVEdgfWI1WviDZy6KfiUY7CZevC1ceL7UAtUMPytxS2QULpmWy2Ahijw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696v535k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Feb 2026 19:25:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61CIC5Hp001825;
 Thu, 12 Feb 2026 19:25:23 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c6je2bn04-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Feb 2026 19:25:23 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61CJPILp42467830
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Feb 2026 19:25:18 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3966220043;
 Thu, 12 Feb 2026 19:25:18 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 87ECB20040;
 Thu, 12 Feb 2026 19:25:17 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.111.43.40])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
 Thu, 12 Feb 2026 19:25:17 +0000 (GMT)
Date: Thu, 12 Feb 2026 20:25:15 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Aby Sam Ross <abysamross@ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, farman@linux.ibm.com, alifm@linux.ibm.com, Halil
 Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v2] s390x/pci: prevent null pointer dereference during
 zpci hot unplug
Message-ID: <20260212202515.3ffa2a80.pasic@linux.ibm.com>
In-Reply-To: <5fa0684d-5127-4db5-937c-d9be9fc4508d@linux.ibm.com>
References: <192dc45c-5bc2-4bfa-8e6f-8a140e23d88a@linux.ibm.com>
 <8e983aa64ebeaad9897496199ca80cfb7e0bf003.1770877629.git.abysamross@ibm.com>
 <20260212165029.206ae722.pasic@linux.ibm.com>
 <5fa0684d-5127-4db5-937c-d9be9fc4508d@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDE0OSBTYWx0ZWRfX2bDxMSMq5r63
 RWYhKdtbVlztKhKWqMIkEJ+jQl9K2kq4G+s08/fG1MD2uyoHjhLfxgpTm11Q4deWSo0WQ+UCbze
 w5JZILkdetmki8N0+tWCtrG25hsEbf28UHXTc4hODgVZO6+g3srrFvIQQg8+gy0BUoiNZ2BQLk8
 E8pDapUjDrQl+RNaWVwvy6c8tFD4zh2TUp4PJjvEodxq4Qj+9edaZojdVtaqQAjOA55k6bokair
 m1qjJbbqoC96b0itQ/suGBTAPbf+sr1cUk7HACUo5aAG1L9Mkqe+JO+rGnbgj3Vq/zZUa/t97cM
 ausrTgyC2zdm9KA34qSY5oJ7m7hiF6Ib81ivNmcy4YH7VO3a2/8sY92qgbkyhp3FdHeAMDkIDId
 NTo2hc69hGyo4kvTCT1pt3VhLdKFq3tMqyIzlEMBZ1kZcQqxAObjD4ADSGsktQRJjBfq+N083Up
 yoJZrRunId2H1VUm/hw==
X-Proofpoint-ORIG-GUID: LmfMZShnfXSQqD_5jdpsotuM25hxQl7I
X-Proofpoint-GUID: LmfMZShnfXSQqD_5jdpsotuM25hxQl7I
X-Authority-Analysis: v=2.4 cv=O+Y0fR9W c=1 sm=1 tr=0 ts=698e2924 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=4FL5sxqK8EKuwWEkRwoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 adultscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602120149
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

On Thu, 12 Feb 2026 11:55:15 -0500
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> > 
> > Maybe add a word or two why the other dereferences of pbdev->iommu
> > not guarded by a null check are safe.
> > 
> > I think we have:
> > * s390_pci_sclp_deconfigure
> > * s390_pci_msix_init
> > * s390_pcihost_reset
> > * s390_pci_device_reset
> > * mpcifc_service_call
> > * stpcifc_service_call
> > * s390_pci_read_base
> > 
> > and more. My guess is that the device never gets into a state where
> > these operations are permissible, and the code makes sure
> > those functions won't be called on a device that has
> > pbdev->iommu == NULL. But that is just my guess.
> > 
> > DISCLAIMER: I didn't look at this properly, just asking based
> > on a quick look. Some of these may contain explicit or implicit
> > checking...  
> 
> I mentioned in response to v1 as part of my review that I did look through all references of pbdev->iommu, as I was also concerned about whether we needed additional NULL checks.  But so far I'm not seeing it - it is largely implicit, but we don't drive the routines until the device is plugged, not in reserved|standby and iommu is associated.
> 
> This particular case is because we reach unplug (which also has to happen after plug of course) but the swizzle is we are reaching unplug exactly because we are giving up without actually having -successfully- plugged both the zpci and pci device.
> 
> But anyway, yes, I do think it would be good to add a small blurb to the commit message. 

Thanks! I have also assumed that I'm not the first one having this
thought.

Regards,
Halil

