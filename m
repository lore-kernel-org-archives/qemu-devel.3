Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864A0CF34C4
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 16:20:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sx7WJ-0004UT-8L; Sat, 05 Oct 2024 12:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sx7WH-0004U7-9L
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 12:20:37 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sx7WF-00051B-FO
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 12:20:36 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-71b0722f221so2465486b3a.3
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 09:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728145234; x=1728750034; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ef7U7TXb6l0QBk6ukfwhK7OalxCk4l87rfM/R5jTwv4=;
 b=sPzk24kyI9TCzay2KTru0aZv3VHFB5QFbKZ0Ixa1/eGpAXobEzUgMSevGjH/4F77fY
 QYBduWRDt1ry2tJexqW7iP3lnBzsIIVxsjkjaNZ7YQYEAxdBD8ZNl4hyVOwuddJ7dpFt
 aKwzkepgs/pHbCJOOqHIX72/PIibA4NpNetZ+3ocuKH12uNb8jT0bGJaSe0qc8lgGGs9
 JfeUXhqpgUv5W1zrmGXnprR+kT42KH5d8qhf25YHPxXkgpEtiY5Uouoxop7khvHqXLXH
 OxBKLUspfgwWTVb1tZCibyP384ATJuwADi+Jr9TaoxTdUifFEqLYyC1vbV8uVjHg4JRl
 GOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728145234; x=1728750034;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ef7U7TXb6l0QBk6ukfwhK7OalxCk4l87rfM/R5jTwv4=;
 b=tK8ZFzTQZ8KLCyyHL/zz7W+iojdMtqUN7lH5FRHQN2Mpza0u1CpxkY8+F6V/tuNMtM
 847zX6zR3ebAULVfbBJ+cK02OyIb2sfMnroPBwUhA6u7LiGke3RbbHvDNJSWw5x8kVbE
 esqVY07e+513xNYJ+3Eglce8qJfncNhKKyDhs76kUFZdq90TD/37TR7/BoluY+a8kAxK
 cAd3DDgYFKZ8sNXxFZbjDqCoV6Ut+LGW0IiXLZEO9mWd9IVVWc479uCfhNYDLoWYELwx
 xjRhguVwmgWX70TLVZQYNiHBlAFFqIYKkAucIoyGON6jfDJE+aHIi1JM6fTpwo9GxF36
 Ky5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1IKycvT40I/jkhcDE8EX4WTFT/QrVvjHFhshXX7/MCOJaPaHwZ6qM6hsHf0y6CU3XuEg1g0dh5fDC@nongnu.org
X-Gm-Message-State: AOJu0Yz1tqmBDxCpYHa+Pzozfgi5V4i8IpfeYcmk2aejAGZdDvDXdup6
 X123DibyALzJUQpscPeNt2cmGfZSUdfhjnHJXBOPojEcfM5Jf5GWCRLi4Mb5wOo=
X-Google-Smtp-Source: AGHT+IEAE44J1jy1nAQ6jzYHLHXBeQE/85wPhvqwojTrIKOM4dEbn3IuM0obRznD/siB1Y+pAl/tMw==
X-Received: by 2002:a05:6a00:2289:b0:705:c0a1:61c9 with SMTP id
 d2e1a72fcca58-71de23c4bfbmr9284659b3a.9.1728145233864; 
 Sat, 05 Oct 2024 09:20:33 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d4a2fcsm1641885b3a.125.2024.10.05.09.20.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Oct 2024 09:20:33 -0700 (PDT)
Message-ID: <1ede7823-8d4c-462a-8a80-c67c9dedd062@linaro.org>
Date: Sat, 5 Oct 2024 09:20:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: ensure we enable CMPXCHG128 on x86_64
To: Michael Tokarev <mjt@tls.msk.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20241004220123.978938-1-pierrick.bouvier@linaro.org>
 <5604626b-cba7-4d1c-8dfb-2c2e3b8495a5@tls.msk.ru>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <5604626b-cba7-4d1c-8dfb-2c2e3b8495a5@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 10/5/24 09:16, Michael Tokarev wrote:
> Besides, in the current situation where CONFIG_CMPXCHG128 is not defined
> due to this bug, the final link fails due to generated calls to -latomic, -
> which might mean we have something else wrong.

No, it doesn't fail to link.  That's why it took so long to notice.


r~

