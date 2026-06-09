Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F107CD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:39:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWun7-0004TT-3p; Tue, 09 Jun 2026 07:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxbr@linux.ibm.com>)
 id 1wWumy-0004SK-V5
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 07:38:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxbr@linux.ibm.com>)
 id 1wWumv-0006ID-0Z
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 07:38:34 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65941sSV089638; Tue, 9 Jun 2026 11:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=r8JVpn
 wqXSJN2TSw7EGjhIbYRwNVChaKxZ3qi9nHrys=; b=oMzCMOmwpbFThiaZp3gfpJ
 UW9rj3a6i1T0GPnRfL6gQpOYJu9zNtMqQjQVgNdAS1iKHQbWqdUSE6HQ8OD8+tGG
 keqSLiqyWKv/DGkP0lEB+pj4FodbDckl4yds9nklZ0nTAVByM3Wg6uLJlehNBKeL
 Gdwc7obZ9A9SeDu3iZwY1cD6kbCmMbYdwOpWVkcP23/RZOcaC4sOgV/dsozm7tVW
 kCfP1K2tAQGliySwOVv2ZuF2ffvTNoCzioX2LzMXyDvqfJq63dPisd16r9S327xm
 NytKYGEJd2FtsJE3MoZlzTEDg2BBXvE4QCcUPJHsJuCOluCROQ0OixKTXHhJW+gw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em8yhuvxp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jun 2026 11:38:18 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 659BYbkF016240;
 Tue, 9 Jun 2026 11:38:17 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en0jy9g96-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jun 2026 11:38:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 659BcGJP24773116
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 9 Jun 2026 11:38:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 26C0820043;
 Tue,  9 Jun 2026 11:38:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E740C20040;
 Tue,  9 Jun 2026 11:38:15 +0000 (GMT)
