Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84DCBD19512
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 02:15:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkYbx-0002tc-O1; Mon, 26 Jan 2026 21:15:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vkYbw-0002tN-AS
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 21:15:20 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vkYbu-0005bI-OK
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 21:15:20 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c47ee987401so2023032a12.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 18:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769480117; x=1770084917; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EldXCZjQ5uh6yhpCBwpCF7B++04C1iD/A9NUJJ6sJeI=;
 b=AuU0BJ9qDFHLdmAeUxsT7ABywaj2FJhDZod++dHqsmNOkQ15kXgC8nm24+VqADfsqH
 O0tIq+RFzs96yeD20t2yPYE/LciN56E4ipWYXMUGKH/v/krWwL/D8dKNCZd7h8ViQgYC
 H9mWPQZ3lpUb7Zxd/d2PDGQGWWqx6+vxAUQj1jEbdOzyUQn+a/AMQJRPmq0CZXd9R1GL
 O/DJBQIx/nhdz/ZL4J9yk7oObJc9WDDlOoCq/wyPx+Pckjqt+2+uEv9qicOxwhgEPd0V
 IVnuHIogS9vz8Jk+sGYRZs20wemVIo7uG+BLoozweRU+/vujEC43Do0XSvAJhzmI4xa7
 8TTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769480117; x=1770084917;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EldXCZjQ5uh6yhpCBwpCF7B++04C1iD/A9NUJJ6sJeI=;
 b=dvqoMTYq5TJO2NQugD/qJxvw/CFqivU4A9Aj5iUX6R4OQIu4cDbEG9lXXdlH4RHRjh
 kNLGhIHVgKyM95VeodoIQFJARM3lnZs2Ndf4rEv6r0PaXvHWJhHycPzGeYm6JqfaL6Vx
 7FwN1qNV4v+OeTXyY1sAxqXraeNSoNu26ukH/UnqDoXvIb3P4GpcIrLA0Vy2HYR5ousY
 qfju/LnE1Rwv0J9NSckXiq74yqVo9yichtsjZ1kSFS73bMHrgXLo7GvDqKca24lp168p
 eevncvPik83POT3gnw7+SA0bm4U/ySB+E1q8NnBufjWtJeTOdRY557rmPGa8XzXGyBX5
 iUyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXP9ZCjcdB0C3JQKhAnzMMn/sxkrYrAym96KjQIKGYmqMegqoRvFztoKaGWI4Nl8FNzmYtyg7HMaBrI@nongnu.org
X-Gm-Message-State: AOJu0YzXk/jpzJxjfKisV/Jvlml2xXcfbCb/LLIK2IFe9r45506T1X92
 JiId8ABFt3hNHdPlYINl1sVCfB8S9VQDgIRDVWV6MwBXFr0lZx+bTQXbmAZo4t6vRyU=
X-Gm-Gg: AZuq6aL+JiKEcjyvn3kH3QSFDxvFjKz81pSfx8M5r9pXixO99ooTxhFvqj8VaLT2goT
 rN+AszQHpcgHBhe3Un85VqEQX2KWWLO3Sxv58LiQtF6xaERkkKcqbyx86CfyprAS+N6VGeclVTU
 x19w8XeZaLEtMa9fo/ArlZSxuAt9Ra8RLKO4Nl511ncp+gCsRpn6xgbBSpmJnBzNxna18nTy37A
 4j+WVinnGMas5v0Cd9omkzpbgeg1/LtEya0aqXrB+6YnvG/TNtsgW9pwfQzofmMPOGcAiB7ZxFE
 u/8/bKv9bRfQUUSCOI75GjlGG4LZMKlMrqUvc+rWFM7m/sMz7/crdn85Pjd+8Ml+4VcCjuvduj3
 EWohVY1lbTH9hpRWO74h2tB7En98zN8F5PbF3NDIerLzf5XQmL6zAckO9bBTPptv8QrPo1OexKw
 WbIWVuKmGqGyshoXa7qM5K5rgHSPEvIg==
X-Received: by 2002:a17:90b:3f45:b0:32e:72bd:6d5a with SMTP id
 98e67ed59e1d1-353ffa2ed08mr99490a91.1.1769480116710; 
 Mon, 26 Jan 2026 18:15:16 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f616f897sm703894a91.17.2026.01.26.18.15.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jan 2026 18:15:16 -0800 (PST)
Message-ID: <19f0a47d-c560-4b52-a919-2c4e8b310cba@linaro.org>
Date: Tue, 27 Jan 2026 13:15:11 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: gitlab docker registries
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>
References: <da1443a0-5bf8-4ec0-9910-fd06beb42552@linaro.org>
 <CAJSP0QWQEr8+dEGD7jkUQ--Oq+D2PKv_ArRB_ApiZM++xN9TCQ@mail.gmail.com>
 <c12f3294-1ef1-41fe-a453-1422063b991d@linaro.org>
 <87jyx4c51o.fsf@draig.linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <87jyx4c51o.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

On 1/27/26 10:44, Alex Bennée wrote:
> it depends on:
> 
>      - wasm64-emsdk-cross-container
> 
> is that build failing?

https://gitlab.com/qemu-project/qemu/-/jobs/12870104569

Passes.

Is the container job pushing to the wrong tag perhaps?


r~

