Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F1FF01832
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 13:10:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyUwL-0002wK-Q2; Fri, 06 Mar 2026 08:10:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyUw7-0002uo-Ta
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 08:09:47 -0500
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyUw6-0000gW-4t
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 08:09:47 -0500
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-649278a69c5so7966279d50.3
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 05:09:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772802585; cv=none;
 d=google.com; s=arc-20240605;
 b=WRQfjCLxrZ6D66GRmeBAjQxHiGiL3qwTdMFc81V7k7rHUVPu0dXmAB4KyxaiyxYkSC
 m3+EEyVasbLu3TwPZM9LIQ4Co3H1U+pQq2tEbRx2yJmUemoFgUJmQO6ImExZMxOFa4Dd
 MbOnVpXduS4V1Qke4MYxjlcT4Pheav1s5pwEbqYeVnp0U9+U1aLxK+8xHsTqyj7LqGED
 DgGVJmEAytgLkQLuU+SupJcPQKsJWYUYTtlX81B43MmaqxvAkUBuoQkYB3qLEb0okn4r
 yA46PHzqOH6ENeHazgH47Ite1zVkcvnmumlFUqLKaBv2JuijzDD/nJUksi55N3iBTDu7
 6Oog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Swf1K3gZWqxMPuwFx8GjZ1bCIultsIOQVBWJg7tJVms=;
 fh=BAyh76Dt9lJjY3uGbG9gye4E4bNa4dvV51FFfKIqCkc=;
 b=e66nhWWhxW+bG0D0gA2WaReFuj35eRmu2XSwi0qSMt3njiuyg4++rZ7KWKmuYc7Tmw
 /oshWUTHAyWSefNEgk4PlA5QG3NsO3XbcJ5mbQADGjjA/jaLXcY3pqtjAQeDjgvbcGg5
 s+ehVHWhJa/TEcEsSbMQH+tD23EiyBb9nhQL6SZzLyoM4uQQcTLIZEfuQdDegJtYj30k
 hR3p5EqIQ92FyiYhyUfTcAz6nc3soe0cIXpEG3niTkvHUjGOXVJoXcF4gKdwnJYSPQV+
 hGJRAePMWxz5Hyq3OvVFWuA6tiEZtkZGL3nRHtJMHbVVMS7U/dZsQnwVyUV+3l5f3IPM
 LLxA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772802585; x=1773407385; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Swf1K3gZWqxMPuwFx8GjZ1bCIultsIOQVBWJg7tJVms=;
 b=RSKhnrGVeuWMinQ5hy+/9qnbz24/HjoRJQ5davb/Z1BaUDqrdxkkRp/IG+GX0BXuU9
 Nehk7DdDcmiZqGUGEkZ3Bq8FZj5bUvTGnleoOFVyDYEYGIEk3UVUZHr0hTjJSQWCHnbp
 YYCldyNy95X6rE2zhuJtxDLLW/p19XIP7anQAFToXDPlsJKoyTHGz6hyVLmU19U9UBEF
 ulC3eVYtiqk2huyW9QyFeTQ4FFJNwMumKPrzxnkQbB07cE8gCvdMqCk3o6qXDzbpP6xC
 84wYEzWjCzjTzqtM7VEc7PUnQrHCx/P16G0TfW/pMRkQtsEGd844w7yvsj+ZK0cFWqg7
 rerQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772802585; x=1773407385;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Swf1K3gZWqxMPuwFx8GjZ1bCIultsIOQVBWJg7tJVms=;
 b=opB4je3dilRToV+u+tAutrKR9ypLPkn3BLE3eoMPc45S8RUhKSb9SlN4D7yM9rbAGD
 TOnd1WrK/+IFacwfUdefBhjUUiWzBJnQDy88xCpYnZosyGEmCT54xLa+XsuTHnWsh3Ct
 FIYeV55xyrAnKnxbxLI4xW0DQQCbsVLGvfNyaRo8wTQGOXo1XhuuPUO99DrWt6M7SlkO
 aKRHKhIHBKE1HQuwcYiz4EAoENwrrQoc1Phx3fY1eb/vYvstP127flWQdPQh/0H2hECL
 ETetbZE7oZYw42PHidF08On87fa24kyBB8tSf+FZiXymWa828eUihkKU9Q07z8iCt9H5
 WuxQ==
X-Gm-Message-State: AOJu0YyE0Njpwq7kfHOT/9zS5xPsAfq0fBnIse2tleX2yCiABPj48/5f
 xD9755ftndS7IiuD/BGRZkHi6eID38+fX++7CmMygyqr3c4ZTqyT8+rXgyF7ekGyqpCPA0jNol3
 ehnQG25QsZvVUp6QLraqGBB678Dy7w+SEaIrwAWdjrQ==
X-Gm-Gg: ATEYQzwEsNYA0ACtjcmPy1Z5Oiti3Zs0mik9WNH18tVo3jkIPt54iqd28+K4d9iKbUu
 +1DioL9+9wnNeboz97U/I1ZJkuB0SnVa9/Cdk8UjB+9hC+6oUJFufp6SxAPPGjzOPxUfHZ3uADw
 Ox5LZZgsbI8TaS0/0itzz7HaihKI43WpDdtjdffv0OenY8YOfoObClyro3nEg876xQyUvATp1oC
 NtYb+S6TPEnDCYWyNrVdXgsQH8uch30hpJQVq2EIZ9WYSugeMH4q0dWzHAm0hozNJ5o/TiUDbOi
 0aGlS1yuSPjBwQaDcHbDxz4f7UsLqLbYFUrHEyaZJR3iNLlQQogKu15IVmyH9El1fUg=
X-Received: by 2002:a53:b44a:0:b0:64c:c267:7f82 with SMTP id
 956f58d0204a3-64d14279a74mr1398364d50.48.1772802584764; Fri, 06 Mar 2026
 05:09:44 -0800 (PST)
MIME-Version: 1.0
References: <20260306-sme2-hvf-v7-0-e72eeda41ed3@linaro.org>
In-Reply-To: <20260306-sme2-hvf-v7-0-e72eeda41ed3@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Mar 2026 13:09:33 +0000
X-Gm-Features: AaiRm52fzqlmbRbXO6JlHmq9ubx2lGn2wCk2wvvNTZ_cAmQGSZgd-t4nYNjl6WA
Message-ID: <CAFEAcA_V3FeSrhWdeegs6XoO-VQXH0Y-A_X9ChcRDR9ZYUjiSw@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] arm/hvf: Add SME2 support
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 6 Mar 2026 at 12:45, Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> M4/M5 Macs support SME2, and HVF exposes this functionality in its
> public API.
>
> Add support for it in QEMU.
>
> This was tested by running an SME2 benchmark from Arm [0]. savevm and
> loadvm during the benchmark's run were used to verify migration works.
>
> [0]:
> https://learn.arm.com/learning-paths/cross-platform/multiplying-matrices-with-sme2/1-get-started/
>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Thanks for the respin -- applied to target-arm.next.

-- PMM

