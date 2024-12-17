Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17BEBE77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 15:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNZK0-0002VL-I3; Tue, 17 Dec 2024 10:17:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNZJy-0002Uz-Ga
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 10:17:14 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNZJv-0003qT-Sw
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 10:17:13 -0500
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-71e287897ceso3567471a34.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 07:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734448630; x=1735053430; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uuFn9hApZFPfN1Devut5zdupFenLSDgfUMfN1rpJQwk=;
 b=PvzLZ1+IC53vdeXurWkvxKbAV0MYFII0Bk9SHuvNEZA85fTDg2u/Dzy2hMw9hUJi3z
 E3wsCY2Ij+VOzFJyZXtPy2fcw+YZbUERTX8zxqU8uwkX0Il8CeMVEMilIYfLCS96zWgD
 iSxM0ACrQhmXVvWoTUfO0pXTNzX0yNho/ejv3Z7tZBugnA/CyFZEJSh8xd+ooj1iLy2h
 MtkzAhqrEOmePntWT1/rgShSmAKi2SemWjKqXJYDgiu1Nu3Duv/ZwZ7VzbsdLHf0uynw
 4eqmEfUOtPtK6tdpofcPmUyIsWzlfGQHiL++/VCJH6GzYEgm/vcqUvJHfTVP7MVqmWv2
 QIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734448630; x=1735053430;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uuFn9hApZFPfN1Devut5zdupFenLSDgfUMfN1rpJQwk=;
 b=TDU+DgkqzETfsZw5b82JHQauHly42BLxnUdA5Q48aSlatwF6YGBFNvYPqcQa4XZ0+Z
 CN7iV2UUDQ1wNkwFyoIKTwkRkO7xUfqmCjjWCWUg3smf8Yez2cb5Md/Jpw4FxUX+GQug
 ryU31kLfKe6rWk/yjpa+B2wrPDPZ1O+g/j5jMZ22BdoVC07qjQfBxAaj6mWiliJbCeXc
 DwRkV2UtVG0rbYHzkD6JztuEqnQZJ+RQ0zm0ZnOxJcs/wdxN4gZQOKhs8RI73bxUdbVP
 q3fgJ+HysfwSKJaZ9vw8uUgGq0pGzTT2DWjFOnFTWiOnyng6J7p4Xh7RmeEorqWQwOdt
 lhZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXh/zJiZ1LLF/wYZp+n9JChb4g+L7iPdBcENqT+f/h8f8C71pIofAfNKjUc28YuDhjeeGfZMmWy4ADg@nongnu.org
X-Gm-Message-State: AOJu0YxxPxmtYAEmdlr2VQjfgsP3egzVucGf4LNki97og2Xdicr1K6sS
 tKgmKGah4R8E3biRCERoYzR5w4MvmqP/uEDDlQqK//P/k7WkNVdsFyAUVeq8VgY=
X-Gm-Gg: ASbGncvDBmUJZ5CSGg8UjmAZcMc+PAFC2RoPL6DIEzTyAYuK/mzXYbTHTNmqQNmcSZJ
 G73ddG2rotgzwa6YEKDZSuee+qwwM1LOYJ6qs7TuOygN71ZWvRNsZfL3u7kts7D9GI72KgCscsd
 XOsiOJbc/B1LS8VIPSKWp9rJcHtlTHcrYiDgZg/yeRKofWNo1LpZOEYzXfX7dHuZzpv7xg3nNQl
 YYYyOFiSofzUedlvYhTNa/tSYcDSM/Hk9TYYa2eQFb2TZK0xcORqCCCvqciDNWoZX/kz7CzSA==
X-Google-Smtp-Source: AGHT+IHgbgKDwj+Syt9Y6IgnHHdCEBjizcH+X/VLdsnHjY8iSGyI5q5OtEdSR2hpNC6XzWRiRrrHfw==
X-Received: by 2002:a05:6830:3890:b0:713:ce15:d4d3 with SMTP id
 46e09a7af769-71e3b8d826amr8744650a34.1.1734448630071; 
 Tue, 17 Dec 2024 07:17:10 -0800 (PST)
Received: from [172.20.0.130] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4836fbd8sm2031222a34.35.2024.12.17.07.17.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 07:17:09 -0800 (PST)
Message-ID: <924121e8-7536-4212-b178-95d98b64d2f5@linaro.org>
Date: Tue, 17 Dec 2024 09:17:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] tests/tcg/plugins/insn: remove unused callback
 parameter
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 philmd@linaro.org
References: <20241217010707.2557258-1-pierrick.bouvier@linaro.org>
 <20241217010707.2557258-4-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241217010707.2557258-4-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
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

On 12/16/24 19:06, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   tests/tcg/plugins/insn.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/tests/tcg/plugins/insn.c b/tests/tcg/plugins/insn.c
> index baf2d07205d..0c723cb9ed8 100644
> --- a/tests/tcg/plugins/insn.c
> +++ b/tests/tcg/plugins/insn.c
> @@ -150,10 +150,8 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>               qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
>                   insn, QEMU_PLUGIN_INLINE_ADD_U64, insn_count, 1);
>           } else {
> -            uint64_t vaddr = qemu_plugin_insn_vaddr(insn);
>               qemu_plugin_register_vcpu_insn_exec_cb(
> -                insn, vcpu_insn_exec_before, QEMU_PLUGIN_CB_NO_REGS,
> -                GUINT_TO_POINTER(vaddr));
> +                insn, vcpu_insn_exec_before, QEMU_PLUGIN_CB_NO_REGS, NULL);
>           }
>   
>           if (do_size) {


