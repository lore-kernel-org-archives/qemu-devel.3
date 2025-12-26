Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A7AE8FDA7
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 11:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZ62l-0004Nx-2r; Fri, 26 Dec 2025 06:31:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZ62g-0004Ng-B4
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 06:31:37 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZ62L-0001yD-OC
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 06:31:16 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-477b5e0323bso40303245e9.0
 for <qemu-devel@nongnu.org>; Fri, 26 Dec 2025 03:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766748671; x=1767353471; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zaC8E/02I4AMJN2PwnFJsoa19sLuEKguCJQvCsJwGD0=;
 b=Ra8wy92vajTCn8NwTv55A29XaidQS9Eo8L8xwKT7+8R2AVY6L2jGRXEMY61Jp+86kk
 BM2Nik4Oyx6Lp9Pl7TW/Mk2TVL/SFDhgGtwaNCgiyJM0wKslfzLci6wBBNV7ZROTgV2f
 AJv3zc0imCaqnFhY6RA5yFg/NGSTgee5lJ8HbEHERcM2333KhA4NIPpJDTAK97+6TJph
 tlLTgDjTVZCkUKmKGjNEkGVVsxStT2mTouOTOGBtjfIBZYdMLQqJl3h1hG30Nkp4x69v
 Pu/hA9Ce4hb9LfEhqQ4tC/OV4iyVqsX10mrNiWC9xEPYWG/nNdYDUsQK6iSV11A7d8rQ
 O0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766748671; x=1767353471;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zaC8E/02I4AMJN2PwnFJsoa19sLuEKguCJQvCsJwGD0=;
 b=eeOFqUp5wGLpj/cLolpa6N2MYOTvCdZjWMFCLxWgxm5TMlvwiH7no2MRqRQvAR+2Yy
 v19h82hMluGO80lIEOnKXmP9CK/iYkYaXysLvgyDIuSfn0h+xiB8RLkoRFX4KqpQffOU
 v6EHaiKRhk2dGr4mlIiC15einhdXIIanBOGg13FCipy8IbvNr4PvV0gEuZkIPMO/xPlN
 +dCydr8qHK2pyLhdum5vsvkzCqkszzUg4Gjmq0mtf7LkyYxBvGykSRRlT9yEZpvIPpua
 tVbQ+SQXS0cHqgDwimLWkDAnQsXWYhy5EfX+G7G974gLyKcVxdAEaM6umHgdFVT4wdaC
 g/qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpPcJnaNa+ZWSziFX+tz1X+a8aKLmyHqmEtyA8a6wivRYe/dqQSpDfM5K+Pv5ssMpUgX9CkTriD+p6@nongnu.org
X-Gm-Message-State: AOJu0YyKjWrfzOKvGJkfsYlyGZDFRDHaJ/mJgYJ0tiC8P/wNlDaqz0L1
 3V8350R5LFoyFTbYX2n6JrJNuJF3F96/Fc5LC+cFDZ9/gJ/NO8+U8Qghz1Sv0Uu/Kxo=
X-Gm-Gg: AY/fxX7PbwS0x1G98iUS+NWWsGJyX0Zk4aGkrGMqXzhW0j/d7/1QYAX8t1Cpo57slQC
 OOiNnGBsZcaChFY2Jh/JC0HCuKVKu8oRTUe39qa4ngJfcnq7GRJtgWbmIbCV9bFP7lQg3DmUr4p
 x7fU/PYe1NxBZYqPEGaZN+27xmyDPf+p6NMZtkx9hriLYR7wbU+YM7DbakMiECIMip2wWOWTrSY
 gzXIw6fJR7A7rthuulSmqpJI8KqK1jLTCPiHIKuLLGoP6e/wccjGQe+/OYfhmJI6aavs+SwTI8x
 mEpd+UAU/NKlplnGpJRZIrY9CnJF3SPw+PNMtdAHMhIO9htyoAiPdcqGwfHqzyM/XPY/9Qv+J2u
 8OwMDqzm2ApYhsQWtA/IX+KXySFOMQVvNuktFH3o7k/T+Tzpp+4N3nuUiBwW4tPv8ICVVh+RH5C
 qCuwdGmOWlE4gMNxJhS/tCwia11hghQ+PH66ITm3sslQlxwrx7YZOqBI6DWN1ecQ==
X-Google-Smtp-Source: AGHT+IGmALyOvBNag9TqNMgn1V9xwABCBuf09gwFJpHmjNNDJIu5m+epK+m7gj0Id0VP0WLrPGNMQA==
X-Received: by 2002:a5d:5f46:0:b0:425:86da:325f with SMTP id
 ffacd0b85a97d-4324e4379aemr27859344f8f.27.1766748671245; 
 Fri, 26 Dec 2025 03:31:11 -0800 (PST)
Received: from [192.168.1.15] (alyon-655-1-564-32.w80-9.abo.wanadoo.fr.
 [80.9.105.32]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab257asm45711077f8f.38.2025.12.26.03.31.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Dec 2025 03:31:10 -0800 (PST)
Message-ID: <fdb62b59-00bc-42ef-980c-a388b1791ed0@linaro.org>
Date: Fri, 26 Dec 2025 12:31:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] memory: Factor out more common ram region
 initialization
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Akihiko Odaki
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <cover.1766525089.git.balaton@eik.bme.hu>
 <6a6918fb8b1e1f207485ea25fd8bc9161fe5c32b.1766525089.git.balaton@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <6a6918fb8b1e1f207485ea25fd8bc9161fe5c32b.1766525089.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 23/12/25 22:49, BALATON Zoltan wrote:
> Introduce internal memory_region_do_init_ram_ptr() function to remove
> duplicated code from different memory_region_init_ram_*ptr functions.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   system/memory.c | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


