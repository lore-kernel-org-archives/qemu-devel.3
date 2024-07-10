Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28623C3DA45
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 08:45:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRSwY-0000wY-E4; Wed, 10 Jul 2024 04:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sRSwU-0000vr-Ec
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 04:44:50 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sRSwS-0000m1-2e
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 04:44:49 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-595856e2332so1739286a12.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 01:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720601086; x=1721205886; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ciYYet6i/Lxi78XNvS2JBGu6dGlfAYRobebzobGKNhQ=;
 b=pWcnlt9QG3Y9YoRNk2QTcC8H0vqOmnzcHP1N6S6o+SWu6V2y3J4K0meXK308W74tMF
 HzIZ3E7aN2CaPyxD/s5WbBQqY33jPhYoTPNUEMXdeiIIwRUtqpG72EKjw1E0XaTwa4Gl
 qCP0XIQUN5bF1LJGIg0hGKzl5dab5ce7pQqf78b+5w28sduvKhP7WWu8RTIUCKfzWQDW
 QW7BLUAt8e59yC55F6bwhgPV8E9gx2HAO6elvW0TITT6lpNEf0TQQOEiZtFY2WxtbYE3
 yJV9ujwdI86q8F8GVB50kPLH3wIzhS6Ab1SsPzbAPJ/K+OwveDZklr1pfaPlmUFSs2NX
 5Aqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720601086; x=1721205886;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ciYYet6i/Lxi78XNvS2JBGu6dGlfAYRobebzobGKNhQ=;
 b=rvWUmBRZav0sPL1s74h8/tw534QpovLcnnbK9RvP2lAA3BMJys+46ID4yfVMn0vX1G
 F1qbFubXVsqKWMhr13P2V92CuhfeSDlbhuMz8ggHEaAFhXuMmHBxOj5FTfkgcUtP23vF
 8MSw+RPpG2Nt6fqycEHNfaVSykfASuMPpLzGwK6mz2mXoP4Um9mg2LBCLfPX+e8eldTL
 cNF63oXRqjBPc+ajfXDBw0aLryEA1XwouBqAs/GzNnRz7DJJdNd8Ga5AZIqhDyBdZtHC
 hYaYZ0NtR+NvFSO2QXWb37DiJGNMX9+y/tRnizMeI0CxNnOgUa3gOHz7t2O4XQLGRtRf
 usog==
X-Gm-Message-State: AOJu0Yx8dl0jiRPfrj2zdlXNvHVMyQFb49/qNoZaIyQXB7A+/stTM4Ih
 aWEBvzfM2H5dUXsdiuM7fNRL6aH3FPKZspWmPCgOGDrxcxb1Js1GPI5qOxAeTic=
X-Google-Smtp-Source: AGHT+IH0lkp/7phvIPeww2zExW7g1o28b6z6QZ7cVubAfGkH196x2nGwKP6+hoJaoScUBgMjoPrlIg==
X-Received: by 2002:a17:906:b4a:b0:a77:c7d8:fe18 with SMTP id
 a640c23a62f3a-a780b89cb9fmr335291566b.75.1720601086095; 
 Wed, 10 Jul 2024 01:44:46 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a7ff290sm140130966b.108.2024.07.10.01.44.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jul 2024 01:44:45 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CF5485F881;
 Wed, 10 Jul 2024 09:44:44 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  Stefan Hajnoczi <stefanha@redhat.com>,  Mads
 Ynddal <mads@ynddal.dk>,  Peter Maydell <peter.maydell@linaro.org>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  =?utf-8?Q?Ma?=
 =?utf-8?Q?rc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Markus
 Armbruster <armbru@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Zhao Liu <zhao1.liu@intel.com>,  Gustavo Romero
 <gustavo.romero@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  rowan.hart@intel.com,  Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [RFC PATCH v4 5/7] .gitattributes: add Rust diff and merge
 attributes
In-Reply-To: <b51249befbee4186a6c0fd6c6c0542f0413e0477.1720094395.git.manos.pitsidianakis@linaro.org>
 (Manos Pitsidianakis's message of "Thu, 4 Jul 2024 15:15:41 +0300")
References: <rust-pl011-rfc-v4.git.manos.pitsidianakis@linaro.org>
 <b51249befbee4186a6c0fd6c6c0542f0413e0477.1720094395.git.manos.pitsidianakis@linaro.org>
Date: Wed, 10 Jul 2024 09:44:44 +0100
Message-ID: <87y169r5z7.fsf@draig.linaro.org>
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> Set rust source code to diff=3Drust (built-in with new git versions)
> and merge=3Dbinary for Cargo.lock files (they should not be merged but
> auto-generated by cargo)
>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

