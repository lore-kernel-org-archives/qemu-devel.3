Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E95C3ABCC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 11:18:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEndW-0000xw-Sw; Tue, 13 May 2025 07:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEndR-0000tL-TT
 for qemu-devel@nongnu.org; Tue, 13 May 2025 07:17:22 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEndQ-0006wJ-9c
 for qemu-devel@nongnu.org; Tue, 13 May 2025 07:17:21 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-442ccf0e1b3so63225625e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 04:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747135038; x=1747739838; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=of2UgCTXvLgTa0aXpiAXjOZGoG/s2RbBRQPK5Qn2GtQ=;
 b=MHqiyIOW5PcvUOu2+rlQk1c3VTKKv4FOnZF2xkrhfNKNQBLlPZiGL2HQt7tXvGLhHV
 iz8eGb145t6uL0Wo+trsuKdwApTwmw+5baBS8Z7x8v3ihSiSzYI6wwMc0WywIKy+CwOi
 Ck3kPM4Src/5rQxNQzFtaMB03E4d6R1NWTpi90sZMm3dKcVMEPC5VMJ3MqlatzG2YXmq
 1TIrHFC5smavO78/1gccXIAzyCYiggwUhfBkRPCAyrV/tMjJvv2g24XaQAQif6R7mJxe
 mROw6/Wp76SkXgUKWM00bV4r+S2RPw+nlp7uu6JvEJ2MOYS/PHRZlNYnICTPunWLh38q
 Ryzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747135038; x=1747739838;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=of2UgCTXvLgTa0aXpiAXjOZGoG/s2RbBRQPK5Qn2GtQ=;
 b=QtkGnqZ7WneYQQ4NbZFTfRU2YswupTfjYM3Ed4VZi6QjkM0YnObafoUNqptsg7S+r9
 qB55dJVbe+o3neciZzTc29bW45P0fiUOcU9t4AE7UpOXamnAB2ecVGGJUgUoIzQ+vpcy
 V2OTJab2j91UMbl2+CtGOaT9Sdxb7WNYyVugdaKX81cIXzOdZeC0WpkAoH0DR7bk1+YW
 vDgcOGMfzrpeM01VtKxamto6XnMRzqqY9Ky+lgfQQ80JFffODQ7d1Xm/VgYVf7FFUzpU
 JpmVNBQUDVV0BqfHWI2TmcHcM01Rf7xNXV5wyjNnBeKFtbbe4wkAeN802NHYyrf+H+2/
 wp0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrflcQf5R52a3W9CBJC6jncGbc0rhf2rJFW4aMesrQofxvrrqZ33qs9pAWMKXH+YU53BwcgJdKN1L8@nongnu.org
X-Gm-Message-State: AOJu0Yw0UBcKpyziOrerPIMLSvRw0KmUrvSMrRp2mfOz5nY0yZ5OD/iA
 okAuaZxlfoJNQbVAOH3r55NHnfa+pVf0x7JpK8HDvkbSU3ih7Ez9QjK3A1wr5+A=
X-Gm-Gg: ASbGncsSS/S9LzHzMeC+9bVTslaAJZZ280AgFyFSvm5iowVG81SOx1u/22Pvjx73prq
 ttW3RNPwSf3hNXVTKz7WRTFPSVqma3QHM7BLnq5oShCU0wjsUnndn+Abr/tfe0/gRP4+cTZ7i43
 F43n3e1fOhw+SEQWRkj1Kp0Lv+y8SyPm6lxgplwHYHKTdB3zrY2QKVAbRSHd8SXsRqeSUq+EpNQ
 ElTv8dFcHBS+fsk4nuX5yZYnNbCniQzEfMc4DbXIa7MFcMIbvdbfyJidpPhQfJehuJjr0HN19nm
 CwymE+LDilzxLv/riKHsPPQCYpXrib2sB2KiPjA2Lb3GcgUP10fbJ8oHmZMOtI8tV67sRAjVzmi
 s1grn3NuMsFOU
X-Google-Smtp-Source: AGHT+IFM7cFYHJRk2aHFsAkOMIRrK3/kt6YDlsnLVo1TC3ZDPZhdPNDnZ6KPTeZirJ2CX3sPZwUKow==
X-Received: by 2002:a05:6000:1889:b0:3a2:377:500c with SMTP id
 ffacd0b85a97d-3a203775382mr8284545f8f.16.1747135038606; 
 Tue, 13 May 2025 04:17:18 -0700 (PDT)
Received: from [10.61.1.197] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58f2b02sm16071599f8f.51.2025.05.13.04.17.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 04:17:18 -0700 (PDT)
Message-ID: <5617a3fc-3178-4661-a179-aca628cdfcb9@linaro.org>
Date: Tue, 13 May 2025 12:17:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ui/vnc: fix tight palette pixel encoding for 8/16-bpp
 formats
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250513100819.1179249-1-berrange@redhat.com>
 <20250513100819.1179249-4-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250513100819.1179249-4-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 13/5/25 12:08, Daniel P. Berrangé wrote:
> From: Daniel P. Berrangé <berrange@redhat.com>
> 
> When sending a tight rectangle with the palette filter, if the client
> format was 8/16bpp, the colours on big endian hosts are not set as
> we're sending the wrong bytes. We must first cast the 32-bit colour
> to a 16/8-bit value, and then send the result.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   ui/vnc-enc-tight.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


