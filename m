Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2BC8C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 13:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzDGk-0007jy-6L; Wed, 26 Aug 2026 09:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wzDGi-0007jq-Dv
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 09:02:16 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wzDGg-0008NC-NP
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 09:02:16 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c160420289bso119871566b.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 06:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787749333; x=1788354133; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xdIse+755ESEtXAf8FTGrtnACDo5SMWBhg0NlB1V6wU=;
 b=MYLIlXxuMqF8cjAE1TDBQFe8qwjzQcM/mB+4qxInu3bTuh5qr+mm94G6Yul3/AEcRV
 O/zvTMeCLaZYuByssR7e9cGBPWdMAEs8GJ1ai3gCA6SrQyOjMVWi63uQ9fSyZiL+PNfb
 V4e9oAKm1LCe6dDzL9Z1JweA7E4jETyvUKLgSX4O/k1COldo5mOxLnJbYRJQa+Hy9j2Z
 +O7I68d2T0mE12Kh/5eX9AgNLOSNVndz8Ayzi89mv3VvmpZBZ3+Bimr27XeKURRkZVSf
 sdDCrZbT0Bh+I6YZYAR2eZBDqbYTmacAQwM1+aZi3B/9XHYVvSrdamryhdF/2f740Mi8
 I2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787749333; x=1788354133;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xdIse+755ESEtXAf8FTGrtnACDo5SMWBhg0NlB1V6wU=;
 b=UMuJgVZfGjrGmSehJQsGNfeXOVbUFH9Xo25/fEc/Aq0qyC0sTiTtqnFom1xDPhKwYC
 MPrK8E1sglj7HKhNzJDYrv9iSYxTvBiaJtnjUJaSEKpxzq+HN7sikGOWBTVBKV4E9qm2
 VdJPV7po6KHBkV0lm5x9oUNbBGC0sY17M3Npl0T09vG/HI2EH9s5TYXlWpGFOG8nmHat
 Y7uMBeE1hRadwwUPgcTFapUTZTZL4iw9+ojpSIXerOp37iouVfLYENsTVWOEJ1mumoFt
 Q0WqpTEtpbhh52v6wS7M4fRd9xLBzguIDLWO0vSt0wpYX0vYE0C4zFwSejbD+IXGEqWJ
 54WQ==
X-Gm-Message-State: AFuF++n/hLjR7Iu750xR28NJVx94yJNL9piEQl/FenlNCOcUMNSHhYZr
 USxvdwRD9D68ENVY6uAtAJc1PUcHyyqvolqBIzmxAQ6sJd1SDNMnzM9NtcDsq3QfKUU=
X-Gm-Gg: AR+sD13Y6im3/jVB+NBCmE8UUXZ8sCu7oFjospqhrUTUJtBUpHo4ZSQ7iIYv5RPFUzF
 QpJx+jv/to9URx2EWCULbSfevHfD+kxIck4RO8Sqw2WgS3fN3maRy9G8ZNUikipRQ/Zw90zuNfa
 M4uzae/jKJjVQcCdCDvHEYwfqp6fdryVdzAVuVzwNQz5f9sMv7EU28yLSS9tmQlp8ao+d694kp4
 BNw6AwbWgR2QCjKFwEdA9BqH347UQnbQ4KJxqyVVNPA0JRo8UecYQ0zU4yT5qJ9uTp5c5RhxwpC
 4gTJ1+Byonh2jrm5mj2qfbPN1t9HUf8MMIEBI41wb8ab0ZUPf21oyRycSti3RY6DtVJCZH1BfbB
 IZ3D3iRcfJ6O1kn8anDfjJKohzC5XLma2Xef1VdybnObEWJHr2OtQpXrgdHdiickMANdqUynVys
 CbYsCBZpf43ZbHs4yppp6KAfqAVtwpwD2qk0/mKChup1KVIDB44r3mGjvyKIWD
X-Received: by 2002:a17:907:e1d3:10b0:c25:2e93:289e with SMTP id
 a640c23a62f3a-c252e93300amr222355066b.16.1787749332613; 
 Wed, 26 Aug 2026 06:02:12 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a730307sm409738266b.27.2026.08.26.06.02.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 06:02:11 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F0A7F5F81E;
 Wed, 26 Aug 2026 14:02:10 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Laurent Vivier
 <laurent@vivier.eu>,  Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,  Helge
 Deller <deller@gmx.de>,  Paolo Bonzini <pbonzini@redhat.com>,  Brian Cain
 <brian.cain@oss.qualcomm.com>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Ilya Leoshkevich <iii@linux.ibm.com>,  Aniket
 Sahu <asahu1x@linux.ibm.com>
Subject: Re: [PATCH v7 040/104] tests/tcg/aarch64: user tests
In-Reply-To: <20260818192309.22169-41-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Tue, 18 Aug 2026 19:22:04 +0000")
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
 <20260818192309.22169-41-pierrick.bouvier@oss.qualcomm.com>
User-Agent: mu4e 1.14.4-pre1; emacs 30.1
Date: Wed, 26 Aug 2026 14:02:10 +0100
Message-ID: <87ik4xnigd.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
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

> Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

