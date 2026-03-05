Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E47F513E6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 22:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyHEG-00068w-65; Thu, 05 Mar 2026 17:31:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vyHEC-00063y-Iq; Thu, 05 Mar 2026 17:31:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vyHEB-0005bq-2d; Thu, 05 Mar 2026 17:31:32 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 625HVLdh1959257; Thu, 5 Mar 2026 22:31:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=lUsjaq
 NwrE/CYrGHmE5pTt/kdXzyZSDlO2JtllCMAOE=; b=B9UtKr887o7qe98nk7FDz9
 SbDJFtGZFlzDXSwIBDwt54j5luwYZzp5z/+kOb/XAizjG8k1SA9QOvwpYj4O6VzR
 /YmACJ/mf/16+r+99yYeg3bgmH7YlH01tfFR7MJdqsNVqVvl/+1SL1gQQ0SpwdTF
 iz+Dy3O9zasnI2m43r6cKIHgp6r0sol2IPGdN+O+3TvuBRN6jCWbQl7u/EFDmAO6
 bxf+Q55QRvAKJduO0Ira5P16TmXTOZZATngpuKJ5y3TD1qw7y4MpHNHEvUECMUg/
 kT6NCSVOiL+Ev8I3N2A+UxXMwqlejQZX3/b6Ue6qAKwFHeL0GN+Llrdahu+asplQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskd5wef-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Mar 2026 22:31:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 625IUPWr010327;
 Thu, 5 Mar 2026 22:31:27 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmc6kd9ph-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Mar 2026 22:31:27 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 625MVQdW31588916
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Mar 2026 22:31:26 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D69858055;
 Thu,  5 Mar 2026 22:31:26 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BF1735803F;
 Thu,  5 Mar 2026 22:31:24 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.29.58]) by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  5 Mar 2026 22:31:24 +0000 (GMT)
Message-ID: <65b5643284037539a5cd47d49d74a7e49302fabd.camel@linux.ibm.com>
Subject: Re: [PATCH v4 13/15] s390x: Build IPLB for virtio-pci devices
From: Eric Farman <farman@linux.ibm.com>
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 thuth@redhat.com, mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, mjrosato@linux.ibm.com,
 zycai@linux.ibm.com
In-Reply-To: <20260304025917.2157032-14-jrossi@linux.ibm.com>
References: <20260304025917.2157032-1-jrossi@linux.ibm.com>
 <20260304025917.2157032-14-jrossi@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date: Thu, 05 Mar 2026 17:30:55 -0500
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oa5nbWR_8fStcHm6Ax8WOh1RBrywAnU4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDE4OSBTYWx0ZWRfX0AGL3yyjQrJ/
 TpEnVMWTWqI0PaK0LrWo9OFArYE+GfZxVY2WUBWG7jSomffkTBblno0Cpn+9CniKmvjZxBXD1Op
 5nrrb7dqeosgXvan+V8T4MK+2PNIxLbBf+Jx6/2pkfwlET4naa2XvKLMmZkgpWTVh+UOEAObonv
 KMSoNV8yBqm8A8Turj8oI6TPIXRD86PQwOQBScv3BOmZcit0QS29pAjGe+12c8jmcFoUnlZAWzG
 ZJ42hcn5YV/fe0DKNW/4ejJr8CDAFlOnpOj9vT5+YyPNMk14hKs7lsrL5kZMbPz76ERuVKXYyE+
 jvm/wgvrC2J8bGx6hfoaOB3BEVPVlpdFPjmw7l1X6t7aqODSO5cQagbSY3nsq0J+Ux5E16LdVk2
 SfWm3O4xMIpqw/Obpm5cH7azhIIjAbC28gTOM8JrKB6EaPnFtiANardrKRaMp77nBkPOyOZYfcV
 PacJ2IUEdwiNbnXhltw==
X-Authority-Analysis: v=2.4 cv=H7DWAuYi c=1 sm=1 tr=0 ts=69aa0440 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=RYx3NvtF8dpJk1fecJwA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: oa5nbWR_8fStcHm6Ax8WOh1RBrywAnU4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_06,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050189
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, 2026-03-03 at 21:59 -0500, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
>=20
> Search for a corresponding S390PCIBusDevice and build an IPLB if a device=
 has
> been indexed for boot but does not identify as a CCW device,
>=20
> PCI devices are not yet included in boot probing (they must have a boot i=
ndex).
>=20
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>  hw/s390x/ipl.c                  | 56 ++++++++++++++++++++++++++++++---
>  hw/s390x/ipl.h                  |  3 ++
>  hw/s390x/s390-pci-bus.c         |  3 +-
>  include/hw/s390x/s390-pci-bus.h |  2 ++
>  4 files changed, 57 insertions(+), 7 deletions(-)

Reviewed-by: Eric Farman <farman@linux.ibm.com>

