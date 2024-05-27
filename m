Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 666FEC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 10:40:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBXle-0004Tw-3H; Mon, 27 May 2024 06:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBXlb-0004Te-Oa
 for qemu-devel@nongnu.org; Mon, 27 May 2024 06:39:48 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBXlV-0007sK-Vz
 for qemu-devel@nongnu.org; Mon, 27 May 2024 06:39:47 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4202959b060so78261695e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 03:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716806380; x=1717411180; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xmG0R/2DS8tqb+myHKEPgeBhr5FMrm/W+Y/U+NssdEw=;
 b=th5ZuQoFmwEV8PtvxeKUTxfXOO989CsIE2Q3XwKiNBHH39+zLi98Z35cEUpfNj5clh
 Ms9wvOSDLJ1DF/JtVVRzQnOo4vesgdbHC5yqWOgNk2VVWjX71KQnmb6aegZtg6Pn/U3H
 nQ8WZ/49OjRlVh3ILrub0q2v5DqdfmGSVH+Y8WTEnpPFCUMHufvvWHQFaIqQL7haoF7V
 gcWJCQVCFUAm96nHRN7y/C5c5wD/i+xnRqkSJCgja5XlKeNwTQQpV4tk7VZ+D6QlOOtD
 rVB66yaqECabZnanc5WWzqyCagQUWp3JA3W7cVg1jp2KgVPrmsFZ8/DV5lgfb2n6F17B
 tM9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716806380; x=1717411180;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xmG0R/2DS8tqb+myHKEPgeBhr5FMrm/W+Y/U+NssdEw=;
 b=ZA2mWOCz5Q0jihboju4ztC7+5/90330enW/yNZKzMkcdxwQJcfdwqq1nRz7D8/FRTk
 y0nfmahyfH+y0uzCwnCbmpUVLfwfSE9Q/lNfMDilbNAAQonRGMbKCcocABiyqeDn03ye
 iPnDr8u5LqEEIJsYtgH6xjkvTlayeKwF48sEHh/vzVD16HJJLgjKvss/r4Eowuw4hEyR
 oq8ye9VXnKqGe32JW/WJBt7BAipBIF2Xx8lUVckC2VHFCuQPPUyXzyoQHKNH16kbcvP/
 dSMo/lz/MsUWjk5lT+R6lJwVWhPuf5q5XvHcjs8+LmNWp5DHoMkMP+bSLcYc1H4A6ke+
 KAUg==
X-Gm-Message-State: AOJu0YwJrJvAC3A6C7RELgHIsmnoP4/5xS9giGlRBPPTk1GVs8aOKMUt
 gGDmOanow0qdU20HxwBYzB+yYaGYZkb8YsQdFlkYpTwAPhPbHcvuSOhnmL9sXJQf0pUOdcgUDhq
 tERI=
X-Google-Smtp-Source: AGHT+IEE+ONiE2E/jmDW7kosAvE/V+MKIT1nKWrZ/t+2rRdexVjivxVj59BLx9oS2vdBW1YBJaaF2w==
X-Received: by 2002:a7b:c00c:0:b0:419:f31e:267c with SMTP id
 5b1f17b1804b1-421089d18fcmr64493965e9.7.1716806380064; 
 Mon, 27 May 2024 03:39:40 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.152.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-421089ae866sm104392455e9.34.2024.05.27.03.39.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 03:39:39 -0700 (PDT)
Message-ID: <83153da8-79e0-4cc0-b9e1-918cc5bf7f87@linaro.org>
Date: Mon, 27 May 2024 12:39:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 0/2] target/loongarch: Add loongson binary translation
 feature
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
References: <20240527083501.844854-1-maobibo@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240527083501.844854-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Bibo,

On 27/5/24 10:34, Bibo Mao wrote:
> Loongson Binary Translation (LBT) is used to accelerate binary
> translation. LBT feature is added in kvm mode, not supported in TCG
> mode since it is not emulated. And only LBT feature is added here, LBT
> registers saving and restoring is not supported since it depeeds on LBT
> feautre implemented in KVM kernel

How do you test?

Thanks,

Phil.

