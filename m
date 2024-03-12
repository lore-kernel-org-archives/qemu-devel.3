Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 115EBC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 13:26:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk28b-00036V-KC; Tue, 12 Mar 2024 09:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rk28Z-00034r-BE
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 09:25:47 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rk28X-0000KP-KE
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 09:25:46 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a45b6fcd5e8so665600666b.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 06:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710249944; x=1710854744; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KkZYi5zbmIfH3sAzPHv6AzYkXnsJcYpsPvCpTF+yf5A=;
 b=ghmteREjkIrldQi8u0u56GSkmHEJ3IxguexnimZbdfJsXF0QqcFy34pm6GnuvtG25Z
 9/N3vimTzACsIajTE+UpGq8kIXg3AIqTpeLYr0JhvU36Y8yx4yFPT3RFPy+wE3AsymH6
 Ngu3cbOP9XqYBuKjI3ZAuWMnoINkMz68N8PHYR7lftfSNoAtjp9Z6xKV1OhUvOChRwr5
 Kj9flERYgzZ7s7EdqVHgtXttRyxmccUZrFAhSRVyfso2ePOoky/yR9t1pLugVd1xww1H
 0stADNOoIo5RjyCCrMU+CmpGbrtVwg2lOYAx7tKKmcmA4p23ujje+dXWJQL1k8rKcXmG
 KPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710249944; x=1710854744;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KkZYi5zbmIfH3sAzPHv6AzYkXnsJcYpsPvCpTF+yf5A=;
 b=ehDSyNl0V12KyYqwVxyCa/bW+KCTdzth4e+A57fEbc3X/Qdz88AfEu1pw4wDMkvZxR
 jYtGNv2EqLRL62by45APm0WuIhZ5MLk7glFSvKy0NAixTC2kLRNXzj+mkc+bpYjeUU8r
 UWcGnIR36c7L9T69maj0IM4SgRDuQUvAhRq4P1j+ttFF8M9HA5jsRynUrJfR/4SLJhK4
 O8K74q1gWnYFTjhl7A02eOvizh/et4ECkcCiPSYi6BgUBACNUHIQfTnl/HuUtOEc5Dcy
 svF2sAP5t+UxQMA3pnqbiAIxzKPRhg4M56NxWtGAZS1s21wWC6HJtY1IinYPs1USAxNG
 LhUQ==
X-Gm-Message-State: AOJu0Yy+hvyAPKxqtlEp669v4dDBCSiWxiuLMHLZxnRB4SKNvBSy/Olj
 UCH7pglFILOR2tG20W2Tyy/KrJo5emlp491y96sqVSImYi4q+vehFIBC23qZDWI=
X-Google-Smtp-Source: AGHT+IGhA7NhFZNKBa+SMHlZbb5CEjEGzYMpqwXcjr3kL4toy5hCRRBxPTHdelnKJSTXySp/VwrVQw==
X-Received: by 2002:a17:906:b6c5:b0:a46:2243:27b with SMTP id
 ec5-20020a170906b6c500b00a462243027bmr1454488ejb.56.1710249943961; 
 Tue, 12 Mar 2024 06:25:43 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a10-20020a17090640ca00b00a4550e8ae70sm3878177ejk.63.2024.03.12.06.25.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 06:25:43 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5EC6C5F863;
 Tue, 12 Mar 2024 13:25:43 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org,  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Richard
 Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>,  Cleber Rosa <crosa@redhat.com>,  Wainer
 dos Santos Moschetta <wainersm@redhat.com>,  Beraldo Leal
 <bleal@redhat.com>,  Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH v4 03/24] tests/avocado: excercise
 scripts/replay-dump.py in replay tests
In-Reply-To: <20240311174026.2177152-4-npiggin@gmail.com> (Nicholas Piggin's
 message of "Tue, 12 Mar 2024 03:40:05 +1000")
References: <20240311174026.2177152-1-npiggin@gmail.com>
 <20240311174026.2177152-4-npiggin@gmail.com>
User-Agent: mu4e 1.12.1; emacs 29.1
Date: Tue, 12 Mar 2024 13:25:43 +0000
Message-ID: <877ci7poo8.fsf@draig.linaro.org>
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

Nicholas Piggin <npiggin@gmail.com> writes:

> This runs replay-dump.py after recording a trace, and fails the test if
> the script fails.
>
> replay-dump.py is modified to exit with non-zero if an error is
> encountered while parsing, to support this.
>
> Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

