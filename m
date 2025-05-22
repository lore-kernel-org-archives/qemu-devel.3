Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B217CC54756
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 05:39:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHyd2-0006q2-TA; Thu, 22 May 2025 01:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uHycv-0006mW-C8
 for qemu-devel@nongnu.org; Thu, 22 May 2025 01:37:58 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uHycq-0002sn-4A
 for qemu-devel@nongnu.org; Thu, 22 May 2025 01:37:57 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-742c035f2afso3216158b3a.2
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 22:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1747892270; x=1748497070;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D/WW7gFMS5n6X9DhlmFAqeQexSMZm71tGcMm/uNUx/E=;
 b=SpwJJuAQYS2cNQYfKWXLmYVEk+drEFHHNown14jCpNDXmc5zlyIS7+6qMXoVO+8CdF
 0hoWqBRbhTDDPvasJekd6g7y/UOTlmQG108r2IR4ooX3HTm5XUSx2T2Wh4lif+iLtkU7
 YhtfBazAQITAFrPiX5yidz6cxf1vS7hGV6tWsQnCcyBHTZZACfOSO60uHaxkEUN9YMNj
 IPuliWL9lSzZf8PnIIpdf+NjESLkbrRrYobLKMea0OoMfmfaIzF9bl3LsHV0hWSBv6jz
 ttA444uAG4Mmoti0vWslW49KzVGpxSgpau+NvQly9swofGklMzzzfftwz2oovfvLNswN
 X1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747892270; x=1748497070;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D/WW7gFMS5n6X9DhlmFAqeQexSMZm71tGcMm/uNUx/E=;
 b=Or8ozju3DfFadcMy95go/W/JB/AY3kt1qOVG8VYvCoO3ajz8iX1DyNBn846yHwSC1V
 k84BwEH1Lr1XZoc1CTLLHH73x1Y+ZT1lva8Uks0/5Oega9+47CUafLyZSQnZVEqzuqff
 OvcqivSUjX0drpCCAje0aFxD2iyGVXJKLm+FQplORwVUK0msvEnYsv6MmpfqBiwYsNnt
 vifQ3eI4RhNE24FBxIF5p6k9Jm7FSf0HgcUso4qYJD48Iz8nQctNMNEHO7Cx5U6tOXnq
 bRcDjhWlNqt+26E8d1tYONL3irQzSmc4KMIPGDFPDAWSRxR0ENWO/C+mdfx8Wzzh3MDA
 HIbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHERfpr1z5c2TxzWn8X+IW1LQD9ER9U93LtacXDAtdt20E9sjxROSD356r56cuy6ZTixyS0l50lF2C@nongnu.org
X-Gm-Message-State: AOJu0YyyRGeEAoe08QdBSR7LyClhXvFb9vDlqu9X6ybdMycHRWHHABbo
 8ZzprWrUyV2v3Iupw4+HWz35MuBdW4Bxr3tFcBNcgUlM7PxSzNYfyC+TnkCYDoiNhco=
X-Gm-Gg: ASbGncvkxPXyiY6G+JzvrATThnmm8xrjtA8JkmUkmz7gEZZrvIMnCSOeeBUj8vMRLVm
 j4WlhoDr/aNQ+nGQ4L7jxoXskKUZ5v12ndAsg/uEc5jpTIixbQDr7Q275P5bYDK2/V5kNAc6fOV
 pEfOVlxwHdVI66Jp0VyLJ/nL8m0PEkkfQlOGRgdhJhYsOf1JhxERe5GylRL8cRUbHznKh1kSkUE
 KDtFTBz7sC79TlYs8hQAkuH1sl/9/3IXuRi7MFrerRfj+TnKIBM09RV0h3PTTgMctgnth7+JaeD
 BPiB/Kv0nZwVbNmMxAxW1NIvF0PDGrEkh3tHWOeGiaoSis9VLrEW+f3MViMxWA==
X-Google-Smtp-Source: AGHT+IEOYM57uiObFmkje+0PJRJ03xAWB9mXFfxxWST0ML3udBCH2luGW74caFQtW0DbVY986bg0pA==
X-Received: by 2002:a05:6a00:3d4d:b0:742:3fb4:f992 with SMTP id
 d2e1a72fcca58-742a97c3f4dmr30575214b3a.10.1747892270067; 
 Wed, 21 May 2025 22:37:50 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a9876e62sm10779205b3a.147.2025.05.21.22.37.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 May 2025 22:37:49 -0700 (PDT)
Message-ID: <15677d5c-cd86-4d75-a21e-0c011800cd55@daynix.com>
Date: Thu, 22 May 2025 14:37:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/20] tests/Makefile: include test-plugins in per-arch
 build deps
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Markus Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20250521164250.135776-1-alex.bennee@linaro.org>
 <20250521164250.135776-6-alex.bennee@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250521164250.135776-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/05/22 1:42, Alex Bennée wrote:
> The user can run a subset of the tcg tests directly, e.g.:
> 
>    make run-tcg-tests-hexagon-linux-user
> 
> but in this case we fail if there has not been a full build to ensure
> all the test-plugins are there. Fix the dependency to ensure we always
> will build them before running tests.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/Makefile.include | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 23fb722d42..7f7f62cbf6 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -46,7 +46,7 @@ $(foreach TARGET,$(TCG_TESTS_TARGETS), \
>           $(eval $(BUILD_DIR)/tests/tcg/config-$(TARGET).mak: config-host.mak))
>   
>   .PHONY: $(TCG_TESTS_TARGETS:%=build-tcg-tests-%)
> -$(TCG_TESTS_TARGETS:%=build-tcg-tests-%): build-tcg-tests-%: $(BUILD_DIR)/tests/tcg/config-%.mak
> +$(TCG_TESTS_TARGETS:%=build-tcg-tests-%): build-tcg-tests-%: $(BUILD_DIR)/tests/tcg/config-%.mak test-plugins

I don't think this is going to work.

test-plugins will invoke run-ninja, which is defined as follows:

run-ninja: config-host.mak
ifneq ($(filter $(ninja-targets), $(ninja-cmd-goals)),)
	+$(if $(MAKE.nq),@:,$(quiet-@)$(NINJA) $(NINJAFLAGS) \
	   $(sort $(filter $(ninja-targets), $(ninja-cmd-goals))) | cat)

$(ninja-cmd-goals) should contain test-plugins, but it doesn't if I 
understand it correctly.

>   	$(call quiet-command, \
>               $(MAKE) -C tests/tcg/$* $(SUBDIR_MAKEFLAGS), \
>           "BUILD","$* guest-tests")


