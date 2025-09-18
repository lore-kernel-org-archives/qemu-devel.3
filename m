Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 557D9CAC59F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 08:45:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzAG9-00027L-Dl; Thu, 18 Sep 2025 04:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxbr@linux.ibm.com>)
 id 1uzAG7-000273-5u
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 04:44:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxbr@linux.ibm.com>)
 id 1uzAG1-0002sB-F9
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 04:44:54 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I5kFS4011288;
 Thu, 18 Sep 2025 08:39:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ntSi72
 GW390Y2+rEg2i79APT4sxvNjeGLssv4cdrACc=; b=i0qoniTO3oi16E2J3wLxRP
 4s/tvnAI4Dw6NzUKTKh8XO+iTL41WJbCLm8LgfgysWG9GJPPVMSOCYpZ9J78XANn
 87/eGbaA1oMeXmY6LhtENt8BG58qBfYQhFRZyPIVTRDB2pw4gGPAhnAt66bzsb3+
 XLNkcxc2o95iDRB8uip41Y2M0ocOkInYRrVO8I+CjTC5YVdTcfC1x8wWlBvnhwPW
 ZxSFBugV2noh2EddpdqF352BZuRc4dg0DwstHNgrCoG9TZAx4eBY70DMOTnM8uww
 FXwLM6zczMhIEZCwDFBnkJ713BBJetv0jvY1kRv7Urj1XbEg+3eubl3inS65RGRQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4ngm87-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Sep 2025 08:39:33 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58I8T2RK017568;
 Thu, 18 Sep 2025 08:39:33 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4ngm82-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Sep 2025 08:39:33 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58I7LU2R008988;
 Thu, 18 Sep 2025 08:39:32 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 495nn3ne4j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Sep 2025 08:39:32 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58I8dUSo51708210
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Sep 2025 08:39:30 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 88F142004B;
 Thu, 18 Sep 2025 08:39:30 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CBAC820043;
 Thu, 18 Sep 2025 08:39:28 +0000 (GMT)
