Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A506F9EDC5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 12:55:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFX5n-0007Kg-Le; Wed, 22 Apr 2026 08:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFX5i-0006wc-11
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 08:54:06 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFX5g-0006Co-EC
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 08:54:05 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso56164305e9.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 05:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776862443; x=1777467243; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=00AJ7UrUeXPy7ZqKcucMiGTlG4wrum92TpmohAq+VBM=;
 b=yPBUgZsIdLaQU/x6QlxIdhfwtYEn6sLvFOuNq4DyLMJ1jhpxuT5xi7FxulTcbF4eeO
 Fl8qDfl3IyqJBVoT8DPhDVf43RZyuhWkzmvHkWfRcDLm/i3k864ihv0fVrjVy14IMekt
 5so1hp6yUOUs3/3Fy0ZrUKx8D9F4BhsHIDk+tUYxNFLF4jfEd8zzbudAQTKHekl6OVAq
 shoVYkY83D3RAWnZiQMAdrkU9USjXGiVv/av2VFAVfRN+zPE8tYY1Tcfc6Hsrs9eDspc
 /fm+LmDsUXMOdvUJqE+9I/WmDF6TON9f88zzBY1VH3X6FsJoDomR3wCq5Y5h/uYoH8we
 kjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776862443; x=1777467243;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=00AJ7UrUeXPy7ZqKcucMiGTlG4wrum92TpmohAq+VBM=;
 b=WpH6gV9Cut3t/xAnqJNcd72QMrv1E8HEsGekFRI/p1hSMHbyPWixFgruhHzGC/fM1W
 S6qovBpfQAr3vqIHSQP85m2WdTZhzL7WIFf3eZxLXYT+Bm4KN+mHVGv01lk18TMuCGal
 8HNvjVJIaGRZj3R7VVzn3Ey9gkeuFkDhZscra4kowR/wWVFm0QGafjpNTNkz4giTJqc8
 W5KxiE45m3flpDFfOTQDFBb5zZXQL4VpldUxExJ4Fneli/9YJFpyo8iC+zuxukn7Qobk
 y3+6W7dZZPyJpsE1xlJuVQsEPC9otawE+JLzQ7vo5rWZNlEOrUe+23urzOucigW2m3c1
 /lJw==
X-Gm-Message-State: AOJu0Yz2Bq9ouhq3yDmHY6b8YrhJG4kIGiThhg1z3kBnpPl1m37eY7bk
 vCG/hy0+oP2UL0PK1rnnmgbWTaG/+cH8ds25I9qaj+5o5j4eFhxQ+XKw7wKmDcOq6pc=
X-Gm-Gg: AeBDieupgPlHzKlIFvCU2B47tNB7+McDRPboCPsr/Xo6/sfGMesdUf+ZCtfJm7+XDFj
 M6mc09Bv/74S4NJnc0Dk5ifkISYdhVg+9Q6wUaB0pjSXKHq6SwgJ5jYHuwWMStuf+pM643XjQlx
 hnLLYbOiFKJWzBKB/FjJvtyIFGtPqlUuV5TfjDeEkQEtBxZjKKwU9hO81N5isxihORcR/3hSKxH
 mFHDoQRkllAvombL7fly+qlZhQdfoTzfqDSZw9aYSsLst1rxShFe869fw8L/T7T/AEPOOdnuwKV
 ethxmmvo1aE+TITpNqws6LrZDBB+5NMrI+QKPY4yOcBkPQzixfvIDWOpf0fdoJp7d+Nn9rFE8Sj
 Vbh7fGoA3tTKiLcHxigdm1PuVYIcjJb40fSocElGC7SpKA3FWdCDyz6y4UFdoDeVYiQusYVzdW4
 WqCsiDzfpCB7ob4F+lcNk9+fk/tUpv9xm5UAtZYSkKjEah
X-Received: by 2002:a05:600c:4f0c:b0:489:1c1f:35e6 with SMTP id
 5b1f17b1804b1-4891c1f38c8mr201641885e9.6.1776862442605; 
 Wed, 22 Apr 2026 05:54:02 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc0f82bbsm753110215e9.3.2026.04.22.05.54.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 05:54:02 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 38A1C60342;
 Wed, 22 Apr 2026 13:54:01 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,  qemu-arm@nongnu.org,  Peter Maydell
 <peter.maydell@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,  Mohamed
 Mediouni <mohamed@unpredictable.fr>,  kvm@vger.kernel.org,  Pedro Barbuda
 <pbarbuda@microsoft.com>
Subject: Re: [PATCH v2 00/31] target/arm: fully model WFxT instructions for
 A-profile
In-Reply-To: <20260422101043.1234229-1-alex.bennee@linaro.org> ("Alex
 =?utf-8?Q?Benn=C3=A9e=22's?= message of "Wed, 22 Apr 2026 11:10:11 +0100")
References: <20260422101043.1234229-1-alex.bennee@linaro.org>
User-Agent: mu4e 1.14.1-pre3; emacs 30.1
Date: Wed, 22 Apr 2026 13:54:01 +0100
Message-ID: <877bpzxija.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> This series fully models the behaviour of WFxT instructions. We
> already had support for WFE for M-profile but we left off A-profile as
> it has more potential sources of wake-ups. The main one is the event
> stream which includes events from significant bits of the timer
> ticking over.
>
<snip>
>   target/arm: enable event stream on WFE instructions
>   target/arm: implement WFET
<snip>

I've posted v3 to handle the missing WFE exception and fix a minor
syndrome bug on the WFET exception.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

