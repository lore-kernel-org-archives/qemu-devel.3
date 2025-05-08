Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEEACC3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 07:19:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCvXk-0001EF-RB; Thu, 08 May 2025 03:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCvXi-00018z-M5
 for qemu-devel@nongnu.org; Thu, 08 May 2025 03:19:42 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCvXh-0007pm-1c
 for qemu-devel@nongnu.org; Thu, 08 May 2025 03:19:42 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22e661313a3so7088055ad.3
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 00:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746688779; x=1747293579; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/a4rsERaMtwNJjYw1i7nW71MMczbfA65baLv6n2A6lQ=;
 b=ak4v9dmPkeFnVa+XzHZG739Wj0Pyu7ARp822u6ai2FFy0Q2F+0fEntHO2atbNrQvjm
 yMz0Xlu/QZ0eULWqK7DbAvTVdFCb21gFT/GjbLQOyJc6xXQpRztlrbwfRaP8SyXvz1h+
 G8GwDTwwlvPkvVwkbdtZxQaEea0h7nppRh9TVewjbSeps6X9ZDuPPh7Lm0oNOHieeLIq
 Vw8pH6W3jSnZgsOnTt7pcGcW+Y+Oh9407Tf75C7bIGM/PzehNXQV7mCVyYCHrbpYc+c0
 Cf0aCGUcJYpV9T0JQ0Tw2f/ikZnTIBJ+5+4RZGdcUw6BD+medW8w65c/wSqmdNv+JUWG
 0NVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746688779; x=1747293579;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/a4rsERaMtwNJjYw1i7nW71MMczbfA65baLv6n2A6lQ=;
 b=iaQ6uhKHMgs3t8Ljrl6kJ+vY4B6Z8xiH32OWHD2jy2cVr+2VLsr4IPvjGypw+cPXMa
 XcZh5/CX+pGRkSce4DuXt7TULqvY39DzyT+2RHwFX8D4rBM4zGcGPTNtgm0qKKvk7Nqb
 sS6Rcr90w/1Ub8n7KUrKZRaakjdwsSUSCXlcqGfl30GOSh2AcXCzwNiybFMWyQRtiTa8
 wLjkk2vgls2eyiCfTrh6C9vHkp8GPGYG8MosSpvx33Ux4vidF8EoptydVXBPhjPu07ma
 uI26vud5EuBPNd2pAqo2t/mfijUH4Rv4lL4zmZqxL7A+pn6YFtLN70fCNjDwfIaW6cCH
 lMeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLv7EhXt9p67yjZNStNBuxH76+kU8g1H4u8H87Wl2PvfH9n0HWtCIhdmkIhD7X/pzB43vCPxF+F1Ks@nongnu.org
X-Gm-Message-State: AOJu0YyccSFYeyeIBKzuUYWDdgianTLvBpyb5A6qa9haOoU+EZvWS/3a
 n78rguf78laX/exvOoPAWkk1QXKQlT+UaYvmSuPtGXurkTMx8KxAzIkwQNqno0c=
X-Gm-Gg: ASbGnctaEFOtEm7TpZ8FyEZnYStQgE/bkU5o1FZf2yBfyuuEe07vyxDQG34QSf67Y+m
 elyTXA3GMUWC2CqGpGIXkBhvo6PthN6OSoET0osAAny5h/8cbKESEOnHdZuW0Hw5D3Gse/SLshm
 IGlnHE+pGD21mkte8SikqfOJli3egkTUyNB/XiyOTNWU8fz60LZwOFbID88305flFQQol+asFl2
 VQxhxJ7s7G4MXPMnemKsairBm7oqaTbiOdTkNv/h8dce+yNP03LD6ZRSG2Bik4cTjfxAHz7MGBs
 xnUdWv0z6AsLFaH/AUmUjoYwoac+wzra7Z4WvpJ2jq0o4N1m6Ldu7qgbkBvTJp5ynBYafrM9Fs3
 iKCGIHVzN
X-Google-Smtp-Source: AGHT+IERBccKVhBKurMj5we0axJQdqL+OvuJ6snOtJe1FsbhUWANK2NXCU4mVNz0+Cwcc1lF2NCzGw==
X-Received: by 2002:a17:903:22cd:b0:224:e0f:4b5 with SMTP id
 d9443c01a7336-22e5ea27e4emr75811645ad.7.1746688779404; 
 Thu, 08 May 2025 00:19:39 -0700 (PDT)
Received: from [192.168.69.243] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e814d6229sm12277455ad.78.2025.05.08.00.19.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 May 2025 00:19:38 -0700 (PDT)
Message-ID: <b29acca9-9ed8-43d6-b111-3d9d52ae6a89@linaro.org>
Date: Thu, 8 May 2025 09:19:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] ppc/spapr: remove deprecated machine pseries-3.1
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: npiggin@gmail.com, danielhb413@gmail.com, clg@kaod.org
References: <20250507052048.90559-1-harshpb@linux.ibm.com>
 <20250507052048.90559-3-harshpb@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250507052048.90559-3-harshpb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x62a.google.com
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

On 7/5/25 07:20, Harsh Prateek Bora wrote:
> pseries-3.1 had been deprecated and due for removal now as per policy.

Please consider splitting.

> Also remove backward compatibility flags and related code introduced for
> pre pseries-4.0 machines.
> 
> Suggested-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>   include/hw/ppc/spapr.h |  3 --
>   hw/ppc/spapr.c         | 64 ++++--------------------------------------
>   hw/ppc/spapr_hcall.c   |  5 ----
>   3 files changed, 6 insertions(+), 66 deletions(-)


