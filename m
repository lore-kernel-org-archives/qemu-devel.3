Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2843F94CB4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 22:43:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFJoK-0007cq-RG; Tue, 21 Apr 2026 18:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1wFJoI-0007cJ-E2; Tue, 21 Apr 2026 18:43:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1wFJoG-0003Vg-Td; Tue, 21 Apr 2026 18:43:14 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63LImJeW878092; Tue, 21 Apr 2026 22:43:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ffKePl
 +cc+i3b2+1hSp0iQVgwlZO0nBzujhjTqLATug=; b=LATXFl62iQhvgPLH0//7ez
 B0QgfrEqPzA1QKAQzqg5VuF9OMJdJgZFP65PYfSW8v3e3LUphSUj4aiuoeNFR6fd
 ayokxHWNq3+3Ohq0xL4d2MN1+C389c0D0ZjqiIOWV9V2f7titrndMvi5XcXX8W4z
 /oKe0kX1cJLoUCaIjjieHk/geII9J+xIo36xcmPWcua5sHy47kLSZ29nfhi8a5V1
 HnIdQehUXUlN2hynhwgOg9BzMDg3lgCaOBY9CMFWXwpilEL5LtanlsIoD7fQRwzA
 J/ng9bYg4nAdqG7RGojfqbm+2Wr4KwV+vHYvmZv1nAHD8R+4s7wLIxmjGDshRi+w
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu20qd3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Apr 2026 22:43:10 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63LMZWRf006347;
 Tue, 21 Apr 2026 22:43:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dmpyy2ckb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Apr 2026 22:43:10 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63LMh6Es42991928
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Apr 2026 22:43:06 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9B7742004B;
 Tue, 21 Apr 2026 22:43:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 15CB320043;
 Tue, 21 Apr 2026 22:43:06 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.111.29.83])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
 Tue, 21 Apr 2026 22:43:05 +0000 (GMT)
Date: Wed, 22 Apr 2026 00:43:00 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Eric Farman <farman@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: Update s390 trees
Message-ID: <20260422004300.75cf2007.pasic@linux.ibm.com>
In-Reply-To: <20260417152236.1305333-2-farman@linux.ibm.com>
References: <20260417152236.1305333-1-farman@linux.ibm.com>
 <20260417152236.1305333-2-farman@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDIyMiBTYWx0ZWRfX3qwdzBH8n3Ry
 E/oHQl791migX3JBwpkbPnd+flr937eCNURrtDrURqA/QkeJ/WFuqbd/aP3ZXNF2dQ/1hZxPWhP
 +2Xjlx5z4tV/MTcSlDaxSJ6UJH1uDlVbygp0iRZ+Vum2RA1rLMBsPJK35vWPpUD8tDATc455JUv
 ZqvM3chuFwqU4diiLr/xiTY8/INwL655WGiANfEyt+Y9qeQq5NdZjf7+mxW6T2PUrayM/2DGoVc
 2mq/mqUto2wtUrNelpPys1jAHpuUyXSmtR/3YWUQQedv7oWGQUO8Z3Mmv/KJjrX5hFWx54LCBEV
 6J3yMQ2ciJlfONyqDBIuPEwE/qKui5pHzlBxdpFrCuOUHF6WY0DQGMQKm8iZ5oYEL9AaU0QVcvT
 b2aFIWOTJN2/v8aOpqOyFNa90/iHIRf9TI6uJoKu0kIiM2FJ1loTT8AhmKSjstVtr/OLmkx5TyQ
 dTP6FVHyzPIcUlcm2lA==
X-Proofpoint-ORIG-GUID: yHgh0o2_WSxuVq5MpMm27UGBixcUTxPb
X-Proofpoint-GUID: yHgh0o2_WSxuVq5MpMm27UGBixcUTxPb
X-Authority-Analysis: v=2.4 cv=XMUAjwhE c=1 sm=1 tr=0 ts=69e7fd7f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=Te5-KOB4WXpanfHyCXIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604210222
Received-SPF: pass client-ip=148.163.156.1; envelope-from=pasic@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 17 Apr 2026 17:22:36 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> Move Cornelia's git tree from virtio-ccw to the overall
> s390 architecture group, since all the subgroups funnel
> up through that.
> 
> Remove Christian's tree from the subgroups, since they are
> not specified consistently across areas but also haven't
> been used in ~6 years.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

Acked-by: Halil Pasic <pasic@linux.ibm.com>

