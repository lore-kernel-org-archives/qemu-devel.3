Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9EC3C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:48:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgIf-00086C-Cm; Thu, 28 Aug 2025 13:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ure0T-0006NQ-Ov
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:53:42 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ure0N-0002WJ-86
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:53:41 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-71d71bcab69so7357007b3.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756392812; x=1756997612; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IjcbSHCZrDkytvJaf38SMhSlxohPnup9zrxec1mnV8M=;
 b=koSJ/B9QnJY0LCRHEONigz9/0RHRY0Fa9lkY6/aEySWOd6zQtcloKmdKwzqvvJ0EZZ
 8Z0Nft8Bsyp/rB74PqrZkicLSNVK1cGeEWi3NrTw2ksdEZLv0FYzm9e6HCLjQAZrO52R
 HGj+DND+TmnPOwBlUok1nMOwsDqdZROO+9ZRjw6Ew9/QQnfBjm6bWy81htbYjFesfsM8
 6PN8fEZV/LIWBrTP1XkPokL9UYXGSGhyY9YoiTlZfOR17rvgxvo4NYcum8IgJI5BpMwZ
 g2wfJFgSwwSlRVvnaDJF3fkA2y3CT1zt2MUktP8URhpCPCyCfWMgokL1P3WWE86H/AhC
 DF0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756392812; x=1756997612;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IjcbSHCZrDkytvJaf38SMhSlxohPnup9zrxec1mnV8M=;
 b=qjrqDAHltFkbuI9buBY8FAyLRVDHvEejTNRgzgOYbOkKpSmwEecZ6cyLJTDv2lXXDB
 1kpZ1ghZ2sEElPm+ly6V+iFbd2JcDigr9KKh6TIxMqLyzZq/O8obNKS7f4p2r3GeA7Ca
 rDPztbAZXEE5JE6wxqanOpF52L/xK9xdlqnNr9T9N2S2vIZXU9M0wGrQ8LZ8fmLdE0mK
 fVTuui/VdyqQ+PNe0Zt76PQHqtnQYd00dQx3kA1luaRD9SMr8lzqCL/enqroFP2SO49+
 9woLQ24prA8fll63HKWi0ZT98bQwB5bWRRg8xUsEQqYzX2/BZpKeetb/pe6+1G+XZOBM
 0aUA==
X-Gm-Message-State: AOJu0YygBKIvGJMN5lPLpSdcthntOm2uEV/RMUdNv68Ea01AkVGRA3Hc
 fjy0PAGhTKQEvoEMWFGei05c2LlzukxeQ5MZYnXde4LmkHo07K6amjbo2NodkkMtOg9IWhY1b0q
 pHmLGsfG4D0UVsjR/qBIT1iElwPBWI6RMOYtPhPyh5A==
X-Gm-Gg: ASbGncszd4GL4jW1kFzjxnxLOtH//mBZYhPNs8zjwaquNnBHobpbCwAUksZKuaYWwmU
 sXnZ/j/aaC5SfEAXzNLu1SUoa3C5FysjDPr2EnmV26AE4hAbpnrAHAFBJpwG7oZCOqi5IBye7lF
 FwAzvmlHGFjDRg19+7o0M4K7mMO7oq9pnj/9SzKIz+RvuJpww/K4Nj4zDJzhbaDxKSSk3pG3QUc
 vYdCxDcL4WNxNNOb7YI65Ctop0rng==
X-Google-Smtp-Source: AGHT+IF86RiOBOFOsjsl8NlbGCriSZaHlNSZOA1Z+li0knaysoNOxvYwikjiKgwraimG31Io3O6ioHVVgP0Yc/oMSm4=
X-Received: by 2002:a05:690c:f88:b0:721:10a3:656c with SMTP id
 00721157ae682-72110a3673bmr167818387b3.9.1756392812131; Thu, 28 Aug 2025
 07:53:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-42-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-42-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 15:53:20 +0100
X-Gm-Features: Ac12FXxHkgzNJe4BpbdYGDm9D5-xpr24Hq4hApjzsFH-qxup4Q4XQS1t-mML_q4
Message-ID: <CAFEAcA_mjiErY9smfQ-j3S19MOZomZfogjHY9qzWdFpLfE_khw@mail.gmail.com>
Subject: Re: [PATCH v3 41/87] linux-user/m68k: Expand target_elf_gregset_t
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
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

On Thu, 28 Aug 2025 at 13:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Make use of the fact that target_elf_gregset_t is a proper structure.
> Drop ELF_NREG, target_elf_greg_t, and tswapreg.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

