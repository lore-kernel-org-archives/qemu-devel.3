Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C862E64AB6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 14:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIUJw-0004vj-0d; Tue, 03 Dec 2024 09:56:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tIUJu-0004uw-JF
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 09:56:10 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tIUJr-0002ly-Ow
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 09:56:10 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-385e5db74d3so2464801f8f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 06:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733237766; x=1733842566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VJFVF4LjWSmtboaro7sj0kFVt3rwdIkXRKJtY3tg7qE=;
 b=fCITdvp7IDiaKQzclJ222e/lXKhpfUrNuUc9HW1TaHCnREGdsg76Y45si2NLa75cRB
 JYQ0VtA8k+nxuPzH1lBsLr2m2+TyhgnKPoobUN51nZTyOP+mJ8whPpvOGQ1nxug0K6tL
 Hif7C13wvgJeGrPgWBlOAuDRJAwYzTZe33GB6ELY6Y6Bfr50borA9kOll0i20v6IqWeU
 evXdG1noo3ZJqrP5rIUKmuj3aoPrGk3FbEbjHo0sY1pen/TJBUQ65W0PCUP18UVN1KJy
 E5Dlew5Z0kB5AHi/C1fwjCEdnIR607mAsfYsQUHExNyyNQZUpjXaOnzd2D3b3Ujgsu15
 FpNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733237766; x=1733842566;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VJFVF4LjWSmtboaro7sj0kFVt3rwdIkXRKJtY3tg7qE=;
 b=xK73Wl9mgT7Oh5gjx58ntsT80n3B3p7fKbPSqLEw3x/wvZlckryzGjBlvmPADBl0c0
 GD5v5fhECPYJx2HN+Furt2T2qyF/sw+21IWieJu0TCYf4X1j6i+mZleC67DGhKDmbAbL
 QHMmaYQqMzqF0jVQtPJCzlLbknAHMxXwSh1nF9GlpPmL/wDovx0n9gFYDOwBq64Amu3N
 +rZtwxQVz/UuGYPre1RKJxxEI2QeRhNN44W0cDO4LDZ5z8ggn0RckPAXENbNyHI9rYlw
 AxFZYm0DeqX/zgrQTmJGmx6UcJ6k8t8NrX3sDlCN/GNS+NhQxvo1Xqf6C4WW6Bz7VMqW
 Lx5w==
X-Gm-Message-State: AOJu0YzfGVYS7CXAYWEyJXszoVBV5cd38XZjC7h6Zg139nXAMybAdEcf
 WvGrmy1XcBAmsxQmB9ZO9/YVJF9iEd5+riM8PULV0kD7kTN9C4krfwoNaGG8Y8M=
X-Gm-Gg: ASbGnctq7uRMrM8m4QWUl8QrgnKQridTvLO1Cxz6JTsXQmtVduvyG0tqAkJP7QUZk69
 z52Yjeo68F1TWBf5m2mvzn1QXDUFAPy+iaDaL6+O0DxazqR5wnbwft7KiOez0Mvk5Z0MGSn2+wR
 QLbna4sW6HtlRqE+MayZmtirOpBhEllnBI+HBB8Lnrpnn4KcSB/5dLTXrPt3p9OCePyg/hV0Kc8
 lXZr0wqq6BxQw8UiE5p3VZlhlLgQ0mrmayAyk07uZDR4AaN
X-Google-Smtp-Source: AGHT+IGQjk+Ql/sKPuMXnmgKvKo7k+UhsYlpyCfp+s/Pk7d14YpsJfSFkYSGQHWCWwX5Q/VZOzy1og==
X-Received: by 2002:a5d:598b:0:b0:385:ec6e:e899 with SMTP id
 ffacd0b85a97d-385fd42a804mr2110539f8f.59.1733237766006; 
 Tue, 03 Dec 2024 06:56:06 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dfb2d7e0sm12543885f8f.44.2024.12.03.06.56.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 06:56:05 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id ADF915F89C;
 Tue,  3 Dec 2024 14:56:04 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@kaod.org>,  Troy Lee
 <leetroy@gmail.com>,  Alistair Francis <alistair@alistair23.me>,  Peter
 Maydell <peter.maydell@linaro.org>,  Andrew Jeffery
 <andrew@codeconstruct.com.au>,  Jamin Lin <jamin_lin@aspeedtech.com>,
 qemu-arm@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Steven Lee
 <steven_lee@aspeedtech.com>,  Niek Linnenbank <nieklinnenbank@gmail.com>,
 Joel Stanley <joel@jms.id.au>,  "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>
