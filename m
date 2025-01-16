Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 951E8C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 17:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYU8L-0007Ma-Ej; Thu, 16 Jan 2025 12:58:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYU8J-0007MN-QD
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 12:58:19 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYU8I-00063b-9s
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 12:58:19 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2f4448bf96fso1773913a91.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 09:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737050296; x=1737655096; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cQDGLtJz1KxWkOzCjDoPmb8soPZ+1RDEZfaE9cfhiOE=;
 b=CqPzIYhpvoS+jXm3aCyJ/0y4aU+VJ5tXz6LbVBspNgI4fRR4abd1w2nBIK2Ikuoq2D
 3Hjg23RT65JLP6YYgMHoqIF0X3txS5ZxzOjkP0z1DsfKTE736w2Zjxqp3YJ+WE6EXlNX
 bRvaTGtZxJeSKKh5Dp9JQr+V+PW0m0zZ2JbNZIERMTIg4ikMTfr4VR2ZyM/1o7gIU+yp
 R1+n/BXRMNxJj+p7CTqmkEnBGSANZoAFcbg+SuCQ7mAebqbaeik/MkGC6RHv4c3H+nLN
 24QdcGwL3wDADnNUTG0GF12jvU6a/tlsh6ZK0pHV09BZiALR1Y/4XkXDmWIQmo3uIliY
 B5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737050296; x=1737655096;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cQDGLtJz1KxWkOzCjDoPmb8soPZ+1RDEZfaE9cfhiOE=;
 b=bxu1ACaS/wXW8RHAB3vpfzrQV4j0S6OP8dKqaI751QIBE0pyiaS6Bat/7a0XLY6Fp2
 ZY2Y8FnLulnuH4XFcgXVevmBfMB7FqrPmNhUaUx0tWeTYMUdIwDTNHgTIv54/6oZsUmT
 6Gg/Ezdxkf164GbcLvl494pQcrvrQywx/4Zlx0huS0A3nrviufhi9ire6Z7yButd/ndY
 zFqza/+HrrjHhyZEzMVU1keVaxe8g5XmmGzsTR2yQb+bz1TOQBK+26KnA4Dr4crPqp9J
 /R/a1R2EAw/nX3rDQY4CnI7mVFbDLCV0+oajn4vM/gLt0TLgn3+p2ezTQDvcwi8xgo55
 RI7w==
X-Gm-Message-State: AOJu0YzLIDvyab5qBCwJds0sR2tsiq2nmj9BHn1WURswD4Z59BV4HX4m
 K5jZ0Ncy6VbqrpWDX+MOZ1IDLcIfQp/0C64wO50Bq90P4bxd/ZAB1UX3mh40CeqFBwyB1vaj4BF
 9
X-Gm-Gg: ASbGncsfTYvXEFqNxBDvSyUD+4SMHk3BDVMxqCP9TnlHZ3L2bFiLOJpQsWlBTqonB8J
 f/+mRo2u4YCB7gG4gbrCu16H7mNgE920oVM9yLF5U3+GN55BJtWSEK5rdhtzmrh1hNqSSqhGdzE
 u8hZY5wTEz4ZHrEjrIXTJtAsmEvk6L2oEchfw0F1NNKCbADlsLnFCMiODyzsT0jRPb8sVBAC2I9
 tFrknOF4NKBey2ZsLGCsTTIXytK6o3w2hKELGA6tPoQbyowzzZKRp/IPR2CDw2FGJYDiDpi+Gj0
 v8nkvoEC/4+XQ6tlFKqB0x0=
X-Google-Smtp-Source: AGHT+IHCkLEVh8c7RNbKPJkXhuV2RJIQT4dJ3FJzqXTHvNhV4Pf0HpZeRPsAYM2Caci05tmi4kDlzg==
X-Received: by 2002:a17:90b:3a08:b0:2ee:dd9b:e402 with SMTP id
 98e67ed59e1d1-2f548eabdc8mr59387114a91.12.1737050296646; 
 Thu, 16 Jan 2025 09:58:16 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f77629bf96sm432932a91.36.2025.01.16.09.58.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 09:58:16 -0800 (PST)
Message-ID: <7de809b1-d3f6-408a-aff3-4540e04140fe@linaro.org>
Date: Thu, 16 Jan 2025 09:58:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v2 07/13] hw/arm/virt: Remove
 VirtMachineClass::claim_edge_triggered_timers field
To: qemu-devel@nongnu.org
References: <20250116145944.38028-1-philmd@linaro.org>
 <20250116145944.38028-8-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250116145944.38028-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 1/16/25 06:59, Philippe Mathieu-Daudé wrote:
> TheVirtMachineClass::claim_edge_triggered_timers field
> was only used by virt-2.8 machine, which got removed.
> Remove it and simplify fdt_add_timer_nodes() and build_gtdt().
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Thomas Huth<thuth@redhat.com>
> ---
>   include/hw/arm/virt.h    | 1 -
>   hw/arm/virt-acpi-build.c | 5 +----
>   hw/arm/virt.c            | 5 -----
>   3 files changed, 1 insertion(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

