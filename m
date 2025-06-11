Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D78C678DC
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 14:02:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPM0n-00045q-Fr; Wed, 11 Jun 2025 10:01:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uPM0c-00044y-FA
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 10:01:02 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uPM0Z-0003Tc-Hc
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 10:00:53 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-604f5691bceso81149a12.0
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 07:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749650448; x=1750255248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rw3OsuBf+UZBV+3Oe2W1P4mJiyWaTcPUqBk0IoX6HzY=;
 b=effsrdokhk2P82GXYylDM/XJfjtsRLSxD/IgU53bxOo6SolyNK8DSWU3k7kDB2sUG5
 EnI/JvGTjXeJmZWms90BoxWFh5fpPvFIfs0D9BdEbBLpcOuKaWsiEwhH9YUVQqMgUjPa
 jhqjTZZu9Bo4AXJIaAqNBqqX6sFLzuEGXjjUPlqS+6Zqb1SrqY3Lz/iGXqsWlugvWF4t
 DWapYXX6Oh1SJop7egPsH/iuTFu0BXiRtIn6BcYI0hPaGR3ggrNAmyIebeewO5rNhTrm
 aiCAXF+6LU01wJwDHdceyKgv8h7PloAgKpsx39VbE21bfSE2ujJ1XRgmYjy0gawDbMG0
 Ik3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749650448; x=1750255248;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Rw3OsuBf+UZBV+3Oe2W1P4mJiyWaTcPUqBk0IoX6HzY=;
 b=PEy8daci9WuTrn5FNQ1Pnh/Y0ZH462shB8aniy7mh5l/RVd6ZwxVA5kA65GglUvwM5
 qAcmiP1HijJlM+AqBUUcXlbCiTOs2mGpFZuSaLLTSwQrE4PciWEbyNUr0nh+RkLv3clr
 MlVun1495IeYCAQ+wd6U1UOv/GnWOrW9iFxJ9h9OoErh3ku98oE7Y2AGWM6tJrT78XIH
 y8UzRXBzCK/AB1FbW6kyEmFcmP+XznEl8vBZhcGOwiIy7nOPLGopFCPRU8CUuhMjJpFX
 SN7qOMiTF21Ne6msASUtfYQmnY8nexQlajg0tq1sb0RLPO6uTh+IC/5iK072gEPETWcU
 ndSg==
X-Gm-Message-State: AOJu0YxRuIOSeMX9GRty0d2O6sg+Ed8+ivE27dWGqtcUCPrDFOKBAIse
 x9a902gbEUWUtBBJwm6cKScBmIOkgET/hESBLuniCj3uvwy8UgwfIxuAIsDU6bchSk4=
X-Gm-Gg: ASbGncuBtRdaEOpxOtAbeWBIfFlwYAAyaoHOtCACarcWx5ssJdThl2Sk/Lov9txrlhK
 zAzAcI2Nnm6uBzZkLjL1dMyw6U0JW2IEg4mBqDOxQyaTuSaM8iREQvpGRv3eA48nkqR0qCqzKBk
 C7OWgrlSGVmekBdl27Ff4sINsrinULn9NeuFoVCcyzdHh5gf0EZ1hN0TruKnxNq1QLE1qFYcQcc
 zXNFuKrIQMIU32xEK6NYgTrWqZ99aniObciysbJCYY2TDadFd9zsK2X2YeqIq8zOXcIvYdNQPDO
 hGkdfg4fjyA3fj/PO6baUSrtuQZS5R3RsypK4aW2gZ4ANCvSJtomcHuJ5Hh85Zo=
X-Google-Smtp-Source: AGHT+IFpUpjm/+0bvH3QkyjY8fcrOmpIhv8k+b2L0kiXFWPNWQ1xgDn0c8dY4A6kFXNaYNSHxzxPDQ==
X-Received: by 2002:a17:907:3f86:b0:ad1:81c5:5ec9 with SMTP id
 a640c23a62f3a-ade893e50damr389063466b.4.1749650447758; 
 Wed, 11 Jun 2025 07:00:47 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ade1dc3a609sm902238066b.145.2025.06.11.07.00.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 07:00:46 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 08E875F7CB;
 Wed, 11 Jun 2025 15:00:44 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>
Subject: Re: [RFC PATCH 00/19] accel: Preparatory cleanups for split-accel
In-Reply-To: <20250606164418.98655-1-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 6 Jun 2025 18:43:59
 +0200")
References: <20250606164418.98655-1-philmd@linaro.org>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Wed, 11 Jun 2025 15:00:43 +0100
Message-ID: <87ecvqjs38.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52a.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Few changes needed before being able to add the
> split acceleration. Mostly adapting few prototypes
> so callees have all necessary information.

make check-tcg failed:

  =E2=9E=9C  make check-tcg
  /home/alex/lsrc/qemu.git/builds/arm.all/pyvenv/bin/meson introspect --tar=
gets --tests --benchmarks | /home/alex/lsrc/qemu.git/builds/arm.all/pyvenv/=
bin/python3 -B scripts/mtest2make.py > Makefile.mtest
    BUILD   aarch64-softmmu guest-tests
  tests/tcg/aarch64-softmmu: -march=3Darmv8.3-a detected
  tests/tcg/aarch64-softmmu: -march=3Darmv8.5-a+memtag detected
    RUN     aarch64-softmmu guest-tests
    TEST    feat-xs on aarch64
  qemu-system-aarch64: ../../system/cpus.c:685: cpus_register_accel: Assert=
ion `ops->create_vcpu_thread !=3D NULL' failed.
  Aborted
  make[1]: *** [Makefile:195: run-feat-xs] Error 134
  make: *** [/home/alex/lsrc/qemu.git/tests/Makefile.include:56: run-tcg-te=
sts-aarch64-softmmu] Error 2

<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

