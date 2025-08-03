Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 370B6C87FD3
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 00:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiMVb-0008N0-9I; Sat, 02 Aug 2025 20:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiMNx-0000PD-1Y
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 20:15:38 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiMNv-0002Yy-E4
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 20:15:32 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-71b52d6d1e3so32806917b3.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 17:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754180130; x=1754784930; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K6G0yfZ7cwusYhUxEyAMaH/g1gtW4S4AqP9ZuaPJyUY=;
 b=iG5nMTSYBm3QESuiA763yoTnHjrafNUrLSfVo+oi/okFAs63GpQNToE2LqmIikhEfd
 hyyyCUzOl+1+ErcjWEfpH13hucls3SU+vLYtF6zrHgPbV9y0EtaEjUusXFhTlAtwGPKz
 w/kSlgZZhMyiPAaMzvmCddGm1okdGsXRQPcAcyAgP02T3HZaGk4Gr5IyF5vK5Fzx5uZX
 7JEqbva78u+gQSGNXGs2YuUe7AfpYuuvpS7KpD/4uKbGCIqvhoIeRS0mGYnOfn1yBl+U
 g0DjobFn0AHuoBEwjtNu6v00NxFtn8qXzox+zQ/qIN4eHfoAIB+pUbHhQ6RPg3jOnIla
 g3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754180130; x=1754784930;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K6G0yfZ7cwusYhUxEyAMaH/g1gtW4S4AqP9ZuaPJyUY=;
 b=fN1RUW5EdMfCnib6K9nW7bc7t4fNQwnV3YDGccRuES6Safm0QHLgi0BMbc9BCHw2Fj
 FsUj1WGuyPb2mlieOKJcd2dCUYaUg0+R9I3YX1j99Uuk0yisnXvjzmJV4lJdUcQbbK1O
 JCyjj1EzlTgRFAeFvFfW0YE7roKgS6R1a7/jQN7rWCkc2BFiGqPnVE3xAtZcyJ3RmhYb
 l1W1jrXa/pKMT/uwFObPGYGEmlkrE7Boop8SCzcyzcTNgVt0SObuSp9LRie4l92Risd/
 Fy4DzfN9yWh8jSsHAoZG/wuHnJhX0GPx5BYJJcal4BOA11YymXPcnTrb2ByFd4sEmnDw
 qk7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+oFMfYa63nQj8zWhdYTvOfmp7byBKmETX7iIj1AW8jqYQbU84gA4DL2hn6St2ZDLOsPB94EcaXSo+@nongnu.org
X-Gm-Message-State: AOJu0Yy+XCaxNCAec7IvKYiQehuJA/lRDisxLjkFgX1V4fjGZLEPl+mO
 sV9lB11t2RrPaJx63e08IwP85ohRFxKgHW4Z6vHHJOTnIkSLLAUUZiVncNwvhW+m6do=
X-Gm-Gg: ASbGncvpNmB8A+a8BF12Eln4Yo+l9yzI+/rr+jAKCF3htmbmiuqG4z2k4vDE3e7KFVV
 ZMpFTBFNv3tCKMgBR/1J+jExfNNDM30p/7D3/tLdKFdiATUzJfPyg4nqZQEBw9n2cBYUWuv8AZs
 eHVcuMxJ0VmlP1byEyElfVpuV0QWqL4G02QQhTw8aOQOTE787rF6pL1j9b8QCSco1Urpp+KBcgi
 S6ecOaqZHp81FBnLvmKQ7C6s9WoptbedxlU+7EWoU1kTeIKwjA1fQiJtFk7kSsfti2r1cQ6n2/Y
 Sqy0WjY0cdhKdeQiKq93XtiVBmVeTv8OQ5Abkqa3ef8dTs+hBVqA2ne7FpZhWmpfOq/b9ahuXbF
 hx9u48CzGE4QD+NI9UKsAjdMIeSSijXzpeQuk8L9TX2Lvt5kiV83iz+qGnnzhGOcH
X-Google-Smtp-Source: AGHT+IGm7zXWi07JT4ckFbImxhgmEHT9vHPCpbb3kRdHOBiIavDREDaRocBy+V/nVXWkCbYVde0Ajw==
X-Received: by 2002:a05:690c:f8d:b0:71b:7043:21af with SMTP id
 00721157ae682-71b7f5fca26mr56910797b3.42.1754180129577; 
 Sat, 02 Aug 2025 17:15:29 -0700 (PDT)
Received: from [10.153.194.227] ([172.58.111.133])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-71b5a59e9d9sm18499957b3.56.2025.08.02.17.15.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Aug 2025 17:15:29 -0700 (PDT)
Message-ID: <9ba2ecdc-d415-4c9e-8bb8-df841abf9712@linaro.org>
Date: Sun, 3 Aug 2025 10:15:21 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/14] whpx: reshuffle common code
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
References: <20250802081800.76030-1-mohamed@unpredictable.fr>
 <20250802081800.76030-4-mohamed@unpredictable.fr>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250802081800.76030-4-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1129.google.com
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

On 8/2/25 18:17, Mohamed Mediouni wrote:
> --- /dev/null
> +++ b/accel/whpx/whpx-common.c
...
> +bool whpx_allowed;
> +static bool whp_dispatch_initialized;
> +static HMODULE hWinHvPlatform;
> +static HMODULE hWinHvEmulation;
> +
> +struct whpx_state whpx_global;
> +struct WHPDispatch whp_dispatch;

You failed to remove these from target/i386/whpx/whpx-all.c.

I'm surprised you didn't receive a link error for at least whpx_allowed. I guess the 
windows compiler doesn't support -fno-common?  Or a compile-time error for the unused 
static variables?

You need to make sure x86 still builds at every step.


r~

