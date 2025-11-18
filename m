Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50FB2CED617
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 12:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLKPz-0006pp-2c; Tue, 18 Nov 2025 07:02:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1vLKPs-0006m5-Fs; Tue, 18 Nov 2025 07:02:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1vLKPp-0001mG-GN; Tue, 18 Nov 2025 07:02:35 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AI6HmYQ026824;
 Tue, 18 Nov 2025 12:02:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=fSdgtz
 fIn3fC7K6xxYVTGCywPnkIeKPfpCuzZV+nCL0=; b=gBre8nddgC98toMVtDKO88
 V4wcPNLc6SKymst4QmdpM7cKblGZSWNobgVXwiXAstbEJS0R5DjL+BW6E9G1pv3K
 oNDzgvRjg88J2utrrtyIhtdYbuGxq46o3fxHm3Zh/75bLK5ZzG7sghOQk2QSIaQZ
 EHFc08cv4HQb5y/qwNIlOspvx/JgyOwW1RMTxxisUnrxwaelz4PVP230xnxgqBCQ
 m7eqwe3LClFCUjiXlAwDg/olbZUSJ8cqL2XojnxVLsqej7LpMCBDZyiqy5yXvI+u
 YxyPb+0+aNCRbykkfsw1o01jGwLMwxb7n8PgxwC/GQdvyXRyxH+58P8fFSnwJsIg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejk9thxv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Nov 2025 12:02:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AIBZPot030813;
 Tue, 18 Nov 2025 12:02:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4af47xu1yr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Nov 2025 12:02:24 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5AIC2Kth51839326
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Nov 2025 12:02:20 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8B0FA2004B;
 Tue, 18 Nov 2025 12:02:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4511920043;
 Tue, 18 Nov 2025 12:02:20 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown
 [9.155.208.219])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Nov 2025 12:02:20 +0000 (GMT)
Date: Tue, 18 Nov 2025 13:02:18 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew
 Rosato <mjrosato@linux.ibm.com>, qemu-devel@nongnu.org, David Hildenbrand
 <david@redhat.com>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v2] hw/s390x: Fix a possible crash with passed-through
 virtio devices
Message-ID: <20251118130218.30d3da33.pasic@linux.ibm.com>
In-Reply-To: <20251118093945.35062-1-thuth@redhat.com>
References: <20251118093945.35062-1-thuth@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HYz3687Fg-G6QpNEcC0jSrhYFPENAkZy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX15hlCOGHYQrv
 AJQoPUZmYvvMlDw3tkdG9cIIuVY+YQu8VUqeCi9WhHZRIRP3abEYT8gulqoefGj7BpHX+t9pu5k
 wD7TT8TlZF93WqlgYvWDWiS7SQ/SEX8FTzlFHwsNzzQ2CSJ/Df5HXiWBP2EbzqROZA1uaMiY4fI
 pib8ehLec/8NhLs7fObuH4660RzbiG9Joa9axuj0ntaKecU4PoCD/PsHFP0jAxWAjoRlJyCM7Yw
 HBYj8f+wthzKzeIMjaOpOwdx4TqCHDC+f01KF0bnksjML4zJ3m3Z0Ei9DPV2CHwp8xLg9vQrajr
 sbsBlwazGn6gqPhaiVqFQrpza9OhzuBDnM9HB+QaFH4VXYT049chVsz18h3tLg+Jusj3xNE3VeH
 9JkpZuYgwj4q/t4lLVqP5SX2eFhI1g==
X-Proofpoint-ORIG-GUID: HYz3687Fg-G6QpNEcC0jSrhYFPENAkZy
X-Authority-Analysis: v=2.4 cv=XtL3+FF9 c=1 sm=1 tr=0 ts=691c6051 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=S9weJagr-DqW-FnTzl4A:9 a=CjuIK1q_8ugA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032
Received-SPF: pass client-ip=148.163.156.1; envelope-from=pasic@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, 18 Nov 2025 10:39:45 +0100
Thomas Huth <thuth@redhat.com> wrote:

> Consider the following nested setup: An L1 host uses some virtio device
> (e.g. virtio-keyboard) for the L2 guest, and this L2 guest passes this
> device through to the L3 guest. Since the L3 guest sees a virtio device,
> it might send virtio notifications to the QEMU in L2 for that device.

Hm, but conceptually the notification is sent to the virtio device,
regardless of hypervisors, right? But because for virtio-ccw the
notification is an DIAG 500, we have the usual cascade of intercept
handling. And because we have never considered this scenario up till now
the intercept handler in L2 QEMU gets called, because it is usually the
responsibility of L2 QEMU to emulate instructions for an L3 guest.

I think vfio-ccw pass through was supposed to be only about DASD. 

> But since the QEMU in L2 defined this device as vfio-ccw, the function
> handle_virtio_ccw_notify() cannot handle this and crashes: It calls
> virtio_ccw_get_vdev() that casts sch->driver_data into a VirtioCcwDevice,
> but since "sch" belongs to a vfio-ccw device, that driver_data rather
> points to a CcwDevice instead. So as soon as QEMU tries to use some
> VirtioCcwDevice specific data from that device, we've lost.
> 
> We must not take virtio notifications for such devices. Thus fix the
> issue by adding a check to the handle_virtio_ccw_notify() handler to
> refuse all devices that are not our own virtio devices.

I'm on board with this patch! Virtio notifications are only supported
for virtio devices and if a guest for what ever reason attempts
to do a virtio notification on a non-virtio device, that should be
handled accordingly. Which would be some sort of a program exception
I guess. Maybe you could add what kind of exception do we end up
with to the commit message. I would guess specification exception.

But I would argue that the L3 guest didn't do anything wrong.
Pass-through of virtio-ccw devices is simply not implemented yet
properly. And even  if we were to swallow that notification silently,
it would be effectively loss of initiative I guess.

So I think it would really make sense to prevent passing through
virtio-ccw devices with vfio-ccw. Eric what is your take?

Regards,
Halil






