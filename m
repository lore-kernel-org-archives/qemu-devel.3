Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF57C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 09:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF9iz-0005wQ-2z; Thu, 06 Jun 2024 05:48:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sF9ix-0005w4-H7
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 05:47:59 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sF9iu-0000yQ-7p
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 05:47:59 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a68c5524086so80111866b.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 02:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717667272; x=1718272072; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jM4ZLyBsU6Z2tuPIR67jth5BYR8r5ELIYjc5QzcJQvc=;
 b=xN9SKuP2FgSCfbJDqfuG3l+ttP+XbGFcAPPT3j063Cujzc/NVX4xHA3MLSLGRzDEey
 3eV9LwRAnwhrSDNNegcWSFhbvwepb3K5T8gnJGwAygl4SnBLr400tkY5Vp83/B8VJcIN
 bHP2KWmuprukpxQ2stQdcFpwG/V34rk+cl9N8zyZ1FvtfLrKkNuikoR8Apl/WGbOVMXJ
 ekqmMudgfE1nJkFX22L9ixUQedKkNM6sGvh6fo+lEx0YrSY+ztHdRBBCpYoRZOf8PKsU
 DoSIB77l42vwfZlywwom+hnjhL46wnQpd39gvKLhx4F3v/36TBiSkvoQdN1sHMePpb8E
 Vryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717667272; x=1718272072;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jM4ZLyBsU6Z2tuPIR67jth5BYR8r5ELIYjc5QzcJQvc=;
 b=E8hUIypq333N4N4xTUt3XtieNsdsex7b+TrxPexLT5AqwNYTQR4e0uz+77p371yla5
 PangAxsgdj/LMQVex6Q/Vxm+FGDZjKdN/POSAOriFiHzpXrJuh28Gb16HdXCkUuBrw3u
 6mo6wPccLAsv/wLQPLEDf9phMnyIQcAEdBluFqPFPh8SI3D/0WowNH/BHqra04vO00gt
 Z4rprGBBsTCZkX0JH8XwyY91PwbKv0RQXsqHhhAcm1Kzd52UU1Ilaa4evSa9yOH3MpyH
 e5A/XOa9eAY+luf3K2EIfSAIB8t2M8YMeyWavaWrhua20FKeGOGdUhBDwy4dTBSot56Z
 29cA==
X-Gm-Message-State: AOJu0Yw9303IE1ZjHzcjIwoNidRrle0CrHNUSTx1Z/ShEyAfqt1P9lnW
 F1T7m18PG+xOaa+NGkADl6lM3Zg8lmjmLP4wa2BKeX8vuU23j12JmxHzjHYpJySOa8EJ/n3wJmD
 Q
X-Google-Smtp-Source: AGHT+IFBJCQqHI/NRNypIRcX4mhL0j4AJmWgjoub0R9jTgLRLJT1TR1VJxEC2XwUNVvxrwoHbOXPAw==
X-Received: by 2002:a17:906:26d0:b0:a68:f28f:34fb with SMTP id
 a640c23a62f3a-a699f887420mr319760366b.39.1717667272201; 
 Thu, 06 Jun 2024 02:47:52 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c8070bfcbsm72017766b.145.2024.06.06.02.47.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 02:47:51 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4D6B85F7AD;
 Thu,  6 Jun 2024 10:47:51 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  pierrick.bouvier@linaro.org
Subject: Re: [PATCH v2 4/9] plugins: Introduce TCGCPUOps callbacks for
 mid-tb register reads
In-Reply-To: <20240606032926.83599-5-richard.henderson@linaro.org> (Richard
 Henderson's message of "Wed, 5 Jun 2024 20:29:21 -0700")
References: <20240606032926.83599-1-richard.henderson@linaro.org>
 <20240606032926.83599-5-richard.henderson@linaro.org>
Date: Thu, 06 Jun 2024 10:47:51 +0100
Message-ID: <87y17il7w8.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Richard Henderson <richard.henderson@linaro.org> writes:

> Certain target registers are not updated continuously within
> the translation block.  For normal exception handling we use
> unwind info to re-generate the correct value when required.
> Leverage that same info for reading those registers for plugins.
>
> All targets will need updating for these new callbacks.
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

