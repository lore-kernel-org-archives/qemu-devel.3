Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12469CE8E76
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 13:38:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3y1g-0002hM-ML; Thu, 24 Oct 2024 09:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fiuczy@linux.ibm.com>)
 id 1t3y1d-0002gn-Hs; Thu, 24 Oct 2024 09:37:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fiuczy@linux.ibm.com>)
 id 1t3y1b-0000mZ-OU; Thu, 24 Oct 2024 09:37:17 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49OBTQAR016712;
 Thu, 24 Oct 2024 13:37:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=LjZXbe
 Ao5MOkiQxpVNv+tSNn/cP5Zk+6j0YkNgdjdiM=; b=VS8sixuoNfeIpZYPS2CEyt
 Jo3NBZt/8b8tXdX5k2fOKT/8nHsbxb5S4F1s2vttnX52W4A4YAsqqJpjkPvTG/mG
 lM1uH0sjuerRQhJYQ7jq4EP67IiXr03JeMrLi/DP0dp0upp/+2iq/FaFktEpA/JR
 vgf+gR5D3x2e9V1zmYqTs8LTCY+rH2zr+2pdqSqL1XZec6KwphNJ4jLV/hmvr0EM
 Kd43hLxGTeoEl9BXoUdAmw77z+XoHw6ys/xG/tfeg/4F24OWy7h+t0/q3bMym5OA
 cCR9NWu6oDFvbt+e9dKE8GkpaKmv8JSlI+rexsBv8eJCkeRngqXLtKcav60g4nnQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emajrs09-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Oct 2024 13:37:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49OATEhi001542;
 Thu, 24 Oct 2024 13:37:11 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42emk9gkqq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Oct 2024 13:37:11 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49ODb7QQ55050516
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2024 13:37:07 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A03332004F;
 Thu, 24 Oct 2024 13:37:07 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 414B12004E;
 Thu, 24 Oct 2024 13:37:07 +0000 (GMT)
Received: from [10.0.2.15] (unknown [9.171.140.58])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Oct 2024 13:37:07 +0000 (GMT)
Message-ID: <2adb8b2e-ebd8-4c98-a2aa-2c4ed24683ed@linux.ibm.com>
Date: Thu, 24 Oct 2024 15:37:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/s390x: Re-enable the pci-bridge device on s390x
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20241024130405.62134-1-thuth@redhat.com>
Content-Language: en-US
From: Boris Fiuczynski <fiuczy@linux.ibm.com>
In-Reply-To: <20241024130405.62134-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2CsV8AmqFTkC43gokHs1k-ike2BMhQFZ
X-Proofpoint-GUID: 2CsV8AmqFTkC43gokHs1k-ike2BMhQFZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0
 mlxscore=0 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410240111
Received-SPF: pass client-ip=148.163.158.5; envelope-from=fiuczy@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Just my two cents on this with regard to the future:
Tools using libvirt to define or modify libvirt domains should not be 
enforced to change there PCI code logic to prevent the usage of 
pci-bridge for s390x.
The PCI bus configuration in QEMU is QEMU internal only as the zPCI 
configuration is used in the s390x guest.

Therefore for this patch
Reviewed-by: Boris Fiuczynski <fiuczy@linux.ibm.com>

On 10/24/24 15:04, Thomas Huth wrote:
> Commit e779e5c05a ("hw/pci-bridge: Add a Kconfig switch for the
> normal PCI bridge") added a config switch for the pci-bridge, so
> that the device is not included in the s390x target anymore (since
> the pci-bridge is not really useful on s390x).
> 
> However, it seems like libvirt is still adding pci-bridge devices
> automatically to the guests' XML definitions (when adding a PCI
> device to a non-zero PCI bus), so these guests are now broken due
> to the missing pci-bridge in the QEMU binary.
> 
> To avoid disruption of the users, let's re-enable the pci-bridge
> device on s390x for the time being. We could maybe disable it later
> again if libvirt does not add the pci-bridge device automatically
> to the guests anymore in the future.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/s390x/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/s390x/Kconfig b/hw/s390x/Kconfig
> index 3bbf4ae56e..82afdaa9dc 100644
> --- a/hw/s390x/Kconfig
> +++ b/hw/s390x/Kconfig
> @@ -7,6 +7,7 @@ config S390_CCW_VIRTIO
>       imply VFIO_AP
>       imply VFIO_CCW
>       imply WDT_DIAG288
> +    imply PCI_BRIDGE
>       imply PCIE_DEVICES
>       imply IOMMUFD
>       select PCI_EXPRESS


-- 
Mit freundlichen Grüßen/Kind regards
    Boris Fiuczynski

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Wolfgang Wendt
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294

