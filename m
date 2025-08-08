Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B084C87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 14:03:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukNgS-0002df-GJ; Fri, 08 Aug 2025 10:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ukNgD-0002Om-1U
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 10:02:48 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ukNgA-0004yU-JO
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 10:02:44 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3b7886bee77so1689448f8f.0
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 07:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754661760; x=1755266560; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EbZZ4sywkonj7FnhWZK8OKG+k1BfHFsIoacIJtQdkJA=;
 b=O6IjJHayBIDqc85p6/YzbNUr+/CoF7rqqfxEyuBZp8UYgT6ig3XBsOqrN2Gr4JNc0z
 FelBL6ujRPqz5jX01ucjjK+IuLhZivLk4nQWaYERtQFKQ1sF3XGemjVj5illlZIV7rZO
 NgA7R//lAgSOWQ5lY5BpxLkHmG6DCgVNhTlOC96DfSKAxVwFT3/mCIYLK/Q2g5X+4jxx
 z8G3z9s/6AZbrUxw0uH0Y8wO10II5qbXyF7EBxzcla66bOO0i2RjMGGwCXfxCANV6YKf
 yzZSW76If+0OTrQGGJChyxWmu0A4k5p9cLIlmRXMLOxFlWLqHnz0OJHpUH7iDwYcBF+Y
 7+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754661760; x=1755266560;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EbZZ4sywkonj7FnhWZK8OKG+k1BfHFsIoacIJtQdkJA=;
 b=MF+yNxTQUPZ6XTrtyIxGj2cF1/8bCxJ7urhKx6+Nyeouefm3U9INtdDjgAuc4QzEVy
 0E9JtvxNeBYg9uwVhCh1FPWpph6T5atzqH5aDC49wbUAWbaLHIafYDdgXr+lyol0Iv1N
 deSYORQtMShjoF/fAmCB47oMapKhlgQG4ThWEa8Cv2LTpYJoAb+Ytpi/NgJTUkGoJJLD
 whEdjGuP9czksQvcSQKOjwF6SrVhSrY02r9NOmW799wBblX0EefScz0vLpwNBY+L5tM9
 M7AOljkIBzY9Pr5tFcxmMfBpQBx/Q/YLJPRAH04PHBSFPcr8jYOd4PvDpLUVkeyzjKs5
 UTQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMI16qRcWurKfxYTT5iuYcqsuJk01AWt3xEU+SAl5ghEHyFpavI7uHjrQJoNfgt7yoa5MF9jnKmlT6@nongnu.org
X-Gm-Message-State: AOJu0YwioIVwhyVltW+n8MLX8Fz9ZodmKdFhGhdd9AnSPVqkbOE7RN3/
 OJZ+g5XnoWcoCu30ncgUNnLLOun6scpmHfo5Qrv17sWGW8eSeA3Jytw4YO7Rop9aWKg=
X-Gm-Gg: ASbGncspMmuUgcdx8F/Fcagv3bSrvujPyDSfDhs9kvg4LjBGqou3UYZsJjVhDagvAuv
 f0aNGhHeRCFYfN28UPJHkhy8r9M5WidkbkQv+1rkOUFEF8n4qvg2iSudBVLr1gA6HFSwflaJWcS
 uAQL4eIzDXr4ExDp6dHDQKZtPvfzTxaDzgsp7Jk2Ry4WGmSXrOIKpv6oKWO+rDH4jevivqa7JnD
 WMTNfJJqPNHcXnQ4dVaq49d78eUqy1Ard+BxApg5C8BldEy9Mwct8jx78SVuRv54vsfIFaGem+V
 TCukk1GmK/LgAxJi2ALM/sZuAqhwDsGlj81WFfu7q6DNBRkuoXGxsjBLhnk3rmspxDH/FfB/eqb
 6lLd9MkAoNdJi1/YGItQTOE1M0OE4qXxRWRd/jLA9Mo2WoWbMzehH0Q/ZBViujL42jA==
X-Google-Smtp-Source: AGHT+IGp1wuLH77xRs9n2uv08MOo3SrgGdzjNYFbwoyik856Ymo7iNKin+cBQFcm+3eOqy2ydyR1MA==
X-Received: by 2002:a05:6000:2511:b0:3b6:17c0:f094 with SMTP id
 ffacd0b85a97d-3b900b50329mr2761402f8f.14.1754661760190; 
 Fri, 08 Aug 2025 07:02:40 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e075047fsm97562835e9.1.2025.08.08.07.02.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Aug 2025 07:02:39 -0700 (PDT)
Message-ID: <7c4d300a-3f61-42d9-90a9-f0781db024e7@linaro.org>
Date: Fri, 8 Aug 2025 16:02:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] error: Kill @error_warn
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, marcandre.lureau@redhat.com
References: <20250808080823.2638861-1-armbru@redhat.com>
 <20250808080823.2638861-13-armbru@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250808080823.2638861-13-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 8/8/25 10:08, Markus Armbruster wrote:
> We added @error_warn some two years ago in commit 3ffef1a55ca (error:
> add global &error_warn destination).  It has multiple issues:
> 
> * error.h's big comment was not updated for it.
> 
> * Function contracts were not updated for it.
> 
> * ERRP_GUARD() is unaware of @error_warn, and fails to mask it from
>    error_prepend() and such.  These crash on @error_warn, as pointed
>    out by Akihiko Odaki.
> 
> All fixable.  However, after more than two years, we had just of 15
> uses, of which the last few patches removed eight as unclean or
> otherwise undesirable.  I didn't look closely enough at the remaining
> seven to decide whether they are desirable or not.

Is it a call for help? If so, better to split this patch per
maintained areas, and finally kill @error_warn.

> 
> I don't think this feature earns its keep.  Drop it.
> 
> Thanks-to: Akihiko  Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   include/qapi/error.h           |  6 ------
>   hw/display/virtio-gpu.c        |  8 ++++++--
>   hw/net/virtio-net.c            |  8 +++++++-
>   tests/unit/test-error-report.c | 17 -----------------
>   ui/gtk.c                       |  6 +++++-
>   util/error.c                   |  5 +----
>   6 files changed, 19 insertions(+), 31 deletions(-)

