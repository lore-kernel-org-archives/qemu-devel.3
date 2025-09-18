Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF51CAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 08:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzA52-0004MM-Oo; Thu, 18 Sep 2025 04:33:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxbr@linux.ibm.com>)
 id 1uzA50-0004MC-2M
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 04:33:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxbr@linux.ibm.com>)
 id 1uzA4v-0001jh-IK
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 04:33:25 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I72D2e024864;
 Thu, 18 Sep 2025 08:33:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=PnQDhX
 OiNBcdxftUR6hh2JvJoXaoYn761iW5wfZKRlI=; b=VRGw+V7krUCgK1vw5EfxFp
 QbVG8nxrNeTqxEbWa3GZ19wDx4CPLcia4s4D0ACw6C4fF0wzlHu3TYO4YSnoFdKg
 cQsDMVTmcdGWsUBJGPu9vzQRZ82aM7CXnlC6h2CLtQZbv75Phj2Q0Oodfwa2AVZe
 WM7FWEiEH8p+ziCHoVi4PgOA0VIlQ/LXcsJbi/aXP45HamRFoAdMLu5/i/uFRW4n
 a5I7blP6KV65ZicbXRXNbngMwNlmnR+9OxwuVqu7/l0rUO3koPw8H/bfp9WBZ0KU
 5d39yXbd6PnVvQ51m0ACud+55YP/iyJPnif7VIWCZOCRny7gt2UGinh1Swe0Xhhg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4qrjm3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Sep 2025 08:33:01 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58I8X1Pg001034;
 Thu, 18 Sep 2025 08:33:01 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4qrjkx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Sep 2025 08:33:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58I56ela005929;
 Thu, 18 Sep 2025 08:33:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 495jxudxm8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Sep 2025 08:32:59 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58I8Ww2v29557020
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Sep 2025 08:32:58 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 44ACF20040;
 Thu, 18 Sep 2025 08:32:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8801D2004B;
 Thu, 18 Sep 2025 08:32:57 +0000 (GMT)
