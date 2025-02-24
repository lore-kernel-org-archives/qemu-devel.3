Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25653C021B5
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 09:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmUTn-0004pB-UZ; Mon, 24 Feb 2025 04:10:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tmUTk-0004oq-5e
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 04:10:20 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tmUTi-0002Dh-0K
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 04:10:19 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-38f24fc466aso3140198f8f.2
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 01:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740388216; x=1740993016; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rBp4yPEblhVH07wFu5ZPD1JQV2nJja4X2k7RjEFTRCs=;
 b=Vrf++ekfQ3jf5PmElna4n2OgG+NA1Oil1ReMWU82DpoLbKRG6Ft3FxPbHM0C120RuE
 26vA8OeXI/ErerTS7HN3ESeCTrq5H/xpRT/02n5cUXta2dKtZpNSO6l7/UQir9VFFmNc
 vn6Mov2IAWP5ZrBlJfsY3mwSLBPyr7UrFemShcWZw3lboA3X+be4IctppH6qH48gpW08
 sf8NJhuxJI8LLGAfaRA3IGvSvhE8aXO6CHEt1/NQ62WRQEsZK536spj8VjOCiQt7jNxa
 6dgyPWXQ+f7TyZu1FJkUh8HwhsXLhTDQBo77DQaReDgOOhgE8JVgud1wPSMkvfc6etUW
 cBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740388216; x=1740993016;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rBp4yPEblhVH07wFu5ZPD1JQV2nJja4X2k7RjEFTRCs=;
 b=UZoIJX7GcI/mYwR89RYr+PkSHp7f1mFd8C+FxL4+ydNCyG3tT39Vz7mq3JRlhUasYO
 J33l/R8zxgD2zNGm+FsJemy4jfyx0qquI/sEOGQfUELsQCZBzaDqYo00JQFrTmUcO0jm
 eOXH0R1o9UVnWJXT2ca4PkJzb15CLD0dsFh6rns6C+FmucWkpMJ4qnC0r/PVZ27N7qiI
 Jroi/NNedGDaaox8etszfvnskjc3E/A5Ajs8lDEty6iDJ/IjJiXmTHGIQlUlooxa33zZ
 JBj4uaEIZHBm9fZPIrwR+a3mCLg2goOuuE7QNOay9frrKfPSb3BEt2YBLUXH2iJ/jmmz
 B5XA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLP3Y7ZPJYU9z7tdwlsOAGO4FfCRpuQRcYbJoHF0+UejsR63ZHhk+NJGK2rzajEEif8Qs0GbsueUME@nongnu.org
X-Gm-Message-State: AOJu0YygUARLbZTDGIyZkQvfQ93Xowk+UJrgOztINVv+01bgii+r1jXS
 MEcOO46y06ags9mFMI7rxXX7Gf+IRbk/Sb5oiF+lT3cX6AZBfdk2giwZIfhwGgY=
X-Gm-Gg: ASbGncvMDz65PPIFZWwhk2bsFRsIzIbLRQWETtEjAA91S7j+my8pVWYUMLSrVBdd+/B
 bWGO6JvO0ex6m5rqfuN/6+WpiO/qV+iz2wgLVF853CKMp4UOU2J23zbH5D7OjTVUvCyN8BwY/IJ
 z8dlDy3vhckA8gPIIyV0y2NuSfLdXnQBrXP46go8oGW5zhdSlV3uhRMAC4CvbBiIWFHwQvNYA34
 rSyO+QBVli2isg13saADuHjOYvIcxyYf2lK2SrqvBYIa9lRuYIvx6iyfpAvnWSEa9aCAe4HBoW2
 Q1bAyiLn6NVSdHPHlcZCdCukKYHwUMBqpNXxxicz0fp4INIlxxtXHPDwDA0EiLVX2IUBGw==
X-Google-Smtp-Source: AGHT+IEhJTzpGVOGrSUrN+F91LdtAOWD3+jt913nTQ7ahLpZZeRV8pEi0a4qPkoIICaIn/XbnBhd9A==
X-Received: by 2002:a5d:6da5:0:b0:38d:cf33:31a1 with SMTP id
 ffacd0b85a97d-38f707afc79mr10978359f8f.23.1740388215824; 
 Mon, 24 Feb 2025 01:10:15 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259f85c2sm32010021f8f.91.2025.02.24.01.10.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2025 01:10:15 -0800 (PST)
Message-ID: <befaccff-5885-4e8d-a397-29df6cdaa7d9@linaro.org>
Date: Mon, 24 Feb 2025 10:10:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Building QEMU as a Shared Library
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <PS2P216MB1388380FEF72AF5916FD9B59CCC62@PS2P216MB1388.KORP216.PROD.OUTLOOK.COM>
Content-Language: en-US
Cc: "amir.gonnen@neuroblade.ai" <amir.gonnen@neuroblade.ai>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Saanjh Sengupta <saanjhsengupta@outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <PS2P216MB1388380FEF72AF5916FD9B59CCC62@PS2P216MB1388.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Cc'ing our meson experts

On 22/2/25 14:36, Saanjh Sengupta wrote:
> Hi,
> 
> I referred to your mailing chains on suggesting QEMU to be built as a 
> shared library.
> 
> *Change meson.build to build QEMU as a shared library (with PIC enabled 
> for static libraries)*
> *
> *
> Could you please suggest what exactly has to be enabled in the meson.build?
> 
> I am confused on that front.
> 
> Regards
> Saanjh Sengupta


