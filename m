Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7704DC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 07:55:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUixG-0005Pr-33; Tue, 30 Jan 2024 02:54:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUix2-0005OT-Ly
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 02:54:39 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUiwz-0006FZ-3A
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 02:54:35 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a349ed467d9so406806566b.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 23:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706601271; x=1707206071; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+KIk+J9ruVZU9dzzhzq5WHwQ64984mrf0dH8TPlLqt0=;
 b=oyFyNIABPDXhqhHfisCZfJTb0R4lcc3rMBVfpEg/nsi1+b7AtkaFU0OxZ/AgzskBAj
 +5wAwuAU4enGRTfnCimUTkmdPdQkbcOPlt8RFRfe8P0kP9DM3sz9ZGhYF0DE2v+AwHYV
 pg+vIxNUApx1Rled7eE6AxFO/ddVTI4zi749Irz491WY808Eu7yJktRz87WFUkxnK1k/
 G6Fsws64fom73eY6vs93i7fpuGe7shgj7wj24rgXnjRNd0LqjHMJLkrcV9502F3TkLXj
 HMrWcUmVXhViRYWo3ZaduP3YgkZEN4Gx29uuxBBSlbbJzDhaJUTSN+SBLWsRNb8Xh0AP
 AshA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706601271; x=1707206071;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+KIk+J9ruVZU9dzzhzq5WHwQ64984mrf0dH8TPlLqt0=;
 b=wK3qRPzjp9O+/F3B9An8QhERYEQK4meTmiqwLlBJ9/uiAzOp7ktGtvunb6TuMpe1zJ
 HM9wADLjLM8dlTR2cHX+rmWV7Lzzl+jip9el/zKYc5Fz/3hJv2uLU2Fi344RcOPUmxWk
 logx7w6QTyb974mLaPg2zfVcEEkIiE8zI0VBs6werO8iaTsXIUwhZnVJsvo/gnI27rAp
 NqAvlBE42fqtqtrLw/gU1QAY6sRWNPq/0o0TEbYUeSQ+LwZlwBX2RlIh7CRdMXRXNOcK
 WnwDlZ1du0y3L2jWgF/oww7e/dj7sXGdVBKXuWqokwCgqeGPtjLTTVBY/uV9nJ3E6Qql
 AYWw==
X-Gm-Message-State: AOJu0YwvlntJuiVROafOgrI7x+zg6bqLzFfSXSEFfmLPK5EpWpMAgBZC
 aDp1uIg5tntWX/OUu9pm/0EWWmbSt/87zpB0A7LGlcbGkCWGkHmshfdxdv9fVaQ=
X-Google-Smtp-Source: AGHT+IFqLs60S+QtykzaLXVB1/i3rGvRppvzUFVU3D3gcXsMt1gMk1a6/Hh/X6DuWD5saGZbV09D4A==
X-Received: by 2002:a17:906:179b:b0:a35:51b1:c757 with SMTP id
 t27-20020a170906179b00b00a3551b1c757mr5380610eje.38.1706601271637; 
 Mon, 29 Jan 2024 23:54:31 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.134])
 by smtp.gmail.com with ESMTPSA id
 bq26-20020a170906d0da00b00a3618de97efsm526540ejb.2.2024.01.29.23.54.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jan 2024 23:54:31 -0800 (PST)
Message-ID: <607f3c7b-c444-482c-8f23-01fdfc2300fe@linaro.org>
Date: Tue, 30 Jan 2024 08:54:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/22] target/sparc: Remove gen_dest_fpr_F
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
References: <20231103173841.33651-1-richard.henderson@linaro.org>
 <20231103173841.33651-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231103173841.33651-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/11/23 18:38, Richard Henderson wrote:
> Replace with tcg_temp_new_i32.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/translate.c | 17 ++++++-----------
>   1 file changed, 6 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


