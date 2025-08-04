Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 221CDC87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 18:12:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uizfF-00044g-18; Mon, 04 Aug 2025 14:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uiyCD-0003ua-13
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 12:37:57 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uiyCB-0004rQ-Bm
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 12:37:56 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-76bee58e01cso2538861b3a.1
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 09:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754325474; x=1754930274; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1LRIwU0zuIGz2jPSjqk6kCv/4B6fpYfJRU2mEevscuc=;
 b=nvd+qmeK0T14b9bSPzh4IHDLsxGo9WUwD/+52uhzrEY5k0WnUmzfh2Sz9Zxb7C6kJW
 ZbBOibjxi/pLEcfkGWEQumMQTyfH45BPz8xFkHT8E6Et3gPhuA3M0j57Ks/MrItRR+4O
 TltaN3mk29g2ro3XhTpQslmuiOOJQYmt3vb8k70CfjAAJNtPce7Y8GlVkkLrCwNlcAys
 a7essPmCEY9YN63lwGB8FpwJ5NxCagSsoSBGH4OFuxaknU7CjTXYfySuSZjZii2/7Cxy
 rW6FRlwFf4DjW/+6gSqQv9JUMdxXu4bcqnhFfuqm8DYPxexg3CAHScb53RgC74+qrBHI
 o++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754325474; x=1754930274;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1LRIwU0zuIGz2jPSjqk6kCv/4B6fpYfJRU2mEevscuc=;
 b=IvR112qEhbTJG5UB25oWe5XWzMBNorPxwnSTEy4nDebK4QxaQMKWg4hu/DLwuQ1uso
 vpiO3m7X2KaNWGxZAMZCvmTObNUNSZiQ4+5MdT9Vc4ZD6ryf7BGiQtlhJM1PiXhp8jqL
 Ycviine0NRoSybuA5O6kwJ+f9MqLFDOvX2td/7ZoZoiUgTmbk0PQdryRGxA3CfvSZxYW
 QewgNKBRkx4SEfQvpQYm+Gjh2Rqrg4pCJfoAVlgijesWkKt79VWKQZY9Muia07EBuzPH
 Z/jumzi30aMR14ZxUozOurD5G2SBXB8Fq+f2CMrPRCou3EWSA84NpoJENq6B+av78+Bn
 KeDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLS/f5z6d0S7/3xuv3E9D1YYhfsSupN5lBKcWdlmfS0aCNIM8wKTMAcCZBabsGgd73YASUVjS8zU9y@nongnu.org
X-Gm-Message-State: AOJu0YzNsyUF4iad2i0Iq8ib0GJzEddsWP701LgooUUf9cmYXQc/PiDe
 rw6d97ImmB36jBSAigjXEJghUpSpS420nwrSrbRLVasuf8fa1KObQ/8kFE9y4tWVEKM=
X-Gm-Gg: ASbGncv/XM166SeOnJjOePJAYAQJx+fqaLen+c9nLBK6AuAc2qxn5D+tl4495kTnc+7
 Ca7uiRZYzvySFNaSTDevl4KShqCiTQX3Wcd6GqTwfe4wca4F38lxtSk1q16Og4CuD4+dkirC6X/
 VTrqWKO3QbLud9Tnp371T1Objg14sMUs7tjhw0oetAUXC5r3+wYXrzoYZ7+xb9cWxsMuAL1U7sk
 3cyhn/F2wzScEEwHEPYl4tDjvzqC77q22Bta0Pb5G08FNiZ2XPNOT7NhZkG9F6jzpVWLlhii95J
 dkZHlI+RU4s7GxjZTNsVPN3YfF1H5E73VOViOa+/zL29ZmdsUy3qRXvsKCOJwprEJj70i5lRO2n
 mO+PpCFDwlEOrbIZqV1dvhen6pjN1Y+0rrHc=
X-Google-Smtp-Source: AGHT+IG8GipCVsciwNw5yPB3I8+K5Lb/BthiJugoNo1n9C5jOl2nBYbrOicHv2bmxV7xhgNklo7Tog==
X-Received: by 2002:a05:6a00:23d5:b0:730:95a6:3761 with SMTP id
 d2e1a72fcca58-76bec2f2eafmr13511637b3a.3.1754325473874; 
 Mon, 04 Aug 2025 09:37:53 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bccfbd05dsm10776492b3a.81.2025.08.04.09.37.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 09:37:53 -0700 (PDT)
Message-ID: <46dde0ad-3116-4145-bdd3-e68506f44bb1@linaro.org>
Date: Mon, 4 Aug 2025 09:37:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] .gitlab-ci.d: Add build tests for wasm64
Content-Language: en-US
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <cover.1754310749.git.ktokunaga.mail@gmail.com>
 <d3a7e2c7d5d8e5257cd7be7da79d135c43cbbc55.1754310749.git.ktokunaga.mail@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <d3a7e2c7d5d8e5257cd7be7da79d135c43cbbc55.1754310749.git.ktokunaga.mail@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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

On 8/4/25 5:57 AM, Kohei Tokunaga wrote:
> The wasm builds are tested for 3 targets: wasm32, wasm64(-sMEMORY64=1) and
> wasm64(-sMEMORY64=2). The CI builds the containers using the same Dockerfile
> (emsdk-wasm-cross.docker) with different build args.
> 
> Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> ---
>   .gitlab-ci.d/buildtest.yml          | 24 +++++++++++++++++++++---
>   .gitlab-ci.d/container-cross.yml    | 18 +++++++++++++++++-
>   .gitlab-ci.d/container-template.yml |  4 +++-
>   3 files changed, 41 insertions(+), 5 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


