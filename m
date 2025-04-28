Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E1AC369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 12:10:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9NIm-0004rQ-34; Mon, 28 Apr 2025 08:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1u9NIG-0004gc-VA
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 08:09:07 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1u9NIE-00049q-9I
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 08:09:04 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ace3b03c043so712820666b.2
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 05:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745842140; x=1746446940; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FA2ZsBdIEmHGu+jH72qeTS4Hoi5VWo3/b7hKS4mvRWU=;
 b=gd0HcVt14XAZ+USqUXEzM83KtOIUTU3l739blhtgPeTICR0N9gKB7e1C1YVOfrerwx
 zhjAj8JdDzN/U12Qpjw/1WqAV/9Vjk92IRpwDC+kyY+LCpnLd8991HnisKJJ9aTwWNmr
 y6qtVJ/pM3EU8QpDG1oQyv5C+bmmzr/XihuH6N8EjQ6AQp6rNZmaoQKEfuusVcEC++1S
 VAfg09XDTIPbkMxeC3IloACvIb3IjDERUtl49xVdLksMBFunPh201MRZML/YUQc5tPKY
 GfR7i1ziSZT/RaC0RhRnfR9AMOJjEU+JI722gyX6BKNnHv+/dITEkh9z4hJk67agYeM3
 xRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745842140; x=1746446940;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FA2ZsBdIEmHGu+jH72qeTS4Hoi5VWo3/b7hKS4mvRWU=;
 b=dA8DUVu658g5GcWVRxmLAvPKxyMlJDFFXpIFJCHf0GA+xW44mjvhFYd97meziOeF+Z
 PubSc6l/0LOCNUdSwhNmDGDT+lom82W5FWMGtMySB4DU/ROz6tJUBWlv4AllBXhYvA8k
 YS8VSMns4FVQheNdrJ9oiTPAH4q5Ke/ywOKgq+f1Iqlpwnt5X9m+0Q1C45Bl6aEUY7N/
 w6yokI9T0nurYwayb9DwHLiDRIA6VCWQM7KCmHVY2DPkUATV+h1the7ig73tULBx4zja
 PomD2xlHQtZsMxlP1tW1vQ5Zz7uULO/Ot3SWwCQ4hTF/LtrMSzfAox2KKPAuaDVril1M
 P8wA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwTahW8MWXSV0W5YhgUdRoJdOCKltmoBpV7Y+ZHZgGLfphdLhgNd0eK4pjjshlgsnOFVNMODadcfNG@nongnu.org
X-Gm-Message-State: AOJu0YwPMvvxBhif7ycQfJMgUu9MTWQocAytKBB0XZV7TCM3j1qINMk7
 Q6peTkoIMxGzng3c5NuYefSEwv5MKTPZsifl9o+foBwT0d84v/lph6u7d0foz9Y=
X-Gm-Gg: ASbGnctSjGelHNFHqq9SHWjoh/ZhJD6zmB9AhVRYowAcw1chDokhV2aAMZOMxxVUTk/
 CmVroqkJ4epriRv3n9rcmQ+1wQgfND8Sb5i8Vu1u/YYy9/6cbDppQKj9BdcxdxRVzofixjLnYuD
 G8YCTWOrm/4xgWoff8raqfH4x9jFWLD7nS1l6PG91l37cCnhU+UERhPBxG3/C/0/Xf8I8XZdPcn
 7f87Y1HTPmMq2i1+t6OknvQZ8+WfEa1qhnCatTfRys9KqvaKZRVr0IWaY4e9PjYQ4/egvwzcAct
 lnZmIfEEpctAW9/lk23LWaL2tf++WOsTPOoZbAupI/vQpk8ZOaa8XrLdFQ8G5Ea7nrQprQ==
X-Google-Smtp-Source: AGHT+IGgejT+RtvNhROxzGnVNBzcSelFfL93tyQ4FI3RvCeDuuEEOxqUlY/nFqrI4nY1Fhjnj2uvSQ==
X-Received: by 2002:a17:907:2dab:b0:ac6:fec7:34dd with SMTP id
 a640c23a62f3a-ace713fb7d0mr1079370066b.52.1745842140398; 
 Mon, 28 Apr 2025 05:09:00 -0700 (PDT)
Received: from localhost (cst2-173-28.cust.vodafone.cz. [31.30.173.28])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f7fbcfc090sm819462a12.20.2025.04.28.05.08.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 05:08:59 -0700 (PDT)
Date: Mon, 28 Apr 2025 14:08:59 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>
Cc: Meng Zhuo <mengzhuo@iscas.ac.cn>, qemu-devel@nongnu.org, 
 qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 qemu-riscv-bounces+qemu-riscv=archiver.kernel.org@nongnu.org
Subject: Re: [PATCH] target/riscv: add satp mode for kvm host cpu
Message-ID: <20250428-4cb96c7f0226e15a40006dee@orel>
References: <20250427132557.1589276-1-mengzhuo@iscas.ac.cn>
 <20250428-00fc862d2d2d628ffa4c8547@orel>
 <D9I60P8TG036.2ZHSS9EHW4W8N@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D9I60P8TG036.2ZHSS9EHW4W8N@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x62e.google.com
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

On Mon, Apr 28, 2025 at 11:30:36AM +0200, Radim Krčmář wrote:
> 2025-04-28T09:00:55+02:00, Andrew Jones <ajones@ventanamicro.com>:
> > On Sun, Apr 27, 2025 at 09:25:57PM +0800, Meng Zhuo wrote:
> >> This patch adds host satp mode while kvm/host cpu satp mode is not
> >> set.
> >
> > Huh, the KVM side[1] was written for this purpose, but it appears we never
> > got a QEMU side merged.
> >
> > [1] commit 2776421e6839 ("RISC-V: KVM: provide UAPI for host SATP mode")
> 
> KVM satp_mode is the current SATP.mode and I don't think the other
> SATP.modes can generally be guessed from the host SATP mode.
> 
> Can't QEMU use the host capabilities from cpuinfo or something?
> 
> Do we need to return a bitmask from KVM?
> (e.g. WARL all modes in vsatp and return what sticks.)
>

The widest supported is sufficient because all narrower must also be
supported. Linux should be figuring out the widest and capturing that
at boot time and we should be returing that info for the KVM satp_mode
get-one-reg call.

If the satp_mode we're currently returning isn't the widest possible,
then we should fix that in KVM.

Thanks,
drew

