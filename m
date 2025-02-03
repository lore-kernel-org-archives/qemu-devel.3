Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2950C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 11:35:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teuir-0004GE-N2; Mon, 03 Feb 2025 06:34:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1teuip-0004FP-8D
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 06:34:35 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1teuin-0006ka-JW
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 06:34:34 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ab39f84cbf1so804111966b.3
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 03:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738582470; x=1739187270; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HSEbdJoTKNmb9CTRr/20Itn16RUNVIDXAasyVtxzCvw=;
 b=ijWouF91axeg2lhAEvb5fSfWA2DTdfgxh55NEzZe4fKCjGULiK/HAx6P5VW0C51etO
 UhPi4+B9FXy6+isgdec+5JtwyhFNaON97R2NFFm9MeWv3MGFfBLCancreqJ4Dn8LjSJ7
 km7HboTU34+vyBZtoFhFV16A8ybBozwjkfHuyQErQUE4TwYfEC4IMZUiPayUPrYIcBzG
 WobRtbHriqmcCdO0HSOgXbFHFQqSEvBkGqkmAx0ukfFkQVpR9yN7f4vXTTgrtutzzbiG
 Lk5Dc7H9y69IZFmZtLd6tkYOl4rbu4Gc0wUlnViuUi6xAXcANm8cMWQ9ChQzvMA1QVxv
 S+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738582470; x=1739187270;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HSEbdJoTKNmb9CTRr/20Itn16RUNVIDXAasyVtxzCvw=;
 b=fbTmyNecvr4czTpUSFRd2hEaL9UWRaVF/ex9/n7n50Zfir+kTKP53VPmTYWplMu2n3
 o+3qj4K1/gP89C4nTlGS96AgYU8A6gcHjklFee5fdAQly3MEdiin2/wMa3Pgp7cOnxfg
 CreB+QSc36TxrFkIulRKsfePBjVBMhShYhLZCz/GDvmpFhB/+o6vbHhXaOvo4P4aAKZD
 RlcFVrsE5EDW8J7duPUMLO+hGRB7MYpT7h/+RkZlgAFaNWwl19Ug6RQxXDSxgKSrns/n
 BF7KL6UI5cGZsbKTM1eGhx4Ks40r+Aa8WrfcXITTH7licWFPCu8pBbkjJB26Nl3dTJMe
 CXjw==
X-Gm-Message-State: AOJu0Yyo1BijWkI365XcgqqFPUMYHQYb5749pVa6tWA1uEu0UI1X2xfi
 6F6Ex/NXLpr7W/zi9eAfmAErk7uYxiUPY9W1+j+Z9d+W0i/1HorJrzQB1eoIqvE=
X-Gm-Gg: ASbGncs1HbHFoNztOwCFUriYn7z2xXQM1pOx2ip9T0BpIiwOW4d7gKGLcRICn0SYvdh
 G91BQpZXiumiviMVFni4ba7SGXSksAhJxGerRUpMP4ill8L9yH5hlqiVXmhaqQgWOt5ZBSjffcu
 i+BsGRfm1lclqktFF42LKr1NkkJkTJSGocfHAk/gV/iszGE6VJTSvEmVRUwqiA3qcW5VOUt04GB
 ccZhki5CYbRq/3kgEIut88H9MMV8nZLDpMknciqHygIuPTH/5ZjFM03D7LrKTsz0/MdD+SUwROP
 LLLqDC0wb2uVfkCNsQ==
X-Google-Smtp-Source: AGHT+IEDa+EcN+m0ywgJMsT/BVDWZgc0oIc48XiOUDfpz9wAhr0c6KYuf8ZHFiAdpAESK2eIt3T3RA==
X-Received: by 2002:a17:907:6d18:b0:ab7:b30:42ed with SMTP id
 a640c23a62f3a-ab70b3042f7mr1035201666b.0.1738582470364; 
 Mon, 03 Feb 2025 03:34:30 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab702d70c8fsm516428866b.161.2025.02.03.03.34.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 03:34:29 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F3D8E5F954;
 Mon,  3 Feb 2025 11:34:28 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  pbonzini@redhat.com,
 mark.cave-ayland@ilande.co.uk,  berrange@redhat.com,  philmd@linaro.org,
 thuth@redhat.com
Subject: Re: [PATCH v2 01/14] meson: Drop tcg as a module
In-Reply-To: <20250203031821.741477-2-richard.henderson@linaro.org> (Richard
 Henderson's message of "Sun, 2 Feb 2025 19:18:08 -0800")
References: <20250203031821.741477-1-richard.henderson@linaro.org>
 <20250203031821.741477-2-richard.henderson@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Mon, 03 Feb 2025 11:34:28 +0000
Message-ID: <877c67feij.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
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

> The fact that this is only enabled for x86 probably means it
> was done incorrectly.  Certainly the set of files selected to
> go into the module is woefully incomplete.  Drop it for now.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

