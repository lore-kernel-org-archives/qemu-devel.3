Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD3BDC27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 13:31:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJCRV-0002Xi-Cm; Mon, 17 Jun 2024 09:30:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sJCRJ-0002VP-AL; Mon, 17 Jun 2024 09:30:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sJCRF-0001kW-N2; Mon, 17 Jun 2024 09:30:28 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HC0eOj006925;
 Mon, 17 Jun 2024 13:30:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 rJ5HHrSgY3g0DgoDYJxNq7yUQo2yzrbJn+3wCyxypGI=; b=n+p9MDGoctnPWf+W
 zD263M0bhM3hcOSIOUHJD7Jl5XOJhRUfZp6g2VLTVjkg7Bw4Vr21NDRg890Wywut
 B3F8OZdSukqw6/AjEuLjhydtv+DHGqw/zcfBqZUqS08VElqTrdVo5G0GjEj3j3P1
 nNzYyN8q+E7nMJgKoLi/oprUQlsRA4KRGl+Z+y7wDOU4+K2E1U8wPKH3JNopFgCV
 X/D8mnnQcLS9nfYZHF3kcXNcFD4VZH+iSiUWH4iX3yZM9e3yeYgMYVYUa3fKWxAz
 LQjOHIn++kj4yised7DbUkqxclJgmrem8WalrWwFnLH5rurYp4tDuDTAcI/E3Frs
 R+utyA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ytj408mer-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Jun 2024 13:30:11 +0000 (GMT)
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45HDUB89011424;
 Mon, 17 Jun 2024 13:30:11 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ytj408mem-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Jun 2024 13:30:11 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 45HC3Qqf011031; Mon, 17 Jun 2024 13:30:10 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yspsmt8kk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Jun 2024 13:30:10 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 45HDU71v24117984
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2024 13:30:09 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CF4D55807D;
 Mon, 17 Jun 2024 13:30:07 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3083458070;
 Mon, 17 Jun 2024 13:30:04 +0000 (GMT)
Received: from [9.195.47.7] (unknown [9.195.47.7])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Jun 2024 13:30:03 +0000 (GMT)
Message-ID: <21ac5eca-dd22-40de-a21e-af9985e2c62f@linux.ibm.com>
Date: Mon, 17 Jun 2024 19:00:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/26] hw/ppc: Prefer HumanReadableText over Monitor
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20240610062105.49848-1-philmd@linaro.org>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20240610062105.49848-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Smrl2P5jb1zaTnt8V94rUl-pAd7jHPLs
X-Proofpoint-GUID: olYVnKHB2gkj1qcKLji9ivp0DSFyxfiX
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_11,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=610 spamscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406170104
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 6/10/24 11:50, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> This series remove uses of Monitor in hw/ppc/,
> replacing by the more generic HumanReadableText.
> Care is taken to keep the commit bisectables by
> updating functions one by one, also easing review.
> 
> For rationale see previous series from Daniel:
> https://lore.kernel.org/qemu-devel/20211028155457.967291-1-berrange@redhat.com/
> 
> Regards,
> 
> Phil.
> 

For the series:

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> Philippe Mathieu-Daudé (26):
>    hw/ppc: Avoid using Monitor in pnv_phb3_msi_pic_print_info()
>    hw/ppc: Avoid using Monitor in icp_pic_print_info()
>    hw/ppc: Avoid using Monitor in xive_tctx_pic_print_info()
>    hw/ppc: Avoid using Monitor in ics_pic_print_info()
>    hw/ppc: Avoid using Monitor in PnvChipClass::intc_print_info()
>    hw/ppc: Avoid using Monitor in xive_end_queue_pic_print_info()
>    hw/ppc: Avoid using Monitor in spapr_xive_end_pic_print_info()
>    hw/ppc: Avoid using Monitor in spapr_xive_pic_print_info()
>    hw/ppc: Avoid using Monitor in xive_source_pic_print_info()
>    hw/ppc: Avoid using Monitor in pnv_phb4_pic_print_info()
>    hw/ppc: Avoid using Monitor in xive_eas_pic_print_info()
>    hw/ppc: Avoid using Monitor in xive_end_pic_print_info()
>    hw/ppc: Avoid using Monitor in xive_end_eas_pic_print_info()
>    hw/ppc: Avoid using Monitor in xive_nvt_pic_print_info()
>    hw/ppc: Avoid using Monitor in pnv_xive_pic_print_info()
>    hw/ppc: Avoid using Monitor in pnv_psi_pic_print_info()
>    hw/ppc: Avoid using Monitor in xive2_eas_pic_print_info()
>    hw/ppc: Avoid using Monitor in xive2_end_eas_pic_print_info()
>    hw/ppc: Avoid using Monitor in xive2_end_queue_pic_print_info()
>    hw/ppc: Avoid using Monitor in xive2_end_pic_print_info()
>    hw/ppc: Avoid using Monitor in xive2_nvp_pic_print_info()
>    hw/ppc: Avoid using Monitor in pnv_xive2_pic_print_info()
>    hw/ppc: Avoid using Monitor in
>      SpaprInterruptControllerClass::print_info()
>    hw/ppc: Avoid using Monitor in spapr_irq_print_info()
>    hw/ppc: Avoid using Monitor in pnv_chip_power9_pic_print_info_child()
>    hw/ppc: Avoid using Monitor in pic_print_info()
> 
>   include/hw/pci-host/pnv_phb3.h |   2 +-
>   include/hw/pci-host/pnv_phb4.h |   2 +-
>   include/hw/ppc/pnv_chip.h      |   4 +-
>   include/hw/ppc/pnv_psi.h       |   2 +-
>   include/hw/ppc/pnv_xive.h      |   4 +-
>   include/hw/ppc/spapr_irq.h     |   4 +-
>   include/hw/ppc/xics.h          |   4 +-
>   include/hw/ppc/xive.h          |   4 +-
>   include/hw/ppc/xive2_regs.h    |   8 +--
>   include/hw/ppc/xive_regs.h     |   8 +--
>   hw/intc/pnv_xive.c             |  38 ++++++------
>   hw/intc/pnv_xive2.c            |  48 +++++++--------
>   hw/intc/spapr_xive.c           |  41 ++++++-------
>   hw/intc/xics.c                 |  25 ++++----
>   hw/intc/xics_spapr.c           |   7 +--
>   hw/intc/xive.c                 | 108 ++++++++++++++++-----------------
>   hw/intc/xive2.c                |  87 +++++++++++++-------------
>   hw/pci-host/pnv_phb3_msi.c     |  21 +++----
>   hw/pci-host/pnv_phb4.c         |  17 +++---
>   hw/ppc/pnv.c                   |  52 ++++++++--------
>   hw/ppc/pnv_psi.c               |   9 ++-
>   hw/ppc/spapr.c                 |  11 +++-
>   hw/ppc/spapr_irq.c             |   4 +-
>   23 files changed, 256 insertions(+), 254 deletions(-)
> 

