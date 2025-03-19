Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD92C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 23:18:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tv2f9-0006ab-G4; Wed, 19 Mar 2025 19:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tv2f8-0006Zl-9K
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 19:17:26 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tv2f6-00057o-5v
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 19:17:26 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22423adf751so1558555ad.2
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 16:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742426242; x=1743031042; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ttP94RHuaW+AA9Kr1WQ092r9FjI6PwOL8z/bAPk2OEs=;
 b=VSTO3pgzCU2upZDq/nffH87V9atkjle03yeCWTUMjLMSDmoPXC929D2LOWpM8xxQPJ
 F61ZSLs/2fBOk2ULqM2LQ4sgAOFJ4Flqn4kIyrA4KuVzufocK+uhuCSuQxeHxWB9R4bQ
 dJTIH73a86oyqJUwujdt43r+zuQyCCtcoNuoGz6K66lXmjWu1QmESfMUeLR3i+yvhFGn
 Dr5D7VzUqasxXsd6RCFiimYSjuc3khzFm952idBcvxsndPYmTkLIMS1AgRhuldijGkgE
 25NRc715N9eKkPy3BUpRJNlEGwFPeVgJT+lP9cIm262dKqdMQ1mmBe+ycXhKls/ZxWAv
 F42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742426242; x=1743031042;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ttP94RHuaW+AA9Kr1WQ092r9FjI6PwOL8z/bAPk2OEs=;
 b=wfywckSmWYHeKx0qNHXMNWpRN28nJJaTsR6R7lx1E3Sa1ZaakbgZ9tlvyOo1LLYkZH
 krEHUkb/i0gwPXaziHjCatzNmFygfrK8uUXHxbEl1DUfvcaMcT5lN9o/Ex/CM2R3IJyx
 I24oBsgCOSR4FbVBPGKzF1PSnTM6oWbtqyuSWc0tjSvAqsxXe88xofHCXBlf3ZIShXYR
 v36+BzSkKSIrKod1kFg6CDl/yBykNCcxhBz4aCbXgWrW7BsMOUyR+z+sAxohRcwJmKvv
 YnAa5Q1e2K9FvH4Br5Pp1SD1WzT1ZWyJfaJAR+v+9v9a6I+WA9Nys7C9piDJcAyebxU3
 Ov/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVl150HQ7DTEhnJMT8Mtnfo92OQq/nWaaqKZgK6hHvHRTzG5aze9lzMPq68EI/uIfDUZUuFD8rauQo@nongnu.org
X-Gm-Message-State: AOJu0YytR3C2/qIz02IxYK/q4nOgUSkr6D/lIpBFu4fpFVXIbQhqCiGG
 gQ2zQGwrBsYGh6WOGZBQcnnOeYAUchqD4r5OS8NcwZ+ZdO6eRd30be0Ppklm0/4=
X-Gm-Gg: ASbGncvTa+dxn8RXPddGaxMZbzqF5HZ1iLo0IuOHjJ1YkjLGDlK9DYF9eytzQjDL44d
 wsS0KuLHV976WC0op3lV2+vdY+AEPwlPJGVuexQCwXH/mhYLa8KJP8AQYkGuFUWKyANdIDDj7WO
 wLz+7q7ThYYJVUzzex1nQjZujnO9MJQ/JzH+V6SotjVUD2e3KdgI9f+ENWKqA9vgGB8AMDlcFPr
 hU1wNPXoqmQfA6XSGSuSEsaHb0CgQGtFtKilTjQrj+xX0RZ7fxTRoTzHg6wafSHs9XFS5q4sU/q
 NKQP65Qjs4fW1EGHEhMitLMuZ7KPSh/yPurTKXujLUZjPFMJXHdTZRo00g==
X-Google-Smtp-Source: AGHT+IEtBsTb1UciPJqi6Yn3xnP4BzsUVR1YgdarGKsS/r3jPqAR67hjwo2vl8jyIQenMvjoz3v6cg==
X-Received: by 2002:a05:6a21:99a0:b0:1f3:3804:9740 with SMTP id
 adf61e73a8af0-1fbeb999249mr6978385637.15.1742426242185; 
 Wed, 19 Mar 2025 16:17:22 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9e0fd8sm11540538a12.26.2025.03.19.16.17.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 16:17:21 -0700 (PDT)
Message-ID: <8ddf1e1e-7570-475c-aae1-fa715f983131@linaro.org>
Date: Wed, 19 Mar 2025 16:17:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] target/arm/cpu: flags2 is always uint64_t
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, alex.bennee@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
 <20250318045125.759259-9-pierrick.bouvier@linaro.org>
 <9556c183-c103-403c-b400-0942d42785d7@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <9556c183-c103-403c-b400-0942d42785d7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

On 3/18/25 15:40, Richard Henderson wrote:
> On 3/17/25 21:51, Pierrick Bouvier wrote:
>> Do not rely on target dependent type, but use a fixed type instead.
>> Since the original type is unsigned, it should be safe to extend its
>> size without any side effect.
>>
>> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
>> ---
>>    target/arm/cpu.h        | 2 +-
>>    target/arm/tcg/hflags.c | 4 ++--
>>    2 files changed, 3 insertions(+), 3 deletions(-)
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> We can also remove the comment lower down about cs_base being
> based on target_ulong, since that was changed some time ago:
> 
> exec/translation-block.h:    uint64_t cs_base;
> 
>

Sure.

I updated the comment to this:

   * We collect these two parts in CPUARMTBFlags where they are named
   * flags and flags2 respectively.
   *
- * The flags that are shared between all execution modes, TBFLAG_ANY,
- * are stored in flags.  The flags that are specific to a given mode
- * are stores in flags2.  Since cs_base is sized on the configured
- * address size, flags2 always has 64-bits for A64, and a minimum of
- * 32-bits for A32 and M32.
+ * The flags that are shared between all execution modes, TBFLAG_ANY, 
are stored
+ * in flags. The flags that are specific to a given mode are stored in 
flags2.
+ * flags2 always has 64-bits, even though only 32-bits are used for A32 
and M32.
   *
   * The bits for 32-bit A-profile and M-profile partially overlap:
   *


> 
> r~


