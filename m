Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E858E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 15:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNZQ4-0006zg-7D; Tue, 17 Dec 2024 10:23:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNZQ2-0006zT-HK
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 10:23:30 -0500
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNZPx-0004ga-V4
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 10:23:30 -0500
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6d8fd060e27so44765226d6.1
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 07:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734449004; x=1735053804; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S8n/b40YqN8YOJUL/vNnP/8gd8jY2MrA/ZCcqfJu+EQ=;
 b=BCuG13As7HDeaPP/+HbkY+8PRTs+OSQ5gGGmAf4cJHSjX0TwQ5p5xDM4LMouWoU9Ss
 5g5Mh6LP0O2z2VDD3lJ3diL+3Omm9c3SM+T/Q4reYlGyya9acLaWsyKwO80vrTHxUPXC
 lbDRb5uSrXqs4P1D3vFzF9EwzcOBXvi4cqCxjDrjCgoO/z2NxMNpimOZ/rs7SKsRkubk
 WXcDraqBobGyl5USsrikbOrvfRLB87Fb2HhNUsAsQs0ku3xoP5GsA8QBfwJd2hvfPvw3
 GuhkHfwpEUPk5YMVgTCJvqJrYU51v2KtzLKKUMJp+hwBAfFG6oN7YVn0ptmvLIiZSGPG
 jsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734449004; x=1735053804;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S8n/b40YqN8YOJUL/vNnP/8gd8jY2MrA/ZCcqfJu+EQ=;
 b=WzrfpT9cKOBMnx0xUbfeF5exmONwZUEtDqb1vUq11G8qLC0rOTsWPoAWdK+K6MOufX
 agsQZMB8wN/zRTD0rZe7efFeiQ57lAPq4BJjzQELO9srGKMqJswnbselmNntWePQMlI2
 aRraoh8YawqJ8uy6vnqK59hYuSS7QW5jY5C1ESayHh6sPpkqaEHoDHs6bAGlwbZIcmrs
 uEwiNzNKjonqSHTZB0/0Vt6rFeTJldl0IwUvvsRegHZe4fVShO4k3WgTsoA8EHqBlDeH
 G3yB5sWThnlg6UGiIyIuDE9bllGPEnu4ElcckDm2mx0g5hWR18vM1pIJ8ZVG2wSfwpId
 dAcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0Sw0fLqXoQ4UniJTEQbwoOrewYU1XpIFMMxiHiVf7eg3YpKW7JsQPU2PCT/iNb4R5OfE/R2dsk8P1@nongnu.org
X-Gm-Message-State: AOJu0Ywn1oHnt3iVYsPxELZ/KSSAu1mdpO3ZM/FADQzTyYLVyhXWUsLo
 HgobAfqS6e2hduqkagiP6DiaYW3ZrIhF/RVfjQy3q3q9yh+gjEzhR7OW+P5PFt8=
X-Gm-Gg: ASbGncsfQPn6L/kt8GssnW1XGPH8l9ivgmCZEN76/2YtrcqZVOUXppk02z8djagwhhs
 knJRgLhiKaxRAJjZ7OGUrhBok6fA9Vv75OVRhHvxO5zpPXdASWsPWfpJ5RXAqCn/29IujRDXWzx
 rditdv8qzLPw1Y/636IOY4RXnOhoeTGbsy683Xo46J4lRRYH63KPvLzEA5P67/beDbzTa/SqNzU
 I3V6kLAo4XyW1ghcN4GLj9p3b933M2/D7DcEtJ7I5vejJYFEyJcFwfkIt8u57aJuLuBXBX7Ag==
X-Google-Smtp-Source: AGHT+IFunO5uDHzKBFW35RDmWjypGrTsE0h533xgwbjv9A8vxGVNOpabFT5sFpVswOskfVm2Zj4p4g==
X-Received: by 2002:a05:6214:2a4c:b0:6d8:821d:7370 with SMTP id
 6a1803df08f44-6dc9698f0afmr251713366d6.49.1734449004491; 
 Tue, 17 Dec 2024 07:23:24 -0800 (PST)
Received: from [172.20.0.130] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dccd2570d7sm39502536d6.34.2024.12.17.07.23.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 07:23:24 -0800 (PST)
Message-ID: <6a5d4c63-72b9-47b1-a247-bc90ec0ffe43@linaro.org>
Date: Tue, 17 Dec 2024 09:23:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] tests/tcg/plugins/syscall: fix 32-bit build
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 philmd@linaro.org
References: <20241217010707.2557258-1-pierrick.bouvier@linaro.org>
 <20241217010707.2557258-6-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241217010707.2557258-6-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
>   tests/tcg/plugins/syscall.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
> index ff452178b18..47aad55fc1b 100644
> --- a/tests/tcg/plugins/syscall.c
> +++ b/tests/tcg/plugins/syscall.c
> @@ -76,12 +76,12 @@ static int64_t write_sysno = -1;
>   static SyscallStats *get_or_create_entry(int64_t num)
>   {
>       SyscallStats *entry =
> -        (SyscallStats *) g_hash_table_lookup(statistics, GINT_TO_POINTER(num));
> +        (SyscallStats *) g_hash_table_lookup(statistics, &num);
>   
>       if (!entry) {
>           entry = g_new0(SyscallStats, 1);
>           entry->num = num;
> -        g_hash_table_insert(statistics, GINT_TO_POINTER(num), (gpointer) entry);
> +        g_hash_table_insert(statistics, &entry->num, entry);
>       }
>   
>       return entry;
> @@ -232,7 +232,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>       }
>   
>       if (!do_print) {
> -        statistics = g_hash_table_new_full(NULL, g_direct_equal, NULL, g_free);
> +        statistics = g_hash_table_new_full(g_int64_hash, g_int64_equal, NULL, g_free);
>       }
>   
>       if (do_log_writes) {


