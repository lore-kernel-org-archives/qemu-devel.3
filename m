Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ECBDCCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 13:33:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vApza-0006pl-0z; Mon, 20 Oct 2025 09:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vApzK-0006pF-48
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 09:31:50 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vApzH-00013L-1x
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 09:31:49 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-780fe76f457so50276247b3.0
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 06:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760967104; x=1761571904; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0LPKHz+mniEvRap+Bab+PlEBxCjH0WDsg0DZht8KEqM=;
 b=TDN1zVooT4WkDrkofiCSTWKYCrQ/Z6kg24U+aQw85hy5kauDgrvObHSOQiWxHfHmrK
 +ozN3qN4sJX3Twstrta7EQUSfeQkDeNnirSj3+1BtGZ4HdQi+gq6dnXzI+mlJEe/CNd+
 eMLoKMvMt7nUNAVGWuWwLvjl04Yz0ybx5As/KGEgbDvUGf0MaUxEQ6z88DuH03iHw+av
 weX7iZ7ORQ4igwVrlgqEQhVmZ5jfdLvxlJvqtZheQU1OV/4Cjhy3yqY6C6DE9kTBkSwk
 DdDioKJW/L6BuxXkEru7JjM3UQLID46BExR7I0D3pNcbxBxkSMHBcmIH+Fx4aqJiwXQm
 dt0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760967104; x=1761571904;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0LPKHz+mniEvRap+Bab+PlEBxCjH0WDsg0DZht8KEqM=;
 b=n7Ux5WCoEqP9lYoqarxRLwyWK/cTUGgIRcJrTmziWNNnwPSvWeeW16I0cg/KdQqLIM
 2gg/J9P2t9HjyZllYPjCxruPXol6JFU3dHCP9SiHaAjkjBkDeWyuQUgNeLWkIdV6m8zk
 I3DV6witIrrKhX+0qzRlFgIO3LvdV/33eLqbEisPKqaQZqgTUO1/Vk+FeatzspHJ73Xb
 rxQ+RbUFhTT7pPxQSiLQBqApmceJGoK9qyZKen2LGfR0yA4u81a9mXaC98AP9t00Qmch
 KUMI1bJz3sXiBci78gN2OUixSacxmOmuGhD4hLvOaAEtFFCr2j8/XJyaoHY7JAgkBgx9
 uGYg==
X-Gm-Message-State: AOJu0YyFVcLExUBKiAX+R7TPqbIy8ZVJHsDL2jiEdppIs+t8s46pjNJ4
 LRC73tqJ9CZrjLxJRAV1bNokcIbkH51CzEHduhFCMNIAY6nsZGkzQuZcMPQ4NFIM1WZwfGC1cev
 C4FJMLOmN/NHX9dE3YIBCWM2yoD3eiZVdJ8anoajuQg==
X-Gm-Gg: ASbGnctrLVNZTnuYgwk4rXcFb8TCvi0ihSpcNBqo1rI7NTvbQgWbzHKd7CCFEFrhUku
 wcPe/IZiEPIZIIjRqKvXFs0ErfQJenoaVE9bMq/503lxfBGcrMHbZBpQ/NJd5fjEyKPkmG4vLYL
 JLWcyNrBB6ixzE/8y4sATsO3Wose2KRdP4RT+dAN36fmtioQXtR9jQdSWdFTvH02akQ90IShy3/
 3j+e3mFKsxpK4XmAgAS4OW/dq55mHK7t+jDR0/Q+KIWkZ4RfveLKJQft2KUl3JiBIP9by/p
X-Google-Smtp-Source: AGHT+IHu8sAPqH7wiF4hdv7DjYU4aUdUTdADZzoEy/3mL/wYFa4HhkX10hLcZovNDDgvcK4hr7HoXYF3zSFTf1ZhkVk=
X-Received: by 2002:a05:690c:600f:b0:721:6b2e:a08a with SMTP id
 00721157ae682-7836d2d6737mr198517967b3.37.1760967104228; Mon, 20 Oct 2025
 06:31:44 -0700 (PDT)
MIME-Version: 1.0
References: <20251014200718.422022-1-richard.henderson@linaro.org>
 <20251014200718.422022-21-richard.henderson@linaro.org>
In-Reply-To: <20251014200718.422022-21-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Oct 2025 14:31:32 +0100
X-Gm-Features: AS18NWAf5v-M6EKBEz6H-2q3wbNX3p0avf_b5AtuspTP3NSWU5xtheyEf34gPG4
Message-ID: <CAFEAcA-tVBn3g185gzs2uOCnYLeqWN_zwfeQ0DccLf0n8BN5PQ@mail.gmail.com>
Subject: Re: [PATCH v2 20/37] target/arm: Consolidate definitions of PAR
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Tue, 14 Oct 2025 at 21:11, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Create a function define_par_register which handles the 3
> distinct cases for PAR.  It is easier to understand with
> the definitions all in one place.
>
> Make the aarch64 to be the primary definition, when present,
> rather than being an alias of the 64-bit non-secure aa32 reg.

Doesn't that break tcg-to-tcg migration across this commit?

thanks
-- PMM

