Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32CA2D26D7B
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 18:03:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veGpE-0000RX-QH; Fri, 09 Jan 2026 13:03:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1veGp4-0000Ko-M5
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 13:02:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1veGp3-0000vj-6E
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 13:02:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767981772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GcMhztl6QjEuJupM6BXt9AQJ8JKbT54FLZItxuNZhsc=;
 b=UCL3ofcqrtbn9xsWnssQoSmgeO/tDzkWgQ/5huhl2Pcuv9XOOgB8eFEcIAjH41Aoc83jV6
 m9tVXqjVAScH+Q8d+jtTF70c90XxPXdya23d84msdt09M1RJWoyFJY1jxESbqpSJpm0YhG
 0X28uD5y4P1s8/zVWoAqvkerJ4g9EVU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-SMCEkqdLOPCPV5Nhnc1-pw-1; Fri, 09 Jan 2026 13:02:49 -0500
X-MC-Unique: SMCEkqdLOPCPV5Nhnc1-pw-1
X-Mimecast-MFC-AGG-ID: SMCEkqdLOPCPV5Nhnc1-pw_1767981768
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b763b24f223so652130766b.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 10:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767981768; x=1768586568; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=GcMhztl6QjEuJupM6BXt9AQJ8JKbT54FLZItxuNZhsc=;
 b=SFhcz96rIV4mgfaJYQjCvK9ajsMo18RkSSmqz2frnQiCdH9tFp02FhYdFE6DHFfjVW
 v1yLOWb3rmuoFNBH/lexFJHTayS/hHDjsiA0c3qcRca3TTm67KHsnACZ/NAMWyY25+BS
 yT0rqLi97hUcpzKs3n+f74TRg04t5t6Wy9rblYhngjlzlvEg6dKAQPcok7MW+9mh2/o8
 NUgjPR3+o3wCbr1GXp0A2skuitzNjsLqdeOVuQ9OFX6bq7KT8FCLqnmVRyA/fUaTE+4q
 iagUHxt7hEFoucAbUZpnadvanBt/uv3yG1sSih93Uz32ZhmX0LBZK3j1whHWkQxwbYnM
 9a+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767981768; x=1768586568;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GcMhztl6QjEuJupM6BXt9AQJ8JKbT54FLZItxuNZhsc=;
 b=kQVIB8cJWAOW1LrG8r0OX2UAfhqr2El+fmh7buc78YHbazxZi/DcLSA6Te4ylmhBoa
 Cax0JTLzeimD0T/s2JrJebSZG6bUGRyUlCbR4Wm/GNU6grM2d/EtzqvxfAv4SgFKTx04
 WIOLKGtS1k2attVEzm0t23EFUSi80F5wfcQ9DMFPavb/Q4bT9kHKV9cPSejjf2pbJYnF
 ktmqQgU0cgJUEpIT/1kREwEhjNDDZ6CxkI5oDc+730ltarjj9hk7hd+4CIOgRqYhdOZ1
 sxxvF7UNHbgsd8hRqFXJukG2z6C1AzWgOfkrQo0/eSjJMtim9YoD8YYqktS+pDJLr3D0
 Z8lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOhKO81gkm8EfXFVXyKF/3ckW/TZ3cZaAcRp1fHfs8DkRDUEWf2MYN1QwNJH62lVFS+FzDzuph/wV6@nongnu.org
X-Gm-Message-State: AOJu0YyI6LnD0WIJKMlxIp5yWb+c9RSv251FGpZvbt1ymgqz4HJ3vQVO
 1tyXSULfdQUm0Zp1LQhcLxlLbP5EBPIGzc1LfjYHb/A4A99Eq3AgsSfq1lfeemDjYJNKs+67rIC
 49ScvVssQds4cReNv+QQ6Zm516yLv6RY88MyuE2TQ5oTa6WSM1ja48uB/
