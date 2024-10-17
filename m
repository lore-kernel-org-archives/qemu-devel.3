Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F61CD2F7FC
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 08:02:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1LS7-0007sy-T5; Thu, 17 Oct 2024 04:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t1LS0-0007s8-KL
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 04:01:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t1LRy-0001M2-RH
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 04:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729152097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dDJyp1IvDlZlZEdVws1ZMa8D1PYW6JFKRrmRUlMiQQc=;
 b=aoV1DVgm73VVUrmBfjNLQOPUgFsx97EmwhbB5eReUI6+EiA6G6QZWgurJ/GLeU8k8epXEt
 QHqbu5iewLVN89J+Vf2TcYrTP2whCyrKh/MmgXT0mKo1vVqAApKc1nReWiyni2TBQzriBg
 ltTj3PFE3fMvzebFeLHgnm7Z0dPyLLQ=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-m11Fv0aePLGoUS-YbrYS7w-1; Thu, 17 Oct 2024 04:01:33 -0400
X-MC-Unique: m11Fv0aePLGoUS-YbrYS7w-1
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-50d32dc6574so242735e0c.3
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 01:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729152092; x=1729756892;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dDJyp1IvDlZlZEdVws1ZMa8D1PYW6JFKRrmRUlMiQQc=;
 b=ts1Bmq4Xty+p1zQKsTwM+KjDC8ZXqfYIpS+Ucby86c2C+GcGyfcVCFbxtNU9N+9YUz
 zI5yyi5uDrjI6IJhAs/yzFmB733TGIT9JOGrF+9Z1bZSAGVbacn/ADK5h+q+M8L9cjyZ
 ZcDTEpvWz18fuGU+7hYdDyRBOAnsuXPPnsUZbV3zJ153b78FfdUKNF90VuWd8D3M48u2
 hyuC/qOcVEH0HUDd7jgDbgj5eVUz/pjhZBqZqYkKwUUNuFqPlXApz36S15R8lhnwg+zk
 eYI+ymXMUbNh/wTqxmyqp1yrhfDROKGKGPGuX6Tz3lys0j8jt7iUyjEuSQ5PptZZzErl
 flAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKnJB/6YUFE8l84oiogznfNI2Gpld9rEWObWgxOKtgJb5EE8tZjySzd9fRTplv1cT94ghJYjJxtdmU@nongnu.org
X-Gm-Message-State: AOJu0YzJoZ6KxnPbBCALOifIITL+fmGpi64Nm7JbP1AUhnCZsAB3GeRI
 B5/ReXYjV1EAnz2e7nPl5R4W/Q16Zo4Fyl5WHN2Ylm5EvPD1uVqTOpHMLoCn/OcA5mVmIz3cDJl
 HTc8mpYmq5+PZWt1zHBNrfFnkcRVSRIm2tjSF5p9Y5E3LusK6d/E3Ms1oX6XjfPM=
X-Received: by 2002:a05:6122:3d15:b0:50d:160e:de73 with SMTP id
 71dfb90a1353d-50d376bb557mr10406715e0c.6.1729152092487; 
 Thu, 17 Oct 2024 01:01:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/Dp/JtiH79D9deFVwCKeNM1uRsGuxT6m3IEiymOyMwMYuYqhCSwJPkyYI4eYQOrT2oYu9tQ==
X-Received: by 2002:a05:6122:3d15:b0:50d:160e:de73 with SMTP id
 71dfb90a1353d-50d376bb557mr10406695e0c.6.1729152092022; 
 Thu, 17 Oct 2024 01:01:32 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-50-24.web.vodafone.de. [109.42.50.24])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b1418e4725sm212754985a.125.2024.10.17.01.01.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2024 01:01:31 -0700 (PDT)
Message-ID: <d7c663e5-e18b-4fce-a0eb-b6e10229bf45@redhat.com>
Date: Thu, 17 Oct 2024 10:01:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/19] pc-bios/s390-ccw: Remove panics from ECKD IPL
 path
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com
References: <20241017014748.829029-1-jrossi@linux.ibm.com>
 <20241017014748.829029-9-jrossi@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241017014748.829029-9-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.038,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 17/10/2024 03.47, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Remove panic-on-error from ECKD block device IPL specific functions so that
