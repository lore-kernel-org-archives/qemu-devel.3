Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8FF4C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 15:33:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woNKO-0007Ix-9p; Mon, 27 Jul 2026 11:33:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1woNK6-0007HW-3t; Mon, 27 Jul 2026 11:32:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1woNK4-0002li-4N; Mon, 27 Jul 2026 11:32:57 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66RDmcbp2406258; Mon, 27 Jul 2026 15:32:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=gzup6f
 kz5loGOeGPGAdWWnzqhUIYIoePQYDAzEamxDo=; b=OpPkEi6CbsHU7EflkyLp8a
 KpbdZiMADkjWT76fmkqB4DFAyrVpvmF/g4jIPMhZYHnb+xwyOTGGT3RtFmuBf4GM
 4Q64Sq50N+YOt0G7gW2IxCQHrv8ZltgTI24MEEAfG3HODX0rowwjK9IBk54kd8i0
 stJOSddSA6sikKAFqPYHrGQyoG3emJ4poOxUoYk/HgD88zo6jr1D+JYmvnLu24tW
 jZqFafjA2N+aj0K3Es8i4AuMyPdqqT3uWAcO9XjmdGbb9QywifOtALrPGbutCRJB
 majmNSNGizmEftE3tHVSnDo19KHq38HujxzpwF965QC+xKfmdW3GlgUj/Mw8AVhw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xgs91-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jul 2026 15:32:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RFQLJt000485;
 Mon, 27 Jul 2026 15:32:50 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fjwxht-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jul 2026 15:32:50 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66RFWnih17040026
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jul 2026 15:32:49 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1DFD758052;
 Mon, 27 Jul 2026 15:32:49 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 19C9F5805A;
 Mon, 27 Jul 2026 15:32:48 +0000 (GMT)
Received: from [9.61.157.32] (unknown [9.61.157.32])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 Jul 2026 15:32:48 +0000 (GMT)
Message-ID: <daff87d9-414d-4aa6-8b13-84d657fdaaef@linux.ibm.com>
Date: Mon, 27 Jul 2026 11:32:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] pc-bios/s390-ccw: bounds-check zipl menu entry index
 before array write
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
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260727115052.24289-1-borntraeger@linux.ibm.com>
 <20260727115052.24289-5-borntraeger@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260727115052.24289-5-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PiK7OeYOQEnFl1ENUZhHowZwf52Lxx9i
X-Proofpoint-ORIG-GUID: PiK7OeYOQEnFl1ENUZhHowZwf52Lxx9i
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE0NCBTYWx0ZWRfX26T/titi/j7a
 DS2orNewKUBQpZF4r1HCAWJCCwfZyhdvXhJfF//q1qyWxA9EiP79EQC+5+WN2T1SF36ujLmhPPo
 r9bN1Hc/IFjC7fwus6619Ks2hEGzkvg=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a677a23 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=I5xs7Sx5vgVjegy3sAAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE0NCBTYWx0ZWRfX7H+iALIYJ6Un
 lhXQp5Q2X1bDYwbtk/GJ2iyzw1v/GST/rlZRV6P4NMfjPWDzxlQEZede3yGAA8JUMkuqRVfDYxQ
 20xmAIvgBuZGrE+ZmFbPvs1fwwrWs1ao6nyrnyKxvMTEsjy4312uJ+XUGqFetqLCRwrsv2VzVEU
 Okk+ECq18O0EG2yKhL2ydBHVAyzG6RbZW3ivmKjYoRvj7b2aO//R5FQbvJ1dtPgdm3B3IqjDnOn
 sggMzjvy2D5iSM7SGsNv0FEijzq9ZDAbipTBsZVcEi56z04gFFY8QyRIfWVEbUn0YA4MIoGnX9/
 jELlv8mDZ8wgGUknoIFYdzGnQ3D7v897B0BVZTEIBVpobfCiiOL0zBdDZx73NMd5y7vE1K4ZhvZ
 GgAJOzApBScrhgXcXWjBoj5DgfZbDY7nqMra435UCvu2iRG87NHaczkUKql5/whkhxvIIM9QSyi
 Xb8ePVEgf3JJa8IPHyw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270144
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
> menu_get_zipl_boot_index() iterates NUL-separated strings from the
> zipl stage-2 boot-menu block, passes each to zipl_print_entry() which
> converts EBCDIC to ASCII and returns atoi(), then writes true into
> valid_entries[entry]. valid_entries is a MAX_BOOT_ENTRIES element
> stack array, but entry was never bounds-checked, so a crafted on-disk
> value could index arbitrarily beyond the array.
> 
> Fix this in two places:
> 
> - zipl_print_entry() now validates that the first significant character
>   (after an optional leading space) is a digit. Entries that fail this
>   check return -1 without printing.
> 
> - menu_get_zipl_boot_index() skips any entry whose index is outside
>   [0, MAX_BOOT_ENTRIES) before writing to valid_entries[].
> 
> Fixes: 7385e947fc65 ("pc-bios/s390-ccw: fix non-sequential boot entries (eckd)")
> Signed-off-by: Joshua Daley <jdaley@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

> ---
>  pc-bios/s390-ccw/menu.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
> index eeaff78f87..b6a9a56d46 100644
> --- a/pc-bios/s390-ccw/menu.c
> +++ b/pc-bios/s390-ccw/menu.c
> @@ -176,18 +176,24 @@ int menu_get_boot_index(bool *valid_entries)
>      return boot_index;
>  }
>  
> -/* Returns the entry number that was printed */
> +/* Returns the entry number that was printed, or -1 on invalid entry */
>  static int zipl_print_entry(const char *data, size_t len)
>  {
>      char buf[len + 2];
> +    const char *p;
>  
>      ebcdic_to_ascii(data, buf, len);
>      buf[len] = '\n';
>      buf[len + 1] = '\0';
>  
> +    p = (buf[0] == ' ') ? buf + 1 : buf;
> +    if (!isdigit((unsigned char)*p)) {
> +        return -1;
> +    }
> +
>      printf("%s", buf);
>  
> -    return buf[0] == ' ' ? atoi(buf + 1) : atoi(buf);
> +    return atoi(p);
>  }
>  
>  int menu_get_zipl_boot_index(const char *menu_data)
> @@ -216,6 +222,9 @@ int menu_get_zipl_boot_index(const char *menu_data)
>          entry = zipl_print_entry(menu_data, len);
>          menu_data += len + 1;
>  
> +        if (entry < 0 || entry >= MAX_BOOT_ENTRIES) {
> +            continue;
> +        }
>          valid_entries[entry] = true;
>  
>          if (entry == 0) {


