Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A4DCF6497
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 10:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svDrW-0006Zb-3G; Mon, 30 Sep 2024 06:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svDrL-0006WJ-CD
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 06:42:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svDrJ-0006ih-8N
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 06:42:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727692948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=k5282DmQZHIsg1KNLaf1w+oxSx6sktTLxsACdlrPpYw=;
 b=ZRnaLvxGs4NS+rD1DxG7H/4prS1IDfBZF5WQJgiGgLUpE8C84VG4xvBzv3EolB3HsA/n+S
 iI8Q3mcGQsQPYrUyeq0mAzaOMNkEVH7A38KTRgj9xeSSzDKXD8yAs1GnEUassfZ/S9iwOH
 MYUYohZzhtufoxKCILDBaI7hNAEHBwE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-g1w8evDOPCKQixO4HDctnA-1; Mon, 30 Sep 2024 06:42:25 -0400
X-MC-Unique: g1w8evDOPCKQixO4HDctnA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6cb2cd97215so72656776d6.1
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 03:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727692944; x=1728297744;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k5282DmQZHIsg1KNLaf1w+oxSx6sktTLxsACdlrPpYw=;
 b=NF2U2rQDvAEp/83Za0198fu74QPEtftHla75O00+Us6iNtd198rQVk6CY8t2RiCJAV
 K4EUtMpiTQT5jizDhEf+fs+h/0yiJuU/3UugryjKuqaMGRl3dVU1dTuEEEnT5nfQeEDY
 oqYJie7UdLYsjU1ymj3UdVw/pGZVKxiGKZnTLGMQWGUrFFINbgS4bwhrnRW0NQ8hKlZP
 0mBh3O6GxTfHgvmTG2NaeO3JoGxfX2IzO2ydeBd1vWsaLLHM5p2+gFTOV9PSbBm7Pm5o
 iFYLyYV8wKQq7qOo0bty0jKwEeqcu2hAFgy3BvO5XrYKbc6kdZytCv7CIfGboE8cX0wk
 B7Pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMlmZHh9R7aNb0xUuFR03j07VqNeqK/RqpV0EUQbViRS/bUzEqIXBkBq2oDrHtULb3WmBLv0ooF/LG@nongnu.org
X-Gm-Message-State: AOJu0YxOCc3rx8XLlYM4ICJjciwMkpNDZCsNTNtsj/cxxK5IqzYfz662
 jNYsvk4/bBjOdlmu2UMZKibHXWyi7oRO64Nu3XB+j0Pc3oT1NoJzt2tZHA4LOGjlw1hw4/+7SFT
 iUqwUstqOzssySm5kQ3Fbe9//wgm3WifnJlR+XYkj7svftnIq8Pfa8cJfxmXOOJ0=
X-Received: by 2002:a0c:f413:0:b0:6cb:4bcd:d1b with SMTP id
 6a1803df08f44-6cb4bcd11b7mr128844396d6.19.1727692944476; 
 Mon, 30 Sep 2024 03:42:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlhwO9RAaw0zdUz//xdTjNrq+fUOPjaQz6YNK6QK28xwljI+VDK/Vhknsd4tHYOxOCCrmN4w==
X-Received: by 2002:a0c:f413:0:b0:6cb:4bcd:d1b with SMTP id
 6a1803df08f44-6cb4bcd11b7mr128844276d6.19.1727692944193; 
 Mon, 30 Sep 2024 03:42:24 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-48-176.web.vodafone.de.
 [109.42.48.176]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b5ffbbesm38491696d6.25.2024.09.30.03.42.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Sep 2024 03:42:23 -0700 (PDT)
Message-ID: <4578b5e4-13ce-4e1a-9ff5-cd2edcd4f6bb@redhat.com>
Date: Mon, 30 Sep 2024 12:42:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/18] include/hw/s390x: Add include files for common IPL
 structs
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com
References: <20240927005117.1679506-1-jrossi@linux.ibm.com>
 <20240927005117.1679506-14-jrossi@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240927005117.1679506-14-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.095,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 27/09/2024 02.51, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Currently, structures defined in both hw/s390x/ipl.h and pc-bios/s390-ccw/iplb.h
> must be kept in sync, which is prone to error. Instead, create a new directory
> at include/hw/s390x/ipl/ to contain the definitions that must be shared.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> 
> ---
...
> diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
> new file mode 100644
> index 0000000000..d21a8f91e3
> --- /dev/null
> +++ b/include/hw/s390x/ipl/qipl.h
> @@ -0,0 +1,123 @@
> +/*
> + * S/390 boot structures
> + *
> + * Copyright 2024 IBM Corp.
> + * Author(s): Jared Rossi <jrossi@linux.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
> + * your option) any later version. See the COPYING file in the top-level
> + * directory.
> + */
> +
> +#ifndef S390X_QIPL_H
> +#define S390X_QIPL_H
> +
> +/* Boot Menu flags */
> +#define QIPL_FLAG_BM_OPTS_CMD   0x80
> +#define QIPL_FLAG_BM_OPTS_ZIPL  0x40
> +
> +#define QIPL_ADDRESS  0xcc
> +#define LOADPARM_LEN    8
> +
> +/*
> + * The QEMU IPL Parameters will be stored at absolute address
> + * 204 (0xcc) which means it is 32-bit word aligned but not
> + * double-word aligned. Placement of 64-bit data fields in this
> + * area must account for their alignment needs.
> + * The total size of the struct must never exceed 28 bytes.
> + */
> +struct QemuIplParameters {
> +    uint8_t  qipl_flags;
> +    uint8_t  reserved1[3];
> +    uint64_t reserved2;
> +    uint32_t boot_menu_timeout;
> +    uint8_t  reserved3[12];
> +} QEMU_PACKED;
> +typedef struct QemuIplParameters QemuIplParameters;
> +
> +struct IPLBlockPVComp {
> +    uint64_t tweak_pref;
> +    uint64_t addr;
> +    uint64_t size;
> +}  QEMU_PACKED;

Could you please replace the two spaces in front of QEMU_PACKED with just 
one place? (also in the other affected spots in this file)

Apart from that cosmetic nit:
Reviewed-by: Thomas Huth <thuth@redhat.com>


