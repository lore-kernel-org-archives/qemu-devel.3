Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED4BC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 02:05:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf6n3-0008Sz-0O; Wed, 01 Jul 2026 22:04:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wf6n1-0008SR-F4; Wed, 01 Jul 2026 22:04:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wf6mz-0002DJ-VZ; Wed, 01 Jul 2026 22:04:31 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6621KXXh2390254; Thu, 2 Jul 2026 02:04:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=j3Q+zm
 pi7T04n+qKxK0U/6rx+3fPBubV8x+ihF9wd80=; b=nWykHHQPkGHjHVMvllv3jW
 k9L7ucyzPTKjWxOMKW86ByPvij7pxxhWscshwcME/gAUQpDL8fEDON6RgE9XHVNL
 s0vn48A+//xHHYvk9Gre/u2VmW/X+zS0SzsYc/4L05TE2XJMlmkmMPCyoO1e684J
 HDakQr7ifC3l1/QLVsW8YkqPyUAaPQulJ0Oe+GZHYMGEAa2Q7YJGDHQtcs8uHEBe
 gwqmDmrldn1pF9kztwmWKo0okSnjsAOPvMiuuBAJ5mN6wY4bAZVrPfKbgsXEaEpt
 2dSrN2fT17TJMGFWO63dmB+VA1OSBjiLnE0m2zqmNLTA0bgOGCEQEaF4TvgGj3Eg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qa785q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 02:04:28 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6621ngdN006225;
 Thu, 2 Jul 2026 02:04:27 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruqj71r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 02:04:27 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66224QZV30409284
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Jul 2026 02:04:26 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1D20A5805E;
 Thu,  2 Jul 2026 02:04:26 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 79F1358058;
 Thu,  2 Jul 2026 02:04:24 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.136.69]) by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Jul 2026 02:04:24 +0000 (GMT)
Message-ID: <c80d3ccc133b3a869dc3e3a8cb5ca9254eac62c0.camel@linux.ibm.com>
Subject: Re: [PATCH v2 5/6] pc-bios/s390-ccw: write IPLB location for
 non-net virtio devices
From: Eric Farman <farman@linux.ibm.com>
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 cohuck@redhat.com, mjrosato@linux.ibm.com
Cc: zycai@linux.ibm.com, jdaley@linux.ibm.com, jjherne@linux.ibm.com,
 nrb@linux.ibm.com
Date: Wed, 01 Jul 2026 22:04:23 -0400
In-Reply-To: <20260630141917.673995-6-jrossi@linux.ibm.com>
References: <20260630141917.673995-1-jrossi@linux.ibm.com>
 <20260630141917.673995-6-jrossi@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAxNiBTYWx0ZWRfX4x5tcGTKwley
 MqwLLZG5KFGKtbSoDHn2gFobN41t8focik3UFVCoCzET/iswmlQaZ3E65uRx6mEDZwYzan37b0v
 7fgFwMsH5buur3XkPYsFsEmOfq7Xiw3K4CObDLMggqANqoSIvHi5BLN6obYN7wDa7D0IEVjra+V
 m1LcZOKqw4FWYNLsmAxaZ8G5e6WeiZOChq0qhSWkB2zHKndw0yNAx4oak++1Iu9kC2S+0L36AMb
 RJhinLHWw7RQkjVXzVraGhj/OVjDgpD7L+UgXnFg73WKt8crSwImdj6eoDb0bdMlBrQiVYaxCTK
 SSIz3jWXcoqQMoVo99byjRepSC8zDLj5b9srWTmK+3nstVTMVf2diXOIQTwSz2zLOa5tAHwTycq
 YRKFJ3r/Otd8Ny7jbTcjf3BpN3gKkjxB8eh6az5FZVO7Gtm/XejpUil5rW1JjaMCmkmQBSI4l4o
 AY90JC9l7l7+EMbuRgw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAxNiBTYWx0ZWRfX+xskwkVr3AUz
 HGutsJpGDoJ1IUwaMCExFFdnd3Mk46b2Cjd+iy40M8/F4jvsBxgYTFNHHTKkiDjISpbWQ59j64n
 bW9q3R9LR5cSkDzlGFgl8dSzmTJpNMY=
X-Proofpoint-GUID: M0d3By88-N1h1GCBlmrDy3hXp8eMPDaY
X-Proofpoint-ORIG-GUID: M0d3By88-N1h1GCBlmrDy3hXp8eMPDaY
X-Authority-Analysis: v=2.4 cv=WZ88rUhX c=1 sm=1 tr=0 ts=6a45c72c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=flT6WI0wyULpFbpzkcoA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607020016
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
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

On Tue, 2026-06-30 at 10:19 -0400, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
>=20
> When IPL type is PCI, cutype is unknown, so the IPLB location does not
> get written to lowcore.  Instead of checking cutype, check if the device
> is virtio generically, which covers both CCW and PCI variants.  Net devic=
es
> are excluded.
>=20
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Eric Farman <farman@linux.ibm.com>

