Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E37F9CA5FAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 15:20:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBZdG-00043h-QP; Tue, 29 Sep 2026 11:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxbr@linux.ibm.com>)
 id 1xBZdC-00042g-U6; Tue, 29 Sep 2026 11:20:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxbr@linux.ibm.com>)
 id 1xBZdB-00071m-7r; Tue, 29 Sep 2026 11:20:34 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TB5bHG2783548; Tue, 29 Sep 2026 15:20:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=WS1ruF1kykFIFhD5G
 JOu/ItzgXSTdB/c/Y0zHaiGx+U=; b=WLaB5qrSYkxBTV3l5Vrxq4VRritUlijxX
 jbXpYyM/dh6p5UaGmgX0yNBYR+tYSqM7qaWo/Epfm5SLBundsXNTbNWWCM3NSeDJ
 R1OJd84KOXtDu9E9Lnr37ZWXtT93Dm6zZfVwCgnsTCbMNtgpcO12abZzHh7o0dlU
 Ge2vQX7tzNHpulDGy1jGn5HtqlZtlfY76opr8JNFdSknhMHRokLqdp7oqe7ZLM2Y
 uwsT0hsh2yNfOHL8+fq5XlweSpZ/tIbc1M2oWuH5wE+zRYzHPMlLKy+0wGHWUOMM
 +M0NVHu2Hxf76FIHpxwsaJt/bMqXigoS5nixiIm163rtv+Eg2Yxhg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fe75ev-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 29 Sep 2026 15:20:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TF3rIB1617007; Tue, 29 Sep 2026 15:20:19 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxrrwact3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Sep 2026 15:20:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68TFKFTm50921880
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Sep 2026 15:20:15 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 39AD520040;
 Tue, 29 Sep 2026 15:20:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D66E120043;
 Tue, 29 Sep 2026 15:20:14 +0000 (GMT)
Received: from li-fa2166e9-1f7d-4f1a-8ca5-7ccf0f022c25.ehn-de.ibm.com (unknown
 [9.224.79.183]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 29 Sep 2026 15:20:14 +0000 (GMT)
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: filip.hejsek@gmail.com
Cc: amit@kernel.org, armbru@redhat.com, berrange@redhat.com, eblake@redhat.com,
 eduardo@habkost.net, lvivier@redhat.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, mst@redhat.com, noh4hss@gmail.com,
 pbonzini@redhat.com, philmd@mailo.com, qemu-devel@nongnu.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com,
 qemu-s390x@nongnu.org, mjrosato@linux.ibm.com, brueckner@linux.ibm.com,
 farman@linux.ibm.com, cohuck@redhat.com,
 maximilian.immanuel.brandtner@protonmail.com
Subject: [PATCH v3 0/2] s390x/sclpconsole: implement resizing for vt220
 consoles
Date: Tue, 29 Sep 2026 17:20:10 +0200
Message-ID: <20260929152012.2696005-1-maxbr@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921121641.1354712-1-maxbr@linux.ibm.com>
References: <20260921121641.1354712-1-maxbr@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6abbd734 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=AYD_gkTrYqsp6PCdjuYA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA2MCBTYWx0ZWRfXxBYUC0TlNcPk
 LwpeTxpwgfFz+Ahb+ABxnHq75IfW/CODWCR9i6Y1maYqDD7TKzMPJByxmyb4NeGwOuXium/q4aE
 ybrEklhB6BaC9Omlube8/FXdEYfEORw=
X-Proofpoint-ORIG-GUID: C_wxHJ7-MilUg2WGJyYQXgUMSkIzhlw1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA2MCBTYWx0ZWRfXy5TAxXj69SaE
 85kjnxnxzyAQcBKWAKhU3orLQdrhDJBb7TGrubY+a3ECHWQ/Kzor3f9aVRo+MhkOyLo9OSKHpn8
 1DB+o84FwT8B7UZ3LSU+I0vWPp1fjEjARLtgy7WNu9wQmhYZXuFLxzjCPwHGpHax28XPuk7U8o6
 VpctAbEnEAQIsqLkjF3kdMdsAvWxTDuSJ8GRreXl+vDqcsE1b0AjXO0is/79mFs+K886FqalIFu
 QM9wz6RnFKte3HmMx/Fbgh30hhTE0cg6ckC7OFMNWAMrMdPHi4PKPUYXJ/dmFu0CsNSkuxBP/5I
 zReVyb8Z1RHpba+r7zY2iE87GB7cOAq4hXRroT6pbV6LzrkUhNRESmeUQ900shI1U8SnkUNOVPQ
 yKODQN0ZRP89zWmSGvvARFrae/Ra00ZeOOewDa3dtukHu15w8cQntTPwFG0qsxUz40oHoc0rgzO
 ffHRZ/2GKT7Nt39GLFg==
X-Proofpoint-GUID: x4UrWAYZ6KJ5zUgvukBWWLXtga333zUM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290060
Received-SPF: pass client-ip=148.163.158.5; envelope-from=maxbr@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

This patch-set implements resize event handling for the vt220 console.
Add a tty code to indicate a resize frame. The body contains two big
endian 16-bit integers rows and columns.
---
Changelog:
v3:
- split console_reset indentation fix into its own patch

v2:
- Use packed struct and named event type codes for resize frames
- Trigger initial resize event in console_reset() instead of
  console_init(), skip when chardev reports no size
- Reset event_pending after resize event

Requires the following pre-req:
    [PATCH v7 00/12] virtio-console: notify about the terminal size
    (https://lore.kernel.org/qemu-devel/20260609-console-resize-v7-0-0c550fdcec15@gmail.com/)

Testing:
- Tested on QEMU: commit 38879a667f with the following patches applied:
    [PATCH v7 00/12] virtio-console: notify about the terminal size
- Tested on linux-next (commit c1f49dea2b8f) with the following patches
  applied:
    [PATCH 0/2] s390/sclp: Resize for sclp-vt220 console

Maximilian Immanuel Brandtner (2):
  s390x/sclpconsole: fix indentation for console_reset
  s390x/sclpconsole: implement resizing for vt220 consoles

 hw/char/sclpconsole.c | 92 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 80 insertions(+), 12 deletions(-)

-- 
2.54.0


