Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4BB3D26D9B
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 20:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veJQE-0007Cd-8g; Fri, 09 Jan 2026 15:49:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veJQC-0007C4-Nu
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 15:49:24 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veJQB-00087H-56
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 15:49:24 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-34c1d84781bso2719339a91.2
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 12:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767991761; x=1768596561; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5zLBkdwX5NmtvgW7FWb6StxtrXev64CqXqSiJ5x04XY=;
 b=TCs2njUWChuNhHVyt0PUmaKyH5IJnq4obvf1V1hnrtCAd57eUHm92PV+YqsxJ4Dqke
 Ms9d4+FLlUYcFX+cZQBVZg37XBh6kdUTwz9fGSAzAuzEJA6YwImbpvZ7t/O2NMsoGmU+
 3etKHR6AXO7lfoqw1gM20fP4YpLlJtmIhLG8Q3nWHCMqPNKmzIV5mvfXbNqIALyVUyxu
 ay8X9clyWyhb9W24+dgVwE8I6rWveT6VytTw1Ge9dVu7rbi9sidGyeFaXN11JfmeSpOx
 Ne0Uak6eNkLhtqWOTIy6jCn2ODU63+VrWVLCQVxI4Ep+IWXC2/IKQe5izqkKthJlD6B+
 uNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767991761; x=1768596561;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5zLBkdwX5NmtvgW7FWb6StxtrXev64CqXqSiJ5x04XY=;
 b=oxpuh8Ikip5IwOiT1Sj25ayu7Ibb4lia0/ypeql7WE1nw3rFZCfAh9DbSGZplEkKm0
 JPObOV+Ne2OKXAF5vkJxW+z3zvqOe6MjS3YAwbYdtp8o+s/WF7wNHDnJCgvOJok6q/+u
 mqUV4nr0FA1JmdTxIoOq7lLR7fD6sX8H9fXP08u4ikEPlJ+rtQDeyEtzKqWzW0IjovDZ
 6jc20RM21QaMRO5wYJ+pTONp471HHSfIy2si92PZ+CeDEopETKCgwdSDYKQI271l5aPt
 aPQDFisIjzLWzKhWcSVKGuqhFQpFkrhP+hQDpXwAxkw5RbwAnYuB+qhwaEMyhiS8VVR7
 fMNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWN+dafvWitC/QKVtDufNSN7YpQswxLMQDVUmIVYNVPiXWJUhFRxSi1y7HX0IABE0VnaK2FgvX/f3IZ@nongnu.org
X-Gm-Message-State: AOJu0YxkXXL0ZqOm1J792mrMAiPV1iKiFtuCk+7cQ3pIt5PIAKLobm+z
 RPT2bpAhhHS/EX/EeJPUltEOdFymQRVklnc80tkBh8ziKB9oHd6mZ2VevNvxyRZZFm8=
X-Gm-Gg: AY/fxX76jvPUQHNNNNzG1ftwpGHcdGfjfyMMRSlwS/H0tvXp5nj5+pz/8qpfQU2d1MN
 u+638URYdRmLCdHmwdA1jB1YdsBK4n4KC3FlSgXd+7221BagGzvfTF0wYA1F49eqCrGYAPLypH+
 TxP5aq4LgUQkNY0T+1zpoDeAvldrETqilWY4F6zfdmV2y9oRZicaCJ6IhL8VIjOC4Rl4yDF1+8X
 JRq76ArQhjG8s16plvvTwRzdBHTU3/H2/8vwbFrqqPoOb5IwgBMG9ThNisEWzq59xaGB7n3KIW1
 UYl3dtlNNzUtX20PNz7aV89CDfWYSAvP61EaLPjdZkwDrKcPWw28ZFDxgeCJURJ8JUWx0Kzh783
 huklx8LLhWJFYBW7o+efjFwcYxmqXCjahzVDK42l+z7BBbI1iDLYh2K12D6M0gc7ybxnbRo4kD9
 PKAVWWjexrKarGxmGS0r5YTvvx5w==
X-Google-Smtp-Source: AGHT+IECV2Khhb/YZwKyKBCi98XAcg6RA7KWM/+X8KKugGMGzsQMGYDTuy9pqFLTyUGQYiwC9mTyhg==
X-Received: by 2002:a17:90b:5746:b0:349:8116:a2d8 with SMTP id
 98e67ed59e1d1-34f68c02457mr11047172a91.7.1767991760961; 
 Fri, 09 Jan 2026 12:49:20 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5fb74435sm11452787a91.14.2026.01.09.12.49.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 12:49:20 -0800 (PST)
Message-ID: <23d64b20-01ec-4237-8816-7adb1fa3141b@linaro.org>
Date: Sat, 10 Jan 2026 07:49:12 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] dockerfiles: Add support for wasm64 to the wasm
 Dockerfile
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <cover.1767886100.git.ktokunaga.mail@gmail.com>
 <bd5596d373b9b801c5ca838d316bea4c5aba4674.1767886100.git.ktokunaga.mail@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <bd5596d373b9b801c5ca838d316bea4c5aba4674.1767886100.git.ktokunaga.mail@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

On 1/9/26 04:11, Kohei Tokunaga wrote:
> @@ -46,6 +49,16 @@ pkgconfig = ['pkg-config', '--static']
>   EOT
>   EOF
>   
> +FROM build-base-common AS build-base-wasm32
> +
> +FROM build-base-common AS build-base-wasm64
> +ARG WASM64_MEMORY64
> +ENV CFLAGS="$CFLAGS -sMEMORY64=${WASM64_MEMORY64}"
> +ENV CXXFLAGS="$CXXFLAGS -sMEMORY64=${WASM64_MEMORY64}"
> +ENV LDFLAGS="$LDFLAGS -sMEMORY64=${WASM64_MEMORY64}"

You've added this control as a configure flag.
Why do you also need it as an environment variable?


r~