Received: from li-9b52914c-2c8b-11b2-a85c-a36f6d484b4a.ibm.com (unknown
 [9.87.148.84]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 18 Sep 2025 08:32:57 +0000 (GMT)
Message-ID: <418ee5f98e2ada1c51b5a38614a7d80d48d68bbf.camel@linux.ibm.com>
Subject: Re: [PATCH v4 04/10] char-mux: add support for the terminal size
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: Filip Hejsek <filip.hejsek@gmail.com>, qemu-devel@nongnu.org
Cc: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, Markus
 Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Eduardo
 Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=	
 <philmd@linaro.org>, Yanan Wang <wangyanan55@huawei.com>, Zhao Liu	
 <zhao1.liu@intel.com>, Szymon Lukasz <noh4hss@gmail.com>
Date: Thu, 18 Sep 2025 10:32:57 +0200
In-Reply-To: <20250912-console-resize-v4-4-7925e444afc4@gmail.com>
References: <20250912-console-resize-v4-0-7925e444afc4@gmail.com>
 <20250912-console-resize-v4-4-7925e444afc4@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2T-guWDJPWvZh8QNCl--_Ehg2RFO3yXv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfXzdzWOyPCh/cr
 usXpr3zikk75sJ60mc8uP6yuhih2PF0o2R1rAVWbst6dhSrh3yLUxXP8ocyQ9TW/NdzNnQs/2Ob
 +04JiuMeSXi3dG7A9l5dAcOs55dni3vOKW3+5DTnsxVidjwHxqT7E/1pHxI+bf9hj2t0qYGAb/B
 F1NEGilmeSYOdLaloa2lF0W+LLp2POzUZ++A68vxi1gzcMR4RvVdS8i6sLYg0S18tRUxnvtrBI9
 uAeycUdqz8e4RCwL+MHn3OiY/Ba0pEq14HpNLQvYVAec77+xN3sXhwsZt1VcUX8dR6KBw2UlyKz
 IFDhWGHqVq2lLYMWZZg/LqVgAhoUdj0u3RJZgFkij/ZyVsiD/jTmztRUqYLThmulZcT6yyUJdPy
 wP+zZeZF
X-Authority-Analysis: v=2.4 cv=R8oDGcRX c=1 sm=1 tr=0 ts=68cbc3bd cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=tmmT7VD2qe406qi5M84A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: uaBhAnWwGwMxZ9pdCw9g_IRR4QPUmMlo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 phishscore=0
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

On Fri, 2025-09-12 at 05:39 +0200, Filip Hejsek wrote:
> From: Szymon Lukasz <noh4hss@gmail.com>
>=20
> The terminal size of a mux chardev should be the same as the real
> chardev, so listen for CHR_EVENT_RESIZE to be up to date.
>=20
> We forward CHR_EVENT_RESIZE only to the focused frontend. This means
> frontends should probably update their view of the terminal size on
> receiving CHR_EVENT_MUX_IN.
>=20
> Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
> Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
> ---
> =C2=A0chardev/char-mux.c | 18 +++++++++++++++++-
> =C2=A01 file changed, 17 insertions(+), 1 deletion(-)
>=20
> diff --git a/chardev/char-mux.c b/chardev/char-mux.c
> index
> 6b36290e2c49f579580d2abb5aa552806f019d4a..4d3d05b82f13e002c766142f9d9
> c24977b8b9bd2 100644
> --- a/chardev/char-mux.c
> +++ b/chardev/char-mux.c
> @@ -264,9 +264,24 @@ void mux_chr_send_all_event(Chardev *chr,
> QEMUChrEvent event)
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0}
> =C2=A0
> +static void mux_update_winsize(Chardev *chr)
> +{
> +=C2=A0=C2=A0=C2=A0 MuxChardev *d =3D MUX_CHARDEV(chr);
> +=C2=A0=C2=A0=C2=A0 uint16_t cols, rows;
> +
> +=C2=A0=C2=A0=C2=A0 qemu_chr_fe_get_winsize(&d->chr, &cols, &rows);
> +=C2=A0=C2=A0=C2=A0 qemu_chr_resize(chr, cols, rows);
> +}
> +
> =C2=A0static void mux_chr_event(void *opaque, QEMUChrEvent event)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 mux_chr_send_all_event(CHARDEV(opaque), event);
> +=C2=A0=C2=A0=C2=A0 Chardev *chr =3D CHARDEV(opaque);
> +
> +=C2=A0=C2=A0=C2=A0 if (event =3D=3D CHR_EVENT_RESIZE) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mux_update_winsize(chr);
> +=C2=A0=C2=A0=C2=A0 } else {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mux_chr_send_all_event(chr, e=
vent);
> +=C2=A0=C2=A0=C2=A0 }
> =C2=A0}
> =C2=A0
> =C2=A0static GSource *mux_chr_add_watch(Chardev *s, GIOCondition cond)
> @@ -382,6 +397,7 @@ static void qemu_chr_open_mux(Chardev *chr,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> =C2=A0=C2=A0=C2=A0=C2=A0 *be_opened =3D muxes_opened;
> =C2=A0=C2=A0=C2=A0=C2=A0 qemu_chr_fe_init(&d->chr, drv, errp);
> +=C2=A0=C2=A0=C2=A0 mux_update_winsize(chr);
> =C2=A0}
> =C2=A0
> =C2=A0static void qemu_chr_parse_mux(QemuOpts *opts, ChardevBackend
> *backend,
>=20

When changing the focussed chardev, the MuxChardev should send a resize
event to the newly focussed chardev. Otherwise the size information of
the focussed chardev might be outdated if it wasn't the focussed
chardev at the time of the resize event.

Theoretically, the resize event could also just be sent to all
character devices focussed or not, however as this causes a lot of
needless redrawing I prefer the approach of only resizing the focussed
chardev.

Kind regards,
Max Brandtner


