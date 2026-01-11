Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18158D2502F
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 07:55:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veqFC-0002O3-0y; Sun, 11 Jan 2026 02:52:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veqFA-0002NF-Lu
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 02:52:12 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veqF9-0003CP-5L
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 02:52:12 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-81e98a1f55eso857513b3a.3
 for <qemu-devel@nongnu.org>; Sat, 10 Jan 2026 23:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768117929; x=1768722729; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n0SFXkoISG6NsAIfzxRUSL/gLvupl+JhIksZ4AXlC5w=;
 b=Z63ys/KTP/Rfw71hIQNB+FnZ/jFGPEgJOKYbBiBDViG4LOts6vUw1MQnrP9zcvK80k
 v6nhBl76bhnYZ2icQEubaeNnKYSPri8x9nPCu2oUvuxnrvINlHszQMUhSap43iu5zzTn
 ky2cWtfozoy8OrQgX0O6W58lfh2rWVO7lbTqzoH+JiHEzNF24lPzDjt6OrcztK0PYNH9
 XcY8q1gZZw64ozRGekvfh63TiUzmFVFjUc224QnW8vkmM3IBzVZVngJ9CRIYZY9IdE74
 PfYAb7lJcynyNzKhwPtpLN7X8m4YkDBzTh3qj+1xId8sUodANVvnJg1kxWCE4LL0SrLV
 ecow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768117929; x=1768722729;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n0SFXkoISG6NsAIfzxRUSL/gLvupl+JhIksZ4AXlC5w=;
 b=n0vcM0/MeIBFnOr+nEDJ8fmFSANKESlza9yuJM/ijuiHTaiyiejuux6y7e8UxHXmC7
 60ImylYINp0g49Qr2xgNnK+J2vBH+UFc7jmUODlD4qHge1Wuc20zpr+7x7LlLfYmf3hK
 vc6XBmPWIhDz3Zs9BN/K4Mc8bUl/QElFRI6IMvS3O8y70Cyf8hU94v8/xMP9ZVZb/WIb
 et7zAEMmnr3SY5tH3U+cCTJRAYSmjb6pCofCmFfImm9MpNCn2QtQE2Tex/eRGlA7bY0D
 J0m9sDk60whtdkjMpa6jKAyp+Lrut+cUEY6kNw+cB6bxaZ+lrqLMj3heV1JD/hdtpRig
 noNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0iDTamt5WzDdyKcRHe1+1JHXnTKXv4uOISMC5jLpVora4wbGgHiXJ26pH1/13fsmY20AVoch1TkPM@nongnu.org
X-Gm-Message-State: AOJu0YzRoe67wuToUgDesEGM1JV4VhVbTXdNUGLleO1XLLEfNhFXVpBe
 Iv080yKpZ0mMbKIxuB2RHuDTG4Y30jXe9G0mLn7iHxhdnrF8CBOpa0GqZjvx2nK7X+k=
X-Gm-Gg: AY/fxX6tsSssk4eweNnO9WlxagnVHXKAlVbszFcfwECo65D58zgszP64EN3RmEJinVq
 Jqw2jdWSa/zIhNJDTBW7lrIckbolTlrZwh3lPulkntIfuYR4wqo/KF26/+VqBXV78BZwtfZoxQh
 UE4grvuNbSNEEGbd7+XuIo86BmDRXGmJYx+dfS0FqoiMLov8NxfJe0RUzUIJwGJnJuAwnoEHcqZ
 Jrr/mV4MUSvZB49k98BhPmdiSw2Eskxr6vPGoZNTnjpRivLCl8OLAMsGSCTITkpTAnKJ4wsLJGP
 V3HJ7FGZYaoDsNL7h58ZQNkvBJgKbTvApgT/g+v18bRmBkdFjMmUULyL07aLzsxYzeeiUVKZ5xy
 pTgimnjhckKTUixfFWbG8HUgJf+YK9Ak1DBJ61nDLAnUCinDGQUDxUZmtHL8ZnpkbNrsybXiaTY
 RZ/GGcP0S+Y2i+kmIDXhoeKlXYiQ==
X-Google-Smtp-Source: AGHT+IH50L4WmoUuKvH20XCUYidoRffb/NAShZbm3862wRTMYETh4oJF9gC4NShSfv3yp2wPmPlpJA==
X-Received: by 2002:a05:6a00:908c:b0:81f:495f:8056 with SMTP id
 d2e1a72fcca58-81f495f82cbmr1865867b3a.39.1768117929185; 
 Sat, 10 Jan 2026 23:52:09 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81efe4a95c7sm4285118b3a.37.2026.01.10.23.52.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Jan 2026 23:52:08 -0800 (PST)
Message-ID: <6805348d-6b62-42af-83b8-555e0fa909c0@linaro.org>
Date: Sun, 11 Jan 2026 18:51:59 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/12] target/sh4: drop cpu_reset from realizefn
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Zhao Liu
 <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Yanan Wang <wangyanan55@huawei.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Thomas Huth <huth@tuxfamily.org>, Eduardo Habkost <eduardo@habkost.net>
References: <20260108143423.1378674-1-alex.bennee@linaro.org>
 <20260108143423.1378674-2-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260108143423.1378674-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 1/9/26 01:34, Alex Bennée wrote:
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/sh4/cpu.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
> index 21ccb86df48..1dd21ad9ed6 100644
> --- a/target/sh4/cpu.c
> +++ b/target/sh4/cpu.c
> @@ -255,7 +255,6 @@ static void superh_cpu_realizefn(DeviceState *dev, Error **errp)
>           return;
>       }
>   
> -    cpu_reset(cs);
>       qemu_init_vcpu(cs);
>   
>       scc->parent_realize(dev, errp);

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

