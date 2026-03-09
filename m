Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA313FCA19A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 22:28:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzj4y-0000jA-41; Mon, 09 Mar 2026 18:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vzj4v-0000iN-SQ; Mon, 09 Mar 2026 18:27:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vzj4u-00007K-Ca; Mon, 09 Mar 2026 18:27:57 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 629KNS183756393; Mon, 9 Mar 2026 22:27:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=mOr0Ho
 NF3QfjdQJPN3kW7OFCuh3OYnrOjBRDx29WAKQ=; b=IYmvg+2IgPhuZ9w/x/RI3O
 lQ/fmF2z99bwhVpF541UnP1iFY4J+UxS4ja46E/jdkiRM9jk5vpWIWSRfdjskJH+
 0GWN6O3OwI8rhtxThFCjAxnLjsDK+pYcn7Rl4pokl/UNEAyFVnEcat1NFxDZjTf1
 ozZ2rOLdY+C6Va4vbiNEVj9slJHPyiMTMOnSzNqS4kwWxiLsSogS/YkekbMx4fOt
 X6oymeAQ5R/KB0ppkIj+F0ZY2000S24xNHSCX2sYo6evZUWYDsMoRZa8xNHTYWJr
 N6ZHFjTkd/iCsBE9wBBQFFVal4ZEXiq7xdJCShYArZZ4akomCccNxqsQxf4Q6aMg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcyw8m4t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 22:27:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 629KTLcS015706;
 Mon, 9 Mar 2026 22:27:52 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cs121xg3h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 22:27:52 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 629MRotY26804780
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Mar 2026 22:27:50 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7E8CE58052;
 Mon,  9 Mar 2026 22:27:50 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AB11B58065;
 Mon,  9 Mar 2026 22:27:49 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.185.62]) by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Mar 2026 22:27:49 +0000 (GMT)
Message-ID: <da97038a7c0a9ad250dd840ceb6a448b8c0df3c3.camel@linux.ibm.com>
Subject: Re: [PATCH v5 11/15] pc-bios/s390-ccw: Introduce virtio-pci functions
From: Eric Farman <farman@linux.ibm.com>
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 thuth@redhat.com, mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, mjrosato@linux.ibm.com,
 zycai@linux.ibm.com
Date: Mon, 09 Mar 2026 18:27:49 -0400
In-Reply-To: <20260309003601.242634-12-jrossi@linux.ibm.com>
References: <20260309003601.242634-1-jrossi@linux.ibm.com>
 <20260309003601.242634-12-jrossi@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDE5NiBTYWx0ZWRfXwNMK0t+o7f5o
 2ka7MfhAKFDKPDRdPZl2XuK41VrtilB3ZS+Ys0m57Iznv3S0jzRhEdSuGm6Sv8ZYCrbcz9LZvKv
 dBXqqIN+1Qe4LhHQNoVUoqOkj/aKt4X+kUxkcu3xYAshLrrcw/ubS7Vyb0hJhKeVx2J1m6fTpUx
 SZXQc0zmuVSgrHrd8VWtlEkMUZqUCrDITWPcXWFSFYunjpi7bkvWACSw4wszmww0/kpTnYBAAPR
 /48KlqO3TLKc0fPTZefiFZ9UktqbMo85bRLI+gIMBIYqGh6tdsJKoKugdzjWyQvzZcO6NvUAMS4
 4VL/KGefjDIE8VA7Rr15xNUTdDdpeYwBCqoJ+7g/xNotEXcNSyeiOV9ZHQ9t63Oi2T6+xGSU+xz
 gR2VnBZ3wyd4Xn0dHOc39PxJ85PmMJj4lBABS3D8V9bBwPxw/UKwvEgaUu1PIDUp4rQ3WD8OQGz
 VQaNpzdNALyDlvlJHkw==
X-Authority-Analysis: v=2.4 cv=QaVrf8bv c=1 sm=1 tr=0 ts=69af4969 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=C0PV6cu7Yr33yCaZjcoA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: dGFRQqUO_oACmkKaai0Xz1sJ8Tas7CXq
X-Proofpoint-ORIG-GUID: dGFRQqUO_oACmkKaai0Xz1sJ8Tas7CXq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_06,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090196
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sun, 2026-03-08 at 20:35 -0400, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
>=20
> Define common functionality for interacting with virtio-pci devices.
>=20
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/Makefile     |   2 +-
>  pc-bios/s390-ccw/virtio-pci.c | 167 ++++++++++++++++++++++++++++++++++
>  pc-bios/s390-ccw/virtio-pci.h |  80 ++++++++++++++++
>  pc-bios/s390-ccw/virtio.h     |   3 +
>  4 files changed, 251 insertions(+), 1 deletion(-)
>  create mode 100644 pc-bios/s390-ccw/virtio-pci.c
>  create mode 100644 pc-bios/s390-ccw/virtio-pci.h

Reviewed-by: Eric Farman <farman@linux.ibm.com>

