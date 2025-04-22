Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B46FCC369D1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 20:43:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7KSN-0000qT-Mh; Tue, 22 Apr 2025 16:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7KSK-0000nH-Rx
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 16:43:01 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7KSJ-0005vW-1N
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 16:43:00 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-301302a328bso6096283a91.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 13:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745354577; x=1745959377; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aFpD35larhqUsDC02uRVxNg10zi0FEc+6AkNc3XTVA4=;
 b=Sjw35q1qPpcKrTtGDSSE6OfQUj5PpLFhBfGt41vVlTR9oTkbHPIbc66ZufhZVmpKMg
 hYiNvrqJzZTvKZ+eZ/KXGO1mqbR2JNJobJ70NbtTaZd7FdRD5yINiIHBaaKzF61ZLmRs
 GS47iP3nTCTlXPwF+czyA5/15FxRHf1uZYho6+JT5PaC4i79AYvDUdmRnWSeCb1X4NEM
 ee1anEvL4yVfmKVXdSCuPrx/9Zu5TAKjHY18F3/lYr+0/FljvWm3eO2VJXlxpV8Ihw6v
 yKiwMwS6HCJyQOqqZO2gJUTfW2f2HtRaNP1o2+AR/xVWVlbH6fx+4Vj4jMjG46uJ8A2Q
 4Euw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745354577; x=1745959377;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aFpD35larhqUsDC02uRVxNg10zi0FEc+6AkNc3XTVA4=;
 b=qYnWIeAN3p2Jvqae3Ny852lSAj4Gj5wuUQfHYsKsO3cXSTMGd88Knn3vsgxG0tp2uQ
 lzqXHcV6J7v9wc6cVcYncuRhy2Xq60iOoSUuOgYeICWjgbHjSdji0bv6sB2IHJbm0a/M
 81V00E3vCerRa7CKpMYmB+BXEfs34M8J5n/Jx7okoiHveEJafcIeGzFY51XledhEKcBf
 /j1uL5eB59k1wOHjCMw4FMu0YLbzjzHwR7AT7lVQSC1iwDGHjYfxrQ3zxSjxBPvrCSDa
 0GihJiFV2XoC/aid5SJalgHB9tQp8uNnlZjyihP25InOIfB9GWGTYxqGFehf9cQ/lBsN
 TcqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSAc6JudddA/Dbrj18oaiGmNtcW9SiHVcM/9YxsYTuLNijz/4baJhyrMrlyqRZj6tWZuAe4g7pnBPN@nongnu.org
X-Gm-Message-State: AOJu0YxGUTrEmFkriUmv6Y1C7g6nbZL4c/JLIvyr7VuWg0RueHFIW5Lv
 ap2FmL6pvup6dN+tsHQjV1NOaaBKggLRCsqCrNLaxQPPe8lMmg/Kkczt1pqTosQ=
X-Gm-Gg: ASbGncuQe8uaoPRMo9VZECYZVdnT7T+9UIZT3F+Gv11ofLS1O6RQI9yudk07aSCb8ch
 n/dkBIqcruhE05vbi5wHg92OwlQrtvzcVmFUaM9Q5dg0gDEqVy2cvSSLX96qmx4JF8EiUyg1C9i
 ocGfXMtFbdBBN6oojVRCTotFyR9XNncBYwgot08KhMM3G0t7+Cnc0/rvPL6zMj0tP+49Zd9shO1
 NXAe6SWPT9O8obNeX5RHXmeVrl0L2lBhPBK06zH7OpSOwUBsh2vIIg7XCgGDBFzoVfcP10sRpVt
 IbRSoDgA5AHCXUzTJDQn1y7bSDWrUzeckYzGdjpiZtBCeJq28ae8Nw==
X-Google-Smtp-Source: AGHT+IGYwxQzdRwga1TPMKvXnqv85vpPP7NNoH5qlcmyKrnmOn9lQteBS0enI4olO1obMTJkwd5Mww==
X-Received: by 2002:a17:90b:2dc5:b0:2ef:2f49:7d7f with SMTP id
 98e67ed59e1d1-3087bb69a99mr29907266a91.18.1745354577584; 
 Tue, 22 Apr 2025 13:42:57 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bdafffsm90140685ad.49.2025.04.22.13.42.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 13:42:57 -0700 (PDT)
Message-ID: <c791d271-c2ed-438b-aa9a-8d3fed088d37@linaro.org>
Date: Tue, 22 Apr 2025 13:42:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 047/147] semihosting: Assert is_user in user-only
 semihosting_enabled
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-48-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250422192819.302784-48-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102d.google.com
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

T24gNC8yMi8yNSAxMjoyNiwgUmljaGFyZCBIZW5kZXJzb24gd3JvdGU6DQo+IFN1Z2dlc3Rl
ZC1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiBT
aWduZWQtb2ZmLWJ5OiBSaWNoYXJkIEhlbmRlcnNvbiA8cmljaGFyZC5oZW5kZXJzb25AbGlu
YXJvLm9yZz4NCj4gLS0tDQo+ICAgc2VtaWhvc3RpbmcvdXNlci5jIHwgMSArDQo+ICAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ICAgDQoNClJldmlld2VkLWJ5OiBQaWVy
cmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQoNCg==

