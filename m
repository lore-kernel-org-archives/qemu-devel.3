Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5F4F8E499
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 03:33:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDZxI-0004IB-KX; Thu, 16 Apr 2026 23:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDZxD-00040X-Sk
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 23:33:18 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDZxC-0006ly-DE
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 23:33:15 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488b8efed61so2068155e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 20:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776396792; x=1777001592; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6/BIoEKQqC4C8cL5i4UmmAV2Ly7ftAnscMWMZVf9gbQ=;
 b=DKLgcIY2TXD43ytLbsM5ayhDvnO0pyqls+lo6gxDmYLFHRdjT2q98NTNjDruN6MtYe
 ESc7dsr9+UAtBCwcmaiXGWszlilb8XZxrFR/ewRYgSfe4HCDLqPNfRiv7OP24/G5JSc6
 Mhrf4U/0GjnuV3rTYBzv/R9tmiQN13EimW+zGq87kjOft6MPYyGDSlDeJzhmKSMcqo2C
 Rx9SKKEorXr2m1WgOd4o6P3sTUj+50usVTMfXjkWOEeQH0ezDc4AvGLCkc1ieRrLi4uM
 tdsq0eOpSwhpgP6z5va8OoU5U9VROCkobC7RD6bXuyT1Ic++MDFXGRb1irTHpXNilrhZ
 qAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776396792; x=1777001592;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6/BIoEKQqC4C8cL5i4UmmAV2Ly7ftAnscMWMZVf9gbQ=;
 b=CbCuqZEUMVEO5bpXYpQDhz6XtrJj/GV39a8vArMadYTID7zM4NsamMOVnjdoTeKX1T
 erUpifYzdOSj8q5Ts3+pm8hOuAmofQcyTW/CB2ASCrXoMuK1IZqd5vH6O5/YiLGpmqgE
 rPdCqDaNhNkwkrS5nANaXOK/qX/SgEWHD6yauPQOzXfjGVBuH4HvMK76KjdxPTR9Emiv
 jdAy1MTBpqZmwRrdGi/iMXtBGzOJ7gLUUzVUa+Np/u/1/8MVjN2QDHn9rdX+ICdcPiwR
 CXNw0Hk8XiC61VbHhejnvWiY2Z9eIs+k1dKQQw7w0RnxzsEnE3dxfWHfnqTwZsPA/UTW
 UDAA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8PRhcuHYOueVwT01x2JZWA2ReXDuo588mpmgDyRnqHYBqWhktciOESQODonxTpVYLjqLHHOP2NOUs1@nongnu.org
X-Gm-Message-State: AOJu0Ywjiyi0boBhuaovDbERL2L9FO1KtFRSriAYSTaT/7zPzba9zhBO
 w4kgNMkZtL2+jDFWJhHLq0Vu7YfCcQ4MfbcIneZpsM8wn4+X0kpf/qSt8NV/edcWfqg=
X-Gm-Gg: AeBDievFOYZnq0uStMNEL028IyADmChj9jJLBVPcw8KvDo4Nz/UCLgIiyRQPej32XsH
 ZGPiE0Jiit+agUvd1Qb4urFaD8A6Zd8hzEqDH1YHIG85jgZ8Z2ivWXl5StgHoFyGoz2VVevaX9b
 LMX6n8gJJtYNVOFFeM8VcmOxal6wtmf9TOFSBwmzOfWDgnznASqQpynQnGKi1MJNW6xJ+Ft6b8a
 1pFaEXzcBV/zBOQIt5ZYka6OZ8R/Aw6BDx7XeqdiSNRK67Tl6WcMhWM8HZitBBJ0EC+niElWP62
 R9+1zZvsNxunv3+ymkfUpPycXQpNUREctkSzV57eMGH0R+7awhmmr50APByp49wBFOqcF5JMcRy
 jlkmkMq2+3A+LHV/c90wGoYhXRmrpvMJa4hwFLGiEiCT3REWgNUFn/s0IBsLAQ9PzNSq+dCkMNk
 12Fo4OJbiayDfby1Tb2gDjxt0pg36cULXUQwm5YGamp6pZWnilBlh9uOTChnN0rm+HvKV8mEe2C
 Y5e
X-Received: by 2002:a05:600c:8b6b:b0:485:3c2e:60d5 with SMTP id
 5b1f17b1804b1-488fb8859ddmr10862245e9.2.1776396792381; 
 Thu, 16 Apr 2026 20:33:12 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc177dafsm12379035e9.4.2026.04.16.20.33.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 20:33:11 -0700 (PDT)
Message-ID: <1a5d5d6f-d425-4556-8e74-c22173f5aead@linaro.org>
Date: Fri, 17 Apr 2026 05:33:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] MAINTAINERS: add new reviewer for Hexagon target
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, manos.pitsidianakis@linaro.org,
 Mark Burton <mburton@qti.qualcomm.com>
References: <20260416231455.346504-1-pierrick.bouvier@oss.qualcomm.com>
 <20260416231455.346504-3-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260416231455.346504-3-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 17/4/26 01:14, Pierrick Bouvier wrote:
> Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