Received: from li-9b52914c-2c8b-11b2-a85c-a36f6d484b4a.ibm.com (unknown
 [9.224.77.197]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  9 Jun 2026 11:38:15 +0000 (GMT)
Message-ID: <5ad91cd4c7ba500a56d8356100becffcfb3062a3.camel@linux.ibm.com>
Subject: Re: [PATCH v6 00/12] virtio-console: notify about the terminal size
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: Filip Hejsek <filip.hejsek@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau	
 <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laurent
 Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, Markus Armbruster
 <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum	 <marcel.apfelbaum@gmail.com>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=	 <philmd@linaro.org>, Yanan Wang
 <wangyanan55@huawei.com>, Zhao Liu	 <zhao1.liu@intel.com>, "Daniel P."
 =?ISO-8859-1?Q?Berrang=E9?=	 <berrange@redhat.com>, Szymon Lukasz
 <noh4hss@gmail.com>
Date: Tue, 09 Jun 2026 13:38:15 +0200
In-Reply-To: <ba34daea09f83601c88be90006ca28e3700910d9.camel@gmail.com>
References: <20260119-console-resize-v6-0-33a7b0330a7a@gmail.com>
 <cc0b8cce5bf5763ace058270e9d80fb84873dbd7.camel@linux.ibm.com>
 <20260609040710-mutt-send-email-mst@kernel.org>
 <147cee86401993714fa94bd6cc79c4dbbdcaca52.camel@linux.ibm.com>
 <ba34daea09f83601c88be90006ca28e3700910d9.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDExMCBTYWx0ZWRfXyhqyO+Ag8nfF
 bXYwp/z+P7JkV3PEJ9XeapDkOymF4hG3NyBMkqr70NoBiTyVgB5IUeTgVFCFtO4wPtK4JPthbzx
 5PDkJhQmnGlQdBHuWufxQRgytskRPzhWiPu23CoTVu481AgZAp9QXxykOd5mq+5k2vF4mVDupmK
 CM/tr/Yxc/zbwW+KiB1DNO9q+QSyUsNBoOm3yZApx6pn8gGGmpP+CddwYiKFQAsSjjhwOr5C78W
 DEp8bD7qhRpx1DKQTuPS8/JBneN4BZPnbUCzRHbLU5lvBZxOqB66Z9Z7qyvfWbTOeOCa8MVaDft
 nV4Tx6zoHE3pGTTEWBdRh/y0MXmeTuG4WuKxwqc6x0M9F9UlLbDSiruW8wWiXF0uQq8Yerw0qeV
 mk4MeUNLPssmgrLPVlux1ppz72Zw1v7XkCY0f37NwhQLlhKGIlbbcyUCxxuI+IPWFUD/q3sZdnH
 oK8UrjUyCRJ1jTAQ7sA==
X-Authority-Analysis: v=2.4 cv=HvFG3UTS c=1 sm=1 tr=0 ts=6a27fb2b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=vIXjsTuexS82xgykj9YA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: qhfAe9nokzr7avENkimaed864x4BgLeI
X-Proofpoint-GUID: hu5mIc2nEdMjqpjfLG_qKBZGixniMnRo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090110
Received-SPF: pass client-ip=148.163.158.5; envelope-from=maxbr@linux.ibm.com;
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

On Tue, 2026-06-09 at 13:13 +0200, Filip Hejsek wrote:
> On Tue, 2026-06-09 at 10:26 +0200, Maximilian Immanuel Brandtner
> wrote:
> > On Tue, 2026-06-09 at 04:09 -0400, Michael S. Tsirkin wrote:
> > > On Tue, Jun 09, 2026 at 10:02:40AM +0200, Maximilian Immanuel
> > > Brandtner wrote:
> > > > What's the status of this series? It seems to me to have
> > > > somewhat
> > > > stalled, because of the virtio resize event discrepancy that
> > > > has
> > > > been
> > > > adressed by backporting the relevant patch. At this point it's
> > > > been
> > > > almost 6 months since any changes have been made to this patch-
> > > > set,
> > > > even though at this point it would have to be refactored to
> > > > address
> > > > changes that have been made to QEMU since. Has progress on this
> > > > patch-
> > > > set just stalled or are there any remaining concerns about the
> > > > implementation of this patch-set I'm unaware of?
> > > >=20
> > > > Kind regards,
> > > > Max Brandtner
> > >=20
> > > Whom are you asking?
> > > There were comments on patches 7 and 8 and Filip seems to have
> > > indicated
> > > he intends to address them, and even posted diffs.
> > > So now, I expect v7 with that.
> > I suppose Filip for the most part. It's just that close to 6 months
> > of
> > inactivity is quite a while and sometimes as other stuff happens
> > people
> > can forget about a patch-series.
> >=20
> > Kind regards,
> > Max Brandtner
>=20
> Hi all,
>=20
> Sorry, I did indeed forget about the series.
>=20
> From what I remember, I was trying to address an issue with the size
> not being updated after a migration, and it turned out fixing this
> required adding the current size to the migration stream (in order to
> avoid sending unnecessary resize events when the size doesn't change,
> which MST pointed out would add guest performance overhead).
>=20
> However, since virtio console serialization still uses save/load
> methods rather than VMState macros, I couldn't simply add a
> subsection,
> so I wasn't quite sure how to proceed. It seemed like the right thing
> to do was to migrate virtio-console to VMState, but that would have
> taken more effort than I was willing to put in at that moment. And
> then
> some other stuff happened in my life and now here we are.
>=20
> So anyway, in order to make progress on this, I see two approaches:
>=20
> 1. Just bump the migration stream version. Makes the loading code
> more
> convoluted due to version checks and increases tech dept for future
> VMState migration, but shouldn't be that hard to do.
>=20
> 2. Do the VMState migration now. This is complicated by the fact the
> on
> load,=C2=A0some of the state shouldn't be restored back into the field
> that
> was saved, but instead should be compared and the guest notified if
> it
> is different. I'm also not quite sure how hard it will be to preserve
> migration stream compatibility.
>=20
> Which one would be preferable to do?
>=20
> Kind regards,
> Filip Hejsek

I have another patch in the pipeline to add resize support for another
chardev backend. Would the migration issue affect any chardev backend
that wants to support resizing or is it specific to virtio? I don't
have a strong opinion either way regarding virtio-console, but I'd be
quite interested to see the generic chardev resizing code rebased
against the latest upstream QEMU sooner rather than later.

Kind regards,
Max Brandtner

