Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A66CFC9833E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 09:30:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB7gj-000662-FJ; Mon, 28 Sep 2026 05:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxbr@linux.ibm.com>)
 id 1xB7gg-00065K-Ol
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:30:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxbr@linux.ibm.com>)
 id 1xB7ge-000694-Tr
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:30:18 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S85akp2949521; Mon, 28 Sep 2026 09:30:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=oBXPAb
 6Oq8290B+mICedRHNCxEZJgYFoZBWM57m8lSY=; b=UC5V1l+rPQkm7aiqOaisVs
 rVDp0xEqpZMoIMx4HS9xfKcPDrglKNI63qnPZ7waD8KuNK75oRZ9weOy7yU9nm++
 Z3p9dWIl0c6lcpei8ff5L5UeCF2FycidYIgdAfwWUzDIkK8TpgOIlcWy3OAZ/Ff6
 Epqw/JDuDIZvtAG+wpKPBdQ/CSvvXhzVu+OZGGkvOg5Cb2HeX1mJgyeD38hbamfs
 0RO3EhrEiFrftx9WhGaBaxxiOzowVKI/yvXm2GR2i/O1ZgN0pcBn10A4Y8XE9yX7
 d9bkAdbkmb4bml/PQO9+ucvnvKKAQGLSB+2m2Pyk0tXysGMwXtIrJgTsWKOs1vOA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qr0dnu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 28 Sep 2026 09:30:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S9HnvO4077852; Mon, 28 Sep 2026 09:30:06 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsck4js0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Sep 2026 09:30:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68S9U4Zf38732128
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Sep 2026 09:30:04 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E6BC42004B;
 Mon, 28 Sep 2026 09:30:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B4C6D20043;
 Mon, 28 Sep 2026 09:30:03 +0000 (GMT)
Received: from li-fa2166e9-1f7d-4f1a-8ca5-7ccf0f022c25.ibm.com (unknown
 [9.224.79.183]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 28 Sep 2026 09:30:03 +0000 (GMT)
Message-ID: <e6ac40a4ff79b9c603c7548acbd8fad9c0c44c87.camel@linux.ibm.com>
Subject: Re: [PATCH v7 00/12] virtio-console: notify about the terminal size
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: Filip Hejsek <filip.hejsek@gmail.com>, qemu-devel@nongnu.org
Cc: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, Markus
 Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Eduardo
 Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Yanan Wang	 <wangyanan55@huawei.com>, Zhao
 Liu <zhao1.liu@intel.com>, "Daniel P." =?ISO-8859-1?Q?Berrang=E9?=	
 <berrange@redhat.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=	
 <philmd@mailo.com>, Szymon Lukasz <noh4hss@gmail.com>
Date: Mon, 28 Sep 2026 11:30:03 +0200
In-Reply-To: <20260609-console-resize-v7-0-0c550fdcec15@gmail.com>
References: <20260609-console-resize-v7-0-0c550fdcec15@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzNiBTYWx0ZWRfXzwMb4upKgoN8
 1DvyWk80pqZ6tdCDbkpmf7D85kn6khsdovEi1pphwUmWJ7Q4mg4xFJ4YsdpU4fxCErJyoxqw63G
 ze7H54nKxNEMuqLMlUKCv8iZFt5b7twWwkpXc6u/L4EneQnYfauQbIApQKQRUFRHhyClXtlTJ5Y
 uuIaph7ztv4FdTNhTz9iXnZowoZwoGHMd/colVLlW4fn2zKV3gcEmakjMkh2bvcVonbS88+ftio
 K85HcwXKfk9xt9p61bAw2DTxD+517yndRW4x5rd2dmDLn00xTNptUN1Skf7lSnyZazX36WoBzrG
 i91c77FRFGDPNOTTrPKc1+WjSqAxeN1R7xWZwfS1h0WJjptRXf6iu8tZM7Dt8e9LWoky+wzR15I
 OiKa+hWnk9lBqUewOC0JZueACTjpEVnoxlNUfgKyIud0Gfq/eA7Ev3bn6iwcpx6eeCB5EBCRCbC
 tSkJ2txGG7A8h4xdNXA==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6aba339f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=buZmngTagEdl8oIrSzwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: XfM1sE1W8vLy53Tf1psaH9Jyk2Oemwvm
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzNiBTYWx0ZWRfXx4j0abztomyy
 ckvaOAoEMEmm7YT9gOuf7rnhum/oMen7RcIYwCiHHvk+DbJjMl6vq0tDLmH4Thg9CMd4YViQwn3
 jBhUPQFIPf+17bqXw6vwvaFnubTIAyg=
X-Proofpoint-GUID: p_aQfg7ECKMnak44_lvbCwPzTYjsHXsa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280036
Received-SPF: pass client-ip=148.163.156.1; envelope-from=maxbr@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

I would really appreciate it, if this patch-set could be merged. I know
that things can get really busy, but it seems to me that there aren't
any blockers that should prevent this patch-set from being merged
(apart from some minor refactors), even as is. It would be a real shame
if all this work were put into this feature, just for it to rot on the
mailing-list.

Kind regards,
Max Brandtner

