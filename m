Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9BFACAC5A0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 12:28:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzDjs-0003mp-BW; Thu, 18 Sep 2025 08:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uzDjr-0003mg-Bl
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 08:27:51 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uzDjp-0000Xv-9d
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 08:27:51 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3e8123c07d7so897396f8f.0
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 05:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758198467; x=1758803267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3j0ZSAUAM5waAmLbuPHwrLZQfvbNTQqgU9WV4FSoiO0=;
 b=oa+O3F2opws0E5uXcZt/E4nlJKgtKj534vxQgwFDojIxFzcSb/hIJ2gpIhygrIRhoc
 T2WoZPhawjcLKfHY3dkJ5y/ofM+ifXFlwRvUH9wwcvHvGPIUTMFKou5xNYva0+q4Ltbq
 ovrG0rlA8GoCPUt7YJA9srLoPnHNfGGXe3V2VYq3RBzZGgl/1rGpxfzoXKc3RbV8AJyR
 KOQ+IzMGc1JYIoCYWZkvOF9bHwylb3IJgxrdF48USOo8KdSV2MshG50itdAA4lqmUC2B
 NFILK0nphkxLGO5H5lPUhMPVfbXMT9nyxAKkPgL6BLkeEQqPab0LoWJfd0SBu20u6C0R
 iCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758198467; x=1758803267;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3j0ZSAUAM5waAmLbuPHwrLZQfvbNTQqgU9WV4FSoiO0=;
 b=NhG+onp4kXIJiMYwQb0WTdptG+mSYuxBz3C+3aWih6Yxbjvak2+dILAL4zyYD/feCB
 vjfPrl6oSqeAlXnBvxYAW8HakdduN180yI2WP1C6M7CPualZWd+LnnlEUo49ymtpsp+0
 pHlXWPDg5OCojtEg0hrpKQOFRIOiIO7RrSzutvgcD4eModNKG94/l1mN1NGmBP+IDSns
 QSlY3lGVnuUv1inGMdQ1zFIBwySBGKjWIxCH/30trLtvi6CHN1Y0ClfiBGj4+YMl5MHl
 b2CvayXq+l0wFiva0uBQhIVz2o7l1K9uRH8RlJEIE5PdxN/oY5aqjOOaKyJb5o7/FQ1a
 j5rg==
X-Gm-Message-State: AOJu0Yyx2Jy4RNO2Nyohcjv4hoO+K2kmxGLEBCe+MWrRScJHVevIntpn
 TLvh43mKYmsKsLjgI/Ljxo5sxnEhQmqmYyHaop4H41FjFJOrbgc4HPYIFs+IODQK/KU=
X-Gm-Gg: ASbGnculVDP3u9yT3bLh6hKyzMLV6kavuPIfDyPg6kUMVeYkR18m/34S03OyiAOfrnn
 Vr62CS5K491cKbVBDYGekV537CWB1Q0RJYZL1V3b8jzGlOdsEqLRqebj8kd0TuM4uRr63F3Rer4
 CjPeqsIaFZP6d+K1nwTfPk7oZT5iNpvQsKOOFZEV2pK518pnY436o9tcyFV18HctqL/zPYikX3r
 29DqlUUru8I7fSKGnrWtV9+NJqZxGA/V+u40qjlkWd3bb5s4y17k8Ask76tR8a+1eNHuz4p3kIk
 O3RNgZGNp7RBugrmZR6WCWtkEyQWKQjjBEF/wEOtKApUqLPLmGKAUR38vun1NxB6ClQ1ExfxigN
 JM8NBvqW5KjmpI+TO9kJfXORhpxCgtgo0AKTvugm+zw==
X-Google-Smtp-Source: AGHT+IFkGrkIq5K7FcpjgBmvlGDjC+Qt1zEhrsPcGy5tHMJPQ+hD7vJQWDI6ZX1W5F/rw6CsilI2pA==
X-Received: by 2002:a05:6000:184b:b0:3e9:d9bd:504f with SMTP id
 ffacd0b85a97d-3edd43e5242mr3539530f8f.21.1758198466811; 
 Thu, 18 Sep 2025 05:27:46 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee073f5392sm3466833f8f.13.2025.09.18.05.27.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 05:27:45 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0D4145F8AC;
 Thu, 18 Sep 2025 13:27:45 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,  Philippe =?utf-8?Q?Ma?=
 =?utf-8?Q?thieu-Daud=C3=A9?= <philmd@linaro.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Alexandre Iooss <erdnaxe@crans.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>,  rowan Hart <rowanbhart@gmail.com>
Subject: Re: [PATCH v7 0/9] contrib/plugins: uftrace
In-Reply-To: <20250902075042.223990-1-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Tue, 2 Sep 2025 00:50:33 -0700")
References: <20250902075042.223990-1-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Thu, 18 Sep 2025 13:27:44 +0100
Message-ID: <87h5x0lzcv.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> This plugin generates a binary trace compatible with the excellent uftrac=
e:
> https://github.com/namhyung/uftrace

Queued to plugins/next, thanks.
--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

