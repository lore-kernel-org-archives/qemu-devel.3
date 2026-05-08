Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F5B0CD37AC
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 18:56:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLQMQ-0004N2-RW; Fri, 08 May 2026 14:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLQMO-0004Mm-Fp
 for qemu-devel@nongnu.org; Fri, 08 May 2026 14:55:40 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLQML-0007Xq-Uc
 for qemu-devel@nongnu.org; Fri, 08 May 2026 14:55:39 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-464bc03efd8so1249387b6e.2
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 11:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778266536; x=1778871336; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bKlzN3cOMUIXdZzJqwRdCg4TyRgGc3SBwiMsvJHKBCY=;
 b=yyc6TwNaFPY/6irL/Nw+uN/WIe7DI6wBeVnyeaLiyWlacY+K6LOtc9SLXjgzHGnEOU
 vj5L/g1L9JgK1A4FiQrjCgxvsIp/vm5CYaJN7YnZCSw9qpSmnVqnFentRayD3qsIbtcd
 Lca/M8BrPpr0dy6v6aioeJqcFFyoeGwGMWIjSgQ2pyyGyWZv4ij9CvI23qiXRjJwpS41
 lk9R6Dljc1q1EZH4z6v5jAuBrYfjAJFrzh2mjm9HdMjU3EVUdoeb8cJogHsorG7UeS7m
 IgDlOg02S46ka1MJ5Ck624guQAbU7/UM67Mb/VqsvTDz0v8+iL0FdKl4VRBdKcGdwOas
 1TKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778266536; x=1778871336;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bKlzN3cOMUIXdZzJqwRdCg4TyRgGc3SBwiMsvJHKBCY=;
 b=fwZSndCEhgCZ3tiXpZiFx+Tc8sFmmdOGEBMJtWqM2wmFyG6XS9N1uszOLeujAfpTq5
 dTOziZsQdJRdgBsihiEz6EClzaZ3JA/M1Nhh5M7fQ4Pb8YjZJxarkuSWNBda8eiWVa8I
 K10Ra2DZjE3XCb1yMqmWwG/6Eb4ajH3caO3KLekTLoRTyx/gQ1PVm5zFL/ZCdOIzR31P
 Bb1OhivlZm1KmANHYMIKfbY51gPop3HIYCBb/cRT1be7ffZwHmy/bV4L7kQIS0i2xHrT
 4KigfYCumu8PdqD35H4oyzRMtc13z8Qzo9bjnr4JP87S1QhRzChf34xzwdONjkEzAqoG
 vh0g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/a+rmW+93ta4G77lNwydb839zeZQM2WVd53mIfEHKz9BO+Sk0o4O2cgtr9v8CJSRtHAH30mc0iRoIz@nongnu.org
X-Gm-Message-State: AOJu0YyOF/fxsaeD/mzTRCcsYWe9isS3hwM4si9UTSLwaAJij2hOUcuA
 XElrIhJrpgsSH2v9vbWixWJXg3savX3X5VHFxAxj/RySiaA0+sUnlVghZGGNPn3hjIE=
X-Gm-Gg: AeBDiete5J5O0ZxyxtkRH8uy5TzY+FPID/vBEvPLGnx/MCAJ2RDKg/VnjmsVkdjY7TL
 iLbrJDZg4X4DRH4MbAwar/n5EO1CXl0XAR9+0Qn65/j3vKfer19uuOnahWJl4x/VRpGziFbXpeI
 xkvygBxiREfhWAD6IEKBabR3uob1iNhzO6CJ+eiblD3bhBYuI00j20Ss4NIPGvCD69bs185cTNS
 JofZIeJ+w4Rygy4xIpABEMwLvmCMlEBsMLMeryJO5ZTDM1oRh8HLjCZZwGjLfgTFZX8uh481ZRp
 PVKt50h7XKognr6DrvGCASQsPeyoTo1mFNg8glggAdaPKBAtc/nS2DLKkqNiCGrb6kLI/4MPwrH
 EdEKoNWr7kV5SKm4n2+HvX15mCDFPqgD9GWg/gSEfe39/N1e494ykUhL3b3QXqTeei+04FdtHpQ
 KzqB8/kzn9lo680/j8SADKYF6IMFcYbMcCuHVuK5sgCYfyt4Fp9SH6+Zs7qMNw60xJvF4n1E5K0
 OEoIOj81Gfb8jKz4SfaxSiy+JsWpQY=
X-Received: by 2002:a05:6808:3c4f:b0:47c:9ba5:d930 with SMTP id
 5614622812f47-480422d94d9mr8772855b6e.25.1778266536551; 
 Fri, 08 May 2026 11:55:36 -0700 (PDT)
Received: from ?IPV6:2600:381:c938:6375:4b0a:aabe:cbe1:bd0c?
 ([2600:381:c938:6375:4b0a:aabe:cbe1:bd0c])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c76936271sm15065348b6e.9.2026.05.08.11.55.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 11:55:36 -0700 (PDT)
Message-ID: <04ad5869-903c-4248-bc61-3656a09e2c97@linaro.org>
Date: Fri, 8 May 2026 13:55:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] target/xtensa/core: register types using type_init
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, marcandre.lureau@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20260505224826.2698753-1-pierrick.bouvier@oss.qualcomm.com>
 <20260505224826.2698753-2-pierrick.bouvier@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260505224826.2698753-2-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x232.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/5/26 17:48, Pierrick Bouvier wrote:
> Instead of using a static constructor, delay registering those types
> until we call module_init(MODULE_INIT_QOM).
> 
> This is not yet a problem, but since we will start initializing
> target-info types before any other, without this patch
> qemu-system-xtensa* fails with:
> Type 'dsp3400-xtensa-cpu' is missing its parent 'xtensa-cpu'
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   target/xtensa/overlay_tool.h | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/target/xtensa/overlay_tool.h b/target/xtensa/overlay_tool.h
> index 701c00eed20..b9eaffa4871 100644
> --- a/target/xtensa/overlay_tool.h
> +++ b/target/xtensa/overlay_tool.h
> @@ -451,13 +451,14 @@
>   
>   #if TARGET_BIG_ENDIAN == (XCHAL_HAVE_BE != 0)
>   #define REGISTER_CORE(core) \
> -    static void __attribute__((constructor)) register_core(void) \
> +    static void register_core(void) \
>       { \
>           static XtensaConfigList node = { \
>               .config = &core, \
>           }; \
>           xtensa_register_core(&node); \
> -    }
> +    } \
> +    type_init(register_core)
>   #else
>   #define REGISTER_CORE(core)
>   #endif

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

