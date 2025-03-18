Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36268C35FF3
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 22:26:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tufNL-0005pP-RS; Tue, 18 Mar 2025 18:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tufNJ-0005op-Dy
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 18:25:29 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tufNA-0005HZ-N0
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 18:25:29 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-301918a4e3bso4819450a91.3
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 15:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742336717; x=1742941517; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+OZcSxEjvy5barsrM9YzuoeAs1gtQHABtK6IPFv4fFE=;
 b=YzMXmJg15iyLLFwzppTJrU6VGDh8PQmAByJLg8ymFFofCFSFh2Np08FTQ3lVms+QoC
 SGZPjxkRbNUwFF9y7jrakQk6k5LX+Hf+zYBYzvFYKZLrmU23jhIbu4ghX/tt3vxwSP7k
 It2GG3dRRCf63OsGMEETH3ZyHUZtYWw41Ety4bdpPCLrtNHHdC6BrrBrkQ/GtsQa2tGO
 1yVOZ/I08ntyDXgYRaT1k8y3csh7juswAwBo0Y/UmPonZ9iFgLQ2yz4/bsbND5VdsSQP
 KVRyztqlyo8xqBphKsek73e7nJlZdTLhEpp9yCkY6LjKVihiBa8PUX7yrtPnqpNLKMOk
 hnbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742336717; x=1742941517;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+OZcSxEjvy5barsrM9YzuoeAs1gtQHABtK6IPFv4fFE=;
 b=Xhb2hZ1w67JyqOECFxqw44aKNeusvqyUoVf52iFyEI9Kk+5JbjQeW9xaVOhdEffjc1
 /fIZHo4Z+MuJAWRVirznjF5Fk8t5g2tiN0PAOjhIjN1VfiF3gRGLpa0zp++roRtwjUWk
 6gfhhTnmiEjFLGEDkvE8p9bRS5K0vddorD1S3FkJWpsmHbLv1TN9BpH3qSK912mTDkeG
 4JFm/9PoHTUFfC8FzntC+pj9olGldcBpHqoDTn50kfnId40xIZGYj2svNO/4GdTty6PE
 fdqKpZaAxaeN+FK175lGFzqq+jpq9lx77NOO6AwgJ9MYCthhxxf7UsBfuhIaNUc/iXdT
 OBag==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkQdnwTffNxRkmNYJdipU3uEzAEIjZjXoGywjuc5HIFGK/hSPbAllRT9tR8m6y6D78U/IYGIUBVKq7@nongnu.org
X-Gm-Message-State: AOJu0YyImt1cuW+kibivSnJaE3bNyX1lASLqclvHFuAaXlxJK0NgM7V/
 8RXjvtUymXwrL+dEpRcpCDcY8OCFTLklvRHOiwXIKLPuNDd7bDYHyIumv9We9IA=
X-Gm-Gg: ASbGncsMwrMI/nOl5AfKrKR2BoxYgMktnwdKjNQ7uY3f3M5ljJFsRfOu+i+Zo5mxDvD
 5XuuEKIXOJQvg7ojffnM/FBZSCWxPEQBcLGuRS9e/knY3PDFfGLeafEdGcUwyqv80ivwHhB+AZC
 +HiWAMxdOhG1ImmJfTaXXr8yHyK4ES1sRCw6HicA4WQCNCwkJb8VmgV8/phVsXn2Y4uSOLPthTR
 xmQ4El+Q1XePqEyqUv12defteuntGl1oDomShd5H03yDlCON5ZMGg+C0LXE6v51Z6AFXgpjpWBO
 LQJ0r6swNE2Li3qtvri7op2Edo72vteG4+lWFo/+GUWSHT39qA0PVpXlgg==
X-Google-Smtp-Source: AGHT+IGmH0IikLDiUP1B2sJeJzQbJRgDAITprzk8AgiG9cM4xJ5TN/4hReGgOfBC1vsSdDXqD1UKow==
X-Received: by 2002:a17:90b:3ccc:b0:2ee:edae:75e with SMTP id
 98e67ed59e1d1-301bde62101mr577697a91.13.1742336717408; 
 Tue, 18 Mar 2025 15:25:17 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf5cddd6sm21699a91.41.2025.03.18.15.25.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 15:25:17 -0700 (PDT)
Message-ID: <172a10d0-f479-4d6c-9555-a9060bdf744e@linaro.org>
Date: Tue, 18 Mar 2025 15:25:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] exec/cpu-all: allow to include specific cpu
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, alex.bennee@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
 <20250318045125.759259-5-pierrick.bouvier@linaro.org>
 <35c90e78-2c2c-4bbb-9996-4031c9eef08a@linaro.org>
 <7202c9e9-1002-4cdc-9ce4-64785aac5de4@linaro.org>
 <0c6f23d5-d220-4fa7-957e-8721f1aa732f@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <0c6f23d5-d220-4fa7-957e-8721f1aa732f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1033.google.com
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

T24gMy8xOC8yNSAxNToyMSwgUmljaGFyZCBIZW5kZXJzb24gd3JvdGU6DQo+IE9uIDMvMTgv
MjUgMTU6MTYsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+Pj4gVGhpcyBkb2Vzbid0IG1h
a2UgYW55IHNlbnNlIHRvIG1lLsKgIENQVV9JTkNMVURFIGlzIGRlZmluZWQgd2l0aGluIHRo
ZSB2ZXJ5IGZpbGUgdGhhdA0KPj4+IHlvdSdyZSB0cnlpbmcgdG8gaW5jbHVkZSBieSBhdm9p
ZGluZyAiY3B1LmgiLg0KPj4+DQo+Pg0KPj4gRXZlcnkgdGFyZ2V0L1gvY3B1LmggaW5jbHVk
ZXMgY3B1LWFsbC5oLCB3aGljaCBpbmNsdWRlcyAiY3B1LmgiIGl0c2VsZiwgcmVseWluZyBv
biBwZXINCj4+IHRhcmdldCBpbmNsdWRlIHBhdGggc2V0IGJ5IGJ1aWxkIHN5c3RlbS4NCj4g
DQo+IFNvLCBhbm90aGVyIHNvbHV0aW9uIHdvdWxkIGJlIHRvIGZpeCB0aGUgc2lsbHkgaW5j
bHVkZSBsb29wPw0KPg0KDQpJZiB5b3UncmUgb2sgd2l0aCBpdCwgSSdtIHdpbGxpbmcgdG8g
cmVtb3ZlIGNwdS1hbGwuaCBjb21wbGV0ZWx5IChtb3ZpbmcgDQp0bGIgZmxhZ3MgYml0cyBp
biBhIG5ldyBoZWFkZXIpLCBhbmQgZml4aW5nIG1pc3NpbmcgaW5jbHVkZXMgZXZlcnl3aGVy
ZS4NCg0KSSBqdXN0IHdhbnRlZCB0byBtYWtlIHN1cmUgaXQncyBhbiBhY2NlcHRhYmxlIHBh
dGggYmVmb3JlIHNwZW5kaW5nIHRvbyANCm11Y2ggdGltZSBvbiBpdC4NCg0KPiANCj4gcn4N
Cg0K

