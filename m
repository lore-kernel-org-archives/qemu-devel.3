Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE588CAC59F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 09:06:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzAam-0004ug-09; Thu, 18 Sep 2025 05:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxbr@linux.ibm.com>)
 id 1uzAai-0004te-Iy
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 05:06:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxbr@linux.ibm.com>)
 id 1uzAaf-0006Kf-UF
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 05:06:12 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I6t4e7011030;
 Thu, 18 Sep 2025 09:05:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=K2IqI0
 NkJN2X7L9sJ5SwY1YIeBMefBhcPyiymNIqY8Y=; b=rpRYEu7VAVc/6RuKBh+ZwQ
 Q3F0Pvg9X/9Nc2YwI0ObDN0MgMVOmd/0BWlhwfDFIIpiOPqRCO83IbONW53Q1k0m
 BzsVCAq3gE3/np5xFdtaCXe1g1jfi6EUZCrjUzqnSvfzE+q1+/OJcGgAbf0xWhxS
 TkbqPVFg5IHMOz35tM9aC0XEG483oXafv97A0BiYf01OWUP/L9u0EjfQ7A4HplhO
 X3WEs834vv4crtGTIuPrTzltAChWDK6fts3h4Imo8ewRFHgPnPpK5NO6QqpAim4l
 CI9W8XvKwiwRKGWBUgExkp5znpBsGawR6867tKXyoDRsQetaG0qjVKkqdsA9d3Sg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4ngrse-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Sep 2025 09:05:48 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58I8lUUZ023567;
 Thu, 18 Sep 2025 09:05:47 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4ngrsb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Sep 2025 09:05:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58I6rONI018649;
 Thu, 18 Sep 2025 09:05:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 495n5mnnhc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Sep 2025 09:05:46 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58I95jNi31850902
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Sep 2025 09:05:45 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2234D2004B;
 Thu, 18 Sep 2025 09:05:45 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 54F8420040;
 Thu, 18 Sep 2025 09:05:44 +0000 (GMT)
