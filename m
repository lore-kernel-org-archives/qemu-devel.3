Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35720CF044D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 10:54:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syUJq-0003Se-Lg; Wed, 09 Oct 2024 06:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1syUJm-0003SH-Iy
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 06:53:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1syUJk-0008H2-Nb
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 06:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728471198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hj1bAUX+Dt1gjIlANvVyeEk5t1THsfxiAen4kNDv5SM=;
 b=W8SHJltXHKvVaFZJYHtC9XcQ1NKC2Jmje4atVmhu7+RYzAszLKz4GduMkHnL4xuTCyoZ9v
 z3rZao8wHr9Uu9PYKLOfCkzzO4Qr8s70dR2ZlGQksiivn76tiMdr+j5gC20dMAHEuxYPDr
 j7W1q960su/+zU0BzRNN1shjJMprZqw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-v7MHuvrjNFql0PRXtVo8EQ-1; Wed, 09 Oct 2024 06:53:16 -0400
X-MC-Unique: v7MHuvrjNFql0PRXtVo8EQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42cb2c5d634so44177675e9.0
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 03:53:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728471195; x=1729075995;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hj1bAUX+Dt1gjIlANvVyeEk5t1THsfxiAen4kNDv5SM=;
 b=W8yuhW5iACJNkZzBHtyKmBwv1VeYC/f1UPrLrz3npgGD91OcA315zUpN5yEqPcHJAz
 6qlwYvgA3hiPOq2AggOapqiKsp5Op+VBERdHsV3MJfnu/8HLKLa0GhxZ0h7PXUpmbalZ
 50kISUPPPvkgp4miflLYd/NLMT6vOEPR8QToEkJIKbBfJ4xit17UOfM6VKead8TUXkgE
 AA0QeUFljss40DLBVaJvIy7KafRanqN+N1xZVadnNEXHXvzoQ2Kc0RR0YvBrYBOBBz5n
 Wj9Y4pNQ/dBFIKjySxndz1pV38I1ZiRjoz8VJ06gRECYMo4pq6Zq63Pi+GBfwLe4i1YI
 EkeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdY2afj0oUEisLo5+PA+pU54vfipwkXO8Tg7GNFJQsvS6MaT2aGN0dE7rQmeotkHt9do3UoG6WAAYC@nongnu.org
X-Gm-Message-State: AOJu0YwCSWqI/HEYn8NCyjw1faxr4Hm/H0O91+E1lHBmJiYvIfE8BYa0
 7NKQTVjh+/nOaK6uJpLZkN9BsAAohxzEDxPL00z2LLZQNEw2hnlKTW/4fevAjCrQmhCusGMD2hw
 Q5fZelxMTXjOI24iK35Yjz6jL4qTQO2V+aoNXHx6MUvplloQAWfwe
X-Received: by 2002:a05:600c:1c14:b0:42f:8fcd:486c with SMTP id
 5b1f17b1804b1-430d70b3f8dmr12903755e9.33.1728471195340; 
 Wed, 09 Oct 2024 03:53:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHw87Xn57J0kxpVrYW+PL1Yn38DjEq2tryQ2Lm8t0/7t/o+2FDarPngibxa4n9c9HHEJadvKQ==
X-Received: by 2002:a05:600c:1c14:b0:42f:8fcd:486c with SMTP id
 5b1f17b1804b1-430d70b3f8dmr12903535e9.33.1728471194740; 
 Wed, 09 Oct 2024 03:53:14 -0700 (PDT)
Received: from [10.33.192.239] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-430ccf5f3dcsm16566335e9.25.2024.10.09.03.53.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2024 03:53:14 -0700 (PDT)
Message-ID: <704bffd2-09b7-4ce0-8fb4-d6f33145bcca@redhat.com>
Date: Wed, 9 Oct 2024 12:53:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/19] pc-bios/s390-ccw: Remove panics from ECKD IPL
 path
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com
References: <20241008011552.2645520-1-jrossi@linux.ibm.com>
 <20241008011552.2645520-9-jrossi@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241008011552.2645520-9-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
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

