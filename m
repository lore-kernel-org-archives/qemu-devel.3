Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E27B2C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 15:58:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY5mL-0004is-NT; Wed, 15 Jan 2025 10:58:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arbab@linux.ibm.com>)
 id 1tY5mD-0004dC-Ie
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 10:57:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arbab@linux.ibm.com>)
 id 1tY5mB-0003yO-93
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 10:57:53 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FDsmuG016777;
 Wed, 15 Jan 2025 15:57:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=YqBdLc
 yxfmpHzmjguCLBd1tty8UM7v94CcjP7GT/Muw=; b=iCpQAIyZ3EhFVuTq1mbN8G
 cV66xFeb4RcNIT93dzjBnLSQDuzL35OLxoWyaFUQWJQgT3pnYvXxiK1rchyWowg/
 +eNqmTFWeE1t3iw50ZFia/I43Lyu4BvVJQPO5uGtPKegJtPcKJtNTI7bSSbEfkQ+
 YHvy9eUrbwaEPyDTIrv0wCseYuFg6TtqHmlJ4oVDkhwsXprk7D5jpEah1U7RS9OY
 ged6ouBOKQpYtKmjwO7O3Zu+HJ0hl/ho80v7YvuSS/4c/vlaJ/gFYfbZLogmYJXY
 HrCpWeUh1+js/s2GFRg4v9VJWKRG91eRI5+N4EFRHcjgMrGEUkSTH6sHyqbAXmKA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4465gbu517-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jan 2025 15:57:38 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50FFr6sj000694;
 Wed, 15 Jan 2025 15:57:38 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4465gbu513-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jan 2025 15:57:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50FF6uSZ000875;
 Wed, 15 Jan 2025 15:57:37 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44456k0v74-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jan 2025 15:57:37 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50FFvawU23659202
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jan 2025 15:57:36 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C620D5805A;
 Wed, 15 Jan 2025 15:57:36 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B752358056;
 Wed, 15 Jan 2025 15:57:36 +0000 (GMT)
Received: from arbab-laptop.localdomain (unknown [9.53.178.221])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 15 Jan 2025 15:57:36 +0000 (GMT)
Received: from arbab-laptop.austin.ibm.com (localhost [IPv6:::1])
 by arbab-laptop.localdomain (Postfix) with ESMTPS id 2D7EFC8FC1;
 Wed, 15 Jan 2025 09:57:36 -0600 (CST)
Date: Wed, 15 Jan 2025 09:57:35 -0600
From: Reza Arbab <arbab@linux.ibm.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH] virtio-balloon-pci: Allow setting nvectors, so we can
 use MSI-X
Message-ID: <3e26638b-138e-498d-b155-d5cbe4a5651b@arbab-laptop>
References: <20241216163125.438156-1-arbab@linux.ibm.com>
 <cf465326-1eaf-4ad1-99ae-1e0d5a562a84@redhat.com>
 <b406b176-4b6c-4d82-824c-5c0ced0d9fcf@arbab-laptop>
 <20250115035133-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250115035133-mutt-send-email-mst@kernel.org>
Organization: IBM Linux Technology Center
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DIPn2k6vQg0kLNbIdcP3lQ-CwA0szDS3
X-Proofpoint-ORIG-GUID: WHOGknAsaXoe7JfaPiiQS38kMNg209Sc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_07,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0
 adultscore=0 mlxlogscore=652 phishscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501150116
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

On Wed, Jan 15, 2025 at 03:54:27AM -0500, Michael S. Tsirkin wrote:
>In file included from ../hw/virtio/virtio-balloon-pci.c:15:
>../hw/virtio/virtio-balloon-pci.c: In function ‘virtio_balloon_pci_class_init’:
>../include/qemu/osdep.h:261:35: error: call to ‘qemu_build_not_reached_always’ declared with attribute error: code path is reachable
>  261 | #define qemu_build_not_reached()  qemu_build_not_reached_always()
>      |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>../include/hw/qdev-core.h:956:13: note: in expansion of macro ‘qemu_build_not_reached’
>  956 |             qemu_build_not_reached();                                   \
>      |             ^~~~~~~~~~~~~~~~~~~~~~
>../hw/virtio/virtio-balloon-pci.c:69:5: note: in expansion of macro ‘device_class_set_props’
>   69 |     device_class_set_props(dc, virtio_balloon_properties);
>      |     ^~~~~~~~~~~~~~~~~~~~~~

Ah, I need to declare virtio_balloon_properties as const.

-- 
Reza Arbab

