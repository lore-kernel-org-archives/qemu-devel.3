Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D884CA0EEB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 14:58:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTCf-0006Ij-3b; Fri, 22 Aug 2025 10:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1upTCe-0006He-1r
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 10:57:16 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1upTCQ-0004Du-MC
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 10:57:15 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-45a286135c8so16414525e9.0
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 07:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755874618; x=1756479418; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ku92CtOseebH77hphJQa35GwQ6faiIuk5LMA9Mw1XbM=;
 b=CBQiKyo78MXE1ycui1qjM6u5ikMWcuQCX+/SzC/eW8pLZVzI53j4TSA4GdQbIBNKi9
 YWukVNv8lggOSOHoniIRLV8weCxv4tzAPA7R/c8NvvC5+HTnob5679+nbNhGn+tcy2Qr
 8IRgJKWXXgIGrWEd2j4mLGYUzA4KbNXGbLl9V+EDmo25K8FfnXy+yU97GN5eHWpmsg4s
 8MZUyIPxTyxHPmfhgtn19jIcNlkKLLkrArfP1utE1abNyssBU+xcyP/nlOsIx4hA/u0d
 PyKRNaYYGVAPsugW8qBKRt+bPBciFI6Dnj4ZTJKGqHvxYl3wvhXFCYyuo6GRyJLf7WrM
 8NBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755874618; x=1756479418;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ku92CtOseebH77hphJQa35GwQ6faiIuk5LMA9Mw1XbM=;
 b=hgCUuhvdjI7QKJMUS2iBHKqnNF2cjl9+a7q0tyu4eZoAFKya0ECBSSkC4ybyfrjk7L
 /x/S6uV+NhhZC6Mdmtd02S1/6tELqLAzGPeeOQwX30A9woGT90gPiIkVwiMEcMdqbUQa
 2U0brdTGg+aLwBffYtwxLeEYP9RhyuvwPLyL9XsByCGgxT9syVquvw3zZF/BdHMnfYPF
 GQglcVEu0X2FiaSBQ9Q2CCA9cljuxL+CvHtwbKjuvmcTeXT7xu1M35ldne6e8vhyDJ6s
 XYVLt8cif9teV3QZO6kVixI1q7xEYTY+piFnmlvg8opIkV7xQ3PLkGhQUDDTsuCA5Pfp
 p+6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUX240JmjGu37PEPBmA43oxzKxVsGubihcVMujPTmEMelbuRLWfGshiCLE9W0bKFjsGw2gblsV4ABf3@nongnu.org
X-Gm-Message-State: AOJu0YzRdMfRpQ5p+VpjSdnCHAmdlVnQ2CspM1wAnG4DjGW9LfynCeEH
 ijfwe2r18sJO3HN+oPhs1Cl92tTCJxL7EXRPMTPCnRJIidlT8SCCgCnsQo7J/TR7oX4=
X-Gm-Gg: ASbGncvaUi2b25iTvvZCXvMVJ2Wd1yLmuQOT1IJLE3hwB/wCzHxxLgcULlO6RrgR3nX
 Asn1zJ1mjt6K/kr/LAvUPRAIUYYQKeF9iQVzEQ+rV3TglAtSqs4pcuj6QGfNp5ttKoZAEFRmBkn
 jkp3KNZJlUHB2qQWx/kHZBl7g76jn3mKIN8d7RP/b1zRZhW5DX6l0DlmdEyrC3uNKX3BffacOVb
 2i/EDG32wgO5p0OgBD8/bU+VCDGthveXfOt8dpSJFhQjOzNHeyFqJOwtqMYTdhOzZhSQ19z0qFU
 szS0t+mnzpgKD8jjJNQ0zbkhssyTEUwm+L8Ya7SgGJC5YyR/cyAf0Ot9AV4hEiujuu5NinYUVv4
 lZaRkj+dl2jqufk6q28yEmj30ethTWChUJIqQUsUGnvM5gqPrMG00qqpY1ca7EUa3ueh1ldo=
X-Google-Smtp-Source: AGHT+IEQZYmVeFpdWaLicccAFbDCVenaoMQ0kGzOt3N9h0enWJCBolpc1rxrMeipOCc4wImutnkeuw==
X-Received: by 2002:a05:6000:4012:b0:3c6:bd96:214e with SMTP id
 ffacd0b85a97d-3c6bd962408mr784532f8f.3.1755874618499; 
 Fri, 22 Aug 2025 07:56:58 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b57487c55sm1921615e9.16.2025.08.22.07.56.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Aug 2025 07:56:58 -0700 (PDT)
Message-ID: <0aee80e7-d18e-483f-8621-12c51f350515@linaro.org>
Date: Fri, 22 Aug 2025 16:56:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] python: mkvenv: fix messages printed by mkvenv
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, John Snow <jsnow@redhat.com>
References: <20250822134652.1366100-1-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250822134652.1366100-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 22/8/25 15:46, Paolo Bonzini wrote:
> The new Matcher class does not have a __str__ implementation, and therefore
> it prints the debugging representation of the internal object:
> 
>    $ ../configure --enable-rust && make qemu-system-arm --enable-download
>    python determined to be '/usr/bin/python3'
>    python version: Python 3.13.6
>    mkvenv: Creating non-isolated virtual environment at 'pyvenv'
>    mkvenv: checking for LegacyMatcher('meson>=1.5.0')
>    mkvenv: checking for LegacyMatcher('pycotap>=1.1.0')
> 
> Add the method to print the nicer
> 
>    mkvenv: checking for meson>=1.5.0
>    mkvenv: checking for pycotap>=1.1.0
> 
> Cc: qemu-stable@nongnu.org
> Cc: John Snow <jsnow@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   python/scripts/mkvenv.py | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


