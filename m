Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D7FAC369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 04:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5HKQ-000383-Lm; Thu, 17 Apr 2025 00:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u5HKN-00037I-VL
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 00:58:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u5HKG-0000MP-Pi
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 00:58:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744865891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=SR7r1qklJjnrZXA0Px6mnasPj/bkBUGrQtCyDce8sDg=;
 b=INV4B6fpGl6vxDAmULstUNAJ8yI11mXmBfb+fCVZueUdOjrymafPbSWJMaNM8gHduSC7d9
 JHtaDRK3YzkbUnFPzpO7lFW8lDtAih0R9wZQK4CXg5dGcmolxkV7tZTFz1mYXO6jYhJL7z
 XRTsjSrOiV5AWDWdJxP2OT7HqVboHys=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-DgeqDAxkNg6Up6xqieVrNQ-1; Thu, 17 Apr 2025 00:58:08 -0400
X-MC-Unique: DgeqDAxkNg6Up6xqieVrNQ-1
X-Mimecast-MFC-AGG-ID: DgeqDAxkNg6Up6xqieVrNQ_1744865887
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ac28a2c7c48so26985066b.3
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 21:58:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744865887; x=1745470687;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SR7r1qklJjnrZXA0Px6mnasPj/bkBUGrQtCyDce8sDg=;
 b=WQohdtz4bq6camBtTJlWABQFKXCImIRltT9LG+UBlX2s/nYPm2dV+iP+Iud764Xebr
 RcJPE1+nzBCeHnKkiNC5X18JNXTgsJhJyZVo4Bl2Y1Wb8GJvg2dquSNO+IGauTDmeiMn
 /Gu2hWNDnUEFyr5vpbfBhmIN6sFTm5aHxQQ/vPO8pJFO4yav4giWAZE/oKmFdfV6f7fx
 jwzuD/3qai7CfTHnhXChpa2yTxzJT7O4X7X/LlWN0b/ykFoAszFuQJZLhU7ZR0AkdVVm
 nE2Fn2g5t5CVk3mh79Ith5/9RdfxgtdyQbyiO6wD+cHOarpkqJKGxmF2B3wDXfksvCIe
 c/Qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUvmh+oJXYA9+6++yJGBJd7vcK+Pqcm0B6ZsA7SycU1Y8D/K7fB9PuYMu29nzKib4FONoM2pwywsYb@nongnu.org
X-Gm-Message-State: AOJu0YwfD9QAfoHLcTUgxtk38qcg99P9SeL8DqFGwby4ttzey8vUQM1R
 ZS4D69rGm3pfLW+uuVYJKo2JIqFEBHQjlyO8/33xGrEGBRyrM0yTi6Rg5/p0Ze9Sw+d6TwmCuVQ
 SQgxbiWSQMtvABQxN3WUCl8knIrZBvJCQdD8Gdp6UCD6z7xsmDwjk
X-Gm-Gg: ASbGncte7DtG7zYF/SK5MKcNI93wPMyjxRbpVYFPfFwDSZzUo32/Cm69SNKAyVl8/JK
 wh+2nUEjT/FH4qyIuvKNj0JhOLZdx0GrnnRq3/uIaprGLvyPNLmMHHtwh8MNxHJcJnqpYic1Tap
 H3QUwlWmb8bayHWUAc/rld5+/GBqlaXeGlLUOdJyj3hXMB87FaDR4/PDpeA2pez/HFX8Ex8YmCT
 K0LHK6Y2Ml/77Bt2HHZP2jfbpsLHXujVqdUe5ZW6w6YfK5IMK0QEsExlGx2zE9Va1Yg3NbAEPBi
 NNB5Gkijx+Pt7TNLCaXlEEUMa134P90WG/TwqiFBX2s=
X-Received: by 2002:a17:907:3d11:b0:ac2:a4ec:46c2 with SMTP id
 a640c23a62f3a-acb42c68c4bmr424617766b.49.1744865887020; 
 Wed, 16 Apr 2025 21:58:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpKJIMh///zTshtj5IgjNW2XC8DAWP5A98Mp/9bChGmlfFzs3tPRXBWnwm1acK5rRB0+PelA==
X-Received: by 2002:a17:907:3d11:b0:ac2:a4ec:46c2 with SMTP id
 a640c23a62f3a-acb42c68c4bmr424615366b.49.1744865886655; 
 Wed, 16 Apr 2025 21:58:06 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-43-176-89.web.vodafone.de.
 [109.43.176.89]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acb3cd635d0sm228793666b.25.2025.04.16.21.58.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 21:58:06 -0700 (PDT)
Message-ID: <efe3d94c-83c4-41d4-bd68-de76cdf0dc8c@redhat.com>
Date: Thu, 17 Apr 2025 06:58:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 14/24] s390x: Guest support for Secure-IPL Facility
To: Zhuoying Cai <zycai@linux.ibm.com>, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250408155527.123341-1-zycai@linux.ibm.com>
 <20250408155527.123341-15-zycai@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250408155527.123341-15-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 08/04/2025 17.55, Zhuoying Cai wrote:
> Introduce Secure-IPL (SIPL) facility.
> 
> Use the abbreviation CBL (Consolidated-Boot-Loader facility at bit 0 of
> byte 136) to represent bytes 136 and 137 for IPL device facilities of the
> SCLP Read Info block.
> 
> Availability of SIPL facility is determined by byte 136 bit 1 of the
> SCLP Read Info block.
> 
> When SIPL facility is installed, the IPL Parameter Block length must
> contains value that is multiple of 8 bytes.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
...
> diff --git a/target/s390x/cpu_features_def.h.inc b/target/s390x/cpu_features_def.h.inc
> index 65d38f546d..f874b9da6f 100644
> --- a/target/s390x/cpu_features_def.h.inc
> +++ b/target/s390x/cpu_features_def.h.inc
> @@ -140,6 +140,9 @@ DEF_FEAT(SIE_IBS, "ibs", SCLP_CONF_CHAR_EXT, 10, "SIE: Interlock-and-broadcast-s
>   DEF_FEAT(DIAG_318, "diag318", SCLP_FAC134, 0, "Control program name and version codes")
>   DEF_FEAT(DIAG_320, "diag320", SCLP_FAC134, 5, "Provide Certificate Store functions")
>   
> +/* Features exposed via SCLP SCCB Facilities byte 136 - 137 (bit numbers relative to byte-136) */
> +DEF_FEAT(SIPL, "sipl", SCLP_CBL, 1, "Seucre-IPL facility")

s/Seucre/Secure/

  Thomas


