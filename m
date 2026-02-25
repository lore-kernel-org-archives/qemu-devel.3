Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DDFAFD45F7
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 21:40:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvMcG-0002hF-6h; Wed, 25 Feb 2026 16:40:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvMcD-0002gZ-U2
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 16:40:17 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvMcC-0004OW-Ae
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 16:40:17 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-826c49b7628so117921b3a.0
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 13:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772055614; x=1772660414; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JC3GKdsB/67HjMM0x+xM5DPdiXVg4HvrguWrnUX/u2M=;
 b=Kmy14jtPyywq6dwChmiwPD74tkSPZbvTk703DYEggRrbJ+0bFv4EhSqbZ3i9uIzuOD
 jGpgQZhEU2rzeserNPA178I6bKqfoE0Jym3N3cRxYH3rr1qpOf5LjSu8DCQ1FwIuqjy6
 3VFmkzKXj24KJjlqx9B4Da4k/QYH2ukOoZNChfCyGyiqWuuJzJlMkNb1sDUDAf6at4cC
 FduMF6vUQRBnDWdZugNsSecxb0+wGlVHslNr+9qynABZ6a2A2c1p/s+I2YtKCqr+AUvr
 xJbbRP5gohTxNg1iObx5/0ampVTq1MwYJYM4vtFbt2Z2IE5fDrNtSc1gu3o+FVj64k63
 wiGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772055614; x=1772660414;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JC3GKdsB/67HjMM0x+xM5DPdiXVg4HvrguWrnUX/u2M=;
 b=wk2ZE7JNk5o693PvGEPwyv82mIpECb5A2GvW1JJU10IHXDCsOoGv6V0ehjp9CV7B0J
 MuNq4HXxrmGMa7f2D/O5GQmxJTF8Orf9ntvdy4ilv/rNsx3LvXZDHKIO5ScLPDrmjAum
 z/zzYpxsd8lTaHPYAfa/IWqjXKt47EH3hvmK0BcQ0WL8Pvaxzp83/RuBEIlTOy67eMzj
 HbB1Km/l7+Svz0hlCLUyWBqP4xZu+fCUaxHGqz2P5jDYP0zsu90nz5VocuKluP3xXB3E
 DQoTE90GW2HwaVOPxzLPz9aq8jB8ZBK2kekdAuxFmLhK5q5WSlYHwhnWEeX7AFjEZB8Q
 xI4A==
X-Gm-Message-State: AOJu0YzuYSqZ0Ea38bSWYO2r2zBXBJzaffkOXbe91i5Sg1QjQsKSCt6v
 ypBaA6J8SarDOc2WARxREg488rzNG59Qbe1WiWyWYT8cpcysACqA3/BKfc6oufND7IE=
X-Gm-Gg: ATEYQzwQVF2tBPd88iF1kkrAMMmawHxrJMTw+KnARU60OBSQPLLOQSklBQnJsrkzr81
 a8YFpOY+cTp/hXmTpjBcj1RS4wCjhgSWjBeYA1wEWIGB3diMZw9NMDeTYom9o8oOjGCnuIF/j3a
 Tm64DIgSu8Iwsv58sqCm9n1nUuxtkQQFJMltND37fqwYGTaG4YZ3+6ujG6YjFG4HK+hwJQ3GGwQ
 TQZsWWmw4R1xH3XO/h8Sc0x8Pq0nF2g28YlcTCGZQUFy5PpPoZTBqETKaTOt9jfI4CxCs+zq986
 rjRkbwzTjsU2vpGke5hqkYnkAYT+hSqt1YVOcDaU9DkhWW3J6xFzFWCGwUyYPuDsRDiP4UZhYXp
 WPdv41AdpITRZkGfMItzzdRjFbLA4jgl1JVmgdOY2BfErBBkzdaYh4bWIX+hQo4kI+WX4RAPk2o
 8OT9j2neB0FLNrH2939DG0YBY6kvFLcV9s5wLT0IpNCIfxq2HG+Svss6yARrmxjAnOmMlxOQbgJ
 78J7+Q=
X-Received: by 2002:a17:902:eccd:b0:2a9:5c0b:e5e9 with SMTP id
 d9443c01a7336-2ade9a60f18mr14010365ad.35.1772055614468; 
 Wed, 25 Feb 2026 13:40:14 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2adfb5b22e7sm1921625ad.3.2026.02.25.13.40.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Feb 2026 13:40:13 -0800 (PST)
Message-ID: <d09ecbc1-3ded-4e75-9488-617dab41e69b@linaro.org>
Date: Wed, 25 Feb 2026 13:40:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 18/31] hw/arm/smmuv3: Make evtq producer use SEC_SID
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>, Eric Auger
 <eric.auger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221101723.2994751-1-tangtao1634@phytium.com.cn>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260221101723.2994751-1-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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

On 2/21/26 2:17 AM, Tao Tang wrote:
> The event queue producer path wrote entries through address_space_memory
> with MEMTXATTRS_UNSPECIFIED, so produced entries did not use the
> sec_sid-selected DMA context.
> 
> Pass AddressSpace and MemTxAttrs to queue_write() from sec_sid, and
> assert that the selected AddressSpace exists before producing entries.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>   hw/arm/smmuv3.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

