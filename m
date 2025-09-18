Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE062CAC59F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 08:46:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzAH9-0002gC-LL; Thu, 18 Sep 2025 04:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxbr@linux.ibm.com>)
 id 1uzAH6-0002e2-LJ
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 04:45:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxbr@linux.ibm.com>)
 id 1uzAH0-00038U-1a
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 04:45:56 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I4abIg003223;
 Thu, 18 Sep 2025 08:45:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=RsY2iJ
 NX3CMZ21NJTGhfpFeVcD8v8wgJZhPxI9ysjm0=; b=q70G7i07XLwW/qy8cXVl+2
 Kvnv0jkGzLUGPgoyVa4oQb8ma7xKs2bfAVTgs70uFnYYaGjxQ6Ma/LszCEDb1kXZ
 SY4+igSwd/FBQOSqdKUT5qfkm+UBaYfh2QkTqqlZvIVZbFg7JXVAyfatIcDe+WrW
 cEaHXLPzddcoCYDPOkpXr1zLUyOl6Tci7ULpB7U2MsAWd3lrkC35n5hGvk6QRZdo
 XZV1CF0Ali1ypajz7gmTUfXnyIQ5Aa1CRDarIo3cc4nUBgDzj+UIYapn//gW89bY
 sL2AEcAi2xJGc/3Iu5S6ErsAEJTfJKbMPF1l8XEPzkSM1xLiHljy1Ds+Mntvuq3Q
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4hs2gq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Sep 2025 08:45:18 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58I8bqSx001336;
 Thu, 18 Sep 2025 08:45:17 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4hs2gf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Sep 2025 08:45:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58I7CwYk018625;
 Thu, 18 Sep 2025 08:45:16 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 495n5mnjka-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Sep 2025 08:45:16 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58I8jEAZ52888032
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Sep 2025 08:45:14 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BA38A20043;
 Thu, 18 Sep 2025 08:45:14 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EB2A820040;
 Thu, 18 Sep 2025 08:45:13 +0000 (GMT)
Received: from li-9b52914c-2c8b-11b2-a85c-a36f6d484b4a.ibm.com (unknown
 [9.87.148.84]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 18 Sep 2025 08:45:13 +0000 (GMT)
Message-ID: <e025952d0d0e1f78b68cfe42dbe39975570a94bc.camel@linux.ibm.com>
Subject: Re: [PATCH v4 03/10] chardev: add qemu_chr_resize()
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
Date: Thu, 18 Sep 2025 10:45:13 +0200
In-Reply-To: <20250912-console-resize-v4-3-7925e444afc4@gmail.com>
References: <20250912-console-resize-v4-0-7925e444afc4@gmail.com>
 <20250912-console-resize-v4-3-7925e444afc4@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ig8hWsNWlqcxyofXK-2W7gy4IbPjJoQw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfXw3pUgZYKW3O/
 c/IEm9aaWC4NbeGvzzUOZA96tN6tw4ft07mZ5Y6pG6ksDbvvwhzRk85bOv/X0Y6mVu7JwLl04V0
 wIgq21ygeIq8H7DjWlmS5FUH/DghEFDmJZumgbSO7Bje96n7vp+l5YaX2BpPOxIBj0uuJY1r5FK
 WKZBRCXNiTIt4rNYiR+v94RARs/FeWihvBGTHAES1DcKF7tLD+YlOJotjFxrLWKBF9ORFpoaCST
 g3JdmvcQTulgtF6NwlU/2+WAn1y7PxkzzeaxMitxrZwJHIiQ6U53PqlW2ed0BmaDDOFg2qaU758
 iXwD66S5KmLZYe2Ltspp51xZ/zDUV2eUoTDT+yM6AXf2BsrAjCg7t5XzCMJtcR+Jasnh6vbwAlg
 s7nHPiq8
X-Proofpoint-GUID: UpuktDXXsdBxK2lIH1rPx8QKrS2o8LHs
X-Authority-Analysis: v=2.4 cv=co2bk04i c=1 sm=1 tr=0 ts=68cbc69e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=qqYWhntMKs6fX_BiRNYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160204
Received-SPF: pass client-ip=148.163.156.1; envelope-from=maxbr@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> This function should be called whenever we learn about a new size of
> the terminal connected to a chardev.
>=20
> Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
> Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
> ---
> =C2=A0chardev/char.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 11=
 +++++++++++
> =C2=A0include/chardev/char.h |=C2=A0 2 ++
> =C2=A02 files changed, 13 insertions(+)
>=20
> diff --git a/chardev/char.c b/chardev/char.c
> index
> 635d19fea4fd4bd0c7f171f055fe940f9f5ebed5..b45d79cb9b57643827eb7479257
> fdda2cf6b0434 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -351,6 +351,17 @@ int qemu_chr_wait_connected(Chardev *chr, Error
> **errp)
> =C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> =C2=A0}
> =C2=A0
> +void qemu_chr_resize(Chardev *chr, uint16_t cols, uint16_t rows)
> +{
> +=C2=A0=C2=A0=C2=A0 if (cols !=3D chr->cols || rows !=3D chr->rows) {

Perhaps it would be better to discard resize events if the requested
cols or rows is 0 as it indicates that an error has occurred at some
point during the process of receiving the winsize.

> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chr->cols =3D cols;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chr->rows =3D rows;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (chr->be_open) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_=
chr_be_event(chr, CHR_EVENT_RESIZE);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> =C2=A0QemuOpts *qemu_chr_parse_compat(const char *label, const char
> *filename,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool permit_mux_mon)
> =C2=A0{
> diff --git a/include/chardev/char.h b/include/chardev/char.h
> index
> 45cb6349756ac8072dffab9354108caf90cd3565..1e69b038241074d627ebb7f096e
> 98aee9953ebdf 100644
> --- a/include/chardev/char.h
> +++ b/include/chardev/char.h
> @@ -232,6 +232,8 @@ int qemu_chr_write(Chardev *s, const uint8_t
> *buf, int len, bool write_all);
> =C2=A0#define qemu_chr_write_all(s, buf, len) qemu_chr_write(s, buf, len,
> true)
> =C2=A0int qemu_chr_wait_connected(Chardev *chr, Error **errp);
> =C2=A0
> +void qemu_chr_resize(Chardev *chr, uint16_t cols, uint16_t rows);
> +
> =C2=A0#define TYPE_CHARDEV "chardev"
> =C2=A0OBJECT_DECLARE_TYPE(Chardev, ChardevClass, CHARDEV)
> =C2=A0
>=20


