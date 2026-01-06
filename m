Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53001CEFD0C
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 20:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdE5M-0006k8-GH; Tue, 06 Jan 2026 15:55:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vdE5I-0006hr-Iz; Tue, 06 Jan 2026 15:55:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vdE5G-0006uV-CJ; Tue, 06 Jan 2026 15:55:19 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 606JBUN0003620;
 Tue, 6 Jan 2026 20:55:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=J448+z
 OkvqrpWI0+AnkCjRUBil43U6dyNnn4MnOYjhU=; b=laLyn282yBsSPOCR9cgmv1
 yPmmXVvb9yCHQN81SEtLUcu05iVHv/mCkaEy217bndIovqp6B0a6ZNY/8sasqeU4
 5Wllylaj08VSmpYjoBW/9ynoOL5iFuublRCXhpW3XhUJLsxvOfaoSoNwo7H9jsv8
 yXnZnnMiFuvXphw98RLUdnXKroKM9q0GhvrsMQqNwKQxne+uBKkjQJsizC/9q5Ft
 wXSjqs8Cd+U9nN6V2nrZ6vbbi0vYFnalzNVtndNTKVUjwXFBc++f7r/H26r8XX1q
 n9m3b9oILsKkQFSpMZkFiZjmp/SRr52VqpglSIAzEvuKRTkXWM4548La6csriPMg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4berhk5550-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jan 2026 20:55:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 606JVq62005264;
 Tue, 6 Jan 2026 20:55:16 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bfexk5gyt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jan 2026 20:55:16 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 606KtEhX262716
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Jan 2026 20:55:15 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D9DE058059;
 Tue,  6 Jan 2026 20:55:14 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D7F4058058;
 Tue,  6 Jan 2026 20:55:13 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.132.176]) by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Jan 2026 20:55:13 +0000 (GMT)
Message-ID: <b0cdc4cad25956348b40498d3fd5cff0a6e49d3f.camel@linux.ibm.com>
Subject: Re: [PATCH 01/10] pc-bios/s390-ccw: Fix misattributed function
 prototypes
From: Eric Farman <farman@linux.ibm.com>
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 thuth@redhat.com, mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, mjrosato@linux.ibm.com,
 zycai@linux.ibm.com
Date: Tue, 06 Jan 2026 15:55:13 -0500
In-Reply-To: <20251210205449.2783111-2-jrossi@linux.ibm.com>
References: <20251210205449.2783111-1-jrossi@linux.ibm.com>
 <20251210205449.2783111-2-jrossi@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=P4s3RyAu c=1 sm=1 tr=0 ts=695d76b4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=v8kHORh2FYsROd1Kk18A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: AH0hfR22c591QA0ThAzfCEgxI4GSGVsO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDE4MCBTYWx0ZWRfX24h661xgc2eR
 pVUlLBMSAw6IzvmP8OVG1TzAqDCuhWYuFcPGuetdFZdlfxG2iRRph6TpxkZNX+qAe53fFZgwkMt
 X8d8ZEZSgxZuzhXmyhgne/yt2FMok+wtKdf01jVgzaistIKVKfCGn4JxHvY3kXN3nha+yI+m0y1
 QLprthZ/SMLOVQEAJph4fewS6PmWzaW4LUZOEToQdX1hWOh1Ab1E74bsuTY/lI5PKwJOYOXupz+
 1UwPz131cHQBz0ve2UOS/kAlF/aXwLFmhFfvdw8/m05m0EzqZA6dbhM+VwJoQCDZ2vQVtn7zbAm
 3EGV9WqLOcCKx3eryxDplaWqqICielV0BQ4ZZ1XFH3Pvk1daVdIE/iEi4710eMkNZhKANK66UiJ
 Y5fklXQDdQHp30necxmvMLrEfImX0FPkLPGD4oaPV07RqjjX2R64VfG6b38pGW45BQ/Kdyr0/Rd
 LGnZ7esao6omidjw+sw==
