Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1538ECAC58C
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 08:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvu0M-0006GV-6L; Tue, 09 Sep 2025 04:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uvu00-0006AJ-D9
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 04:46:50 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uvtzq-0003p1-HU
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 04:46:47 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b046f6fb230so125904666b.1
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 01:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757407596; x=1758012396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lrBTwxbWfehJGHfoZQVy21HNvFSiwSEPRKO+L7NgJQE=;
 b=hdw4tKXdANHcmTRXqciz5WikX38+GgODpuPMWmicipE+gKCMjOkibHHQphsBHopcml
 UWgiNRMz7kqHki3k34sTtO7GaiXMCzG22sRZ15137pwxaJ2ewhCITLxLQfzRIZJ9bPRR
 3fgcXC86EB3bLl0L3YI605qH4PPMUw6IWZJCe4DpmtQFQ+BRhDvIYADq1+NZR5JwE7O3
 qh4rHe4FtqDzwkVIqmTf/k+YeyJ9DzPDCjBUjsW9ZyhDNGEUfhMvACjborpZYZrVS4cs
 XcdVDCjugKTARWMLHw3XFTzD74dbDNplgzPBn07fOgPjGlryQDUo65YpHOa6BvzIfy1z
 S49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757407596; x=1758012396;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lrBTwxbWfehJGHfoZQVy21HNvFSiwSEPRKO+L7NgJQE=;
 b=k1B4qcs9zylg37WCgouCaL3yFFUA+wzniui3GbSLI5VS4ZZJN6FHgv7yGlOpMUrqP6
 72mg2soA6Je6uDACYCGtMyTtLkJDTInLbtFJcah5fgVB3M2a+qZQbmgvmOGoDxnG92wd
 v+ij/cc760igEcSe+4MmWmHBGthTx0ztysLZwgLVfbhShdL9zCcAkqYhoTrD0uUoD1Qz
 55nU9ISpDem7LVaCTBmCWVKlhmi3IJG7/MDvND7YjFvaKFPRCTleABxmjg3G1ld1ako5
 TvQtKl5YRMOkOIRu5Z8i5ZBl+S+rio9iVxvmva88qK6A++xlaevfgcqhUwSEL/9KfOv4
 nGHA==
X-Gm-Message-State: AOJu0YwulcBoVQE4u/lP1qEUqJnyqUKEfWA4EzTsme7acmp7poCc07kE
 1wENPlZIBocBLapDMQ9hWe4VTtBpaMg1NAhXXfjotyYSngN+acJ/v2jGHiuu4+D/0Ro=
X-Gm-Gg: ASbGnctXkQ4xDDXMv30GAu0LwG6gv8CKzrYScZZTeg0XFT8N3RjZENwBLWRE8Y2if+7
 WPQuOFt4S5FcIZZtbldYskz9edZIlH/7ZRhrIG/rBBOX1uWJnd8DX/xUQJrfTg61ByKrl1Luv/3
 3g0B+9BmHrBh3ObpStRdPoz7y53siBbsclbkygJ1/Gf+jtzuPU061BfKchr5IBF59jenQDBgn/q
 fRwsyWuJ64WyXgW+L1J83JKfM4/iF9um5xlKUtGxmJ7Tm7T0kmf8Nw5l5WUvr3sm2Za2fbEpR5F
 OuF4r3RN/zc+NdqfIGiqxgye8iv1AncvwCEWsyauHGErxQFdTgZAFvyMSsTZgpaJ9MKQ64VJOIP
 snjy6GVMx5snJqHJwUMrvvTw=
X-Google-Smtp-Source: AGHT+IG8O5LisGCJqQjooVRofew8AfKxxZPJlo3uv9NlOBugr5CIhWl+BuaL1Hk09d9Rqrh2cT3JHQ==
X-Received: by 2002:a17:907:940c:b0:afe:8bd8:e2c3 with SMTP id
 a640c23a62f3a-b04b1a804d1mr1248822966b.0.1757407595767; 
 Tue, 09 Sep 2025 01:46:35 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aff138a8d76sm2477468766b.104.2025.09.09.01.46.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 01:46:35 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3BF8F5F829;
 Tue, 09 Sep 2025 09:46:34 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Yonggang Luo
 <luoyonggang@gmail.com>
Subject: Re: [PATCH 4/4] gitlab: prevent duplicated meson log artifacts in
 test jobs
In-Reply-To: <aL_QzBYYd4HB0T3Q@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 9 Sep 2025 08:04:30 +0100")
References: <20250908190901.3571859-1-berrange@redhat.com>
 <20250908190901.3571859-5-berrange@redhat.com>
 <87v7ls7i8t.fsf@draig.linaro.org> <aL_QzBYYd4HB0T3Q@redhat.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Tue, 09 Sep 2025 09:46:34 +0100
Message-ID: <87jz286mj9.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, Sep 08, 2025 at 10:21:38PM +0100, Alex Benn=C3=A9e wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > The build jobs will populate build/meson-logs/ with various files
>> > that are added as artifacts.
>> >
>> > The test jobs preserve the state of the build jobs, so we must
>> > delete any pre-existing logs to prevent confusion from duplicate
>> > artifacts.
>>=20
>> Will this cause us to rebuild needlessly?
>
> These files aren't involved in any rebuild / stale checks &
> the test pipeline I ran show no difference in what was done.

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

