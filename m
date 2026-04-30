Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A29FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 04:48:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIJJx-0003UD-NC; Thu, 30 Apr 2026 00:48:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIJJw-0003U5-Ly
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 00:48:16 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIJJu-0000U6-3u
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 00:48:15 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso15091685e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 21:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777524491; x=1778129291; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Wliuttsy+ISBztPp/LNbhhYhik4ECr3lyadJ7xW0++0=;
 b=sSVmX/6VkS9WI/RmWwkue2Gy0tgcYcBq+3V43LUftw1OCEEY0ub4Xs0JwpuimIw5Ew
 zrXKFZThXdljgmkBoNvCnWR/BFkO+pol0o5WsPnxwFNgbVw3t+z9N6FWTrO8VmCkh8Ys
 6VFnYCpLQKMJopuEVKQdmjq7I9/cEVozLr4t402Z+HKer6gzqu9pkz58CUElyDC4dMAO
 /8EqfmktHgo+1FZaffQuGacYPBG1uJjmJHzp6z5OI4kEpBRT+Ga/4+erMZ661eLSpjNd
 WUkrPXqij1nyTNq7tIusf+vvLEPrz2aouvBDJqsFIdMbHwKh1F9hWrosw1Px/gXZstl/
 jhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777524491; x=1778129291;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wliuttsy+ISBztPp/LNbhhYhik4ECr3lyadJ7xW0++0=;
 b=FODn6rginaOMiF37N3S27gvNSB7JiB8Gi+t93n47m0TheQlDdF1h3W2ckFOhRtet5y
 SOYXUBs2iAIWPzHQmJs0YKuGXgf75pyrlNHT2qzA3s8e1fV7iSSMOGykGmhbiSSPsrQx
 qwMUfsB6VfsiLMbVS4kIiJY/w8hzeOBUQu7VnRJVWB9Yl1t4cV/iGqGRwif3nHvzFBRm
 +u5gSB3qn9lG1bp3jpwl45z16eW0t6xP000u2p0qoxL9JtLWP9TrpKSpWODORZyz787q
 Y6X/+cy5PCsLeV0Y6awCK0yRu6BQYOjs8lhn/J4O89Pt4eMKuDFJk/Ap7MJxyV/SI6qg
 a0GA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Y7aDlR29tf2rdRP5EDWX8X5urv0zcR7Qe47MMBk8mNIeQu9DEDODfJru4NiCE9yOvN9/xPoirB9rD@nongnu.org
X-Gm-Message-State: AOJu0YzYhe8VS9O0KXBstgR+U08NrdH1mUlorOOaEAfrZxgdlIKUvgrl
 cOx+ljGxWipLwES93WhkP3CJI3XhxaEDYj5VghWYpVLzXbdypL9fmYOrN8WmEfabeuc=
X-Gm-Gg: AeBDietR3k4Q2RgoyLMt4RofSsDn09qaYBZ9HSk5oTZPcJE5M3iGo+9pNUt2igk/R3m
 gRvb3403OBmT0BBjeC9hZsoAofbf6xofJ/IQzwWplOxdWJ8/cuOtLtSlOF7Fff7qcYIl57+TdOz
 k50mFgOrJRoRqVDNdXfqfDeDbjrZbMfOS50hUHvW0z79s0ighvtEkzal6MQ/8AR83rGFpIp59Wp
 4Bzs6d4DTsXtCXZT259va9CS8sSP+NO4Ypv0Aw3Qy7U/jHhYT1lVZHMYZLjoCd8W6uZkxbJVogx
 BHar9roB/SCVCfRDvenrqX2UQ3UAemwjecDIwlT8YTJwV4zs7sVYHBpZciIcLTLa6REzsRADxPc
 9XqzktaZv07rcZ6Fs39//PxxXlvfIN1+E09pognLfgRGnMZY0RMJowfaW97wocYx4HBxPVmBGfV
 m87SX1eJ2UxrQ/262Y23lrUzte40J49EwkHywO+f4zq0OinNSFZC/4BNKk9iejycQS1BbYIB+wU
 PCO
X-Received: by 2002:a05:600c:548d:b0:48a:534a:eed8 with SMTP id
 5b1f17b1804b1-48a85e17294mr13443585e9.1.1777524491134; 
 Wed, 29 Apr 2026 21:48:11 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a822bf3ffsm43198305e9.7.2026.04.29.21.48.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 21:48:10 -0700 (PDT)
Message-ID: <86d448b2-6695-45f3-824a-9b70511711ed@linaro.org>
Date: Thu, 30 Apr 2026 06:48:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] target/xtensa/core: register types using type_init
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Anton Johansson <anjo@rev.ng>,
 marcandre.lureau@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20260430035626.3511676-1-pierrick.bouvier@oss.qualcomm.com>
 <20260430035626.3511676-5-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260430035626.3511676-5-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 30/4/26 05:56, Pierrick Bouvier wrote:
> Instead of using a static constructor, delay registering those types
> until we call module_init(MODULE_INIT_QOM).
> 
> This is not yet a problem, but since we will start initializing
> target-info types before any other, without this patch
> qemu-system-xtensa* fails with:
> Type 'dsp3400-xtensa-cpu' is missing its parent 'xtensa-cpu'
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   target/xtensa/overlay_tool.h | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

