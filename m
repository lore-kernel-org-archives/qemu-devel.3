Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E74D2ECE6
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 20:55:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhwFR-0002At-BA; Mon, 19 Jan 2026 15:53:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhwFM-00029c-5X
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 15:53:12 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhwFK-0005mZ-D8
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 15:53:11 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2a0d67f1877so31546925ad.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 12:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768855988; x=1769460788; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A+A7cVCAswnFS5egGy861iJ2dG6pr17EJV/k2Lhmo70=;
 b=M8ZxaXFieaoJADDnWStP+XZVCNS8or74P7C9SnwWomEqsaQllpgb38QKknXp0S1dGc
 86y8YI631nXC+ULkyuZI4AmtBsSrQLE+JJwWfbRafu7jnmOXhp3D/jfcSZYvIz9fKhGL
 e+w97ig22OECdH+lTSUU9v7caLrT4aNCCWZFDG1/IYPkdIB6YaaEyev5jdDEULU5GlI+
 E0KbLd1gFMJSoP8z94QwnhAJlqpaCA89Aq56sYGcncCyglNcBg918N5Ux39JIb2ANfqL
 2gvTtrspfGB7rkZ8VfXDlLmP/bxKsMWPRTXAWM0qaYQ+SCYpJpQr/rCQcugmyCTc7WAI
 YABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768855988; x=1769460788;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A+A7cVCAswnFS5egGy861iJ2dG6pr17EJV/k2Lhmo70=;
 b=ufb82IMbLPkTEqZRGWdyWeROW+JOOqjJhVsJLlBb/NUybtAwVDTWNt0O4Wglqgz9il
 L9d9iZJuVOewic7UC4qkg9mCQ6bkrMl5EG2Q46Zltc4Ux0Uywdivn7OsUqxd+UINf6U5
 3TSKvSnAL7P5skkI43MF4UEF1VqB56dsVVWqGiK1Wgt0stHAkommMQrOIBxEvpXC82mE
 bjD2Ejf64nGUZGOQKX+tKJgdDFHlllGwIy+Asyc3nV0hDV+0i4KEoFTnMcX95uSEO2z9
 /zke1/KKbADUj3pp7S5qkoK8fkmGjFuBSt9jTNL3ep1e3tOB5vGeGamiG09v7Twgn8TX
 xgXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzEj+EAutFiSf95bI9S/6u1rBTcDC1Nc/tf4Irgtti9YdmEx+i1fFFqROz+VdoFZCj6UTQd6qr4M2I@nongnu.org
X-Gm-Message-State: AOJu0YyvG58K6PsaJF1dhM+hR0eFgEa6JLUtsQOXgBVyCffP3gJ1L+Sh
 f4hM1ss9q89ZfbbKqUDLzSWmrnllZ76oyOMPC0qqfZ3/lEMGx4EmOqg7x54yhnXXCjg=
X-Gm-Gg: AZuq6aK4eiu57y16m5eKrREp9XyWIO/dY9LObRJyfVVtcgWX5aXcsvZPRIHxDx6clYD
 20ww2PC0BJXZrMV1GhbvxvHIqIOIjenCAJNmLNMR3FLDURzbb/hFuRp4ObALU4kGDWg7k2SwWB0
 LJQDVvQelGfs34M0vgMfRB5StC72UbVLrrz5bYV3eAYSSZNnYeKQSQTdSQuTfT6rwpYDcPicnSB
 zbsX3SaYsxKQ3xqMq5JxqOxZ/Dm6tPzSSYKKGGvNochWzYiSBcDRQcIKlKHrG0o+dVKtyLnk2SU
 xgdilhobpzkybiH7b2PRbq/PNFjh9gRnFqsTPidb4KTXfAKtmfpkXMGmXt5qfNTBhHmtLfwTV68
 CNzVxXgbUwU/pbFGMtYparJ5180L2DEq4Zsb2Q8BWkTzGCozlWHZ8ws2dDZ4bi8BFzg9mmoPInB
 jP7VHmKo5oOfMohKR+5TB2axaJ7N+t9g==
X-Received: by 2002:a17:902:ecce:b0:29f:2ec4:83eb with SMTP id
 d9443c01a7336-2a718971860mr113792485ad.53.1768855988394; 
 Mon, 19 Jan 2026 12:53:08 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a71941e3cdsm101910825ad.100.2026.01.19.12.53.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jan 2026 12:53:08 -0800 (PST)
