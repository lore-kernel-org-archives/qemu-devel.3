Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D31C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:48:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWxoK-0007hi-EU; Wed, 02 Jul 2025 09:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWxoJ-0007hX-6S
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 09:47:39 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWxoF-0006va-V6
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 09:47:38 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ae360b6249fso896603166b.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 06:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751464053; x=1752068853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xvSTyXCInEmAPQVIOEJmrmimprBwMw7NLncV96oTeJU=;
 b=xRp6fjz3hnR5DP7cRIMPGBMlCRgbUfh2eq2GdV/lhEDLfnVKQsfz21hzD6Nsq5dDdn
 MS9uaNZf3qf1zC4F75BeYxMdFnYTOJBt8oqo94ffCG9+3RgZVNjLr0uKuQpESpZQ0w4R
 abTAe9juCQFb8jE3iLHjjbT/ALNrNfr9mlpPkCxr4ESrBxUX3igCxnSixFN8WdLdK7er
 wl1hOzFlvSRfbNIjm1k7soB5+nc4wiZnnbxEobzEKImuCw/DS7mc7DfKete/AOsBrVX0
 LuWkaIatWp6RALpJSspQRSdCPhyAyI64kbeGl5bq14u4XxNpiqiDXOsug3tEfbwfL26a
 pCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751464053; x=1752068853;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xvSTyXCInEmAPQVIOEJmrmimprBwMw7NLncV96oTeJU=;
 b=qjXE3JQyorXWIhtc1eD5FlRpwKrUqRCyI3KGAc+cKS2J4S/fJ3cH6VdQho2y5jae3l
 goxEAPLyxGIVSwhVmWIlFoJkCAUvCp8UHfoGQzy3WP7diLgJHMgUh+0xF434Z6smdEYH
 nsheiMqaF65SKIhqh6XtYXX2edN6/EEhs8z/Tf/LU+uLI/fvAi+Z3u2BBeMFGXvVUu2I
 Ghk8uugxi788zN7ULsMPvy2HkCcN+oMvj6nIxqEJHG1h8qyHc0btZXmok1TGQXNeRfD+
 BENlGZ/R+ZsIYBvPpsHb6Swo3XPp0R8bhjQTUwXx0O/WY0AGeYiH+YOP60onTWtpC8oe
 siUQ==
X-Gm-Message-State: AOJu0YwWnOv5qXCK35pQ6Ejc4/4k1Oe2vm1mnb0MJZovCPNihD4moyyi
 dT4z5JDoTYRB8UwJvUEi8Sw/FiLVpuFSqXTqtc/DgNEWr3CoVKRR/E9CsWAF0PHUtRaXfuvg17V
 9ut1z46s=
X-Gm-Gg: ASbGncuFE5ER6QYvVnWjgiusQR9uFyB2rF31j1v0mMfT7ZHC9SSckdQaf65BJYMv10t
 lk+PhNla+3LhFDcassyIgY5k6JQv2RXW0XjkOHwUU3qgbkM0F5YcUALTztTBvy9faqp8zRBhndk
 1v8wfGMNyYJ/rbztMu8umTIHI/0aXWlFtQyH9wN+fDCm/8nu84UvDTR+NDas4Av+OzBZrm7ko+6
 OwzYb9oOnad75iK2K2ArGgBdrqZhfw0jnaDs42ar21RtNkuiUGS5BXCSnojdzYbeRoZn5eawfg6
 H4lNsEy6b7uwBtvu4SXKgOct1T40P+4vOb/YdAN5gSU2kTQf6DQMmN3xWCygFeI=
X-Google-Smtp-Source: AGHT+IHQ31QYe5zVLaAERciydHioeJZMLkzzSHsb/vghgm1eBR0Lw3T/EFsqC7+WtQNinEzJvettCQ==
X-Received: by 2002:a17:907:60d2:b0:ad8:9a3b:b26e with SMTP id
 a640c23a62f3a-ae3c2da9e90mr289043466b.56.1751464053399; 
 Wed, 02 Jul 2025 06:47:33 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae353659e12sm1073012366b.40.2025.07.02.06.47.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 06:47:32 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D84445F8BE;
 Wed, 02 Jul 2025 14:47:31 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  peter.maydell@linaro.org
Subject: Re: [PATCH v3 10/10] target/arm: Remove CPUARMState.vfp.scratch
In-Reply-To: <20250702122213.758588-11-richard.henderson@linaro.org> (Richard
 Henderson's message of "Wed, 2 Jul 2025 06:22:13 -0600")
References: <20250702122213.758588-1-richard.henderson@linaro.org>
 <20250702122213.758588-11-richard.henderson@linaro.org>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Wed, 02 Jul 2025 14:47:31 +0100
Message-ID: <8734beembw.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
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

> The last use of this field was removed in b2fc7be972b9.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

