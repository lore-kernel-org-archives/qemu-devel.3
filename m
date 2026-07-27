Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EBA6C54F4C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 15:52:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woNcg-0002EF-3e; Mon, 27 Jul 2026 11:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1woNce-0002Dx-Nz; Mon, 27 Jul 2026 11:52:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1woNcc-0005cw-Ry; Mon, 27 Jul 2026 11:52:08 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66RDmeVF2406277; Mon, 27 Jul 2026 15:52:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=1W0oSC
 pYhYUESfhvvVQT7qWNpK00SZSEOsx6Sai1STY=; b=J2XHF/kXwpjRpUyPPYRDjS
 u+HE3dmjRfeBp0VKUKh5GmzzYercEVf1ctBmWzMKIiE//i0euDsE8AojMCZOqxXc
 VExiHN5Zxnsgy3rDlJJcIIfDDZa2uSWspjscKMIBBb2fWw1WKd1XgjW7yCK1kJQn
 Rh8jxpkzvGUp0kV18aYufW0x9yQpND8bz4lhULzaSYiZxOZuGQPph7kxj8g2nkQh
 nGu1AXIMuUZQibZWqJ8NgCUfSfLoKK9QQT19dxHlCnki0zc9ygFHt5wG6Fd+Aypw
 zzF3Lg81x8bO0mgDyLd51NDMv9T1qUJahYsF5stYDNkGrwLuJhzI6wJlNNbnffhA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xgumd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jul 2026 15:52:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RFfai4026234;
 Mon, 27 Jul 2026 15:52:01 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yh5wke-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jul 2026 15:52:01 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66RFpNJB12649074
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jul 2026 15:51:23 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8318A58056;
 Mon, 27 Jul 2026 15:51:59 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 756E958052;
 Mon, 27 Jul 2026 15:51:58 +0000 (GMT)
Received: from [9.61.157.32] (unknown [9.61.157.32])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 Jul 2026 15:51:58 +0000 (GMT)
Message-ID: <91d5f2b9-2b32-4b62-95c7-4526261d1326@linux.ibm.com>
Date: Mon, 27 Jul 2026 11:51:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] pc-bios/s390-ccw: bound zipl menu strlen and replace
 VLA in zipl_print_entry
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
 <20260727115052.24289-6-borntraeger@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260727115052.24289-6-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XFbEBZqluv4nu_99KpisJkO6nfR4jD4z
