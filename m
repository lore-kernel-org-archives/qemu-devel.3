Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E497FC02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 12:06:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfe9z-0002ZO-0f; Wed, 05 Feb 2025 07:05:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tfe9w-0002Yi-EI
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 07:05:36 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tfe9t-0004M7-MT
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 07:05:35 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5dca468c5e4so6568181a12.1
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 04:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738757132; x=1739361932; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8NBezMpoYq3Nd3pV1ASrHM0JQ9E1YF7JEDo6fsbB6D8=;
 b=hDglX/ngHK8WejNNQqVtuJmq3+WwToxsXs6xtGtghMVo7rL2LLUgNBA9JEkpbUKqOR
 JSnL26OuUvdt6hnh3D8ynIXAVF4PCVi/0WlyNjAemC3qwOxFwb3yvbGRCKZAajlFmNmp
 qNCvWSjQDFrB0bcBO1sVHeh5Tekvmgs55SXGTS8TilJOnZ2UCdk7q4NNjO/8lcfIFdlj
 ZJNGzlGRzSMyZRHivKqk7MvhXN0pSqio7It67+s7B2s+dFrmDNjK4mFe7oBlPE+IjUcf
 m4DH4GIH3lUO6fjjtbZTnHI4ldnbcoWXQ3Vs02UvChKt0lAzk2TyWc80rfl1gnDHI3/o
 1PDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738757132; x=1739361932;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8NBezMpoYq3Nd3pV1ASrHM0JQ9E1YF7JEDo6fsbB6D8=;
 b=nuywUugJG7KF/40L6YQ5JLQgd89uo3ZobOL0uEEtq8J4eJMnsW5CV9tAYQ99LAFgTo
 huFbI4yYvT91EACB60g9UfSRwbzB99aJoenEEFoNPOEpZisZxCKuz7F1vEY6C5EIM8MB
 bz9XbO2g1ubQev5xaS9p1hT/aWeL4Xkc70VctJX13zQ3eQJRPb73UJtQ28F2K9KpIs1M
 opOFZpPzP4xy2AxE8iOrIWC6dMxcrm+BN6VMx1amF/0nJf/Rla3TvyGusUI7o0iUBKtm
 BRS7enFCFDHJLBGGnz5RAx47Czp5jM37q1Ti3j3XlzqQYgPlJfg8EdWpcny+pdFurJkw
 MnBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNIsL+g7aMMOahNSCBFf5kN4pgBKbtXrReDt0TSN0FZRINemDvXeHGX361VNmphCirbh54HIsMIjCU@nongnu.org
X-Gm-Message-State: AOJu0YwVMjGqiRvneRR8Ajw9vTUATWZ6IJYULSskEwS/Q3vqNsXxYc1a
 qAv70pgoMudze/Je66lxRr8/8KxyH6osz7jvsBV4vhg7XobC09LTKlIEWhLG11UtQdCtivbPN2g
 d3Zw=
X-Gm-Gg: ASbGncuB+DPQEZhzNy+yk0x4APeeGx1nFIKmdgzT7YR6mso2Hju5TKdQdGC4vOotI5h
 CpXswt2C5+as/NJixFYoQy8wjA15KYAdFYxYihgAXN2i++7WPt8BElYKdSgq0nCmhiACUfYd98I
 92Vu+aVTEB0eAZNjmbbtr7bAuBwCKUe24mna4sBI42PBxGP/nDBZ1cc1Lb6a2FFfGB8hMUK8U0y
 3M6z5OtWvIzEgM82tPWr26M4qg1JlMFOY1HJIXy+2I7irix6bffsvHTVzqDbhem23Gl7C/9lfFZ
 N4MxeTzBIfxAn/ESFg==
X-Google-Smtp-Source: AGHT+IFH32kDLtFnDnLdXjjSQVblCqeQva1N71UrIrWd+YAnQZXsnhFxRk1z7NulrzboePJtKYSBmQ==
X-Received: by 2002:a05:6402:2355:b0:5dc:7f72:5eae with SMTP id
 4fb4d7f45d1cf-5dcdb778ecamr2160033a12.23.1738757131803; 
 Wed, 05 Feb 2025 04:05:31 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dc8857d60esm8848060a12.41.2025.02.05.04.05.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 04:05:31 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 542665F90B;
 Wed,  5 Feb 2025 12:05:29 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH 04/14] target/arm: Report correct syndrome for UNDEFINED
 LOR sysregs when NS=0
In-Reply-To: <20250130182309.717346-5-peter.maydell@linaro.org> (Peter
 Maydell's message of "Thu, 30 Jan 2025 18:22:59 +0000")
References: <20250130182309.717346-1-peter.maydell@linaro.org>
 <20250130182309.717346-5-peter.maydell@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Wed, 05 Feb 2025 12:05:29 +0000
Message-ID: <87frksa96e.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> The pseudocode for the accessors for the LOR sysregs says they
> are UNDEFINED if SCR_EL3.NS is 0. We were reporting the wrong
> syndrome value here; use CP_ACCESS_TRAP_UNCATEGORIZED.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 2d7137c10faf ("target/arm: Implement the ARMv8.1-LOR extension")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

