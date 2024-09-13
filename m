Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9D7FA3754
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 13:34:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp6RZ-0005Hl-QZ; Fri, 13 Sep 2024 09:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp6RU-0005C4-WD
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 09:34:33 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp6RT-00052y-9S
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 09:34:32 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a8a7903cb7dso53886266b.3
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 06:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726234470; x=1726839270; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pmhe3bI8QFmgeyNcHimuA3oh+IslcFwJqvMvAP71Ovg=;
 b=FPcAcDdWSVSc/sidhMLGGrJm82C4bk1Dc+1ufWEe1WkMtl0pdtnb68wtpdaYT3If5D
 6Jw3G0wWOm1EDQqiEzU5mkC7QBMPgwOt7enTRk6G0Eo7PWHd9BN+uWa/+uVSEaQj0O7D
 hufWVGYzKNOCxurucCjoTGzEJfORKrBc5s2BrupEeYRyruf2/luNUSwjIdnDsXr5sL4m
 wabLf8Mrlugn6GhHTY4KkkXQa/bBu4svRza0WpZzsqwM+SMzcUW8rrt3Ca6VX9ZAJ3sS
 6gsLSUVQ1rJKNeSmaRnkoV6t81g6+p11FPQsGa5XrRYxHFTFq4PL8ytnBF9bkNK6AsA7
 51Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726234470; x=1726839270;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pmhe3bI8QFmgeyNcHimuA3oh+IslcFwJqvMvAP71Ovg=;
 b=euJyIHxzYvHWSxEqJynEHZHTCnS+KHOjLT95UjejoDZQ8YRxOesasqNbwFi7owqp2n
 uroTrl7u9vqo/INMPJFxo2z/l40GGWGVxiazYUgoBZA0rrhDKCj3QTpL/8nKqCxs5l3M
 WRDy7E6BGIyg17Vq2ebvXn1ugL01wxSMBajXW3eupn9qk4QCAfTZm11k8SD8adINCzCI
 4rHZuoXdU0XMVi8oU2Dc6mUFbrSEK+CSCck9l8bFsbNCJOiRRhtlmmhSYTSrWn8j0o6X
 dvaLb0r4BVdcWerlmDuPs5rKZSO8hV8IhqZSM/bJqZVAn49zHJMVOAx8UxxRyUxDVCZK
 ROIg==
X-Gm-Message-State: AOJu0YwdLZhbhjn7uLzcgt/TlkhK587TiLqXTtMrqbH8CuJiBD2hmkwY
 tgc8AGRSDwObYk4wV2XckC9cUCi6FX4Hq6rxCZ6ruA2E4R6NoMlBbl1mbXUr/zydxZBW57HG/Dw
 pRLrbiXDPu0xZxUuUOwQwl+jhIs4eHoO3cz9t0JxaRWOZyc7n
X-Google-Smtp-Source: AGHT+IF21PDvA3gGDYUb/F28TfrL73qkWBU7Y6EDA4lk1AKKsGLUkWQ5IYVl4SS8wK0sCIV9GEmAbr9gn4EPyMba4i0=
X-Received: by 2002:a05:6402:5d3:b0:5c3:c530:e99a with SMTP id
 4fb4d7f45d1cf-5c41e1930c7mr3289275a12.15.1726234469613; Fri, 13 Sep 2024
 06:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240912125132.268802-1-gaosong@loongson.cn>
In-Reply-To: <20240912125132.268802-1-gaosong@loongson.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Sep 2024 14:34:18 +0100
Message-ID: <CAFEAcA8OVt1+VH8JAio9uHHkxuT6f58+g3By3KjeDu0HRLTC2Q@mail.gmail.com>
Subject: Re: [PULL 0/7] loongarch-to-apply queue
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x632.google.com
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

On Thu, 12 Sept 2024 at 14:09, Song Gao <gaosong@loongson.cn> wrote:
>
> The following changes since commit 4b7ea33074450bc6148c8e1545d78f179e64adb4:
>
>   Merge tag 'pull-request-2024-09-11' of https://gitlab.com/thuth/qemu into staging (2024-09-11 19:28:23 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20240912
>
> for you to fetch changes up to 45d1fe46e5a6fe2b22b034e2b2bc0d941acd4b9e:
>
>   hw/loongarch: Add acpi SPCR table support (2024-09-12 20:57:54 +0800)
>
> ----------------------------------------------------------------
> pull-loongarch-20240912
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

