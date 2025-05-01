Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17DBAC369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 16:25:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAWj0-0000as-CR; Thu, 01 May 2025 12:25:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAWiY-0008OJ-Nj
 for qemu-devel@nongnu.org; Thu, 01 May 2025 12:24:59 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAWiW-0002Lz-Mv
 for qemu-devel@nongnu.org; Thu, 01 May 2025 12:24:58 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-227d6b530d8so12795215ad.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 09:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746116695; x=1746721495; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cIv3SYpt0KGIULJLpRzPxVIXo1I4QvmLyk6TDaXK/TU=;
 b=NNnIA/d2tC7jHBkjXjogav7Jfnp5vYHoEFGoiQxgNi510BNDMzVZ0qzCVNqBjUMnzf
 VYgGFrjT3TqgcUQlcMFv36qfqpgLSWOpH3oaKiJUsmeBcfRT9i5nfDDD5qfVuIkuqcnu
 TivW4ys8TJNq5RNObWnbYUSlbMkYyFtdvXRk6FKg4wyy2tmmrY+svpRvzayQ3QU8r7v9
 WL4NL3BveJTaW4PaG3crNT4r1TptB/jn4m+FKqV4U6Ce8IqZsx7aXaa/4E0SPc0vm1Xw
 cC60mV5Tny5sRVQwPJPhMJoHRVnBbqofPqmIe1KDf90yFlvMVDguYs948DIVPd/FMXGi
 fB3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746116695; x=1746721495;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cIv3SYpt0KGIULJLpRzPxVIXo1I4QvmLyk6TDaXK/TU=;
 b=U7JiIuI1iXy27e0dKOTMXo1iQCVXj625BIC91S7TIP2nGm/pH0O/pd7NcPZJ1CB7y8
 FTlcDdfRACK1h9w338ukCUxcxM0v1+hLHkOMkAvBKb6syGMDZ0zcEM8YhVEAUGRb/6XY
 7wDsOnNCNn4E/W8Ki0fNmOSbWEGpRkVgeSuCE0nYr3v7EaXGi6QCRtU2HJEMTjvtAv27
 nFfDD4QfZRsbwq1IPEoQvCKnDuoGyr8pojfdbWyIVVy6xyw1M5qwlliCZRYJu+IBcy/r
 75Hmc9VHkr0n0M5R1SGr6B5Hd/kB9LaqSWrqJEmdjsivz7EN7pKtUP2UcSgBGqswiQX3
 oGeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXBHl31L64OAEX4g4Uzg59IWQDBCccip3DIIDHfFiOcTqPRV1u03puxdVtlSDX0PC5Zl5sa8EV1fBR@nongnu.org
X-Gm-Message-State: AOJu0Ywx1gOwo1x611B4BeqGmP2vEi1SK08ih9uqFm3UzZxHxhL+ri/+
 Pq7SDOIdoLuzXRsKUAm9A9kj7wj27vF8aRtCIMKYBNHkAbGer6a8oBFOs5bjpE/IGZF1YIYy3EO
 c
X-Gm-Gg: ASbGncs5OqmYkoVYpKICgOlDA2pCcqITurdXPDDYexNuj/RYFBIOVr9jaqHJbRz/bEH
 9iU+zxWrnZIPmSFhviDifJdXwzHYZ2jeYmPBP8wZ2JjlDh1YCSXw/KSVi65Za4AU3/gZUsad2C2
 mVFVqFjfSh2ba6DpQHGxA9W5ojbhdEdfepGFl7dEjYIwrrziaB/37rqMq3Pp7kpX9DMFiRqe5Bg
 EKgFrhI5Tsbdnt794fMc3HK10ajcbFV89tlVwS1AJi0f8Afh/QcplVDG459QZPoMePr3dKjaBAS
 a3VJFwf9GO/N7gSqvIBxPyf67b1Qj0bywTzIV4WvHQ0PRWO3SxY3wZFZ6ncJxjbMSHx48um0jk9
 C7hJLdac=
X-Google-Smtp-Source: AGHT+IGAKwM6RcxOtOkzEFIhOkFLa/b5bn90FuBPHURkl0wMDnKUkk3rI7DC/t+lusoNb8z3Bd9w2w==
X-Received: by 2002:a17:902:ccc1:b0:224:1c41:a4cd with SMTP id
 d9443c01a7336-22e0832d6f8mr50408735ad.3.1746116694875; 
 Thu, 01 May 2025 09:24:54 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e0bc6dab4sm8608535ad.141.2025.05.01.09.24.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 09:24:54 -0700 (PDT)
Message-ID: <59d1bbbe-7f39-4022-80a6-945484508ce1@linaro.org>
Date: Thu, 1 May 2025 09:24:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 32/33] target/arm/meson: accelerator files are not
 needed in user mode
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
 <20250501062344.2526061-33-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250501062344.2526061-33-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 4/30/25 23:23, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   target/arm/meson.build | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

