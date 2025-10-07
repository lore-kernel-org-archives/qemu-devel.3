Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B67BCCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68ky-0004JA-U3; Tue, 07 Oct 2025 10:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68km-0004EO-N1
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:33:25 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68kf-0005U0-2C
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:33:24 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-743ba48eb71so101558747b3.1
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759847589; x=1760452389; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eUcABolmLKzvNvBfTunUMJPXMrj4PmRsjn1sU0BBoA4=;
 b=bIpYsBsAIFmILG24+M0Sve0FKfdXajXF4sxISCMR1SplmnhpqbjRFSv5QB0MPIPGM+
 d3CPFD//EW7HZJdQM+bue+45gwiCzZ/5hnlyugoMAN4NgUk0Xi1QeA38cAKLmYKyTAM+
 vDJTtb2gAEvwDZFfTF0DcLgG0+8b/1Arve+ISBAjPZg+ET3CRzLGp8Q7qlZhKJIg3Uni
 dmZKxwgPHHKOJekkNpkab6MKJZhcaKnUPIqDtbj+OSmJMip0XtrMtR9/sPAIL+VYu++c
 5OoVOkQs6PnPBUHvV59XqGbJBXtNk3gMo5n6AzmzrHFaGWQ2djtulDcfKzVUJn55ju+X
 TGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759847589; x=1760452389;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eUcABolmLKzvNvBfTunUMJPXMrj4PmRsjn1sU0BBoA4=;
 b=dtLxwtozAj1tVd0XgEHwSkqFGnBsoB14Emg8y6K4v+Optcz3g7Bo2PVA6buiqhcqAz
 vgmc1wn/7HFcmW57c9yEEgFP/e1qQrAQb8EamgcWB1muRTMYZOqSSQWTdNwN80xPNSL0
 Iyn85idDW18tbNzmlMCC6zg34V0Q8pqSBalspZ2Edp1k/teuvFqywEc0qsem7OAIOIgx
 FrzZbZTJRhDQVlTtKEpDzPyLzJEh+98rKplI2uruym5vB0JQMFlaqHTfJvDL3enW7VAx
 tMnCaofUiaSIHMl6UN0pqs45eILNp14RrDEKW/qGXis/b+lDEO0IThp4mdFlc3RXC3Eq
 LznQ==
X-Gm-Message-State: AOJu0Yy+EGjVtjQPLm5dOzMSdhHhBMRYGY91JAT9UVk2fWaM9Lck74C3
 /vTkId81gtvGsIWg9rndnV6fW1tgxJLMhUYz+eiR+vT5j/mgncv1LEp+TeZlSr1iYJm6foeZ3h9
 pTDFzpVF3koopOsHY947pUtOSyd0918XUHtBmZztVYA==
X-Gm-Gg: ASbGncs1OMaACR3+50sYSuaYePp1BVYhjTTuXrLWeZLobUEOkR8JFWoSgXx70iCkuIV
 k6I0I7e/s8uyUK53yqyQ8DDZiJIwCzBkWQGSoynNQGXLWqtLi6wvo3rveLoUdakfimkG4ujPgzU
 aB2sBO0mwO4Efai+4jdps5QqSQfjG7+1IqdLLR84j9G0NxMuXI6LSGXb+OAKQZIYUeXTDH0q0yD
 mzBlzhQ3XJdQiyi6yWdJCqLRytlifrYUuy4A46nAZoGJgU=
X-Google-Smtp-Source: AGHT+IFfE21W/JLI93Q6a9rkf0KZ9VukKWRMLNXtZJvq8Elu8CEm3qSCdIONhAXG/y977K3A39YC3QL12DJbA/Brh1w=
X-Received: by 2002:a05:690e:4319:b0:638:aaa4:ca7a with SMTP id
 956f58d0204a3-63cbe09ad62mr3318193d50.7.1759847588629; Tue, 07 Oct 2025
 07:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <20251006001018.219756-1-gustavo.romero@linaro.org>
 <20251006001018.219756-3-gustavo.romero@linaro.org>
In-Reply-To: <20251006001018.219756-3-gustavo.romero@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Oct 2025 15:32:57 +0100
X-Gm-Features: AS18NWAivNp8IvBhD7Fg-5Q77bPPtZbrzfVrqCszjuG-WOgGUV0wDKvGQw-q5nk
Message-ID: <CAFEAcA_mBh2GeDMXG5b2GAbNj85z8g7bZicxdiyH6jogndDHpw@mail.gmail.com>
Subject: Re: [PATCH v10 2/3] target/arm: Implement FEAT_MEC registers
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, richard.henderson@linaro.org, 
 alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Mon, 6 Oct 2025 at 01:10, Gustavo Romero <gustavo.romero@linaro.org> wrote:
>
> Add all FEAT_MEC registers.  Enable access to the registers via the
> SCTLR2 and TCR2 control bits.  Add the two new cache management
> instructions, which are nops in QEMU because we do not model caches.
>
> Message-ID: <20250711140828.1714666-3-gustavo.romero@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> [rth: Squash 3 patches to add all registers at once.]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

