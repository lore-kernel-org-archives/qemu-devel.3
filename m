Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2860FD88D2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 23:53:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w06sh-0004AL-E0; Tue, 10 Mar 2026 19:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w06sa-0004AB-UQ
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:52:49 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w06sX-0001fU-GT
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:52:47 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48532925a4bso17360285e9.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 16:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773186753; x=1773791553; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L86dKLNb9x3/9nS86hWLD6OJNR62MksgKYIenpbv6l4=;
 b=Jn0+hF2RlascgSdzFEtmUzyLFmhxsUPfLOnsEZUrzA/Fu2OqzzJqTc1AW2T2Q7qtYp
 1Z/WooF5T+1mVxWDNFdEtxOShewk8Rv9xuzvQcGiZoAku783xqd8KekQq2ikAyAtM7w+
 m3lT+Qqr1Oox3L1+qbSNkWy4GbusMWEdNgEqQEyGekaLNt0heN79snu08nqtgXlg5cVE
 zF8mej5GwD75OeeEpPONm5yJpa6pUI54BImmBN8SWpQToQ65geOHL0wdxDUSA5W77hO3
 y9zl4QyBRhl28srfi3ogLP3HBJMlSjTkoSGKn7dcX0RTapftZNeDGPTsj1mcTeVbV+cF
 Scqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773186753; x=1773791553;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L86dKLNb9x3/9nS86hWLD6OJNR62MksgKYIenpbv6l4=;
 b=H1sO8cDsOw63KZxEKmB2C27g3F9LWNZkVJzpkFwL++wgaG/7v1bTWt3HZSWVhu71AY
 DQWsWgklraQmxNl3IWRUOA70bI8wfUKdIavI0/JpFvZw6Cs1NqvEqjZt7N815XJPm2XK
 KETacO7NS/f6Zt9BiGYipOhVRWJ+3vmAEyRcfSQNKLmDxIZadRoMpE+oBfIGxGIrkb7S
 7zYsWIjJ0aAHe1eaoqohAssoSU5yImLsql/YakMSzrCLmEHc9f+dDwiKcKva3EVTmtm5
 IBoOkJc6CtRKk/ATsOBzXNk1EmKlnwd1VB5b8d6sUYjnNJgNjK/WV35bHoFVVhPrmvwR
 ghEQ==
X-Gm-Message-State: AOJu0YxvalD6rkjFphibximffD/zNqaGCEZ5LM4SHuaVRQE3oGcDouLL
 4SrObGUzaWL5bNDjngl8ScWtJH3j5YFMM2Hz09205oUvMiKmmRbF/0rQ7a8OXOVeLyQ4GQ3WSgi
 icvWoIyY=
X-Gm-Gg: ATEYQzwYP9EJij2yNqEaQ4tcnNzjoMQdkFym7O73Cznbja5H99HjhW0u9zTGmGx/Ae+
 wGr6pSY+L4AIbvMOml8eUkSrsOTIxt7l1cD8k+DYzDBhSG7kQtBJJLUUjexXe2YRcy+o96Oc6Ku
 ewQJi6Ws3r6PYm2LK5moLh2ExVJKoqE2+42OT0DV2vm3GetoipWP/k+DwoUOmYdnBVF9FsV7JNz
 yHM48GN/ztwMLLXA35sbmyDPMPAdjaU3X9ip4qlNDnvKLP8ZrxR2RHV9AfUbPKzI3PAOswTB8NQ
 ueEUkrRWyEUaC1esZBnysvPyE60AQwzm/JbBgfDMIOmpq+XesZLlNIF4N3Hwqgy/JriuYzUgc54
 2MaXlvNRfxAFwtldVLRpc+83H6aFKo4OQ76GRHA9GDMP71YbgEhZ9ICUje5Mq4h8mGXqZrfNkic
 iMbxg0xu2Vh4vjgyK39oPY+pcT2/wG7JXHSyotAEu2L1QwixRgXg5B0sxLYYQTL4eTKvvkU+EyR
 laJ
