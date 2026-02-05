Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18114E9128B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 07:33:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vntrn-00031u-BW; Thu, 05 Feb 2026 02:33:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vntrk-000312-4y
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 02:33:29 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vntri-0004dc-FQ
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 02:33:27 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c0c24d0f4ceso225518a12.1
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 23:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1770276804; x=1770881604; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mTfjF6QfqrENc5ehmLGsf+eWEc2eSmS+Odt17EHpwRs=;
 b=MH0Qhpox+d98/YYCfvGpnO6G5p6Ezmlgrph7caXVUAlRDRzsK4wLQ0xn8IrInklajP
 2mFjnrhrYML5fRHcm9FBQoRm5FDk8EsVp/mm+rcwOlHETy2N/wNWTajJ5yBJ4pa7LCv1
 Tkz51SP266HtcdaCEHy7UGbPLFmrNlFAHNDPBHK9yvikkpEy//tQeE3T9E5JUo9io+fS
 GPWSN/ilmhGP50h3AEW0Bvu0WR84BLY3+O3caaQJ0G58k9ItsJu1v3mXEkYszt9oiSd4
 I2eXgDSSQfFn5EmHXFbxj+qtpA67wPjtwG1U4AsrgC4i+VqsPoXQMRSt39QAkS7huOSC
 slfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770276804; x=1770881604;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mTfjF6QfqrENc5ehmLGsf+eWEc2eSmS+Odt17EHpwRs=;
 b=M2fXTDsxo3WRQScfY+0N0GUxBE0f5oCptcYb9FeIlN9n02utJx2O8UrwbOg/ub7+Mz
 1SRNwdpPlZex/YSwFzLqF1w1ygOCA0GkXhoYFVmgZrrDqK/4lBQ0NKwNX23FYsEvD0WW
 sRxehzB18bRv/n0y1CDfaKBb8foGmP6td7PllCPWBi4mAFnfML2c6U0lqBllPHD1t1vS
 Bel4pqBnRnlInu/8jpGMvy4k4to7RGQP8h+FJIZNkDj/zktPEGiOM+Dx+8k19xmzak4F
 JUbG6Zs7Np7WGTx7KppsGPjnyI9urzooE6hcUGbD78uOzy5BOPyOOxDgXazxOyMefdxX
 EGDA==
X-Gm-Message-State: AOJu0YycmE25cA5nlpCAH3EF2zyyQ2OvlICtPU1+Jwo9GV1+2qC57yfP
 FnQSkC1ORb8F2OFnTvtMB6PYuEwvw/Y2zretpiJc79XpBfsuuL17ciqKCwaQiM52oXk=
X-Gm-Gg: AZuq6aKTqcgn345JKyk6i7pa2F3jIcHbTgIiChEySj0K5X3+lkeadIITiUbtZN8Btcm
 URfpFLo3OIRnniHUJXsQlh18pvcbDyzCvfB8vTI7IreBjnaKlek4akAmOJy9v6xK+u30RBzQPx/
 hTiKDi6heyqOmEO/GnSZRMaIOT6OnmKqbFumWPK45nmvE2wH1XYbwexbQ5Dl00RbE628OyNgLLJ
 /GUFVo3H1YyRfnZGBpyTeVna7KAMUVboNebqpODr8y7ljTAYM0pywtRHnWLFi0qbZWAD1WBjvv0
 whar6CVq4n4n+fIdAGTu1GncaIUHCOMqzEYCyx0Rn9v1it93OwyVF79kLHPy8h+7UEaAeyYGt6Q
 iAQXKtkohlFTXVRewwOrp3EcW1iaAveDngiwTmZM7+rN2rYA4Wt7o5BH8nuHg2XcIFvsEqkQW7R
 B5Tnz+ipPtp7LLsv4EG+RJ8MYn6YQDPKrCzyKJdtqXYifUydVSZcqQ
X-Received: by 2002:a05:6a20:2452:b0:358:dc7d:a2d1 with SMTP id
 adf61e73a8af0-39372421f24mr5868093637.42.1770276804510; 
 Wed, 04 Feb 2026 23:33:24 -0800 (PST)
Received: from sifive.com ([136.226.240.169]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6c82e342e0sm4110002a12.6.2026.02.04.23.33.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 23:33:23 -0800 (PST)
Date: Thu, 5 Feb 2026 15:33:19 +0800
From: Max Chou <max.chou@sifive.com>
To: Chao Liu <chao.liu.zevorn@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v3 07/19] target/riscv: Add cfg properity for Zvfofp8min
 extension
Message-ID: <aYRHIzlJ4fyASZGY@sifive.com>
References: <20260204051756.667397-1-max.chou@sifive.com>
 <20260204051756.667397-8-max.chou@sifive.com>
 <aYNy_rXbHe4jT1T5@ZEVORN-PC.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aYNy_rXbHe4jT1T5@ZEVORN-PC.localdomain>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=max.chou@sifive.com; helo=mail-pg1-x52e.google.com
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

On 2026-02-05 00:29, Chao Liu wrote:
> On Wed, Feb 04, 2026 at 01:17:43PM +0800, Max Chou wrote:
> > According to the ISA spec of Zvfofp8min extension,
> > 
> > "The Zvfofp8min extension requires on the Zve32f extension."
> > 
> Typo in subject: "properity" should be "property".
> 
> The same typo appears in patches 13, 15, and 18.
> 
> Otherwise, the patch looks good.
> 

Thanks for pointing out the typo.
Will fix this issue at next version.

rnax

> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> 
> Thanks,
> Chao

