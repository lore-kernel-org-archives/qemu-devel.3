Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D0C9FF8861
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:12:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHH4m-0005FN-Dj; Mon, 27 Apr 2026 04:12:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH4i-0005Ap-Cq
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:12:16 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH4f-0003Rq-2v
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:12:15 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488b150559bso78697895e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 01:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777277531; x=1777882331; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s5Cy1Ya3Ls4JtL6oKm5YUAQpyt8zwMGqHqWJC3r+QGo=;
 b=bcwpVXSvV/Pdlf6oggfbo87+q46Ibx+j3CsMhhc/FkARtCsGZP6khknM8ZyAJbS/jZ
 8w9wKj/ahxSU3pRWawx/CzVDilMB2BL5s3VlwAXZm7n4Oj1SLlrwHGEvbWHz6Hhr/wtI
 pvyRLNr+3xDGIBwkPkkxxlTPaHXnHn9ZFp63fUD73OGK5lyz6H0RIQDqNqVRuWNYa1lK
 0fdXUXqq0ItjfeiCDYQ/N3MhkNPGhwwHGpD5eqEVm/Bq0HiaMiuPrtBP/JUnOXzyfNK8
 EmYkky13qosvPt3M4pDKTNXzXWC4kPsumeJjA1syEHQS+nluwT9Q1wOD+KJoefuOLfAb
 YOIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777277531; x=1777882331;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s5Cy1Ya3Ls4JtL6oKm5YUAQpyt8zwMGqHqWJC3r+QGo=;
 b=cM2EdoBwB3znYKlU/DbVICrLr5vM94lgICr9ZyGKOR6dwSdk5yG70fAh/cEhKhfBg3
 XWijj76lRoDvrakixdTf9HnUhmCvHoLzuYf7y0b5LLi3JFdwhXqMidZkj9Y/SmcD/42E
 xSqkDYsa4fQnoJ2YFrj19jTJS2q3tU0bqMBbAt7eTxcW45NGWleelhpj3D96419LkrOP
 jIfcmLa4P60HHJUVySzaB2Yzu1zY3Fx9QFjDrZaadD+bBmsoxZoRtffLVwrKyvltJfCv
 O7tnInyqA5S6u00eKJ9Xsu/LApCbqqZXkawXCVoxMM3T4YVLeEDtTQidOKVokTrDbXI8
 nhcw==
X-Gm-Message-State: AOJu0YzG0dnqURabKg+Kh5HgE+eI63+OyNUFNdhBMrbrfhkA/C7xh+hE
 Qap7lKHPUR7KT40opgS7zIaXdj1MvKZF6CGUkLIfBOosMSwHwHhvmg54Hmx+2Kda+gU=
X-Gm-Gg: AeBDieth/vCTV6TwHMf18y98o4D2885suXtYO31IU35rxl9FcGRU/F6LqkdA4HOzqlB
 H9gXC5vI08hRmNryIzKEqHY5pTQIW71R+QFnoYaVEBQxRejAi6+RYRW201rNEClNpPuz1x3aCHO
 EFUxFapDjiIfStD/ONznDHwtVueAz8xOklqN9W36E9hBhkManMLMgcGxYjBwC1q6gHK5IKJWXXq
 Ip6Qz2mL1MzOGFvm7z/9XSebytqo7gOHENOVAzmszcIvRJHWcgjwoa6iL7M/AW6TSPOHKmT+VQ4
 fXZ8Ye1ggF15ITr3qUQBDxL0JhKXuLTQidn097RSjAVP6AezkX1dQDDFQvJdAPc5dKATd4KBX/F
 3OCMBPuCivENH910bxPhotVUz4vJNj9ZqsY+MqH27jrq3Mu+KSXpImKVBhR9KyIP9L4kUVvqsDq
 5r6RnUjLYyrCt8VyLhsaVWa2fvzF7750y/VbonX7Yx1ugj1cQeGXeLJKfiWel/F7dL8nEU4oxm+
 vIS
X-Received: by 2002:a05:600c:c0c8:b0:487:21c7:2885 with SMTP id
 5b1f17b1804b1-488fb73d9ffmr444367255e9.5.1777277531063; 
 Mon, 27 Apr 2026 01:12:11 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc177dafsm940086065e9.4.2026.04.27.01.12.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 01:12:10 -0700 (PDT)
Message-ID: <1d0a5102-7261-4b7d-84da-934c955d93ed@linaro.org>
Date: Mon, 27 Apr 2026 10:12:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/ppc/test_ppe42: Fix warning from the
 latest version of pylint
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Glenn Miles <milesg@linux.ibm.com>,
 qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20260427080731.389061-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260427080731.389061-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 27/4/26 10:07, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The pylint from Fedora 44 found a new issue in this test:
> 
>   tests/functional/ppc/test_ppe42.py:63:20: W0101: Unreachable code (unreachable)
> 
> And indeed, the "break" is unreachable since the previous self.fail()
> always aborts immediately. Thus let's remove the "break" to make pylint
> happy again.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/ppc/test_ppe42.py | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

