Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AEB6C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 17:16:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubMmf-0003Se-HH; Mon, 14 Jul 2025 13:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ubLdU-000627-Kf
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 12:02:39 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ubLdO-0008TC-Hk
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 12:02:36 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-74924255af4so3696683b3a.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 09:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752508949; x=1753113749; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c6hBEzz0STW5NCmqbjK9zA2B4WGBTRkoVY6Hl7kcho8=;
 b=PdvOXDUoDsetiDA7Ksx07OndrC6Nmu4NSGm+FikPNqUHdOCmIYrzfLA+ADqTYAq28L
 qEm2tJsDsUANgg1aC3W9OeTux9OJ/SvSX9AoLwzKGuYPeV7x1wc71TrtrWHenw2sRldA
 +HZvu7fco8CBQ7//LHEyMiMI2w6pwhgcRkL7zxLG1gIIayZbLBI7B977wB/UvvVz1lyY
 W2fattgO3LvNQ8//ciTeU+fneUubqJEhan0JurTictaNiGAGh9oeM79qdlUEURrsVjCU
 i9zzQd/KEKxJliSp0s/a0dLrZKvni2J/uHQTi8abvU5vgQjZ0JOCfeT77KMPzt3Q2QZA
 +IXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752508949; x=1753113749;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c6hBEzz0STW5NCmqbjK9zA2B4WGBTRkoVY6Hl7kcho8=;
 b=fn/RC3YvyLOLIsOzAMrAvuz8YgUSnwfCAPs9LXp0OQtMD7YKVieAD+6FgEyfcPgLpB
 Z4lQ0GjdFNQv43KIY4H+oeP3tVWmFA0JXDzxx0PFTNa+Gqm4AISBqNJSOCZC4qvYIUZ/
 ocRzvU6d0W0Bk1QZhX+sLlBahMlDbEnHb1X9gYC4J3GKgRTO4gUuacuCPYz8LgJaHbrp
 eYaEFWPKRZ6D6KFTVnarRcEdoEBi9qm1qfrflNUTagGA5bUeCfAfBnwdQbSgqu2EuLrz
 Qq3A5IhI6BZY0im4IfyLsQ6MQU8BzdSc2WxRjZgHAgpWxsa5WxnWauj29HvXL5AS/w+k
 ZdzQ==
X-Gm-Message-State: AOJu0Yw+F0M8jyfJgq9/Uh9sSc4+BsOT7URKkn9augsE7Lo10HjiZd8a
 PDhWWIKXXiblgAkHotyN7USovr7LKI9czAFP12e7EpyPng2iD1hpn6l1hTciyktQN/HuA64GxIZ
 9Q7afhqI=
X-Gm-Gg: ASbGnct9GBJhRj/4O+2wY7MjVAgnlofT8xmW+XX+mTe3L6zMXlPYIMoqkpvvWRKSomE
 6j1GL2GyyiZhnEsydL8H4A7qpqQYIFguF8iBZVJ55D+uWXURd+d35+o/tRVyNkMq7+wu6mDdwY6
 /mURa6dc0fEbPrNOZ0znbJtvFavhlvzBeRPonVtnG467NdG1adEpS+384Dmx1Hs7amtyLKEK+2Z
 euKc+r0C6vYrafonAY8KgiuEkViO0ewDCpTpJRZ4dY6F/0EaAfyyx6Vpjs/K1wXLYIm/RezDL0L
 pcKjPazqvPo4wdu3Wq4pULBYY+I+AXrl6uegxUak5USQqZLF+2KabtwVg+VY4zzjm8AzjAYQbHj
 opp1hChFBOPBu2tvEVnigB+XqtPzucMsoZ3PX4JQw1RD6aG36V3NFY31KuMNANfs=
X-Google-Smtp-Source: AGHT+IG0qjY1HWTEuPFK+leUoeL1jwAhvAI26QxBM4QH3t2GTcqLFSF4O6vodEIc1ukUoOxsqkvJ9w==
X-Received: by 2002:a05:6a20:734b:b0:232:6630:bca4 with SMTP id
 adf61e73a8af0-2326630bca7mr18598519637.15.1752508948596; 
 Mon, 14 Jul 2025 09:02:28 -0700 (PDT)
Received: from [10.113.99.227] ([172.56.179.167])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3bbe6f4fc8sm10495932a12.51.2025.07.14.09.02.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 09:02:28 -0700 (PDT)
Message-ID: <83ea06e7-aaea-45d3-b421-3bec31fb50a3@linaro.org>
Date: Mon, 14 Jul 2025 10:02:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] host-utils: Drop workaround for buggy Apple Clang
 __builtin_subcll()
To: qemu-devel@nongnu.org
References: <20250714145033.1908788-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250714145033.1908788-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 7/14/25 08:50, Peter Maydell wrote:
> In commit b0438861efe ("host-utils: Avoid using __builtin_subcll on
> buggy versions of Apple Clang") we added a workaround for a bug in
> Apple Clang 14 where its __builtin_subcll() implementation was wrong.
> This bug was only present in Apple Clang 14, not in upstream clang,
> and is not present in Apple Clang versions 15 and newer.
> 
> Since commit 4e035201 we have required at least Apple Clang 15, so we
> no longer build with the buggy versions.  We can therefore drop the
> workaround. This is effectively a revert of b0438861efe.
> 
> This should not be backported to stable branches, which may still
> need to support Apple Clang 14.
> 
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/3030
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   include/qemu/compiler.h   | 13 -------------
>   include/qemu/host-utils.h |  2 +-
>   2 files changed, 1 insertion(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Commit 4e035201 was in 9.2.0, but indeed there's no point in backporting to any stable branch.


r~

