Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8426BD3ABEF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 09:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSXPn-0004yP-5Y; Mon, 08 Dec 2025 04:20:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vSXPl-0004x5-1z
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 04:20:17 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vSXPj-0002N8-I4
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 04:20:16 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-42e2e445dbbso1945100f8f.2
 for <qemu-devel@nongnu.org>; Mon, 08 Dec 2025 01:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765185613; x=1765790413; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UTTQruUmtSBB1oMJgveq5Zof2loh3iqKqsuP1mnpAHg=;
 b=eWiyIbKNaYCPRY12RvrG3m9mEVKybPV52PEATtoSwlhCYNP35Qlwnfu0ZvnsfFHK4H
 wfUBqGcAUH7P/yIqONogpBdG1NJGIzLQK0WHT1Q5Rkr3/peyblO3k5kSGhcBCiEPcJSm
 Ydmv23ODVelFkir+0LUJo8JOJSj19K5RpKvjNiCyLffdBT+/uf64Zg2nEZ1GZCucuPEa
 GguXaNGUXZmVz8Ln2Tj/WsEGhhJTQgI4ogzL+9TYOSK5ylgp4Yk5i0bvmpkkQGdyEjgL
 tREWFDCpaBLDaW7vON9Z4mCd8YEHyAAJzmPdZ15gZs477Cdlk/RdUGCHwkB5nctV1Amd
 CHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765185613; x=1765790413;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UTTQruUmtSBB1oMJgveq5Zof2loh3iqKqsuP1mnpAHg=;
 b=VO2KSG1LPoxgVGOS6BWSxS3baDrGUaXhj8dlogqVRSG7EhxcQLE7vcXLx/9Nk5dn33
 k6UH1sYpWdV/dmCQ8qs2ZapbM3SYeS8KsyyR/tvgSr7kFEM+7m+2juSU+BoHuM5l1ZFI
 3Ku3EROV+wgHVoTorklLZqkw4BcIFhYQYyJQUFUb1UdiHZemtKKI+U2suS054ZOMD6x7
 iYLUl9gNgMD0qwBmFC4tJje1pDabBoVMz+yBZ1OnR+HvgbhgfpQZV583lWyd0rxIY7EG
 joXoID9yuS/c1fCuGYyQ3cETM2b23tiJypeijx2aBL1CQj8ML9+wBTzYFZzWD8+W8E1J
 ZPuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEtQ0NCLGhVPGwfIl6LJke0KqvI4lcM42C2F4bRMeP8kM+25AHyzuL1pfon24bSTF//U4jP9aklNmO@nongnu.org
X-Gm-Message-State: AOJu0YwFtORg21Qks5O8y97tExJRsy9Ib2glKmWJU0wIHpdT9NgWC/Zl
 c6ZCEO15ki+nYhYm9dIH/ABh3rOuqjdDFPVICNrzvk4rjlSpEzmFO8b4pWWbL7hc18Y=
X-Gm-Gg: ASbGncuKTnm8JRfmegsCdV0Hah2674Doz2IsQ7sYOLwQQ02VNFlotw8ALq+KuxPNqTG
 WpvjsRMYN4NJ3yy7iY4Q4V7xAKyJjNAweoFEAhHcc1VOkwgukX6xmWThBhYtNUKrIFknO91NenH
 T71WZ/ZbNGxybsCVjGnq4yu8s/uZAwMtFM9eDmYNNTy8xUb9fsy88I5MOF7t2WWl/6T8hTOdGVk
 VuSjfhcZgyy3Qz3T+N+pfzh5tzjRyM+L0smvO972PHS91sTYTVyc19WoDRcXTHLZX0YObn16GS5
 uDhGiu5S0uBIgBFudK7P5GDJtzIoZmqjBiwppBbmqH6ol2MDfJU1NwzjN2ZU3ilbbrex2GDNQ3q
 rv6eCAPfj0LZxeIXFVjR/orDs+z98SZ1i6xT1QHZCL6xCY6s+moaZ0I0ykVZE16xBrxoNnjJBBF
 Spe0WMpZDXMQfijd3Ye13JBupj4HCc716z7k2YCt7onYghrKe3PUd+kw==
X-Google-Smtp-Source: AGHT+IEyaI/YJjiDORwvZTTCXEoQFMozjMr/rXj/V3HNTQSkEhQrkabkslIZbOoPZrjHX944FxoM0w==
X-Received: by 2002:a05:6000:2910:b0:42b:394a:9de with SMTP id
 ffacd0b85a97d-42f89f6b24fmr7375063f8f.49.1765185612790; 
 Mon, 08 Dec 2025 01:20:12 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7ca4f219sm23220189f8f.0.2025.12.08.01.20.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Dec 2025 01:20:12 -0800 (PST)
Message-ID: <092bdaeb-e43f-42e7-a4b9-028a1f2b5e97@linaro.org>
Date: Mon, 8 Dec 2025 10:20:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/11] MAINTAINERS: update the custom runner entries
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>, Markus Armbruster
 <armbru@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20251204194902.1340008-1-alex.bennee@linaro.org>
 <20251204194902.1340008-11-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251204194902.1340008-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 4/12/25 20:49, Alex Bennée wrote:
> Fix a number of issues:
> 
>    - update the ubuntu references to 24.0
>    - add the s390x and ppc64le yml files
>    - replace Works on Arm with Linaro
>    - Also mention IBM (s390x) and OSUL (ppc64le) as HW hosts
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   MAINTAINERS | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


