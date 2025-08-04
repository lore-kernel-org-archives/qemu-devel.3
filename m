Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B21DC87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 18:18:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uizl4-0006Ff-Fc; Mon, 04 Aug 2025 14:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uiy8H-0006Ut-8R
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 12:33:54 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uiy8B-0004Fi-Gv
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 12:33:50 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-76c18568e5eso305027b3a.1
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 09:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754325226; x=1754930026; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NplfqzSq6BSIdF30eaVRfkDHWiEc+GlcOceHc23ZxuA=;
 b=RUcOeSYYYJsTOhnZxTBpdjNw1qdbEzK92hHaahwPin3uv4HFZNiIckKjxqR2Eh8PiY
 izY1PF3ap5UfcEE36wFXw2wRxSk75MokbgxkfDNAnkQVZJT7Jvuf/5YQgr1hovFRbgtA
 NFTgwVD0JsaC72ZI08Lohc6XrQZm6R5bqC1zY3qCu4GMFsa6rk233mGoUfMvRMDOH/gl
 ipNpyr5UbAYx7hLycps/IalwHR8RWExU/w4MeJrMRUCHxqGC1wcn5f+KQ7CXfz40QGR+
 N/goBDcZmgzwq31R0PFPK1YbVVLBISca+ZgGlkE+zieT9aPm7tKeXU0/MngxuvISOwap
 Kq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754325226; x=1754930026;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NplfqzSq6BSIdF30eaVRfkDHWiEc+GlcOceHc23ZxuA=;
 b=KqiV5ksjOX8P/QDKDr+9P4ndILwIOGh/we+hBQHszS1xk1yjLMjpeaNKkPAymv03fH
 4hbwI+etPgMw7Kz/feEO9dC4/o6sDejEvvfr0+NW0CYfN13SGWf2gdz4Xww2w2sGbBdf
 OaVH6kpuc/+Y27Bw1xw9XBoW1QxNwz0T3ZT1hEphgXs1/HQqixklAOspjZCAWN8fXhO6
 rKzl3WZFyhd57yfaVL73IGLr5PfAupZl4Z0dL7ta1q5WRFiWUTmPw3mjR2lSZGD4R6vT
 8uhxhTcEoAtVfoJHZwSwwLwqxkzs/YEwLnQOSbMEoCa9UO9iTmKgfsLip2Di8i7QhbF8
 C8kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXs74dMYLVavtjBQTX/See6xs7sCtJgSCF7qqyDyJKubB+zwcB7ETwbTScuLpCds+bSWah5wkeEy7QP@nongnu.org
X-Gm-Message-State: AOJu0YxqImRYYOwIiX9bebXVSQoyX7bRQvY6mR2FxKqFsCHjjbSVkM+x
 SrydKtvzrP7Upj4jd1TZApwjZaBcB9evi+9OYNQgHxaS0KzRsCLWWlZ3lfer2ESWPR4=
X-Gm-Gg: ASbGncstt1e6MzY4sNxzDOU9XbElwogM4HoLxD+/qMcuw73maN3w3qCJj7UYfkyifBE
 RCjc4EJmIB7CBhLkiKgzUboa06c5y0XgoAcJCPB/4Ry2sP9FCpqKiqXvUiIlBbSbGAxarL9MaPj
 Ytg6D4Dpg8quSxrciLKb15d1P2+JiKGKA/CxzW2A2BFnMrXacoIo3uE4K+BzRya8zxISig2Yn2t
 oXEus2IPAmPxc6qBbqunyvuOIUWvlb6898eKd4q26PsF5uS1aZ97GkFMKen1ZxBzRzHvY91rxmt
 XQ/iOrYejKV/4B9Nq7YPAwcGmQlyi7bl0gCkBi6yrK81311O+MPGd7ZrI/CBIgOc/Qo313fREuC
 3Vg7DimtyCNXwkpWNthURNjY1OP1/c4PESXM=
X-Google-Smtp-Source: AGHT+IEorxrCHHTdXY8qTxK+1WxRBaDrIn91gd/Zg4gL1wMO35PBi1de3nGcG5OOfRUHjvnQh5niwA==
X-Received: by 2002:a05:6a20:1596:b0:233:3036:6fae with SMTP id
 adf61e73a8af0-23df9082f78mr15693407637.27.1754325226127; 
 Mon, 04 Aug 2025 09:33:46 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f63da602asm14807713a91.2.2025.08.04.09.33.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 09:33:45 -0700 (PDT)
Message-ID: <0b632b70-c79e-40c6-badd-50a4b3f61d53@linaro.org>
Date: Mon, 4 Aug 2025 09:33:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] meson: Add wasm64 support to the --cpu flag
Content-Language: en-US
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <cover.1754310749.git.ktokunaga.mail@gmail.com>
 <ac10a681d44665df56bf7f35660719b29654119d.1754310749.git.ktokunaga.mail@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <ac10a681d44665df56bf7f35660719b29654119d.1754310749.git.ktokunaga.mail@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

On 8/4/25 5:57 AM, Kohei Tokunaga wrote:
> wasm64 target enables 64bit pointers using Emscripten's -sMEMORY64=1
> flag[1]. This enables QEMU to run 64bit guests.
> 
> Although the configure script uses "uname -m" as the fallback value when
> "cpu" is empty, this can't be used for Emscripten which targets to Wasm.
> So, in wasm build, this commit fixes configure to require --cpu flag to be
> explicitly specified by the user.
> 
> [1] https://emscripten.org/docs/tools_reference/settings_reference.html#memory64
> 
> Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> ---
>   configure   | 6 +++++-
>   meson.build | 4 ++--
>   2 files changed, 7 insertions(+), 3 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


