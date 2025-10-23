Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C99CCD1BF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 12:16:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBuFG-00087Z-Fn; Thu, 23 Oct 2025 08:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vBuEv-0007Hb-Bc
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:16:26 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vBuEs-0006Gd-7u
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:16:20 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b6d5e04e0d3so37023266b.2
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 05:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761221773; x=1761826573; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ih//sRhSyHA9hVOZL8Tj2g2gvQANfeVCuUwMr5JE4NM=;
 b=rVO1oV9PHXg5sbxam9cos7FbhaiMHaMQJml8DdQL+TAGVjn12/az27FgIHAn2fjyZ7
 39ndAd3uXpAX7TFB+SKZqqrCX/hT9g4hsjZUfsSw/jR4joTguzg03RbiPjAVUepHX8B6
 ZQcGz6hmHzfZYky8YTRtg5xpOwxc+UTZwN7jE46YiH5dqYz8tZmN6j1i8OCHwHRaF8vV
 hgw4HCL4/ZScwGGbeUupN8S/JdEQeJV8lgc8ObmQBe4rojTnDwGxpm0b5urNmJpDOrFQ
 0cnsxAHArxS/pA6YahjgwFlW10a4dwLKsJ3tpxWI+xMdY+AJavlzu26mIJxiqt8l8Nkg
 cV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761221773; x=1761826573;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ih//sRhSyHA9hVOZL8Tj2g2gvQANfeVCuUwMr5JE4NM=;
 b=VU5I626S5fXHZmFWXaBEwmypJpjl5dwLkIb44WsAxpNEGmlFWufYE+ziLohxh5GMXA
 wI34HKO27XByNNM0fSQEzwzRnw7dxCrU27LVvcRbsOl0HQluvB4GXJ8JdolgfrO0V4r6
 Y/Cm9QcW01BmHUCghPA7Kkj6XwI+JOOjrPexNSpa7fhtsWoCOuBcL6pxEoshIEuBYThf
 POgko1WPJc+8sdx7E9ukdCoq1Rqec2wtYaojrYmqSwxGKtoVd6WnzXEHqBbRVt+6FCWS
 99ALa2JSNnnXc/+I4MVZ+03syGLVuCVCExaGyUBsIXi/qSnc0+CnVuRKpQV0REPr6Mdn
 U2Jg==
X-Gm-Message-State: AOJu0YwtNdSnLw4irZd5sDUcF+Cq0ayleUxFls9UklJ+B71lMhVA3v0o
 CrgehZXvE2fY+6CWOiCvQI3g/UYxm8YSVQpUSnKwkmS4+5WSqYJ9UuBB7ueOULCEpHC8hAJ5ygt
 6Qk+PUNs=
X-Gm-Gg: ASbGncu4uC9bCn8qhigosjSzX6va+XQ2PVyulMXJR9wu6LAExgO/GgvEW9Bo6d0FaTF
 pJH4FeUV9bvNxcva5VllPEHCdwobWayeVsfAQfAuOQ3ztJ1ObiPSyP/lqXrQfoADNn/gf6Zfs3m
 eR+I1y/2WKHwNQDMWt1B8gOQO1cXrVs36CigxwU8khHfG0fMyomHCLInqKv9hKIE8q2Jvj2EpCH
 7Jez4/DkKbSw9hwqJCtNkt/ArWd5NEpW9ORBu2/N44uKeOGRTCCqMzxuquqYldnk8AsUukDGLTA
 fEr19HsjwoVb60fY1jDHfLO1UBZQe480m7CaVJX3gIgzt3IzYkWLd3I2VZ8aNVeFx1FqFDi/XqC
 6BAx/0AETJGCQ6XVOd4FvI0ap7p8Wrc1rAZAlLMzhx1ETdGh01dJLBb2qRBDhFKh254QG6LJczf
 WA
X-Google-Smtp-Source: AGHT+IEcfEPCKO630AYFgoHcXYElDyKqMrW86n40wCsqTZ2KdkUg9MAMPxXaaLm8hlOCmaGcMMFCIg==
X-Received: by 2002:a17:906:fe4d:b0:b3c:e14c:e24 with SMTP id
 a640c23a62f3a-b647195b339mr2711608566b.13.1761221773209; 
 Thu, 23 Oct 2025 05:16:13 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63e3f3348cfsm1542139a12.35.2025.10.23.05.16.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 05:16:12 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 81CBA5F7F5;
 Thu, 23 Oct 2025 13:16:11 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Julian Ganz <neither@nut.email>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v8 00/25] tcg-plugins: add hooks for discontinuities
In-Reply-To: <cover.1760884672.git.neither@nut.email> (Julian Ganz's message
 of "Sun, 19 Oct 2025 17:14:49 +0200")
References: <cover.1760884672.git.neither@nut.email>
User-Agent: mu4e 1.12.14-dev1; emacs 30.1
Date: Thu, 23 Oct 2025 13:16:11 +0100
Message-ID: <87ecqtn790.fsf@draig.linaro.org>
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

Julian Ganz <neither@nut.email> writes:

> Some analysis greatly benefits, or depends on, information about
> certain types of dicontinuities such as interrupts. For example, we may
> need to handle the execution of a new translation block differently if
> it is not the result of normal program flow but of an interrupt.

Queued to plugins/next, thanks.
--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