Received: from li-9b52914c-2c8b-11b2-a85c-a36f6d484b4a.ibm.com (unknown
 [9.87.148.84]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 18 Sep 2025 08:39:28 +0000 (GMT)
Message-ID: <8979fb7f27b9dbe48f6419d515c4d33a77cefe0a.camel@linux.ibm.com>
Subject: Re: [PATCH v2] char-pty: add support for the terminal size
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>, Filip
 Hejsek <filip.hejsek@gmail.com>
Cc: amit@kernel.org, armbru@redhat.com, eblake@redhat.com, eduardo@habkost.net,
 lvivier@redhat.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, mst@redhat.com, noh4hss@gmail.com,
 pbonzini@redhat.com, philmd@linaro.org, qemu-devel@nongnu.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, nsg@linux.ibm.com
Date: Thu, 18 Sep 2025 10:39:28 +0200
In-Reply-To: <aMvETd_dlUed-nlN@redhat.com>
References: <20250915163415.149190-1-maxbr@linux.ibm.com>
 <4c8e1ae5dd16d6ee4bcb42ed25d2987bc2c4a3cc.camel@gmail.com>
 <95142e7fd2a103cfb8d8bea9727117bfe952baec.camel@linux.ibm.com>
 <E0EFD1A6-09E9-481D-82FD-84FD4B45CA9B@gmail.com>
 <aMq4Ta4aPwRgDrxR@redhat.com>
 <0A6C8C3D-68E7-4E88-BEBE-D653135915DF@gmail.com>
 <aMrfGUfCSWnvkXzT@redhat.com>
 <e2f80c7ad10b8b6376144ba5d959a2ad4739f81c.camel@gmail.com>
 <aMr1sn-LU2f-w49o@redhat.com>
 <15cc6bcd675f2e20efe4fbd6332018a693122b9c.camel@gmail.com>
 <aMvETd_dlUed-nlN@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MN5gmNZl c=1 sm=1 tr=0 ts=68cbc545 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=JkEQnYpzsr8omvxcchgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: xep6SoX82PQMocKIGQRm_la1dJERM0Pc
X-Proofpoint-ORIG-GUID: WixrZ5HjJs57d2uEM6nFUr9Havg6jqS8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX2xdESGekZ3kR
 njH//kb+fTavLIWJMZZdAID0EpSfGYmEP9xXxys2KWEgo0brbimV+VBAeax33xJqD62A5voXAo9
 7rtNs3OE44+tVoenHlMm3RYzBST9JSbVoJJpcbXBNOMJEgmroSgKHzw7AJQW9//12Oe8iMDPX0s
 RrDvvRuohaL65VNictABT2aXrvoMYrSq94Y9ViCIkDR5/B/YOxryhJVQyjKgGr8J3aSoojpLTEN
 Vgewjc/CRQU+yt5w+FD0+3z7hz9C3Mk8vBNZJYs2IFDEwDbmLZt4+vJgGMYI3KAbKbcaQ3/ZVJi
 M893dGM1nA8ygkivQkGl+qhkK8jynAIoIQxMUWZNuI/4lAMcR9BLObjmbW+bncZB9jZTs1QJu07
 BZbKtUkU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204
Received-SPF: pass client-ip=148.163.158.5; envelope-from=maxbr@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On Thu, 2025-09-18 at 09:35 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Sep 17, 2025 at 08:29:39PM +0200, Filip Hejsek wrote:
> > On Wed, 2025-09-17 at 18:53 +0100, Daniel P. Berrang=C3=A9 wrote:
> > > On Wed, Sep 17, 2025 at 07:11:03PM +0200, Filip Hejsek wrote:
> > > > On Wed, 2025-09-17 at 17:17 +0100, Daniel P. Berrang=C3=A9 wrote:
> > > >=20
> > > > > We shouldn't send any size info to the guest if the hsot
> > > > > backend
> > > > > does not have it available.
> > > >=20
> > > > Does that mean sending 0x0, or not sending anything at all? The
> > > > later
> > > > is tricky,=C2=A0because for non-multiport devices it's only really
> > > > possible
> > > > by not offering the feature bit, but we don't know upfront
> > > > whether the
> > > > size command will be used.
>=20
> What are the semantics in the guest if we sent 0x0 as the size ?
> AFAICT the virtio spec is silent on what '0x0' means.
>=20
> It seems like it could conceivably have any behaviour, whether
> a zero-size console, or a console clamped to 1x1 as a min size,
> or a console reset to an arbitrary guest default like 80x24.

During testing the kernel resized the tty to 0x0 if VirtIO instructed
the kernel to resize the tty to 0x0.
>=20
>=20
> > > Nothing at all - is in no difference from current QEMU behaviour.
> >=20
> > As I said, that's not possible with the current semantics of the
> > resize
> > command, as we would need to know upfront whether it is going to be
> > used.
> >=20
> > To get the exact same behavior as current QEMU, we would need to
> > add
> > some way to inform QEMU whether we want to use the resize command
> > (e.g.
> > device property).
>=20
> That is usually unknowable at the time we spawn QEMU.
>=20
> I'd say that the common case is for guests to get given a console
> connected to a UNIX socket. Most of the time the console will not
> be used. If it is, then we've no idea whether the client will be
> something virtualization-unaware like a plain 'socat', or something
> virtualization-aware like libvirt's=C2=A0 'virsh console'.
>=20
> > Even then, depending on how you interpret the virtio spec, there
> > would
> > be a problem with multiport devices if port 0 didn't support size,
> > but
> > another port did. Not providing port 0 size can only be done by not
> > offering the size feature bit, and then the question is, can you
> > still
> > send resize events for the other ports? The spec does not say
> > either
> > way.
> >=20
> > Note that getting the exact same behavior as current QEMU is still
> > possible by disabling the console-size property on the virtio-
> > serial
> > device (but it applies to all ports).
>=20
> Yes, it seems like the spec ties our hands here wrt multiple ports.
>=20
> I didn't apprepreciate in my previous review that integrating this
> support
> into QEMU was going to imply us /always/ informing the guest about
> the
> requested console size for all ports, regardless of the backend.
>=20
> I had been under the belief that we were only going to pass size info
> to
> the guest, if the chardev was 'stdio', and for all other chardev
> backends
> no size info would be passed unless we had issued the QMP resize
> command.
>=20
> That we will always pass size info the guest regardless of the
> backend,
> across all ports, changes my view about whether it is=C2=A0 reasonable to
> enable resize by default given the known Linux guest bug.
>=20
> The impact of the guest bug is just about tolerable if we were only
> going
> to enable passing size information when the user had chosen 'stdio'
> backend
> as that is relatively rarely used and mostly by ad-hoc dev usage
> where it
> is perhaps easier for users to get a fixed guest kernel.
>=20
> If we enable this for all ports though, regardless of backend, then I
> think
> we're going to cause too much pain for users with the inverted
> rows/cols,
> as its going to apply in every single deployment of QEMU using
> virtioconsole.
>=20
> So IMHO we cannot enable this without explict user opt-in.
>=20
> With regards,
> Daniel


