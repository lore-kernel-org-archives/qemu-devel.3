Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F5AAC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 12:46:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1who99-0006j9-2c; Thu, 09 Jul 2026 08:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1who97-0006iw-Qw
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 08:46:29 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1who95-0004oy-SQ
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 08:46:29 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-493c83474ddso16264995e9.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 05:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783601182; x=1784205982; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3yHZ30R1qJ2DDZ6Rv6EGmIzKSoIqKMi16je8kwQXqvQ=;
 b=FlcaQFUi8kHjNCCLgjAyu0ev+BLldQLDb1UeRr26lAKscBPSBXIovLoofWgMucv0tJ
 XuzBQtc//zmn6znLnl98CP5+oZyXLQUGPianoxY/Z/ZrV07ZPRUcem+GKhpWPeR322Xs
 d4wmnCwUfshAJA/PrjlbhavmdAc+sdn7XqGModRLK32GnTh/M7LVoHnxUruJTE0KjZQq
 MCsyYHLBEjHRcJvVgTKSIzW8wE29XZL/DJzUrPpxuBIJ3fGAKTt4OZYlTf3pJJK8nTom
 cigInFA2i/kFJTzr+054RpiAc9rA1aB++nxnNVXsS3lek/uwwR1xOtW42Y9sE0iuNRAJ
 o6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783601182; x=1784205982;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3yHZ30R1qJ2DDZ6Rv6EGmIzKSoIqKMi16je8kwQXqvQ=;
 b=Ca8e2G7tdX0Rvs6Ijm4Fg2CH0TNCDfoC1v9nUT1/wcMqMEIZDHs5pfi1WAq20BC++H
 G3nW4PYmEKdncdFPaACICMbnQQkVo6FiRvd+oMewMiA7tR2Qf+HFmNN7PFdwOhHc7DNw
 WNdCZI/UYAlzrbJfG6gLoYu8W0stjCI5xB2rIGJBYeXRl6g4dfSx3/kqyRn0NJYXSPEC
 iqFpcxCjz9cCpdFN8EvAAdk03CaqV2oIjwvuSRr2OJX9CmG6dUVmw+e4EFS94XOCmZKh
 a1zd70/dWrRK0I1QtjV71i1l9aiKscKVEa+ylOpXloJCX2e+qpbK9n5NygIl/lg3pLCj
 gvHA==
X-Gm-Message-State: AOJu0Yyp2/a07upeL0mSSKftdkVYdUI5Rjxh0FtTqHM8uMD9+i1jGuHD
 AOKo220f4sQU46llbIpJ6oifF/HI/moXdpTwPVcEQsYGuHvydBPatk+gawssOmRmiss=
X-Gm-Gg: AfdE7ckImj68wONKduaZRgJCx3TRSZq1IRLD8zLWAk6jiWBRp6PTDMO7sucMbkcU5TJ
 2L4yX3YWisnkIlZkbbdi4vPBCFQG95tzmTc5cBYGPd082zLbVdr3+tu2GXT5brdGsq9o8eyARPM
 XodDSVLule4bbvRh2vwLLjkucy/+Eyqlqg49wj3VOnYt04Hd3U29KaVCDOhkTLe2PUwLXrwdfFf
 emc4ysz+uLfECNB1V0+8mwJa50q6uhfynGGzUMeq7m+wK+cSmYhuKGZYlWSryh/QukjYFGcGlWp
 BUtenF5zDJ0KBhZtR6GmV73gQ6zjgf3xm5hxwTMWRT3hG+6YwcVESo/7me3YZKLFLgTkgtdlLhl
 z9E1KgO6uTJLzeHdBBZJOTp3je4O9oy8egSUlZejqOk8Va+SL55loGjyYvpSo+mK9gG2M9ThvSx
 SWV9IT4H5YFl1X
X-Received: by 2002:a05:600c:8a08:b0:493:eed4:7210 with SMTP id
 5b1f17b1804b1-493eed47225mr13330145e9.11.1783601182490; 
 Thu, 09 Jul 2026 05:46:22 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6f2e56sm72511855e9.13.2026.07.09.05.46.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 05:46:21 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 62CC75F82D;
 Thu, 09 Jul 2026 13:46:20 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,  Ilya Leoshkevich
 <iii@linux.ibm.com>,  Brian Cain <brian.cain@oss.qualcomm.com>,  Gustavo
 Romero <gustavo.romero@linaro.org>,  Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,  Helge Deller
 <deller@gmx.de>,  Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3 90/91] tests/tcg: remove Makefiles
In-Reply-To: <20260706223343.988769-91-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Mon, 6 Jul 2026 15:33:42 -0700")
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
 <20260706223343.988769-91-pierrick.bouvier@oss.qualcomm.com>
User-Agent: mu4e 1.14.2; emacs 30.1
Date: Thu, 09 Jul 2026 13:46:20 +0100
Message-ID: <87v7aos543.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
<snip>
>  tests/tcg/multiarch/Makefile.target           | 232 ---------------
<snip>

There is a conflict here, probably because of db6b71f1ad7 (Revert "tests/tc=
g: skip the vma-pthread test on CI")

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

