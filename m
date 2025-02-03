Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD55C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 13:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tewyk-0005xK-Ul; Mon, 03 Feb 2025 08:59:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tewyj-0005wu-Bh
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 08:59:09 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tewyh-0004um-TU
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 08:59:09 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ab698eae2d9so891174266b.0
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 05:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738591146; x=1739195946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gt8Rn86AXh6kVZpy4m9lU14y7OqHcZJmxjxjCyF74hs=;
 b=yorblmMQYw+Fq5dcxwdQ4cfsn9p5TL3M/wr78ykS4S5CPXSDQWsSVT52KNe9JkF5l1
 eTnszfZDAaTh5AR+KtAEeS6MqHReYlRyTxn9P/yV4Z3tmgkjpr2HrCZDaZZKAI0J3fUp
 isnyDcsTtuxQWtJNCeMwvdMhch8W3KVHZ3Y4NDXF1DhDbsJzkPvYBaSLtTcjNBcxdRpv
 3au78ioBVbEOl5VOlsp1f9lmUMT7jvac4mwHjD5Ox9NPCKfbpQHt0FdJfZOpE+3yG6Sl
 3pwysc49l8MhuD2HQ4K5OZ++mtQYBK7VauEtvlvbCG+X1uxp0rPadBvSSbQLI+dSalrI
 Erpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738591146; x=1739195946;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gt8Rn86AXh6kVZpy4m9lU14y7OqHcZJmxjxjCyF74hs=;
 b=tdoY6L5XXofAgUFKRI66rlkLHwp2l+1xYjE0zXaVkmjw1OL3IK+8DzJYcwUs6TReBE
 5DsOynNzyVzESsJvxI6Xacy6NllylNgNtx71oah5E0I9mN7X653U1RhhxReXfwa6pLBR
 J5yhYwMP7YTRtR17+OAU6wUbi7sSv2RJzgJdzOxHKTewzjhbMXqszXuHgnvqdU7KMyqX
 Jc1AGESiXG+jVeguobgxCqJSF/y07t/iMPmqKV1zaLGNT+cftlq1FghlyDeDHFdztfrt
 UHRisDu72REZpCQzmYDk8x1WNiVBGMe8GYkwgiCWvo+NHjXLBYSjpWJV/6bpQ4guUBic
 aPXw==
X-Gm-Message-State: AOJu0YyGXx5pbik7mrkL9oW6Gbi8IFSLGs1IiVbhlFOOyyCTvOMjYg3i
 59ClyfVU+pE5jwDTA8S4sOCKTAgzwOi9peilD+qRGI75ryLj5bjx6hDrpnzWAF4=
X-Gm-Gg: ASbGncuBpzluIdgtkuZxnvYlwztaqImWRvnbwT4Y04tUPgKBifZbF77f7bu4DO1w2Wz
 Ic3zxZIRli02ZQQjYkm1JjByYsDvlswyL+xLzBEpd6h9iZwgCGU/Soh1v4dUsUw/YuSIg0/wWef
 Gzz8wiC3FiDSG+qqSQLMsAIsTnCKvlrsweaHE6hkB0XAJ9cxNNO6hWDnUJR2cbEHu68CIqtIW8Q
 c0uLxygB0UB45OtZ6jbZNYLNuYPi3B/X9wQu5vQUYby5f9f7QYzKkCU1qHP6uw1N1idZvxkJhIT
 E99JraegDMP0Z/rprA==
X-Google-Smtp-Source: AGHT+IExS6WPeOJojLQkDYn1avo+StqiYmk7Sn1Nb3vehFXK95hSurh5GZBy9GatB9hBCBugO4tTJQ==
X-Received: by 2002:a17:907:1c0e:b0:ab2:b936:f110 with SMTP id
 a640c23a62f3a-ab6cfcb8d3emr2430314666b.20.1738591146168; 
 Mon, 03 Feb 2025 05:59:06 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e47d0fc4sm765013366b.65.2025.02.03.05.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 05:59:05 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EBE505F8BF;
 Mon,  3 Feb 2025 13:59:04 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  pbonzini@redhat.com,
 mark.cave-ayland@ilande.co.uk,  berrange@redhat.com,  philmd@linaro.org,
 thuth@redhat.com
Subject: Re: [PATCH v2 14/14] tcg: Remove TCG_OVERSIZED_GUEST
In-Reply-To: <20250203031821.741477-15-richard.henderson@linaro.org> (Richard
 Henderson's message of "Sun, 2 Feb 2025 19:18:21 -0800")
References: <20250203031821.741477-1-richard.henderson@linaro.org>
 <20250203031821.741477-15-richard.henderson@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Mon, 03 Feb 2025 13:59:04 +0000
Message-ID: <87cyfzceon.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> This is now prohibited in configuration.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
<snip>
> -#if TARGET_LONG_BITS > TCG_TARGET_REG_BITS

Is it worth keeping a compile time assert with a comment so if anyone
attempts to hack 32 bit support back in they will find out quickly?

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