> error recovery may be possible in the future.
> 
> Functions that would previously panic now provide a return code.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/bootmap.h |   1 +
>   pc-bios/s390-ccw/bootmap.c | 193 +++++++++++++++++++++++++------------
>   2 files changed, 135 insertions(+), 59 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
> index 09f4e6fb40..271dbabbc3 100644
> --- a/pc-bios/s390-ccw/bootmap.h
> +++ b/pc-bios/s390-ccw/bootmap.h
> @@ -16,6 +16,7 @@
>   
>   typedef uint64_t block_number_t;
>   #define NULL_BLOCK_NR 0xffffffffffffffffULL
> +#define ERROR_BLOCK_NR 0xfffffffffffffffeULL
>   
>   #define FREE_SPACE_FILLER '\xAA'
>   
> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
> index 5477cfe228..dd04bb3384 100644
> --- a/pc-bios/s390-ccw/bootmap.c
> +++ b/pc-bios/s390-ccw/bootmap.c
> @@ -145,14 +145,17 @@ static block_number_t load_eckd_segments(block_number_t blk, bool ldipl,
>       bool more_data;
>   
>       memset(_bprs, FREE_SPACE_FILLER, sizeof(_bprs));
> -    read_block(blk, bprs, "BPRS read failed");
> +    if (virtio_read(blk, bprs)) {
> +        puts("BPRS read failed");
> +        return ERROR_BLOCK_NR;
> +    }
>   
>       do {
>           more_data = false;
>           for (j = 0;; j++) {
>               block_nr = gen_eckd_block_num(&bprs[j].xeckd, ldipl);
>               if (is_null_block_number(block_nr)) { /* end of chunk */
> -                break;
> +                return NULL_BLOCK_NR;
>               }
>   
>               /* we need the updated blockno for the next indirect entry
> @@ -163,15 +166,20 @@ static block_number_t load_eckd_segments(block_number_t blk, bool ldipl,
>               }
>   
>               /* List directed pointer does not store block size */
> -            IPL_assert(ldipl || block_size_ok(bprs[j].xeckd.bptr.size),
> -                       "bad chunk block size");
> +            if (!ldipl && !block_size_ok(bprs[j].xeckd.bptr.size)) {
> +                puts("Bad chunk block size");
> +                return NULL_BLOCK_NR;

Shouldn't that be a "return ERROR_BLOCK_NR" instead?

> +            }
>   
>               if (!eckd_valid_address(&bprs[j].xeckd, ldipl)) {
>                   /*
>                    * If an invalid address is found during LD-IPL then break and
> -                 * retry as CCW
> +                 * retry as CCW-IPL, otherwise abort on error
>                    */
> -                IPL_assert(ldipl, "bad chunk ECKD addr");
> +                if (!ldipl) {
> +                    puts("Bad chunk ECKD address");
> +                    return ERROR_BLOCK_NR;
> +                }
>                   break;
>               }
>   
> @@ -189,7 +197,10 @@ static block_number_t load_eckd_segments(block_number_t blk, bool ldipl,
>                    * I.e. the next ptr must point to the unused memory area
>                    */
>                   memset(_bprs, FREE_SPACE_FILLER, sizeof(_bprs));
> -                read_block(block_nr, bprs, "BPRS continuation read failed");
> +                if (virtio_read(block_nr, bprs)) {
> +                    puts("BPRS continuation read failed");
> +                    return ERROR_BLOCK_NR;
> +                }
>                   more_data = true;
>                   break;
>               }
> @@ -198,7 +209,10 @@ static block_number_t load_eckd_segments(block_number_t blk, bool ldipl,
>                * to memory (address).
>                */
>               rc = virtio_read_many(block_nr, (void *)(*address), count + 1);
> -            IPL_assert(rc == 0, "code chunk read failed");
> +            if (rc != 0) {
> +                puts("Code chunk read failed");
> +                return ERROR_BLOCK_NR;
> +            }
>   
>               *address += (count + 1) * virtio_get_block_size();
>           }
> @@ -232,7 +246,10 @@ static int eckd_get_boot_menu_index(block_number_t s1b_block_nr)
>   
>       /* Get Stage1b data */
>       memset(sec, FREE_SPACE_FILLER, sizeof(sec));
> -    read_block(s1b_block_nr, s1b, "Cannot read stage1b boot loader");
> +    if (virtio_read(s1b_block_nr, s1b)) {
> +        puts("Cannot read stage1b boot loader");
> +        return -EIO;
> +    }
>   
>       memset(_s2, FREE_SPACE_FILLER, sizeof(_s2));
>   
> @@ -244,7 +261,10 @@ static int eckd_get_boot_menu_index(block_number_t s1b_block_nr)
>               break;
>           }
>   
> -        read_block(cur_block_nr, s2_cur_blk, "Cannot read stage2 boot loader");
> +        if (virtio_read(cur_block_nr, s2_cur_blk)) {
> +            puts("Cannot read stage2 boot loader");
> +            return -EIO;
> +        }
>   
>           if (find_zipl_boot_menu_banner(&banner_offset)) {
>               /*
> @@ -252,8 +272,10 @@ static int eckd_get_boot_menu_index(block_number_t s1b_block_nr)
>                * possibility of menu data spanning multiple blocks.
>                */
>               if (prev_block_nr) {
> -                read_block(prev_block_nr, s2_prev_blk,
> -                           "Cannot read stage2 boot loader");
> +                if (virtio_read(prev_block_nr, s2_prev_blk)) {
> +                    puts("Cannot read stage2 boot loader");
> +                    return -EIO;
> +                }
>               }
>   
>               if (i + 1 < STAGE2_BLK_CNT_MAX) {
> @@ -261,8 +283,10 @@ static int eckd_get_boot_menu_index(block_number_t s1b_block_nr)
>               }
>   
>               if (next_block_nr && !is_null_block_number(next_block_nr)) {
> -                read_block(next_block_nr, s2_next_blk,
> -                           "Cannot read stage2 boot loader");
> +                if (virtio_read(next_block_nr, s2_next_blk)) {
> +                    puts("Cannot read stage2 boot loader");
> +                    return -EIO;
> +                }
>               }
>   
>               return menu_get_zipl_boot_index(s2_cur_blk + banner_offset);
> @@ -275,7 +299,7 @@ static int eckd_get_boot_menu_index(block_number_t s1b_block_nr)
>       return 0;
>   }
>   
> -static void run_eckd_boot_script(block_number_t bmt_block_nr,
> +static int run_eckd_boot_script(block_number_t bmt_block_nr,
>                                    block_number_t s1b_block_nr)
>   {
>       int i;
> @@ -292,17 +316,28 @@ static void run_eckd_boot_script(block_number_t bmt_block_nr,
>       }
>   
>       debug_print_int("loadparm", loadparm);
> -    IPL_assert(loadparm < MAX_BOOT_ENTRIES, "loadparm value greater than"
> -               " maximum number of boot entries allowed");
> +    if (loadparm >= MAX_BOOT_ENTRIES) {
> +        puts("loadparm value greater than max number of boot entries allowed");
> +        return -EINVAL;
> +    }
>   
>       memset(sec, FREE_SPACE_FILLER, sizeof(sec));
> -    read_block(bmt_block_nr, sec, "Cannot read Boot Map Table");
> +    if (virtio_read(bmt_block_nr, sec)) {
> +        puts("Cannot read Boot Map Table");
> +        return -EIO;
> +    }
>   
>       block_nr = gen_eckd_block_num(&bmt->entry[loadparm].xeckd, ldipl);
> -    IPL_assert(block_nr != -1, "Cannot find Boot Map Table Entry");
> +    if (block_nr == NULL_BLOCK_NR) {
> +        puts("Cannot find Boot Map Table Entry");
> +        return -EIO;
> +    }
>   
>       memset(sec, FREE_SPACE_FILLER, sizeof(sec));
> -    read_block(block_nr, sec, "Cannot read Boot Map Script");
> +    if (virtio_read(block_nr, sec)) {
> +        puts("Cannot read Boot Map Script");
> +        return -EIO;
> +    }
>   
>       for (i = 0; bms->entry[i].type == BOOT_SCRIPT_LOAD ||
>                   bms->entry[i].type == BOOT_SCRIPT_SIGNATURE; i++) {
> @@ -317,21 +352,28 @@ static void run_eckd_boot_script(block_number_t bmt_block_nr,
>   
>           do {
>               block_nr = load_eckd_segments(block_nr, ldipl, &address);
> -        } while (block_nr != -1);
> +        } while (block_nr != ERROR_BLOCK_NR && block_nr != NULL_BLOCK_NR);
> +
> +        if (block_nr == ERROR_BLOCK_NR) {
> +            return ldipl ? 0 : -EIO;
> +        }

Mostly a matter of style, but if you move the if-statement into the while 
loop, you don't have to check for ERROR_BLOCK_NR in the while condition again.

>       }
>   
>       if (ldipl && bms->entry[i].type != BOOT_SCRIPT_EXEC) {
>           /* Abort LD-IPL and retry as CCW-IPL */
> -        return;
> +        return 0;
>       }
>   
> -    IPL_assert(bms->entry[i].type == BOOT_SCRIPT_EXEC,
> -               "Unknown script entry type");
> +    if (bms->entry[i].type != BOOT_SCRIPT_EXEC) {
> +        puts("Unknown script entry type");
> +        return -EINVAL;
> +    }
>       write_reset_psw(bms->entry[i].address.load_address); /* no return */
>       jump_to_IPL_code(0); /* no return */
> +    return 1;
>   }
...
> @@ -787,12 +859,15 @@ static void load_iso_bc_entry(IsoBcSection *load)
>       uint32_t blks_to_load = bswap16(s.sector_count) >> ET_SECTOR_SHIFT;
>       long real_size = iso_get_file_size(bswap32(s.load_rba));
>   
> -    if (real_size) {
> +    if (real_size > 0) {
>           /* Round up blocks to load */
>           blks_to_load = (real_size + ISO_SECTOR_SIZE - 1) / ISO_SECTOR_SIZE;
>           puts("ISO boot image size verified");
>       } else {
>           puts("ISO boot image size could not be verified");
> +        if (real_size < 0) {
> +            return;
> +        }
>       }

Ah, here's the fix for the problem that I complained about in the previous 
patch :-) ... looks like you've squashed it into the wrong patch.

  Thomas



