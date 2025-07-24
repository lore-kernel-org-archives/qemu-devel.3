Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B19FC83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 11:04:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uetiu-0003VW-DK; Thu, 24 Jul 2025 07:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uetik-0003Hl-Rv
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 07:02:43 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uetii-0000Fr-SD
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 07:02:42 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-611f74c1837so1805103a12.3
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 04:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753354959; x=1753959759; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ypkjtOv1NF51f15wxpFuussHfewnmWMlMBzhvNzwbwM=;
 b=T2LokxVYFJFlHHg3uJnlp0fnD2OyaPT41LrsXCfU/tiQKt5E8iIKBu1xz/xPEzHldZ
 o0wUDDCJ9Zoqph0Dz2AjmJ57HgGaQtUZKkcZTkHpsTGfOiQfENH06KgQiBCm7iZhwIn8
 B1W1nhHXwRa+nSQJ7wg82UHBp9Jnfap5UjIkSmD/XTGglNLr4TP9q0vhHJETOV2mO63U
 0uthmnoAfs6EXs4ycT+ghApgD34RH4afkGsTbP5oFRVLsf55cgA0I/1/W4T2xN9UTOVc
 mwNH6Ke9hBF4v4Pjp9vMG9MXJd02UiXNUXOqmzASknxnStxb6z77iVMoFE9U1oEbrNu5
 T1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753354959; x=1753959759;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ypkjtOv1NF51f15wxpFuussHfewnmWMlMBzhvNzwbwM=;
 b=ZeKR8Hhip3btJ6VxO5guOqGXpf1zwXsMYSrgVG4fmtB8TkK2s5rqTFbXDYWxG3/OI7
 r7YyQL7a/khY166QHSVBpBqbVlLplyUrhHuQfC+6ODtp4Q2eaMqMPmHc5eVly54euxbQ
 dhmZe3OGYdpqNH9BCS8pbzbTZkmBsiOZNx0XpaPDHqA3Zlij1Z15RhoxWzyeVeWPfL40
 1pokMLWhIKj1xBSNzrEEvHQOsi7MRNagBsjEwfbls4D6lTUlJtAtCHnb9jhwOnx4KR6u
 ApfieJdOy2SYpdzz6R8o7cpVx2ZiZollO0IRZ0b28GEkvNEjGvqYyCoCNJXH+Q6DQOJf
 uFkg==
X-Gm-Message-State: AOJu0Yw4Q9N06OQ0hK6SQmTHf+Aod5TgaoEyZSnAtxNbGSOm+Tt7f0bh
 0i5wAj8fJLxRD5JUKcVL4iYbY/Ewqi7WE71AoQj/PqDaa6jP3hYHbutA9cZ6vuHhnOc=
X-Gm-Gg: ASbGnctpnb26cHhoqeMap17IHgG2OSMqyfegjmNF/5mrisnFvc3tLVVhJWHFRjOfjE3
 ScECj59H8j+CfJA8ZIDJ5UkKcr2AK3NWOzkxhwRUA59zKh6GXZ8YxGfkLy9fj9khITMIe8UYXxS
 VcoYlxIK8xHKC/i9OI1NkZZFV4ZPX4c4hw8y2kfEyMr3j4J3t22IKdXSvEovE9adPIKK2X4Lcmr
 /iBpHzgkGyWT3LmpH60O9Dy/51GRFn07Z0bHsZX5EK1wdZdolO05w84+h+IaVYeNGlY6B72MU9h
 Q2R3HvjkTcajk2EwrQBmPa5jFDORdw6iQ7CVCvNXKxTffHA8T+oMtVI60oagATREnLeqLkIRo6y
 lrCZIBBl6ufqG+Q7HkE7MCDA=
X-Google-Smtp-Source: AGHT+IF64qJI06vE8yuKeUfAkHB6qDSWnOPlsVQEERnSxUuyWyqYzlVClGBlkifQb6++cwhG94ZOZg==
X-Received: by 2002:a05:6402:51c7:b0:612:b67f:d512 with SMTP id
 4fb4d7f45d1cf-6149b40cf0cmr5865713a12.4.1753354959070; 
 Thu, 24 Jul 2025 04:02:39 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-614cd1edf10sm678979a12.26.2025.07.24.04.02.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 04:02:38 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7A78B5F7B0;
 Thu, 24 Jul 2025 12:02:37 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Mark Burton <mburton@qti.qualcomm.com>,  Manos
 Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH v2] tests/functional: add hypervisor test for aarch64
In-Reply-To: <20250724094214.93330-1-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 24 Jul 2025 11:42:14
 +0200")
References: <20250724094214.93330-1-philmd@linaro.org>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Thu, 24 Jul 2025 12:02:37 +0100
Message-ID: <87h5z1voky.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
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

> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> This is a simple test case that runs an image with kvmtool and
> kvm-unit-tests which can validate virtualisation works. This is useful
> for exercising TCG but can also be applied to any nested virt setup
> which is why it doesn't specify an accelerator.

You might want to update this text give now...

<snip>
> +
> +    def do_test(self, kvm_mode=3D'nvhe', accel=3D'tcg'):
> +        self.require_accelerator(accel)

You are now forcing tcg. Or are you planning on adding additional tests
bellow to exercise split and KVM (when we have nested support for
HVF/KVM)?

> +        self._launch_guest(kvm_mode)
> +        self._run_kut(kvm_mode)
> +
> +    def test_aarch64_vhe_selftest_tcg(self):
> +        self.do_test('vhe')
> +
> +    def test_aarch64_nvhe_selftest_tcg(self):
> +        self.do_test('nvhe')
> +
> +if __name__ =3D=3D '__main__':
> +    LinuxKernelTest.main()

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

