Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E33C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 04:09:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf8jU-0004Lj-1g; Thu, 02 Jul 2026 00:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wf8jR-0004L2-16; Thu, 02 Jul 2026 00:08:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wf8jO-000790-NS; Thu, 02 Jul 2026 00:08:56 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6621KMit2346923; Thu, 2 Jul 2026 04:08:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=i9l8ZZ
 K830Si1Ofv1zTwOiGHWjhE9caAEm4rsscSqVY=; b=SKfH9o0/Otna7AF6sSTRAi
 dBekx1YL/U8zKZyxTdE/zogy9KIaVYkOfqm/xyL0wpP/wD0tLOKllPGLPFwxb1qM
 jII5AecH23Z/DUGs+zo7FUZoajctU8+8kTIn1LlmuunrCkNGZqrLwVgorIFVmwVr
 Mj1ZTCm6bdKHt55g0Zl3sBMZOcGvNa18SCibpq7npPYrg9CN1JjHVhkYu9u8Hgpr
 40Mc6XuJUgvFjCF6Al5dUqqCfffwFoQv6Jgyt1+VF2gpWM7EbUnBkmOeZIGDtjlc
 iZGew1oYuzm6NPs8HGfzxSfspQcyUUHgy/81FCQcW97cqbWvA/FcXDYl2qXD6fig
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mjykr9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 04:08:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66244bZu017650;
 Thu, 2 Jul 2026 04:08:50 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2gj77x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 04:08:49 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66248nbV13042310
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Jul 2026 04:08:49 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1CFD05805A;
 Thu,  2 Jul 2026 04:08:49 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 72A735805C;
 Thu,  2 Jul 2026 04:08:47 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.136.69]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Jul 2026 04:08:47 +0000 (GMT)
Message-ID: <8347c74676adb2c25dc619abe920d0c82341ac82.camel@linux.ibm.com>
Subject: Re: [PATCH v12 23/35] pc-bios/s390-ccw: Add signature verification
 for secure IPL in audit mode
From: Eric Farman <farman@linux.ibm.com>
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Date: Thu, 02 Jul 2026 00:08:47 -0400
In-Reply-To: <20260701204922.1320349-24-zycai@linux.ibm.com>
References: <20260701204922.1320349-1-zycai@linux.ibm.com>
 <20260701204922.1320349-24-zycai@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAzNCBTYWx0ZWRfXydy79u0xVfLW
 Mv5fovJL1nlWNo3eTdQoA4ItPN6GVQQ1n9aTbemCScK/4iz8KG8oqjRe2EKMFzwDT4dV3vEW7Ib
 nKNz5k2/c/dVvUPe20vKfPswiY10CtLTTBDr7jp/q6kaGbnOFXfts2zvqn+M4oKOWA5w5TE62gD
 EMoGgz6GOmZqoKWMbKkJssvRFcO7yUv7qhq9aYrtex8uXp6R5DYfw84p0d8KuP6+xpmh68Kyugf
 xuIZpcxsy4QkNJ+4gFgRROBXTXaJALNn4QTzR/taot1srPmxC8f4e9tKDLBZib5850zAcOvAYAG
 B446kwXKu4f58Ivz97uIzxK0KOsDCUg6YiPNIWu2KEwh2diJaxT7PzIDXuRZzhoS3q6TOUqTKfs
 7BDy5zxlZqF4kve56UXCGK4ybiIbSR1jdfVKm09SwT/zznR4NkNiHN8docGvCdYWZm+P+DB7V7b
 +gSaET7o7pDFrE2Ky2A==
X-Proofpoint-GUID: _ythjTq0jfCzW-k6Kz20X0c_L5n8kxjg
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a45e452 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=3lo2IEksWZ017zfnk4MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAzNCBTYWx0ZWRfX3M3V/18t2W/L
 2wdoxqS6fN5FuLyIcBbMBObiLjQe5NeI/kMJbRBTKxQ5RLfswFmGPWVJkA3drhG+480XgWslyfu
 o1HaE8/mlBH8FeOEJUWc9gt9PWk3cC8=
X-Proofpoint-ORIG-GUID: _ythjTq0jfCzW-k6Kz20X0c_L5n8kxjg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020034
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

On Wed, 2026-07-01 at 16:49 -0400, Zhuoying Cai wrote:
> Enable secure IPL in audit mode, which performs signature verification,
> but any error does not terminate the boot process. Only warnings will be
> logged to the console instead.
>=20
> Secure IPL in audit mode requires at least one certificate provided in
> the key store along with necessary facilities (Secure IPL Facility,
> Certificate Store Facility and secure IPL extension support).
>=20
> Note: Secure IPL in audit mode is implemented for the SCSI scheme of
> virtio-blk/virtio-scsi devices.
>=20
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>  docs/system/s390x/secure-ipl.rst |  15 ++
>  pc-bios/s390-ccw/Makefile        |   2 +-
>  pc-bios/s390-ccw/bootmap.c       |  27 +++
>  pc-bios/s390-ccw/bootmap.h       |   9 +
>  pc-bios/s390-ccw/jump2ipl.c      |   7 +
>  pc-bios/s390-ccw/main.c          |  18 +-
>  pc-bios/s390-ccw/s390-ccw.h      |  20 ++
>  pc-bios/s390-ccw/sclp.c          |  27 +++
>  pc-bios/s390-ccw/sclp.h          |   6 +
>  pc-bios/s390-ccw/secure-ipl.c    | 362 +++++++++++++++++++++++++++++++
>  pc-bios/s390-ccw/secure-ipl.h    | 116 ++++++++++
>  11 files changed, 607 insertions(+), 2 deletions(-)
>  create mode 100644 pc-bios/s390-ccw/secure-ipl.c
>  create mode 100644 pc-bios/s390-ccw/secure-ipl.h

...snip...

>=20
> diff --git a/pc-bios/s390-ccw/secure-ipl.c b/pc-bios/s390-ccw/secure-ipl.=
c
> new file mode 100644
> index 0000000000..2d9a4cbc02
> --- /dev/null
> +++ b/pc-bios/s390-ccw/secure-ipl.c

...snip...

> +void update_cert_list(IplSignatureCertificateList *cert_list)
> +{
> +    IplSignatureCertificateEntry *cert_entry;
> +    uint8_t *cert_buf;
> +
> +    cert_buf =3D (uint8_t *)qipl.ipl_data;
> +
> +    for_each_rb_entry(cert_entry, cert_list) {
> +        memcpy(cert_buf, (uint8_t *)cert_entry->addr, cert_entry->len);
> +        cert_entry->addr =3D (uint64_t)cert_buf;
> +        cert_buf +=3D cert_entry->len;
> +    }
> +}

Apologies if this is elsewhere in the patch (I'll revisit this tomorrow wit=
h coffee), but is there
any limit to the number of entries in this loop, or could we walk off the e=
nd of qipl.ipl_data with
a sufficiently large list?

