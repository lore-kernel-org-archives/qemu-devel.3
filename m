Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40512C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 17:35:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wolhZ-0005pF-Jx; Tue, 28 Jul 2026 13:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wolhU-0005op-Uq; Tue, 28 Jul 2026 13:34:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wolhS-0005LE-GD; Tue, 28 Jul 2026 13:34:44 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66SEm1gw1491778; Tue, 28 Jul 2026 17:34:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=gZzk5O
 sTZOG5DO4PMsyX6y90QYNJ5JoV/d23y7TNpqw=; b=nizid2kBjQYTZ8LyK24bJI
 AvY8DBpAYhmBNIZM+juzQQGfbFUCbnLdGwwilfy9Db8eD+1reRAyVtf/UNN8mwI1
 pdmZ9sqy/2DzRSVPeOGqDEutI8iiVRoEa0v8eABPkhH44TFAc4BgK/9THIQUsAbc
 8GGnIx/9+ceEdQqUkmjfpRsh96eAaVGPenPf3R2gdF833weD1BbKcJpNsgoBRT2s
 ISYhTayY+7qQGbtRrGFPuAksuhBgOVVEiph+lMIqt6G1Cwwj5T6gIpHYlJMRoTCS
 tUtJ5VzudFFvg8c0L6IR/cOLDY9nwAB45485Yu1G/bPrL2S5dme3UTBjHG2pIVBQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xpp4m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jul 2026 17:34:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66SHQF33007689;
 Tue, 28 Jul 2026 17:34:35 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5y2srm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jul 2026 17:34:35 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66SHYYpU56820018
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Jul 2026 17:34:34 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 243085805A;
 Tue, 28 Jul 2026 17:34:34 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1E92558052;
 Tue, 28 Jul 2026 17:34:33 +0000 (GMT)
Received: from [9.61.157.32] (unknown [9.61.157.32])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 Jul 2026 17:34:33 +0000 (GMT)
Message-ID: <40e02089-c223-4d59-a4c6-1ac1fc31a7e2@linux.ibm.com>
Date: Tue, 28 Jul 2026 13:34:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] pc-bios/s390-ccw: bound zipl menu strlen and
 replace VLA in zipl_print_entry
To: Joshua Daley <jdaley@linux.ibm.com>, farman@linux.ibm.com
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 brueckner@linux.ibm.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, jjherne@linux.ibm.com,
 jrossi@linux.ibm.com, zycai@linux.ibm.com
References: <20260728134704.2924005-1-jdaley@linux.ibm.com>
 <20260728134704.2924005-2-jdaley@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260728134704.2924005-2-jdaley@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mwPVMN0O5qkMNGbi6crxgK1j5n0YLKYa
X-Proofpoint-ORIG-GUID: mwPVMN0O5qkMNGbi6crxgK1j5n0YLKYa
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDE1MyBTYWx0ZWRfXwJq/Tc4NBcZZ
 XLtq8CLGS1BjMCSmhqJvDRmtSdYE2K/a+UPIVXT9FhLFlzrATbWRTxvOplXBU1O5ByG5mo2V1CT
 XS3kJe3z2/pQgV8Sn25NT60I2y34kvY=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a68e82c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=JFDnpvIpuvfgIa8d490A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDE1MyBTYWx0ZWRfX+ZsEG0GauqsD
 wfNyGQ8SVGx6Hraus3KLKuevpeOZEhBq+tDv2eT4XLZoX9R/f6Fax1msObG7Yg6iu9EelxbhalD
 hQfaGevNXEhhRt3GedRBOhZntlrZmWavFOMJ/X3X6SPmqgmiRAzkOETyWIII0r9zMk/MRccyS31
 2+EF1anW9y8bSWbBMLGegy5BPu0fk6dkEpb5MYXp9kLvxX4p+zOFtN4icUxUc4syFRo2xTxQfPD
 Wt8R+/auJIef6aUVW6U81zvddBfr1re+LeMiUCsWw/ybuNRNfYXlhPjn1XNJ3fS8HB1Im78Oxeo
 Y9yWtLi7ACqGszMZ5VZrPL2XnpWJUZdyf2WLky+yWpaydEO8tFjMgky+Ld8jfQOFzXo36qer/Xv
 6NlgK/oiBAgyW2PMrWQPWF0MjbHhGUMq3fno8x3akX/GuTciU4CH6bs90Cyj/PCOhWWxfsC8B9w
 R9F+8PdppV75sPBk4YA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280153
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

On 7/28/26 9:47 AM, Joshua Daley wrote:
> menu_get_zipl_boot_index() calls strlen() on a pointer into the middle
> of _s2 with no upper bound, so a stage-2 image whose blocks contain no
> NUL bytes causes strlen() to walk beyond _s2. The resulting length
> is then used to size a stack VLA in zipl_print_entry(), risking a stack
> overflow.
> 
> Fix by:
> 
> - Implementing strnlen(), a bounded version of strlen().

Thanks Josh!  One other minor comment...

Nit: it might be worth clarifying why we must implement our own
strnlen() where we were previously using strlen() without any custom
implementation.
Something like: 's390-ccw uses libc from SLOF, which includes strlen()
but does not have an implementation of strnlen(), so we must implement
our own.'

Either way:

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

> 
> - Adding a menu_data_end parameter to menu_get_zipl_boot_index() and
>   replacing both strlen() calls with strnlen() bounded by the remaining
>   buffer space. The loop guard also checks that the pointer has not
>   reached menu_data_end. The function returns 0 (boot default) if
>   somehow menu_data reaches menu_data_end before printing any entries.
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
>  pc-bios/s390-ccw/menu.c     | 29 +++++++++++++++++++++++------
>  pc-bios/s390-ccw/s390-ccw.h |  2 +-
>  4 files changed, 37 insertions(+), 8 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
> index 420ee32eff..662265171b 100644
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
> index b6a9a56d46..9b81154b0e 100644
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
> @@ -212,13 +220,22 @@ int menu_get_zipl_boot_index(const char *menu_data)
>          timeout = zipl_timeout * 1000;
>      }
>  
> -    /* Print banner */
> +    if (menu_data >= menu_data_end) {
> +        return 0; /* Boot default */
> +    }
> +
> +    /* Skip banner */
> +    len = strnlen(menu_data, menu_data_end - menu_data);
> +    menu_data += len + 1;
> +    if (menu_data >= menu_data_end || !(*menu_data)) {
> +        return 0; /* No entries, boot default */
> +    }
> +
>      puts("s390-ccw zIPL Boot Menu\n");
> -    menu_data += strlen(menu_data) + 1;
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


