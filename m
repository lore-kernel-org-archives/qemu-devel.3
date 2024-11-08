Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A018D5E152
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 10:23:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9M8g-0007ju-7s; Fri, 08 Nov 2024 05:22:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t9M8c-0007ig-8F
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 05:22:48 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t9M8a-0003Wl-Mp
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 05:22:46 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5cefa22e9d5so2179836a12.3
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 02:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731061362; x=1731666162; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E50wz7jykj+ROZV5+dUA4vRjqLfB8DXoxy+H41uGIRI=;
 b=yZnlzXtN5wxe6tX2l6BIa1R/xLeS4S0juKaOUCvbKt4ZfCCyoiNT8xiSr7QQ5W+yKf
 0HOHLQf7nz55tlGdNS78uzfM94YUWl5K5R931yr7KwF5ESEqs6c2+kEt5YRC2xkY/jwO
 vNlMezpKZNf5/Al6mfy16dMCtPGZuUHfwiNVdX2bTmAnggnEgYkk/88vaezmZojSjedc
 d6kD9+uHCaqa3qMNn4Qc3DeQJlmbjtC96jGV4auD3J6HDk4hhuetb6C6joIyyilAZ/d8
 kW0ZZdJskYmHoeoQITAJV7kXiXD736W1UbC3wME4AGxSMxlB6H8vgP1zCFny/zzv3kym
 M8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731061362; x=1731666162;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E50wz7jykj+ROZV5+dUA4vRjqLfB8DXoxy+H41uGIRI=;
 b=E9aDiudSOJqxpvYZGibMXavr0fk4/0A3GYiiJ3GS8TJzbN1P0UqzpL31uthMQ5uGaf
 U0X0sQt+YafSCXocTeM8LlwkNmGaPEaC0fwqFihQBhElLv//I9AF8/z2rzxag5eDkSHd
 dj9o1AUosvRNjpVjUq5B9OSHzykVokiWx/T+czNoSRcrAnsDE/SkPQuNVTmtmcUIrBms
 p7WQ+91I+WDWFmpcstIdnthq8p8eUhNbu7Tpw3UXA4hmVwgVxsTyr3MNa/IN5WzWTMkk
 OSZWgLU8eyDkb5OhsNBfvBgFXIwGNMqu4hpHszu9zKJca+xDjksz+fVWtGfux9aBsehf
 h2HQ==
X-Gm-Message-State: AOJu0YyLhyTk9WtSdltrY+ZpuUzfLfOoRR/yHpyjMHh1Y5Q63tR5c3u1
 6UI1yYt9anUA9AkDj22rT2lgrqTjGEuBtXG3/ueXAmuMzOddMNBcm+0M7l49TotZRJ/FHm3yrTB
 u0ZkqsIyxcov8MqK/elOqA98ELAKoMldonaH8FIRkQA2od6fz
X-Google-Smtp-Source: AGHT+IFWSWWH8NfKVyFOAWuLMkK7bNYIVGzfZ86PY6PzPWXZCkpT+ZhUOisPcKTyX5p4p+TBNYpPSaS0n7A18J1uN2c=
X-Received: by 2002:a05:6402:5213:b0:5ce:fc3c:3c3 with SMTP id
 4fb4d7f45d1cf-5cf0a45c690mr1747029a12.28.1731061362370; Fri, 08 Nov 2024
 02:22:42 -0800 (PST)
MIME-Version: 1.0
References: <20241107150534.38651-1-stefanb@linux.ibm.com>
In-Reply-To: <20241107150534.38651-1-stefanb@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Nov 2024 10:22:31 +0000
Message-ID: <CAFEAcA8J-SrhhAVnwygrgvntf5KEWgpqm3M9MZ0jn5Z9qHdk2Q@mail.gmail.com>
Subject: Re: [PULL v2 0/1] Merge Aspeed TPM test 2024/11/07 v2
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Thu, 7 Nov 2024 at 15:05, Stefan Berger <stefanb@linux.ibm.com> wrote:
>
> Hello!
>
>  This PR fixes the path used by swtpm to store its state and now uses a
> path under /var/tmp rather than a path local to the test. We ran into
> issues on Ubuntu when that path was under /mnt and therefore not
> supported by the AppArmor profile of swtpm.
>
>    Stefan
>
> The following changes since commit 63dc36944383f70f1c7a20f6104966d8560300fa:
>
>   Merge tag 'hw-misc-20241105' of https://github.com/philmd/qemu into staging (2024-11-06 17:28:45 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/stefanberger/qemu-tpm.git pull-tpm-2024-11-07-2
>
> for you to fetch changes up to e3edada526f3ac28f71dc8ae7a0acbc76f8e2050:
>
>   tests: Adjust path for swtpm state to use path under /var/tmp/ (2024-11-07 09:57:20 -0500)
>
> v2:
>  - Added missing comment into test file; generalized it a bit from Peter's
>    suggestion
>
> Stefan Berger (1):
>   tests: Adjust path for swtpm state to use path under /var/tmp/


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

