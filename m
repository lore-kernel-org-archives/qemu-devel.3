Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F18CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 20:11:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAwDu-00087g-Pt; Mon, 20 Oct 2025 16:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAwDo-000807-GL
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 16:11:12 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAwDm-0002Re-It
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 16:11:12 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47157119d8bso6099565e9.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 13:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760991067; x=1761595867; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=udOCExQewwd3CaZbAZr52+GtbC5z3HS/cS29PVWvtCE=;
 b=nkCS/XtXm5IYrDWR07WgYaLgyBDr9XyCnbbA+VmMCaM+kaiJKa0l9YjamTPvisBEXo
 d+neFMGDl9Bqbd1lLXk85qBc7/P2ZWvTrsRtr9KBWeAR1u5NiAqYduVzGPgLpLOfUEbI
 n4GngBdU6rKWHPM8cbHdKbIIgSnSXWR5zsRYilyqGAJGCOoKrbeFNuT9pIvhhbhSW+YP
 t3sVT0k49Atx/iXQ2EipHMYbtLlc2vUNu5fKwmZwaJIByXqlj3RwnNhKy8oe4BlJHFI+
 aaXzOBd6i5T9AeWU63z/YnDUXTpP7xlJF8r8Gog+xv6bE/ZMRFWGRgqFXNCtG2Vmb4sb
 PH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760991067; x=1761595867;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=udOCExQewwd3CaZbAZr52+GtbC5z3HS/cS29PVWvtCE=;
 b=FW1eBp4IjRigq0mowAAGRquFoS0+rg+lyOiMoPPTJGvfBaQ8sWvb1YnLRGpPUx1v4k
 Ir2/E0Enh7qRAZ4fj1bcxm7LyozB2lH1xt23yFTTpX18o6eGUZ/k5EtM1nWEKQIBJWAi
 EE4bTpZ8qrRpHjU80qVyjl+jKtScjkCg9wnDSCVwO/o0QKAOQLtxYcUVpPRGpOJziqix
 e5eSCB5v82Rz8v966Thi26KaaxuAvj83fJUThyl6IDElZy/JXEIlitx93NyYs4Dbm+nS
 Ha8KVj74VH8YZo2w1EDm2iKeJBYActANtCHb2wOrO1hVQeP11VtRIFl+RZn+0X4MLLMR
 +4gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWL+KkEY1KXAxOS4XnjklCDWj9OM1JSpuXF53wXT79KRGycw5XldrHXzc7NrmAN9qxJaNVJhcb2JTgC@nongnu.org
X-Gm-Message-State: AOJu0Yy7mmI9oP7Y14/1lW93lktkoWaJ35Q8YuPAsWruZD6F9W7yZ4Do
 w6nbANeV1E+/xIhEfBL7qoH2eeOAiqwGDVjQCO4vweZ4HDls/DeVVD98RYhekjzm3fnPkyIDB8d
 g1L9xPkA=
X-Gm-Gg: ASbGnctynkhJwMggRcw+AJmb92EdN4FJmaEMIgZsnD4m2ccTnMjAYXQIUDsfhMixxmV
 9dRyGy0XMbu7/rcIMwHJtF8YQ8mYVCRZlaSZpywl3/MN25VYxfMsbyqlX8dg4Z+MiuqaHuQj3NA
 ICWCt6BDW9cW1jXSqGCNmB7xwxKz8weiPr1UXmPxJUcSAnJkIcCtKFNlIFcMPuzVsQnGpn1IqUS
 d+fas1KHRTBJJ+bckB08XKQKWAeEXI9p60VwYLD+wfILeu88TBYm1MmMtYypRAaKA9JDErVu+75
 IhkwielD+gIYkQtiQ9Wc/K8zExU14qXAqznYg1fQUvP9z0mCedioyQw6/V0O7tAAnpcDL1yLBho
 JF4cdeuRAxPK6Dj3/x1MjahB7LJpn875f+n0po8FbzmauC4Z6fM3r8do/6TbKvUearlzK2eWtj8
 SKOB0eyWSvwsM0jKErxkCv55GJlVvgOXFjPGxk8yX+DhU=
X-Google-Smtp-Source: AGHT+IGqjsF9EaDj8YWpbMkjc4OAISq+5DEVNGiqOYHvr0wzYbP7p4m4m2gUPrffRH6xEtyX8MIjPA==
X-Received: by 2002:a05:600c:4e11:b0:471:c72:c807 with SMTP id
 5b1f17b1804b1-471179079c7mr117597675e9.22.1760991066799; 
 Mon, 20 Oct 2025 13:11:06 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5b3affsm16652537f8f.12.2025.10.20.13.11.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 13:11:06 -0700 (PDT)
Message-ID: <f3f2e107-1336-426e-a920-be2f5a433e1f@linaro.org>
Date: Mon, 20 Oct 2025 22:11:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c/smbus_eeprom: Add minimum write recovery time for DDR2
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Corey Minyard <cminyard@mvista.com>
References: <20251008122502.9DA8956F301@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251008122502.9DA8956F301@zero.eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 8/10/25 14:25, BALATON Zoltan wrote:
> This is needed for newer u-boot-sam460ex versions to pass the DRAM
> setup.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/i2c/smbus_eeprom.c | 1 +
>   1 file changed, 1 insertion(+)

Patch queued, thanks.

