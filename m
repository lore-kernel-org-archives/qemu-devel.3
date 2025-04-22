Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C18C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 06:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u77Uf-0000J9-OE; Tue, 22 Apr 2025 02:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u77Ue-0000Hi-9S
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 02:52:32 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u77Ua-0000Tf-85
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 02:52:31 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso38144345e9.0
 for <qemu-devel@nongnu.org>; Mon, 21 Apr 2025 23:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745304745; x=1745909545; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SjiQWxPOlSNVbGc7W9J3JEzK5NR3eJEU8fykCh1e2f4=;
 b=Ew+luM4dohmyhqylk0S11UeD2PJSGPXLijcrzRF6LqXtuD2QcMfuv4vJPmb6kqlmpv
 XFbm/RsOZsuRthIXb42Tp9a11L3jr+KVPr1Q326Zhj24C9ZeR/WiQ5lgmngOIRbhNBhc
 VmsCZyhApW9K0RRvZqrksgiBsaE+UmWoF/05XJTH582RlGR3fQQSbARq1YnNQgmoVOxx
 beqtjxnw62o6BSLUNOdMvFOsl35VUiB4O7P8OurxyZvU53mXXyNP0gMDJgMvnwrzkKhk
 sWrQzJExFVrFwD5Vh3TlTIjY45BM7koi6PnTZvx3+1mw3M48SIeERxeGtJI48Xu9VEty
 eiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745304745; x=1745909545;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SjiQWxPOlSNVbGc7W9J3JEzK5NR3eJEU8fykCh1e2f4=;
 b=gEFZGTxhNkto02QMbCq+3Yq7pnZB81pP1SJOyOBh8JL0evpn7ooQ0oLWhAzXp4Atbs
 A283a5+mxlVGeR0GHQTufXhwsKh68pSuSqUy/3DCUfF9Ia38JBO/CiR8RRq+AqhF5OQk
 WCD7YlI/2WM9/p5+pvNQ82F705aONXpXDfBCwrhSjK2hUWKaBl9eEZGOX/g29LqJpUvn
 Ign3os8h4z4vljOzragHw7ytDUA8ncRB0C1YYenlKyp8gwmXUG7tndyqAtAI0CzvI/66
 XGGsGnuUgV4Zb5DecFXHlHSHqzj2hliD7PpnWJdxriUt6t8O5S8LdsxiUKQg5D0+k0Q/
 WaVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8hdJm1K9By1mZRSgNkxiSrxUCw54ATWxHGPrXmiDPKsHeSDx5UZRNSL7AaGQJPiT3TS3Sacun5Hwq@nongnu.org
X-Gm-Message-State: AOJu0YwydykzVQg3ybA3iVtkD+bYGgSPuWuT3FMDa9NRc2VcFF+6IWi0
 jonUzBx3ttU/R7fveobgdm/WDeya3OPEQbjcrOUlPKAhAS4TMd8GElnD+lRKjRg=
X-Gm-Gg: ASbGncuTjcvKrM81heqpp/Fw2k3PmTu+mGjGsK2IppRbk44BQm0v2mSBubn4IcJNj0P
 6gcjMcxLicvGaCYMjPpp5DuB4nBwDQiw+Fa8mJWbijKbebppnZd+topNMRbNSl4Co6iELIIMe8Z
 GvJZ0D+9lSe5IDrXyT7r67hafV9yiG10yii1K5bUc0HYFCfB78WdN9ty2DkF3xIyS1qyUgQhTk/
 muYSj/phjkf25fpietrV80rxKah722CH/vkeATUkeeJIfiiAm1hiALVOdaTEC4qK0XbDim8giqk
 QxHZ/P1INSrwfqzF8JqTC3DPdYO3+wBsiiWE+fzyR1cW6UjLEeHkPVC+uCJfVwSZ3E9SnrmPUsv
 YSihWDvK5
X-Google-Smtp-Source: AGHT+IHt3h54M4vtwl7DRF5h65UdgoH4/u8sgi1vZYRuQtRMbNcoheUDjjhNNRdhtzIUU+XdW7CFxA==
X-Received: by 2002:a05:600c:1d95:b0:43d:b3:fb1 with SMTP id
 5b1f17b1804b1-4406ac270f7mr123517835e9.27.1745304745084; 
 Mon, 21 Apr 2025 23:52:25 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4408c8b0ea0sm5702765e9.2.2025.04.21.23.52.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Apr 2025 23:52:24 -0700 (PDT)
Message-ID: <47fd711e-7d73-45e8-9956-e0f91d513f0a@linaro.org>
Date: Tue, 22 Apr 2025 08:52:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/20] block: Add including of ioctl header for
 Emscripten build
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org
References: <cover.1745295397.git.ktokunaga.mail@gmail.com>
 <1821e79d3977c3645aa79128b823748aa9a63800.1745295397.git.ktokunaga.mail@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1821e79d3977c3645aa79128b823748aa9a63800.1745295397.git.ktokunaga.mail@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 22/4/25 07:27, Kohei Tokunaga wrote:
> Including <sys/ioctl.h> is still required on Emscripten, just like on other
> platforms, to make the ioctl function available.
> 
> Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> ---
>   block/file-posix.c | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


