Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FAC6C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 16:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY5rD-0006QA-RG; Wed, 15 Jan 2025 11:03:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arbab@linux.ibm.com>)
 id 1tY5r8-0006Q0-VG
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 11:02:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arbab@linux.ibm.com>)
 id 1tY5r7-0004jR-8v
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 11:02:58 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FCe1ET014624;
 Wed, 15 Jan 2025 16:02:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ekWzyp
 mHFN2nq+f2wPk/7MpNua1wMwT1yJV2xA40UOI=; b=L02PZffqZ5QFPQM3XqGcGx
 voNQaY0MB6ChnalhbsV4NbZStN79mr6LRBUGgysAdlJ9LmA5R5rPyjtYyFBljoyL
 TqX86mUyhchwCGw6Hgg8+ywcu76lSLvt7lEJKjCuWpuc/+wdYGAgZtH1Ext0KfZi
 oQTUedb3oUaDCydoaLbmJFoWkR7yE3fsqOIaoawF67obcfZ3AGAhXLPED3McIVI2
 XHgl/WuDD3VgmWqw4h76CfwDpgWSzbIhD4HPggORYm6eLaC4kAuIXOsrLQA1iPHY
 CKThN6yXeikgvZ5dL3Ccq0W7SfplFTsR4PLq/sLTEUDS4PGu06vGObZKM/DRAJ0A
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44622huutf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jan 2025 16:02:49 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50FFup3A030979;
 Wed, 15 Jan 2025 16:02:48 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44622huutb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jan 2025 16:02:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50FELE4D007364;
 Wed, 15 Jan 2025 16:02:47 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443yn95ah-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jan 2025 16:02:47 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50FG2kkd66650550
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jan 2025 16:02:47 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D4E6258059;
 Wed, 15 Jan 2025 16:02:46 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C756E58043;
 Wed, 15 Jan 2025 16:02:46 +0000 (GMT)
Received: from arbab-laptop.localdomain (unknown [9.53.178.221])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 15 Jan 2025 16:02:46 +0000 (GMT)
Received: from arbab-laptop.austin.ibm.com (localhost [IPv6:::1])
 by arbab-laptop.localdomain (Postfix) with ESMTPS id 4D4EE460D4C;
 Wed, 15 Jan 2025 10:02:46 -0600 (CST)
Date: Wed, 15 Jan 2025 10:02:45 -0600
From: Reza Arbab <arbab@linux.ibm.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH] virtio-balloon-pci: Allow setting nvectors, so we can
 use MSI-X
Message-ID: <4350e8a9-b3bc-4db9-bc02-611be01973d5@arbab-laptop>
References: <20241216163125.438156-1-arbab@linux.ibm.com>
 <040eea70-e991-4831-a564-bf3f6b917587@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <040eea70-e991-4831-a564-bf3f6b917587@linaro.org>
Organization: IBM Linux Technology Center
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wLOEXSYKr2vfjQvDNx3cytqb1D76KuOp
X-Proofpoint-ORIG-GUID: DKKrSUnMxg5vexfjG2WoDr_dlpRfz0OX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_07,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=650 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501150119
Received-SPF: pass client-ip=148.163.156.1; envelope-from=arbab@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1.793, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Jan 15, 2025 at 10:06:26AM +0100, Philippe Mathieu-Daudé wrote:
>>--- a/hw/virtio/virtio-balloon-pci.c
>>+++ b/hw/virtio/virtio-balloon-pci.c
>>@@ -35,11 +35,23 @@ struct VirtIOBalloonPCI {
>>      VirtIOBalloon vdev;
>>  };
>>+static Property virtio_balloon_properties[] = {
>>+    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
>>+                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
>>+    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
>>+                       DEV_NVECTORS_UNSPECIFIED),
>>+    DEFINE_PROP_END_OF_LIST(),
>
>You shouldn't use that anymore since commit 5fcabe628b8
>("include/hw/qdev-properties: Remove DEFINE_PROP_END_OF_LIST").

Ah, yes, that happened after I sent this.

>Also, this array can be declared const.

Funny, commit 1577a9180f37 ("hw/virtio: Constify all Property") also 
happened not long after I sent.

Thanks for your review! v2 incoming.

-- 
Reza Arbab

