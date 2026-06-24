Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 998AECDB481
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 14:29:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcObL-0002WC-OO; Wed, 24 Jun 2026 10:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcObJ-0002TK-Ng
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 10:29:13 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcObH-0000rf-DP
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 10:29:13 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-490b3637b90so7614305e9.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 07:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782311349; x=1782916149; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hbJ6v012wSu/lA7Ip8ksZ4TZm3hqzDsLRB9ivd33iEE=;
 b=CdXvJcb18KlxMGnjI1aTMfhynzUNzQSNK8mpcjQ/ukx7Zb9I8xnoAYFvfKeLxHhIzc
 vRDi3Var8727akZEDGyCYVv1xQruC2vY3r0pkXWzJWgYFgLS9pd9OGtt6FRpk4sU4poh
 sS69Xr83HfwCqdrxIEc6VTNBiaxnymCzS2ARXohApNRbckakk+sFlU60BGW/zBl2YZFa
 ILLIw5Vk+5Og7nhd5Irx5YS4hAYMGBzPwu6nMpUxTpMsBPUiAHZ03IqPUwd3nKIWJZJ4
 zBIkh3OUNRLJp5eX5IOW3ICVKM704r83i+ysBQF9vhmALa6A01JeZ1Gja9EK/lmrMCPx
 pLJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782311349; x=1782916149;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hbJ6v012wSu/lA7Ip8ksZ4TZm3hqzDsLRB9ivd33iEE=;
 b=l8EWwMCuoowhqQ295VOQtnfkUAqQ48cSgbkLYGUSWmQYpTh/c9FRnnVxjIOqexwamA
 tcIV9s2z2DT8GRu9mgqbPhYV+wZWvKvwJTqt09LbRmCBv/QK6lN92BUjP2ARw/rgaw6I
 ImqfsiwyMmsr8k/hSNCTJmRaXkomQgucxvQSOgcD4nOH/0fVvHsXWXngA0ACBFwNri4X
 A01On6cuI26QkMUlL24/8l47kkRX/fHzsZO978yzpQfzHcfh9sO9QTsqJ8iSwhZu/GqF
 zfxhzzG6Kr7I++qUCcGYpT8Bv1gdhzLhAdoZmZdADb+UvtIH9i3ynz2Ti9/vBvoraMh4
 DP8g==
X-Gm-Message-State: AOJu0YydvFNHkenKaceULEhXq1+H/V+1EA/+WRo8rmYNBuLbRgq3iWbn
 6v26j2Y6x88/CBT/wq9OyiakCuFey6ofnRZ2nilJMifw4CO3w50wKoxl7Iyy0LlXUKY=
X-Gm-Gg: AfdE7cn9MaFCksVMeeHlWiXjzQw4+LE8mkB8hhHL/wGCisLQa4fLGR2dAuzZ7hkhQoa
 pbaFVOT4PPg1GN92FjAiEanQPK91WefMvRDd+BMkeOIrUnEx8w9E4MMrsgsFxlagNgRxGHjPtpo
 YnlULPQNngkUSfItTCIEYlR/EzfoMQPJHw1jwsJJ686nyKp3V4RjNkifG9FxGLydYmAK8vT+d7E
 FeN2r2c/IgC7N5G8a/Bq1pQ5fCkVVUrlKMxrwwoMxD6ILA2QmIdXCU9sF5x26oyL5lU6RB7kqeF
 JvfIHPU+kqId/QnkNjGU3x4FCUC42xoFkMC5d/IOLhe35333gALXiiv3iTodtG5VumMiMNFIilz
 j1dI+KJ8DK/S2HgU1PIOygMQGiE+XUvSgm3s8QxXVm1g2x2AFgA89vbeCp3FBpJOPGDgtxuEacl
 bEsQLx3dyxrGxG
X-Received: by 2002:a05:600c:c0c3:10b0:492:53e2:7712 with SMTP id
 5b1f17b1804b1-492608726a0mr39830165e9.21.1782311349020; 
 Wed, 24 Jun 2026 07:29:09 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4924923392dsm733203025e9.2.2026.06.24.07.29.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 07:29:08 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6ADB85F80B;
 Wed, 24 Jun 2026 15:29:07 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 qemu-arm@nongnu.org,  Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Gustavo Romero <gustavo.romero@linaro.org>
Subject: Re: [PATCH 02/27]
 tests/tcg/multiarch/plugin/check-plugin-output.sh: take test output as
 input
In-Reply-To: <20260609214745.772536-3-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Tue, 9 Jun 2026 14:47:20 -0700")
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
 <20260609214745.772536-3-pierrick.bouvier@oss.qualcomm.com>
User-Agent: mu4e 1.14.2; emacs 30.1
Date: Wed, 24 Jun 2026 15:29:07 +0100
Message-ID: <877bnoko5o.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> Instead of executing test, just read it's output from a file. This
> allows to standardize how to call check plugins scripts.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