On 08/10/2024 03.15, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Remove panic-on-error from ECKD block device IPL specific functions so that
> error recovery may be possible in the future.
> 
> Functions that would previously panic now provide a return code.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/s390-ccw.h |   1 +
>   pc-bios/s390-ccw/bootmap.c  | 183 ++++++++++++++++++++++++------------
>   2 files changed, 126 insertions(+), 58 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
> index cbd92f3671..7516e96a14 100644
> --- a/pc-bios/s390-ccw/s390-ccw.h
> +++ b/pc-bios/s390-ccw/s390-ccw.h
> @@ -31,6 +31,7 @@ typedef unsigned long long u64;
>   #define EBUSY   2
>   #define ENODEV  3
>   #define EINVAL  4
> +#define ENOENT  5
>   
>   #ifndef MIN
>   #define MIN(a, b) (((a) < (b)) ? (a) : (b))
> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
> index 7984de62fe..266b38c034 100644
> --- a/pc-bios/s390-ccw/bootmap.c
> +++ b/pc-bios/s390-ccw/bootmap.c
> @@ -145,14 +145,17 @@ static block_number_t load_eckd_segments(block_number_t blk, bool ldipl,
>       bool more_data;
>   
>       memset(_bprs, FREE_SPACE_FILLER, sizeof(_bprs));
> -    read_block(blk, bprs, "BPRS read failed");
> +    if (virtio_read(blk, bprs)) {
> +        puts("BPRS read failed");
> +        return -EIO;
> +    }

load_eckd_segments() returns a value of type block_number_t which is an 
unsigned type, so returning a negative error value will likely not work as 
expected...

...
> @@ -317,21 +352,28 @@ static void run_eckd_boot_script(block_number_t bmt_block_nr,
>   
>           do {
>               block_nr = load_eckd_segments(block_nr, ldipl, &address);
> -        } while (block_nr != -1);
> +        } while (block_nr >= 0);

... for example here: block_nr is also of type block_number_t, so the while 
condition is also true for "negative" error codes.

> +        if (block_nr != -ENOENT && block_nr < 0) {

"block_nr < 0" likely also always evaluates to "false".

> +            return ldipl ? 0 : -EIO;
> +        }
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
> @@ -441,11 +490,14 @@ static block_number_t eckd_find_bmt(ExtEckdBlockPtr *ptr)
>       BootRecord *br;
>   
>       blockno = gen_eckd_block_num(ptr, 0);
> -    read_block(blockno, tmp_sec, "Cannot read boot record");
> +    if (virtio_read(blockno, tmp_sec)) {
> +        puts("Cannot read boot record");
> +        return -EIO;

Same problem here: Returning a negative error code via unsigned 
block_number_t ....

...
> @@ -490,34 +545,46 @@ static void ipl_eckd(void)
>           ldipl_bmt = eckd_find_bmt((ExtEckdBlockPtr *)&vlbl->f.br);
>           if (ldipl_bmt) {

... will cause trouble here.

>               puts("List-Directed");
> -            /* LD-IPL does not use the S1B bock, just make it NULL */
> -            run_eckd_boot_script(ldipl_bmt, NULL_BLOCK_NR);
> -            /* Only return in error, retry as CCW-IPL */
> +            /*
> +             * LD-IPL does not use the S1B bock, just make it NULL_BLOCK_NR.
> +             * In some failure cases retry IPL before aborting.
> +             */
> +            if (run_eckd_boot_script(ldipl_bmt, NULL_BLOCK_NR)) {
> +                return -EIO;
> +            }
> +            /* Non-fatal error, retry as CCW-IPL */
>               printf("Retrying IPL ");
>               print_eckd_msg();
>           }
>           memset(sec, FREE_SPACE_FILLER, sizeof(sec));
> -        read_block(2, vtoc, "Cannot read block 2");
> +        if (virtio_read(2, vtoc)) {
> +            puts("Cannot read block 2");
> +            return -EIO;
> +        }
>       }
>   
>       /* Not list-directed */
>       if (magic_match(vtoc->magic, VOL1_MAGIC)) {
> -        ipl_eckd_cdl(); /* may return in error */
> +        if (ipl_eckd_cdl()) {
> +            return 1;
> +        }
>       }
>   
>       if (magic_match(vtoc->magic, CMS1_MAGIC)) {
> -        ipl_eckd_ldl(ECKD_CMS); /* no return */
> +        return ipl_eckd_ldl(ECKD_CMS);
>       }
>       if (magic_match(vtoc->magic, LNX1_MAGIC)) {
> -        ipl_eckd_ldl(ECKD_LDL); /* no return */
> +        return ipl_eckd_ldl(ECKD_LDL);
>       }
>   
> -    ipl_eckd_ldl(ECKD_LDL_UNLABELED); /* it still may return */
> +    if (ipl_eckd_ldl(ECKD_LDL_UNLABELED)) {
> +        return 1;
> +    }
>       /*
>        * Ok, it is not a LDL by any means.
>        * It still might be a CDL with zero record keys for IPL1 and IPL2
>        */
> -    ipl_eckd_cdl();
> +    return ipl_eckd_cdl();
>   }

  Thomas


