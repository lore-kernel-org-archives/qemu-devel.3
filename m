Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D3C2CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 21:32:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6yFA-0001tZ-2n; Thu, 09 Oct 2025 17:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6yF7-0001me-V4
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 17:32:09 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6yF5-0006o4-Kk
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 17:32:09 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-27d4d6b7ab5so20211915ad.2
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 14:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760045526; x=1760650326; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t5tKo/Dsk14JEK2hhV5l+0cg5j/4kE/MML+YeC0roVs=;
 b=uFZdo39ytsh75o3MT+vb0CBuz0h+Z5vWBHqiSrTAsdGvITQZTbtwSuQL2wyxurftsI
 9eo+MAvme99kyJO8VAfdD3eiacGljvDVyf0cRSKZpqlRtIia5s09KkMjnSfFOnFz8NFS
 z9Qmp4iQanTYkcaAH2dgocEjgmyTcXZsA0LDXsjILCW9kx5d4Cb+rwv7CJeuBYMWYZZ5
 OW/psXLkN9vJ3Nz3VztbAw251wgX+9Ab5CR32KPZ3sRwD9figSjo6EdUIn9LmSBaYxf9
 kiTeDZLUKJJQHmLwnKgcX7leEUkTj0goA/PTH7o0nJxBHV/zwwpGX37fe3eMDt0N99J2
 094g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760045526; x=1760650326;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t5tKo/Dsk14JEK2hhV5l+0cg5j/4kE/MML+YeC0roVs=;
 b=KmHKv+s6PqaI071XXP21EnJklv9b24yNGjAVq2ljyRXGannJmLDxN2YZQVrXbRz81S
 a4D9inswk74WGpZKrFNGGx9AGWJe1/NDJ2xl7e7X0Hwo6Pb93V2xNCUCa3XkSZWxt7hw
 or5sZ7xVE/gmtux4LYKMVxCyyBcJimPBWd5ErSXDDaGA/8i+3jBfuEYlTiPBrAq4mzOu
 H5VOcOMee0llw9pPLj+veRbPk0F2Ek1vCVZerFrOCVDym/YMpK7ZdyE8ZpZq+6oB+kai
 vUfzkVxQaQhW4RPVnkxELHz7sFgV136SEl7DXrN8DSqH5ufti6E8dxO4wPaoIztQ/DuW
 uS7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsTBhKHS+yfrhJ1uviolZPiQxv03fbeSHpUBf5Ftw54QsVeGmWmml+hbdMQlpwvC72HKWK0rWbeRc1@nongnu.org
X-Gm-Message-State: AOJu0YxtpjfRQaOsTZF9rq0mDoRrYuz3IC4YDh6pt3HWXJsn3fyBFF47
 OHEr/JJl/EepHvNIJV6ZqUck9a6UhYSUeya03aNtljPwGT45dAGKek379ND83whrfII=
X-Gm-Gg: ASbGnctLLdjXOH0sUDbMw6rQlj23FH2Phpke3Oyrz68b+SJoOADDlAR2LQuhsjB9BUh
 A9w8L0i+YPXAb/f3wqXJgVPD7N8OQ0cYEQpx8Kx0q9qMmZgnJsRp+kon6Lbk0paRSBO3Mmy2z6R
 dxNEjPaUw3x1DeFjC6GjISrZOcPYae8f4XtAb+EP25AsoeckXF1Hekz8goA9Ftugw3iZ/9fgi4b
 6ehWvbdIMMA5XB1/edt0Sw0ty2N3VYkYyKIALZZ1FuSzwhT1i0MqUob0a2g2qN2tJKNmRezGHim
 n8HGIRB/aVam6WHxdRosUZ3FjufvblWJzratKJjoKuJSVt+OsMrvc8y5rC3ciiLqeZOGkRNcOEV
 qW9Hq8qxCZWuRK5L+GyPNc7wpEriRvm32nlc+z5w8Eb2UMT9ARmzcchjn/qnRPIgf
X-Google-Smtp-Source: AGHT+IGsQTyrQsRuVB+8vbVnMzMDMvzZSnbpMO15c41n7RF497la4vXS9uHbjZmGdEXlrQYZEZVivA==
X-Received: by 2002:a17:903:1b4b:b0:269:b6c8:4a4b with SMTP id
 d9443c01a7336-29027214ee7mr119914485ad.6.1760045525407; 
 Thu, 09 Oct 2025 14:32:05 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f36116sm38032545ad.93.2025.10.09.14.32.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 14:32:04 -0700 (PDT)
Message-ID: <f75c7149-bfef-4b7e-bbb9-548b2ff5d34c@linaro.org>
Date: Thu, 9 Oct 2025 14:32:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: [PATCH] target/hppa: correct size bit parity for fmpyadd
To: "Andreas K. Huettel" <dilfridge@gentoo.org>,
 Gabriel Brookman <brookmangabriel@gmail.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>
References: <20251009-hppa-correct-fmpyadd-size-bit-decoding-v1-1-f63bb6c3290c@gmail.com>
 <b5e928a2-f4ae-4b24-a2c0-2f67442dff2e@linaro.org>
 <10069660.lOV4Wx5bFT@pinacolada>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <10069660.lOV4Wx5bFT@pinacolada>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 10/9/25 14:30, Andreas K. Huettel wrote:
> 2) The doc is probably page 6-18 (fig. 6-8) and 6-19 (table 6-16), where the
> f field for FMPYADD and FMPYSUB is documented.

Yep, that's it.


r~

