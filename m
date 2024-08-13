Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D26FC52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 13:57:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sds1k-0001hl-6z; Tue, 13 Aug 2024 09:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sds1j-0001dL-1s
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 09:57:31 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sds1h-0008MB-Fq
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 09:57:30 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a7a9a7af0d0so616576766b.3
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 06:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723557448; x=1724162248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vZbNUaRGzDwuCJqocUZb26rViHbMptFncVo/QKHCSGk=;
 b=gMKRm/PT0X+T/sBCZdrXneJaRYct0zIFgS3pRqWkQfF5nD4tJ3IiqQ8z1cCsIx90nc
 OwRZ2CbjegTOAZAxrDUbaV9zI4My8NkZEL9lIVZlp3WUEuXoonXbE77Xeo/pENgMYcdc
 oSCDhQ7WHX40EYIKYUWPggEyJGuQY2yb+ocCqEDBRbAx5fLC5dnUzy+on6+XXTTQiHVQ
 GjzScyQuMeVXg3iowsuofr6ZK3igrpHug641p044YX81S+6I6aKTWea33a9OSDDGc2Qz
 oC1kwpY98mTOerqBxiMvKUVMEhV3b7HIL/cGt+6+4M4uTzsEx8+U5MRX7A5mtlWF3O8T
 LD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723557448; x=1724162248;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vZbNUaRGzDwuCJqocUZb26rViHbMptFncVo/QKHCSGk=;
 b=Awu0/LFqo28SBObfDhqwMsLbPe47n5GVjehLY39QVsB/l14wdxk8zIh1x4/Q2FzW8o
 JU7VFM/KZCieStlXRx6aj+aamUwlE00RejbF5kBoq1AHf+qHkYBG0zcWmoI3ds2YbpMM
 0RIS+tUFCo7UHMBild2WW5/2j1HxlrJ5aBOSwMpRBjKiSRf798mX96NbaxSbmvNW9MHU
 RT+4bqxdWRLEDO8cP0iytXNzOCby+ZDa109HFisvJghN5LRDy/fCVagFHE9KfbY51cvx
 gkYxq0tufg7/D3i1j6NnEZbhAHwSk3zuB+WSPsT61Zx/nICx7dZEa7uYaXoylUUZgUGE
 Sv2A==
X-Gm-Message-State: AOJu0Yxf5k+F+bDXiKL31HausLj+ntdfSh89Q6gSIPT4bhu4uBA6bd/f
 CohK9fD2z+YsI+zxswQ8754OpW88fuEEHNMrmkSxFGObv7PU2Ekn21VS/63hLj0=
X-Google-Smtp-Source: AGHT+IEqBxdEYjPZNBDSOy5PWLapkl1NEMyQGHWFXLZnuWRWwjB80BDjqx416T+xte806bkp/eBd9w==
X-Received: by 2002:a17:907:e64b:b0:a7a:bd5a:1ec0 with SMTP id
 a640c23a62f3a-a80ed255a34mr314624066b.29.1723557447170; 
 Tue, 13 Aug 2024 06:57:27 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a80f411b11bsm72082166b.130.2024.08.13.06.57.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 06:57:26 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BCF0D5F792;
 Tue, 13 Aug 2024 14:57:25 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Mahmoud Mandour <ma.mandourr@gmail.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH-for-9.1] buildsys: Fix building without plugins on Darwin
In-Reply-To: <20240813112457.92560-1-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 13 Aug 2024 13:24:57
 +0200")
References: <20240813112457.92560-1-philmd@linaro.org>
Date: Tue, 13 Aug 2024 14:57:25 +0100
Message-ID: <87o75wa5kq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Since commit 0082475e26 the plugin symbol list is unconditionally
> added to the linker flags, leading to a build failure:
>
>   Undefined symbols for architecture arm64:
>     "_qemu_plugin_entry_code", referenced from:
>         <initial-undefines>
>   ...
>   ld: symbol(s) not found for architecture arm64
>   clang: error: linker command failed with exit code 1 (use -v to see inv=
ocation)
>   ninja: build stopped: subcommand failed.
>
> Fix by restricting the whole meson file to the --enable-plugins
> configure argument.
>
> Fixes: 0082475e26 ("meson: merge plugin_ldflags into emulator_link_args")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Queued to maintainer/for-9.1, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

