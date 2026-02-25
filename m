Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C51EFD214
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 09:24:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvB7t-0006of-99; Wed, 25 Feb 2026 04:24:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vvB7s-0006m5-05
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 04:24:12 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vvB7q-0003tv-Gr
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 04:24:11 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-65f771c6b89so1444635a12.3
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 01:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772011449; x=1772616249; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q5aWpO6UmIMbvDKAUDubZlmg5+9rL2Fi/OOuWOyJBb8=;
 b=pU1/0mULizPrkOHfoSnA/dCUPYklLl2c8lbNaTOlhoEN+fSiHvtu8grUds4qWl6iCl
 lAsO7udF9kvFNwFd0Q7p5ZIQ8ezPV/k4xV1Kosg4q9Z9tfHlNMtpPmcrAdm+22EsF1Eg
 xkxzuDZaJo7S2sHUBG8LA85AjnRHZdKgBTxhIxgKd9/PMqgsBJ8WyJsveIPa29Zlx/ho
 P1KRS4oT5yjL0vN5i8b2dxZYDlrTpODwmY+bRg6PrB9lvht+XvD4iJafiFxyCH5cPf8S
 PeOjPNRJkU4i5kecCKL7L/BKowCbLq/V4WsJXZ7Ht3hVy7JrTKTUxo+cLDBqYn/9j/bX
 AFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772011449; x=1772616249;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q5aWpO6UmIMbvDKAUDubZlmg5+9rL2Fi/OOuWOyJBb8=;
 b=dK3/Omib0+fXImf0NT3w65Nx2Ck2+5g3CoD6pPaj0lNqqpd0T30agYQwXo4krqQ7K5
 YhHqN0M6Mcaap5J5OV8z2oc0D6IXrECpOnT4Z1YBLJvoaGFvDYDHE6f5yuOjbAfjLv5D
 al6GmSUbF7RzDEvpft7s2L21l8M2VtNiedQQyWywRn26zfdlARk9+/FQrWEt+Sw8KcQT
 ltML7oEgZ2Gq8uu8sBnkTIxB8GzfKf7VSolgmQRn8xJr0/JTTicL2OFlrkNzWYvGzQu3
 p06hFrE7kUa7fCa39pI1jtywKx7pdrupEBlbtabwwtFO6CvhvEB/jCaigVOK3xD5Tnnu
 pdlg==
X-Gm-Message-State: AOJu0YxeNVpOBUxqdcyGHAhj856JzsceEbf9sZsVrvFJGoykmrLhsCS0
 tx7cfCY1cB65Wtee2JmPeJFyuJIvNqDZX92sjQUKIZHiMVdbmQcjORIILKgjOTMTmvM=
X-Gm-Gg: ATEYQzwst3ufAB7VkuVBCyoxrIKlT4quamRRFwunEaT7FX0XKiHelLMiSgLw0hbsCe9
 Mdo0imDCXtpBDtfVRzJFGez5oa0SKWNBjgMunCNpCCfb4TrSrz+1DWjC5iB7cDIxbHe5LocddOb
 AfLdOgNuOSSnGfQjj0ap4UK8rNYGg/R/xrrX2xAB5yf3VhdBfyDHcx01qLpeULPq5BlI3ZBifu4
 TqnLVgZQoLY7yvzo7pk1ZTrBm7cFjpN8Nebcoxf3GFtdhs/ZWduknjlAMTlKyxGnY4M9UGYrcEU
 DbXdkyREA7ZtrHENylaHZa0adB9Uz4p/ES3+QaEz3qv5Xj5AhHqLTYNXyhJYGhWFAhVQj3gBHHj
 q1Z3UUjuJZf/6mgj5tINhQO2pox86Q/baT7PXUjMbMJCxWI8jW8+Q/Vx5k2LG67ingqup7tLj2U
 iZQyBLJlA0rs9UxZ/2Bficq84=
X-Received: by 2002:a05:6402:3585:b0:65a:439d:8289 with SMTP id
 4fb4d7f45d1cf-65ea57e33fdmr8586667a12.31.1772011448502; 
 Wed, 25 Feb 2026 01:24:08 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65f72019b60sm969345a12.1.2026.02.25.01.24.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 01:24:07 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 118B55F834;
 Wed, 25 Feb 2026 09:24:07 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Florian Hofhammer <florian.hofhammer@epfl.ch>
Cc: qemu-devel@nongnu.org,  pierrick.bouvier@linaro.org,
 richard.henderson@linaro.org,  laurent@vivier.eu,  imp@bsdimp.com,
 berrange@redhat.com
Subject: Re: [PATCH v4 7/7] tests/tcg/plugins: test register readonly feature
In-Reply-To: <e6be7001-491f-4f5b-9aeb-3d27727d7b9a@epfl.ch> (Florian
 Hofhammer's message of "Tue, 24 Feb 2026 16:58:25 +0100")
References: <909b0a4f-9759-4e27-bba8-997ae2f41bd6@epfl.ch>
 <e6be7001-491f-4f5b-9aeb-3d27727d7b9a@epfl.ch>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Wed, 25 Feb 2026 09:24:07 +0000
Message-ID: <87a4wx2n2g.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
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

Florian Hofhammer <florian.hofhammer@epfl.ch> writes:

> This commit tests the readonly feature for registers exposed via the
> plugin API introduced earlier in the patch series.
>
> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

