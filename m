Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B32C5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 10:59:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu6fU-0000Os-Hm; Wed, 12 Aug 2026 06:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wu6fP-0000LP-QK
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 06:58:40 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wu6fO-0006nE-9t
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 06:58:39 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-47f59f25ec4so286006f8f.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 03:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786532316; x=1787137116; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eCMqXrLKmVqUQkFbYtIWjpKxJ4T7vNu+euGtIGX1DTY=;
 b=COEPt6WPz6HbCh9XR3mNQEzFDB0NRnXxvFYm2w0IxmWCF4Jbmtw7/R6HwOmGan3e2L
 Yukth4hh2WOVoCe9C80D/jWuO4iVKzePuoJ8bbbG3MxN4NOUQSK3GzYOd90sDj4YCYUi
 hjx5YBLuCD1lPFl1h2GwwnyR0jf+dGc9r4+4Dr6x71sjFpmFcBcJoBiammGNf0uRO1nB
 bFaMkapwrzSoBmcaWtwJV6YK7l7eIwAnXkzAPj8MjuenJinLNDHzDiv+u89upBsAKTMj
 03Rzvl1Cn8bGvp+1xk1dQTGZJSJVgSDmRTKlAQNOqCo6PFtodz3RMQodJRzHjB5i5bI4
 ndMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786532316; x=1787137116;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eCMqXrLKmVqUQkFbYtIWjpKxJ4T7vNu+euGtIGX1DTY=;
 b=JN/LkrQIPsnf0e2TXA3ph5TCRvlgj6TBeKSc1JyePlwbwLQ76KiOhjGppS7Pl8oR3y
 ZLjAq7wCpsj1FhvWA5v7KVIwfW8/hqKCTtTHAOGdaB639MJ8SPLYO299MXKLGBtk96Vl
 4EKszNf6mZ5fWGF6ZsWMd6iNy0JmmqAHlMDRMnup3kIAHUoeHixvB3BzwSK7vXcXsPyU
 iIP4MKSQGMJbUtnYdm1Lkm+8jKlr0oLNSkHp2jTJsaPHInDkPZCA7a6DdcxbedVqIYyj
 GZwLvrEyzx2tVRqZRcNtVQUa/BcYtGqvv0P3m54DklNW/cxWSUtMHDySose8f1PRSMsX
 VisA==
X-Gm-Message-State: AOJu0YykKavYt0NZmNO8dmw0iLEEv/60eHlhPNp88rjVt68jz8CHIQSH
 1a5sDRwVNuJbHZrU6x73r9ZctTziFhPEOjVRbGF5l6WZbEiSyH9v1lUzwsgwj5fGBMM=
X-Gm-Gg: AR+sD11tRcY5fB1K85jeWjHc1TsPrdH7vy8Yw2f/XMbmb2LKSBFto8l+qKl3AVSxXCD
 wQgdDiLfrqQzL1AchKkjm4Wbg8qkpF5Kj4DX2KeQRNMhFoBSel8Q2a49Dtr/OJuTC5QA2EGZbcN
 Lc5ynlR+1xO78gzv1I0dblQG7i8tFDoBuoSNCA3GQjsASDXtG1kOvhmTsDIQTPCQGxpK6OMhtQX
 +KH7tT1c9Jm8AlRgDOvdXRizMmVnOF/5+HqqAe/l2YH7LmIB2p33n3miMRaV6zXZzMr8dxizUMw
 rUin/IdIlsqAMvZnqGlE/vfBU9VqZbRINLxH8TsSirxnNnI0S0nwlekFf/hcoo8vwoz0JsU8SRK
 eUaHvwjR6Fhi2aXicqvTEiOXr/6CzaKUF8xPA9KJhcCaaBdhQkj3kJnINYAL8fZN/eabZAoqOZn
 8AZnQ0dEh1gr9KKutdlnRL99/hGMxSeegW9agsTqgsDbHKpznYnw/XrpzKW5HD
X-Received: by 2002:a05:6000:25ca:b0:47f:7129:e30 with SMTP id
 ffacd0b85a97d-48152b2c082mr5078524f8f.11.1786532316150; 
 Wed, 12 Aug 2026 03:58:36 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150c08982sm5851293f8f.14.2026.08.12.03.58.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 03:58:35 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F1C185F886;
 Wed, 12 Aug 2026 11:58:33 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Thomas Huth <thuth@redhat.com>,  Ilya
 Leoshkevich <iii@linux.ibm.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,  Helge Deller <deller@gmx.de>,  Gustavo Romero
 <gustavo.romero@linaro.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH v6 099/103] tests/tcg/meson.build: implement ./configure
 containers options
In-Reply-To: <20260728044248.137626-100-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Mon, 27 Jul 2026 21:42:43 -0700")
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
 <20260728044248.137626-100-pierrick.bouvier@oss.qualcomm.com>
User-Agent: mu4e 1.14.3-pre5; emacs 30.1
Date: Wed, 12 Aug 2026 11:58:33 +0100
Message-ID: <871pc31u7a.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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

> ./configure --disable-containers now skip containers build.
> ./configure --container-command "/path/to/docker" can be used to
> override autodetection.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

