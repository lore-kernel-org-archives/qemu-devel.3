Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE05AD62067
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 10:10:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDLBA-00005N-Q7; Tue, 19 Nov 2024 05:09:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDLB8-00004x-Fk
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 05:09:50 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDLB6-0007kN-Gv
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 05:09:50 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5cfaa02c716so865631a12.3
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 02:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732010986; x=1732615786; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RHBe2V/k1UtOYq7C2OHkUZ8XpdfMUyTmE9JBBn6vRt4=;
 b=OweVqnrDVviSREESrN6yW26E6yuVs6GXpzUSkwOKdCLGcWTboqa3la/ieLbCgTzmSd
 4cdixwSGip3XaS6ZC5pfjZ/0lJQGWRZKQlKO5oe7vGiRoyvpA3qoHFzbiHGIx0Wf19qz
 1VK3zqwhh3GbU5OU1GiiFr2xnyJL9+HRgMGqIVUfXSzMqgfxVNyX0I8DzgQ5nkoqaKDu
 YuTGdIFcnS2Zb75Wg9gYt4EzFrVTasB0lIkU10QpSNgKaTLeFUSrm4loLZm0I9JAlhRP
 wmg4jktJXWe6hxFhvKyuSWDeXxZkpb+0dEcBD2AREx/WfVzLUv+0+5nIVHjEih279xxe
 mm1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732010986; x=1732615786;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RHBe2V/k1UtOYq7C2OHkUZ8XpdfMUyTmE9JBBn6vRt4=;
 b=e3FuwYCYPiYVeEEzXqpKW8DuMXV5XJ74l3MbC8Pz9IxBcQtWzbXSosKt5tFvv1pOKb
 sVmrKv7Y1QgVofhlZe9E9loW3g4SXXoItk/jAu5d8rUDKy58PpaGBwEA8UDEXNvHfG0K
 czI0hzznz+Jno3zx+a2Z/6hYS8qh/6mJ5yi7zaukaYVoN4UQemjBjAMLKPbdeKAXUi5h
 TFriC4mKf4jGJ2FLGVQweIH9KvAY/AQF6utgXOHdWnDUxOcTb9wV6kmUpHwnPzcJhQvT
 p/T1PLSBRH4NV1S07RUtGuON7hVtNXErjC1kimYmsNvFM4JxzbqI034qfN8NPOsDLA4H
 smRw==
X-Gm-Message-State: AOJu0YwCyuRpDwZ0qXeTPZY9K02Kq46rlbRcYqDoBZM790Vjsl4f/NUz
 yNSt+cr9Am74WY1ubUL+nit35o/yRcAlVy0SKEGYEWWUbnvz8JKGyv3Dv26Snn12iZ2BOaBEXYm
 cbCBZb4+16QM095kbRmd0Sz5JkPb9bCiE5GpmJA==
X-Google-Smtp-Source: AGHT+IF5e/E5rJSiQ0Kpfolaj0GUOE3FlWlnGYa2Wd/qUsCe4+eauP7SFsWPZy8Lq3VptKDKk7Av/TQbeXXFp3yiKEg=
X-Received: by 2002:a05:6402:5241:b0:5cf:ca30:fd3c with SMTP id
 4fb4d7f45d1cf-5cfca31035dmr6437091a12.28.1732010986326; Tue, 19 Nov 2024
 02:09:46 -0800 (PST)
MIME-Version: 1.0
References: <51442716-467b-46c2-b2f7-8ffdeeca320e@linaro.org>
In-Reply-To: <51442716-467b-46c2-b2f7-8ffdeeca320e@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Nov 2024 10:09:34 +0000
Message-ID: <CAFEAcA_eL+F572fZpFW2+Tz6xx5Mx5ux-axe3HR_fEf43_GLRA@mail.gmail.com>
Subject: Re: Status of some Arm features
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Mon, 18 Nov 2024 at 23:33, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
> I'm currently reviewing the QEMU Arm documentation, and I have a
> question about the status of following features:
>
> 8.0:
> - FEAT_DoubleLock, Double Lock

This is actually an "anti-feature" :-)  It is optional from v8.0
and it must not be implemented from v9.0. We implement the handling
of it based on the DOUBLELOCK fields in ID_AA64DFR0 and DBGDEVID
(so it does the right thing on older named CPU types) and don't
advertise it in "max".

> 8.2:
> - FEAT_ASMv8p2, Armv8.2 changes to the A64 ISA (bfc and rev64 instructions)

This isn't a feature for CPU implementations; it's a feature for
assemblers and disassemblers, which have to recognize BFC and
REV64 mnemonics as being ways to write special-case flavours
of the BFM and REV instructions.

> 8.4:
> - FEAT_CNTSC, Generic Counter Scaling (hw/timer/sse-counter.c)

This is optional, and we don't implement it yet. (There's an
open ticket for it in Linaro JIRA at
https://linaro.atlassian.net/browse/QEMU-309 )

thanks
-- PMM

