Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D39E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJFT-0001nG-Tv; Thu, 19 Dec 2024 11:19:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tOIjh-0006C6-Ut
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:46:49 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tOIjg-0005vJ-FS
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:46:49 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5d7e3f1fc01so1741391a12.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 07:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734623207; x=1735228007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ONHbH48quKQ6AaGNzJcEegS0OWBBUfyvhqjz9Ljd4SE=;
 b=Mz7x+HhtjCIO86hhNVMKAzArtKIJVb2bOkyaS163DZee7ASA+cMOnNIv6bcgKQ+NmU
 HEdgMqczW2kw7I6T3pYKVfLAc3GpiwyeGSiHjqVYXMX+KcanRkL2bynNvYH9pRQkSHlJ
 x9QPc+PIdGdLEr42mQFUWLE/hB0iWF0UR3KDc8j9c01j0wWCCBXuGKnR1bdV8JF3bmwr
 rwSUao6+c8jB1Ge/PRIAaV9os5nqQ3ZAJS2iXIV9+LXhbrqcEywb1zXCGqGhGjP0aQoh
 /IM/5rDJuemmdegFi+Vse5vWuXpXikrjqJoCTDI+1Kv8BBNfw+9v+Z9yVM9PO71VpShk
 isaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734623207; x=1735228007;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ONHbH48quKQ6AaGNzJcEegS0OWBBUfyvhqjz9Ljd4SE=;
 b=jjTh08shuXNxXC9AmPaiVnuXYjGowoOrD2EZhRFRdST+4LnZvPnSqhiUAzKcl7DVJl
 QUCkkLtOlQWD0/FtmwtqxhkIF33Y/msWd7ZH1teOsUrz7GuyTpzdsccJqs/UsIWnz2vP
 03Q7hBVqCwI76QGwIpJNhexCggnuDwB4+6vnyjK+cERDZhonYoCg0ssV2jtmnwymS/Qc
 L5Bc/AhED2/9YN8oH4V/A54nGpLyzLYQCPfE7vSE7xsyYfJCdgLo2NunTxPDHyYlqjB0
 6Th+T7RJVwVNkeXT3WC7b/1M/tiDUy6lipMTPp/YVBxRfL+g6xQSkbwDiBI0F606w5kg
 QE3A==
X-Gm-Message-State: AOJu0Yzw2Ya9TsB5CMUe/2JLPqcaVfQ4g72qpq5/wTcZxiW2PtTmtc3C
 tZjGXz+kvuNijkj8Se9aQhccwOmE1OMO9hLRkMU+YiQixr5P4bfodfDCGrOZCYM=
X-Gm-Gg: ASbGncsOv2L+bxznNRIMhNIUKYnCP3BM+9DPp2e/P81gpVlCthKxedKMuyLWZEHVJDN
 ePP34mYnmX4N9Oq+qkOg1hFzXeCKONmtm8iFWNNYMEJ6ewAaaChrE2hC0O/U7h1aJY3Y/VJiLZE
 vZNv1g4PzrfygDktivR+7SA0HxPfzIxJ6PW7jH6yVq6kv6/QXr4OnxrFYyalPylxn7u1afFZqJe
 uZmByV39MlGRViJSLmeqPdi+u5Xj22nkQzC7Hx4XBeAIUwC/XabBoU=
X-Google-Smtp-Source: AGHT+IGnQT502O+Kml/uyr5waEO0W78aSOBOMLOsFd22TIRhk9432XeqJxHtb4Se+0kSNPecDHc36g==
X-Received: by 2002:a05:6402:5385:b0:5cf:43c1:6ba7 with SMTP id
 4fb4d7f45d1cf-5d802852dd3mr2997896a12.30.1734623207040; 
 Thu, 19 Dec 2024 07:46:47 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d80676eecfsm798659a12.19.2024.12.19.07.46.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 07:46:45 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0CCBD5F867;
 Thu, 19 Dec 2024 15:46:45 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>,  devel@lists.libvirt.org,  Laurent
 Vivier <laurent@vivier.eu>,  qemu-trivial@nongnu.org
Subject: Re: [PATCH 3/3] docs: Replace 'since' -> 'removed in' in
 removed-features.rst
In-Reply-To: <20241219150203.55212-4-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 19 Dec 2024 16:02:03
 +0100")
References: <20241219150203.55212-1-philmd@linaro.org>
 <20241219150203.55212-4-philmd@linaro.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 19 Dec 2024 15:46:45 +0000
Message-ID: <87ed233cbe.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

