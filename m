Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A39CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 08:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vENxv-0003oI-4W; Thu, 30 Oct 2025 04:25:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vENxj-0003m3-Nk
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:24:52 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vENxc-00040C-Il
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:24:51 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3f2cf786abeso499324f8f.3
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 01:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761812676; x=1762417476; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Db9JjtqkhbLfVnb0WEnEqUfufYylNJ/0J0wga1APhRE=;
 b=R22eydweAhWbmxdVliCxpGyMqqjskU3N5/tYR/7l2XOmu/YNtrjwn/6AyB1djFV9Xt
 7FHMMfgXg6RJGUdBfHC1Hk6S7GOiqMLHBFcg99d5aHYS0QEy2PNK7tbwO5aqK12dceFa
 cDd0bfYSk8n5HPwe/BbxyzR4tlEXt9S1pw+xGzZtJzYetMbwYoWF9dP4iwZOe6bzjmGT
 Y+yFfmdL9Uox0w0qskgGZGj4CU5ozFETi2FPgfWovM92z2jSm4F6pvT4lgV6NDcV7Ib1
 y9RBE7ty8IlkdFlhWIt2l/W/4OrQlu0ozhRdPxKjAtXn9XR2lSpcYIFssmEcBHXSQGFI
 Ah/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761812676; x=1762417476;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Db9JjtqkhbLfVnb0WEnEqUfufYylNJ/0J0wga1APhRE=;
 b=eOR04kJ68o1fUE4MnIRk2X2djcQRE7OxUx3CQhxDQg0lg3pXMDcKipnlK77U4cja51
 T4Au4229/2leouz+wWN17w48skhiHLk+PZcnBgWk8F54DvDixpSwHmyZdiysSYtQJBoc
 4Sp5/Auc8tKSoVVNPD80DatVdl6ZPW1ZflAK7dehRRm5HLFf37p++TJ1jFZsVKXHFea0
 a4FT5zyCZeecUQD7yi058Pt+4inmoigNgyVO4JNXyq6ud20gAl85+yfrKXYri+rks/AA
 8jghh+PXvo6TDHp5BLfVloC9zLeNNNglQoMB5dGuN83w0NX2cawRqyQ7KRUoz48C8X03
 gGBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXm1vSOG8BysdG9naSLVpKcySmswXM/mdjfTl0hiBJY/FGR56nPi1HlHXL+ONDVpXTs7PVKWadG375C@nongnu.org
X-Gm-Message-State: AOJu0YzOqNI3NB3RgB2HTRrm4k8CN8856jrxy9OpG/2ncMy2xtN9d3k2
 kIu44kbAfqZVcP64/TAv+SgVd+kAr+S19MIgV8w6Pm3ctvJaXFOihJj49QVI5zBFSUcXAw0eJh1
 4YCc3cyI=
X-Gm-Gg: ASbGncs7PQlk5jvl2l2vf2530JtuHpnZaHzeprTtJbpGwEq1kc7MLh8N/N2rbYxEo1S
 yc4PJr8N2xljkJlbVl7CGbr5xqkk8rPiZjcLt8eeGDMRF+By0tS2EmnaXFh7JptQ/FbXyb3gtQc
 HGLXcUDcJ2iRZ2dogxhB9h2rVK3WwXaK0tenMMK1aGtmgSXL8Txa7CCJYYVlj6eGa/2fYAojR0D
 npPT6FFuqYFZsIUDN2RRYcE5Sa5wEOAio4cISIWiVsEgUDvYNKFPKnPqiYt2ukqPvFewozO4HhE
 KzJs5lcWVsdToGbHohMcRxhXjisEH8qQsWnMlE0KhI34Mt+1UTBVywL1f0/V7UlSU7mcHI2J39A
 RWS3Z65W6AIsluyslt3Wyj/Z+wzOu0n6Cnu/j/9DCdtY0t3f0juzRhD8ZHGPEv4LuqSNOtArFVa
 wjAkiBST4TvmMeQe3bAk+jjbG4MTePFQu7030loK9v5vY=
X-Google-Smtp-Source: AGHT+IG2Qm7vsCOCnAhS0ZD3a4I8p+cqi4F+eDEMIod3kZYjhv/FljNgK7ZlgoKNaNKCUwR88oLAiw==
X-Received: by 2002:a05:6000:240c:b0:3f1:2671:6d9e with SMTP id
 ffacd0b85a97d-429b4c73bc7mr1721872f8f.1.1761812675654; 
 Thu, 30 Oct 2025 01:24:35 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477289a57fdsm26108335e9.7.2025.10.30.01.24.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Oct 2025 01:24:35 -0700 (PDT)
Message-ID: <5c33b3d8-0603-4a17-8303-12568b712bd2@linaro.org>
Date: Thu, 30 Oct 2025 09:24:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hw/core/loader: Free the image file descriptor on
 error
Content-Language: en-US
To: alistair23@gmail.com, alistair.francis@wdc.com, vishalc@linux.ibm.com,
 qemu-devel@nongnu.org
References: <20251030015306.2279148-1-alistair.francis@wdc.com>
 <20251030015306.2279148-2-alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251030015306.2279148-2-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 30/10/25 02:53, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Coverity: CID 1642764
> Fixes: f62226f7dc4 ("hw/core/loader: improve error handling in image loading functions")
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   hw/core/loader.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


