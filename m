Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF8EFA372A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 11:22:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbdE0-0004Rk-JK; Fri, 02 Jan 2026 06:21:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vbdDz-0004RU-0I
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 06:21:43 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vbdDx-0007I5-ML
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 06:21:42 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47a95efd2ceso107801715e9.2
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 03:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767352900; x=1767957700; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tFVKHmnkxQ3qobL3YmMQOytbDJSp9SIKyMZ9YJQ6t3U=;
 b=b68s9eJSUGMQ3YknEEOUuQvsEx8q9x6Hwvgx1Q0Mn0GD1zjgG5001y2keMGsm0rUdw
 iGj6B/9vavY45tiETufT4aejYQQT1actETDrXwIiHLvci7GMoogG8ZzANt7y6HlMYsGF
 9szeSlLUsxYaIDZDJHy7wwCWpO694TOXRRTCMIGYpKBvUDNkMuHmYPlw8MXDVjLJ1GL7
 BJ5brApVR44kDs0kTqQu9ShWMP2nOdXhwU27g/k/XOAPOyyK+P02VgzWy9vK+lugMHUq
 IIubVYMIaXWbrry8060Je6FKskahplXbNPEumaoCGrOnczD6W7Y1yPiWrei/yQNh+w5Z
 RYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767352900; x=1767957700;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tFVKHmnkxQ3qobL3YmMQOytbDJSp9SIKyMZ9YJQ6t3U=;
 b=Wwj1azkFk5QfwZ5SkofBwIFQdYcpDt3wq0A+bCRCt/MQ4w6yV/9mERAMe95E8MFkYE
 4VfH9c6YJneRwTo5yMHUr6nYc5N0e27EgJvq68NZ3a66LTKuQlTEkhWYBiI1WMx15Sgm
 XtXxFGWM7+5XblHr5twjgtvqTfjg0vhzJ8JVVRcfMNDMO557bGpd5UKAod17y/XsJtKs
 4i7Xa3jQ/oos3pvtDlMdRnQbNzqFkZDeqHEdGwQ3XAGJ0gm/FQevFQU0KRUV1DRM+4by
 k1pThlgp5KjqwDKW65OkRsg0xO5UthuoQTf4T9QsgiUylVpIs6ixNtlXlCXQn3z8WYZF
 aTPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIAnZ6zz9sjkYoh1rYLV4wiRSNSDY6n0LmNKGvkbxy/Ms73ejfk/v93z/dyNpkXFLMyysJzsUpCFJ0@nongnu.org
X-Gm-Message-State: AOJu0Yz2HGwvz7BYhWLeX9e13UKQ0FlxaZqRBzI5LMZ8mPeq6aIBoyoD
 CT7N2uuUyEtkUbgPsETVfNciUZdjKfYJqHIVVzPh7c4Mg5YFVmkhkc+pbxikjAhBNuQ=
X-Gm-Gg: AY/fxX7+BpKjoOMcmLp4he0ZKYkZ4EG6fRYAX7o0DFKShsTT8FggT5Ldmem2PmS1XTW
 6gdYpYCQTCAtUzFWcH0y4G8mLxG7gpCepTLLKQco1rbIGhAKSIGe8bd6n7kPSNFjjKTrivBHgfu
 ded+Y8DLNqR6nHAUCuz4Qr2nqTgFF7Y+rVfxq8Fr/oktoiuOEerseavCQjZtbYDPyqiXFyhdR4T
 pJysZWdK9jnUejjqBBbjku8xpfPsmYGKUUcf7y9kBgM5zJbqjL1E6Htetc8NQxt/PqP+BixwUce
 nmEwxU19iU1HmBpJ6Ft0vHKbTB2K27cLV0N1Own0Tn7DR9xbpc8L+WRRUAQxe+mwanQKU5/eJfq
 OTMSQZ5zH3O2dHmw7vlBgPreHXtlnf2U8cwEHLMg42Od5LdDzpSmuxDZmr+giVJa8mhXY/Uigw9
 Ev+1bvARMVWKI=
X-Google-Smtp-Source: AGHT+IHvaQpeidF9CMkkjwowToaK3zs/8Qn3f70gynWYBZtldegcjyK+vMk3LfHKaXZ895JpWAbKGw==
X-Received: by 2002:a05:600d:486:10b0:47d:333d:868a with SMTP id
 5b1f17b1804b1-47d333d86c2mr318702825e9.33.1767352895490; 
 Fri, 02 Jan 2026 03:21:35 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa2bdfsm85127062f8f.32.2026.01.02.03.21.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 03:21:34 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 25AE25F7FE;
 Fri, 02 Jan 2026 11:21:34 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org,  qemu-stable@nongnu.org
Subject: Re: [PATCH 4/4] target/arm: Rename access_aa64_tid5() to access_tid5()
In-Reply-To: <20251231170858.254594-5-peter.maydell@linaro.org> (Peter
 Maydell's message of "Wed, 31 Dec 2025 17:08:58 +0000")
References: <20251231170858.254594-1-peter.maydell@linaro.org>
 <20251231170858.254594-5-peter.maydell@linaro.org>
User-Agent: mu4e 1.12.14; emacs 30.1
Date: Fri, 02 Jan 2026 11:21:34 +0000
Message-ID: <87o6ncw98h.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> There is no equivalent access_aa32_tid5() (HCR_EL2.TID5 only exists
> starting from v8); rename access_aa64_tid5() to access_tid5() to line
> up with the naming we now have for the TID1 and TID3 check functions.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

