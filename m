Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFEB3C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 18:12:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whAGo-0001sS-P7; Tue, 07 Jul 2026 14:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1whAGj-0001rm-3g
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:11:42 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1whAGh-0005ga-IK
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:11:40 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-381ed661712so4248720a91.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 11:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783447898; x=1784052698; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eVxVh55/ebGxswbTNhGbaenIkE/zm5TtXnz4O7QUAK0=;
 b=o6qvuCAYu9qSWnYOZkA8+kETJSDZCQ5W6SsMdzGWHR9vlYNs5yVbxFabVKv9Gngg2Q
 tNu++t+FxMCnssDlrqIOhqk24s3u3+EA+/XyEZ/MVC1wYMrO+R7/Mzr5xn/td8vOEQqA
 43Vhz2NUPl6hRZx4Ti6ORzTzvEO28PiSAXDTKEYnUApCU9N/VhATt9pkT92RGU1nNtbv
 d6TowiixN4omkNHyJQnZQu1R3K/M1xDQK/JSe81fMwTwcpvdURbdirqp9QoaLr0aFlvE
 zKkvCrNl6s2EE/tx4bPEjQCcQAgkHP6v09SbMxk7OWflEwmcsG99XfsJTgjzHuuRq07U
 zwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783447898; x=1784052698;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eVxVh55/ebGxswbTNhGbaenIkE/zm5TtXnz4O7QUAK0=;
 b=HsxcZcOdiXK3L+hVQ/BOrTRbTMe+lK/o46LPDUU0znlxN/sNsJ8eWfRF1cQ2TJDRzS
 K3GFP1NZfsmnI+zVQ+jBp8SNVgmYjydpjdq8qJ2/PIGjapIcMFTWOb+mP7mbDUcxfdqe
 7AB4B3c6wTuE7T4Lzl02Hce16UqcvCU/qtkmxAGBPBUFWf0U3SJ/ItYuUcFmczMY/Jw/
 uawUKTDSohC7ey1QrvMidDwpjJ7JvdV4pnUD88GDbroMO5/UkYf33Nm3Ehsc05Xxx2Fp
 /zeSqEp/Kxzjnp21FJqrDhox4FXG3xHFtcu9l5jRrtHi2cKIJc2PTmXfyNqUqxMcFeyN
 7jDg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrq2GT4Ixiith69HN52DMEtdekXUtRY1ycAN1Jql86lb7mKhon//sOhGNj1onGCj3hy/v2uB9/uoxA7@nongnu.org
X-Gm-Message-State: AOJu0Yw5yYPac41f6p4W78HY+CyqYVV9XPXe0VCnv1fYmkQa57DHM6xH
 LXXBrn4dVGORi+wpWq799fEsLCbQK4AaHtz0Dct9n4+P3CfP5eJ6w/vARnaiN+EdGxM=
X-Gm-Gg: AfdE7ck7TKRNqm/EAgo4riepgWOkdawk5jpS4E2CLqytw8/utm8Q4UfpyD4GU55S84S
 PdqKULx8RS9jYD5h9HT5bDtgNfx7G+DOqfrrPD8df5JYi1BDRGab1ofpOmWV/tDf/4H4nr3UT2j
 xl74FcqdKW7cJBqlOMu7Kesg9m/bXkaqDaoBpOGf1fiY3IOtw8gNDywWrPgvk/gTNvS18OWL6oS
 4F/izGzYPPOgokQkT3/g3/MT3fMlZvsnvwG8oJUH3Dhb5qmmZZ0GnairfM7VmVKrSLoukEcOLn9
 Zxut2N/xMmUcZPYPX3adbm8pLMKJNT5bZD5D+zu8Pbtx8j1Eecl5I9uIt8I3PJaqENg1FuNQYYE
 7lTE3YEgwp04caQqELVQt5A4lAotgIaqjbgjSDHTb8uvJbBMumlMU5aGnACkIGmLnDQC8anBRCO
 RwBxjX2diLz+3Pyl1J1DoEn6F2XahmUGM7suUxeEXzBg7LxvoSKhPAC2s=
X-Received: by 2002:a17:90a:d003:b0:37f:e326:6557 with SMTP id
 98e67ed59e1d1-387555738ccmr5989779a91.4.1783447897973; 
 Tue, 07 Jul 2026 11:11:37 -0700 (PDT)
Received: from [192.168.0.4] (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d3bc1fsm16113035ad.55.2026.07.07.11.11.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 11:11:37 -0700 (PDT)
Message-ID: <a475df94-a179-4181-8c0e-c722ea6b1b32@linaro.org>
Date: Tue, 7 Jul 2026 11:11:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/91] tests/tcg/meson.build: introduce exe_name
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
 <20260706223343.988769-6-pierrick.bouvier@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260706223343.988769-6-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

On 7/6/26 15:32, Pierrick Bouvier wrote:
> We add possibility to duplicate a test executable for a given source
> file. This is needed when different cflags need to be used (like
> vectorized vs non-vectorized for instance, like sve tests in aarch64).
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/tcg/meson.build | 17 +++++++++++++++--
>   1 file changed, 15 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

