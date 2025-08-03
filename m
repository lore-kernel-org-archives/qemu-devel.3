Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64BC8C87FCA
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 10:46:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiWD2-0004eA-Nz; Sun, 03 Aug 2025 06:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiWD1-0004ai-Hw
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 06:44:55 -0400
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiWD0-00051u-6i
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 06:44:55 -0400
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e8da1fd7b6bso2664279276.2
 for <qemu-devel@nongnu.org>; Sun, 03 Aug 2025 03:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754217893; x=1754822693; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qxiCWrzxRWrur1hZa+SKc8HbkL8ZJRUO5KGgdGxNtCM=;
 b=aX4LUJ0CymjGrA/5rXfzhlwOBEe7bodLL0qfbq1C0RDOmn/p6nRwC62uWxAvGGsdeA
 mr6y7T5tHbOT5PznWtrjyCPx3YJhkMFKMujWmT00kiFt6zBN1ciDxRa5gJPpbryyc+WN
 gYhTUNR71GZ1ymfz0ck+IlnUXqVRs+f+9lA3Sizeg5GF4aT4tdaL4wC67+A2lKCQbWUn
 g23AHAQvO1C4uCE5b9DCGhwVIJlXz0/Egq4vYz0MCuay82+c1BPbNU4DVyZh8T5SEs96
 41UBeGrqT73rXxsBGR6sIfOQ5QcHnDHlIfREiYs5bCCgE6J2KgnbrVXercmyoYqP80GK
 G6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754217893; x=1754822693;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qxiCWrzxRWrur1hZa+SKc8HbkL8ZJRUO5KGgdGxNtCM=;
 b=ZmvLTU1QCQDrO3FAIiuTUvT8o1TtoVmkPfCPbp/omF4mbWDtniz7wgRM0Y2zbR7wpX
 shBuHFjOgr0sSNkYt0nmdGmgS44TeFM6ZD6ZA9ZKFnsFi824TzeUVUwi3bSAqAHHRm2b
 Ke/yX4t581+LH3qi915ZrngxMM0ye6Qi/87dKYE6KagoQbCiGmp2j1bssBvZmQSiHDTV
 Z8PX5b09eQESN37rxHAGnEhqILyG6uTe88L3OWPQW9yny9gLzYDr4Zf2xsvu7/FVi2EM
 BNPkid+IhZwvZoQHosASqJbQo30E2cTxrAYBcmv6I05odaUxlubuAtooGQ2unPcb/3Ng
 pl3g==
X-Gm-Message-State: AOJu0Yx3jCmuFfahQudI9doxhvkEGy/oesNTVxSHW1mV35hU0dJH19eH
 hPLbfNXyMXN7Fam+XewRB9eKRWIRQ5eJ5ePa9NRKp7CD2c+zSzl+s45QLHNUciTJCEnQaOcTnlc
 hGY+zuUy1C6BccuzG9MKAj172PWCj476hPUpHVxFVXg==
X-Gm-Gg: ASbGncshS+pNbqj/QA2Z521xLRZ2nIm8tW+dj2o94r9Yo3DIlo4BaeSwce3sviw2yRU
 929OxXR2IuBHrMOK1X8yqtSjhj2AI3xuFazCDz5tmpqR0mgoK90YHP8fXBs8SsBTf6kTOabvZen
 WAfmXs3n68Y8PQ8qfJp261+r7PmM98xyFfXbuwgC1shSmVOCdjca+IjqpnGn0W6ysuM+XE90KE8
 Co/EHi6
X-Google-Smtp-Source: AGHT+IEmNvDE3J0TnOM2ewUzBafSWpW4bsxC73eDp1iPA0VRUCwyggST/t6TRN62+xPDA0xRrTR93b02f5h48KtFqYU=
X-Received: by 2002:a05:690c:4b08:b0:71a:4099:4254 with SMTP id
 00721157ae682-71b7ef4db70mr65603587b3.22.1754217892914; Sun, 03 Aug 2025
 03:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250802230459.412251-1-richard.henderson@linaro.org>
 <20250802230459.412251-28-richard.henderson@linaro.org>
In-Reply-To: <20250802230459.412251-28-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 3 Aug 2025 11:44:41 +0100
X-Gm-Features: Ac12FXzyUP1Wf7mB06pD9A4yIaBkhMFSS-ojDBf4JpJwBhhan0eAhPHOkiz2-aA
Message-ID: <CAFEAcA-E2TCOEyamzGg57cAAcR1dnVcu+xcfMAWiaxggG5QwXA@mail.gmail.com>
Subject: Re: [PATCH v2 27/95] linux-user/arm: Create init_main_thread
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb34.google.com
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

On Sun, 3 Aug 2025 at 00:07, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Merge init_thread and target_cpu_copy_regs.
> There's no point going through a target_pt_regs intermediate.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/arm/cpu_loop.c | 52 +++++++++++++++++++++++++++++++--------
>  linux-user/elfload.c      | 41 +-----------------------------
>  2 files changed, 43 insertions(+), 50 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

