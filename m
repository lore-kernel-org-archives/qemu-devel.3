Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A035E7716B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 06:20:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIijl-0004D2-SF; Wed, 04 Dec 2024 01:19:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIijj-0004BV-St
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 01:19:48 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIijh-0005xE-Nt
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 01:19:47 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-434a099ba95so57720725e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 22:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733293183; x=1733897983; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Vm2jwAfu3BvWyjQjkaSyb0QAD7viyHy+j8hkejcDONs=;
 b=R9nmv5JCOuwWie2yHa5znfBRTcY0vWJVvNNtVjhWAMwlp8Rkojqx9TLXMZkLBizita
 l2eFmvOnunAUYEV2S7OF5bwe5zllqrcZRHAHz7Umib8vFcdUhaWj2DOXOcis4yYGpeRc
 maVy0lsMnW6HTg8oD6DKvi0MjzLx/ZgQgLAelrkaDvgyzzHoV7Yl+AzG5zEJwnrpckoX
 +2WTJ1fbiBnSHmSx5RDRnEfx8Hf9MeyjWcZ9JTw5KSUs9vwq47z01B/NOQVZuaCtp8RJ
 v4RbrMIDIhj+qplJ0MU5AsOWavb1j7s8ERu5eXl2nwUU7KDsm7/pjGCuY2Du0rbZCuT0
 LvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733293183; x=1733897983;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vm2jwAfu3BvWyjQjkaSyb0QAD7viyHy+j8hkejcDONs=;
 b=GI1yZoaF4XLMLxNVM1wYAin1g+vu9de5EB/H4syWZiU7f0Kl9tLKleKwLE4Eg9N5Tf
 5kQuBDzT6cBIz39+f4kX9EDQJU3fwNZpJNx+0KLdvV8F7Yb04gr8v0mY4T5KWchnQIyy
 qRjy/Nqs1LEf4yoAvPTBWzgC52WkDondKHIS0aqYYiwgMmYM5AkAbO1rzzt8OOq518Dv
 YtO5p10bwC2Q0sPpjNMQ3UmPTAKOXKq5AYMLsPY33H8/iqe65Q3L6b2icvUg5NHXksjk
 KGMNzF02/ZyUXNqFnxVF7oIHx7gJKv1Rsfbc0ceFFQ4T7ImbfeI5FHek7ShOhD+GX4MZ
 mM3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUi5+NXRch4uZDI1DEEPFGknOdipWcANf7FoKlCY9l928yATTeHpPNE7FdzkM63H9cHrBsXfWy834DP@nongnu.org
X-Gm-Message-State: AOJu0YzZeM0rh7+5qv4CeimC6ysUY65X0V9g3gcp2+S9+w5q8WBpwMtQ
 AivB2JAK0ePSeCoRioBbnp5Ivy8Z/qc9B100oleZb9TQ8ygMuQMf0QGfETWCaMNVdc4D/FV4VK0
 j
X-Gm-Gg: ASbGncv54GHTvRdinHtB8AC0YIcR3cf12oFCaUycvQA/dmpDgj4X/pT/rpNkeddzloH
 vGMVhrMX+TkEeinzlreFIlfIi7pmi6JOxhQM8Cy88Dj94UiJa7gFXOsuu7+hHtLFHOiw3u17u04
 vh22bx0ucfTuhwd8v06G/TXHp22sntbRcH6HNMWpJgQUf0+BCwuKg3oIJIrMGeTDpHzSvvexawc
 /Ha82mg/1AbzZzBc70LOfFeY+cWaMYhffFkthXJ32Zuwf9i+zmMAf+9nSDU5/m2uWLNILTjwmto
 7eq71GQmVLJto6hXDNEf
X-Google-Smtp-Source: AGHT+IG2HotX+wUCMVmjNeZXgxRLKWWRduEq0QE81ljv+uyHnzWtn38V2JFLKFNMxrJevfeOcMt3Yg==
X-Received: by 2002:a05:600c:3ba3:b0:434:9de2:b101 with SMTP id
 5b1f17b1804b1-434d09a6c1amr43941585e9.2.1733293183203; 
 Tue, 03 Dec 2024 22:19:43 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d527257dsm12473545e9.1.2024.12.03.22.19.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 22:19:42 -0800 (PST)
Message-ID: <0c448906-1f65-4433-aaf6-ec10943269a3@linaro.org>
Date: Wed, 4 Dec 2024 07:19:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] softfloat: Pad array size in pick_nan_muladd
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20241203203949.483774-1-richard.henderson@linaro.org>
 <20241203203949.483774-6-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241203203949.483774-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 3/12/24 21:39, Richard Henderson wrote:
> While all indices into val[] should be in [0-2], the mask
> applied is two bits.  To help static analysis see there is
> no possibility of read beyond the end of the array, pad the
> array to 4 entries, with the final being (implicitly) NULL.

Squash in previous keeping the explanation? Regardless,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat-parts.c.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)


