Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE9FD6E2DC
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 19:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWJru-0008U2-CW; Thu, 18 Dec 2025 14:40:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vWJro-0008Te-22; Thu, 18 Dec 2025 14:40:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vWJrh-0008Nf-Dl; Thu, 18 Dec 2025 14:40:48 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BIBJfK4018517;
 Thu, 18 Dec 2025 19:40:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=uCPGvn
 j2OELd1uD/qAByl9yyn/0K2ng93/bgZOnL9c8=; b=HbpYt3KaKB4CZAl5+VW0k9
 1TaXdsvdELa76aO+6jkKgZvbXmamxpubf9OJZVdleFaD01ySF4lNxOxFhR6/vjnU
 knwAeFZ4QU26R+LCDSDgnromTT/cER8/oPV13azhFePOAjuHV8Qia6x9Px5hR+L6
 5vRRlKqIAQw7uCipuDw/9RtimWYeKVWT8ym+fzkLPhWCgXAHnqs2QJDIFA5nW4Ha
 vfbDFGXUK7WAwF/kTIf1aGlsS4her3x0UdzkudnfPm0yeGz9oqPiIbovrB86cmro
 WvkeK58u+UyOca/v/+7h2i7dxcmJ5V4tkGnaq92c4q5E4Yz3BAmgTa8c0OlRqp0g
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yvbmgcb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Dec 2025 19:40:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BIJXuJj016368;
 Thu, 18 Dec 2025 19:40:35 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b4qvr00t8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Dec 2025 19:40:35 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BIJeYi626149378
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Dec 2025 19:40:34 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6F34A58059;
 Thu, 18 Dec 2025 19:40:34 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 527BB5804B;
 Thu, 18 Dec 2025 19:40:33 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.79.187]) by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 18 Dec 2025 19:40:33 +0000 (GMT)
Message-ID: <99785a08c0f29f84b9c6e4b971532b43998f7f53.camel@linux.ibm.com>
Subject: Re: [PATCH] hw/s390x: Un-inline the s390_do_cpu_*() functions
From: Eric Farman <farman@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Ilya Leoshkevich	 <iii@linux.ibm.com>, David
 Hildenbrand <david@kernel.org>
Date: Thu, 18 Dec 2025 14:40:32 -0500
In-Reply-To: <20251217144238.37610-1-thuth@redhat.com>
References: <20251217144238.37610-1-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=V/JwEOni c=1 sm=1 tr=0 ts=694458b4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=GnlyYoKnFeKzSITRfPQA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Xq797lwABaMfjegahKw8-pnZJuOROhJe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAyMyBTYWx0ZWRfXw7CulBZq9kHH
 9NgrK5dPSdNJroedWoWJPQ8C/6RD+RrK8gP0bjAiuWm2VhXjAudVtnaWH4GxA3SxAjhjADJBFK9
 jBul4+TVDddkA/wx/tPilZutDtj9iA6mU3ukSx7lYbbrE0JKYzDkO+pb14s4NmhFNcbW9NFYTUD
 O31fGHB7N9lBSJjXkwDCSisP8BeU0k1QEXPn1/+Ekyj9hCZAqGaRwfLX7EG9l51zsW7RosrPNCy
 5QyaQiByBqg62GRqifhdCKjVTl+iBQ6BI49QwcRE7KNDkM5AT+C6X3I3VX3MhXyWvDQ7A48C/s9
 VYOiDoHOQHmEMeb+p861/mlLni+VGx5ufNxTYhCkW4K+HNoTP/pS/+Qh7pUDqbmNjscFG5h9inW
 GGXSt2NtNFaxuihURK48GzBZ7ArHAQ==
X-Proofpoint-ORIG-GUID: Xq797lwABaMfjegahKw8-pnZJuOROhJe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_02,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130023
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, 2025-12-17 at 15:42 +0100, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
>=20
> These functions are only called via their function pointer by using
> the run_on_cpu() function, so it does not make sense to declare these
> as "inline" functions. Move the functions from cpu.h to either cpu.c
> (when they are still used in multiple places), or to s390-virtio-ccw.c
> (when they are only called from that file).
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  target/s390x/cpu.h         | 24 +-----------------------
>  hw/s390x/s390-virtio-ccw.c | 19 ++++++++++++++++++-
>  target/s390x/cpu.c         |  5 +++++
>  3 files changed, 24 insertions(+), 24 deletions(-)

Reviewed-by: Eric Farman <farman@linux.ibm.com>

