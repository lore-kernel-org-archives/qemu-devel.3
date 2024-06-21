Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E09C2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 14:48:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKfYP-0004Ts-B5; Fri, 21 Jun 2024 10:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1sKfYJ-0004TM-Ce; Fri, 21 Jun 2024 10:47:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1sKfYH-0001pL-38; Fri, 21 Jun 2024 10:47:46 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45LEgEcO016925;
 Fri, 21 Jun 2024 14:47:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=3
 dphU7W+jAjpiQIAwa7GdJDtWuNSZlbPHx4rTqIJP4E=; b=nEf2OOVvOvhZh3vgM
 RV61kuLFkVgPO95bD/f7MYOKtQpD1nnPeIdiKKt79jk8odgv4++i9S4KozCDuvjj
 +H7MJgUh3GcqeQgeLeR1eQIwsNRah5aA8int3mg73yMA4Gz0tFk6KdhAzQdz94T/
 G8UZZrCRL91C5WUH6INU3egXDCE6dHwD2irFJRpV4iQjayhO40Ka4yUIz6GkTV77
 W60ZeLbMEIoVm6TMo0fQlZa2tgt7ttWIAWqEh0D3dvlX0qh9YYHprYV82N42Qopw
 sbLn8l5p7UaXoROO5wTM3Kuq9cSitSSRR+ANMasPU2+KZe9italTrhm6APBMcx6+
 KHxwQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ywbgu00e3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Jun 2024 14:47:39 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45LElcaB027740;
 Fri, 21 Jun 2024 14:47:38 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ywbgu00e0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Jun 2024 14:47:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 45LC1HL5019941; Fri, 21 Jun 2024 14:47:38 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yvrquqqbt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Jun 2024 14:47:38 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 45LElYtN49873184
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Jun 2024 14:47:36 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1E90C20040;
 Fri, 21 Jun 2024 14:47:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8205920049;
 Fri, 21 Jun 2024 14:47:31 +0000 (GMT)
Received: from [9.195.35.9] (unknown [9.195.35.9])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 21 Jun 2024 14:47:31 +0000 (GMT)
Message-ID: <7b553db9-4d29-4cfe-8874-3c87ad862c74@linux.ibm.com>
Date: Fri, 21 Jun 2024 20:17:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio: container: Fix missing allocation of
 VFIOSpaprContainer
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, harshpb@linux.ibm.com, 
 npiggin@gmail.com
Cc: danielhb413@gmail.com, david@gibson.dropbear.id.au,
 alex.williamson@redhat.com, qemu-ppc@nongnu.org,
 zhenzhong.duan@intel.com, qemu-devel@nongnu.org
References: <171528203026.8420.10620440513237875837.stgit@ltcd48-lp2.aus.stglabs.ibm.com>
 <11578ca8-2bb3-4504-b7b9-022c1df65942@redhat.com>
 <cef472a4-da2c-449e-8f76-0b3e9105e194@linux.ibm.com>
 <ba376f81-2175-4e3d-bda0-4b08b2ae5158@redhat.com>
Content-Language: en-US
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
In-Reply-To: <ba376f81-2175-4e3d-bda0-4b08b2ae5158@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _zKO6G-wKLYCT-XMUOXepcjqK9nMtvnf
X-Proofpoint-ORIG-GUID: WUDIq7RXjwHQwA7fQzTwUe5vzHhLq3A8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_06,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406210105
Received-SPF: pass client-ip=148.163.158.5; envelope-from=sbhat@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


On 6/21/24 2:19 PM, Cédric Le Goater wrote:
>
> Could you please describe the host/guest OS, hypervisor, processor
> and adapter ?
>
Here is the environment info,


pSeries:

Host : Power10 PowerVM  Lpar

Kernel: Upstream 6.10.0-rc4 + VFIO fixes posted at 
171810893836.1721.2640631616827396553.stgit@linux.ibm.com

Hypervisor : KVM on PowerVM & also tried without KVM using TCG

Guest : 6.8.5-301.fc40.ppc64le Fedora 40 distro kernel

Adapter: Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe 
SSD Controller PM173X


PowerNV:

Host: Power9 Baremetal

Kernel: kernel-core-6.9.4-200 - Fedora 40 distro kernel

Hypervisor: KVM

Guest : 6.8.5-301.fc40.ppc64le - Fedora 40 distro kernel

Adapter: Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe 
SSD Controller PM173X


Thanks,

Shivaprasad

> Thanks,
>
> C. 