X-Received: by 2002:a05:600c:8a0c:20b0:485:4552:8fbb with SMTP id
 5b1f17b1804b1-4854b107fefmr7233845e9.22.1773186753339; 
 Tue, 10 Mar 2026 16:52:33 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439f818ff0fsm1935075f8f.4.2026.03.10.16.52.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2026 16:52:32 -0700 (PDT)
Message-ID: <cefeab1b-3e14-4732-a268-1bc99dc310b8@linaro.org>
Date: Wed, 11 Mar 2026 00:52:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/16] tests/tcg: Disable prot-none test on GitLab
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20260310232045.58440-1-philmd@linaro.org>
 <20260310232045.58440-3-philmd@linaro.org>
 <22332fe2-fd47-4493-b7d8-7ce3b3badc4c@linaro.org>
In-Reply-To: <22332fe2-fd47-4493-b7d8-7ce3b3badc4c@linaro.org>
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

On 11/3/26 00:37, Philippe Mathieu-Daudé wrote:
> On 11/3/26 00:20, Philippe Mathieu-Daudé wrote:
>> When adding gdb-multiarch on our container images, we
>> see the prot-none tests to pass on GitHub but fail on
>> GitLab. Disable and track:
>> https://gitlab.com/qemu-project/qemu/-/issues/3329
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   tests/tcg/multiarch/Makefile.target | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/ 
>> multiarch/Makefile.target
>> index 73c2a78215c..70e2ac38f5a 100644
>> --- a/tests/tcg/multiarch/Makefile.target
>> +++ b/tests/tcg/multiarch/Makefile.target
>> @@ -117,12 +117,17 @@ run-gdbstub-registers: sha512
>>           --bin $< --test $(MULTIARCH_SRC)/gdbstub/registers.py, \
>>       checking register enumeration)
>> +# The prot-none test was skipped on gitlab due to missing gdb-multiarch,
>> +# however it seems to have bitrotten. Disable, it is tracked as
>> +# https://gitlab.com/qemu-project/qemu/-/issues/3329
>> +ifneq ($(GITLAB_CI),)
>>   run-gdbstub-prot-none: prot-none
>>       $(call run-test, $@, env PROT_NONE_PY=1 $(GDB_SCRIPT) \
>>           --gdb $(GDB) \
>>           --qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
>>           --bin $< --test $(MULTIARCH_SRC)/gdbstub/prot-none.py, \
>>       accessing PROT_NONE memory)
> 
> Makefile is harder than meson, I had forgotten about it =)
> 
> To be squashed:
> 
> -- >8 --
> diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/ 
> Makefile.target
> index 23377f7a4e3..b05bde23df0 100644
> --- a/tests/tcg/multiarch/Makefile.target
> +++ b/tests/tcg/multiarch/Makefile.target
> @@ -120,8 +120,10 @@ run-gdbstub-registers: sha512
>   # The prot-none test was skipped on gitlab due to missing gdb-multiarch,
>   # however it seems to have bitrotten. Disable, it is tracked as
>   # https://gitlab.com/qemu-project/qemu/-/issues/3329
> -ifneq ($(GITLAB_CI),)
>   run-gdbstub-prot-none: prot-none
> +ifeq ($(GITLAB_CI),)
> -ifneq ($(GITLAB_CI),)

This correctly log:

   SKIPPED prot-none on arm because Broken on GitLab

https://gitlab.com/philmd/qemu/-/jobs/13441410520#L3358

> +       $(call skip-test, $<, "Broken on GitLab")
> +else
>          $(call run-test, $@, env PROT_NONE_PY=1 $(GDB_SCRIPT) \
>                  --gdb $(GDB) \
>                  --qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
> ---
> 
>> +endif
>>   run-gdbstub-catch-syscalls: catch-syscalls
>>       $(call run-test, $@, $(GDB_SCRIPT) \
> 


