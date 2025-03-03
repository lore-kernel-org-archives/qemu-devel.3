Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08437C282C6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 19:58:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpBuh-0006f5-AY; Mon, 03 Mar 2025 14:57:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpBuK-0006YC-53
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 14:56:59 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpBuG-0002cy-Ls
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 14:56:55 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4398e3dfc66so43920445e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 11:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741031809; x=1741636609; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fd0Pge+LQMofC6BhAVzK4AO8A0rGptnTNZXMGBhg59U=;
 b=dbsusJaOqL/G0O9GlQBGYWAtGTcymHjtSPWIErpvTxxNR+ouI4vY5RaAEEePGvOXOO
 MT2GYKDzjIcP8ZhLPy7p8JFEPd9LOn9irZVRSNv+0UgavUSIdHWoB4afcXoX0/PECayc
 hzpTqHKozz2IhWcGi//TFmvS2NIykfW/45lYlSaOuF2B18YcPkFlTa1kmwKQ0uLXbdfZ
 xJIMG21s41CBxI56OlyiXbDHjT/cy9yk+2Hj7sBjVPT2fJiPqJkWjN2wgFpdda4vLY5y
 ukQMHFcq1bJUCQ+hFPouBhPAJl9FYuRaVKMJP78RmTNFb4x8MmiyK1VVsVgax+lCI/bA
 7cnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741031809; x=1741636609;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fd0Pge+LQMofC6BhAVzK4AO8A0rGptnTNZXMGBhg59U=;
 b=vOAr05pTX/r1qNJe04RZxZuJRNDHc20RDwl/l0XclmuUWufhJDKzSqDgOA0LQGaZyU
 7ubhgbP6VUlSYMey112JEgQkGyaMm53w+3alCDBBJg6F82/mpHsD3XNHl9dJY/NNp02p
 NtjaQhg8/gGhGgeHQCAGYVaAfQkZn9TPXo6Fvm3lfntxjbqCfKMoy3wUwnfQZJqumrZ3
 uy9ALLtebG8BUzaIsuKEDgp1m9VZf9AxkX7BXjlGG9KF8J4+RoUsZR7ueXWiWeLaVssO
 AYmwi9dhZ1NB/F2BoOtzOQO6w/RniQ3eQQJjDeo9GAV2opHP2YXZmkESaYlUkwg+7gn9
 Q8iw==
X-Gm-Message-State: AOJu0YwhyMZPKehrCksoB2tdlIWyG9S2B03NEqsVCTev6kJMWPHyZ7E0
 8j+6bMEPs+VIJjtC1up22/4D92EcT+er20RLEv6Kcdl7TRQlWSYk/9QTmuoB1DE=
X-Gm-Gg: ASbGncvJ3gatiW6eo9Al6kfg9SZYpz1m715tLImPQWMGL/arIOgBBFYvq4hDj/Ih4P7
 jpngw64HeD2E4UKnmpzqZBnU+NMeZGpQJ/tOaHidUQmBaEiT39JTakIquZU2aem/tUAyePVumIF
 W+9enTt1JA6BdQaN/hxlHiP5h7OpzwG1oNXUtgJydlC2axHRsxRfVPeIJUiKgist+EYC/ipJPwd
 QQvZnLVCZ6R5hff4/LhS0jLSZivGYIXgrCNMHt070d+d/o3BFodArh1DUnThaNK8ja8gGjI+2LW
 DCVqElbIrAq+WCCfHBl8p61KZCm8rAryyirithngNIyiiGw=
X-Google-Smtp-Source: AGHT+IHxKPdL8pEHpP4/K0dvs5DWLOSULhGxByHRsxDJk1swJ3rL6qY+1wuE9e1gLFIar5BbQKuOPQ==
X-Received: by 2002:a05:600c:4f86:b0:43b:ca39:a9ca with SMTP id
 5b1f17b1804b1-43bca39ac88mr14950285e9.16.1741031808919; 
 Mon, 03 Mar 2025 11:56:48 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bc63bcaafsm30626415e9.28.2025.03.03.11.56.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 11:56:48 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 857CF5F938;
 Mon,  3 Mar 2025 19:56:47 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,  Troy Lee <leetroy@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  qemu-arm@nongnu.org,  =?utf-8?Q?C?=
 =?utf-8?Q?=C3=A9dric?= Le
 Goater <clg@kaod.org>,  Steven Lee <steven_lee@aspeedtech.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Niek Linnenbank
 <nieklinnenbank@gmail.com>,  Alistair Francis <alistair@alistair23.me>,
 Joel Stanley <joel@jms.id.au>,  Andrew Jeffery
 <andrew@codeconstruct.com.au>,  Jamin Lin <jamin_lin@aspeedtech.com>
Subject: Re: [PATCH] tests/functional: add boot error detection for RME tests
In-Reply-To: <20250303185745.2504842-1-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Mon, 3 Mar 2025 10:57:45 -0800")
References: <20250303185745.2504842-1-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Mon, 03 Mar 2025 19:56:47 +0000
Message-ID: <875xkp7urk.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> It was identified that those tests randomly fail with a synchronous
> exception at boot (reported by EDK2).
> While we solve this problem, report failure immediately so tests don't
> timeout in CI.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Queued to maintainer/for-10.0-softfreeze, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

