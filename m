Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC929CAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 08:55:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzAQ3-00077m-PY; Thu, 18 Sep 2025 04:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxbr@linux.ibm.com>)
 id 1uzAPy-00077G-QR
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 04:55:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxbr@linux.ibm.com>)
 id 1uzAPu-00047M-UY
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 04:55:06 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I52XeO011495;
 Thu, 18 Sep 2025 08:54:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=EjarOI
 D9FNqUhiCYpnixNjfIhyIUgpeLE1miThDoxlM=; b=Yv9401EV1umJtcm5pJJC/V
 YWjRP5XECDI9cjgZs0CfKacH703MHjqc9k25JizC9w+UgzPzl0gPWv1ohTzw6C8/
 qcPgZCKMtq5ElpjkzusWStX0m6Ds64sqxs8H+SWz07IVY84eXPWXM5bI13EQzPUK
 pabEBrrTHU5P901s4vQCEYcT+iJbfjTGYWw4MnUfe5mpQeWBczIXMhFdDrkEMWBr
 qiwHPQ7U/Y1CP3rP+kl8dIJeWfpreu/kDDqkgoZhxOyJVo1augTNOT6tTNq9lGuS
 ol8kaTPPPpsq1VO1n2Cj0Pk827EZ/2+JIGpODddfn57cUN6RuT/38G7EWuVvDWOw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4j95a1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Sep 2025 08:54:50 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58I8mtu3002506;
 Thu, 18 Sep 2025 08:54:49 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4j959y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Sep 2025 08:54:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58I5il4F022347;
 Thu, 18 Sep 2025 08:54:48 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495kxpwtnd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Sep 2025 08:54:48 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58I8sk5741353562
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Sep 2025 08:54:46 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 57B9420043;
 Thu, 18 Sep 2025 08:54:46 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 653CD20040;
 Thu, 18 Sep 2025 08:54:45 +0000 (GMT)
