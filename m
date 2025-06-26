Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 951C4C7EE31
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 18:24:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUrFf-0002xm-Dw; Thu, 26 Jun 2025 14:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uUrFd-0002xU-IM
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 14:23:09 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uUrFb-0000W4-EY
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 14:23:09 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-313bb9b2f5bso1503082a91.3
 for <qemu-devel@nongnu.org>; Thu, 26 Jun 2025 11:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750962185; x=1751566985; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Wq5pu/GRz4Z5nVAeOru2uq9wwPu3hY1UcDyYgEYFKj0=;
 b=Y7A31/zJWM4C94HuNehaZsRv4R/TjHcB0T8SIdZPLyIeany7lf/xEwHXtQiQmFObh3
 dXBd/BviD0PAAthIBJvBgRLGNHF5gJoJoUBTlae2amfwPpYe15BXR8Z3ouRxC5/hZZRI
 9NXQ+wWHk7fuzvVfDbsh/zWqJXN+P44y1WdycqPrwyd3EeknvhdRTxzx00FznIY2N8BT
 UZrbELEVYQ16/GFdUnwppLPLn1ippum3kNuyppzPQMmPv//144yo8AFuslV7tnBS6nRl
 rIrSpafYbW6v0cQacNlvQqshZc9rsb3R3P+Tq7GUkCZ8ezlsgXP6S9pvbxT5IHUKKx9g
 aFOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750962185; x=1751566985;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wq5pu/GRz4Z5nVAeOru2uq9wwPu3hY1UcDyYgEYFKj0=;
 b=KeTU8V+0tfYkMnZG+Q7fDQfWoxX/mzpSCqDnhjplvlKOW1N+NNoaGLNzdRI+wD8F+T
 nFl78warZNY7d9+607acWrVi5OmYignNiuUEKP3OLwBLuT3SsEz0rn+4p0CTlAGacLLZ
 kF1vh+NJCSpZZN/4iddJjCeGSVWjq5j7wuiz9x7FuvF7yD/PqWzJ6/RXJhidkj2AVTwk
 cDKH+noc1CKC35dl83fhzg/DBNt8Z4PZaUi2nEowv1Q/N9CnurC3O7+0hgEhdy9R/i5m
 mulNlqMIDg3LEKngTVaiClS+4N8TPRh1XjZgUy0eC5FVLyad+CNM4OUJNfpeXNQLZY17
 HAEA==
X-Gm-Message-State: AOJu0YyaLEHUj9Lqedq2jvNbZHs/O4Oj/RJrxW0nFlGZE6s7k4JcGNGm
 SnA/zmFmG+1n17bucHV+WmnitdibOAtdj4Sp2C5WgRVFNT5DvAtrol7G5Yjr6qvEV20=
X-Gm-Gg: ASbGnctWkGl8u0ETPUXbD3w6aKE2rBJXPl0DcSvjYC1FqOrsdf57xkzKfMRWobEFJE6
 tjek/UjsmlUMEssb6UXGdEnMrbYupzcdvpi2+2k64H8Yr2YSrCSqHujNeDo4cb4g7dTnfHh6h8m
 oWLGGUzMhdn79rZI+kpnLJwJMIpBGCH9tOM7/OHS+YPTFyb2cbgiKH506Ghl0lth4DcVZE2bZrJ
 WX3R0d7XjtM7VBtfi9O9NmD4gTeIcg/zNBWG7gAAstM8tPQgMT1vQokhBZK5Hh9aS9l+AoyZSdA
 RF/mJspvIRLL8rDuUFPnksTOsuLyU1xI7ws2YaC/2IhP9nlL9h5qh7KZ7QooolFtncxhSrOqXAY
 =
X-Google-Smtp-Source: AGHT+IFqAye0oYvWI20M1Tar6f8aqJrPwveFe2IpwEuT2QUx4YvcNFefSoJDJO9PfMvc8K+NnQ6L3Q==
X-Received: by 2002:a17:90b:4ad0:b0:308:7270:d6ea with SMTP id
 98e67ed59e1d1-318c9322912mr42534a91.30.1750962184619; 
 Thu, 26 Jun 2025 11:23:04 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-315f5384140sm5167359a91.7.2025.06.26.11.23.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Jun 2025 11:23:04 -0700 (PDT)
