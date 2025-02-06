Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1285C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 20:48:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg8nT-0000hl-LY; Thu, 06 Feb 2025 15:48:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg8nR-0000h6-JG
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 15:48:25 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg8nQ-0004Jo-13
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 15:48:25 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2f9d627b5fbso2392600a91.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 12:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738874902; x=1739479702; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4yMuK96oSzFEvLcXBa/MIupHQHR0YlYv9/iA5+NQqjw=;
 b=i+igSp6toS9iL7WvisxAVPr4+XN2MRmExpyjetK8RdanePnncewvtQVMboH2TcQxml
 tyav6HcU46l1vsQSI3CUBMMzbxX5I8npDjzQ0qsSf/tNcJD9QTx9VP8uN93pLXB6Eup+
 QOgfrZDhFs5fsbNGEHNfiaizAl2a8gmbvUsZG+2o9+0HFmuF/7XvV0a6Puc5CkV3tz3g
 Wkag4/0xD4VDJo2sTxCzVVqfm9LoFwAvQyu8OmCjFRFYAzw1f2oOJuHcX6fllz6aTDUp
 GhnLgaInYtdVOHcvV5ByWEGTjaQzTuxXxn1LGXAtjO5AdRZHwLGYHK4wN1zR3XmZOnlf
 bzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738874902; x=1739479702;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4yMuK96oSzFEvLcXBa/MIupHQHR0YlYv9/iA5+NQqjw=;
 b=opFTmIRQsP61FaT6oNr3idJwxW1lgikAM3W1mu45nkCOqaQnvQZq991la/zCyd9Kxu
 BmOigmzvOt3JJO+HTmVRRaOrjASnrf08k03JqmlY6l+80o1K3dovCiL/BpqEtbL6CsFb
 UIbPxI25aGhN5jEGL6sfx0Lx5nUc67wDE47A/ykw2DUeMXn6gwwCsLhECN1cdZiNTMbn
 +lnECFjoOf/EtxzP/DdhjI/+8vDxCKDZwaqVogJxVaI90XiVuAPDmHap8Vc2+gJUCS/1
 V/4KMmCWc5jOhzepFTu6chKPDNZBmLi3f8MmBcWYJ5grS4ekg1VlH+liPk+S6a32ZcA8
 DWyg==
X-Gm-Message-State: AOJu0Ywws0kkBsTbWT65Z+5Jk9AMLAwJYOWUebf6vdP+PiNy4bj0Zvzt
 mr5kizmphEEuRT6cljOVe1V9GFP09beGNaolrB+xzRiCQ7DqKAws7WIzzYHCfxZnQ7a88W8mtN1
 /
X-Gm-Gg: ASbGncv26oe004oOUZ6hDIzBKGxl/sBV6ejLZBUIuuQWT8idIlx8Fr8Zj4ziNeqk4Jt
 tF9l5v3qMgKxS89cBTexdl1kAHhpP7cKzYCacd1cMDv5rVP5Wa8rFe70HB7Jtmu0nEs93c/jQMm
 VjzUo2ymDIWZBYzv8bOB1/BX/ttksWsnthZMBF3jSuIsVsa5f7WcIcYja0oppJ52vkv9qBedtJz
 OkIvI4BOFCgudYziUlXiwph4GE5xrVgH398PkBgzu303L/ivI5Ti2SeVeFsRy7M9FVxYUypGUOH
 VFd5h/L9M50igxUUAUH74Bd44Jkua642fmAoon6udVtQDoJqAkEiXpQ=
X-Google-Smtp-Source: AGHT+IGCwlM5vceIEQMNaIBsEMa3o/kYUc+Uz7ddP16PQv5gcJqA2RQKoKHhZ8Lwfob4/qugrNe1hw==
X-Received: by 2002:a17:90b:38c3:b0:2f4:434d:c7ed with SMTP id
 98e67ed59e1d1-2fa24177361mr870178a91.16.1738874901851; 
 Thu, 06 Feb 2025 12:48:21 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f9e1e23766sm4071434a91.33.2025.02.06.12.48.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 12:48:21 -0800 (PST)
Message-ID: <2164915c-89f2-432a-abdd-1b131894f48c@linaro.org>
Date: Thu, 6 Feb 2025 12:48:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] hw/openrisc: Support monitor dumpdtb command
To: qemu-devel@nongnu.org
References: <20250206151214.2947842-1-peter.maydell@linaro.org>
 <20250206151214.2947842-3-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250206151214.2947842-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

On 2/6/25 07:12, Peter Maydell wrote:
> The openrisc machines don't setMachineState::fdt to point to their
> DTB blob.  This means that although the command line '-machine
> dumpdtb=file.dtb' option works, the equivalent QMP and HMP monitor
> commands do not, but instead produce the error "This machine doesn't
> have a FDT".
> 
> SetMachineState::fdt in openrisc_load_fdt(), when we write it to
> guest memory.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   include/hw/openrisc/boot.h | 3 ++-
>   hw/openrisc/boot.c         | 7 +++++--
>   hw/openrisc/openrisc_sim.c | 2 +-
>   hw/openrisc/virt.c         | 2 +-
>   4 files changed, 9 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

