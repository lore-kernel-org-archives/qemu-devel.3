Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C42FCA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 19:29:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBH28-0008AP-P0; Mon, 28 Sep 2026 15:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxbr@linux.ibm.com>)
 id 1xBH27-0008AA-EB; Mon, 28 Sep 2026 15:29:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxbr@linux.ibm.com>)
 id 1xBH25-0003GW-2t; Mon, 28 Sep 2026 15:29:03 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SI5MeY4187633; Mon, 28 Sep 2026 19:28:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=DOj1lW
 LrdxcsgnPxMCU8iTDJyqV8emFf5H+Sv4J0HtE=; b=d2awK95oFfsQJV+aCXsQHK
 PZO1bmZ2FJnVQCJKKpmfRPgPI+Ncy14GLnUr98QqbxoS4TKEPOspvmomb8R3LKWa
 MMUAvPFLdKV2v5D4Qna26x31kP0xiK4SQwx+TCZ5TE4lLyLeuZKuDrhVkcnVdx6r
 B16Y7CHGalAzuWKLfuVazHBz/m5cNVfBwWgjiLwprOkP1u+whh2XTFzqlesia4wq
 J2oQDX8ajaHQRdKVv+cXCjCmPvH6md88TUukjhzU9T1aE2K+FHqNvFQmB4kcJ108
 rzxgN8LY69oggV+2+Fdau6nRUawFK/3cFKhGfoLd9+QcTC6Hu837UFDeMpLqUmvQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qr3dj2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 28 Sep 2026 19:28:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SI2hPm532504; Mon, 28 Sep 2026 19:28:49 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsvhen71-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Sep 2026 19:28:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68SJSigq9830850
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Sep 2026 19:28:45 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D915A20043;
 Mon, 28 Sep 2026 19:28:44 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CABB420040;
 Mon, 28 Sep 2026 19:28:42 +0000 (GMT)
