Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 985EEC87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 08:47:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiqqN-0001wD-Lb; Mon, 04 Aug 2025 04:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uiqq7-0001sh-FY
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 04:46:48 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uiqq4-0002sO-6C
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 04:46:38 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-45896cf24ebso30395705e9.1
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 01:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754297193; x=1754901993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ALTJAvL6LhkgSmWPjy4X0yEEslYCl4NPIUD5DRrmdE=;
 b=vOQc8YByf9FTXty57xF3P+TjDPHt8uIb6QT+KMDgRNp2Jf0IxxcicAhM4kei388G7W
 KQvq3W9kM6UtVqI9du7LS1hMWqMXtefJctppa9gbVkwmuER0xyWNoJ4SCiIFvdrkSLD7
 FGitVgczH1+/s/aTLap3ItLutXki2AFRg1bgyYEp/0d0xO96JV0359f52V9m5CWjwWC9
 mM+Azpac5qC2BusadXz0UEc7g7QOGLMvgZ0gwB8HKtL4I2cWY/TzQLZ5y5tpdfjKUf69
 xem6NLfzWRySPGbchNOvp3rmg2AKZlIccipxQio1UiTtuBVxOJWwVo3PZDBUkVC8hfpw
 nRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754297193; x=1754901993;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2ALTJAvL6LhkgSmWPjy4X0yEEslYCl4NPIUD5DRrmdE=;
 b=mysbq8ie0g2SHYHM7wjvTdklpJHquaBjS4M05YXmuUWt0aQCh9NsEddRCIxpVnTgHc
 8TG0HbpLLa9f7yTb0NQtg5gj8KbVq46eW35AI4fZvYpj8CuArC/oAYvvepKl+bGF1TN3
 btLTSChNkJ2oiapCxrMwWAtnrddEtEbeJQ2K4xB2zXclxOOhDR+UGV2dB6vyOUVIyggS
 PrQldU93CRG/Ovp8qXXJVxlKPTtxQquHjeB2aGD3bCKy4Hk6aByDBgjHjz/pQYspFAqa
 MVX5FTVCLPgYbWgnT9airwlozlIgROXsrFIPYVmLDhThy/O7Aa35OjqJtdfIgrVXeJIO
 DgQA==
X-Gm-Message-State: AOJu0YwRgj9z9Q/Y5GIynHIPia7C0KL8hGO7cTJGbboQJw5J8fXGJaqI
 SbXqa1jy/r7Nf7+Oz0iCoJ9yaqtUoA4+2oZd6vzyNwGaWjNHiWBZugCvR2jzAHt84MI=
X-Gm-Gg: ASbGnctNf9yMdIuq0HYbX5KTPB4corAePq0fdnIBNDOc/SGoczZet1xBIXIkMSsSrrj
 wsM8+qZ1JRZexX8yAbatSuA3N4vVNeKtiEcbf5OZJDqeaQLjTxGbJdgx54o89g/75jkJWum1epw
 XhbF4TW0HWZux7QIp9sRw72pmnmi2HhBZxmR0Fdspnv62XBItjuhzsuRW2UQuouSlrz2F9GiUhO
 l/yqdwPg5aRZ45IDAd/Yh2yrL3NJLzZHM/vNDHY6ECcr5U80MgJrF/V0sVWz6ktfBFeiafnkU+g
 v+gfxL7uv1C0a9PDXRRAPxu7ce3awIMitRBE++tCMVRGEqOdcVhMZLmYtGbi+ciQoD+7/Y/PaOH
 RXnrmEXEMDSJbEHo2VN4yyMM=
X-Google-Smtp-Source: AGHT+IHvACHunwdt8s+V4xe/gC49/YyKCloEBgwwkTA9jQcMedv5nh+7wRj8RnphAlhD2AmS/UiKZw==
X-Received: by 2002:a05:600c:138d:b0:43c:f44c:72a6 with SMTP id
 5b1f17b1804b1-458b69f2c1fmr76384415e9.2.1754297193359; 
 Mon, 04 Aug 2025 01:46:33 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3ac574sm14793969f8f.5.2025.08.04.01.46.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 01:46:32 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8D18C5F88A;
 Mon, 04 Aug 2025 09:46:31 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,  Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Gustavo
 Romero <gustavo.romero@linaro.org>
Subject: Re: [PATCH v2] docs/devel/submitting-a-patch.rst: add b4 section
In-Reply-To: <20250717-docs_add_b4_section-v2-1-69212ed39299@linaro.org>
 (Manos Pitsidianakis's message of "Thu, 17 Jul 2025 21:59:28 +0300")
References: <20250717-docs_add_b4_section-v2-1-69212ed39299@linaro.org>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 04 Aug 2025 09:46:31 +0100
Message-ID: <87y0rz79ug.fsf@draig.linaro.org>
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> Add a section about b4, an actively maintained and widely packaged CLI
> tool for contributing to patch-based development projects.
>
> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Queued to maintainer/for-10.1-rc2, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

