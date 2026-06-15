Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5940CD98CF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 18:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZCCP-0002TG-ND; Mon, 15 Jun 2026 14:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZCCK-0002SP-Sn
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 14:38:13 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZCCI-0002GH-1n
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 14:38:12 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2c0c1e0d00bso33274755ad.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 11:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781548678; x=1782153478; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=97lbOVoF62W2GPJk2Zeas0aDOI7h5cihE+O+dpW+WWU=;
 b=rk8sWiBCetnsVcpUZNNpXsW/IcYPpNXYu0MhCdEwo7NzWHgIIC/kHQfz6GSv3dxHTS
 2GoGdc4TyV4s5gSnnYS+WQXMOA+z0VWZ5+jAR+N28S8+Q76pTaSE3VKhmMlAXQPBkOKu
 EoekKEDURt4+xp7wEJC+G5SS4N68WFjMagZkr3slRsNMUybTY5EQYeMhYMiRbuGKWb97
 5vsZMMupk5O2/TI6wQvdlm+mqVK9Hphkz0whLjGIELfex0A8qCrJcNqRbI+jtUEeApR5
 TUdCNUZbPmmVnW/ejYDg4ZdgmRWW+HpheBr0TPMP+OJaBavNgrdK3O93ldjipbaVUd3I
 Uq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781548678; x=1782153478;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=97lbOVoF62W2GPJk2Zeas0aDOI7h5cihE+O+dpW+WWU=;
 b=TBzYcHVM2lAyE8+5b7GfqKGCt2ybaupQ6VXsDQvoIpaaFRLzH/odD9iPoO64jf3DZt
 03Ft7zC6mPiHO+hiUQtZF9o0YHwjY+tC5ea1s5m70IEdR1iRA4om6jcZeyRG5ytb2grc
 EeBeci1sQpq0OwKf+FSbAA5SYjN/2b+4Xmd+F8pkY5IBHoBDwFm/bUylPw1BdA8/si4Y
 eZe3MNHmqQjS/3IHUPAd1wMOzvi0LhAkWBaiiMK5uDe8nthQLy1gnRgaeAzTquwmtP9v
 c0m0WpMYM2yFbUp03o2ivDlOWYK8qYXSQPailj1QACrmypywIuQcKpC6Mg09tfnljq7H
 F26g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+g0ty2Em4KDsy7xGSz9lRDenErGDoOwWhmx8BO+77ye8z6GHodgB+LedUwAExLIfY/rRuQugjJKGD4@nongnu.org
X-Gm-Message-State: AOJu0YxbRM9WNisOtuWJx75a3zfnbJc5ZRqLT5p0fGh/IF0zy0JObmAQ
 yKKNX0OW/r/cLstj2Ois7ywfD+lA7kuVGI+UCswSfD4g+FjcNT8pOm3+qAcn0IC0Ixs=
X-Gm-Gg: Acq92OHqogcm4o0DB4t7Ps5MYCv/vzoF9dxiI5NfATy6c/x6ok7YpIDF7uNF6kHx2nF
 vJ/dl+1OLm7h/BzaPmO24kba46pT2Ap9BB2maQ3p8ZxIOAIEzBJOfkYnr7+ZCIx0dVELinuv4C0
 58XzqbVMwcFsQjQutRMhbw53o8x8WOVSjs2sbyZZS5UIfO98rQD9mF1r8IMaZc8c6d+4duD5XTn
 VK9vb9OhUdaVQyxfQuD1mMumgLFiuKC1DEcGV1L4o9cnz7nmWDFjJVVoVdeea7910kkYwqHeI7/
 6TQ0DuL7Q18Me4Q8wa2qIIgL9r8/OhFnqq6PyrD6Sc2c7sNz1X2kUt4fKk+T3Q92fiLQBDqY7mn
 YleJtc98fgctl/RzsqUhSjeNVzjr9zEFBSsVRBCsFcx2lR+9z+bo5bvHlLL8TtBQUVgzARvEfRW
 /6GT5Ofofvk6yPIJevQmMlyqPhKNB/dDgWC4Bvt0QLNcq6oSQx/+I50ckp9FHRj0nv22gEpTwFt
 jcA+x8=
X-Received: by 2002:a17:903:238b:b0:2c1:77cd:fb0b with SMTP id
 d9443c01a7336-2c412f17bcfmr166432335ad.37.1781548677861; 
 Mon, 15 Jun 2026 11:37:57 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c432d8a039sm110189025ad.62.2026.06.15.11.37.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 11:37:57 -0700 (PDT)
Message-ID: <65a1034a-d71a-41f8-b148-7120934d3761@linaro.org>
Date: Mon, 15 Jun 2026 11:37:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] system: Document cpu_physical_memory_*() declarations
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>
References: <20260611180320.30320-1-philmd@oss.qualcomm.com>
 <20260611180320.30320-2-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260611180320.30320-2-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 6/11/26 11:03, Philippe Mathieu-Daudé wrote:
> +/**
> + * cpu_physical_memory_map: Map guest physical memory region into host virtual
> + *                          address.
> + *
> + * Map a memory region into the legacy global #address_space_memory address

s/into/from/ ?

Otherwise
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

