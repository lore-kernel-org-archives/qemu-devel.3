Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF36EF5545F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 05:41:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv7dd-0005IO-Ox; Wed, 25 Feb 2026 00:40:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv7dX-0005Db-Hr
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 00:40:41 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv7dS-0007Sf-Sq
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 00:40:36 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-4362197d174so3986235f8f.3
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 21:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771998032; x=1772602832; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jim4xbJXz7SnPUKKC3DwQmgpGa8NWT0hYvcF+MMYZfM=;
 b=j/byASj8Ln4qu5ga7y41B9ZopLeFNV84O1hSwirVn5PMH/fG7nE6k6cMh7lmastYYg
 btRpnGm0DNSpU7767eXA8EhHGebRTq365tWxj4WFoV12bZ6Vf4rbPvYMonL7txuhN4B1
 SQgOiOk9up2pIv3Tb2W0/Ue44qwFN+0H19MEjWwygi3kYPNi3wqUC49Pdy+Wg14ydVHg
 Pp/ujoi26s3ya+TnrIAYsiZXrWvGGusSWVQdaIH9IHuKMfYM0ghmdx6dpOd0jG6sQAN7
 EIMJHvX9cVvib0w6tfvQ9XO3J8aormWmbFoMCed3YU6eLT/+2qHhOqvUagM2ioMfCBRg
 iJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771998032; x=1772602832;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jim4xbJXz7SnPUKKC3DwQmgpGa8NWT0hYvcF+MMYZfM=;
 b=GemVRXoHC+NeuVjOAaEtr+oVZhgJoxPt33QQifU2X4UQaTGZNiZy23ef0FBKyTcbqR
 Xgle1s0PnCL/0JyKDDuLsSFHWPvtutTPDtO7+X8TYS8IprIIBzf9U2zKUkwFcotEMuyg
 X/iwSqee2fft7C2b4cIVO+of4H5ck2TC5lE2JGDrfBVV++HzTLJ2qQhKBO6DKPfzLnf3
 9QHJrkqwTxD5ESa4PuxxHMaOD2StGQw5djbbT0aKyQBW5yKgEhbgMXKbQnbAhtxGQovF
 I0+FFJVK1g9Coc9Lsk/rkl/XlEYCNuWevyGVDAZqh2IWOirx0JNxoeDWxOPoflzz8z6Q
 b7Ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCU299aSGuB77sJNPnTObJsmRwl360ifKBQ3ETWx2CpMapOe4bkx3+xpndxGtTTIV8d91yqLgcf6j+8H@nongnu.org
X-Gm-Message-State: AOJu0YxbBH9W62Ha98CWCnpn1L3V6K9kiEr/D7SE5BEoSf6uTIkdxBGt
 haxCvsbhiej1rC6GwAKo8Rs2uvAnJZuWaD+XPq6CKyQfLFN/pJxqkYG7+ZNVsEDEfOI=
X-Gm-Gg: ATEYQzwX6Q6UWl4TCX40okwmmj8SKBUBNTEy36zFrNVbzp5qwUDwAQ3MdvMVLGtAER7
 TrRnDWN+MO+uJiJi0yX+gxgn8aP93O6/fFbfqRbwLItvrvWENipSFZzMCf/HN7vYllj9Xane6br
 t8uRll5zh8WRwQghb5ze6ZIQrOqfztIkk4Bxxk16gm9LpsnomWH7JwYtbPqqldRsifgrFnQgXY0
 Wzf3TVk7QDF/YaavifBtM571Xwr34trh+xVAA/DKmg6NvUfbi3DoX1cAwdi0jhDTuIFKuI9w9Jp
 2TImr1cXJ+HwAn3ZNg5zcC1Sekis+Ts1j/h57wXiBfyiX3Joc4qCY98vPV/VyKJy8GiRieaLLh1
 b4lB/yJpuB1VvKhVWcWYWDEA9dciAlayS4/HIJA7zOh3XDsRM+B4wGI6sVnAnDRjdc4mXJf+kqz
 TilwNyHJ4WWVmh87LXoG4oZMaUZwiKNqIsBreevtiOFeBSKvrv5aSE8R6io+vMATVTog==
X-Received: by 2002:a05:6000:230b:b0:435:8f18:9539 with SMTP id
 ffacd0b85a97d-4396f153a29mr26591891f8f.9.1771998031732; 
 Tue, 24 Feb 2026 21:40:31 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970bf9fb2sm32107733f8f.1.2026.02.24.21.40.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 21:40:30 -0800 (PST)
Message-ID: <54f05e9d-ba1b-480b-b4de-103b33471efe@linaro.org>
Date: Wed, 25 Feb 2026 06:40:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] page-vary: Build once
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260217095106.598486-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260217095106.598486-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 17/2/26 10:50, Richard Henderson wrote:

> Philippe Mathieu-Daudé (1):
>    page-vary: Expose TARGET_PAGE_BITS_MIN definition
> 
> Richard Henderson (6):
>    target-info: Add page_bits_{init,vary}
>    target-info: Move TARGET_PAGE_BITS sanity check
>    page-vary: Build set_preferred_target_page_bits as common code
>    page-vary: Build finalize_target_page_bits as common code
>    page-vary: Build migration_legacy_page_bits as common code

Queuing patches 1-6, thanks for the help!


