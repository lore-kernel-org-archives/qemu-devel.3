Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE6CCA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 07:21:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uthmm-0004rX-7O; Wed, 03 Sep 2025 03:20:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uthme-0004q2-AF
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 03:19:56 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uthma-0008JK-Gb
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 03:19:55 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3cf991e8c82so3437408f8f.3
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 00:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756883989; x=1757488789; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j5B3rngysK6Msp6UaNHP1OsAO+7W5+EQJFiAuDon0mw=;
 b=LyGk6GA+dX6wBNpTTt4L8TVHgec72HNcRRYumz/Mh6LxVlis89fUgNxPAKiM+HbDCI
 p74HqOm+JXULFEACcnIhkJtoWRsMJv8sQOdp26fIy+0Qyd+aYL87AhP+agaFEqGlr8oW
 EFWzC/pLeTr4BGgpIeM+1AkXZNCe7TOyPj3lmSug9mqLyzNcqLx7akFoRJKLRzHDWHF7
 MXh0W9QxKrTNnxombAtofrGd7BEXE3MGjijXKA9lPn5bebA/uJ4DZHKxgeUl2T/rEfq7
 aRxVYK1CnKX8IgrTXaYOWjuYI/v+FkbuDSDCDCKtU0STTBVFQud0jrFl3HZksZ3vcdS2
 STaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756883989; x=1757488789;
 h=content-transfer-encoding:in-reply-to:cc:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j5B3rngysK6Msp6UaNHP1OsAO+7W5+EQJFiAuDon0mw=;
 b=PrdL/Djq+3N8A5MUN1GuVuDkdaHXCEx/jdeGVuitTYKqpmpIzhnZ4gbidkKAvUtu2j
 v/x3tF1jQZqCpz9OtRpQia+R+W9wOQFB08WUog39sAuc5TgwN2IZvNprMG+h+xp3H+sI
 6TJhAn+MyVBK3zMJ6+Av0AAikUoTqyBoyEjPoFYrsavH0yHrvJVVk5HdkbeVegsHoDuO
 tE3PF+XpjlGnh57mIOisp3HY4/2Lvk5+W948soQ83pJGZZgNS3G/JqK8Ujw3M+xJCdxu
 RYYmhmcvK3WVEImxpcPdL3oqavHGbQdtScxzGtKo4jgdgVt5KU0Gi/dN7ujGBAF70E/9
 gkqg==
X-Gm-Message-State: AOJu0Yy6H5E0JJ4f8e7OIErJwEg1rhT1/Q8YetmVVzD9rW/AyQ1tL5O4
 18zAWheIrwxdxm2O4YGwD/Y6Eb3iMBQnac+rXFc4COLaLPiLyTO+KaBcB48vukHFxZU=
X-Gm-Gg: ASbGncsS7w8jIefjKUllglqmhwenFePiUpd/f2CJ1f9fYSexcJ/dA+m35NdzN7WjqUO
 pdSoS4szt1t0wi9dXyb9ajdmghH/VyfnKiL0t9u+AdHaU9Wuz1VNtBdDgG69/4FylbZbjOg+P+v
 GCAUa8Kr9Y7eDCDivE0JGIU7L9miAhttNf3gKJrkTpW7T+P9t2MpaJboQqkS6cyL+siyrShhm67
 Dqo96EILxTMMVMV/jqiJ8JdCc6bHNZQGNfYEZliG8fv4S+BMZL4AIxL7B3mbhqrnM7zzUAQeDmA
 zEGjtiHz7MsrrbgN3veB3UoVuhwGDzn1bH2lSEu+GivJX12A87ZPgRTR61v8UOl7IY8ww5NN3jb
 4yQoFkuFK9icd1WeWLzOK9RyXl0M/yD7YPER2lErpW3NrktbcgxWWq05IfE7yyCZkLznUEW3V
X-Google-Smtp-Source: AGHT+IErjV+SNcclwRfDxO/jM2ZRg8T+A2nd0uauxdBrni14vjbW4X5Gk+Rao8wpknjof2iCNCjE/Q==
X-Received: by 2002:a5d:5d0e:0:b0:3d7:df92:5e31 with SMTP id
 ffacd0b85a97d-3d7df9262ecmr6279336f8f.16.1756883989515; 
 Wed, 03 Sep 2025 00:19:49 -0700 (PDT)
Received: from [10.223.47.213] (4.red-95-127-47.staticip.rima-tde.net.
 [95.127.47.4]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d520eada16sm13626531f8f.41.2025.09.03.00.19.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 00:19:48 -0700 (PDT)
Message-ID: <3dc13fe2-4a9f-46bf-b033-81d41e322fea@linaro.org>
Date: Wed, 3 Sep 2025 09:19:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/38] Misc HW patches for 2025-09-02
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
References: <20250902160004.3816-1-philmd@linaro.org>
Content-Language: en-US
Cc: qemu-devel@nongnu.org
In-Reply-To: <20250902160004.3816-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Hi Richard,

On 2/9/25 18:00, Philippe Mathieu-Daudé wrote:
> The following changes since commit 8415b0619f65bff12f10c774659df92d3f61daca:
> 
>    Merge tag 'qga-pull-2025-08-29-v2' of https://github.com/kostyanf14/qemu into staging (2025-09-02 12:07:05 +0200)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/hw-misc-20250902
> 
> for you to fetch changes up to e502e614f4c3e5ee7b12cf1c926d9581262fd626:
> 
>    hw/i386/pc_piix.c: remove unnecessary if() from pc_init1() (2025-09-02 17:58:05 +0200)
> 
> v2: Dropped "hw/sd/sdcard: Fix size check for backing block image"
> 
> ----------------------------------------------------------------
> Misc HW patches
> 
> - Compile various system files once
> - Remove SDCard spec v1.10
> - Remove mipssim machine and mipsnet device model
> - Prevent crash in e1000e when legacy interrupt fires after enabling MSI-X
> - Introduce qemu_init_irq_child()
> - Remove various memory leaks reported by ASan
> - Few Coverity fixes
> - Use 74Kf CPU to run MIPS16e binaries and M14Kc for microMIPS ones
> 
> (a pair if spurious checkpatch.pl warnings ignored).
> 
> ----------------------------------------------------------------

Could you restart this job that timeouted please?
https://gitlab.com/qemu-project/qemu/-/jobs/11225398103

