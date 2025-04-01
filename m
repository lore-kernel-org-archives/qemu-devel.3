Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFEC5C36014
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 10:30:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzYsg-0007D0-W0; Tue, 01 Apr 2025 06:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tzYse-0007C7-Mc
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 06:30:04 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tzYsb-0002tW-OI
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 06:30:04 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cf257158fso37997235e9.2
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 03:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743503399; x=1744108199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=exM0qDUXriN627sYJi8hnsjMqODQyivFPPjPhdDB09s=;
 b=Wb0VppCo60UHlRXlexvCom4lyRtc5FiZVAdywbQi3umKM6pv18xenyUUrfT+Sx/FPs
 gMr4MRkfPtqURoodju4v0rAK727d0tIYpyIBwzW2oYmM+kYdE08iePp+3Gsx2pHPCRu9
 Q3Jpj1kedkr5GWqfLcOXPOWlsW3q3WGTa53WJMxefXn4J3twnenxWWQCxtdhqHyx5fpY
 Gx7VIJPra540AmuRvqB0gGLK5db709BKbbDdRO0Xpbz7rrB7x918Uixx0ykhEXd2WLZ8
 kgVhkqm5cmiGD1cDblZ2FLuNNmk0BAmk+BXF29twVEKe3lzLiHRJXRvXrMcSCRlTVzOz
 Uz7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743503399; x=1744108199;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=exM0qDUXriN627sYJi8hnsjMqODQyivFPPjPhdDB09s=;
 b=ME9zxZAQHQQrb+ZcDu0GCNcJK1iMu+7Tw60OGD+WKjnEJXDBCnX1fxpVVUjs6QBD2M
 1Wwx4Kc+lYhuI7Tl4fwR7KHfwh8Yh08cAGOZ9CPHUuMOjDnab6LnS7FAxztlX9nCww47
 bfP+xXluRtkGy9t0Xe4WI4WyzViv37Tvkmh7KlDl5DxrRXxM0+sMCSt/dSKhu0wMRwym
 z1+DCegjnhyiecTMcc3cLBRQh0Ygbkyud2WIPrXhN1pOxyKW740KC87+sVRbyqdvcBCo
 +9Fm4cNPdniJv2e8QS9Hm4iV38LltzlDsvqkQ7IcgHCDVNMpgW1xhHEr7tah8eMWB7UF
 0vzQ==
X-Gm-Message-State: AOJu0YywTL605T+pi4wcC9TfQUI39LZ28bOes6C5fwDJsYwmQKkGzP9m
 npBrnaJtQqpr4l8c07VrIOM1PSgoeas3NqWYcFsmvYqS59J7cUykAkpJjE/74sI=
X-Gm-Gg: ASbGncsG53pN3P+75lYzVkR79YDagC4LkLgsr6fVz6998dfnopUoIavrnyDxMu7K2Qq
 gzAbcMDBjxQ74LKkv7XfhyworG99TAA7h6tRRUfPRullsxMWKCjJXi5b+Bw7VoDKqcZgycAliug
 9i+tuK0+M3XCnt51Zs+3GJoWusVv68PiOtzDAnumb2oz/gr3TGYOJC1UjP5K6q1gmmldWA2QQvw
 gvFBi2DJs9e3wlOtX+O0lyZTqRdbmxSBnhWTIbaIwhxYUdjOdpNQdYGT27gMoVw6VPvG+A5O4wV
 repv8GkBTTwyl3VQnkq+JA/iBcE37T49znKCbvW75bRF4bg=
X-Google-Smtp-Source: AGHT+IHZd2gStGxa6cxCvJvgB2RYzQ2eSGI66GiYHsc/pYxwn4Q1PAczcpovJVRcNJXIx8fIFYgkyA==
X-Received: by 2002:a05:600c:46d0:b0:43d:7588:667b with SMTP id
 5b1f17b1804b1-43db62264d4mr135591365e9.10.1743503399634; 
 Tue, 01 Apr 2025 03:29:59 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8fba4c29sm157175245e9.5.2025.04.01.03.29.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 03:29:59 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3FEAC5F8B9;
 Tue,  1 Apr 2025 11:29:58 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  Peter Maydell
 <peter.maydell@linaro.org>,  qemu-trivial@nongnu.org
Subject: Re: [PATCH] docs/arm: Add apple HVF host for supported guest CPU type
In-Reply-To: <20250401083102.72845-1-zhangckid@gmail.com> (Zhang Chen's
 message of "Tue, 1 Apr 2025 16:31:02 +0800")
References: <20250401083102.72845-1-zhangckid@gmail.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 01 Apr 2025 11:29:58 +0100
Message-ID: <87zfh0npi1.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

Zhang Chen <zhangckid@gmail.com> writes:

> In my test, latest QEMU already support Apple HVF for -cpu host and max.
>
> From guest VM lscpu:
>
> Architecture:             aarch64
>   CPU op-mode(s):         64-bit
>   Byte Order:             Little Endian
> CPU(s):                   11
>   On-line CPU(s) list:    0-10
> Vendor ID:                Apple
>   Model name:             -
>     Model:                0
>     Thread(s) per core:   1
>     Core(s) per socket:   11
>     Socket(s):            1
>     Stepping:             0x0
>     BogoMIPS:             48.00
>     Flags:                fp asimd evtstrm aes pmull sha1 sha2 crc32 atom=
ics fphp asimdhp cpuid asimdrdm jscvt fcma lrcpc dcpop sha3 asimddp sha512 =
asim
>                           dfhm dit uscat ilrcpc flagm ssbs sb paca pacg d=
cpodp flagm2 frint
>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

