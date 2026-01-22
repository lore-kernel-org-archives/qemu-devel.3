Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E9B4C44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 08:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viqDm-0004qu-GZ; Thu, 22 Jan 2026 03:39:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqDi-0004nG-8m
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:39:15 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqDg-0002a2-Nd
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:39:14 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47ee937ecf2so5571115e9.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 00:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769071150; x=1769675950; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=30f0cSXShqdjb7UuYiS8vVnSNUG5M/opPRtjOxE1Nks=;
 b=cE6jXCEyKuUnQq80cMcqnrbh3tpnXhFoltmaM9XhjJLU0UuMC9deyTNh98ajMnEfnv
 L/mNj5H367x2aQXN07vMJuI7VF1uH8BbGTHOo1IX6Ze6LpnEY/qwQx6k7YqJsFhWa28T
 eEpdkLA/KASDmXPaPfF/tSRzFVxaSl47u7N67dlgY/APZhAlU+l+o5FbSKlsqW453ZDy
 1c7o66q7v2RA2aOahJRZLozpVo1532SXynViHo+LU7inJaQPoiEhIowBM1JTK/qEFY+B
 Z21nohDtwD8rehytdRM5jzt2Sw0CoFDYMAewLJw2QCW3kYjQP76aZxS0l45jdwSQa/t3
 RKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769071150; x=1769675950;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=30f0cSXShqdjb7UuYiS8vVnSNUG5M/opPRtjOxE1Nks=;
 b=HAVlQYP5jURNA7cZSbnEVZaLzDP7vQ+p8x7CQbs6cLasIsGMCW2gX3l5Oau4zplKj7
 q88/KuaZK1OK5AXjCuLsCb+xQPuuEkRVLtoRSvHIgqEnvFbsplwwoI05UV/u0r+OJn0R
 8awg5L3nDxgXwy333drhA/ATCYJnIP00s/QK7GzycWxCX/b23Scq4PXBcuAQWYKfRDMN
 i0bZwALPEgD40WdgWzkn2qhp3QasOC9gKJ7ai5Y3Pj4wZpZG5T994ljzWrw+EECzsmnl
 TS4wZU+0UYX61NcFVDDoozeFrImhfKeqZptzSPxr2FSx1+c4zZf9tQVnCn+thV1QJdlp
 CbKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCsgDskYvkO079GHv6Ud5qURnRNxkRCZM2bZ5Nx1nTcoCq/SkmiOqc6X99S/BTH0nxpBoOKHdukmGw@nongnu.org
X-Gm-Message-State: AOJu0YxXuJZe7LR/P11taPEFhVuRMvDHIJrNzLiFad/on14aEf2ZFdf6
 aFm3XFujNyTIKEeu3ABy8h3kH4jOLiuWdiJQiDJBP0crYeQrmiGXOrlHd03PtWTOaGc=
X-Gm-Gg: AZuq6aJgXMPINemlcMDlmX3eCb9wjQ0f79nB2XbbFyt5+KrUUimmdIwTBQtbmmGFoor
 l9MorNWBP++OVFtR+QmlB1Qrg4obAK1Se9rr4uo4HXLYPYAcA8opwtYQtJ9VPKUxf0cEcefkBGU
 m8wYDNcbbqWUm2jlqHNuBU8Qmljw7JsTe89SiioIVL+iuCM1+SMXPKkRNCPm7XKlLO56oGLcdsm
 jz08sRWaqwblMWaXSn0EJeaU4CJoH4SxwITaX2nqxmCEp30JMNs8nBkuyT28dmCvgjaC8JcPY03
 fderJph8z1houxt96LgfBqGR+mYmlDIlWmV0+sdmrlD8EbQj6nieeOzzSPm6h0p50n8lpCM1VJS
 KrlPjIFWVgY2wma8e7cBiLMXgYiH3nBrpWKw6SJOKhEM67lKMZ2LPtHGypTaDXOr7MtMHVOJ4ki
 JC+7+ift7MTkiNp6oJjg5b08TmTgFVoPbYGR/BjjjF/suaipwsWsOjfw==
X-Received: by 2002:a05:600d:108:10b0:47d:52ef:c572 with SMTP id
 5b1f17b1804b1-48047052112mr25638675e9.1.1769071150432; 
 Thu, 22 Jan 2026 00:39:10 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-480424b64a8sm49935355e9.3.2026.01.22.00.39.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jan 2026 00:39:09 -0800 (PST)
Message-ID: <623a1ccc-3029-4c70-9f69-921ea7c2ef92@linaro.org>
Date: Thu, 22 Jan 2026 09:39:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pc-bios/optionrom: Use 32-bit linker emulation for the
 optionroms
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Ryo ONODERA <ryoon@netbsd.org>
References: <20260121074819.29396-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260121074819.29396-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 21/1/26 08:48, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Without this linker flag, the linking fails on NetBSD v10.1 with:
> 
>   ld: i386 architecture of input file `multiboot.o' is incompatible with i386:x86-64 output
>   ld: i386 architecture of input file `multiboot_dma.o' is incompatible with i386:x86-64 output
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   pc-bios/optionrom/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

