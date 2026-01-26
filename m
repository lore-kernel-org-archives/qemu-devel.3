Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7BFCD13C3C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 15:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkOyG-00020g-B5; Mon, 26 Jan 2026 10:57:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vkOyE-0001tE-1C
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 10:57:42 -0500
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vkOy9-00048v-Ny
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 10:57:41 -0500
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-78c66bdf675so45359937b3.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 07:57:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769443036; cv=none;
 d=google.com; s=arc-20240605;
 b=KhXa77Lx7qTj+ekaB++/nrDc1nZhPc+KvpoULlCqmAlIcIuAMnuyzZ0/KcXJTdMPvQ
 rzvbzVvkUgJ7nuOnVET9/Lu6Tjeq9ftPBpYiCJrrrsdCIabS82eMQtjsrC304Y0WcMMj
 CQuf7M8r/MecRNpL6Z00x95uFcvXOPd8byGsXtezNuXGhCbDw+PZUnMFHFAmE9rTcJxp
 PckLxdPt18PnwxsxO6nAsE1Gbg7If3qt6M6cSM9DctLIihzn4HqysakiGZjxb9EoR+xY
 /0fOCN7OxH6N9D0CvLMJvZe04E9ahn1BTPuHw7c/4OQzV1LbTGLIE9thXyktCg/0IV4q
 H43A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3TFTYGTUCnfBohj+5pRRLLDiJ6Trzudjzgoa1grlkIk=;
 fh=mzmOKlaajBrAUNwZw8b5pEPo1eDewy2Peyu7iKq8ZXQ=;
 b=i+2U0RMjnXQuKVA4iGODbOCMPd8rqPZp9jmi+PjI4KvkwNwRxbIPex4nVqVf5o695h
 He59xhSsw1atuD9nZ9DhTotKwH895oMW09+8WgIWzIWRIVWQ1flUyOZ6NY+BYQl+Db4o
 Fhjhp7gnFxBu3cQNjJ0/+/nDosR6tVF7odd9siXTxmLLxmSGX0oC5d1it5AA8VwYrYXa
 hbuHifkfm3OBiw7P3g2kWA4wzWJssgwIXHU2uKOPg4qEYAp5MorXPxD3XVv1F0+CESN6
 HQV6HxWMlURsuX62kVT8nIWLJEDlcj3nYbNnVz4sJEaDCVWxGQZ8lGdQOI+2brFdeIc5
 I9bQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769443036; x=1770047836; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3TFTYGTUCnfBohj+5pRRLLDiJ6Trzudjzgoa1grlkIk=;
 b=qGLX8QVzRYiUAI8dGK2AMRKna/HKk9odGF9Jd763VZCGuCmgixOK+uRQPGwdVKVO9i
 gqtk19EjFXHUubf/Okq/qKOUVR6qx6NVx8cOobiHXt14Zx46I8qDBeKirkfYSacUYaNp
 kyBJzv4sIuZakdGWfvtB8pCgbnga2ZT/JYV7OgMkIe7ufKV1QrfdninC26C9DR2AK5KR
 7RKavk32FckFAC1m4NMfSg6YU3x4zqIOUxmq1sU8ELpeQ0KnwWwnG+qZ+/pDQKge3znB
 Zje2Ej+tLEUPV/vdAsmtIuLHZo8tf5Wp11FL6k7EVgBsvk9F/Yr/AbizJEzVby+ZqhlI
 gouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769443036; x=1770047836;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3TFTYGTUCnfBohj+5pRRLLDiJ6Trzudjzgoa1grlkIk=;
 b=tc53zkbLhiYmPTDILCmRL8TEJxA6KY7W4Yup1TnybYaO+Cy2Qw1VVJTiBfX2GP5V4D
 fPMEXmxWdfWWAhBqKfq/FK0pR9caEP1vND+H2+nZlx+C3roCgdiZXuwQrfZXWwQlyaBB
 rLe/cSp0Y6HrN0rMQLxPh/mk8gc8Pr0iTVPt1XgjYbEYU6CZcU+Oq3JMzdecISsCyaz5
 W1/UcAt4uviHxgzMhS5fkVe1/Bckp1Khks3AMXKIXRBSy0SDpEJupAayWYwGd5tUOCJa
 PwqdEB/YsOnOAhM1wcersEXWJ1bkM0fcy7ldLnrapBVYTUFX6lC2lTJJgXdSObRvc6c5
 aBxQ==
X-Gm-Message-State: AOJu0YwlTVWZc8WHqWWCQ2mBawZqRKHuz0sJ8ioiNYh9DqdrUWUATrHp
 ez0PGj3qmfrQ4OZdaR0yzdGrH/Nt+KC9RUD9SE5UdtsRH58yTTCiypNcmnINS6fAvEMygEGml3R
 iDfzlNgK5upSf34xVYZNy82s7TE9J2bnG/uWIQbMTCw==
X-Gm-Gg: AZuq6aKpqK9+31PGCAZEm87T7V0UBBgL+7b4jT5c2zxxEvd0tRmJILkKv40SEW7Zi1+
 w3Ac2pH8c8fN4UZk2sfzz9Dx6yZymdWkgLAMdeMgl86brAUhWo4Wruu8P7HnwdqtqvR1q+kOrZi
 QBL9lKH1cqGlsYyDBHo3yKPqmNtSYOrlPmSjbGyxOkEKYtxVwaonmoHpJsxLBj3lRUvIZEF6Cah
 J0GoxRopJgsdZJPkZCzuEngNQfvyJAgBQp78X8AuCBo500xggxzv6h9TF3/7oRMxuSdYg==
X-Received: by 2002:a05:690c:e3ee:b0:792:7c92:4626 with SMTP id
 00721157ae682-7945a9bcfa1mr38071007b3.51.1769443036567; Mon, 26 Jan 2026
 07:57:16 -0800 (PST)
MIME-Version: 1.0
References: <20260118215945.46693-1-philmd@linaro.org>
In-Reply-To: <20260118215945.46693-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Jan 2026 15:57:03 +0000
X-Gm-Features: AZwV_QgGONqiM5hKluAzXeGmPICJqmu7lLf-3aKE73sgb4xrgzeLRgmBbR1rekw
Message-ID: <CAFEAcA_3-YuPdkgBE_PA5ik4rH7_KkKU1JEGpYf0mm5nS=Aq+g@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] accel/hvf: Sync CNTV_CTL_EL0 & CNTV_CVAL_EL0
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 qemu-arm@nongnu.org, 
 Alexander Graf <agraf@csgraf.de>, Cameron Esfahani <dirty@apple.com>,
 Mads Ynddal <mads@ynddal.dk>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, 18 Jan 2026 at 21:59, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Since v4:
> - Addressed Akihiko's comments
>  . Do not introduce hvf_arch_cpu_synchronize_[pre/post]exec() hooks
>  . Sync CNTV_CTL_EL0 & CNTV_CVAL_EL0 in hvf_[put/get]_registers()
>
> Philippe Mathieu-Daud=C3=A9 (2):
>   target/arm/hvf: Move hvf_sysreg_[read,write]_cp() functions around
>   target/arm/hvf: Sync CNTV_CTL_EL0 & CNTV_CVAL_EL0
>
>  target/arm/hvf/hvf.c | 167 +++++++++++++++++++++++++------------------
>  1 file changed, 96 insertions(+), 71 deletions(-)
>



Applied to target-arm.next, thanks.

-- PMM

