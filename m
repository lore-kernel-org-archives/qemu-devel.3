Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E27C54E90
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 15:29:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJDH2-00020s-NV; Sun, 25 May 2025 11:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJDGt-00020N-HU
 for qemu-devel@nongnu.org; Sun, 25 May 2025 11:28:20 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJDGr-0007sf-U8
 for qemu-devel@nongnu.org; Sun, 25 May 2025 11:28:19 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a4c6c0a9c7so923772f8f.3
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 08:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748186896; x=1748791696; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F8EbGkz4M42nZqRhqPqRAkBdasL/dXOwqjNBKsbMQWc=;
 b=wrm0FHkkyunmOwhKE4Ubtg/e2edKIYpN5dzzB2ZS3m5yu85/t8Up8/jYrwkSAB+GsE
 GNZpUM6+rGMXV96KSEIlM9+pFdaivm3TBhdHTkdqMxzZv1iJzOeSDV0yMgw5iskxSArA
 ftiSx9XT4V86zdXEC88MB2vlajzwz2YDsMz3SB1t++fSC4ut2KYIxnIwCij+bO/ytEeW
 Bf/CSBRjfNw+g5gT6CHvVcuSlnAlvZK6CYpcaXWouUiiw0QbW/h4MPHOAEPYzyWeQcux
 INNdS3dLch1xwYrSRifUz6Qu9tGNCAxMwOxcTEHemKz/QesAmizI51zfJUiHIPP0IgIE
 d4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748186896; x=1748791696;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F8EbGkz4M42nZqRhqPqRAkBdasL/dXOwqjNBKsbMQWc=;
 b=oJho4Jao19pfTZ0UEy7vWmbxU0GPACVixnUNnaKH14mSQDEWyYKEcBJixDY1v3hqu/
 1bBakUsvD0PFTrw90AGTFMsOfaPJDh6o3D6g2NSJEgQhKLnCdoNDgqVX70E2Vvi3PWkD
 DqM+fOBoXL9VIU27kwgLHH3yQjOiPSzxqFzuWcMggGv8Xv7T6D59yy2G0t1CInV0So0f
 6XIcyT3m4dMmVqTM8sqNKSCQcl/Cz9amNQjGHQgITOvJXVCNa2S0Ule03O2FvDg2Ee2h
 cGP6a/n0VUZJWx6KS1oogb3gZWux1fOBnQWD97pTI6SnNF8RPtFFVGxh/TBk3/FLOf7u
 T/Gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzDxty+lzb06E3qKAWK0FzYrzCOt0UM890vzqBeOgD5W91z5vzv7GRvleqnrXp7LzHly1IPWq0j5VA@nongnu.org
X-Gm-Message-State: AOJu0YxaT8Sfahvzj0pKvCyji8rK7hPVDXxx66jIjOCc+w+2oDvW2YIi
 zp64BMNMi3fnogtJ69P0b8CV9pAg3TirlhUkElUiRHqQbxRrYtsSEcAF3CujKOV+yd4=
X-Gm-Gg: ASbGncvGgbJVBGmo7lickFGeBh5RHxXhElocHDAQKTegS47ELkgWZ7w4y7KsxO6SnOY
 JNcHRkAmtyzR8M2uCk/+BVjTEY58S7o8fFiSVR6vxRF96JpN4LIVDOAF2bRYobY1jQdAwOxfDKx
 QMkLqfRy1Z4A3ISazTdLcG/OrYsfuRUIN2rzzwmQZHfWgprddzU7KsjJ1/4VAZu2YZFCzDt8qC4
 KofLmQMokKwkb3kLRthwwr6W2Cy6MdF965tUaAkGQ7m80rJ/dhA3AA7tHXGXnxteNDanp7ePhf2
 j2rQKcEX1Q7tTSUE9Fl5PkMxQLfzSwAHPo0tW3itT4m6h+Ygl37y+V0y7QruPcCUOKNKQ7GyGp5
 wQf9ZSKCURki6I1p1Z9QoQYXtees=
X-Google-Smtp-Source: AGHT+IGp9RtJkV746KVd/hPdNPWac0dVsiHmCWWng6icApKNenD3z6+N3ZcVgJ/B02sF0OMNO0Fgeg==
X-Received: by 2002:a05:6000:1ac6:b0:3a3:4bb4:7357 with SMTP id
 ffacd0b85a97d-3a4cb4b8e7fmr4703653f8f.37.1748186895813; 
 Sun, 25 May 2025 08:28:15 -0700 (PDT)
Received: from [10.132.0.213] (17.red-95-127-33.staticip.rima-tde.net.
 [95.127.33.17]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f6b297easm220231085e9.6.2025.05.25.08.28.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 May 2025 08:28:14 -0700 (PDT)
Message-ID: <6e6ed828-9fde-4378-a7b8-6747ce764ab5@linaro.org>
Date: Sun, 25 May 2025 17:28:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/test_mem_addr_space: Use set_machine()
 to select the machine
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250521143732.140711-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250521143732.140711-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 21/5/25 15:37, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> By using self.set_machine() the tests get properly skipped in case
> the machine has not been compiled into the QEMU binary, e.g. when
> "configure" has been run with "--without-default-devices".
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/test_mem_addr_space.py | 63 +++++++++++++------------
>   1 file changed, 32 insertions(+), 31 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