Received: from li-9b52914c-2c8b-11b2-a85c-a36f6d484b4a.ibm.com (unknown
 [9.87.148.84]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 18 Sep 2025 08:54:45 +0000 (GMT)
Message-ID: <e6c30d2143147ebf285e69b4a786c0ed0f5212d2.camel@linux.ibm.com>
Subject: Re: [PATCH v2] char-pty: add support for the terminal size
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Cc: Filip Hejsek <filip.hejsek@gmail.com>, amit@kernel.org, armbru@redhat.com, 
 eblake@redhat.com, eduardo@habkost.net, lvivier@redhat.com,
 marcandre.lureau@redhat.com, marcel.apfelbaum@gmail.com,
 mst@redhat.com, noh4hss@gmail.com, pbonzini@redhat.com,
 philmd@linaro.org, qemu-devel@nongnu.org, wangyanan55@huawei.com,
 zhao1.liu@intel.com, nsg@linux.ibm.com
Date: Thu, 18 Sep 2025 10:54:45 +0200
In-Reply-To: <aMvHScAtr3E_H2KB@redhat.com>
References: <95142e7fd2a103cfb8d8bea9727117bfe952baec.camel@linux.ibm.com>
 <E0EFD1A6-09E9-481D-82FD-84FD4B45CA9B@gmail.com>
 <aMq4Ta4aPwRgDrxR@redhat.com>
 <0A6C8C3D-68E7-4E88-BEBE-D653135915DF@gmail.com>
 <aMrfGUfCSWnvkXzT@redhat.com>
 <e2f80c7ad10b8b6376144ba5d959a2ad4739f81c.camel@gmail.com>
 <aMr1sn-LU2f-w49o@redhat.com>
 <15cc6bcd675f2e20efe4fbd6332018a693122b9c.camel@gmail.com>
 <aMvETd_dlUed-nlN@redhat.com>
 <8979fb7f27b9dbe48f6419d515c4d33a77cefe0a.camel@linux.ibm.com>
 <aMvHScAtr3E_H2KB@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Qf5mvtbv c=1 sm=1 tr=0 ts=68cbc8da cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=vdxyQyfYVvcB46YxvJYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: nczI8UZWItqrNxzuWlOg--idHzRwObF3
X-Proofpoint-GUID: gP16cnjvD8Zmvql7aarT3RUUUgd1gptA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX50IUn7k9m/Ea
 RxZeTXXIU4JPQqfGeR1YNfxvyvExYINe73PoVkD00D1utjlQuFvMU69KmOB3b3fBgB6W/1ml1wd
 +6ngOyWwFtcnhHfdps2MfVfsfBbuvG9KyBMr/6/qFM2UyMvkPO29y7K7CfzpinPfy3yuz5hsvXW
 W57FfRmj4JSUnaMjSmyyxmOpxjHy54EnpyEBuomUAFWRAYvMXxoFDj1npi8ljgyhBreb8T6kU5c
 H3iWg+PZOO7+TE+us11k9oa+gsvXuqrcYb8ws2XOytK4LVntjMxJk5NR88VHkVZi0foMkvY9UgU
 6rQtrJ0BdICKn1KBiuiH92YpB20XWBX0AjDuTHrnj1+fl+O0QsP2A0q7m5y5JVbIG1qSvy0bXIO
 IQLFXLor
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204
Received-SPF: pass client-ip=148.163.156.1; envelope-from=maxbr@linux.ibm.com;
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

On Thu, 2025-09-18 at 09:48 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Sep 18, 2025 at 10:39:28AM +0200, Maximilian Immanuel
> Brandtner wrote:
> > On Thu, 2025-09-18 at 09:35 +0100, Daniel P. Berrang=C3=A9 wrote:
> > > On Wed, Sep 17, 2025 at 08:29:39PM +0200, Filip Hejsek wrote:
> > > > On Wed, 2025-09-17 at 18:53 +0100, Daniel P. Berrang=C3=A9 wrote:
> > > > > On Wed, Sep 17, 2025 at 07:11:03PM +0200, Filip Hejsek wrote:
> > > > > > On Wed, 2025-09-17 at 17:17 +0100, Daniel P. Berrang=C3=A9
> > > > > > wrote:
> > > > > >=20
> > > > > > > We shouldn't send any size info to the guest if the hsot
> > > > > > > backend
> > > > > > > does not have it available.
> > > > > >=20
> > > > > > Does that mean sending 0x0, or not sending anything at all?
> > > > > > The
> > > > > > later
> > > > > > is tricky,=C2=A0because for non-multiport devices it's only
> > > > > > really
> > > > > > possible
> > > > > > by not offering the feature bit, but we don't know upfront
> > > > > > whether the
> > > > > > size command will be used.
> > >=20
> > > What are the semantics in the guest if we sent 0x0 as the size ?
> > > AFAICT the virtio spec is silent on what '0x0' means.
> > >=20
> > > It seems like it could conceivably have any behaviour, whether
> > > a zero-size console, or a console clamped to 1x1 as a min size,
> > > or a console reset to an arbitrary guest default like 80x24.
> >=20
> > During testing the kernel resized the tty to 0x0 if VirtIO
> > instructed
> > the kernel to resize the tty to 0x0.
>=20
> If the chardev backends are defaulting to 0x0 for everything except
> the 'stdio' backend, then this series is surely going to break all
> existing usage of virtio-console for non-stdio backends ?
>=20
> What am I missing here ?
>=20
> With regards,
> Daniel

Most applications fall back to 80x24 if the terminal size is 0x0 so
it's not as big of a dealbreaker as you might think.

However, I think it would be even better if the patch-set could be
changed to account for that. After initializing the VirtIO console a
resize event could be sent to set the initial size (80x24), which might
later be changed or be left as is.
If the VIRTIO_CONSOLE_F_SIZE is negotiated(and this feature flag is
necessary for multiport resize messages not to be ignored) QEMU is
responsible for setting the initial terminal size.

Kind regards,
Max Brandtner