X-Proofpoint-ORIG-GUID: XFbEBZqluv4nu_99KpisJkO6nfR4jD4z
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE0OCBTYWx0ZWRfX8YLdRTRQH/CX
 PTOy7gD6kg3fys0g6IsZaK2qTlkUd5dGqdCqfWjj4WKJKah8cHYJx/MjZUvZ77hJ8/LJTyhU7QM
 7b3gm1q85qZ2Uu6Yw3U2uQkWN9wNuSg=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a677ea2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=TmcFyS7tEBEUxEvcJu0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE0OCBTYWx0ZWRfX3yhtYAM8M6ri
 c9hb/yXGagCzvg6jzpKaYaq/STzhfCwMjkhww1kM0zXg84l+okG8xQKRs+RDYdz/Z1G2SJrnKjn
 vKhBoljz+xhU5XNuiDH/4/8gv8puFJVssmU+JdzYgIGuTltPsOfEsmsjv0udPZezJn14FsrWH1Q
 /ytsM8KmmrtQUrlseeLJ0PqMqzxbhtOwaq88VFrHOgnbcQUDXc/9Zfscq5LypE0zshhMGH9L2R+
 IrNhiHcg0MDP/EHpPVA/eQIycux2b0Qj2IpFpjtIZmADxDTL+nL4NZhl0x12F7VnqzowkU5IfsT
 oP9ROtvpPwPvISS40m3HcLSk3duPBg7n6zdTz1Z2OCfi3wYMHeNh0ZOIMoxMlWWdE/zFFrqdb0r
 mVQvl8I6AMMlqmMQyYZiIfhTFtCNudOPRgA+IzGI3+H23YcSJ87AAyr8sc8j74L9FNMOSjY6BLs
 osOzlptHNVFbZYlZmkQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270148
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
> menu_get_zipl_boot_index() calls strlen() on a pointer into the middle
> of _s2 with no upper bound, so a stage-2 image whose blocks contain no
> NUL bytes causes strlen() to walk beyond _s2. The resulting length
> is then used to size a stack VLA in zipl_print_entry(), risking a stack
> overflow.
> 
> Fix by:
> 
> - Implementing strnlen(), a bounded version of strlen().
> 
> - Adding a menu_data_end parameter to menu_get_zipl_boot_index() and
>   replacing both strlen() calls with strnlen() bounded by the remaining
>   buffer space. The loop guard also checks that the pointer has not
>   reached menu_data_end. For robustness, the function returns 0
>   (boot default) if somehow menu_data is initially >= menu_data_end.
> 
> - Replacing the VLA char buf[len + 2] in zipl_print_entry() with a fixed
>   ZIPL_ENTRY_MAX + 2 (82-byte) buffer and truncating len before use.
> 
> - Passing s2_end (_s2 + sizeof(_s2)) as menu_data_end at the one call
>   site in eckd_get_boot_menu_index(), so the bound is exactly the end of
>   the buffer.
> 
> Fixes: f7178910845a ("s390-ccw: print zipl boot menu")
> Signed-off-by: Joshua Daley <jdaley@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/bootmap.c  |  4 +++-
>  pc-bios/s390-ccw/helper.h   | 10 ++++++++++
>  pc-bios/s390-ccw/menu.c     | 23 ++++++++++++++++++-----
>  pc-bios/s390-ccw/s390-ccw.h |  2 +-
>  4 files changed, 32 insertions(+), 7 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
> index ed6e8cbbc7..81512265ce 100644
> --- a/pc-bios/s390-ccw/bootmap.c
> +++ b/pc-bios/s390-ccw/bootmap.c
> @@ -61,6 +61,7 @@ static uint8_t _s2[MAX_SECTOR_SIZE * 3] __attribute__((__aligned__(PAGE_SIZE)));
>  static void *s2_prev_blk = _s2;
>  static void *s2_cur_blk = _s2 + MAX_SECTOR_SIZE;
>  static void *s2_next_blk = _s2 + MAX_SECTOR_SIZE * 2;
> +static void *s2_end = _s2 + sizeof(_s2);
>  
>  static inline int verify_boot_info(BootInfo *bip)
>  {
> @@ -308,7 +309,8 @@ static int eckd_get_boot_menu_index(block_number_t s1b_block_nr)
>                  }
>              }
>  
> -            return menu_get_zipl_boot_index(s2_cur_blk + banner_offset);
> +            return menu_get_zipl_boot_index(s2_cur_blk + banner_offset,
> +                                            s2_end);
>          }
>  
>          prev_block_nr = cur_block_nr;
> diff --git a/pc-bios/s390-ccw/helper.h b/pc-bios/s390-ccw/helper.h
> index 8e3dfcb6d6..d9b7da444a 100644
> --- a/pc-bios/s390-ccw/helper.h
> +++ b/pc-bios/s390-ccw/helper.h
> @@ -45,4 +45,14 @@ static inline void sleep(unsigned int seconds)
>      }
>  }
>  
> +static inline size_t strnlen(const char *s, size_t maxlen)
> +{
> +    size_t len = 0;
> +
> +    while (len < maxlen && s[len]) {
> +        len++;
> +    }
> +    return len;
> +}
> +
>  #endif
> diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
> index b6a9a56d46..af96a83de9 100644
> --- a/pc-bios/s390-ccw/menu.c
> +++ b/pc-bios/s390-ccw/menu.c
> @@ -16,6 +16,7 @@
>  #include "s390-ccw.h"
>  #include "sclp.h"
>  #include "s390-time.h"
> +#include "helper.h"
>  
>  #define KEYCODE_NO_INP '\0'
>  #define KEYCODE_ESCAPE '\033'
> @@ -26,6 +27,9 @@
>  #define ZIPL_TIMEOUT_OFFSET 138
>  #define ZIPL_FLAG_OFFSET    140
>  
> +/* Max printable chars for a zipl boot menu entry */
> +#define ZIPL_ENTRY_MAX 80
> +
>  #define TOD_CLOCK_MILLISECOND   0x3e8000
>  
>  #define LOW_CORE_EXTERNAL_INT_ADDR   0x86
> @@ -179,9 +183,13 @@ int menu_get_boot_index(bool *valid_entries)
>  /* Returns the entry number that was printed, or -1 on invalid entry */
>  static int zipl_print_entry(const char *data, size_t len)
>  {
> -    char buf[len + 2];
> +    char buf[ZIPL_ENTRY_MAX + 2];
>      const char *p;
>  
> +    if (len > ZIPL_ENTRY_MAX) {
> +        len = ZIPL_ENTRY_MAX;
> +    }
> +
>      ebcdic_to_ascii(data, buf, len);
>      buf[len] = '\n';
>      buf[len + 1] = '\0';
> @@ -196,7 +204,7 @@ static int zipl_print_entry(const char *data, size_t len)
>      return atoi(p);
>  }
>  
> -int menu_get_zipl_boot_index(const char *menu_data)
> +int menu_get_zipl_boot_index(const char *menu_data, const char *menu_data_end)
>  {
>      size_t len;
>      int entry;
> @@ -212,13 +220,18 @@ int menu_get_zipl_boot_index(const char *menu_data)
>          timeout = zipl_timeout * 1000;
>      }
>  
> +    if (menu_data >= menu_data_end) {
> +        return 0;
> +    }
> +
>      /* Print banner */
>      puts("s390-ccw zIPL Boot Menu\n");
> -    menu_data += strlen(menu_data) + 1;
> +    len = strnlen(menu_data, menu_data_end - menu_data);
> +    menu_data += len + 1;

If we've already hit menu_data_end at this point should we bail rather
than skipping the while() loop and immediately proceeding into
menu_get_boot_index(valid_entries); with an all-false array?

AFAICT the current implementation would print no options and wait for
user input.

e.g. something like

    if (menu_data >= menu_data_end)
        return 0;

>  
>      /* Print entries */
> -    while (*menu_data) {
> -        len = strlen(menu_data);
> +    while (menu_data < menu_data_end && *menu_data) {
> +        len = strnlen(menu_data, menu_data_end - menu_data);
>          entry = zipl_print_entry(menu_data, len);
>          menu_data += len + 1;
>  
> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
> index 1e1f71775e..f6030a6071 100644
> --- a/pc-bios/s390-ccw/s390-ccw.h
> +++ b/pc-bios/s390-ccw/s390-ccw.h
> @@ -76,7 +76,7 @@ void jump_to_low_kernel(void);
>  
>  /* menu.c */
>  void menu_set_parms(uint8_t boot_menu_flag, uint32_t boot_menu_timeout);
> -int menu_get_zipl_boot_index(const char *menu_data);
> +int menu_get_zipl_boot_index(const char *menu_data, const char *menu_data_end);
>  bool menu_is_enabled_zipl(void);
>  int menu_get_enum_boot_index(bool *valid_entries);
>  bool menu_is_enabled_enum(void);


