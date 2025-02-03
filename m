Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E93BC02193
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 06:07:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tepbh-0008Jc-Vj; Mon, 03 Feb 2025 01:06:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tepba-0008F1-RI
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 01:06:50 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tepbY-00027u-8f
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 01:06:45 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2164b1f05caso63625045ad.3
 for <qemu-devel@nongnu.org>; Sun, 02 Feb 2025 22:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1738562803; x=1739167603;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=roBDBiMQYWmB2chio1q+U7Go06XhZmL+gvSo6+HYe/4=;
 b=tLXNOajZQ2wctF18V4OdKrysC97gGvsdsMTUL3hCv6y/75bACAZozBk2CMleKssO9O
 uY30dZUSeYSUGffHfW3oOIrLocnQppOsQvGq3XAaEpbYzZxGDBizuSWcz/l43ccCKE0p
 ul4tLJ60kWDkuKfWW2a5O5aen8fkttG4R8rHuU3wmXdqprCNhWvRatPujzwvnGNxHiAg
 wOzpjuo5ZiyaE+59ALxANeTQP37zkluVJgnkwFNn+5mYixsYzGvAtP7HlnMDSY/pbduv
 kvGX+ljXcDFwWNqwtwpMY0PXiPWbE3S6Q+hlP+L6ibXdwjjuK4TC7htumHCRCihVM3iA
 sWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738562803; x=1739167603;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=roBDBiMQYWmB2chio1q+U7Go06XhZmL+gvSo6+HYe/4=;
 b=oh3URBpPkYQD2cojhESS22rEx+BnORIhkotfPHUC8griYZ95zYbB5uy62kdWu6XRDB
 Bt0qawKv/Mxr9mPHyIi7fz2zu14AJxlJ7KRfJ2Muv2hsIzyZ9atBvV76xdGnkjHJd8lG
 9khidADJBuBZp/kn01IG12HUdjXSbgsjT1Ag0MlmqXUD4mK7PKhWY/k6Z7rPPEYfIW/l
 ETQmc8IPU0L3Gtd9N8zcXfM3RXshwErVct2N/VYetb4a+zJiWvflMwmi6054rzNkG3tt
 rYFiCMvg8MFvwv1IlP786pegJMRGIzQ3ZRcx3pSta/CpE5X1VASTliKmeg5SjacKuGDh
 T4JQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9HIl1ZtujDfa+mBk67yhs21wo3PeQLlB0h5OQh0xGbyl5BdeisY9Psw6SjBdJ0vKeZXgY0BRqPN0P@nongnu.org
X-Gm-Message-State: AOJu0Yyk8K9w3rr0cMknZ7pS7qfRG6jNVIznwLqe6iknb5XdIKAldkiM
 nSz2zPWwEXRnsbiH7JWxXD5KLhVUKBnKZ0qQ+3ZxgH7awHANZ+Wk/B2zpBcFXiA=
X-Gm-Gg: ASbGncu8QUC3O7n5ZltPNn956zc46W6e2QWwak46yhHa5LO+I0+ccE17AYEXbyEb/5A
 AwR2+4rVN8WFgYH5xEhz2wSb6/zAbPrKgkhgCqJxnsGj71AcyFjQINK4Cff/ka/+dVq0pvSkJ50
 FVPZqhp6x1Oo3iCQhU8jQ9DzSClQnhmUg79BxnfXr21r0qFQvg5W3ngR94OciC44Q83IUzm7+TO
 zNjUZ/mmpYco2Iu6+O8SQTLHg58A8c3hfblUwlGbboXLjugFjhwp9D5du/6bUN/07/xph/rnB3Z
 KbGj/4RKF/xhL3cZKTq/uYG63mfu
X-Google-Smtp-Source: AGHT+IFChQn0oasUsLTOSA0PR10D4jxXmn223c6yn+Sqfu20/hE1xQSCIeD+fEtH9eT5MB3ApSx6Zg==
X-Received: by 2002:a05:6a21:3399:b0:1e1:a094:f20e with SMTP id
 adf61e73a8af0-1ed7a5f06e6mr30487918637.17.1738562802842; 
 Sun, 02 Feb 2025 22:06:42 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72fe69ba380sm7459553b3a.118.2025.02.02.22.06.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Feb 2025 22:06:42 -0800 (PST)
Message-ID: <5bd0c71b-8bd8-4cef-b24b-5842476740a3@daynix.com>
Date: Mon, 3 Feb 2025 15:06:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/10] docs/system: virtio-gpu: Update Venus link
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, Sergio Lopez Pascual <slp@redhat.com>
References: <20250202232136.919342-1-dmitry.osipenko@collabora.com>
 <20250202232136.919342-10-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250202232136.919342-10-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/02/03 8:21, Dmitry Osipenko wrote:
> Change virtio-gpu Venus link, pointing it at the Mesa Venus
> documentation instead of the protocol. The Mesa doc provides more
> information and also has a link to the protocol.
> 
> Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