X-Gm-Gg: AY/fxX6wHXqtjhInzy0H5EQVWQbxD22ZrG2Egg7ungUUGk+Ah2aIIllzdUUWcYvwmbi
 BkjL+aKy3lLP4YNHVFq9Z6UCLnZHwdR4ODwaW1QW3WRLe1QUX0qI3Jt/jQ2mnBzW/YnonDfPIo7
 Hx3K4ckUgSg6c2wNi6xntJallmreOBgs8r5ISLFgeeol4Khjl6D3eccrJQQTziXOXX4HuasK+uY
 0NFmQkwoVrEYzq9WfzUMYcVSFWmBdjxG1G0oUARVL3PIzgaNqjsungX4jIBDjnQF9+cMdGJ4V6Q
 udKLuQm28HyHOpPYNPqnWzKLG1j+/Zyvv9PJL8TBpluzpcfTqZEbOe1L/S1SvHqpFHzntKJjrs6
 qL8xGvAo=
X-Received: by 2002:a17:907:3e83:b0:b7a:32:3d60 with SMTP id
 a640c23a62f3a-b844518a88dmr1065704366b.11.1767981767766; 
 Fri, 09 Jan 2026 10:02:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8fNSTitbSQpSKsrtDJhnj2iO6ZfujwO/LkoATDIA1LRcJUenS6Rq8KpmyO6qP5HQqyYlAuw==
X-Received: by 2002:a17:907:3e83:b0:b7a:32:3d60 with SMTP id
 a640c23a62f3a-b844518a88dmr1065700966b.11.1767981767287; 
 Fri, 09 Jan 2026 10:02:47 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a511551sm1158914466b.53.2026.01.09.10.02.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 10:02:46 -0800 (PST)
Message-ID: <9d99ee80-8652-4164-819c-add79309c7f1@redhat.com>
Date: Fri, 9 Jan 2026 19:02:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 14/29] pc-bios/s390-ccw: Define memory for IPLB and
 convert IPLB to pointers
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20251208213247.702569-1-zycai@linux.ibm.com>
 <20251208213247.702569-15-zycai@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251208213247.702569-15-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 08/12/2025 22.32, Zhuoying Cai wrote:
> Define a memory space for both IPL Parameter Block (IPLB) and
> IPL Information Report Block (IIRB) since IIRB is stored immediately
> following IPLB.
> 
> Convert IPLB to pointer and it points to the start of the defined memory space.
> IIRB points to the end of IPLB.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/iplb.h     | 13 +++++++++++--
>   pc-bios/s390-ccw/jump2ipl.c |  6 +++---
>   pc-bios/s390-ccw/main.c     | 34 +++++++++++++++++++---------------
>   pc-bios/s390-ccw/netmain.c  |  8 ++++----
>   4 files changed, 37 insertions(+), 24 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
> index cc3ecc69e5..a0f58d125c 100644
> --- a/pc-bios/s390-ccw/iplb.h
> +++ b/pc-bios/s390-ccw/iplb.h
> @@ -20,7 +20,7 @@
>   #include <string.h>
>   
>   extern QemuIplParameters qipl;
> -extern IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
> +extern IplParameterBlock *iplb;
>   extern bool have_iplb;
>   
>   struct IplInfoReportBlockHeader {
> @@ -85,6 +85,15 @@ struct IplInfoReportBlock {
>   };
>   typedef struct IplInfoReportBlock IplInfoReportBlock;
>   
> +struct IplBlocks {
> +    IplParameterBlock   iplb;
> +    IplInfoReportBlock  iirb;
> +};
> +typedef struct IplBlocks IplBlocks;
> +
> +/* extern only allowed in header file */
> +extern IplBlocks ipl_data __attribute__((__aligned__(PAGE_SIZE)));

Not sure ... does that __attribute__ have any effects for "extern" declarations?

> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index 76bf743900..c9328f1c51 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -22,7 +22,9 @@
>   static SubChannelId blk_schid = { .one = 1 };
>   static char loadparm_str[LOADPARM_LEN + 1];
>   QemuIplParameters qipl;
> -IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
> +/* Ensure that IPLB and IIRB are page aligned and sequential in memory */
> +IplBlocks ipl_data;

I think you definitely want to have an 
__attribute__((__aligned__(PAGE_SIZE))) after the ipl_data declaration here!

  Thomas


