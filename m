Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E293FF885A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 11:00:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKDVp-0002qN-Dq; Tue, 05 May 2026 07:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wKDVn-0002pz-2h
 for qemu-devel@nongnu.org; Tue, 05 May 2026 07:00:23 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wKDVf-0004cQ-BU
 for qemu-devel@nongnu.org; Tue, 05 May 2026 07:00:16 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4891f625344so54853875e9.0
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 04:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777978813; x=1778583613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bsDTUqj2zX/6REcWVqYEDDMZA+WrT6bCoLyt03GXGdc=;
 b=wFg6LQba7bKrs9fdTNQ9v4PqjP1r2SCTD4EVq+94yOeyWWoei67w0VDMRSD8qNrd5q
 NhniHkysNQ0i3QuOuKkz6E9qY7LebBkfSafO52GO8j/SomCy2vRfBktcTh+hceRlB1+6
 9/kZ+13OBBHg8us8m8Z7FdB5IpWUypoRuo+JFXH9plKL3LDmrx/4ILXsQ23MEA29kUJE
 Fs7KnrVR6/hEEN4O0LbvqyXudVuvOsWCXGpaHUdaxW6i1r3r8uNGK0IukQ/peDSqJlIR
 qiCdmEcR2W8hQNFMUaDsDvkiLMRXvefVYUHJImi87c97BwiURQ1sWgvIUFBTz6qzg3WI
 SiXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777978813; x=1778583613;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bsDTUqj2zX/6REcWVqYEDDMZA+WrT6bCoLyt03GXGdc=;
 b=NmveO01ITyKDcgAi8LcjCrOm022Lja94yupefGDNIpzbTjjSirfuTyG3z1zQSP3Om1
 fn9wEYQMZs/kmehk00yiMjPgTDNcKQblBv6k4YPSRN4QV2cE3BAW1GaBYhKu9QyNi6ww
 MeESrsO5qYg+wnGjP22G8OxPWg153fM3PvVI9uLJyGWgnVb5q0TuJQEIB3ySZov0LUwf
 uIwKHC3RyV61UhDP5ZZoCgwotW4IXbU7H9L+KCRLuj8ZpCW9KEy83+f3NrZ+6h4yFNL4
 K7JZLADqaxcjdDtHyGSMmk2RZ/Ntlo1bNwZax7Vz04BYmyPius9OBSoZhPCPB0t91csx
 JJqw==
X-Gm-Message-State: AOJu0YxSK4R58iSfuWv2Ngdi3uZMMG+6Lgq5idfggmY4Nfd5N/abDvEZ
 bdyUXb2glxefYoMa+bMvZ3ReBUltdEGbISuKm2bULs6KFPvQtqUiTbeg+OGLkB+TByw=
X-Gm-Gg: AeBDietw7+AukC98ijacAaDT2/YgNH5yCATRXcHshGJwTKWiFIgUM+w6ircydlni/8V
 Dm15/R6dcmYRpsX/IAJXEnhL2+I5JlxBwXfAnzQlwdDraoF2LpsHOqzQtg10YqanLI5jaPDgBQk
 4ELJ2l2KUsvDzUkyhrIImnOsU0Jlt+42P6gNbKgmd9apUzAMYPJbyBbneLaTcyJUm3+5Lr9I+wQ
 xIuu/Klf9TWCXpbklbi6vUBLtR2USfP8kCCmJOLX/8os7od1ceWx45hMh9l9RxuNbdhGR2fnCbY
 q9BWOBWvrPYLpSnssDtkiFpo41GnCEEluvTMoH7mX7+rQyPfnafJT7cS8q3woAogt39C+wXfnh4
 2upqB3DRjrjhtENHnuZkjCzaA0d3hS5KUFrAQWDyXm9hRC+ZpeD/D7ugnvfxx4iktP3GBlvI/tE
 MNW0J93EaJhLlQYUmkEyM19PqBM9m73ywzhSU2un8mrp12
X-Received: by 2002:a05:600c:c096:b0:48a:5821:6006 with SMTP id
 5b1f17b1804b1-48d142331dcmr35997945e9.4.1777978812830; 
 Tue, 05 May 2026 04:00:12 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48d17710bfbsm18626915e9.7.2026.05.05.04.00.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 04:00:11 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B74365F8E7;
 Tue, 05 May 2026 12:00:10 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Thomas Huth <th.huth+qemu@posteo.eu>,  Thomas
 Huth <thuth@redhat.com>,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-arm@nongnu.org,  Peter Xu <peterx@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Brad Smith <brad@comstyle.com>,
 Fabiano Rosas <farosas@suse.de>,  Kyle Evans <kevans@freebsd.org>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Warner Losh <imp@bsdimp.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Dau?=
 =?utf-8?Q?d=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 1/5] configure: report unsigned qemu binaries for check-tcg
In-Reply-To: <CAFEAcA-rFhHmS2+ToEZkr1+HE_e710-ZyyPESHLzCeW0QopY_A@mail.gmail.com>
 (Peter Maydell's message of "Tue, 5 May 2026 11:43:08 +0100")
References: <20260505103649.68361-1-alex.bennee@linaro.org>
 <20260505103649.68361-2-alex.bennee@linaro.org>
 <CAFEAcA-rFhHmS2+ToEZkr1+HE_e710-ZyyPESHLzCeW0QopY_A@mail.gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Tue, 05 May 2026 12:00:10 +0100
Message-ID: <87bjeunmth.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 5 May 2026 at 11:36, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>>
>> On MacOS the initial binaries are created with the unsigned suffix.
>> The user is expected to sign them before they can access the
>> hypervisor APIs. However for TCG testing we can run the unsigned
>> binaries so lets make sure the make variable is correctly set so we
>> can run the TCG tests.
>
> We have a scripts/entitlement.sh, and this seems to have
> at least some plumbing into meson.build. What stops us from
> running this at build time so that macos users, like everybody
> else, have a working "qemu-system-foo" in the build tree ?
> Having to work around this by knowing that you have an
> "-unsigned" suffix until install is awkward for our own
> scripts and for humans.

Hmm it gets built if you do:

  =E2=9E=9C  make qemu-system-aarch64
  [1/6] Generating qemu-version.h with a custom command (wrapped by meson t=
o capture output)

and there seems to be logic in that refers to test_emulator =3D
emulators['qemu-system-' + target_base] which ensures the other targets
have it built. I'll see if there is a good place to hook that
requirement in for check-tcg.

>
> thanks
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

