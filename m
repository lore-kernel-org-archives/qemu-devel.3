Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08BF3D2F7F7
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 07:39:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1L5X-0001sj-Ip; Thu, 17 Oct 2024 03:38:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t1L5W-0001sS-KG
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 03:38:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t1L5V-0000Eo-17
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 03:38:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729150704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TTGyRuqqhJp1uWWtgRzw4hlhV09tsV8Pn+t4RTc9FYU=;
 b=MUM2erf1tULWBoA8WOD3bs/vHAVotY1DvZ6/HN4mwHlWVZCQs0mzdre2d41vBrWywrIdE0
 6t4iQ7hyxhEQu+o73pUtmJhc97KfYH7QbrHpjKz7JENs7dEcBnKw8oPj74iP1YF3msj+y9
 O4ocOCxpSB94bqqzqL06vGG35KtAXMQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-8c9YOz2dNBSx6bRy_bwPEQ-1; Thu, 17 Oct 2024 03:38:20 -0400
X-MC-Unique: 8c9YOz2dNBSx6bRy_bwPEQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43157cff1d1so4822455e9.2
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 00:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729150699; x=1729755499;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TTGyRuqqhJp1uWWtgRzw4hlhV09tsV8Pn+t4RTc9FYU=;
 b=JbcS2OTMJMpB54WKC3p5vBUGPBlUMaSIjcauru2wPbrpol/nBsphbjGzUI7zkpntkW
 hvDromighEzfhidzfupjuO5q+9sqctXWDQtJw9sO9WNGBDH70WS56RGx/kbq2B6WGIVy
 OIpsvrlalO/AgcGwn89BP68HkavJMAebVffoE56TVP0sfqVJK6XIZWo+QoAxF+Sx4ZkI
 DHj6hf8f1CjTZDJgp6tDSmEOdJJu6xIsCXog++QC4bZyxj7kHBwqIUNYARxF84+o7tzN
 7ARrRC0C/U7t70HIRjo2brHIWTZRAoSzdz+OkJTAr9UFpSVkzk6J3xMzkU/JtPaw9KNU
 u9MA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVVNZxgjYO4zLRcPhSAkrlVTOeHaS2RmenQMQ1kwXSO2dEssARLtD66zjVimY886AoyVPsv0+iYLeV@nongnu.org
X-Gm-Message-State: AOJu0YwNUNgyk7tLWptQxq2zPp244AvluPM/rzWofIbs8qio3oP8CS38
 v7MDM7L6XchKawaOMhRY7y92gG8vzMyBEHWgSggiGU7Kb4pxCUZAWwK1qdTGxmNAUIXQ1RsXs+k
 djtdhGx6JMnVAFS1U4pT3BJBmkZKIRWFd05/KNZooPlA1kTP414dM
X-Received: by 2002:a05:600c:3ba9:b0:42c:b52b:4335 with SMTP id
 5b1f17b1804b1-4311decaa31mr185037325e9.10.1729150699114; 
 Thu, 17 Oct 2024 00:38:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBGLuQxyLz7LAGVkx0PtyCNdSFiVAYp8/rGjaHQjNSGw4jtJec6mmxO8+z28k1hAVaEolhPQ==
X-Received: by 2002:a05:600c:3ba9:b0:42c:b52b:4335 with SMTP id
 5b1f17b1804b1-4311decaa31mr185037125e9.10.1729150698669; 
 Thu, 17 Oct 2024 00:38:18 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-50-24.web.vodafone.de. [109.42.50.24])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43158c40378sm17032385e9.23.2024.10.17.00.38.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2024 00:38:18 -0700 (PDT)
Message-ID: <88f084e2-4d3b-4ba7-a921-5ee8a9c143e7@redhat.com>
Date: Thu, 17 Oct 2024 09:38:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/19] pc-bios/s390-ccw: Remove panics from ISO IPL path
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com
References: <20241017014748.829029-1-jrossi@linux.ibm.com>
 <20241017014748.829029-8-jrossi@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241017014748.829029-8-jrossi@linux.ibm.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> Remove panic-on-error from IPL ISO El Torito specific functions so that error
> recovery may be possible in the future.
> 
> Functions that would previously panic now provide a return code.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
...
> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
> index 414c3f1b47..5477cfe228 100644
> --- a/pc-bios/s390-ccw/bootmap.c
> +++ b/pc-bios/s390-ccw/bootmap.c
> @@ -678,8 +678,10 @@ static bool is_iso_bc_entry_compatible(IsoBcSection *s)
>       if (s->unused || !s->sector_count) {
>           return false;
>       }
> -    read_iso_sector(bswap32(s->load_rba), magic_sec,
> -                    "Failed to read image sector 0");
> +    if (virtio_read(bswap32(s->load_rba), magic_sec)) {
> +        puts("Failed to read image sector 0");
> +        return false;
> +    }
>   
>       /* Checking bytes 8 - 32 for S390 Linux magic */
>       return !memcmp(magic_sec + 8, linux_s390_magic, 24);
> @@ -692,28 +694,35 @@ static uint32_t sec_offset[ISO9660_MAX_DIR_DEPTH];
>   /* Remained directory space in bytes */
>   static uint32_t dir_rem[ISO9660_MAX_DIR_DEPTH];
>   
> -static inline uint32_t iso_get_file_size(uint32_t load_rba)
> +static inline long iso_get_file_size(uint32_t load_rba)
>   {
>       IsoVolDesc *vd = (IsoVolDesc *)sec;
>       IsoDirHdr *cur_record = &vd->vd.primary.rootdir;
>       uint8_t *temp = sec + ISO_SECTOR_SIZE;
>       int level = 0;
>   
> -    read_iso_sector(ISO_PRIMARY_VD_SECTOR, sec,
> -                    "Failed to read ISO primary descriptor");
> +    if (virtio_read(ISO_PRIMARY_VD_SECTOR, sec)) {
> +        puts("Failed to read ISO primary descriptor");
> +        return -EIO;
> +    }
> +
>       sec_loc[0] = iso_733_to_u32(cur_record->ext_loc);
>       dir_rem[0] = 0;
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
>               if (dir_rem[level] == 0) {
>                   /* Skip self and parent records */
>                   dir_rem[level] = iso_733_to_u32(cur_record->data_len) -
> @@ -758,8 +767,10 @@ static inline uint32_t iso_get_file_size(uint32_t load_rba)
>           if (dir_rem[level] == 0) {
>               /* Nothing remaining */
>               level--;
> -            read_iso_sector(sec_loc[level], temp,
> -                            "Failed to read ISO directory");
> +            if (virtio_read(sec_loc[level], temp)) {
> +                puts("Failed to read ISO directory");
> +                return -EIO;
> +            }
>           }
>       }
>   
> @@ -774,7 +785,7 @@ static void load_iso_bc_entry(IsoBcSection *load)
>        * is padded and ISO_SECTOR_SIZE bytes aligned
>        */
>       uint32_t blks_to_load = bswap16(s.sector_count) >> ET_SECTOR_SHIFT;
> -    uint32_t real_size = iso_get_file_size(bswap32(s.load_rba));
> +    long real_size = iso_get_file_size(bswap32(s.load_rba));
>   
>       if (real_size) {
>           /* Round up blocks to load */

I think this check should now be changed to "real_size > 0" ?
And in the "else" path, the function should return immediately?

  Thomas