Message-ID: <5606f27e-48c1-40fa-9453-f76f87fecd2e@linaro.org>
Date: Thu, 26 Jun 2025 11:23:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 0/8] Add additional plugin API functions to read and
 write memory and registers
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Rowan Hart <rowanbhart@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250624175351.440780-1-rowanbhart@gmail.com>
 <87o6ubzxfw.fsf@draig.linaro.org> <87cyaqzcft.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87cyaqzcft.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1032.google.com
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

On 6/26/25 9:37 AM, Alex Bennée wrote:
> Alex Bennée <alex.bennee@linaro.org> writes:
> 
>> Rowan Hart <rowanbhart@gmail.com> writes:
>>
>>> This patch series adds several new API functions focused on enabling use
>>> cases around reading and writing guest memory from QEMU plugins. To support
>>> these new APIs, some utility functionality around retrieving information about
>>> address spaces is added as well.
>>
>> Queued to plugins/next, thanks.
> 
> So this fails a number of the CI tests, mostly due to 32 bit issues:
> 
>    https://gitlab.com/stsquad/qemu/-/pipelines/1890883927/failures
> 
> The tci failure is easy enough:
> 
> --8<---------------cut here---------------start------------->8---
> modified   tests/tcg/x86_64/Makefile.softmmu-target
> @@ -34,9 +34,11 @@ memory: CFLAGS+=-DCHECK_UNALIGNED=1
>   # Running
>   QEMU_OPTS+=-device isa-debugcon,chardev=output -device isa-debug-exit,iobase=0xf4,iosize=0x4 -kernel
>   
> +ifeq ($(CONFIG_PLUGIN),y)
>   run-plugin-patch-target-with-libpatch.so:		\
>   	PLUGIN_ARGS=$(COMMA)target=ffc0$(COMMA)patch=9090$(COMMA)use_hwaddr=true
>   run-plugin-patch-target-with-libpatch.so:		\
>   	CHECK_PLUGIN_OUTPUT_COMMAND=$(X64_SYSTEM_SRC)/validate-patch.py $@.out
>   run-plugin-patch-target-with-libpatch.so: patch-target libpatch.so
>   EXTRA_RUNS+=run-plugin-patch-target-with-libpatch.so
> +endif
> --8<---------------cut here---------------end--------------->8---
> 
> The other problem is trying to stuff a uint64_t into a void * on 32 bit.
> We did disable plugins for 32 bit but then reverted because we were able
> to fixup the cases:
> 
>   cf2a78cbbb (deprecation: don't enable TCG plugins by default on 32 bit hosts)
>   db7a06ade1 (configure: reenable plugins by default for 32-bit hosts)
> 
> So I don't what is easier:
> 
>   - re-deprecate for 32 bit systems
>   - only build libpatch on 64 bit systems
>   - fix libpatch to handle being built on 32 bit systems
> 

More context:
../tests/tcg/plugins/patch.c: In function ‘patch_hwaddr’:
../tests/tcg/plugins/patch.c:50:21: error: cast from pointer to integer 
of different size [-Werror=pointer-to-int-cast]
    50 |     uint64_t addr = (uint64_t)userdata;
       |                     ^
../tests/tcg/plugins/patch.c: In function ‘patch_vaddr’:
../tests/tcg/plugins/patch.c:93:21: error: cast from pointer to integer 
of different size [-Werror=pointer-to-int-cast]
    93 |     uint64_t addr = (uint64_t)userdata;
       |                     ^
../tests/tcg/plugins/patch.c: In function ‘vcpu_tb_trans_cb’:
../tests/tcg/plugins/patch.c:159:54: error: cast to pointer from integer 
of different size [-Werror=int-to-pointer-cast]
   159 |                                                      (void *)addr);
       |                                                      ^
../tests/tcg/plugins/patch.c:163:54: error: cast to pointer from integer 
of different size [-Werror=int-to-pointer-cast]
   163 |                                                      (void *)addr);
       |

Since we disabled 64 bit targets on 32 bit hosts, and that data passed 
by pointers concern addresses, it should be safe to cast values to 
(uintptr_t) instead of (uint64_t).

Pierrick