Received: from li-fa2166e9-1f7d-4f1a-8ca5-7ccf0f022c25.ibm.com (unknown
 [9.111.43.35]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 28 Sep 2026 19:28:42 +0000 (GMT)
Message-ID: <557a71b95eb900454adc477ad16154e1466f13d9.camel@linux.ibm.com>
Subject: Re: [PATCH v2] s390x/sclpconsole: implement resizing for vt220
 consoles
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: "Jason J. Herne" <jjherne@linux.ibm.com>, filip.hejsek@gmail.com
Cc: amit@kernel.org, armbru@redhat.com, berrange@redhat.com, eblake@redhat.com,
 eduardo@habkost.net, lvivier@redhat.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, mst@redhat.com, noh4hss@gmail.com,
 pbonzini@redhat.com, philmd@mailo.com, qemu-devel@nongnu.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 mjrosato@linux.ibm.com, brueckner@linux.ibm.com, farman@linux.ibm.com,
 cohuck@redhat.com, maximilian.immanuel.brandtner@protonmail.com
Date: Mon, 28 Sep 2026 21:28:42 +0200
In-Reply-To: <e17a5337-849a-428a-b8e4-65fd92a8c186@linux.ibm.com>
References: <20260921121641.1354712-1-maxbr@linux.ibm.com>
 <20260928090846.2315532-1-maxbr@linux.ibm.com>
 <e17a5337-849a-428a-b8e4-65fd92a8c186@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA3NiBTYWx0ZWRfX3kv0Gqkc79JL
 paI5IH6+gznXzUaaAUW6jk+q5HXhheoBm5cGqg5kR3U/mp2g+cs0pM/mb2LLM3C/Kgafo6Eomga
 CbuMKtDnPUO1s2x19E88OEAMvO4t0vKBIIV2+NohakhVwj1qyjk1DVvVn0+RV1CvOiHjs1Lng5R
 n4I9e41tRWSUEa6B7fV8Loy7vvWOeuLybLiIgqYTvmsPuf9SSSywiXEKeHNmfocyvcIBTXiUTC+
 YTEJggkHV6bGe1WCzJMsr6mnBpv6JAzOHO6GYJb5jr+yBE1ADo88x8jQgXGS8Krx8Gm36LJtYYH
 qgvjb0SgSqeY36jKKIsZ/j/PhkZsHjgDFLJvrrvl9l22dhI0O12W6nnDfmz7eAMp0bGvkPDO+Pc
 gzPRC6r4NPfMFEUOk4PW1saPD7jb4kh7nZdxlyaGqqIUbh2g/ehdwZ645mtZ8025OW5czXxnBQW
 6NoqN7GgBNFqSIAE7Ug==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6ababff2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=Kadzyh2ZY87WCsIF0bUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 2U7PU1emLHhSijkI7AVAX03dDqXy-41v
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA3NiBTYWx0ZWRfX/ufpuRjqAiB7
 ZKDsn+KFHhZflLmo6NjL6tlflQNF58TrCDBU4fyLey/+Y7v/roSlBdNPIA6Jbe0tOMNJdYwOuzC
 AZGwSVW1A8dhNeWj9Ejkrdqf1uO5Da4=
X-Proofpoint-GUID: 634dt6mi0bRTFqU1rHNRRqog58cfZB78
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280076
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

On Mon, 2026-09-28 at 09:32 -0400, Jason J. Herne wrote:
>=20
>=20
> On 9/28/26 5:08 AM, Maximilian Immanuel Brandtner wrote:
> > Add a tty code to indicate a resize frame. The body contains two
> > big
> > endian 16-bit integers rows and columns.
> >=20
> > After reset, the guest must be informed of the terminal size again.
> > A
> > chardev that doesn't report its size yields 0x0, which shouldn't
> > replace
> > the guest's default.
> >=20
> > Signed-off-by: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
> > ---
> > Changelog:
> > v2:
> > - Use packed struct and named event type codes for resize frames
> > - Trigger initial resize event in console_reset() instead of
> > =C2=A0=C2=A0 console_init(), skip when chardev reports no size
> > - Reset event_pending after resize event
> >=20
> > Requires the following pre-req:
> > =C2=A0=C2=A0=C2=A0=C2=A0 [PATCH v7 00/12] virtio-console: notify about =
the terminal
> > size
> > =C2=A0=C2=A0=C2=A0=C2=A0
> > (https://lore.kernel.org/qemu-devel/20260609-console-resize-v7-0-0c
> > 550fdcec15@gmail.com/)
> >=20
> > Testing:
> > - Tested on QEMU: commit 38879a667f with the following patches
> > applied:
> > =C2=A0=C2=A0=C2=A0=C2=A0 [PATCH v7 00/12] virtio-console: notify about =
the terminal
> > size
> > - Tested on linux-next (commit c1f49dea2b8f) with the following
> > patches
> > =C2=A0=C2=A0 applied:
> > =C2=A0=C2=A0=C2=A0=C2=A0 [PATCH 0/2] s390/sclp: Resize for sclp-vt220 c=
onsole
> > ---
> > =C2=A0 hw/char/sclpconsole.c | 92 +++++++++++++++++++++++++++++++++++++=
-
> > -----
> > =C2=A0 1 file changed, 80 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/hw/char/sclpconsole.c b/hw/char/sclpconsole.c
> > index 179d12745c..12033e1e46 100644
> > --- a/hw/char/sclpconsole.c
> > +++ b/hw/char/sclpconsole.c
> > @@ -33,6 +33,9 @@ typedef struct ASCIIConsoleData {
> > =C2=A0 /* max size for ASCII data in 4K SCCB page */
> > =C2=A0 #define SIZE_BUFFER_VT220 4080
> > =C2=A0=20
> > +#define SCLP_CONSOLE_EVENT_TYPE_DATA 0x00
> > +#define SCLP_CONSOLE_EVENT_TYPE_RESIZE 0x08
> > +
> > =C2=A0 struct SCLPConsole {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SCLPEvent event;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CharFrontend chr;
> > @@ -42,6 +45,8 @@ struct SCLPConsole {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t iov_data_len;=C2=A0 /* length o=
f byte stream in
> > buffer=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t iov_sclp_rest; /* length of byt=
e stream not read via
> > SCLP=C2=A0=C2=A0=C2=A0=C2=A0 */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool notify;=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* qemu_notify_event() req'd if
> > true=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0 bool resize;
> > +=C2=A0=C2=A0=C2=A0 bool resize_init;
> > =C2=A0 };
> > =C2=A0 typedef struct SCLPConsole SCLPConsole;
> > =C2=A0=20
> > @@ -49,6 +54,12 @@ typedef struct SCLPConsole SCLPConsole;
> > =C2=A0 DECLARE_INSTANCE_CHECKER(SCLPConsole, SCLP_CONSOLE,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 TYPE_SCLP_CONSOLE)
> > =C2=A0=20
> > +typedef struct SCLPConsoleResizeData {
> > +=C2=A0=C2=A0=C2=A0 uint8_t type;
> > +=C2=A0=C2=A0=C2=A0 uint16_t rows;
> > +=C2=A0=C2=A0=C2=A0 uint16_t cols;
> > +} QEMU_PACKED SCLPConsoleResizeData;
> > +
> > =C2=A0 /* character layer call-back functions */
> > =C2=A0=20
> > =C2=A0 /* Return number of bytes that fit into iov buffer */
> > @@ -81,6 +92,29 @@ static void chr_read(void *opaque, const uint8_t
> > *buf, int size)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sclp_service_interrupt(0);
> > =C2=A0 }
> > =C2=A0=20
> > +static void chr_event(void *opaque, QEMUChrEvent event)
> > +{
> > +=C2=A0=C2=A0=C2=A0 SCLPConsole *scon =3D opaque;
> > +
> > +=C2=A0=C2=A0=C2=A0 assert(scon);
> > +
> > +=C2=A0=C2=A0=C2=A0 switch (event) {
> > +=C2=A0=C2=A0=C2=A0 case CHR_EVENT_RESIZE:
> > +=C2=A0=C2=A0=C2=A0 case CHR_EVENT_MUX_IN:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scon->resize =3D true;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scon->resize_init =3D false=
;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scon->event.event_pending =
=3D true;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sclp_service_interrupt(0);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > +=C2=A0=C2=A0=C2=A0 case CHR_EVENT_BREAK:
> > +=C2=A0=C2=A0=C2=A0 case CHR_EVENT_OPENED:
> > +=C2=A0=C2=A0=C2=A0 case CHR_EVENT_MUX_OUT:
> > +=C2=A0=C2=A0=C2=A0 case CHR_EVENT_CLOSED:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* ignore */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > +=C2=A0=C2=A0=C2=A0 }
> > +}
> > +
> > =C2=A0 /* functions to be called by event facility */
> > =C2=A0=20
> > =C2=A0 static bool can_handle_event(uint8_t type)
> > @@ -104,10 +138,37 @@ static sccb_mask_t receive_mask(void)
> > =C2=A0 static void get_console_data(SCLPEvent *event, uint8_t *buf,
> > size_t *size,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int avail)
> > =C2=A0 {
> > +=C2=A0=C2=A0=C2=A0 SCLPConsoleResizeData resize_data;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SCLPConsole *cons =3D SCLP_CONSOLE(event=
);
> > +=C2=A0=C2=A0=C2=A0 uint16_t rows, cols;
> > +
> > +=C2=A0=C2=A0=C2=A0 if (cons->resize) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (avail < sizeof(resize_d=
ata)) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *si=
ze =3D 0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0=20
> > -=C2=A0=C2=A0=C2=A0 /* first byte is hex 0 saying an ascii string follo=
ws */
> > -=C2=A0=C2=A0=C2=A0 *buf++ =3D '\0';
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_chr_fe_get_winsize(&co=
ns->chr, &cols, &rows);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cons->resize_init && co=
ls =3D=3D 0 && rows =3D=3D 0) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *si=
ze =3D 0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 res=
ize_data.type =3D SCLP_CONSOLE_EVENT_TYPE_RESIZE;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 res=
ize_data.rows =3D cpu_to_be16(rows);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 res=
ize_data.cols =3D cpu_to_be16(cols);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mem=
cpy(buf, &resize_data, sizeof(resize_data));
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *si=
ze =3D sizeof(resize_data);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cons->resize =3D false;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cons->resize_init =3D false=
;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 event->event_pending =3D co=
ns->iov_sclp_rest !=3D 0;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> > +=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0 *buf++ =3D SCLP_CONSOLE_EVENT_TYPE_DATA;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 avail--;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* if all data fit into provided SCLP bu=
ffer */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (avail >=3D cons->iov_sclp_rest) {
> > @@ -150,6 +211,9 @@ static int read_event_data(SCLPEvent *event,
> > EventBufferHeader *evt_buf_hdr,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to =3D (uint8_t *)&acd->data;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 avail =3D *slen - sizeof(ASCIIConsoleDat=
a);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 get_console_data(event, to, &src_len, av=
ail);
> > +=C2=A0=C2=A0=C2=A0 if (src_len =3D=3D 0) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > +=C2=A0=C2=A0=C2=A0 }
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 acd->ebh.length =3D cpu_to_be16(sizeof(A=
SCIIConsoleData) +
> > src_len);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 acd->ebh.type =3D SCLP_EVENT_ASCII_CONSO=
LE_DATA;
> > @@ -233,22 +297,26 @@ static int console_init(SCLPEvent *event)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 console_available =3D true;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_chr_fe_set_handlers(&scon->chr, chr=
_can_read,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 chr_read, NULL, NULL, scon, NULL,
> > true);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 chr_read, chr_event, NULL, scon,
> > NULL, true);
> > =C2=A0=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > =C2=A0 }
> > =C2=A0=20
> > =C2=A0 static void console_reset(DeviceState *dev)
> > =C2=A0 {
> > -=C2=A0=C2=A0 SCLPEvent *event =3D SCLP_EVENT(dev);
> > -=C2=A0=C2=A0 SCLPConsole *scon =3D SCLP_CONSOLE(event);
> > -
> > -=C2=A0=C2=A0 event->event_pending =3D false;
> > -=C2=A0=C2=A0 scon->iov_sclp =3D 0;
> > -=C2=A0=C2=A0 scon->iov_bs =3D 0;
> > -=C2=A0=C2=A0 scon->iov_data_len =3D 0;
> > -=C2=A0=C2=A0 scon->iov_sclp_rest =3D 0;
> > -=C2=A0=C2=A0 scon->notify =3D false;
> > +=C2=A0=C2=A0=C2=A0 SCLPEvent *event =3D SCLP_EVENT(dev);
> > +=C2=A0=C2=A0=C2=A0 SCLPConsole *scon =3D SCLP_CONSOLE(event);
> > +
> > +=C2=A0=C2=A0=C2=A0 scon->iov_sclp =3D 0;
> > +=C2=A0=C2=A0=C2=A0 scon->iov_bs =3D 0;
> > +=C2=A0=C2=A0=C2=A0 scon->iov_data_len =3D 0;
> > +=C2=A0=C2=A0=C2=A0 scon->iov_sclp_rest =3D 0;
> > +=C2=A0=C2=A0=C2=A0 scon->notify =3D false;
> > +
> > +=C2=A0=C2=A0=C2=A0 /* the guest defaults its terminal size on reset, a=
nnounce the
> > real one */
> > +=C2=A0=C2=A0=C2=A0 scon->resize =3D true;
> > +=C2=A0=C2=A0=C2=A0 scon->resize_init =3D true;
> > +=C2=A0=C2=A0=C2=A0 event->event_pending =3D true;
> > =C2=A0 }
>=20
> This is a style fix, included in a functional patch. I suppose it is=20
> probably borderline, but it might be best to put this in its own
> patch.

I thought about that, but concluded that a 6-line indentation commit
would be too small to warrant its own patch. If you'd prefer it to be
split I could also send it as a seperate patch.

>=20
> Other than that:
> Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>

Thanks

