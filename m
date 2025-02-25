Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14FEBC021B6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 10:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmsUl-00044S-V6; Tue, 25 Feb 2025 05:49:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1tmsUj-000443-Vg
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 05:48:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1tmsUi-00055T-3S
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 05:48:57 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P183KQ011036;
 Tue, 25 Feb 2025 10:48:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=vyFzsB
 QlyiEb8rUBOP5hwOSIO7sP8FT1lmsa7xGJ62g=; b=MDRl/GTdR8ppLRzsGnJeqa
 r8oeKvMnyeCz5wRFEZjGDT2S67Co/97UpMFSqSEOpfPpd8qIMI/iOYZHGLCyTF/i
 zoTNREbQK+Ejey1e2Ze7Led1MPofId3hBK9lE9n6L1qhoPl0S5lHdVAcPCPobYbE
 rGFZ9s5XcN+vA3mh+YWfIq7SJ8ADqg4ShaaMun8HJ5HfUe8Wr8Di4hGFuQWmn7lJ
 pGGZ9XfhAxduYjKGmRN+xjzBqkCqaEsfT+8UaOGqTYlm/WrYl1EfI8NOffcI3+5V
 PSb0KUERqxQMz5iVs0OtZ0Xi82yxMgyhsTMI1uGw38p5UASjt9nrGt49RMjQlLaA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4513x9t9ft-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Feb 2025 10:48:52 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51PAbvc7025073;
 Tue, 25 Feb 2025 10:48:51 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4513x9t9fp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Feb 2025 10:48:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51PAi1nB027479;
 Tue, 25 Feb 2025 10:48:50 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44ytdkcab0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Feb 2025 10:48:50 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51PAmoeH53150170
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Feb 2025 10:48:50 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 28ADB58054;
 Tue, 25 Feb 2025 10:48:50 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2DC595804E;
 Tue, 25 Feb 2025 10:48:49 +0000 (GMT)
Received: from [9.61.107.75] (unknown [9.61.107.75])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 25 Feb 2025 10:48:49 +0000 (GMT)
Message-ID: <56517009-bde4-4d72-922b-1d355021d618@linux.ibm.com>
Date: Tue, 25 Feb 2025 05:48:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] vfio: Add property documentation
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, tomitamoeko@gmail.com,
 corvin.koehne@gmail.com, Kirti Wankhede <kwankhede@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, Eric Farman
 <farman@linux.ibm.com>, Eric Auger <eric.auger@redhat.com>
References: <20250217173455.449983-1-clg@redhat.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20250217173455.449983-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2W8oG-rYspNQToH6zQvujVbdpDFGBQyG
X-Proofpoint-GUID: FwkIqZGsYRw2eFtzkNMw3qRCZiLIFUzy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_03,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 mlxlogscore=999 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2502250073
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=akrowiak@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org




On 2/17/25 12:34 PM, Cédric Le Goater wrote:
> Investigate the git history to uncover when and why the VFIO
> properties were introduced and update the models. This is mostly
> targeting vfio-pci device, since vfio-platform, vfio-ap and vfio-ccw
> devices are simpler.
>
> Sort the properties based on the QEMU version in which they were
> introduced.
>
> Cc: Tony Krowiak <akrowiak@linux.ibm.com>
> Cc: Eric Farman <farman@linux.ibm.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>
>   Should we introduce documentation for properties like the kernel has
>   in Documentation/ABI/*/sysfs-* ?
>
>   Changes in v4:
>
>   - Latest improvements from Alex
>
>   Changes in v3:
>
>   - Re-organized the vfio-pci properties based on the QEMU version in
>     which they were introduced
>   - Added property labels
>   - Improved description as suggested by Alex, Tomita and Corvin
>
>   Changes in v2:
>
>   - Fixed version numbers
>   - Fixed #ifdef in vfio/ccw.c
>   - Addressed vfio-pci-nohotplug
>   - Organize the vfio-pci properties in topics
>
>   hw/vfio/ap.c       |   9 ++++
>   hw/vfio/ccw.c      |  15 ++++++
>   hw/vfio/pci.c      | 125 +++++++++++++++++++++++++++++++++++++++++++++
>   hw/vfio/platform.c |  24 +++++++++
>   4 files changed, 173 insertions(+)
>
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 30b08ad375d5ecae886c5000fbaa364799fe76d0..c7ab4ff57ada0ed0e5a76f52b5a05c86ca4fe0b4 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -257,6 +257,15 @@ static void vfio_ap_class_init(ObjectClass *klass, void *data)
>       dc->hotpluggable = true;
>       device_class_set_legacy_reset(dc, vfio_ap_reset);
>       dc->bus_type = TYPE_AP_BUS;
> +
> +    object_class_property_set_description(klass, /* 3.1 */
> +                                          "sysfsdev",
> +                                          "Host sysfs path of assigned device");
> +#ifdef CONFIG_IOMMUFD
> +    object_class_property_set_description(klass, /* 9.0 */
> +                                          "iommufd",
> +                                          "Set host IOMMUFD backend device");
> +#endif
>   }
>   
>   static const TypeInfo vfio_ap_info = {

For ap.c:
Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>

>

