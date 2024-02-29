Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9FB0C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 14:22:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfhHs-0002wd-Gv; Thu, 29 Feb 2024 09:21:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfhHm-0002uv-6d
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 09:21:22 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfhHj-0004Oy-Im
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 09:21:21 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-412b41a1294so7097775e9.3
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 06:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709216478; x=1709821278; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0+I1NC9RuByNlmrEoQi+IaEDLAAgDFEseHAtXYXW0AI=;
 b=i2tLSd6EIo8Pp6Tpb3IYu332g6siv9uc0Vo2SdkrnYQP6I99UZwSDD+E6MJ8fcaS03
 FhFymDlBMD3AZsTQllc0Dg4oTiWxj5FLNoVxvuyAe/QOOGbsixk3GX0wPP4491o/KFCP
 iEZbJzZQUqmDwUC/BGOHiFrm3867H/L9tbAkFDVY1EFHong1C9I3aGFa8BUMRzU4GtAT
 rECbZ0iAJhz/MiXUo7U8RgToERSS9TRdVHtnTiSy5WIKg/40xZTSJ9wL2NuPIrjBU2jA
 gwA7IXwr2iEc6ZlfI92miI59Di5OKEYwti2o7qxWe2xpJMkR5I8NZEAeY8TbtPjp4Iel
 3Jqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709216478; x=1709821278;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0+I1NC9RuByNlmrEoQi+IaEDLAAgDFEseHAtXYXW0AI=;
 b=NiOBt1/n06Op4w4MVrr7R2cOotbMaYP59UMu6HB5ISCzM4vwYwb0sYBSTAy1FDM94x
 fmHZ/YrSgvquGy43Mt4vBuggnuRPLL8YcXshjd3t2adj/C9v1iTL/CQklR1ZclWCe9T2
 giKiCM/3bcHhC+56sERnXVLyKsh5pDDo7qqXSb7J/y7yeObQMmxFIWmH96wnMeI899X9
 r0uH50/J3kQaGJiwKCdrETXSOeuc8Nk8X1KarZ5krdOmOFlKrU0scaBCkARDx5JsANaX
 9sF+yjeWtEnbLNaHrKVxIzEZjTUwUXVVsAkc2PhNtIewHgXcaW5+PECF44xkDqOZ4kLx
 7DvA==
X-Gm-Message-State: AOJu0YzkRRhkivgUoT2wYBWaeuKqyjDOzDSBQGDjLuBOFUDLJsZLcM5K
 0Cq7mA58JXAbBf4On3q4xwY8RNXUUV9ViF6mb8aazsIFFyPSZBXdR7BXEqAcCRg=
X-Google-Smtp-Source: AGHT+IGBgRyNkMWDduTv3ZBW6ezAq/QWcltO08ykb7WZh6VCYrXPq7J6ktd2g1u62ZrhR8t/v84avw==
X-Received: by 2002:a05:600c:1e0f:b0:412:bcc1:4431 with SMTP id
 ay15-20020a05600c1e0f00b00412bcc14431mr1463212wmb.30.1709216477614; 
 Thu, 29 Feb 2024 06:21:17 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bv28-20020a0560001f1c00b0033d70dd0e04sm1955585wrb.8.2024.02.29.06.21.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 06:21:17 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B298B5F753;
 Thu, 29 Feb 2024 14:21:16 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Yanan Wang <wangyanan55@huawei.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,  Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v5 08/12] tests/plugin/bb: migrate to new per_vcpu API
In-Reply-To: <20240226091446.479436-9-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Mon, 26 Feb 2024 13:14:40 +0400")
References: <20240226091446.479436-1-pierrick.bouvier@linaro.org>
 <20240226091446.479436-9-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.12.0; emacs 29.1
Date: Thu, 29 Feb 2024 14:21:16 +0000
Message-ID: <87o7bz9wrn.fsf@draig.linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

I did notice there is a discrepancy between what libisns and libb
report. The libb looks like an overcount so I wonder if there are some
instructions we are not picking up but I can't see where that would be.

  =E2=9E=9C  ./qemu-hppa -plugin ./tests/plugin/libinsn.so -plugin ./tests/=
plugin/libbb.so,inline=3Dtrue -d plugin  ./tests/tcg/hppa-linux-user/sha512
  1..10
  ok 1 - do_test(&tests[i])
  ok 2 - do_test(&tests[i])
  ok 3 - do_test(&tests[i])
  ok 4 - do_test(&tests[i])
  ok 5 - do_test(&tests[i])
  ok 6 - do_test(&tests[i])
  ok 7 - do_test(&tests[i])
  ok 8 - do_test(&tests[i])
  ok 9 - do_test(&tests[i])
  ok 10 - do_test(&tests[i])
  CPU0: bb's: 54282, insns: 775697
  Total: bb's: 54282, insns: 775697
  cpu 0 insns: 774827
  total insns: 774827

Although weirdly maybe only an hppa thing. Richard?

  =E2=9E=9C  ./qemu-aarch64 -plugin ./tests/plugin/libinsn.so -plugin ./tes=
ts/plugin/libbb.so,inline=3Dtrue -d plugin  ./tests/tcg/aarch64-linux-user/=
sha512
  1..10
  ok 1 - do_test(&tests[i])
  ok 2 - do_test(&tests[i])
  ok 3 - do_test(&tests[i])
  ok 4 - do_test(&tests[i])
  ok 5 - do_test(&tests[i])
  ok 6 - do_test(&tests[i])
  ok 7 - do_test(&tests[i])
  ok 8 - do_test(&tests[i])
  ok 9 - do_test(&tests[i])
  ok 10 - do_test(&tests[i])
  CPU0: bb's: 41513, insns: 302671
  Total: bb's: 41513, insns: 302671
  cpu 0 insns: 302671
  total insns: 302671

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

