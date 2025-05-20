Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 717EDC3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 09:30:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHJIL-0001tp-FI; Tue, 20 May 2025 05:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uHJIJ-0001tV-3Z
 for qemu-devel@nongnu.org; Tue, 20 May 2025 05:29:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uHJIH-0002v9-FN
 for qemu-devel@nongnu.org; Tue, 20 May 2025 05:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747733391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7HBgpfleakRxXaXvCkfft+UiIsLto8wMC5VR5+wNF14=;
 b=TTsVGk1iMkdq2+7qwNQNnv1uvCE16YvzNMFvWGP8l1UhkLMq1UwmGNZfpccXlzMcgvtn2u
 HyfQqOaSaSJYqDK83CDEak9uPBQV1CcCQg2Ygi8oIhvWtQY//LSkpPwheYtOpHIA9OHG4p
 +DkACcm7RzvI7Rp2jytcLi7MAJmwsTg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-nmmxWIv_PbiLjlkHFGmdbQ-1; Tue, 20 May 2025 05:29:50 -0400
X-MC-Unique: nmmxWIv_PbiLjlkHFGmdbQ-1
X-Mimecast-MFC-AGG-ID: nmmxWIv_PbiLjlkHFGmdbQ_1747733389
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-445135eb689so16520915e9.2
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 02:29:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747733389; x=1748338189;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7HBgpfleakRxXaXvCkfft+UiIsLto8wMC5VR5+wNF14=;
 b=QCTeKxirt3ZSHJWeVKIrPToSYXMEdfOfTX7DkiYUBtjnYMRHeuZEupB4HxjTSZlBjl
 0Qu0w6APACq3VJUabu6s5XHJJ2ipnwGtHUYH3qfE+3TNe9L2Ct/hBvC3tMaZNRxcARvr
 jfharHfCYnu8MeOXxLDm8w/td75k+JZ2Hg+WLiuE/JJKxBLAb6YKm/pXkU3YCg5somjs
 JKEhuqBkt6zQ2pfge4FrY96O493tgql3J8tSzZ1uS/17xqdZx7SmD3WP8+Ov5f06cUGO
 jMz/5+S5ZKYCFh7BOFEayngvAA+lSA0mVxkwE/uHkZNz7VTxGEhEJefOHkOgV95a/82j
 6qdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOHC+jpCzEWA5ItvT/5FvB+cA6YVdRlt3esMRNZGKZ3wLsNi5Cgb6BGUhkekUjdWFT1M3Wv+LiQOhh@nongnu.org
X-Gm-Message-State: AOJu0YxVOYqGkyqK/Ff0QpJvEpGo08WTBWInweGrq3UDJMzO+y4zPOHs
 8sMnYGO2RjlaFQQakUxPo86fsTzL78kQsCSdUehGSvLgcVHZqsvUsKzzrPUyAV5GJhhjcfn3SZc
 L675CfMhbLgg9sMzXLdNwjPSGBHZbmVPDXiAAPH7iw5llL2Y6jX+r0Yqc
X-Gm-Gg: ASbGncsVlmjuMuIi7kA+xrmyOn0aCK9vFF7KEI6/nygb+VlgWGUvHVjjjH3psIAFRIV
 BMlN70jrZeL8LJwEm2qG7+t3JFDer5dzHwTKYAfdu90FICYxqT+zXtXrSUymuWOLcb7Y0c1+jnt
 mtoQttKAwlnhdsjPuqP/SfyTrs4RqfwhxoICqTYSkePRkXZEm/Guo8TgQOyCr6SwFZE39WLaE6k
 uRxJvFPMQsn+22sikPWwsR0Lw5xSXOUBZPgRCYPLGOkaMGDwKnGZfIcWeyhjcKrNqxMVsvjZ3FK
 RU/e244knXtYl3mFFd0Gugb/X8bPvmXzaerCd6BxHY8=
X-Received: by 2002:a05:600c:3f06:b0:43b:ca39:6c75 with SMTP id
 5b1f17b1804b1-442fd63c7aemr180170305e9.16.1747733388911; 
 Tue, 20 May 2025 02:29:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLKmMt6bd7CNe8WjrZ/uxFWc91irwIAgge6xf0SU8hw8j+sbiOoz7vMAU0YM+hXLWL7rBe2Q==
X-Received: by 2002:a05:600c:3f06:b0:43b:ca39:6c75 with SMTP id
 5b1f17b1804b1-442fd63c7aemr180170005e9.16.1747733388525; 
 Tue, 20 May 2025 02:29:48 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-201.web.vodafone.de.
 [109.42.49.201]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f1ef0b20sm23994305e9.14.2025.05.20.02.29.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 May 2025 02:29:48 -0700 (PDT)
Message-ID: <9ea13d24-683d-4d44-9482-d1a3b30997c6@redhat.com>
Date: Tue, 20 May 2025 11:29:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/25] pc-bios/s390-ccw: Refactor zipl_run()
To: Zhuoying Cai <zycai@linux.ibm.com>, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250508225042.313672-1-zycai@linux.ibm.com>
 <20250508225042.313672-16-zycai@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250508225042.313672-16-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 09/05/2025 00.50, Zhuoying Cai wrote:
> Refactor to enhance readability before enabling secure IPL in later
> patches.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/bootmap.c | 58 ++++++++++++++++++++++----------------
>   1 file changed, 34 insertions(+), 24 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
> index 0f8baa0198..485b55f1bf 100644
> --- a/pc-bios/s390-ccw/bootmap.c
> +++ b/pc-bios/s390-ccw/bootmap.c
> @@ -674,6 +674,38 @@ static int zipl_load_segment(ComponentEntry *entry)
>       return 0;
>   }
>   
> +static int zipl_run_normal(ComponentEntry *entry, uint8_t *tmp_sec)
> +{
> +    while (entry->component_type == ZIPL_COMP_ENTRY_LOAD ||
> +        entry->component_type == ZIPL_COMP_ENTRY_SIGNATURE) {
> +
> +        /* Secure boot is off, so we skip signature entries */
> +        if (entry->component_type == ZIPL_COMP_ENTRY_SIGNATURE) {
> +            entry++;
> +            continue;
> +        }
> +
> +        if (zipl_load_segment(entry)) {
> +            return -1;
> +        }
> +
> +        entry++;
> +
> +        if ((uint8_t *)(&entry[1]) > (tmp_sec + MAX_SECTOR_SIZE)) {

Should be possible with less parentheses:

         if ((uint8_t *)&entry[1] > tmp_sec + MAX_SECTOR_SIZE) {

  Thomas


