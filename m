Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B917CDD1B8
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 15:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suCUR-0006mV-4L; Fri, 27 Sep 2024 11:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1suCUI-0006ki-Gx
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 11:02:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1suCUF-0001Ko-5o
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 11:02:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727449344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7RCGvf9pH9ZrN4LAWWv5IGLdRW0XBWTvK+D1z93T1MY=;
 b=BB0+mCZLiGHXVc0/sVMoO58Jd66if3ZLPc9ImKfoYA1IiMhpe7FFuzSaVeIbiMUdrLohBI
 VC4WQfAvkC/6jWLCNBbSV3LvdHHTwzSOh+LBe922IXv0F21vdbFHnV3iZ9L8huAZkLA3JU
 B5lWg8YwLrPCCTJIcErjT1ts/G/CBps=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-aSgPj3xiPsiFdfLjQyYpNQ-1; Fri, 27 Sep 2024 11:02:21 -0400
X-MC-Unique: aSgPj3xiPsiFdfLjQyYpNQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42cdeac2da6so18540225e9.2
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2024 08:02:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727449340; x=1728054140;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7RCGvf9pH9ZrN4LAWWv5IGLdRW0XBWTvK+D1z93T1MY=;
 b=AEGNI1VzjTXU7NdXwM3juDmIEScgyzE6nKV1nqce88EVvBbW7eovgS6wWGtoNgGJUQ
 /CnqF7QkGMwqMDZ7YddSCXRYnT7qjW38UIptDwckJwBN13bLfw6PUT/HSuwvxlpN5EA+
 mjAp1/R0MNFRXsBl9PfCLDunb/z5JNQReGCzLCAkqgmafOejkiQygmLxJdA3AQLi20ov
 4iGSTkJFoCK7RThO/lVHDrC9S67/eJg7y7QoM/AUFr7Fc7572nOxDbA4Gh4Jds40DLO5
 z/cfqm1J8fG9KUUhIgv1s5lz96rrhf69iu5mNqncgrvtNWnzyQ3PyZvaTkg3iCr41CLC
 bf6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnJSvF7w5FykRm9LT5ZMBUty+KOR3UE/PEQr8qAQplC/HooEKg4Qp++SM/KkVgE07K17zuqHrRsnp4@nongnu.org
X-Gm-Message-State: AOJu0YxbTmJiqhD3nbCJTIio1m0NfX4pcjC6fwPIkU5zz91srIgNRyVG
 pawid+QzHT4gUl8UgISaJG3tK354adU3psWrnvk70RH7T+zJtq5Ji7LDN2i4N2048i+YVlMf39l
 ZveX7tTNw1WCZv5kwf7EoNpFOexUMLr9RMdaGneMwG54NMJL51UVo
X-Received: by 2002:a05:600c:3b8c:b0:42c:be90:fa1b with SMTP id
 5b1f17b1804b1-42f584335f0mr27161235e9.14.1727449339922; 
 Fri, 27 Sep 2024 08:02:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8YuZo0yo07S3kyfW5nzaJj5UnPR2w0+9ZsqniMIjlrmTLWZelyZb9TmNC7/tfLkq3YLVphQ==
X-Received: by 2002:a05:600c:3b8c:b0:42c:be90:fa1b with SMTP id
 5b1f17b1804b1-42f584335f0mr27160125e9.14.1727449338835; 
 Fri, 27 Sep 2024 08:02:18 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-48-176.web.vodafone.de.
 [109.42.48.176]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd57429fbsm2709513f8f.103.2024.09.27.08.02.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Sep 2024 08:02:18 -0700 (PDT)
Message-ID: <77cad234-524d-4166-ab1b-10666c8c676e@redhat.com>
Date: Fri, 27 Sep 2024 17:02:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/18] pc-bios/s390-ccw: Remove panics from ISO IPL path
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com
References: <20240927005117.1679506-1-jrossi@linux.ibm.com>
 <20240927005117.1679506-8-jrossi@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240927005117.1679506-8-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 27/09/2024 02.51, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Remove panic-on-error from IPL ISO El Torito specific functions so that error
