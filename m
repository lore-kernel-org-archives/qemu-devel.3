Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0613C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 15:19:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woN6h-0002xR-2W; Mon, 27 Jul 2026 11:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1woN6f-0002wH-3t; Mon, 27 Jul 2026 11:19:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1woN6c-0000fR-U5; Mon, 27 Jul 2026 11:19:04 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66RDmin52373188; Mon, 27 Jul 2026 15:18:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ApfTvE
 Z0MfHBh2loC2KVcgW7ocvRYTgNG6Vatzb7s+w=; b=L/Uf40oZeRphMboO5HsjIN
 PYc1iy6KYUsQ3hdzs19do4WLxtztcfmOszUH0VkUbtadkeLojo3JYWgIwDT++quj
 gSBvyky42VjC9G5hq7CAK4R3oYjpFbyEaTbgwWMbgVgmlrdcT+Q9+1ng9Q+y4HYl
 LL6E6Xgk+iRTeC75gASk2wQ6EqYi9Zox75DZcqRm0FKBvwS0UCZXd6Qk9B1igwtK
 D3kHMgi8UCyO7cTMYZQGnXwxbxw3PgGM1IaigikHGYdjxCcvMfRraE+uwLLCKXRU
 vPnL5Q38B0i5BKFvmuTY7xo9k6ii9kY5zlH9Cy9uXrrk69ugdJ5ADZRefORnimtw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw78q90-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jul 2026 15:18:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RFBGvv028397;
 Mon, 27 Jul 2026 15:18:57 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fq61yn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jul 2026 15:18:57 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66RFIt1A32703132
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jul 2026 15:18:55 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8DD7B5805E;
 Mon, 27 Jul 2026 15:18:55 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 79B1D5805A;
 Mon, 27 Jul 2026 15:18:54 +0000 (GMT)
Received: from [9.61.157.32] (unknown [9.61.157.32])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 Jul 2026 15:18:54 +0000 (GMT)
Message-ID: <bfa3b015-b632-47d4-aa3b-61f365b84e64@linux.ibm.com>
Date: Mon, 27 Jul 2026 11:18:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] pc-bios/s390-ccw: fix out-of-bounds read in
 iso_get_file_size()
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Joshua Daley <jdaley@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Jared Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Christian Borntraeger <borntraeger@inux.ibm.com>
References: <20260727115052.24289-1-borntraeger@linux.ibm.com>
 <20260727115052.24289-4-borntraeger@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260727115052.24289-4-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZRDVQStADC6fD7hPBrkCSmOFiyCAxJ2z
X-Proofpoint-ORIG-GUID: ZRDVQStADC6fD7hPBrkCSmOFiyCAxJ2z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE0NCBTYWx0ZWRfX+iy/Pmx1D29i
 ZXQH5OUyKA4Nsu5VsycKwXF/Mtd0SryJ2tQBZuc3oPnm1CbCb7+poMtSCYZmfEex5DoWo1314ly
 Lh79Renmi8oeWp5Mb/bcF1QAHLHMIppvj3CmJFENAXnNw9rRjQK+ycFJH8OB3A9UYzJ/Z1h6MPq
 A0qYNGKVWS9s+IKvqJd4kmYWof7+Dd6Um8mKe/gr0pZCyBVSiEV+HV3QJaBuhgsPBFiP4Y+kQjD
 9dafDR/IP4MHgBDdcxOfX+3mAdXNOqHUC9b5VMb1DAPPa3DmhpJKfsKqc0tf2pkCr6aBYHqFUQ6
 up0ASqhuTJwOb4bImStczPP4GaSSjDRv31ZsFLPr91a8AbK43FFBNRlV4wnUiJi4EZwlnPJN15a
 jx9ccORlvwDzKv3HxL18Um9VmxmUy7R7qLGoWtYKoG5nV+aqJPErj7n90uotFCNDvzRPzq6ViOl
 4MYln0jNQ0z2WJ9lCmg==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6776e2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=WEOf0O4jm6CEY0_B44gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE0NCBTYWx0ZWRfX0X6uGbkEmC5W
 nZm+RBYPciNy8V3NGIQP12x8pgGGslWb3M4rO2pIfJro7JmbWfBSGDrwiWAtKwQd/23wenyKhv6
 O5WykXKPLrmjsNi4JaPWbijaENx+20I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270144
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 7/27/26 7:50 AM, Christian Borntraeger wrote:
> From: Joshua Daley <jdaley@linux.ibm.com>
> 
> In the dir_rem[level] == 0 case, level is decremented, then
> a virtio_read() is issued on sec_loc[level]. If level is -1, then the
> 4 bytes before the static sec_loc array are read, and the virtio_read()
> is issued on that garbage block number.
> 
> Guard the call to virtio_read() against the value of level to prevent
> this.
> 
> Fixes: 869648e87eeb ("pc-bios/s390-ccw: El Torito 16-bit boot image size field workaround")
> Signed-off-by: Joshua Daley <jdaley@linux.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@inux.ibm.com>

Typo in the RB tag, please fix when applying or if there is a v2!

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

> ---
>  pc-bios/s390-ccw/bootmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
> index 420ee32eff..ed6e8cbbc7 100644
> --- a/pc-bios/s390-ccw/bootmap.c
> +++ b/pc-bios/s390-ccw/bootmap.c
> @@ -902,7 +902,7 @@ static inline long iso_get_file_size(uint32_t load_rba)
>          if (dir_rem[level] == 0) {
>              /* Nothing remaining */
>              level--;
> -            if (virtio_read(sec_loc[level], temp)) {
> +            if (level >= 0 && virtio_read(sec_loc[level], temp)) {
>                  puts("Failed to read ISO directory");
>                  return -EIO;
>              }


