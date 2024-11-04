Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40DB9D1BDC5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 16:58:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80PK-0007jS-Sh; Mon, 04 Nov 2024 11:58:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t80PI-0007ik-Nx
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 11:58:24 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t80PH-00058V-0N
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 11:58:24 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-37d43a9bc03so3024549f8f.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 08:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730739501; x=1731344301; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=m0o2RgKkHP9t1oVMWCUj0yrb8kc+cMF2/vR0PNGAOy4=;
 b=oW081eo2RibRnUuGIrhpG6TJtKY5U0a0R5ZtsiKlf8utQaUFBh2Asb2T9HuAKVpEq8
 4JllTfaTpVA0bbKXtIgk0p96Z3QKsO8MV+smoK56DUNSwmtT73fb+E5Uul8J52QzXqa3
 g07btOXEYsAGuhBjt8C9vVpbk3Vj6h5dQLpY+jmXnUKbwXiGQ9UqMexQNh5Fq3oq4XM4
 sobgZvL4YMaJbS6z3wgSd+NlJXDxqILSLrfEpXZc2ar0VgCYGBMcTO9mZ+TlPQtPubQ4
 IRxzcUpPX4KGMX/lrdD67ZxBWzhbHJ1Gv0gigGvwlIm8CSJEG92l7BzWXaIUfAAYQ5z0
 EUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730739501; x=1731344301;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m0o2RgKkHP9t1oVMWCUj0yrb8kc+cMF2/vR0PNGAOy4=;
 b=OdbXHsB6DdWbcVRyxslAzmkTxZO0mICMbw61iFI0cgyqMYvWvy+eRuN252MXdwSsNH
 63PCg3cW/w26fFFZRwPI5Kw9m6xC/6L58/taBmpq9F2Oc/9/51rnGs/xEb6L94996vJl
 QzB6QXNPkNuw5XumB3UMX7vXPyb/Mf1ejsYiuja+2ksy1u3WuHpTO40Vv/Wa01hq+RT+
 I+E97GYClqvtvWPPqm205rY27W57G1DROhd1ON3yC1DUXfrLkG3mYQQhGe7qocBy4yy0
 G9NWkun8CkI4Zy6LqQ+w/td+1yfGakyu/77v/DPuxCBp3EoQ3AG8CmzJchtNVsNNheL6
 MzOg==
X-Gm-Message-State: AOJu0YxyBdXqCWjrqV8dj5euPvYhEOwD92SXkpNtaEEgx/iaFjzjoETI
 ExittvafUVkNlxn8HGsAkiSVi6wifBIUy1DJDNaS/UqtT1sAaYdyxBiLnkZNWpVKwOd0txBiCk3
 SvoVge0J0SEhE69sNfix4fKBPXNTruG/e+bBW3g==
X-Google-Smtp-Source: AGHT+IHlfbypLypjDRbkkufLGEWuzBXtPvG95UdaIRb7uMNRkLJ7lPcNZa3L/SUhBsFDrRudH6xZAFIYXSNCpA65k5Y=
X-Received: by 2002:a05:6000:4027:b0:37d:4ebe:1646 with SMTP id
 ffacd0b85a97d-381c7ac74d2mr10870950f8f.48.1730739500855; Mon, 04 Nov 2024
 08:58:20 -0800 (PST)
MIME-Version: 1.0
References: <20241104142606.941638-1-gustavo.romero@linaro.org>
In-Reply-To: <20241104142606.941638-1-gustavo.romero@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Nov 2024 16:58:09 +0000
Message-ID: <CAFEAcA85mXoskBCnackKpMAe936qGHwdkSpSRsOBespzeAFBjw@mail.gmail.com>
Subject: Re: [PATCH v2] target/arm: Enable FEAT_CMOW for -cpu max
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, alex.bennee@linaro.org, 
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

On Mon, 4 Nov 2024 at 14:26, Gustavo Romero <gustavo.romero@linaro.org> wrote:
>
> FEAT_CMOW introduces support for controlling cache maintenance
> instructions executed in EL0/1 and is mandatory from Armv8.8.
>
> On real hardware, the main use for this feature is to prevent processes
> from invalidating or flushing cache lines for addresses they only have
> read permission, which can impact the performance of other processes.
>
> QEMU implements all cache instructions as NOPs, and, according to rule
> [1], which states that generating any Permission fault when a cache
> instruction is implemented as a NOP is implementation-defined, no
> Permission fault is generated for any cache instruction when it lacks
> read and write permissions.
>
> QEMU does not model any cache topology, so the PoU and PoC are before
> any cache, and rules [2] apply. These rules state that generating any
> MMU fault for cache instructions in this topology is also
> implementation-defined. Therefore, for FEAT_CMOW, we do not generate any
> MMU faults either, instead, we only advertise it in the feature
> register.
>
> [1] Rule R_HGLYG of section D8.14.3, Arm ARM K.a.
> [2] Rules R_MZTNR and R_DNZYL of section D8.14.3, Arm ARM K.a.
>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>



Applied to target-arm.next, thanks.

-- PMM

