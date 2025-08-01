Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD3CC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 19:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhvVT-0002s7-NI; Fri, 01 Aug 2025 15:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhttQ-0000xH-Si
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:50:14 -0400
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhttL-0007VP-Jn
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:50:08 -0400
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e8e1ae319c6so1041462276.0
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 10:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754070599; x=1754675399; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=diVwAdxMu7OqRUGjwY2XEHGhlkT2BPnmLUuk1lxW1mY=;
 b=R03vyVMaNAP/Y1tthHbt9jcXbQj60rdOwuqzfmoUWZwEH7IngOnD830yxiSui91c4L
 Oz1lUloUabc/2pKH/WF+eCvy6pJu0zokf27v9EssS7OMPGvBTqXkOxE/6njcjMZtpw5c
 jNHDEqqhgSmssHmU9Vazh8i0FNMYbKaqmt3UnTr4h0Oyzc4EJkWZFpLobBJUOsLh59CS
 In04DSXwBDrYBcc8EytGdNEzc2igdvsn1w4oHOyhAmnMla9QP1lLXtp+AH4FV2ohRTIo
 vCkNb0xHeBXIXvflhHtC9wjO89V1J7HCYN3ec3sulFPRnq5eNlJswjoLFShy2CliY0GF
 s6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754070599; x=1754675399;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=diVwAdxMu7OqRUGjwY2XEHGhlkT2BPnmLUuk1lxW1mY=;
 b=qdQseq42BZM+DxUqMETHpUf0FQXQMRTGm/1rGM5S8DbbXzh21QsotYb9upNesSUsBo
 mSabbcPMZA4/qwn0f8WUDhk5zWwtiajjtlAsdcLs0isKCG2UFGzNPsaAkmC1/89tR229
 eHfm3bEh11Zf5b7r0IEyUGXMOyBXW9B5FDhqji9J4RHBwBlD9YYeENtigPY9KBsdFmlr
 Ju2iMoxWt37Os+rNAlhfHSfvdmXQbkEOuzUIzB5gbEXel66CTYrLsLgZOyZMJNWvwvKo
 v96+pnxc9jJSzp5pwTnqYkEiGf61xMTBBFJFmlaSM0lPZwzaucVjUa96OfMtUXFg48K7
 3gqQ==
X-Gm-Message-State: AOJu0YwcOjqOn74pFs231AxEeuyEEPFiuXsOXqAt6Y+Bt29Z63RuuAax
 /Mqda5a/3DMgSvEbPn5oxN8Qv0R7v/jhHaXx10mxcXDDDIRuQtP4zEUvYS+sLBISykwbi2IuQ1z
 ppRpCB4EWhqg8yDmCA4aOJHWvl+8mKOzWxg/nEI8bzA==
X-Gm-Gg: ASbGncsxZBBkJOrrnIPw/XwDgAqtuhN1s2GqIsfMfPTelxyZZumNAKQ8439o+7loF/4
 9vSDZblbPNPmTTxbwmeUZ0yVKHCdO8rT4CcKYoKtKoJ/0Y1/DK6WF3c9eIzhJn0actUw97L0Wr9
 ZnrfgzuWmizee9ierPlH11H0itgcSfcn+GzKU6zhGIYKdFo9fjIL1FJ5tz3ZLmlqZCMFo6XYDwb
 KqE1dLg
X-Google-Smtp-Source: AGHT+IF4yRVbc0g1jRSY+x7mqnoYj5qNGcbKAUTRlvt4VCcGTBqNHsxjLtoNyzqKuqAA9rP1zLj8LCkKTTtfbEpnvBA=
X-Received: by 2002:a05:690c:110:b0:71a:1e72:84c3 with SMTP id
 00721157ae682-71b7ecda924mr8530647b3.9.1754070599396; Fri, 01 Aug 2025
 10:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-53-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-53-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 18:49:47 +0100
X-Gm-Features: Ac12FXxFdYF2e3zwKsSBvFMvnf9xiS1san4ehgNWuu_3cSRKZwkI_EGCsin76ys
Message-ID: <CAFEAcA9U9mtEK1bwU=reUbCM2f8hA7LCB1V1+6G+vG6J=RpWFg@mail.gmail.com>
Subject: Re: [PATCH 52/89] linux-user/s390x: Split out target_coredump.c.inc
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2c.google.com
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

On Wed, 30 Jul 2025 at 01:28, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c                   | 31 +-------------------------
>  linux-user/s390x/target_coredump.c.inc | 31 ++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+), 30 deletions(-)
>  create mode 100644 linux-user/s390x/target_coredump.c.inc

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