> recovery may be possible in the future.
> 
> Functions that would previously panic now provide a return code.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> 
> ---
>   pc-bios/s390-ccw/bootmap.h  | 17 +++++++---
>   pc-bios/s390-ccw/s390-ccw.h |  1 +
>   pc-bios/s390-ccw/bootmap.c  | 64 ++++++++++++++++++++++++-------------
>   3 files changed, 55 insertions(+), 27 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
> index bbe2c132aa..cb5346829b 100644
> --- a/pc-bios/s390-ccw/bootmap.h
> +++ b/pc-bios/s390-ccw/bootmap.h
> @@ -385,17 +385,24 @@ static inline uint32_t iso_733_to_u32(uint64_t x)
>   
>   #define ISO_PRIMARY_VD_SECTOR 16
>   
> -static inline void read_iso_sector(uint32_t block_offset, void *buf,
> +static inline int read_iso_sector(uint32_t block_offset, void *buf,
>                                      const char *errmsg)
>   {
> -    IPL_assert(virtio_read_many(block_offset, buf, 1) == 0, errmsg);
> +    if (virtio_read(block_offset, buf)) {
> +        puts(errmsg);
> +        return 1;
> +    }
> +    return 0;
>   }
>   
> -static inline void read_iso_boot_image(uint32_t block_offset, void *load_addr,
> +static inline int read_iso_boot_image(uint32_t block_offset, void *load_addr,
>                                          uint32_t blks_to_load)
>   {
> -    IPL_assert(virtio_read_many(block_offset, load_addr, blks_to_load) == 0,
> -               "Failed to read boot image!");
> +    if (!virtio_read_many(block_offset, load_addr, blks_to_load)) {

That "!" looks wrong here? Or do I misunderstood the original IPL_assert() 
condition?

> +        puts("Failed to read boot image!");
> +        return 1;
> +    }
> +    return 0;
>   }
>   
>   #define ISO9660_MAX_DIR_DEPTH 8
> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
> index 0ed7eb8ade..cbd92f3671 100644
> --- a/pc-bios/s390-ccw/s390-ccw.h
> +++ b/pc-bios/s390-ccw/s390-ccw.h
> @@ -30,6 +30,7 @@ typedef unsigned long long u64;
>   #define EIO     1
>   #define EBUSY   2
>   #define ENODEV  3
> +#define EINVAL  4
>   
>   #ifndef MIN
>   #define MIN(a, b) (((a) < (b)) ? (a) : (b))
> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
> index 414c3f1b47..31cf0f6d97 100644
> --- a/pc-bios/s390-ccw/bootmap.c
> +++ b/pc-bios/s390-ccw/bootmap.c
> @@ -678,8 +678,10 @@ static bool is_iso_bc_entry_compatible(IsoBcSection *s)
>       if (s->unused || !s->sector_count) {
>           return false;
>       }
> -    read_iso_sector(bswap32(s->load_rba), magic_sec,
> -                    "Failed to read image sector 0");
> +    if (read_iso_sector(bswap32(s->load_rba), magic_sec,
> +                    "Failed to read image sector 0")) {
> +        return false;
> +    }
>   
>       /* Checking bytes 8 - 32 for S390 Linux magic */
>       return !memcmp(magic_sec + 8, linux_s390_magic, 24);
> @@ -706,14 +708,18 @@ static inline uint32_t iso_get_file_size(uint32_t load_rba)
>       sec_offset[0] = 0;
>   
>       while (level >= 0) {
> -        IPL_assert(sec_offset[level] <= ISO_SECTOR_SIZE,
> -                   "Directory tree structure violation");
> +        if (sec_offset[level] > ISO_SECTOR_SIZE) {
> +            puts("Directory tree structure violation");
> +            return -EIO;
> +        }
>   
>           cur_record = (IsoDirHdr *)(temp + sec_offset[level]);
>   
>           if (sec_offset[level] == 0) {
> -            read_iso_sector(sec_loc[level], temp,
> -                            "Failed to read ISO directory");
> +            if (virtio_read(sec_loc[level], temp)) {
> +                puts("Failed to read ISO directory");
> +                return -EIO;
> +            }

Any reasons for switching from read_iso_sector() directly to virtio_read() here?

Apart from that, patch looks fine for me, thanks for doing this clean-up work!

  Thomas


