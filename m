Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E998BEF8FE6
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 13:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxmRa-0006C0-4F; Wed, 04 Mar 2026 08:39:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vxmRY-0006Bi-AO; Wed, 04 Mar 2026 08:39:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vxmRW-0004wM-AD; Wed, 04 Mar 2026 08:39:16 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 623KGaHf2165137; Wed, 4 Mar 2026 13:39:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=fzMrhT
 dEZzQDGyazRjLI51YG834KtEZA3DIXnykzB3M=; b=oUdLA5J/SFObq6UN8P+1D6
 HE+/Wmkh+C8Ml6DIAGC5u+9xV7Js6HU93YIfqvsMSvd8WJ8wjMpXZlGUq3a5Yxr3
 c6dtrjD6/vF9JtBeWQV1Q21otKO6d4fwGBmiv8n3e3PvW9Zr9Ccf5zn6a7I4uXwB
 BR+uniFZLohZ0azYx7JlvKyi4KRLxK5QvdphPy3pBbRM4QolxuGczz53mOfRuRB6
 PIi9UW1TLWRsba0uhJBc+2NbMNSCBMPDrIp8jMhWYlKf9gSEevYEFl8vVUa3wdQZ
 1BpDeOuDBVugUuzhiWq4AieJNlqmP15G9wUdSSJOgdYaJKIHjfha09UOBaIAB3Yg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksjdfgxf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2026 13:39:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 624B5RE0010327;
 Wed, 4 Mar 2026 13:39:09 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmc6k6rqx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2026 13:39:09 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 624Dd8Jm33030694
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Mar 2026 13:39:08 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 45C4658062;
 Wed,  4 Mar 2026 13:39:08 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9EBBE5805C;
 Wed,  4 Mar 2026 13:39:07 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.97.94]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Mar 2026 13:39:07 +0000 (GMT)
Message-ID: <7cf98378dcf4223bc999c89a45311e6cff4161b7.camel@linux.ibm.com>
Subject: Re: [PATCH v4 03/15] pc-bios/s390-ccw: Always reset virtio device
 on failed boot attempt
From: Eric Farman <farman@linux.ibm.com>
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 thuth@redhat.com, mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, mjrosato@linux.ibm.com,
 zycai@linux.ibm.com
Date: Wed, 04 Mar 2026 08:39:07 -0500
In-Reply-To: <20260304025917.2157032-4-jrossi@linux.ibm.com>
References: <20260304025917.2157032-1-jrossi@linux.ibm.com>
 <20260304025917.2157032-4-jrossi@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M9BA6iws c=1 sm=1 tr=0 ts=69a835fe cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=zJBeZKDU5A6KwnCt2W4A:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: 1aXADHdi7ASkFn6Gv4Ww5TLdTKz2tv2V
X-Proofpoint-GUID: 1aXADHdi7ASkFn6Gv4Ww5TLdTKz2tv2V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDExMCBTYWx0ZWRfX9XAV9nl3uCn6
 UoNprVbgBq2uzWZmRW/sDY0c2rRmd2QBLkbKZQZW8q2y8BU4iuIuAcXUEVHAJc1xLSZdq9KMUzJ
 4b5lU8ij/jgt8Tab2Tjd1RFuoySyB4P8XddgBU7nHnwp7F5HALmpYhxTh962GlQTHXpi7mDPC/U
 HILiMs5GiSswkwBCqUUAVH66ScukGGwjIg22BnCYKSMfeHmtI9ZbrlEFOE+JyyyiQprQNR2x5PA
 iabkcUucl+SYQxXI75wrDCbA9pD3ZkvpM7JpRtiTacA79qOjwuVGvjwZ3ILu4/9IaZOdvXWZqjV
 8VAH7p8bOqFYSm86WaTYhvhyEf4gOkGWnNyVYPKmRE4uRm50AUK9frh5QzKN5ggQfm8aDB99wq/
 bEIBCQLnV2+q+E7lTSXOpGk/baj6+EVornnwfhQ7HighhVPGn5ehWEqNewqzVfLndy8NbxyD1Ou
 /6yFjybgC7+314YosRg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_06,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040110
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, 2026-03-03 at 21:59 -0500, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
>=20
> The virtio spec necessitates that live virtqueues must not be altered.  R=
eset
> the failed device so that the queues are not live before we attempt to bo=
ot any
> fallback devices.
>=20
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Eric Farman <farman@linux.ibm.com>

>=20
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index 76bf743900..8e2c99bee1 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -277,7 +277,8 @@ static void ipl_boot_device(void)
>          break;
>      case CU_TYPE_VIRTIO:
>          if (virtio_setup() =3D=3D 0) {
> -            zipl_load();
> +            zipl_load(); /* only return on error */
> +            virtio_reset(virtio_get_device());
>          }
>          break;
>      default:

