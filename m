Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27586CD4851
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 06:00:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN2d9-0001ME-09; Wed, 13 May 2026 01:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN2cy-0001Lh-RR
 for qemu-devel@nongnu.org; Wed, 13 May 2026 01:59:28 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN2cv-0007je-Au
 for qemu-devel@nongnu.org; Wed, 13 May 2026 01:59:28 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso57458635e9.3
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 22:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778651963; x=1779256763; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FJip+JPTZxh/Npxwsm/nJ75N22YHGL0+Lsg0prK85AA=;
 b=hW9pcvBcIcHZxY1moeY9bmU0mhKUouxP0kKJped/cYkfOZuzsxtAnUJrC2o72GPLxF
 6X1SFLrqvrxhgzYvmWqUfrnGVqQDC5g+t+so8fp81CN+/cwi6MXBw80he2q5LgzfcLZl
 lfjAyhPJ1HpcOFVuFk7hD0uTieNaSSrITHP8R0m3FssRgVRzU3nyHxKqO1mHUjrYpNz5
 /mbar+szWFg/bCyG5yHBOcYcdUI3V7TKY2lsgNoQo8kjKVC4B1Ftepd34KJIsEqLMr1v
 IrJ33KyaatMCR9Dju4LGVMkjLq1comV8G/6Rq5LD6sgtGf/LWTo94jTZXrF6zkkEPx6A
 mvgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778651963; x=1779256763;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FJip+JPTZxh/Npxwsm/nJ75N22YHGL0+Lsg0prK85AA=;
 b=SFZwHwRn2SaiUL7ZGLvuuo9w45BqrGCNDRk0048cfauuynVB/NvwIP4Di77EqtdusQ
 /1gQDOSvqMQI87+TYWeC7jDTjTuf5C4qs5ZQd5VoZEVwPBRBGRbop/ZwHSNTjFcCV0HW
 QrpnsojpApBODyTbR/y3O8l5CNtOzLvCKH1es4UbmYb1fsp3lOa4hziIvHv7ApWYOPK3
 x8NTKFQfPZnaJ9jxKcSh6tKegqP6MWf/2WA6CJI/mHHkQx/8OJQdDBhA83vM+PoFPvhn
 b0SPb/8bVTCrVSJnFJU4F9kutOB7DzxiKU0j5cnmsKf3eap5igVNKNHFNdhUy868bBG/
 vB6w==
X-Gm-Message-State: AOJu0YyqpJBzcPCsNH3Di8yS6CUd2hInrJGzI4z4hAWLjpHfbnsh/sZS
 i9RIknAHkNuV/+O6N7aLy214eNshmArlwEVy52CjBGpqw+s5D+FrHfjwBuTmZfsHXQc=
X-Gm-Gg: Acq92OHgBDKvaznh2jWBGe2nvuEsvRDQ+nhiiD+LK/Ofeik9KGwV76EVJd2FsGYkojm
 ngGTswNCUpt5cpjZuIZx74xTPjehb9vU1ARWAoNDQ+P1HerS3SUTQSri27yQgt2+PxyapFVNmTh
 gLdZeFVfT8s/tCDX+wHsoVNA+Sjdbt9h2V71UShC4sEGyRnIxmVX1tDyfVJ9fHLb/ICnBZTj87L
 ENrW8/6Z0BV3wUIzSFBW5dsuBg+20VUyxaWDmHO66hrk1L6sboy3Mqn1eu6WpQfe1Ed7wCzpVNs
 5eEraX94kKb8rhk0GmumF9oiJNQrkXR6ODQG2tehogEPp6B+hJtP1b1BHT2uUYoU0mwKEX/DgRE
 IrcdEBF9f6Z7okTzpr8X8hQ9h2SCi4ZaIurWOK9A/dCtECJjwqif8HP8MpbxLVvPugH87CBJph6
 ow5hsRe6zwV5Segr4Ou/tJ/+/+NDZra8CobcQBtHY/o/cDrgVdZBPGMvWyTM5QKVeOHQ==
X-Received: by 2002:a05:600c:a11b:b0:489:1fa4:50c6 with SMTP id
 5b1f17b1804b1-48fce9fc34fmr8895055e9.20.1778651963410; 
 Tue, 12 May 2026 22:59:23 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fce37b308sm45332525e9.10.2026.05.12.22.59.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 22:59:22 -0700 (PDT)
Message-ID: <0be66ee5-d519-4a37-a4ba-3f51665edc6d@linaro.org>
Date: Wed, 13 May 2026 07:59:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/loongarch/kvm: Include missing exec/cpu-defs.h
 header
Content-Language: en-US
To: gaosong <gaosong@loongson.cn>, Qiang Ma <maqianga@uniontech.com>
Cc: qemu-devel@nongnu.org, bibo mao <maobibo@loongson.cn>,
 Thomas Huth <thuth@redhat.com>
References: <20260512121954.2248026-1-maqianga@uniontech.com>
 <81f4ad66-bb0d-e2c2-66c0-74a6ec595738@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <81f4ad66-bb0d-e2c2-66c0-74a6ec595738@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Hi,

On 12/5/26 14:36, gaosong wrote:
> +Philippe,and bibo.
> 在 2026/5/12 下午8:19, Qiang Ma 写道:
>> After commit 71cab1a42d2 removed the indirect include of
>> exec/cpu-defs.h from target/loongarch/cpu.h, the TARGET_FMT_lx
>> macro is no longer visible in kvm.c, causing build failures:
>>
>>    error: expected ')' before TARGET_FMT_lx
>>
>> Add the missing #include exec/cpu-defs.h to restore the
>> TARGET_FMT_lx definition.
>>
>> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
>> ---
>>   target/loongarch/kvm/kvm.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
>> index 9d844c4905..7989aec7c7 100644
>> --- a/target/loongarch/kvm/kvm.c
>> +++ b/target/loongarch/kvm/kvm.c
>> @@ -6,6 +6,7 @@
>>    */
>>   #include "qemu/osdep.h"
>> +#include "exec/cpu-defs.h"
> Simply add exec/target_long.h.

Correct.

Looking at the last build-loongarch64 job output,
https://gitlab.com/qemu-project/qemu/-/jobs/14336151206,
I see KVM is not build-covered:

configuring with:  '../configure' '--enable-werror' '--disable-docs' 
'--enable-fdt=system' '--disable-debug-info' 
'--target-list=loongarch64-linux-user loongarch64-softmmu' 
'--disable-tools' '--enable-debug'
[...]
   Targets and accelerators
     KVM support                     : NO

Why is that, what is missing?

Also I strongly suggest adding a cross-loongarch64-kvm-only job in
.gitlab-ci.d/crossbuilds.yml.

> 
> Thanks.
> Song Gao