Message-ID: <2bf9fc90-c7c6-4439-8ac8-d955950591c5@linaro.org>
Date: Tue, 20 Jan 2026 07:53:02 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/8] Tracing patches
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Richard Henderson <rth@twiddle.net>, John Snow <jsnow@redhat.com>
References: <20260119190823.867761-1-stefanha@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260119190823.867761-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 1/20/26 06:08, Stefan Hajnoczi wrote:
> The following changes since commit 38879a667fbb4ef54c70de71494882615f600a64:
> 
>    Merge tag 'pull-tcg-20260119' of https://gitlab.com/rth7680/qemu into staging (2026-01-19 09:04:31 +1100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stefanha/qemu.git tags/tracing-pull-request
> 
> for you to fetch changes up to 0527c4fdd28ae8b13ecc34f80b91e42ce42b917f:
> 
>    tests/tracetool: Honor the Python interpreter that "configure" detected (2026-01-19 13:58:23 -0500)
> 
> ----------------------------------------------------------------
> Pull request
> 
> - Thomas Huth's Python interpreter fix
> - Paolo Bonzini's tracetool cleanups
> - Stefan Hajnoczi's tracetool test QEMU_TEST_KEEP_SCRATCH=1 support

This has lots of failures:

https://gitlab.com/qemu-project/qemu/-/jobs/12772423978

> Summary of Failures:
> 507/512 tracetool - qemu:dtrace                                              FAIL             0.03s   exit status 1
> 508/512 tracetool - qemu:ftrace                                              FAIL             0.04s   exit status 1
> 509/512 tracetool - qemu:log                                                 FAIL             0.04s   exit status 1
> 510/512 tracetool - qemu:simple                                              FAIL             0.04s   exit status 1
> 511/512 tracetool - qemu:syslog                                              FAIL             0.04s   exit status 1
> 512/512 tracetool - qemu:ust                                                 FAIL             0.03s   exit status 1

https://gitlab.com/qemu-project/qemu/-/jobs/12772423994

> Log file "stdout" content for test "38-tests/tracetool-isort.sh" (FAIL):
> ERROR: /builds/qemu-project/qemu/scripts/tracetool/__init__.py Imports are incorrectly sorted and/or formatted.
> ERROR: /builds/qemu-project/qemu/scripts/tracetool/backend/__init__.py Imports are incorrectly sorted and/or formatted.
> ERROR: /builds/qemu-project/qemu/scripts/tracetool/backend/dtrace.py Imports are incorrectly sorted and/or formatted.
> ERROR: /builds/qemu-project/qemu/scripts/tracetool/backend/ftrace.py Imports are incorrectly sorted and/or formatted.
> ERROR: /builds/qemu-project/qemu/scripts/tracetool/backend/log.py Imports are incorrectly sorted and/or formatted.
> ERROR: /builds/qemu-project/qemu/scripts/tracetool/backend/simple.py Imports are incorrectly sorted and/or formatted.
> ERROR: /builds/qemu-project/qemu/scripts/tracetool/backend/syslog.py Imports are incorrectly sorted and/or formatted.
> ERROR: /builds/qemu-project/qemu/scripts/tracetool/backend/ust.py Imports are incorrectly sorted and/or formatted.
> ERROR: /builds/qemu-project/qemu/scripts/tracetool/format/__init__.py Imports are incorrectly sorted and/or formatted.
> ERROR: /builds/qemu-project/qemu/scripts/tracetool/format/c.py Imports are incorrectly sorted and/or formatted.
> ERROR: /builds/qemu-project/qemu/scripts/tracetool/format/d.py Imports are incorrectly sorted and/or formatted.
> ERROR: /builds/qemu-project/qemu/scripts/tracetool/format/h.py Imports are incorrectly sorted and/or formatted.
> ERROR: /builds/qemu-project/qemu/scripts/tracetool/format/log_stap.py Imports are incorrectly sorted and/or formatted.
> ERROR: /builds/qemu-project/qemu/scripts/tracetool/format/rs.py Imports are incorrectly sorted and/or formatted.
> ERROR: /builds/qemu-project/qemu/scripts/tracetool/format/simpletrace_stap.py Imports are incorrectly sorted and/or formatted.
> ERROR: /builds/qemu-project/qemu/scripts/tracetool/format/stap.py Imports are incorrectly sorted and/or formatted.
> ERROR: /builds/qemu-project/qemu/scripts/tracetool/format/ust_events_c.py Imports are incorrectly sorted and/or formatted.
> ERROR: /builds/qemu-project/qemu/scripts/tracetool/format/ust_events_h.py Imports are incorrectly sorted and/or formatted.
> Log file "stderr" content for test "38-tests/tracetool-isort.sh" (FAIL):
> Log file "stdout" content for test "39-tests/tracetool-mypy.sh" (FAIL):
> tracetool/backend/dtrace.py:76: error: Function is missing a type annotation  [no-untyped-def]
> tracetool/backend/dtrace.py:91: error: Function is missing a type annotation  [no-untyped-def]
> tracetool/backend/dtrace.py:99: error: Function is missing a type annotation  [no-untyped-def]
> Found 3 errors in 1 file (checked 18 source files)


r~