X-Proofpoint-GUID: AH0hfR22c591QA0ThAzfCEgxI4GSGVsO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601060180
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
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

On Wed, 2025-12-10 at 15:54 -0500, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
>=20
> The virtio-blkdev functions are incorrectly listed in s390-ccw.h as belon=
ging to
> virtio.c.  Additionally, virtio_load_direct() has an unused subchan_id ar=
gument.
>=20
> Remove the unused argument and move the prototypes to virtio.h so that th=
ey are
> independent from the CCW bus.
>=20
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/s390-ccw.h      | 4 ----
>  pc-bios/s390-ccw/virtio.h        | 7 +++++++
>  pc-bios/s390-ccw/bootmap.c       | 2 +-
>  pc-bios/s390-ccw/virtio-blkdev.c | 2 +-
>  4 files changed, 9 insertions(+), 6 deletions(-)

Reviewed-by: Eric Farman <farman@linux.ibm.com>

>=20
> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
> index b1dc35cded..47ea66bd4d 100644
> --- a/pc-bios/s390-ccw/s390-ccw.h
> +++ b/pc-bios/s390-ccw/s390-ccw.h
> @@ -67,11 +67,7 @@ void sclp_get_loadparm_ascii(char *loadparm);
>  int sclp_read(char *str, size_t count);
> =20
>  /* virtio.c */
> -unsigned long virtio_load_direct(unsigned long rec_list1, unsigned long =
rec_list2,
> -                                 unsigned long subchan_id, void *load_ad=
dr);
>  bool virtio_is_supported(SubChannelId schid);
> -int virtio_blk_setup_device(SubChannelId schid);
> -int virtio_read(unsigned long sector, void *load_addr);
> =20
>  /* bootmap.c */
>  void zipl_load(void);
> diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
> index 5c5e808a50..597bd42358 100644
> --- a/pc-bios/s390-ccw/virtio.h
> +++ b/pc-bios/s390-ccw/virtio.h
> @@ -277,7 +277,14 @@ int virtio_run(VDev *vdev, int vqid, VirtioCmd *cmd)=
;
>  int virtio_reset(VDev *vdev);
>  int virtio_setup_ccw(VDev *vdev);
> =20
> +/* virtio-net.c */
>  int virtio_net_init(void *mac_addr);
>  void virtio_net_deinit(void);
> =20
> +/* virtio-blkdev.c */
> +int virtio_blk_setup_device(SubChannelId schid);
> +int virtio_read(unsigned long sector, void *load_addr);
> +unsigned long virtio_load_direct(unsigned long rec_list1, unsigned long =
rec_list2,
> +                                 void *load_addr);
> +
>  #endif /* VIRTIO_H */
> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
> index 0f8baa0198..420ee32eff 100644
> --- a/pc-bios/s390-ccw/bootmap.c
> +++ b/pc-bios/s390-ccw/bootmap.c
> @@ -662,7 +662,7 @@ static int zipl_load_segment(ComponentEntry *entry)
>                   */
>                  break;
>              }
> -            address =3D virtio_load_direct(cur_desc[0], cur_desc[1], 0,
> +            address =3D virtio_load_direct(cur_desc[0], cur_desc[1],
>                                           (void *)address);
>              if (!address) {
>                  puts("zIPL load segment failed");
> diff --git a/pc-bios/s390-ccw/virtio-blkdev.c b/pc-bios/s390-ccw/virtio-b=
lkdev.c
> index 7b2d1e20f4..4b819dd80f 100644
> --- a/pc-bios/s390-ccw/virtio-blkdev.c
> +++ b/pc-bios/s390-ccw/virtio-blkdev.c
> @@ -64,7 +64,7 @@ int virtio_read_many(unsigned long sector, void *load_a=
ddr, int sec_num)
>  }
> =20
>  unsigned long virtio_load_direct(unsigned long rec_list1, unsigned long =
rec_list2,
> -                                 unsigned long subchan_id, void *load_ad=
dr)
> +                                 void *load_addr)
>  {
>      u8 status;
>      int sec =3D rec_list1;

