Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E2ACD484E
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 20:09:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMWvC-00071C-NJ; Mon, 11 May 2026 16:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wMWvA-00070o-Pz
 for qemu-devel@nongnu.org; Mon, 11 May 2026 16:08:08 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wMWv9-0006aU-5X
 for qemu-devel@nongnu.org; Mon, 11 May 2026 16:08:08 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7e363c6141dso3137876a34.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 13:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778530085; x=1779134885; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IdD+LcEt3BIxUCkNKs9FY/WAhdfKNajSGNJBdfmpqFk=;
 b=pGJMwJJAncXNMG5nIfaNA5EhqTvkdy/Zl7Foof+Jss8E85LU0CbfmtLrB/BeVCsqH9
 iYOnnprIlVZ24rrBp5K+aXC/4pQEYXyigryuUywwfauKLI8s37aHnbExnB1zJTD9twJH
 m4N60o6Uv+ma8aDDYF1wuJbiRwAjkeWP2d73Ejw2bb3sng/zMCtg/jSYMTlCgHF7YMSl
 sObv3CNm8vHNsbPNlU36on57/KZ2XvJUU1XrxXY9dV1yj5EDqteqPdDCgDRu7LiMQ8s5
 6C6NIeug6wDp4yqqCHXWDWXqxH5+aDTe3Ggu6v/a9F0gICePwJJSS7mMEbop6bB/SZog
 T/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778530085; x=1779134885;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IdD+LcEt3BIxUCkNKs9FY/WAhdfKNajSGNJBdfmpqFk=;
 b=PXCrCOyLR1IJjp/1OZzgb9OZuLIzAmEEMcnD612/2x9JBIZ0J8LxDejEV/i5xj/MPS
 Rvw9yu8CtJkOlAylfC2SFmXm7wEehaCmFG6AYZGyKEsh/Grji/14aFXwhBvzfDbWE3mo
 F/O+VmCmLHaKVIa5PJFv5GKZCPNJgt8bFSc5qmcujX/ApZ8WMePx8Lu1pKgnENCadA3D
 PbiFp6tgvykTaHmYBeUXc21nvG4d7J9wkWNFzWcyPoV1Mideehrgk1/kkSivelCwhBXz
 QZ+nsCF5RuCmJaeCmhw90pGyDU3n1xWqNce+lMLCT7b+xhRy5+eaRdQoZLTrfVm4Hs5E
 nMAQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+W1sxw0mPXXQsoTjqOQf53vujWyfaKh5voHl9iQWf8v8IMi+I1qe3vwyiJpJMOfDUSAj84dXBYdmNn@nongnu.org
X-Gm-Message-State: AOJu0YxdlEJNiaPTJ/rEsa77Kv2BuI99VcPSGkXNeTtWl6cwfGGe2KQw
 qFb/3ZqBswP7WCzzrbeiuWSYeGjQB9d53bUXUvyxvauMail2Cv0EjHrIAUhZ/QucghQ=
X-Gm-Gg: Acq92OHOcgfR0Vu64qyLpoYX4GPH4dhPeZ+ONYVEs4QYzE1D86IsvACI/CDkPJfxhrN
 TPtRiTUZKCbeNkI756MaXSGrYmDq4dg/8ppjZEylsAkED5EvO0zy0dBonv+DFRHMl1J9+g8vDBO
 L3Sd6AVeomxaffoJLc5240l1mrmWkqdx3PRIxE4CjLcqi4Pr7JhnkjeY4g/N7cstV8bijb2EnRE
 hdOIoyaGeIdRMtlGvwFdXD0D1t+ru+PAHBYJMZqadTS2hDDpi2v4PP6E1ACfGfYS/k4+0lbv9be
 RDWx+kowqc4dSNkNZJ45R6j8vX68aTDg9AfaWqZDxxPsZoTi4QtIzMna2IKeMR8Kx/37n89bdUp
 0efsLAHP/7ZdbGceOmWeSprCZOufQRRTSW1fF7UDCWd/jNCrWIG9Ym25ED9c/kclB7LrnZS2rKd
 3XPCHGvBPbfbSouSYQcy+RHIBq/0MmwsdPfJYUX+g/kql8bkTowb0t1TYJnQ8wcTccRxj8FYuQ/
 5Rift2vLg==
X-Received: by 2002:a05:6830:4981:b0:7d7:4fc9:5204 with SMTP id
 46e09a7af769-7e1deec7181mr16530013a34.2.1778530084554; 
 Mon, 11 May 2026 13:08:04 -0700 (PDT)
Received: from ?IPV6:2600:381:c938:6375:e3e5:757d:3cef:3491?
 ([2600:381:c938:6375:e3e5:757d:3cef:3491])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367be1173sm7478039a34.3.2026.05.11.13.08.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 13:08:04 -0700 (PDT)
Message-ID: <64370224-bebc-4420-b3db-582eedcc7a57@linaro.org>
Date: Mon, 11 May 2026 15:08:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] meson: Build target-info-qom.c with -fno-lto
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20260511190634.472174-1-richard.henderson@linaro.org>
 <20260511190634.472174-2-richard.henderson@linaro.org>
 <1b05886e-e193-404d-ba78-d342147daece@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <1b05886e-e193-404d-ba78-d342147daece@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
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

On 5/11/26 14:38, Pierrick Bouvier wrote:
> On 5/11/2026 12:06 PM, Richard Henderson wrote:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   meson.build | 12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>
> 
> Why?
> Does LTO breaks anything in this case?

If the definition of target_info is available to lto, it will unify the const declaration 
with the non-const definition.  It will also constant propagate the 
default-zero-initializer to the uses.

The gcc bug reference in the meson.build comment may or may not be instructive.


r~