Subject: Re: [PATCH v2] tests/functional/aarch64: add tests for FEAT_RME
In-Reply-To: <20241128213729.1021961-1-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Thu, 28 Nov 2024 13:37:29 -0800")
References: <20241128213729.1021961-1-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 03 Dec 2024 14:56:04 +0000
Message-ID: <87mshcdddn.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> This boot an OP-TEE environment, and launch a nested guest VM inside it
> using the Realms feature. We do it for virt and sbsa-ref platforms.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>
<snip>
> +
> +        self.vm.add_args('-accel', 'tcg')
> +        self.vm.add_args('-cpu', 'max,x-rme=3Don')

With debug on the PAC function are certainly very high in the perf
report. So pauth-impdef=3Don seems worthwhile here.

> +        self.vm.add_args('-m', '2G')
> +        self.vm.add_args('-M', 'sbsa-ref')
> +        self.vm.add_args('-drive', f'file=3D{pflash0},format=3Draw,if=3D=
pflash')
> +        self.vm.add_args('-drive', f'file=3D{pflash1},format=3Draw,if=3D=
pflash')
> +        self.vm.add_args('-drive', f'file=3Dfat:rw:{virtual},format=3Dra=
w')
> +        self.vm.add_args('-drive', f'format=3Draw,if=3Dnone,file=3D{driv=
e},id=3Dhd0')
> +        self.vm.add_args('-device', 'virtio-blk-pci,drive=3Dhd0')
> +        self.vm.add_args('-device', 'virtio-9p-pci,fsdev=3Dshr0,mount_ta=
g=3Dshr0')
> +        self.vm.add_args('-fsdev', f'local,security_model=3Dnone,path=3D=
{rme_stack},id=3Dshr0')
> +        self.vm.add_args('-device', 'virtio-net-pci,netdev=3Dnet0')
> +        self.vm.add_args('-netdev', 'user,id=3Dnet0')
<snip>
> +
> +        self.vm.add_args('-accel', 'tcg')
> +        self.vm.add_args('-cpu', 'max,x-rme=3Don')

And here.

<snip>

With that the tests both pass with --enable-debug (312s, 352s) and the
profile looks like:

   6.33%  qemu-system-aar  qemu-system-aarch64                       [.] ar=
m_feature
   5.66%  qemu-system-aar  qemu-system-aarch64                       [.] tc=
g_flush_jmp_cache
   3.44%  qemu-system-aar  qemu-system-aarch64                       [.] re=
build_hflags_a64

This I suspect is triggered by assert_hflags_rebuild_correctly() which
is validating we've not skipped rebuilding the flags when we need to.
It's a lot easier than debugging why your execution trace looks weird.

   2.95%  qemu-system-aar  qemu-system-aarch64                       [.] ex=
tract64
   2.52%  qemu-system-aar  qemu-system-aarch64                       [.] ex=
tract64

This is usually triggered by translation code which uses extract64
heavily during instruction decode.

It might be useful to see if we can get functional tests run under TCG
to dump "info jit" at the end and ensure we are not over generating code
and exhausting the translation cache.

   2.12%  qemu-system-aar  qemu-system-aarch64                       [.] ar=
m_el_is_aa64
   2.11%  qemu-system-aar  qemu-system-aarch64                       [.] ar=
m_security_space_below_el3
   2.11%  qemu-system-aar  qemu-system-aarch64                       [.] de=
posit64
   1.49%  qemu-system-aar  qemu-system-aarch64                       [.] ar=
m_hcr_el2_eff_secstate
   1.46%  qemu-system-aar  qemu-system-aarch64                       [.] ar=
m_is_el2_enabled_secstate
   1.38%  qemu-system-aar  qemu-system-aarch64                       [.] ex=
tract32
   1.34%  qemu-system-aar  qemu-system-aarch64                       [.] ex=
tract64
   1.30%  qemu-system-aar  qemu-system-aarch64                       [.] ge=
t_phys_addr_lpae
   1.23%  qemu-system-aar  qemu-system-aarch64                       [.] aa=
64_va_parameters
   1.09%  qemu-system-aar  qemu-system-aarch64                       [.] ro=
l32
   1.07%  qemu-system-aar  qemu-system-aarch64                       [.] pr=
obe_access_internal
   1.02%  qemu-system-aar  qemu-system-aarch64                       [.] de=
posit32


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

