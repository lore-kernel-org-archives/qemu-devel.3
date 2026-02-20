Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1DD0C531E4
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 04:40:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtIIk-0004Zt-DH; Thu, 19 Feb 2026 23:39:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vtIIh-0004Z8-FU
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 23:39:35 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vtIIf-00080Z-NV
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 23:39:35 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c6e1a67d4b8so955737a12.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 20:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1771562372; x=1772167172; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YbRLhNqGTklhHOZdmFEopLm1uA1LeLca8Se4eHj7tSU=;
 b=i2VtniyES8rbg49BCLI2tD0oQsJjTow+tNnv9PxJuztpVkMiyFGsCUT0sfUzq01cXF
 IFHSo5uMDMapNFsdvrY+HbnytGfsym1+9wiD/Y1yNNJwOuzYsj3urJS0hcT3zEO/DvMC
 G5pILv7BsW63h/g2yZpfIRgYfpv3BzcIM2/5FRuqwUIeCQwmviBAK3qpg4eA+5Y//Agd
 C7hLT7xtu8SBzK69MbGN6gLX+kslWVnDe6ZvPRHx4icFpIrjI2DVHadrLycZd9cz7zW6
 iO5lWmI5NcVRvNDN7VLP3ORoTdOibUGKxLhCChs9vanyUOitK8Uid9GCgwCvrFfF61z3
 HjMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771562372; x=1772167172;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YbRLhNqGTklhHOZdmFEopLm1uA1LeLca8Se4eHj7tSU=;
 b=konzNyXhQjdPWAj8q1cGDMiWb6eAf8W8Sx5MmuZs23t44C5kcF6IHGp5sgUlORnSIP
 S6L2HqUcvGjZlZQIeH/3R2sixxNXDJe4czfiYDbVb8tgDvEzAgpQbejAK7c4OtbKHXY5
 rTcANk38l9ZuiWtC2S+NHfnMAGnzLfLo36TsjvSoy9h++TCERUWbiyVY741qHmhR8XAs
 E4LgeqvZA5ed9WeBQXucU8ygUygOyN9nyW5RaAkCH4fZqy+X/9vtir7GfLZPoQrvuT1P
 RZR7gNS+fZIZclyMD5sWgamzy6JOHUNyry7mx7xuxOptsT8jIMc6r6eA6wC7Vkm72Vmf
 BUBg==
X-Gm-Message-State: AOJu0YwL8fOqUhsCZu7gXmVHmCswSU/tduVmiYc5S/hb/OQJOFzNhFlV
 ls7TzSTZt6qiRxhB+6eor25Ok0cfiOXFP6EQ8/5YJN1areOa77LV/ZclThAdu21zixo=
X-Gm-Gg: AZuq6aKNRCR7xQbjfFkK005y2JHHbs1JTDazvWO9gxql/3aPVsjy+ySwcx+7DeYNFiV
 1ECgrFUit9FlYMw/Y7xnqgOKhNSnqmlnsrG3wY4xppZgN4yDcWPCmMunc73keypZnO6bJJI74yW
 JfFRSeUr07ouEoQONHyMy7+/OkysUP4TIjFGeB+Zi87AC/gRMK0d/G2+SQe2xFVUlcY0GUhel8z
 uZs9T02+c/HBMdtdUTGi/5im5rGNEmV4NcHM7fOi2cM3HexxBM0OtkX4dXO6xs+M9GBNqR9UHza
 VjDS7iYiRMVix5qfr8a3U84DfgH27Fwf5IYG1nD7175SdRtMffib2MHcB+43qmBnGuXa2VQ5Xjr
 BvT6NYvWtq1Jhvj9w+h8WaG6MgeOEvVgqrptmISAt4URBzqulyEWmAoJ7l1puKrlWu7g1shNpWt
 oI0N6A7+uLDi+WTn51TNFW5q7WGk2fygneyWfSoJp4FLNWKqu5Dkz6Wj6TOXRS1FzU
X-Received: by 2002:a05:6a21:6118:b0:38d:fad1:cf36 with SMTP id
 adf61e73a8af0-394fc2171camr6729069637.9.1771562371922; 
 Thu, 19 Feb 2026 20:39:31 -0800 (PST)
Received: from sifive.com ([136.226.240.194]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6e531e6cbbsm16963875a12.18.2026.02.19.20.39.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 20:39:31 -0800 (PST)
Date: Fri, 20 Feb 2026 12:39:27 +0800
From: Max Chou <max.chou@sifive.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v4 8/9] fpu: Add conversion routines for OCP FP8 E4M3
Message-ID: <aZffvM-Mw7pAuMh2@sifive.com>
References: <20260205111622.461497-1-richard.henderson@linaro.org>
 <20260205111622.461497-9-richard.henderson@linaro.org>
 <aZKVxean7S9fkHHn@sifive.com>
 <0a41230f-e8c5-41f4-8824-9d45de6ca17a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0a41230f-e8c5-41f4-8824-9d45de6ca17a@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=max.chou@sifive.com; helo=mail-pg1-x535.google.com
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

On 2026-02-16 15:04, Richard Henderson wrote:
> Do you use those in target/riscv somewhere?
> I didn't include them simply because they seemed useless.
> 

No,the target/riscv part does not use these classification functions yet.
Got it.

Thanks
rnax

> 
> r~

