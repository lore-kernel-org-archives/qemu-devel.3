Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A19BCD8CBD
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 08:27:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWrnX-0003Lr-NT; Tue, 09 Jun 2026 04:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxbr@linux.ibm.com>)
 id 1wWrnW-0003LO-6F
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 04:26:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxbr@linux.ibm.com>)
 id 1wWrnU-0003yr-JI
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 04:26:57 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 658K7E2d1448816; Tue, 9 Jun 2026 08:26:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=+IObn0
 l2Gziks6neqcqEfYkF0yRGoug8D8GCZdpQjQU=; b=qSoocQGVgtV+FZXLhC0iAu
 UBZr0BoylTntALY1iQfrc7B4krpAKfSihsHvwIk+THfSi4tIaP1AD2V8YsGFKyD7
 WaxYVxgjPz6GU3wXognnLN98x5Eiz4u1I2tahTXie3pf/y08cTWaATz3jJvnPlyn
 ZTePoddq1qphHuDdNFVNENPkNAqAy85OinlYIpF2xZjpfPVolfVDid8AzH0Pydp8
 At6GT8l/qKZceNT9JfdR2gM/kwvZisnbP/uAH5cyZdPqNLXuUiMXLqsXLDB90EC5
 P4fhCXRnBFfr3GnbpTwEI8CeEGI725Lw7bfTu0uWKEMESgudhbE43YV9ZoAmSswA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb7qk5q8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jun 2026 08:26:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6598JeO8006612;
 Tue, 9 Jun 2026 08:26:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en03g0xdy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jun 2026 08:26:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6598QaKm13107644
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 9 Jun 2026 08:26:36 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B69FC20043;
 Tue,  9 Jun 2026 08:26:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 83E3720040;
 Tue,  9 Jun 2026 08:26:36 +0000 (GMT)
Received: from li-9b52914c-2c8b-11b2-a85c-a36f6d484b4a.ibm.com (unknown
 [9.224.77.197]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  9 Jun 2026 08:26:36 +0000 (GMT)
Message-ID: <147cee86401993714fa94bd6cc79c4dbbdcaca52.camel@linux.ibm.com>
Subject: Re: [PATCH v6 00/12] virtio-console: notify about the terminal size
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Filip Hejsek <filip.hejsek@gmail.com>, qemu-devel@nongnu.org,
 =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau	 <marcandre.lureau@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Amit
 Shah <amit@kernel.org>, Markus Armbruster <armbru@redhat.com>, Eric Blake
 <eblake@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum	 <marcel.apfelbaum@gmail.com>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?=	 <philmd@linaro.org>, Yanan Wang
 <wangyanan55@huawei.com>, Zhao Liu	 <zhao1.liu@intel.com>, "Daniel P."
 =?ISO-8859-1?Q?Berrang=E9?=	 <berrange@redhat.com>, Szymon Lukasz
 <noh4hss@gmail.com>
Date: Tue, 09 Jun 2026 10:26:36 +0200
In-Reply-To: <20260609040710-mutt-send-email-mst@kernel.org>
References: <20260119-console-resize-v6-0-33a7b0330a7a@gmail.com>
 <cc0b8cce5bf5763ace058270e9d80fb84873dbd7.camel@linux.ibm.com>
 <20260609040710-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=HppG3UTS c=1 sm=1 tr=0 ts=6a27ce3f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=Bd7h0VvgvP5irlchiG4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: BHvgcPvxCC5IwgQNySJYsHfRQoQPK8uc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA3NiBTYWx0ZWRfXzABzt+T0aR/b
 A20N6XxDabtyYsF0s8n489LOlINwDxIiTqoeu4jY3Vvwt400tYSAM8Cq8WINR2WJXnrWwWR7zUm
 zOj23Tbi1n23itIPQ9016yZj7gBeFftmj4MIvOIts6XttM5sqJqU2tm07CE57bxBvcVz1UXGTXw
 dhscgzSHuebRxNwRUksGaQDSx0zJfc1hbwFD8ks4gjrP9rnYMQP4blT/CNMqg+b8xaEqL7Z4bFF
 8beHcQ1sybpSYG5df4mK+z4S7sJ2XDKPeq37JQBaR6vTZ7MZLSay0FZ6JLGXnd3GWKZv2SX258R
 x6+7Ei2uqpHHz5ZAQGpXeCDGuQA/NgDq6HZwcolYjyecyWjZLvQsEBYMumI6FNK+F8FZvNeHWeH
 GnHNRiHBb6VNKt/g8OT4EKA0GL+n72NGYzLYvAKJ3yraYXfCB6COMjeJe/im/xaFf1pxVIm2+nA
 4ZsOVg1nX4ZhKwsGDnA==
X-Proofpoint-ORIG-GUID: kKNSgZVY0j6xoiBTWLHv2Uo9J0nLwvLD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090076
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

On Tue, 2026-06-09 at 04:09 -0400, Michael S. Tsirkin wrote:
> On Tue, Jun 09, 2026 at 10:02:40AM +0200, Maximilian Immanuel
> Brandtner wrote:
> > What's the status of this series? It seems to me to have somewhat
> > stalled, because of the virtio resize event discrepancy that has
> > been
> > adressed by backporting the relevant patch. At this point it's been
> > almost 6 months since any changes have been made to this patch-set,
> > even though at this point it would have to be refactored to address
> > changes that have been made to QEMU since. Has progress on this
> > patch-
> > set just stalled or are there any remaining concerns about the
> > implementation of this patch-set I'm unaware of?
> >=20
> > Kind regards,
> > Max Brandtner
>=20
> Whom are you asking?
> There were comments on patches 7 and 8 and Filip seems to have
> indicated
> he intends to address them, and even posted diffs.
> So now, I expect v7 with that.
I suppose Filip for the most part. It's just that close to 6 months of
inactivity is quite a while and sometimes as other stuff happens people
can forget about a patch-series.

Kind regards,
Max Brandtner

