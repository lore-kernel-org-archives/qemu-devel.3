Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F33D9C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:23:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgBi-0002XK-RC; Thu, 28 Aug 2025 13:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdbt-0004GE-81
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:28:17 -0400
Received: from [2607:f8b0:4864:20::b12d] (helo=mail-yx1-xb12d.google.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdbo-0007Q7-A6
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:28:16 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-5fe42994547so299550d50.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756391288; x=1756996088; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8YxGLNKt7U4WZBhYc2rV2fxXrZOQFjgUj9wtt7CR9Vs=;
 b=Ma2ZlZSho6seSsxr0FRgSx0a4VKo16hIWVFCT+WVdmYHuV4PzweJ8Mw+6ZALQs4DVJ
 K1GaQ8NXYtGeWFWIhKIBaxrYLD4OixGJ2NHGXSnBmbLLAQKDLl5qIlMURVOJNhj+f+SN
 NSLIoRNRH8VgsagcqYZLDJzmMsNceJ17BKOz1Rlkw1POw8wd/eMcJRX3LBnc8S7ANm+7
 gZrlsnASbg0yH9ynjuumTtSn7KAutLuRJG3/xn0O8OX48koZe7RVpcwtOWcGOt9Ysz0+
 zP8cSGESNeMmdMgbWE5TE5HEbi6mkzH8IEs5cU9hFdbwSwcfMjV8btBZZ8LQw8KTH4xg
 fp1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756391288; x=1756996088;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8YxGLNKt7U4WZBhYc2rV2fxXrZOQFjgUj9wtt7CR9Vs=;
 b=Qza3uus8Nm70E8ohFHUW4aJ8K9ldi02n95NycR1wzZjVJ7scQQCzTpc1Axabd+cQnh
 QTX5s5XApcexzQ8lkG7aeOj5b9JDKXUGxrBbuju+EOlDqgBGTnj0L3Hl8xkpp60ql8vg
 WPADaQF/IaO3KUGvQN2SOnLTKKw+MwC3ZzmUNtTZj4TjeCT/16Dr2YvpRlTN7sD4Bb6S
 TcSev7Ufhr5IZ8DTV5NZLiLxr05CDAVccftb4Gq2MxarACb3cQZHB9Ju4EZLkN0SQ1o/
 I2S/NNPwKFIhMRDpX1KnIwrxyEIi6r7TxzJmgsW3N9VsJz9+HYr/J0GkBEvLU/lnbHv0
 2Gag==
X-Gm-Message-State: AOJu0YzXZTPzKrTM50AQX5538o9qzkWvY11OeDYh2RMNcFL+iQr6OeRO
 +FLmI+210plbq9w4hIUX6TdVsyrftpRCB67RtBClglMD+6CundupbMCUuWPExCckX/6K69zHqKH
 x2NNQd/HHbVx2YFGus/KSaONL8Edu3m65lSdITKIB4LynEfg3rsvf
X-Gm-Gg: ASbGncthOS9uneES3qffLj7P31uJxvWBg9EiYnwxHNtwWwUYxoatGpd24jpyCC/MKai
 R/yDVDQHLGc2WPiFjjiZrECE4V0VcSOAnDfF/GS2hoNPpa5oPdC23LdNZlJoyKC9Ggbq04NKvh4
 4IiyRfq2bd/jkm00/AVv6cuoT7yIaDkB3ivltkRbBTcQGVNzl2VgTH74yJa41dmXNT6hFt+uc58
 zJXEwyG3TGaSyeKXKs=
X-Google-Smtp-Source: AGHT+IGc0o5FSmtNSs+zGeKh11LgJs94DyATQliEgZl5YMu8sv7ko3ZLhsmlg4FeYziZnpipo/BrA8ynv3ywMnbitMw=
X-Received: by 2002:a05:690c:6d07:b0:71e:84d6:afc4 with SMTP id
 00721157ae682-71fdc2e296emr272993787b3.14.1756391287144; Thu, 28 Aug 2025
 07:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-15-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-15-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 15:27:55 +0100
X-Gm-Features: Ac12FXz8ni7c9nQopqB9_WkZZ3ZxiNjOojeBVQW1dBgjHpiXBKwV8o6_y4-oj9U
Message-ID: <CAFEAcA-Mg6UxJn9WLGa6ZT4Fntn8DSFjSysifJ_mMUrrzQDFdQ@mail.gmail.com>
Subject: Re: [PATCH v3 14/87] linux-user: Update comment for
 target_elf_gregset_t
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2607:f8b0:4864:20::b12d
 (failed)
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Thu, 28 Aug 2025 at 13:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The only thing now used by generic core dump code is
> target_elf_gregset_t; ELF_NREG and target_elf_greg_t
> are now private to the implementation.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