Received: from li-9b52914c-2c8b-11b2-a85c-a36f6d484b4a.ibm.com (unknown
 [9.87.148.84]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 18 Sep 2025 09:05:44 +0000 (GMT)
Message-ID: <30058224264231a1d5c6315580b14e42119d16c0.camel@linux.ibm.com>
Subject: Re: [PATCH v2] char-pty: add support for the terminal size
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Cc: Filip Hejsek <filip.hejsek@gmail.com>, amit@kernel.org, armbru@redhat.com, 
 eblake@redhat.com, eduardo@habkost.net, lvivier@redhat.com,
 marcandre.lureau@redhat.com, marcel.apfelbaum@gmail.com,
 mst@redhat.com, noh4hss@gmail.com, pbonzini@redhat.com,
 philmd@linaro.org, qemu-devel@nongnu.org, wangyanan55@huawei.com,
 zhao1.liu@intel.com, nsg@linux.ibm.com
Date: Thu, 18 Sep 2025 11:05:44 +0200
In-Reply-To: <aMvKBxaYLR065YKu@redhat.com>
References: <aMq4Ta4aPwRgDrxR@redhat.com>
 <0A6C8C3D-68E7-4E88-BEBE-D653135915DF@gmail.com>
 <aMrfGUfCSWnvkXzT@redhat.com>
 <e2f80c7ad10b8b6376144ba5d959a2ad4739f81c.camel@gmail.com>
 <aMr1sn-LU2f-w49o@redhat.com>
 <15cc6bcd675f2e20efe4fbd6332018a693122b9c.camel@gmail.com>
 <aMvETd_dlUed-nlN@redhat.com>
 <8979fb7f27b9dbe48f6419d515c4d33a77cefe0a.camel@linux.ibm.com>
 <aMvHScAtr3E_H2KB@redhat.com>
 <e6c30d2143147ebf285e69b4a786c0ed0f5212d2.camel@linux.ibm.com>
 <aMvKBxaYLR065YKu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MN5gmNZl c=1 sm=1 tr=0 ts=68cbcb6c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=paPP6BqtQoqtc4dki4EA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: OYbcRwBsMxHycN6amiVDsJWt94N2c8mK
X-Proofpoint-ORIG-GUID: dEhsrVbgm8IB2kA-fUmygXh0FrodI0lY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX8cpww39xEDBu
 MgEjBRhminWC5Gs91dHLr3YJQzGsYpLQvJoLmNfdwm6uLr7TK7Prkn8zn+SJ6RJ+JfqWoMUhnmQ
 oBWxYmWfhFiSTUMLcnozNAV7vWjd26GNoHpEPG1wpn4MAjFNH0vqmvAiF7zRkuTqFDPaRSDV5hj
 TM/eOfJK3P97cHxFndN8vxSvghj1bAGfk7XC/zxMoXwabvD/rTRxz8pVVBbCCIG51b6z18BZSf8
 rczgLUHCC7fK5jjRrQQpLcEG5uOyatGjyIjy5trUPGBaYL8uMsd5F+74iY96//Asi6puyIPx2NP
 8KECAdFsCiDdIgWpVcMDT2nPQiX+1NQW5ZyHgPl0M8g21CEii9oJj47pEqOoO8RHXc/YmDaIkuF
 3UebYpdP
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

On Thu, 2025-09-18 at 09:59 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Sep 18, 2025 at 10:54:45AM +0200, Maximilian Immanuel
> Brandtner wrote:
> > On Thu, 2025-09-18 at 09:48 +0100, Daniel P. Berrang=C3=A9 wrote:
> > > On Thu, Sep 18, 2025 at 10:39:28AM +0200, Maximilian Immanuel
> > > Brandtner wrote:
> > > > On Thu, 2025-09-18 at 09:35 +0100, Daniel P. Berrang=C3=A9 wrote:
> > > > > On Wed, Sep 17, 2025 at 08:29:39PM +0200, Filip Hejsek wrote:
> > > > > > On Wed, 2025-09-17 at 18:53 +0100, Daniel P. Berrang=C3=A9
> > > > > > wrote:
> > > > > > > On Wed, Sep 17, 2025 at 07:11:03PM +0200, Filip Hejsek
> > > > > > > wrote:
> > > > > > > > On Wed, 2025-09-17 at 17:17 +0100, Daniel P. Berrang=C3=A9
> > > > > > > > wrote:
> > > > > > > >=20
> > > > > > > > > We shouldn't send any size info to the guest if the
> > > > > > > > > hsot
> > > > > > > > > backend
> > > > > > > > > does not have it available.
> > > > > > > >=20
> > > > > > > > Does that mean sending 0x0, or not sending anything at
> > > > > > > > all?
> > > > > > > > The
> > > > > > > > later
> > > > > > > > is tricky,=C2=A0because for non-multiport devices it's only
> > > > > > > > really
> > > > > > > > possible
> > > > > > > > by not offering the feature bit, but we don't know
> > > > > > > > upfront
> > > > > > > > whether the
> > > > > > > > size command will be used.
> > > > >=20
> > > > > What are the semantics in the guest if we sent 0x0 as the
> > > > > size ?
> > > > > AFAICT the virtio spec is silent on what '0x0' means.
> > > > >=20
> > > > > It seems like it could conceivably have any behaviour,
> > > > > whether
> > > > > a zero-size console, or a console clamped to 1x1 as a min
> > > > > size,
> > > > > or a console reset to an arbitrary guest default like 80x24.
> > > >=20
> > > > During testing the kernel resized the tty to 0x0 if VirtIO
> > > > instructed
> > > > the kernel to resize the tty to 0x0.
> > >=20
> > > If the chardev backends are defaulting to 0x0 for everything
> > > except
> > > the 'stdio' backend, then this series is surely going to break
> > > all
> > > existing usage of virtio-console for non-stdio backends ?
> > >=20
> > > What am I missing here ?
> >=20
> > Most applications fall back to 80x24 if the terminal size is 0x0 so
> > it's not as big of a dealbreaker as you might think.
>=20
> I'm not convinced that its a good idea for QEMU to be relying on
> every
> application to be doing that. I can forsee the bug reports from
> situations
> where this doesn't happen and something ends up dividing by zero when
> doing an aspect ratio calculation.=C2=A0 Yes, we could point to the app
> code
> and call it buggy, but I think there's a strong case to be made that
> we
> shouldn't have been sending 0x0 to begin with.
>=20
> > However, I think it would be even better if the patch-set could be
> > changed to account for that. After initializing the VirtIO console
> > a
> > resize event could be sent to set the initial size (80x24), which
> > might
> > later be changed or be left as is.
>=20
> The problem with QEMU sending 80x24 instead of 0x0 is that the
> majority
> of Linux guests will then treat that as 24x80 due to the historical
> bug
> in Linux drivers. This will probably be even worse than the bugs we
> get
> from sending 0x0.

I agree that this is a much more significant issue and I like your idea
of adding an opt-in parameter to support resizing for the virtio-
console chardev. The smoothest solution would have been a spec-change.

>=20
> > If the VIRTIO_CONSOLE_F_SIZE is negotiated(and this feature flag is
> > necessary for multiport resize messages not to be ignored) QEMU is
> > responsible for setting the initial terminal size.
>=20
> With regards,
> Daniel


