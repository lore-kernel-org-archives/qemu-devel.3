Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C1D106FD6C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 03:16:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0t0m-000344-Eg; Thu, 12 Mar 2026 23:16:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0t0k-00033u-Md
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 23:16:26 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0t0i-0002cz-V0
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 23:16:26 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48540d21f7dso19563845e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 20:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773371783; x=1773976583; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=45wjUECnkznHvi75mJ1EoByfvbFD/vlU2ddv+wBOv/c=;
 b=qSaqw3TafGScabLp0j3F5VhHs1a7wMIURZstVhEwObFW0aY786tsthP3ZplhSD14sh
 nlrWx3IgqZUmn5NcoU88vQ35PJkU31SHXL8k6KEHjNj8ztl9sfVFU6jxTDoh7U3UPmAm
 asTU7X8EkwGGXHttLZf70iFCxdmGMIWrZ1+tFjJBSvkM1kjfVtq25RrInUhgsIr41oHb
 57UEvHtBV2RWgG8Z8qzw1fI74LTTHqfBHWjkoAhQCgkYM6xai79eE0zMT1t88ZKhLxfP
 omc2pkWVmEjUjEP0nBhyMHLHXZ0VA9SoJA1wi9C2QUYbI8mZzc59CuDfzXxDBGg5tk2A
 ng4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773371783; x=1773976583;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=45wjUECnkznHvi75mJ1EoByfvbFD/vlU2ddv+wBOv/c=;
 b=EVFexCFmReHmICYYqb/7M98xhNVX1OsisjXU4dsw4txJDa8/v/vyuyBFJbLXFiI2SZ
 ccWAzrFe7atwxKXVb4WVSUph0GCqPNca+6CGzA/feP5B+zBe+NfMT4T2Jb8mtGNkMzRM
 NvUQ+S/jauXIVKP8TNSzXDGh+CVUoYMjDIO/elGejXlKeU6tP3bsZIN8zEgmYhAwAp3P
 W7tlAweOk3Ad29va34Ebyf7vflBiwlyzmCzO1JXby9+IKCsc+j/mkOdYpWYO4YKMKiE1
 lIMgu0C2uQYTRsjsFlbZgThXRKY42LJHStzOMG8ZNGavgtReUYXUCJjRdSyXBPKR82DQ
 i2ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2lg1eZK3L6HLnG0WqdhhyExR16awDKr3cMEgiWz3i2LvAJQXMRiimr47ZDRKTC+6A3HQl6j/P6HFm@nongnu.org
X-Gm-Message-State: AOJu0YzXsq0aXcGYaQgDk8hzkYPa42/gM46PeIEOatlsWDfyk2dMRiOL
 PhiM/cCpOaQetlbIjgL8nQLfni/RssW4N9XHne2kou2o1/thU/EY1Y+J/Y8AmhqBISg=
X-Gm-Gg: ATEYQzwSkZ99eaEgZVBGep54o6SFIDppTMrJfGZ2sQzVvMcTzZmEZ3BKPHni1l4nW0H
 hh3t2EO2pAGwWyiJEONxWZX+TaXHQ41vNfQa5eDQT0J8tpp5IvCXtfLlOcveZ/lHn4gEbjX7+7x
 dhBZpsAd0KnBwZWeMMZYT2I2gANeqYa4+nXz0tzOVILHkhPcf8XOIw7W1P2P37cUrCK1GIfyhZ7
 CmShwTpgmZ3cPpkYsorFuFbi+g8pt+905G6nX1haXck9FF3SxZzwqj0XzPqqEHZzlpLzTLcT4o/
 1/tMZROmENqn1VPSfo4t7sbi+MdXWEDABezVo9tVD6kj365lGKKRc9W3EsU+JfpkQE/KtmkgEiz
 8Pe3F+quqV5pfrdiNURcawUOyPDXtHNNWXA93NLYY3YDbO1qlc2snMamkSzccDUHpjeCd7tpo/r
 g1/ti+R3N78ZzREB0sJGCTU+gVqn+FMIr1pFgZHQpi6nBivZ8CJA0ViQfboDfwiuIyAQ==
X-Received: by 2002:a05:600c:1f8d:b0:485:4278:24fb with SMTP id
 5b1f17b1804b1-48556711dfcmr22118795e9.32.1773371783014; 
 Thu, 12 Mar 2026 20:16:23 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b5e92d5sm170714915e9.1.2026.03.12.20.16.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Mar 2026 20:16:22 -0700 (PDT)
Message-ID: <565aa65a-c65f-4f14-9e8a-ac4995a22758@linaro.org>
Date: Fri, 13 Mar 2026 04:16:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] hw/vfio/listener.c: remove CONFIG_KVM
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com
References: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
 <20260312224449.1605071-2-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260312224449.1605071-2-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 12/3/26 23:44, Pierrick Bouvier wrote:
> Code concerned is under a kvm_enabled() guard.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/vfio/listener.c | 4 ----
>   1 file changed, 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

