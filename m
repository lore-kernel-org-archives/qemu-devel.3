Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4083CD0E6C9
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 08:29:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2nmP-0005Lf-It; Mon, 21 Oct 2024 04:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t2nmJ-0005Ka-9I
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 04:28:41 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t2nmH-0004h1-BG
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 04:28:39 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-539fe76e802so4643722e87.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 01:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729499315; x=1730104115; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=84gfC1gAjK7OCZ1PIfjtfsr/yJmMb509Tgo7dyz4CM0=;
 b=DHw3wubdC5qMzMDUmSyE2piD0fvVQx9pjeW49cO3BZWR+uW8scc/mUFcFuUjMjDzly
 MqXZ96GO31m6Bt45mB6bktYmaVBmmfS36ZCfrHcHSdfecEjCI7E/kCeYqlEJXoG5CZG0
 uiYLBbMf3DTvFRxpwWlAWEXjFT/1jDoGXSidpYapK9iAxDjVwFSkQXB3sxdkYYUGVuig
 ih9Lr8oKPaY/wRHToiVrQeG75U/8cr5n4bkP7tK1pZD1dYoCWdwO8Nr1rG/vOVGo/3No
 J9kNWPME0kEk0kURUDwpHPuLg4ZRklJopEwaDWq4TfS4APhG+RHzk7Md+iCrmnDfnSAm
 KZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729499315; x=1730104115;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=84gfC1gAjK7OCZ1PIfjtfsr/yJmMb509Tgo7dyz4CM0=;
 b=bpv8TDD5mCgJ3InaCST2PgzmRcW2prZx7Qr7FiQsBiml4058puI2/T0mENhX+2KZeL
 dio0mMgpPZI5Da+x2VYnNWPaxmrvkebTE+q6I81URz4KSPhl36nssPxA3ix9dDxEugYJ
 lQHBjGJYggUOmx2zYbhEjJ1u1KkcXyiDVOgUIuXOOUiKhdRH2DYabIpvOSeuo9R5Oeth
 3AU9/3NmBj6lCbLzvGop5+upuwr7oI7KfKhTFKwWcCXPj9OPLfSuO4fdejt6dAB6tShU
 LWuY4al3FWS3d+cs3s9nU1jnw0tC1BFSEdsQTEai+4Q8Ur5gvU/155PCTQ4egYquSO5L
 kHDg==
X-Gm-Message-State: AOJu0YyVfiHqIzfVkD5UAjnao5cAeSg6edxor9cqHjPYNgftZ6ajIexp
 yMhiZAk179x7XC1GkpxLeCZS7H++Fmv7eftWCJ9q8Ye4bZPHt9MkXFen4s2+ZVc=
X-Google-Smtp-Source: AGHT+IFmJKouy2x97hvxk2CmmBHvInwHV/lfNwAvUoqTXAH4lgqZay429g6GrOVw2HHHp8ikZwdy/g==
X-Received: by 2002:a05:6512:b8a:b0:539:e214:20e5 with SMTP id
 2adb3069b0e04-53a1550d0bfmr4587592e87.59.1729499315308; 
 Mon, 21 Oct 2024 01:28:35 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cb6696b647sm1683632a12.18.2024.10.21.01.28.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 01:28:34 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9A3115F8B9;
 Mon, 21 Oct 2024 09:28:33 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org
Subject: Re: [PATCH] tests/tcg/aarch64: Use raw strings for regexes in
 test-mte.py
In-Reply-To: <20241015140806.385449-1-gustavo.romero@linaro.org> (Gustavo
 Romero's message of "Tue, 15 Oct 2024 14:08:06 +0000")
References: <20241015140806.385449-1-gustavo.romero@linaro.org>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Mon, 21 Oct 2024 09:28:33 +0100
Message-ID: <87a5exq2q6.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12d.google.com
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

Gustavo Romero <gustavo.romero@linaro.org> writes:

> Use Python's raw string notation instead of string literals for regex so
> it's not necessary to double backslashes when regex special forms are
> used. Raw notation is preferred for regex and easier to read.
>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>

Queued to gdbstub/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

