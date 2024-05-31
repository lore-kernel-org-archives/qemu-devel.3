Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C02C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 17:01:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD5cl-0005sj-Cs; Fri, 31 May 2024 13:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sD5cj-0005sG-C7
 for qemu-devel@nongnu.org; Fri, 31 May 2024 13:01:01 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sD5ch-0008Re-RT
 for qemu-devel@nongnu.org; Fri, 31 May 2024 13:01:01 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-354be94c874so1723406f8f.3
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 10:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717174858; x=1717779658; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nUQpIw0J7gYJntdrF3+fYQvrBvEG+S/20aOM1DWuFCc=;
 b=JGlb+hWeo33uaLoTyw/DjIodoBXaRJKUdEmNzc/wkQTGK6NZ1Y0vmM51GnPblFF/0K
 UshKwA43ET+BvQqPP4U/I/Pf4ceH7zOmAoWMbpGU/uA4gOmfSr28Ff3pQca9XEV4wrIN
 lQA18eNDjABXjYg1A+qtjtYPdui+ghkNzn9W/QH/rrIR2mdoHr5HfebnmrYzj6bO9JKm
 8Kdo5JHPbWr45azT4EagLRRgUFFuOw5jW/6yQkX3MmDS0r5BtpH3IG6dSfh3sv2/uikO
 7Wnlz0HQcYK71X9aFAaxwtzGdWk4RPq6tMz70e7PsY4sLn8WYPZFDAnYPOCxnK2g9JvZ
 9sUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717174858; x=1717779658;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nUQpIw0J7gYJntdrF3+fYQvrBvEG+S/20aOM1DWuFCc=;
 b=vx0XeY0BBU+DB8ObkYKNQ50uM+e8dqTE1Rv2pr/p8LIyvMDww6dpdBEfhWJHP1G9A2
 tEifntlvqAC0iEnC3NVWMeGCYls+8hfP7wrYMX0fWZlqNQ5PxurBt2YFwwXqunj21Yjx
 3P++Yd6d+37UuklGtHKH61ajxj5ryYeOlTT/x3ppm4O/xCg4fEnayNNNeJZzg3nWws5/
 WQ15zyNXnp6BJHvxvLEX8Uy9ywir25zPvL20KFc4xu5Y5V7VMGTNbKPX9H71u5YBq5KC
 1Z9G6xdDPUh6RPBrdBjfHdkAcJ+3Ayp+Y3RxX1FcuQKWjN1hV3ufv4B5/UVcJejf0p2x
 tQxw==
X-Gm-Message-State: AOJu0YwcfCYxuBxOLNm3iujdw9HcIWdGG6/CVJPXRVnmLNxGSskR3eVq
 hHfyjprJbUejXvpqAAPs5pqx9A7T4BVXeQ+Lsfs71cxuziyfeS152UjJfTZq1fQ=
X-Google-Smtp-Source: AGHT+IGV6GNODPVNW00WKJnfwY+dqae2q0LPDy7eBd71FRtnvqjIj6MmQy81J7jAev7CCyMYbdnM9A==
X-Received: by 2002:adf:eace:0:b0:35d:be9a:3e6a with SMTP id
 ffacd0b85a97d-35e0f30af26mr2027564f8f.53.1717174858198; 
 Fri, 31 May 2024 10:00:58 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04da756sm2244698f8f.59.2024.05.31.10.00.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 10:00:57 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1AAF25F8A3;
 Fri, 31 May 2024 18:00:57 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  pierrick.bouvier@linaro.org
Subject: Re: [PATCH 5/7] target/i386: Split out gdb-internal.h
In-Reply-To: <20240416040609.1313605-6-richard.henderson@linaro.org> (Richard
 Henderson's message of "Mon, 15 Apr 2024 21:06:07 -0700")
References: <20240416040609.1313605-1-richard.henderson@linaro.org>
 <20240416040609.1313605-6-richard.henderson@linaro.org>
Date: Fri, 31 May 2024 18:00:57 +0100
Message-ID: <87ttidapbq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

