Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28CE9C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 21:16:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfmkw-0000AT-9t; Wed, 05 Feb 2025 16:16:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfmkb-0008U2-GQ
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 16:16:07 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfmkY-00068D-Hr
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 16:16:01 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-38db10ab86cso139352f8f.3
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 13:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738790156; x=1739394956; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fB7oBBMNYqFF9UVX1VnLN9On1lXy2OqeBwDGd4G7qis=;
 b=LwWUysEa3gskgGwxDEWGQ7Xj2X+Eb3KIJf+UwI0r6gb1l1InmQQA4Pa4JeG+HfGrDj
 j1L0Bcl05vP0fMQw3LSEQmiDSGQFSS+QPH5KDL4AdbJ9ccSERFNWDn88N4U+ACZGJh8y
 E/lF7MnVCJa8dojOQlIAAxzvc6p/yPWyEinqYfaFsW46HRbpCIAOebA+EJMqfZKn56Hx
 JlcbFaOWJKhLM+3HJAVL8xmQ2GCPaaU2cyt1zJdRIYndoq+0a1wHVy64acv3B7+0P5/i
 cFfG6UJ2NZb8bO0zuy676/hKVlL3xrh87YCjPxfayVD2628s6zWpYIs0YXDH+AZYDshD
 qwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738790156; x=1739394956;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fB7oBBMNYqFF9UVX1VnLN9On1lXy2OqeBwDGd4G7qis=;
 b=SHgGPCkPNGPZJ2hxKrTfrPxdtaqbGqpDiT72gZLjxxzblhgjWMkm4bUOFYNiIl7Ajy
 TV/Jyf3XQ2tFPyoJEgcqvc1swp+CSg6I23rZncqxW0PIfjFDLESiIluOFdeVwZyvKsHF
 drMFiBeq3rqPOplHXNgSKaSwBm81eaQSy3uAR2gDjc8EzZoqQw4L28XM5iST3aPu5NX3
 tMIFiLmFUGmsJm0SDFg0MgPjtSyHehtNckVmIC4N02Yyckb8681DlE0KSbOVVPpv7cW7
 k0wgPzO2msLFXOmp7NH+9ogWZOPUzyr1qtME8aLCVVN7JQYY7U7kOxuEVtQXI5kJkV3s
 9QPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXh8z3FTjCr/7nTV7FIo1rkD2IX270a85FVCXyUPiQ4ObrAIjyXQkJHNfIO432ENRDdujqvAd+1bRxi@nongnu.org
X-Gm-Message-State: AOJu0YxcXOJOLWvB9CxVj9WzhoFJt0ee0nsm8qBUHjLr702xsVJCJ+sI
 uiq2eHx38D1hfVkBqE7u/76ZvHDPBAMD4JFnBSNh4z0+lfXb0lbhytjmpTd0ln4=
X-Gm-Gg: ASbGncv3nra4BfEyEpTzQi8K31h7YWnR9aZbtHBeX7U3Faq3V1mvPGwyE4M56XdQL66
 NvpatN6dtWS+8lmWu00NzRaWZg2R0W7m+zMJ0R5ePCO891uBGdavMicQ95SQSoDVS6UgOOrXI2C
 4ugwG6UyMM9a0Wc0pakehNqWzypT7aW6vjSrzwhD4WMMfsgt0Rfsbz/qBYsx7nKmlUr90saMuyl
 /GE+YTIQCEADmbtv5p79iK4Irx22DUJcvtMBtLlIY5oyfjIntl9Z1BxNh4pYkSw10JomaZlDl7N
 s85ya1OdhU6LHURfHCCma2jvOpBvrvY4BZKBKkiInodvH4T39vaIaAZrCmk=
X-Google-Smtp-Source: AGHT+IFQEug11VFjt9/OFnCrcgf1M+CZ+vdH68fFgk6TUrBnTCnUjuak83bhzbB+zjY0gx6+YuxXWw==
X-Received: by 2002:a5d:5887:0:b0:38c:5d42:152a with SMTP id
 ffacd0b85a97d-38db493f635mr3974852f8f.35.1738790156675; 
 Wed, 05 Feb 2025 13:15:56 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c0ebfdasm20052660f8f.17.2025.02.05.13.15.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Feb 2025 13:15:56 -0800 (PST)
Message-ID: <1b058aa2-5156-467f-939d-010c339bfc55@linaro.org>
Date: Wed, 5 Feb 2025 22:15:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/12] plugins: Uninline qemu_plugin_add_opts
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 thuth@redhat.com, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250204215359.1238808-1-richard.henderson@linaro.org>
 <20250204215359.1238808-4-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250204215359.1238808-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 4/2/25 22:53, Richard Henderson wrote:
> No need to expand this function inline.
> Unexport qemu_plugin_opts to match.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/qemu/plugin.h | 9 +--------
>   plugins/loader.c      | 7 ++++++-
>   2 files changed, 7 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


