Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60586CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 15:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9m8m-0006Ds-BS; Fri, 17 Oct 2025 11:13:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9m8g-0006C8-PG
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 11:13:08 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9m8V-0006Db-50
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 11:13:04 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-290deb0e643so7603545ad.2
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 08:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760713969; x=1761318769; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xbT8s7BgAOOCeKwpgykrHCA1cuKIxwsWITIY/NphJvA=;
 b=QojdqxP3ZXPSwZjjvxnrMiPqxZ8rBvZnePLDUfS8Vx+hLJvvsbFY3SleqgTuS1TDEm
 xlwEXF2DP82OHmK1Jzq1KxoY7NFFmUiLXI1nQS27QJMVZBozcq+4oNfZj9bV6ozCfSJX
 wXPRnq+NNEjHuDBeo6ck1XSWnMXP/kF5id37LZW7vHEEn73DgdwDZAXzUQ6NTw5FO/6b
 0UmI4js/m/1MtxnRFi0YZ321DoZtYDnWL5w5XtuF3C/6j1y4BoI4QSvB3iRLi2+pO8af
 QUVZ0TizdhZ5B/LZvz0xUFMNssoO+j9JE+4HO0pTW+/QzAghbmU+J25/hnLGXriz+2zJ
 Hhdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760713969; x=1761318769;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xbT8s7BgAOOCeKwpgykrHCA1cuKIxwsWITIY/NphJvA=;
 b=ArDHdvJf4A9ekdCVACR01ZOINN3n2UKfTe8r7pwX3mgNybj+/KHYc6+/Llpd5HhPkt
 a+XMnyBAAtDXO+wzLxmdcpHOUpJcDYiSgR2/n3tfB12Bbw7BY0ih79zSMpO68A471wsp
 oMtLrF421n0Wrf1ajuryWgGJeTb5xwvdwR5dcAicxR+kKA34VFto2BEGMHu+2U8DRrrf
 Ng3cnPPQxe324R9oRgEVeJ7pe8ymQVua0aS+ROXyoD2UFrnSzpil/QMNiH8qoGMQmYhY
 eNqrQ+NlaROmkQkYbkVqEMEw0nXDiHzSUN7A6M8VpEkmHhSG9C5ger7S7k9lLIT33/Qk
 0uIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAEaiAey0kOIrSZvRebiUMEQWIaSD0D8qOVnmgpbIqI6rBPIi/yenwRO03Ed9K8l+OLRz51HoZxL6U@nongnu.org
X-Gm-Message-State: AOJu0Ywyfhh/NwWFLkXEqlvtp5JT7H1PLFICWoJT9ZUoSz+jlssYQrMj
 t/T5t+cYTzUFCDf/7hRQCyajbXCFDuPLh0XSlhq83D1es+8SfgvWbz7fxGlL/f2yULhTcpZbnTi
 yCo9TsSo=
X-Gm-Gg: ASbGnctUNsEvNA0TzinCb/q5GSUX+KkTgZ3K0F2x2DyTxhxtEFN6P+YZCg3xq7fYNjm
 TW66DK3DzyX1X4nJeopIhBgCsT3L+4euyuJeGP4Rva2LjlZriK0aowTBsRmzVYZNrU08R39ymgH
 Y5eD/hkS21yUJxXKtOGX5uK0WqfHLHWLeN2hwivzfz0TyPaQ/wFFU1STmdEgcHwIwV4cpSF6FGj
 2dMf3JceQ/oDDldU9VkNI8CXvos2+6VboL4U+TlUcabFr0wfODCcmvPg6nFFbUMCmbWHu5Y1hfl
 0WrFPERjcRCq6VEFbJiERaugmgZLtrlMK+yC+VZTJ5AXYiSmIZjuK6aIW1xqJJEO3c0OW9UbCKa
 k7VqZgyaIx4zO+vTw/3tZ6d+iN2FMlRjVWbG20RcBDkSEOKDy0a4fsXuOqFP2VaN6FvvgVH9K4k
 vmeGBM0nwPdmD9XHR8j8ixr67FzTgd7Ir6t/0=
X-Google-Smtp-Source: AGHT+IHJLyfaYojF5dI1fdkvesYf/LVdDr7xZmRK0nsQgvsiFf6GtHIKJLF75Voxh+uUtjTBdZTanw==
X-Received: by 2002:a17:903:8c6:b0:290:d0fb:55ab with SMTP id
 d9443c01a7336-290d0fb57e8mr45007315ad.50.1760713969279; 
 Fri, 17 Oct 2025 08:12:49 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2909939613csm66610595ad.51.2025.10.17.08.12.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Oct 2025 08:12:48 -0700 (PDT)
Message-ID: <33f0a6e8-a84c-4071-b418-d8a218e8721a@linaro.org>
Date: Fri, 17 Oct 2025 08:12:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/10] Various testing and s390x patches
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20251016162601.442557-1-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251016162601.442557-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 10/16/25 09:25, Thomas Huth wrote:
>   Hi Richard!
> 
> The following changes since commit 8109ebdb95c45d9062c7e6e7beae0ee571fca4f8:
> 
>    Merge tag 'pull-loongarch-20251015' ofhttps://github.com/bibo-mao/qemu into staging (2025-10-15 14:49:51 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/thuth/qemu.git tags/pull-request-2025-10-16
> 
> for you to fetch changes up to d6f7f9254e333c56226bb7051e74ea57daea2fff:
> 
>    target/s390x/mmu_helper: Do not ignore address_space_rw() errors (2025-10-16 18:19:23 +0200)
> 
> ----------------------------------------------------------------
> * Improve cache handling for the msys2 CI and the functional asset cache
> * Clean ups for some minor issues in functional tests
> * Don't ignore errors of address_space_rw in s390x MMU code

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~


