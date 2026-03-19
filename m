Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A03411091927
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 22:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3LQN-0004Sm-Fh; Thu, 19 Mar 2026 18:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w3LQL-0004Se-VW
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 18:01:02 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w3LQK-0002y1-3F
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 18:01:01 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2b05fd1d147so6105825ad.2
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 15:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773957657; x=1774562457; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s9ks0mHqs2VFevTJ6NxshM5OsY+W2JRX/0bJQrlPOnw=;
 b=vOlj5wNpnFERYCDJzCGiVgdGDWy+lM2aWW0nyNW9yXv72Y/dHCKTzBoJ6l1tBwMFm0
 2/LOO1h7QhWMgzvP1w0juxIMP5I8bxO3wUdExXL+p3yqPzJ+tkviT3Q/kYwFwJzASjl+
 6kV0TnDi359tO2nQNk2cvS+npCNcizktbPYenJxehIMc7+y/9vO6+DPGMC1ktret7Zs5
 F+CjquT8ALuQ1z+7uequXPAyTgSPAugOfQNgi/gMKjqQRSsE0jPQjFwagIhkYjWNHPvj
 +1SQcucidrFjqiq+jZHpNz84MsfnDOlt4+Y9BE+//0Iu7jTQquEwSCDu3pla1tzjIwJo
 jMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773957657; x=1774562457;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s9ks0mHqs2VFevTJ6NxshM5OsY+W2JRX/0bJQrlPOnw=;
 b=sOFP7mG0XKaGW1lcEZz2fjV1GxFjZDPWFaaF3CYQE0BgRWvCc0kKQTRzwg6UpDmtJr
 yj4iw8h3+kMv9QuZSuaZ1QOJ7MlzUoPOMNI7pe5HBmvJZu3hykeID6x7LB/sLeFt0Q2U
 V9avdOi2qSb4tnZufnHe/Q7CFKuORfO2Fsg8aVLemuZ8DM99SMXb2C/0kxsb+WuEBN4S
 ia2NoCNoab6914j5H45mElMMGAL5qo1ZOnLg0LXAzbvbdQtqLyq4H6gcjRKB0ZIdzQJe
 RUTeHk6n9PCoOPYDMa4P1sjFc0UUQxUNJAb/Vi82nM8m6YyGYWTsvJ/UJWMiX7eqeHb7
 fPJQ==
X-Gm-Message-State: AOJu0Yx4HwUaNb17tGhy+zvEK64FK7p9GeXZle0CIiMBlMH5zxRXZjlI
 vsOmuRVCNYfkxkno0XA2dLk/RFF0EJtR95u9tqyBAS4tON0f7l5q+yh6jALdHuTo4y4AerTmAm9
 gpJdjtKE=
X-Gm-Gg: ATEYQzxEWTg3ZPd8U+aL+igXgzpvVWyYLQiHYTriq8HbWmdak4SD3XOb3UDUN0J7I11
 safw5+7B62VmFy9ceKUWoMZw791UsdxeHLF9jLEvln1ENj7o0biNIlb8JFBUirZ8l6Sku/+XpQS
 fr4+l6476/4ENE/JS2Ao6jUVHXjQNky0Ef5IpaHCuIX60VJWbYEUS8o7VTElrLbnKmBmO96bSwL
 zoNlZdN3C6ZozfeaXjRCgPQXvvIxj3V0SiWuK0jc733u1vbW1ZKOuAmSRd9bC26hIBKwCqfyqmB
 zC5XC6MkGuDIEuQPDK1fEMTnXZTnzVAYgNy5mTqJjZOYKTdjxXsD7suR266NtNp1iN9ONUOVbYN
 NOwOYozzW9RqLPijoGaGD5l+ewZDRBUWMUi/v9XN4WD+Gjto0njXiKfs9pQvv+Zc9Yu+hy91Dzm
 97IWGmqRxiPJwTBf8lWCNjVJhyww91KhT1m+w=
X-Received: by 2002:a17:902:eccb:b0:2ae:4d23:3364 with SMTP id
 d9443c01a7336-2b0827d6452mr5208515ad.52.1773957657034; 
 Thu, 19 Mar 2026 15:00:57 -0700 (PDT)
Received: from [10.5.0.209] ([114.23.167.13]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0836b8b95sm1807935ad.83.2026.03.19.15.00.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 15:00:56 -0700 (PDT)
Message-ID: <01f71a9e-0ade-4125-b1bb-c2ba1439c2a8@linaro.org>
Date: Fri, 20 Mar 2026 11:00:52 +1300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] target/arm/emulate: add ISV=0 emulation library
 with load/store immediate
To: qemu-devel@nongnu.org
References: <20260315034123.41921-1-lucaaamaral@gmail.com>
 <20260316025034.85611-1-lucaaamaral@gmail.com>
 <20260316025034.85611-2-lucaaamaral@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260316025034.85611-2-lucaaamaral@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 3/16/26 15:50, Lucas Amaral wrote:
> +typedef struct {
> +    CPUState *cpu;
> +    CPUARMState *env;
> +    ArmEmulResult result;
> +} DisasContext;
...
> +ArmEmulResult arm_emul_insn(CPUArchState *env, uint32_t insn)
> +{
> +    DisasContext ctx = {
> +        .cpu = env_cpu(env),
> +        .env = env,

The env_cpu function is trivial pointer arithmetic.
Put the one that's used more into DisasContext and use env_cpu or cpu_env inline to get to 
the other.

> diff --git a/target/arm/emulate/meson.build b/target/arm/emulate/meson.build
> new file mode 100644
> index 00000000..c0b38dd1
> --- /dev/null
> +++ b/target/arm/emulate/meson.build
> @@ -0,0 +1,6 @@
> +gen_a64_ldst = decodetree.process('a64-ldst.decode',
> +    extra_args: ['--static-decode=decode_a64_ldst'])
> +
> +arm_common_system_ss.add(when: 'TARGET_AARCH64', if_true: [
> +    gen_a64_ldst, files('arm_emulate.c')
> +])

Do we really want to include this emulation when the host virtualization won't use it?
I'm sure Kconfig can be used to select it from the relevant virt configs.


r~

