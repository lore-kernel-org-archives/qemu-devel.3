Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48731C44501
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 10:40:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viVcz-00026G-Au; Wed, 21 Jan 2026 05:39:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1viVcx-00024M-2e; Wed, 21 Jan 2026 05:39:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1viVcv-0001Wk-7I; Wed, 21 Jan 2026 05:39:54 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60KMv06u021317;
 Wed, 21 Jan 2026 10:39:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=r7Y+Oj
 cGEygVXH5bPtPqdv90fENkyWIzcQIMBGnUDfc=; b=emj4rD1HgpldMPJz+YQInH
 dNor4TdehfDVcGu5865nefuTqIY97pXAJWxmht/hr3WVl8RleWhGUl8CXpTZRo1/
 f9ErBbxn6SMLlzGN3osIydUdqqk7IAEGqubbIrl3Fv2s4qkVytbLtsgETwIfjWZj
 d3P9cxUpnOqfVCnAXj/kUHiuhcOA65ZzN1hbh9jyrMua8TzSyWYMUorvJIeJoSNh
 atM+lJUZFP4pQON/+o6TVZAuVe2v3tkDC/oW1VFob9FFHqI4e2PEQtWkP4EPehX4
 lrAkNU9o9wtfrSBK3ob0hAp8taspuKZJsCB0skTY7kgnqXQf8MIwcXMb6BzwJd6g
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bt6126qsr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Jan 2026 10:39:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60LASFNs024634;
 Wed, 21 Jan 2026 10:39:45 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brxarsn1u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Jan 2026 10:39:45 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60LAdfTx37421350
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Jan 2026 10:39:41 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3892E2004D;
 Wed, 21 Jan 2026 10:39:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E99232004B;
 Wed, 21 Jan 2026 10:39:40 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.52.198.210])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 21 Jan 2026 10:39:40 +0000 (GMT)
Date: Wed, 21 Jan 2026 11:39:39 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, sgarzare@redhat.com, raphael@enfabrica.net,
 qemu-devel@nongnu.org, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 qemu-s390x@nongnu.org (open list:virtio-ccw), Halil Pasic
 <pasic@linux.ibm.com>
Subject: Re: [PATCH v4 07/23] virtio-ccw: virtio_ccw_set_guest_notifier():
 fix failure path
Message-ID: <20260121113939.109e525e.pasic@linux.ibm.com>
In-Reply-To: <20260119185228.203296-8-vsementsov@yandex-team.ru>
References: <20260119185228.203296-1-vsementsov@yandex-team.ru>
 <20260119185228.203296-8-vsementsov@yandex-team.ru>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AjZlXPrY7dsoEoVfZb2Fgrtb0XoBWu5e
X-Authority-Analysis: v=2.4 cv=LaIxKzfi c=1 sm=1 tr=0 ts=6970acf2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6R7veym_AAAA:8 a=VnNF1IyMAAAA:8 a=49E5kkUQfOZ3Knp8DMQA:9 a=CjuIK1q_8ugA:10
 a=ILCOIF4F_8SzUMnO7jNM:22
X-Proofpoint-ORIG-GUID: AjZlXPrY7dsoEoVfZb2Fgrtb0XoBWu5e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDA4NiBTYWx0ZWRfX8YuLOSHh9Bnc
 VtS1mAlKaYk9p1xArSSpYWiSkh18GyJmzHzwEoJW8q/bOs2XZPcL6Z5TTrHN1BhZSpjGmHxfZJu
 JJitPy71g3tNprqcYz/YBQKW7DOMlwjUM0vPOLxIrt6KOSi12zaLeBdw34MsWag1Sbd5OHOE1kn
 SI1tzC7xdushWU4j/6s+X3Xd0oNH2lOrwKEb24pE8RppA7aUX6yIO0OGQzpkzVEo3nVx41uOnP0
 O4GIS6j5noDKRbgdiYfmY8AiDLUm9Ur4l2i7IpU4DdP+/2kEE/yq/WUGRDzFcyqptmc69wjyuOj
 DOH7eVNUuVmhgsxOsu2DBLb/4HWmc0ACRZG5/ntasplDrFejqK+2weNR4Mm5yvU5HMDOKTIsMtx
 Q7cdHrbk/ry09Ghxa03DZAovB2DK+opxWL7Rg7xv4D4Z9F0oYJVRkaIWriPzZYJjAk83lfgJ3hh
 k3D/HM/gXrz8Ut8odKA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 clxscore=1011 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601210086
Received-SPF: pass client-ip=148.163.158.5; envelope-from=pasic@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 19 Jan 2026 21:52:11 +0300
Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> wrote:

> We leak notifier initialization on that failure path. Let's
> cleanup it.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

