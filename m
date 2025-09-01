Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 423C4CA1002
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 20:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utBc8-0000nf-GU; Mon, 01 Sep 2025 16:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utBc7-0000nK-42
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 16:58:55 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utBc5-0004XB-Fp
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 16:58:54 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3d4dcf3863dso1141571f8f.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 13:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756760331; x=1757365131; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Sly1pQGIL/9C4hfW0BvZYs7+YdkOOkPEeU6wf1Vr1xM=;
 b=v6bHsv08xpeh2WaLJil0EFRMjuO4yB0/bvdXZcsvU19QXIsDv78JrfGxtdJBYVjCiz
 VhWOT6j1zpvJk2rvZWklZh8zfu1MOYbWVzcS1vDODVfzcd9C+Zf3aBU8QPH94N6p7Fsc
 whu6LQUuiCPsojbJUv7QzFfPG5Imq0au5h7uB+YB2xRpZ35gXwqCckc1/tCBncRFg1JQ
 d6cwY1KdSEPrXnCTsCMeQINpke5ssXEF7KG8tFzGnRUaFNFme561b5dMUzmLgilup6C0
 kfenmXdGcg/msKGs6e0rIww/J67euBsvpvxD883zyxIxt00Rfx4MG45X9Ul/GmwlGKpk
 iOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756760331; x=1757365131;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Sly1pQGIL/9C4hfW0BvZYs7+YdkOOkPEeU6wf1Vr1xM=;
 b=rrodp9BacQHscAJc6L219RHFblJPQ3KBKbG9D2l7ArPBP029wE2pn1hLGbZeBQD4d1
 heJbCheutliz7U5Ib8zQL2stbARzQBNon9ouxqLP8vNVJs/Uy+u2ZAzQk22w2BvQ1spa
 0qWXX20skPIjdXRx9wlezxFvksopMdSlHVx6imr3lOui8BW5SaDkkr5x3k68ftDjWj1x
 5z+2iXRO17NqgFcZcanTpKpZeC4Ga+EadRKYDX6Zr/+qQoVLkLL7BNY6q80qXg2EfwnE
 wrREgBOW2OmhvpJ7TS9yopH/z21TlZnZ4qBdJxa0SP94xmwOkWEdCNDbHH4ophMyx5n5
 +7lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV29Uq6Zm9Bk1MMJGEeHiYGbzHjc5gGvPaiIg+3COFjOS8CXODCqgPEvDt+gEWK3mMtwW0ifo9tG8P/@nongnu.org
X-Gm-Message-State: AOJu0YxB09V0v4Z5fH/i0FiJOcmLg9yFd+YEMEFOE+dmLxuOHSBm/hng
 FtjF/vFqP2BqTyBQxn2cZ+gywgCgbnk2dIj7BLwO7O6M0JNGPGO0YbkZ5FaJxOPi/LM=
X-Gm-Gg: ASbGncsGG9fpdcUpNnCrhfqhDBddiUbbU/nckdfl00j0ZMg4k747jTB/eg3Q2JpWbsz
 tc1tp4Nn/8j9oj8auXJJlNPl+QMkrh49S007aoin4j5s7Rc9wgHmZx354uILVw17iVFBW+1xhvH
 D33WuTvC3KHEyyA67RF5MdL3mXMDNCGavm/TvS8EtkGOKTWuwCQEgN2Ve/s6FN2hfV3TivSGTu4
 5GLL7bHJptAxxQI0ujc7+V/5NETBdLgQ0WjFkRWgFkkYeUiUFCXo9ILRDy/K1LqW5t+H3PHOVEp
 rQlG733BptrYb/n0xrN47IZuF/TtCZ1V8KGXiZVWeogZis9NJa3FEOWlxDepMwI/iMRaBLGMAZC
 Ny1sMetYfLoxNxgi/1a/qNrwV3JM962i4fJ5sQgjlTYoIkhtt4b0d+QVn6DGuFx3Zvv7wUCzL8c
 0M
X-Google-Smtp-Source: AGHT+IGPMUNu51/es9Bnr8SoDMrfIfs0zKxaWy5xFfgGcgI7/TwwuA8qa0keDDWacr+NrbNPBqAVww==
X-Received: by 2002:a05:6000:2c04:b0:3d1:61f0:d253 with SMTP id
 ffacd0b85a97d-3d1df828682mr8833908f8f.60.1756760331478; 
 Mon, 01 Sep 2025 13:58:51 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f0c6db6sm267577045e9.2.2025.09.01.13.58.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 13:58:50 -0700 (PDT)
Message-ID: <a2077894-7f0d-4b73-85d1-8a625f2e0445@linaro.org>
Date: Mon, 1 Sep 2025 22:58:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] sd: Add RPMB emulation to eMMC model
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <cover.1756706188.git.jan.kiszka@siemens.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <cover.1756706188.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Hi Jan,

On 1/9/25 07:56, Jan Kiszka wrote:

> Jan Kiszka (8):
>    hw/sd/sdcard: Fix size check for backing block image
>    hw/sd/sdcard: Add validation for boot-partition-size

>    hw/sd/sdcard: Refactor sd_bootpart_offset

>    crypto/hmac: Allow to build hmac over multiple
>      qcrypto_gnutls_hmac_bytes[v] calls
I'm queuing the 4 reviewed preparatory patches to alleviate
your series (and keep the RPMB patches in my TOREVIEW folder
-- no objection so far, I just need more testing time).

Regards,

Phil.

