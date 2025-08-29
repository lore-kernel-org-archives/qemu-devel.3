Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD0A4CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNiE-0002nN-3J; Sat, 30 Aug 2025 11:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us6VT-0008CZ-2d
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 17:19:35 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us6VR-0003HV-7I
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 17:19:34 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-b4d4881897cso725271a12.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 14:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756502371; x=1757107171; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cLdCdGO6KgNfET/tKkR5GrN1zhQkheLz0RORBruzRQI=;
 b=ifGd5cX/bonh4eg5jw1zH6tzOsKZAsbhVFTACtdCcFnrD/mfYiHfXH3tDupxM7R928
 J+7T/WKHZQWfDka3aSi+hgJiswqiOG1M/UbekD4AqS+1aHKRTp/jh946T4/buLh3Ag30
 KT6iosVBcrx/1Eulyjm+wX7vRXMO4IZcEImLyuILnN76fYcEgtd4CPjyynLCCQwJOP29
 r7bBlxx8BPMmE2Tp4geXkAVdTIjf1HAIKO07vra8w3C/Ov2s9v6Peipm96MQtFfeocXH
 sJN7Cq6bpUldYiMmWyEjoNjUYitbOjz5W6nUSbhZbNr5iRlEC8Opn8qsLaYsXsbXF3BA
 qQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756502371; x=1757107171;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cLdCdGO6KgNfET/tKkR5GrN1zhQkheLz0RORBruzRQI=;
 b=O0dBRiXdVa1kjfQqMJfXYB7cio5znmpWivaYAhEOXhrcYjoHZ4GaMws+bOhdLMmvJk
 RLCIwLwnnkRlCxv5WycywLzyYOn0mj6Q1gP0mNds86l/OT+EN90kDn0fy+mWenK30+ox
 DhlxBgCqqlPFrVMv2twgSFdiJ5JKqi0s2tiLb4GOskI+lkADdv2kKRlmN1xmlr8ukQ2X
 5i05iFJluYnFnJJNp3Dlfe8yjbtBaEj2FOFv57zD99nQawQF4dEOCt1a2eB+n1VpEB78
 9F5aNMAPFmgNKq25jF4zz7wvD0rnP/mmEJoEHJJSpurtf3O9WmGPFHFyhLIyEPX1n1u6
 bNTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjj92IsQ51Gkt/sqzdbTYC4wzIRsWqoLaIR31F9zfG2WXsovzJGYv3SQ6bihWBDWcJzOkkh5FPrKiw@nongnu.org
X-Gm-Message-State: AOJu0YxefIbcXWUokp0XIiUZpgzcz9P9jUw1XqXuofzpmKZQ36x++Na0
 luT7K4ZEn3mZJY2xN6mBHJd1uUBtW4pjR2rUK0iAdLDIZhClYrnKoHd7pEtQawqDrOU=
X-Gm-Gg: ASbGnct9/j8Gt0G0HSZlijr0lLL14Jnlu3rFODD79xXP2p6H3OsDvvJLEIlQpLF97tY
 rZxy3CWmtb3Us4kzSzML+omViCIYOIU36bsp5ALQJ+fw4fPvD2Qp5x3to+FwELdLrhypMP8Ee/v
 kBEaL5u0skbYkvJE8I4FSq44ryF3XTXKm4oth211mofxu8tA/uEdpf8jZ6EctBH0oXuCLtLTfQ4
 1fDQ49U0oIDaVl/7oJ/9uzdovAzHj1/oOzEWhocry6+/NCGzsTe2yTd4HdPLfrodwU8rewuK9zY
 j9ffaT/6a3TX7Q3SxadIqPwN19KECsj0qgZsFXVXwsWZ5G21Lkn5nZ2lWVpjLwcKv+IdLLVXkHM
 zkNmSYEfxRm0pc/MWpvlxw+33lVkAIGjheLPQ795Mwjp0pr31inwuzeWQRFa6hWx9S0sg6g==
X-Google-Smtp-Source: AGHT+IHcemx1XDd+dLDe4LJtVag2p3o6xU7edK+rLc7aPtVewKZTogi71dQTyxXsbAotumBn1GWdpQ==
X-Received: by 2002:a17:902:f68c:b0:246:cfa2:81df with SMTP id
 d9443c01a7336-24944b3fdd1mr416365ad.43.1756502371092; 
 Fri, 29 Aug 2025 14:19:31 -0700 (PDT)
Received: from [10.118.1.198] (122-150-204-48.dyn.ip.vocus.au.
 [122.150.204.48]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24903744d05sm34048495ad.53.2025.08.29.14.19.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Aug 2025 14:19:30 -0700 (PDT)
Message-ID: <de9e303c-73bd-450b-856a-5b00b1c963b5@linaro.org>
Date: Sat, 30 Aug 2025 07:19:25 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] tests/functional: fix formatting of exception args
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
References: <20250829142616.2633254-1-berrange@redhat.com>
 <20250829142616.2633254-3-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250829142616.2633254-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

On 8/30/25 00:26, Daniel P. Berrangé wrote:
> The catch-all exception handler forgot the placeholder for
> the exception details.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/qemu_test/asset.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
> index b5a6136d36..5c74adf224 100644
> --- a/tests/functional/qemu_test/asset.py
> +++ b/tests/functional/qemu_test/asset.py
> @@ -173,7 +173,7 @@ def fetch(self):
>                   continue
>               except Exception as e:
>                   tmp_cache_file.unlink()
> -                raise AssetError(self, "Unable to download: " % e)
> +                raise AssetError(self, "Unable to download: %s" % e)
>   
>           if not os.path.exists(tmp_cache_file):
>               raise AssetError(self, "Download retries exceeded", transient=True)

Isn't this exactly why f-strings are better, because you can't mess up the placeholders?

Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

