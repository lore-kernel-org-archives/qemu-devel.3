Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF93C3ABAA
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 09:17:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9h4n-0003hj-VE; Tue, 29 Apr 2025 05:16:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u9h4H-0003VU-Vh
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 05:16:03 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u9h4F-0003pC-Mx
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 05:15:57 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ace333d5f7bso935708766b.3
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 02:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745918152; x=1746522952; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DmtOy/ZG9qrrV3/RcfFT98L7Kv6MyvS8sAjoX/+25k4=;
 b=TBxF/fOHRaUqehTmp31RVvStcDwraBBC7RO9r7oXsgYEjpJGVH7o0Ru+HL/oJvwHBL
 KkNQikwNJY5XNaQbrA+bUMLv/LaZ8i0SqZtvJ3lTUlvrJE615kOMLkCFksK4Edgfs3OY
 FsgbqU5s6O6bgrdfJ3e6QzY7EZhUB/HWI9yOubZEQufQctqkF6a5RP5xnYKORcaoSZHF
 +GNB6i4RgN+ZeQiSH4kjXPpAAuwwCWP8OeFjvmq6HlOaJE37SBKQCiE/LDbDs73oBF4e
 ZC9PGTGsevuX2CRrJ7nlSu6FloEEXhu7p3fJm7en23GvhVBKXSAz/xmINRU8A1xbRYO9
 j3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745918152; x=1746522952;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DmtOy/ZG9qrrV3/RcfFT98L7Kv6MyvS8sAjoX/+25k4=;
 b=RrpKqMhE1k9YqGDxaOF0LUsxYsdWyHA2Fs0SA9zB/ebetDMIO7oJTh5Y0gbpwF3O+5
 iozy+o0UYjnuTnfJm2sU/4oygdiSIkt/tZZBj+fDb1Dq5ZI/2GGlhqe+Me98Fk/5upVp
 GZQnTMBZJ24V2bp5mtrCZ//4uL5H5qmiZUfLyUpKU1S0KEn8R+xUek0d/XdsvTx1xCBv
 FBMrP2aV+Jk9hGD6+K08hgTff0lirEmyqGzFfyE7N9bVF7ZXhWx8QYIZ8MzqXRHI8K7x
 G376o5oBD0WAEkm0J7x2sthE/KJKwJpNfNDKbdOP+vE12PIA6vISdATyFhUXgOpIZ4SC
 JSBA==
X-Gm-Message-State: AOJu0YxdXAbeiFHRufpiCkQg+l37zz82B3t6XE6rDAchv7eQh7piLzN8
 I3Kzm+m/2q90H0m1GM+etNhL6BWp6OYPTemeGsbmgP3I3PxU0OQNkUv5k9KYni4=
X-Gm-Gg: ASbGncuEK1Mvq08jERa9IAue4w7HOjn4rudrL6K3TSJZQFgvtMyIvxwLvRxY03wQTzF
 hR5lTm+QMeK/7xXYCp07zjndW//XCM+riXTTh8PDJpI4fDCOnqZHKMqyAmJlmO2ye5uZjRuVDNk
 yCSB9FLn4NedA19E3eVxv8xhN7Au+2+J/VhPi9dFSC8sxhHqWLLVXWYgxI7fzPPDQUjjuIOfFm6
 gGa76fFMxJaqI6R46MPwMrayaSGHXXDBT48fXR0koEDUBcbLC2CEZCRKgb3/VQxd12plgbdUgUB
 1dshV4YDUooXdgYbSEOQPW3lc7eQ0ozw9XSS01r0dqY=
X-Google-Smtp-Source: AGHT+IFejMuzZX3IfeC1lGuUK4hm4+ZuXZbt8ZBZC4iacJFnjcoCd1UhcNczc/J3wiUMumQ+AK0wKg==
X-Received: by 2002:a17:907:7ba3:b0:ac7:ecea:8472 with SMTP id
 a640c23a62f3a-ace8493b5camr1153942066b.26.1745918152017; 
 Tue, 29 Apr 2025 02:15:52 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ace6e41ad27sm745439866b.5.2025.04.29.02.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 02:15:51 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 994485F863;
 Tue, 29 Apr 2025 10:15:50 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 kvm@vger.kernel.org,  Paolo Bonzini <pbonzini@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  qemu-arm@nongnu.org,
 anjo@rev.ng, richard.henderson@linaro.org
Subject: Re: [PATCH 01/13] target/arm: Replace target_ulong -> uint64_t for
 HWBreakpoint
In-Reply-To: <20250429050010.971128-2-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Mon, 28 Apr 2025 21:59:58 -0700")
References: <20250429050010.971128-1-pierrick.bouvier@linaro.org>
 <20250429050010.971128-2-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 29 Apr 2025 10:15:50 +0100
Message-ID: <87selr49bt.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
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

> From: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> CPUARMState::pc is of type uint64_t.
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

