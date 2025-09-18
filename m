Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CBABCAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 07:55:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uz9Si-0005nB-Lu; Thu, 18 Sep 2025 03:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxbr@linux.ibm.com>)
 id 1uz9Sf-0005md-3P
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 03:53:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxbr@linux.ibm.com>)
 id 1uz9Sb-0004S0-Gq
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 03:53:48 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I7ZhZH000472;
 Thu, 18 Sep 2025 07:53:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=0KfVxg
 pz/WWL7wI1erqK+3td4quaKbHsaITnBKRHVBk=; b=V1KkGSoqghDP9uOruwfjF+
 LJWChdfHEIFHzV//WM/4VZ7liOigN19BB8XdU5uIebXM7CSSXXo89XRPPq4Cpput
 uTpDhX7c3ACWkbFZotZMeBd/Bh/wnkZKaVWxf/YAMOCSzTM9Egyvkd4qwsprk1ir
 +p0RNX32B7SZkmzf+IPVGYfpZwCv1s1SogDk37/baAPDhNnBGRb+BOCM//Wa26RT
 nGWt/SBhJ4D8zv9lJD4oflPtBv2uoLRKbeGNm/BmIQ90w8EEPmSWo1OGlL1YsrrM
 atUsgN5k2+Af+3GIAy9YDXHEp/zN/KVtyW37fyWVgw2LAUro/WUKmFFojd4FIYKA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 498dtwg2y3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Sep 2025 07:53:31 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58I7rVRx006538;
 Thu, 18 Sep 2025 07:53:31 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 498dtwg2xx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Sep 2025 07:53:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58I6mevs018637;
 Thu, 18 Sep 2025 07:53:30 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 495n5mncpc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Sep 2025 07:53:30 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58I7rS3x30998922
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Sep 2025 07:53:28 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B8BD72004D;
 Thu, 18 Sep 2025 07:53:28 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D892F20040;
 Thu, 18 Sep 2025 07:53:27 +0000 (GMT)
Received: from li-9b52914c-2c8b-11b2-a85c-a36f6d484b4a.ibm.com (unknown
 [9.87.148.84]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 18 Sep 2025 07:53:27 +0000 (GMT)
Message-ID: <49e6a105914fe0dd3b3476c1bceaf2c7d1f92824.camel@linux.ibm.com>
Subject: Re: [PATCH v2] char-pty: add support for the terminal size
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>, Filip
 Hejsek <filip.hejsek@gmail.com>
Cc: amit@kernel.org, armbru@redhat.com, eblake@redhat.com, eduardo@habkost.net,
 lvivier@redhat.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, mst@redhat.com, noh4hss@gmail.com,
 pbonzini@redhat.com, philmd@linaro.org, qemu-devel@nongnu.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, nsg@linux.ibm.com
Date: Thu, 18 Sep 2025 09:53:27 +0200
In-Reply-To: <aMq4Ta4aPwRgDrxR@redhat.com>
References: <20250915162535.147642-1-maxbr@linux.ibm.com>
 <20250915163415.149190-1-maxbr@linux.ibm.com>
 <4c8e1ae5dd16d6ee4bcb42ed25d2987bc2c4a3cc.camel@gmail.com>
 <95142e7fd2a103cfb8d8bea9727117bfe952baec.camel@linux.ibm.com>
 <E0EFD1A6-09E9-481D-82FD-84FD4B45CA9B@gmail.com>
 <aMq4Ta4aPwRgDrxR@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EYvIQOmC c=1 sm=1 tr=0 ts=68cbba7c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=YfPNSW3WArftJzciuO0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: QMJYIgtvJ-19WC63BUvHYIKbvGxDkG8A
X-Proofpoint-GUID: NCAJPF8UCfmeeKOT-cs7op-eE2XlFGIf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE4MDA2NSBTYWx0ZWRfX+pXkR38e0c8h
 6GhuE8Q7XtlsiFJvhax3PnimNxnBizGms40BCThyMG63ypPEL2uUJMA2XWB16o62coA0XR+PicA
 ia5g8J4G9n9HCVbrwExlf9nDQbjy8V8r98hQbeO/CZXONYnfU5JupjkuwAWRbeJIRZdLCwsmQhd
 e5vgLU9yQSMI+gatin/2jrfovYr6m4I0wngCvGHR+1v2guVRnb2ujhWJjPmZHpOVJdU30oiQsIY
 lS2fyi7jOTyJmQPlbPBz5cUml94bmR8fcTOPCcSo9Lnq4ugxok/I0ESeXiPpuofRc5xsVIGRfc3
 vo4cIUfF4bkTUG1yAbXXA56sEuTkIQgTSQGuEn/WlCojEhzzzwIzIJkZzTVqlJJPjvdxuAJVvv1
 qQ+EpPLc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509180065
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

On Wed, 2025-09-17 at 14:31 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Sep 17, 2025 at 03:09:50PM +0200, Filip Hejsek wrote:
> >=20
> >=20
> > On September 17, 2025 11:39:55 AM GMT+02:00, Maximilian Immanuel
> > Brandtner <maxbr@linux.ibm.com> wrote:
> > > On Tue, 2025-09-16 at 00:02 +0200, Filip Hejsek wrote:
> > > > On Mon, 2025-09-15 at 18:34 +0200, Maximilian Immanuel
> > > > Brandtner
> > > > wrote:
> > > > > Update the terminal size upon SIGWINCH delivery.
> > > > >=20
> > > > > Signed-off-by: Maximilian Immanuel Brandtner
> > > > > <maxbr@linux.ibm.com>
> > > >=20
> > > > I don't think this will work, because SIGWINCH is only
> > > > delivered for
> > > > the process' controling terminal. Unfortunately I don't think
> > > > there
> > > > is
> > > > any way to get size notifications for arbitrary terminal.
> > >=20
> > > In that case there are two solutions:
> > > 1. make qemu the controlling process of the pty (this has the
> > > disadvantage of QEMU being quit when the pty is closed)
> >=20
> > A bigger disadvantage is that a process can only have one
> > controlling terminal, and a terminal can only be the controlling
> > terminal for a single session (and only sends signals to the
> > foreground process group of that session). It would require forking
> > a process for each pty, and I don't even know if the master end can
> > have its own session.
> >=20
> > > 2. create a timer polling every eg 100ms to check if the winsize
> > > has
> > > changed
> > >=20
> > > I would go with the second approach then
> >=20
> > Me too, the timer is a bit unfortunate, but it's probably the less
> > bad option.
>=20
> I don't think we want a timer polling for an situation that will very
> rarely arise.=C2=A0 We already add the 'chardev_resize' QMP command, whic=
h
> is
> a good enough way to kick QEMU to re-read the size.
>=20
> With regards,
> Daniel

This approach would only work with libvirt and not generic pty
applications though. Perhaps a bool poll_resize could be added to the
struct Chardev which is disabled, as soon as the chardev_resize QMP
command is used to avoid race conditions.


