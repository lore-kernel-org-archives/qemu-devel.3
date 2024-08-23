Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ADE0C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 14:45:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shVX5-0003Lj-7J; Fri, 23 Aug 2024 10:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1shVX2-0003It-S0
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 10:44:52 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1shVWz-0001A1-HY
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 10:44:52 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5bebd3b7c22so5080064a12.0
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2024 07:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724424286; x=1725029086; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=fDO1UunCpORbilzq8v5rXeDb+AES/vyYNU4mVBCcBgo=;
 b=IjO6Haj5syMwAJJ9AWsFXAjipKbHXT1l6iDf4+Sl7c5S/WVhg74O7/9SA4IUhd/T41
 ovDV+6F0Qm79Ma5/hzr955+jxhK3WQl06anNLdPOPGUpyJeh9i9J7zZoxrqK12q81a5K
 Hg4LvoeWafTetm8r9iazWsedWOhwaF3eG4FQnmGJ5H4iekVro3wvw9hHQgPPLBteVUQ/
 xY2PKhgPJlHuCEM4HIEqPE/+fBrTWxd7dwhG9GvnzcmrjZeEUiKxl0CATLEbHDpf9vqX
 1JpRyD0fu8Cu9ug0S6QvgevXbSeSLTrmy3lysiHWk6W1KaN4YiP37FDiDNHResu0Ur5g
 3V6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724424286; x=1725029086;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fDO1UunCpORbilzq8v5rXeDb+AES/vyYNU4mVBCcBgo=;
 b=BMTbV8xwslD7t9w62JZjEQ8g8Frv2zKwZ9qwmS04HQZGXnZeetUByWDQiZFQZUbj/Z
 +2MCsBKAgvcnP5A2/Y/jIW5nSxPziRZQ4Q9ErTk/jMLb7dklvblZM1sgbTSSb2q10BRA
 88SjPK1g0sqQGTJNZSMsZCGoSSNyZIIdLuzWAU8EObknftbmw+3TuSYHKOerBdDKMQhx
 5EChdTeIPJSSyg48ZFcxJxI47vA9iH3svF2zZat5YtrznijnNP+1o6pieF5W/hOXOKz2
 tJChR2f2y5+782cwepk4bo0Oj0nvMbmR/NYpcweUEoTC9X0mVj3FXjvLSKG5R48/zV4C
 CiVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrku+U7OwmVS3csNyk0wVDATRuwqnfFfMO6zcQhsH/eOoM4zkLYBPJvXNO9NfXse5NSnAgIdxtZfig@nongnu.org
X-Gm-Message-State: AOJu0YxMFJtX4hmRhIq07+IrWUQzoGyauHIi9l9NscCXDxiKoszTT056
 tJvt3RSAnbpjr/dOLYqFFviDtyx0sCV1yR7WP7a6KywHUXZlCBxrCVOL2gc3FhA=
X-Google-Smtp-Source: AGHT+IF9Lu3zwX8svjX2N7WuAplgiPtkyVzLLAKLRC4pEioaWHYHpD+wKCqWVJpSMbloxP2vKr0AYQ==
X-Received: by 2002:a17:906:6a1e:b0:a73:9037:fdf5 with SMTP id
 a640c23a62f3a-a86a2f1f72emr288622866b.6.1724424285862; 
 Fri, 23 Aug 2024 07:44:45 -0700 (PDT)
Received: from [192.168.200.25] (83.25.211.12.ipv4.supernova.orange.pl.
 [83.25.211.12]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a868f2adc55sm265928266b.71.2024.08.23.07.44.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Aug 2024 07:44:45 -0700 (PDT)
Message-ID: <857d39f8-c45c-489a-875e-7e1a4358aaf9@linaro.org>
Date: Fri, 23 Aug 2024 16:44:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tests/functional: Convert Aarch64 SBSA-Ref avocado
 tests
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Leif Lindholm <quic_llindhol@quicinc.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Thomas Huth <thuth@redhat.com>
References: <20240823131614.10269-1-philmd@linaro.org>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Language: pl-PL, en-GB
Organization: Linaro
In-Reply-To: <20240823131614.10269-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 23.08.2024 15:16, Philippe Mathieu-Daudé wrote:
> Straight forward conversion. Since SBSA_FLASH files are not
> tarballs, use lzma_uncompress() method.
> 
> Avocado used to set a timeout of 11 tests * 180s = 1980s.
> Hopefully 600s should be sufficient.
> 
> Running on macOS Sonoma / Apple silicon M1:
> 
>    $ QEMU_TEST_TIMEOUT_EXPECTED=1 make check-functional-aarch64 V=1
>    ▶ 1/5 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_alpine_linux_max              OK
>    ▶ 1/5 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_alpine_linux_max_pauth_impdef OK
>    ▶ 1/5 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_alpine_linux_max_pauth_off    OK
>    ▶ 1/5 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_alpine_linux_neoverse_n1      OK
>    ▶ 1/5 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_edk2_firmware                 OK
>    ▶ 1/5 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_openbsd73_cortex_a57          OK
>    ▶ 1/5 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_openbsd73_max                 OK
>    ▶ 1/5 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_openbsd73_max_pauth_impdef    OK
>    ▶ 1/5 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_openbsd73_max_pauth_off       OK
>    ▶ 1/5 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_openbsd73_neoverse_n1         OK
>    1/5 qemu:func-thorough+func-aarch64-thorough+thorough / func-aarch64-aarch64_sbsaref        OK   241.79s  11 subtests passed

354.35s   11 subtests passed

M1 Pro, Fedora Linux. 600s feels fine.

>    ...
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
> Based-on:<20240821082748.65853-1-thuth@redhat.com>

Reviewed-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

