Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34BACE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 15:15:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVXm1-0003xK-6z; Wed, 08 Jan 2025 10:15:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arbab@linux.ibm.com>)
 id 1tVXlk-0003qh-I7
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 10:14:53 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arbab@linux.ibm.com>)
 id 1tVXlh-0000sC-R0
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 10:14:52 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50885wcl022474;
 Wed, 8 Jan 2025 15:14:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=p8KGfb+6fTCPwo8n/lz6Ilw41OTUpM
 3vces1MbedR00=; b=PURjnSpZxf2aeBpKSCCKN3hIbtPF4SoVnT/xdSqXxruur1
 etLFpZVtBjHub1uSB+N5immbgr3dFv011UollHAuiSbsj5TTCyL0D301Qiq4a7Y9
 BjlSnIcw5mll1oJIp4LCY0yNNxPPLqp9ICW15v3H021HR8G8O++aa2Y6HEgKpvb9
 upkGLkXj+2hWfT6hxQKy1e9y3f1IOqfGQL/ZHV8PAEiTyouatZW6KJ/EmuZ7fWVb
 treVg5WRDc3OsvtaPjiDAIE5NZK7bjWVW8jr4ql0ttO3O6spLS0/CUQHXTpv2gAM
 o5RVIdHTP2+KE1dqVFCw8dkAr38KSjHWs/kpopQQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441nj39x7f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 15:14:39 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 508FAFNU010073;
 Wed, 8 Jan 2025 15:14:38 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441nj39x7d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 15:14:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 508DhNaF013571;
 Wed, 8 Jan 2025 15:14:37 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ygap08xg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 15:14:37 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 508FEbfn31654488
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 8 Jan 2025 15:14:37 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 398F058063;
 Wed,  8 Jan 2025 15:14:37 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2819D58061;
 Wed,  8 Jan 2025 15:14:37 +0000 (GMT)
Received: from arbab-laptop.localdomain (unknown [9.53.178.221])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Wed,  8 Jan 2025 15:14:37 +0000 (GMT)
Received: from arbab-laptop.austin.ibm.com (localhost [IPv6:::1])
 by arbab-laptop.localdomain (Postfix) with ESMTPS id 985E4174E7E;
 Wed,  8 Jan 2025 09:14:36 -0600 (CST)
Date: Wed, 8 Jan 2025 09:14:35 -0600
From: Reza Arbab <arbab@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH] virtio-balloon-pci: Allow setting nvectors, so we can
 use MSI-X
Message-ID: <b406b176-4b6c-4d82-824c-5c0ced0d9fcf@arbab-laptop>
References: <20241216163125.438156-1-arbab@linux.ibm.com>
 <cf465326-1eaf-4ad1-99ae-1e0d5a562a84@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <cf465326-1eaf-4ad1-99ae-1e0d5a562a84@redhat.com>
Organization: IBM Linux Technology Center
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EqSfUwdVCnIO7ND_UG8NflcYj355cJtv
X-Proofpoint-GUID: GV8XQUJeShagtEZbDZUEExAynB7uZj45
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 impostorscore=0 mlxlogscore=421 phishscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501080125
Received-SPF: pass client-ip=148.163.158.5; envelope-from=arbab@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Dec 18, 2024 at 11:37:05AM +0100, David Hildenbrand wrote:
>No expert on any of that MSi-X / PCI magic, but LGTM
>
>Acked-by: David Hildenbrand <david@redhat.com>

Thanks David!

Did anyone else have any comments? Just want to make sure I have things 
in order to get this into the next release.

-- 
Reza Arbab

