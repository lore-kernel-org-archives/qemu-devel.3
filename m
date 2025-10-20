Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A44F7CCD1A2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 23:04:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAyvO-0006em-4M; Mon, 20 Oct 2025 19:04:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vAyvL-0006eU-UE
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:04:20 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vAyvJ-00060C-42
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:04:19 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7841da939deso4573195b3a.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 16:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761001455; x=1761606255; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jTec9NXjNPhqfb2H8I8J4o5vO26CAcSZgQI4J6ugA/Y=;
 b=iDibgYvqr2KFbfxqyXOSGmfpqy3ZBeuAKnkkZHAEW72q3mdmVly/eQuNDLMsUCkV8z
 9AlaRdlHAkgWmhI89Wg//dvM+gM16lJxfRUZ7wsl7H5SQ7Lf2QIEeJiMjFTd3TCA3dvT
 oGdLFKGKOaGruSURuFFsnN/mIL+OVGvVWkVXDt/TaOsiMpbco1zVRBdhzJXh1MBbLYTO
 odj1MpumDHm0tDZJ1OU8xDlHwIkHazmtaWX6X0BN1tL6Kl/DkIDZh5AevV6yCRTRDj7i
 SPloXApj+3AP7g839+24ia39RpaJ6+y3fEWz+Rj8lvUr7XvsYhNymSPGh2plNoT2WaR1
 /1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761001455; x=1761606255;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jTec9NXjNPhqfb2H8I8J4o5vO26CAcSZgQI4J6ugA/Y=;
 b=Z3KorfAxsXjqmetjkkZ59WATlYIDIcEOXVtN4CGTHjSPO8TW54HjXEn2hMPV1PynPL
 BZOSQbvOhN4J6kRjFhPHtqXthsLFPauxbcxtBXeg04hINlVx+/CmVP1usRugdmcVhqRb
 PsYH1MvSal6VRKxxkSnzYc7frx1fbbljAgSRAqeOYc5o36EG3VjaiOuxT8YGTRs2T+W6
 h0wfT6JUKtLhJtZgemQTtXCyxrvEwXVyOSKB9+TZhWhS9V0ulvLtK/NAOysbqtsDWM9g
 OBxl5dU4SdztPUO6l1ZUT7JTd7D3fFmEHw3DRC9H5QH+D+JuPkSfHT+H+SVc3rdJapxy
 8ysQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTBNcC2VU1Q4tQEefjE0SWqDVHGOM3L1VBGsGqqaRZ96l5Bkk+puEMg1dCVe/1VWUyuneCdkXIdjbq@nongnu.org
X-Gm-Message-State: AOJu0YxQc05ox0I6uFPVJqykj3hognaCeB4bEv1NF6URpC8q0EC+nDtW
 1tZvrLbQ5UI6JnGg0t9DhI0dhgbWYrkgUNvlwql01giClp0GXom0JLTJTOCvWz06pbo=
X-Gm-Gg: ASbGncvpC3eJLQr4lVuSWR8thGFVC6tKVhLOYwKRV6Anr5wi9Z7MAd5tJvn6Cdybqyc
 VpVeesBsx2yvSY7KhdRfADant8kjUn0jG6N9nu6AQIxMTERtsdOnpjaFzJRNYT5XA5xNXYcdjX8
 t+LLjrEDLnFzZ8Aa8R07HiQ7JSKa7I8hfAPG5Yc7wYrUjVTjNASLD+6A/b658aOeFg+G2oGFLpB
 Cjkz92HgWFcSg1Bv8buycdCv8nPrfv3f3QFBsUUEiUixKl7LW0v8zrzDf7vTwfyo7gbpH6mAXEV
 6HHiHCE8LJLtk4QewSaz3CxjWAAsVqIsDFBohf443O8KK0AAvkB7odhrd58txYvj30wSCDVt69W
 Po3k7mgxbo3tRsPWWa2Zmz5A25yic9qbfBn+RBJpcG83AFZMndLm5/4UVq4lpDGDw9aWY3CrKYk
 /2oJh/fsHNOQx+tA==
X-Google-Smtp-Source: AGHT+IFu2rj1j7aBVRNXkFisSLoQSMABgfY5OEFHNY4sjHRD79ZEcOEbzTZytRL2aujZAuhkt0uxbw==
X-Received: by 2002:a05:6a00:94c3:b0:792:2dd9:d8e9 with SMTP id
 d2e1a72fcca58-7a2208fe6camr19365627b3a.4.1761001455321; 
 Mon, 20 Oct 2025 16:04:15 -0700 (PDT)
Received: from [192.168.1.111] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a2300f252csm9328158b3a.38.2025.10.20.16.04.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 16:04:14 -0700 (PDT)
Message-ID: <d1779577-3198-4361-9301-3af46d8cf995@linaro.org>
Date: Mon, 20 Oct 2025 16:04:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/30] qemu/target-info: Include missing
 'qapi-types-common.h' header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20251020220941.65269-1-philmd@linaro.org>
 <20251020220941.65269-10-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251020220941.65269-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

On 2025-10-20 15:09, Philippe Mathieu-Daudé wrote:
> When adding the TargetInfo::@endianness field in commit a37aec2e7d8,
> we neglected to include the "qapi-types-common.h" header to get the
> EndianMode enum definition. Fix that.
> 
> Fixes: a37aec2e7d8 ("qemu/target-info: Add target_endian_mode()")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/qemu/target-info-impl.h | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


