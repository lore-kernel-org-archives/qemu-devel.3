Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C87BACF3187
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 10:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLfLM-0001Js-U2; Wed, 19 Nov 2025 05:23:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLfL7-0001CB-7r
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 05:23:06 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLfL5-000200-86
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 05:23:05 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47775fb6cb4so47200885e9.0
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 02:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763547781; x=1764152581; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DNHsoCQnZuLROnmXTwWb75A0IFlQGlVEDCQsgZuD/FU=;
 b=Zi2lg8/pZgAAimY2ER1KAOOqG//vOx/rJQ7Hq0wpKkPKsgL/P5wKGpB+qMpc9zh2Eq
 vBf6kYvrg2AbeN70GhhD5OsHII7I3OnPH8tzSLjZtIikJwjppKb2wSKJpFabO/3NMRrw
 nMwhz5qXHAL959FUktbQI1UQuHt2Ug4d5jXsmak6JeOGSEfVDHAa/wa9WCbmj8suHPMR
 oKMVUnyvkhtlrGJH2xn5QUKv7yPF2CXOmkQLvvT/Q2W+ZRWNpSAGaAPJDVbX56nb/F9o
 XGGdYbbf1qO4E0mjzme9HHHHicJES/ci4ZRpLseUmLMpEjXzI9Yqi4XaA5nnCd5KSBpX
 XmSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763547781; x=1764152581;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DNHsoCQnZuLROnmXTwWb75A0IFlQGlVEDCQsgZuD/FU=;
 b=MnHi5DLhSO5jxL0FOWXIRQiTAAw7rxmgUbgE526Te3pFTgPT/m6lH6+7lh0Jh+YvwT
 l4ZBRdLxW4qAFYZLaQSp46ewVt/bFFbOkigREuftCzODA6ZWBGHQpFC5218xnLm3PVPj
 Izb05K2Rgst2QgX+k2LXa/o0YtSZUPjwM/IjFbCDhQ3wfGtpKmRigCiciXHqQnwzxPpu
 noxme1i96a90UOwXQRq7xixRFReFrW6bbW/b1zg+hYu1MqY6E5N+lrQOA/lV3vSgAD/N
 ZDJiiHtraM2Q1ZHPC0vEMmQV13Ul83I8E+wSqTkNwM/0pY0ZKKW+TeLKaDmtvtESP8tJ
 RuTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWewm5kJDsewlBzpEBEHJdUcDYi46n+WDaOg/qRcU/AHyUg+MB16Xws0zophj1jqceTv84R0R3LV2Ep@nongnu.org
X-Gm-Message-State: AOJu0YwPQAcI5EAvsncmb81w4rYvJD3GHe4xBqEfZnOghmaXvRkF1o0r
 CmTCh4Q3JCvEZyS+FWiOs4eHLtzlhkONmt1mhxh8UKpovWWXi8asxyJefbD72VRFAco=
X-Gm-Gg: ASbGncstfT9BkgEdI/SpYJuUPfaxwuWo5912OEVuIV3tZad3WNNtEeTofWqcAS96Jg8
 Nb9qq4YK0ZxTespPcYrd4tdzB4q8FJxkoZpbvAJUqslijdXNIt9+7oQitwU0zIOqx1pqao/askd
 rsgFgCw7/pv7j5Urv3vHwSuG6SSiNeWAh5EoBbKn+/3LJiTueaLaGgSKhJHh4kXzuWLdob3r2pt
 MP1xChiVqxYiAE80HD1S7+WiafpNJGpnyvYh02m6IF4sgEWxcSq6gcYtOFtBS1NXZPt3wVuyNUs
 VFRZEMtmqkC6J/cxd3TVj2+iEdSYh67VitK7fH8KTzcLVS2/peO4Z+Vz3AD10rHkYvHLTh+g3Y6
 Z2NYaVLMfYDie439NsaFL1GU6vmGxuvgo0wQnz6BVOs+rXjlAN8XTqEHt7Px5fy7xle41C/4Dz8
 iDuPgduYzzTRHQAgASSV1A+u28aRTXP2wSRSCypy+Z1Gc/keDa3hJxYcBzarnLaoQLn206ieRpv
 tw=
X-Google-Smtp-Source: AGHT+IF3uroOSDNafrdtFBMH2aNwz/R/toAgjdok3r4mXer4Xi9Ue2YRYpo6b/92xEwM7a3bn5C5AA==
X-Received: by 2002:a05:6000:4383:b0:42b:3c8d:1932 with SMTP id
 ffacd0b85a97d-42b59345301mr17214642f8f.23.1763547781125; 
 Wed, 19 Nov 2025 02:23:01 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42c9628ebacsm24339777f8f.30.2025.11.19.02.22.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Nov 2025 02:23:00 -0800 (PST)
Message-ID: <9911d2b2-6eb3-4068-8609-d430ba36cd1b@linaro.org>
Date: Wed, 19 Nov 2025 11:22:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.0 09/15] tests/functional/ppc/test_amiga: Fix
 issues reported by pylint and flake8
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 John Snow <jsnow@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Eric Auger <eric.auger@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 BALATON Zoltan <balaton@eik.bme.hu>, Glenn Miles <milesg@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Zhao Liu <zhao1.liu@intel.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20251119082636.43286-1-thuth@redhat.com>
 <20251119082636.43286-10-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251119082636.43286-10-thuth@redhat.com>
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

On 19/11/25 09:26, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Pylint complains about unused variable "tar_name" and a missing "check"
> for subprocess.run(), and flake8 suggest a second empty line after the
> class. While we're at it, also remove the unused "timeout" class variable
> (that was only necessary for the avocado framework which we don't use
> anymore).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/ppc/test_amiga.py | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


