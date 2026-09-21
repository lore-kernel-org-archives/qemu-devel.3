Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B16C982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 12:19:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8czy-0000nv-Hu; Mon, 21 Sep 2026 08:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxbr@linux.ibm.com>)
 id 1x8czu-0000bi-HH; Mon, 21 Sep 2026 08:19:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxbr@linux.ibm.com>)
 id 1x8czs-0000DW-M6; Mon, 21 Sep 2026 08:19:50 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LB5WbI1327871; Mon, 21 Sep 2026 12:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=drXrGJ
 tav62A+BzThidnHGgd9i3rIgWesrNrpbNAk0A=; b=O2Kj7bbxjNr4iykM1UNMTT
 ucg1TAmLlPZ42n/Oi+fWIVKVu05eF2Nri3DE9AsbVgbJAHQkrjLMJsRzln3kCp15
 wFGT/fG0l6EAKbdZgaZnynICeVKm3w37HU9fbAlKGxulNK0wAHN/3CoAU1nm41XA
 bWS1hrIMilJxaY39p2bZ+vUpJlDmrkcCxhVj2EivCnB7lQKtVYY4a48OdCXz5+Ry
 XrV+d2p9Mg1ZcMHkC7QAeJI/GqJfZdgYaO0ypvvHReVNu+lsr9d+6JalP+79l9su
 DxgRV9S9k3jwv1tHjdWSkpwC5Snmc8J93jgp/3MDDMbrIJkVkGXZ4AcZq6Mi9vNA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgs0eam-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 12:19:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LAlUaA1159913; Mon, 21 Sep 2026 12:19:38 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt6xgd0x0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 12:19:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68LCJYwB48759098
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Sep 2026 12:19:34 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 20B2020043;
 Mon, 21 Sep 2026 12:19:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CBED020040;
 Mon, 21 Sep 2026 12:19:33 +0000 (GMT)
Received: from li-fa2166e9-1f7d-4f1a-8ca5-7ccf0f022c25.ibm.com (unknown
 [9.224.79.183]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 21 Sep 2026 12:19:33 +0000 (GMT)
Message-ID: <8e5e07d2879d38231471d5db3cf3b2b1a306226f.camel@linux.ibm.com>
Subject: Re: [PATCH] s390x/sclpconsole: implement resizing for vt220 consoles
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
Date: Mon, 21 Sep 2026 14:19:33 +0200
In-Reply-To: <20260921121641.1354712-1-maxbr@linux.ibm.com>
References: <20260609-console-resize-v7-0-0c550fdcec15@gmail.com>
 <20260921121641.1354712-1-maxbr@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab120db cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=bNIeynoWs8fUgCxaHYoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: JwyJS5EUI3MMo3-GGGbJHNfVRkR9XlVK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE3NSBTYWx0ZWRfXwAZP+BWuBCBU
 N1f8dq1xA+JO358E65mLBx+Dm1mrdD6IvSORTfQ52QfzBm+B75mCoQti5gow2p+n/RA5FzfNuCo
 Y2aV8ERz1D61n+SfpHP1qIDW6zsXXH8PVq7fgN481F/zM0CLmaIrZcfp7DAYuYa8elAwpwIz4SQ
 jH9X+wRe9D9yYTL5e/jTZ6o8JmE6NoxCvvoPrqj1p9NKV/bb5MAhE3U5jQh/1qL5M9O/ZoxftOW
 u/fdy9HrdaSICKHP3K1tao8L31kJB84aNiwBZXgbAdmFlL2Tgiql4EQhx4BSGsK49vGWy+/NS0U
 6f0Lo7tNBp46FaDjhAcStW0KDb0vEj05Ca44q75dEfznx9CncPkYc0aOF5Gh1qVIIo+L0kVNBif
 Xo03Ybgz9qBgBx6n5FCwHdJZEesaAnzpzSk419R9GP/iuiVuLIxCh+DHFfF+xyDL/rBAqMYQjMy
 +OTJ8+FnmOFTnl44RKQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE3NSBTYWx0ZWRfX7vnSDwFEVix8
 zMw6UP5cesfP7o+CpU76AHW8HShUYSCKha56kizA2DKOiXIRlIAzhURR8mZT20n8Ggm6AGOYpqq
 U0JuWxiIMApIULHnUZREPwIcrP3PzNY=
X-Proofpoint-GUID: zotUIDBr39D-BWU7eDWA8vMqSjDaNYm9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1011 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210175
Received-SPF: pass client-ip=148.163.156.1; envelope-from=maxbr@linux.ibm.com;
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

For the Linux Kernel patch-set see: [PATCH 0/2] s390/sclp: Resize for
sclp-vt220 console
=C2=A0
(https://lore.kernel.org/all/20260921121619.1354611-1-
maxbr@linux.ibm.com/T/#t)

