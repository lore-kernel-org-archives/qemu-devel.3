Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 671DFCCF9F8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Nov 2025 11:12:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vF9WK-0007r1-1r; Sat, 01 Nov 2025 07:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vF9WI-0007qq-3G
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 07:11:42 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vF9WE-0005Rk-Hi
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 07:11:40 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b6d4e44c54aso433195966b.2
 for <qemu-devel@nongnu.org>; Sat, 01 Nov 2025 04:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761995494; x=1762600294; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Pdwipp/3K+YdD9HsqURHTU+MjvwtnqGdJCpue83rf04=;
 b=J2Mqb459JKtwRI5rQPv7aYD6CdcVrL4mV5LneR8LkYZTo9YDqavkFqA3fPj4x9JqFk
 /f/5Zi+c0qa8bS/YNRCBVDKS4+dbw/94HoTlml9LXAZg7tnE5QpBDGda/Jc4UorlJOlf
 daxzq+3MyNK5GbJT8/nE38F4VFAa7+vgr2e8qvJs37nZbWUJqKsdN9S3/xd6lUc2Rl2T
 RwrnUyRtnGDotyKyq0R8qifm8bfJzJ/c769ODXD7uM5XA9RrAy4Owe3veLVJSEEkPC4r
 hLhc6xTRepD2J8HA7VilOSy6mCbKzfp88FYAwnDyRuAoa2xmYwYpChJ49lbD1gUdCYuv
 KxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761995494; x=1762600294;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Pdwipp/3K+YdD9HsqURHTU+MjvwtnqGdJCpue83rf04=;
 b=mFNDTaA7+RZveae+5IbzdUTCDdYAIkzC5hBPPOeiM7W3X+Q9YZKR8PF9h73Wv40OHN
 rqTvOYx7ibKB3mUhhPV0Xm0hEFkSaP7s6UD8S8TW6l7QEsR2l/1smZ0SCthCn8o5tFBt
 xuSjl8DaD8ZoQjkfl80Kha1oEu1IYsuulMteK6dhiJ5Bbh+fJO0He/x5dHxiZpeY8asu
 dZw37KJ3F2YXNDRyeqFOb54OJpXnLuRGD/BTAaH/cJzMNFJ8TrToHUq72Q4kCwefuySd
 3fVDn8L6VuRvcbtI283EVSPRskXjHA8olbSxe/9jsVsOvZo/zCWtznRG3FLCzTk8yKN1
 qeXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWi9FMZUJmmxPNUAlcy5q45e4PqeToAB+jdM1HTQ3VPRAERlJu4KEYb50G7HW5aIfdVHKto3ikrvK26@nongnu.org
X-Gm-Message-State: AOJu0YwJ8OEwvwFnEtPilamn3RrMmRN2MsRrFHqWcWLp+GGaTplqLH+Q
 c6cHpQwJQnB14JD8DB1uv/Tg8k6VvIrvF5SRF7l0I9Svnbs5RUuHDy3rzeDHD3ZGag4=
X-Gm-Gg: ASbGnctfutCA3MqgaubXr+hieJWgHrnb+ezgxXzgDjUZhE1K50kp7zeEJrEdIK3rdIX
 rRZVBmHI51EYXXHy91EdnJXJThHyUL89j5WnlyqyApt0Dkla1AhvnhxYw1UE8+P26K6MExKrkla
 TQnonFP+77DGhMXhM+MQDnI+Xc79bEdJNylb7nmpUtiaN0TAHO6SPEMiFvDMj/13pd2z9VCDLYE
 HIV0peqCzmVqJec8lekeCqF6d0wKIpic4Gn39ugznoc3j1nh4MJFvFWmXKYYV03B0N3cz9nLpaF
 wRNB8OEWoaEhNukBFvBS9i6bDZNcxUbfY/82ZcSY03e+9PYLHx1HX9TvNCobXneH9uN3uMJ2yDW
 QtuYGNZHCy6XpLg+b9wvcVWPtRv83/IrItwrrq/oo9tPnk9b2H3ZXb6B76pcSEB6xS/h8jhpJR/
 Kf6DZh95ManUT4b0E9vXz7q6URDDCqgSIFv1F3q/zsZ637n8jD73A=
X-Google-Smtp-Source: AGHT+IE+FPL6hBdzhet2kMS8K9q0wREBCq1YvxBy3HZDEsn021PaoaEaCjk4Sk2hLduEUEMx/mGrrA==
X-Received: by 2002:a17:907:3d8e:b0:b3d:30d8:b897 with SMTP id
 a640c23a62f3a-b707013e542mr641978266b.14.1761995494621; 
 Sat, 01 Nov 2025 04:11:34 -0700 (PDT)
Received: from [10.240.88.227] (C3239BBB.static.ziggozakelijk.nl.
 [195.35.155.187]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7077c809dasm422929166b.50.2025.11.01.04.11.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Nov 2025 04:11:34 -0700 (PDT)
Message-ID: <1054844f-cfc4-4d7b-8753-082d7736839e@linaro.org>
Date: Sat, 1 Nov 2025 12:11:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/36] Audio test patches
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
References: <20251031064631.134651-1-marcandre.lureau@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251031064631.134651-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62f.google.com
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

On 10/31/25 07:45, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau<marcandre.lureau@redhat.com>
> 
> The following changes since commit e090e0312dc9030d94e38e3d98a88718d3561e4e:
> 
>    Merge tag 'pull-trivial-patches' ofhttps://gitlab.com/mjt0k/qemu into staging (2025-10-29 10:44:15 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/marcandre.lureau/qemu.git tags/audio-test-pull-request
> 
> for you to fetch changes up to 05404916bf89867e613da271ebff1a556c206965:
> 
>    audio: deprecate HMP audio commands (2025-10-30 22:59:30 +0400)
> 
> ----------------------------------------------------------------
> Audio clean-ups


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

