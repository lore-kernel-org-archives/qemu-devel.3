Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE780CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:36:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBwQg-0002RU-SW; Thu, 23 Oct 2025 10:36:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBwQW-0002Ow-2W
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:36:29 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBwQT-0002eW-Pb
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:36:27 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4711f156326so8759225e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 07:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761230183; x=1761834983; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yjpyF/1fKhMues6CxnLiUv7Dt8TBIl2szKKd2PGZMu4=;
 b=w6JVN0OdjbjCqtFCXuATLp23aQhzEogsG/00uOFGcGkm8zvkIY8fs6TK0zyi3xTKMu
 zOLbfYna0zv0UhUPp4Ul4/Wf5ALXLdCRhXcBKtUVAxKUjyuQruIFimjmTXowRKqpBmjo
 54q45FdhLYSWGwP/SdgMhDWKELKIk4d26lE4YTTgjRwffnv3VfHgGJKkL8FekDuIjGCt
 q++JZsdxtcCS0bVRe1gOqJf48FdoFF45p/GOFluev56tZMEZp9VibMLbpANlKJ5F8VGy
 Ol9h5phpN9qOCM+uxFJrwHiy7+14iHPq09cnn+f7pgUO9CwWeDQEG6n+5RKc43KShYZ4
 fkkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761230183; x=1761834983;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yjpyF/1fKhMues6CxnLiUv7Dt8TBIl2szKKd2PGZMu4=;
 b=k1wEv1xpVBXy9uhOjnzVsGI8GdWd0zG0ZU8aRjcBLbYS/N4G+hxOwJGCAiK0B9HWHD
 +u2VEWF8CrrB/DnuakxRzM97s1asNfJX0H/opFnjxKdH6kxYmrJnxlF87J7YR11erxuJ
 zLP6yenv4v+y6Dd7N7mFgP7U9hkOqNgT5MEpooProvkVoYrLXBYAsss4T8RUviJlN1ot
 VIaXlqSMCTw5UnuVU++HCFmRiY/2LOQiVWBOkQhX0roHYMqACiIltO59zgPbE62pI7vu
 1eXrLZnbbtePjsq9CLqdACxPO9u4txOmHQZPLCgq8B/tsdtnsHqlSrWxMua+6b8pRMzU
 oznA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzf+cy99m6yAUwnezeOAoTkHkemYiXtJobxzE/7qVVEb9uch39ohAGXGeuSNuRG7PxGZplpC54Yy/v@nongnu.org
X-Gm-Message-State: AOJu0Yz7n1RHFzPUf2s2cgAPM1Mea6lFtKzGChpXkhkTk2a0kW/t9Mre
 +QBn9llRu32pT9p7SLhbw3W4uLa49chGHx2reeP81Zmvi1b/ovE0dWHlntXnSAJgWXc=
X-Gm-Gg: ASbGncvmGL4uZ2JIjONfQn3q+HTa+FxAEYqTY6i437p9RrwHMtsToOciWzTmi4RA4rh
 1EMadxJqyvBkVIsuhabk/dmldnCuTwqSVznlEcYOxo/gBHcI7/UZ002t72/OgAvP4zTfuO7r2WH
 nEYfiJ9KxQVdiXlZIbG8Va/Iojff5Y7a01VMR0QoDMi0E14ePV0iYyhYOpzutFlfttWrous146V
 cFz/kMG/1yvkKHh1Mo2frw9WMBgOp2pIWqjgqy3NN4TVMKOOB2OiAPGvYUNqWO4CGoySYwQyOL/
 LMV5vex8c3Wy1zAp9ZFZeBP8MRdk85iAuFn0bAaDaF4pqAW5iIIcBC8xysPbOhW7LJAXkJe0qsS
 55stWYfZMvFkuH6t5Y9lg1yx+QcP/QtC0GLhqZHKU5jNTrYUkYnUs6uBGNU7n76TdV2BGhUvNCO
 /FPRttl/8SGcCGR5W0LYYX7WL4MiweVDqOcyA2rcYj5OxfMc9vRgbVIg==
X-Google-Smtp-Source: AGHT+IGNDyFoTjmMqObtlsJ6wzCrffuU6JGCq1S5/fddBkST8sf4Et813G5B1h8qgXaXqYgv3Ww91w==
X-Received: by 2002:a05:600c:4710:b0:471:115e:9605 with SMTP id
 5b1f17b1804b1-4711791fc13mr180226145e9.35.1761230183074; 
 Thu, 23 Oct 2025 07:36:23 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47496b09bc4sm63736335e9.2.2025.10.23.07.36.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Oct 2025 07:36:22 -0700 (PDT)
Message-ID: <c22daec6-0954-4836-ad78-3a3f17ff4199@linaro.org>
Date: Thu, 23 Oct 2025 16:36:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/i386/isapc.c: warn rather than reject modern x86
 CPU models
Content-Language: en-US
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, imammedo@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, qemu-devel@nongnu.org
References: <20251023142926.964718-1-mark.caveayland@nutanix.com>
 <20251023142926.964718-2-mark.caveayland@nutanix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251023142926.964718-2-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 23/10/25 16:28, Mark Cave-Ayland wrote:
> Commit e1e2909f8e ("hw/i386/pc_piix.c: restrict isapc machine to 32-bit CPUs")
> restricted the isapc machine to 32-bit CPUs, but subsequent concern has been
> expressed as to the effect this could have on users.
> 
> The outcome of the latest discussion is that we should exercise more caution
> and follow the official deprecation route, so instead of rejecting modern x86
> CPUs issue a deprecation warning but allow the user to continue.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/i386/isapc.c | 53 ++++++++++++++++++++-----------------------------
>   1 file changed, 21 insertions(+), 32 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


