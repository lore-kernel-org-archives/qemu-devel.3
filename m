Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A7D3E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 22:21:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL8b5-0001Ni-OC; Tue, 10 Dec 2024 17:20:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL8b4-0001NZ-5N
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 17:20:50 -0500
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL8b2-0003WD-6l
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 17:20:49 -0500
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-29f88004a92so2149826fac.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 14:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733869246; x=1734474046; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5fGFpCI/EYjl3R9JTExxmw/JAqQgmVrEt+dLtyD3CJ4=;
 b=wOr5OBx2Xkod7BRtbkqcB6aWz9bzp/sPWWJntXoXNQDIrpVc+1v94EKBDq5K64VwpC
 t6TLvBGJYbWtPCAsydscBP6TR3XXB2bsh/LY9R2Cw7W+0uvKcKdfe5bXlgy0TN2frL5b
 24EFALweJiiC5c0L93nF0QftvhDRki70Pr5IfQ4m+UzUntW8zOim+g1mhn++nGAl1DHd
 gouNf+RdmH9wKgma9r5RCBE5qjTIt1YD2i/O1/wpDtQdlzVX7oWjMmAESeuU6Y1qhns0
 Q5EkjbkXE5xdRSHRMhtcdcWPzyEFJYELafIWKnPAQfBlU/tTYx0QCCtv69UIlp5hV+R7
 I3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733869246; x=1734474046;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5fGFpCI/EYjl3R9JTExxmw/JAqQgmVrEt+dLtyD3CJ4=;
 b=QRTDNZ3EU0G9Oq2OjsXOtxvgWdQvYN5a5dSNpzP6aasTctbN79emvuNYrNQaQfsqpV
 BL9n8nYFeQJ3yHgtvxMdQgViJeA9b/M4e5ntjjjtKhIVxMfOOIBM8q/DKqVy1LSVUQeF
 Ew+pdJOzBgv/bP25jPIVLYpw5Swgl5H8K8yAQzbUe8fwjOEBRgIDV4x3Rr5KZb0duOAi
 Dt50QbW+h47KhYi3Eyb4gs94aZHSTcBjEdQ08MABG+Mfq9s5eixJDE17pwUhAfylDqhd
 YXMzkUhGNqFz+kXAIX4a/eAY5QUebPXg7izFZw+vroIkX/sczOGvc0lKer/h4zRTLSpG
 drFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxTWVvfa3yC3g/RUrczJYRjB/kHDj+H5fJK5La/7n9IYu6islyzIh6R3HrH6ZJzNkhKTglSqYbfcrl@nongnu.org
X-Gm-Message-State: AOJu0YxbLIp1BFNMObxWsoUYbgqKfaB8AYnKZYmAk1okw//Ib7KaQGBx
 MZUq9Z/cphO05wrzDPVaqfQTBqP/byi9KjhRNnzbVpF2rwKwI347RvbWihf3V6c=
X-Gm-Gg: ASbGncvZYYBmc0BoQhs/DbTz/XsToGSAlBFAkuNvJl1YmnRxcAP8YrjaeMUWyoG2u7O
 3QSyMn7kq8QtRxf8xUrEgPJB/ToKZh8IdMZIkhZTlTy8zEqj9nUVaa+r8Xxb39tUdjWDV8rMTyy
 szIcVstunSAMGKjfDCLu2BKIAXHbV00hTzhHSRSLT4Y7R0nrI2lodeDbm086J58au5371aiXdd+
 PiLaiFjHz+4SZccI5AvPog43EVw8r1rZPQmobylXTLIUeCMko9nooRJBWwj6ovmuKPCjclHDOY2
 DgxqVnONOkA/w63yo3E8XNbs1KjZ1aZ8
X-Google-Smtp-Source: AGHT+IH1h+KAEMoA0OIzY0etXOvGtOIlGAN/lspo5aRsBRwmUpZbjgtWHKeAA+ifeAaBNzlwQjeURA==
X-Received: by 2002:a05:6870:c115:b0:29e:719b:7837 with SMTP id
 586e51a60fabf-2a012bafb99mr420121fac.13.1733869246320; 
 Tue, 10 Dec 2024 14:20:46 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29fa454d037sm2248677fac.38.2024.12.10.14.20.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2024 14:20:46 -0800 (PST)
Message-ID: <2ca333dc-aba4-43d8-a7ef-c35981e2c13c@linaro.org>
Date: Tue, 10 Dec 2024 16:20:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/20] tests/functional: extend test_aarch64_virt with
 vulkan test
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20241210204349.723590-1-alex.bennee@linaro.org>
 <20241210204349.723590-21-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241210204349.723590-21-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x33.google.com
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

On 12/10/24 14:43, Alex Bennée wrote:
> Now we have virtio-gpu Vulkan support lets add a test for it.
> Currently this is using images build by buildroot:
> 
>    https://lists.buildroot.org/pipermail/buildroot/2024-December/768196.html
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/functional/test_aarch64_virt.py | 83 ++++++++++++++++++++++++++-
>   1 file changed, 80 insertions(+), 3 deletions(-)

Why is this not in a new file, so that it can run in parallel
with the existing test?


r~

