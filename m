Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C54CF2562
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 22:58:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLUe8-00056w-4p; Tue, 18 Nov 2025 17:58:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1vLUe6-000568-2L; Tue, 18 Nov 2025 17:57:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1vLUe4-0002VL-HG; Tue, 18 Nov 2025 17:57:57 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AIH331E010636;
 Tue, 18 Nov 2025 22:57:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=H+VvkH
 BP0cLPZrNjXoL3UdU6ueCb9cXv5UEaF4MrxuM=; b=NIM5YXEorB7+GNZHzyU1oc
 YG5l2e+pWVsQugTe6+eilHeILzPLWrxt6ZW/7e16KlKzN9PlztUUSeBnHqHuH4Gc
 FvRqww7HpJPWtPNangHtZeHzn89f1kYSyF9gmhahagI59hck9DSioV5mAj0v7uPe
 bw7ESWQZyEL7X0ydWTGEFQPgQ1OyRbfku3PLmyGoJE8Umqi2Qmb3pS0PvNfxRlP8
 VemVIlH4FCuPZ2g8iSWM/tBUX30glkF1OF88f0/6QASUh7CfD58qYHQopRMRZD6p
 9CGZuLa40zkXKvcM36D0QA1PvuePOQ2ZdGKceiIXEa5JyMpeIkYyW6zBWf4bCtwA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejjw5m44-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Nov 2025 22:57:52 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AIMQ3oX010411;
 Tue, 18 Nov 2025 22:57:51 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4af3us5rws-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Nov 2025 22:57:51 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5AIMvlCn49611110
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Nov 2025 22:57:47 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B643E20043;
 Tue, 18 Nov 2025 22:57:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 109AA20040;
 Tue, 18 Nov 2025 22:57:47 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.111.14.232])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
 Tue, 18 Nov 2025 22:57:46 +0000 (GMT)
Date: Tue, 18 Nov 2025 23:57:45 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew
 Rosato <mjrosato@linux.ibm.com>, qemu-devel@nongnu.org, David Hildenbrand
 <david@redhat.com>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v3] hw/s390x: Fix a possible crash with passed-through
 virtio devices
Message-ID: <20251118235745.524c878a.pasic@linux.ibm.com>
In-Reply-To: <20251118174047.73103-1-thuth@redhat.com>
References: <20251118174047.73103-1-thuth@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BanVE7t2 c=1 sm=1 tr=0 ts=691cf9f0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=DF9jzra27_ti4jtxTWgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX3vBq4HEQTKhs
 zYi8EhaJHhF5uP/7GwC1YQn0FYsXUcVf64YaCoSvQxLkHrBR/IxRXAMmjTvePkAMImXOtGEu++R
 Em3jM6yTPCj0IAVv3951N8pre11sj38g1HT8MX/G7m5xtb4MIo42GZMPh1JZufPVchR4nmD4SiE
 nY+vYji1dKII6dtZICTJqCzKOOaafE+n2d6OMUdcq1Il0kryg2I/fBfVcThjIBCwNDqcKlt54wH
 2oDuufDVGYTK96R2BNk3bdZiUVqohFnMGoGBVcVtTbJTmFghUhCnh9qkQ+GlAmoA2qHH/q3BlKQ
 PZ/Vk4ncw5u9vofkCpYvF032Uuwi/nPNC0U/CwqyOe9FsfcfNDYm8jj+2rVuFTrQyF2R2vQrI0Y
 awFqf5ihilH8F3bR++U27DMSVVHJQA==
X-Proofpoint-GUID: blMqnCg5YWE3LU3U_b1vGwvw9saBypTb
X-Proofpoint-ORIG-GUID: blMqnCg5YWE3LU3U_b1vGwvw9saBypTb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-18_04,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0
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

On Tue, 18 Nov 2025 18:40:47 +0100
Thomas Huth <thuth@redhat.com> wrote:

> Consider the following nested setup: An L1 host uses some virtio device
> (e.g. virtio-keyboard) for the L2 guest, and this L2 guest passes this
> device through to the L3 guest. Since the L3 guest sees a virtio device,
> it might send virtio notifications to the QEMU in L2 for that device.
> But since the QEMU in L2 defined this device as vfio-ccw, the function
> handle_virtio_ccw_notify() cannot handle this and crashes: It calls
> virtio_ccw_get_vdev() that casts sch->driver_data into a VirtioCcwDevice,
> but since "sch" belongs to a vfio-ccw device, that driver_data rather
> points to a CcwDevice instead. So as soon as QEMU tries to use some
> VirtioCcwDevice specific data from that device, we've lost.
> 
> We must not take virtio notifications for such devices. Thus fix the
> issue by adding a check to the handle_virtio_ccw_notify() handler to
> refuse all devices that are not our own virtio devices. Like in the
> other branches that detect wrong settings, we return -EINVAL from the
> function, which will later be placed in GPR2 to inform the guest about
> the error.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

