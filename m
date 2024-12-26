Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B629E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 21:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQvLt-0000ho-3q; Thu, 26 Dec 2024 16:25:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQvLr-0000gz-9E
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:25:03 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQvLp-0003VV-H7
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:25:03 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2166f1e589cso96071515ad.3
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 13:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735248300; x=1735853100; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=axpLL/8zFkOviCjNAAqzFNv57PnInBizEh6hvv+69uM=;
 b=XAh87Y0HRStOwOQ5zs80oBJbWmgVGAaFB9sfw0+bfNpcMOnNxBkOyg3NDPMNJlFtW/
 8hmxs4Yw1iHFeRktWxNWdXwDiXOp+W898bykoid+NtXsDX2bpWvyuouKNpRdO3E9exta
 SovKHMhKm4KJRz+9Du8fEeMqo/fuKLFg7va8Qr/EoRzioOBzbjn3g28c+v5nZkMXOYUx
 0mn86nY3t/C1PxNVobia9WHPTOrvj+jNOMfDRjSo4NeaaP/eFuzcuUJr8Qh7A88AEfiB
 JRcglAtVrp3JfblIPtIHwEu7C/X6iYFO8d0l4Xw7Ps2HuSJO6gHSJ+zOlyvUNQaze8yu
 GEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735248300; x=1735853100;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=axpLL/8zFkOviCjNAAqzFNv57PnInBizEh6hvv+69uM=;
 b=gDO8qjluLiwDbAfqn13SpEjaye/KCqsyoG/IHjI3STIp5NW7xV1pRuELnsm0JYUHm1
 qzsGfNl++bAxDownuH2Xv8gYNODcQhU2hGdvHE6K+4sPsV78aGELybIUuP06CzxFHa8E
 svHjMpJuaKMI76qNBHIsIB/nrw1QklEf0NrdVpMGwJsYIoEs3CFwJfom4y2L52sN+fss
 U58Tvzn98CS4eaDJZqpVC6yUrWBF9j3F9NkMwlB/hvNx+85DFi63FaCnND+sOzAVFxhm
 4Kn5QKa/SA8HiWpJsEubpgpxhJ0fOAJx8C3Y2IFU3mirdda4lr4dHZr+BZTQkiBCu5ZY
 vK+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFc8oZ/cGMqltjn+rEn8uJEqMeLwboNRcDxyaAsekNlQltw93WLqKxJf9F6XTA86Qg2+9wujlTF/Ep@nongnu.org
X-Gm-Message-State: AOJu0Yyou2rEVuVOC+JqOgsyDlvkS8ODHDSir56GeP3b9MaJPb4nkAZ0
 +gbNKS5eniY4uluNun3BDHzTRcPGoRysaTI6IDpfzhtifYMJvuGLXKYwqWuHdak/WfjoG3Gt4tQ
 RKIA=
X-Gm-Gg: ASbGnctDE11doM8Y4zAhUwwbO1oEikMMgZbMEgKuuMXN49TaQ2+6jGKGeuGGE4QLfCk
 zY7e/54Cip8t6I4GLL+jjITM2nVo9kxdnbm6LXuHM3+rlVXDQttkRRpUIoC0JddrKxSpHUmvooy
 oE7UFBp0Q7Tj9P0lDxGAsZl47SudWXp/H+nnK3l50VODVJaSBoRN/xklOsHtbUd4eVDs5bhOBiJ
 uWWV/a5eLHUDyLBS4OWBx/ScCqsL/p75zvqQU8KFL3F0FrVYNhZSlRNpVwo9TJ1DuWb3UlL92sW
 JjLjfPp5xZ2GipVYuEmqr0SeVXSfZOtj2vqugGE=
X-Google-Smtp-Source: AGHT+IFy75dcv062d0hLdsS98QBcpa2N8zwdH9qnWJUZVDeCQg+jbEVhlmYPfS66coYNXq4zRIVXXg==
X-Received: by 2002:a05:6a20:158c:b0:1e0:d6ef:521a with SMTP id
 adf61e73a8af0-1e5e043f6c0mr38303693637.1.1735248299923; 
 Thu, 26 Dec 2024 13:24:59 -0800 (PST)
Received: from [192.168.125.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dbb5asm13265074b3a.93.2024.12.26.13.24.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Dec 2024 13:24:59 -0800 (PST)
Message-ID: <fca63b16-9750-4116-bbb6-8ae1d3b5e5eb@linaro.org>
Date: Thu, 26 Dec 2024 13:24:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/23] target/loongarch: Enable rotr.w/rotri.w for
 LoongArch32
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20241226-la32-fixes1-v2-0-0414594f8cb5@flygoat.com>
 <20241226-la32-fixes1-v2-1-0414594f8cb5@flygoat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241226-la32-fixes1-v2-1-0414594f8cb5@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 12/26/24 13:19, Jiaxun Yang wrote:
> As per "LoongArch Reference Manual Volume 1: Basic Architecture" v1.1.0,
> "2.2 Table 2. Application-level basic integer instructions in LA32",
> rotr.w and rotri.w is a part of LA32 basic integer instructions.
> 
> Note that those instructions are indeed not in LA32R subset, however QEMU
> is not performing any check against LA32R so far.
> 
> Make it available to ALL.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   target/loongarch/tcg/insn_trans/trans_shift.c.inc | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

