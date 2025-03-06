Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C83C282DE
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 16:27:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqE3h-0005q5-7J; Thu, 06 Mar 2025 11:26:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqE3Z-0005ny-Uo
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:26:46 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqE3X-0002zW-4N
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:26:45 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22401f4d35aso16448805ad.2
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 08:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741278401; x=1741883201; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P88s8ijDyDl014pRNdvWiHhjjv/J6gaml3H1P6W98Lw=;
 b=bFlhVTyaZwKbS0kaJARKtReXVctJ2+vc7H4lQjE4O7h+wUpR2p6Gg7ghH6zytYtHE0
 v+drekHj06FsSsh8U1YP+8StFOKs5kZLLzcL19UveiKaU054T4/2Jh8c6Nfd+47qhVLt
 Jmh477JxrZmtBQPdn0g7ZtcvPqImoDvAU5avnIJxRdJqKIyKVNXOUUw2ArSklIj04hIx
 3t6WCAOAI9ZETv9EQc2/scEkMYLWo652uwXGP6bJNSV8vMW1j8UutohQm84uo6S/QGsR
 SPV9uSgYeGpCmM9zoTDfwQ2SiTBNl5/2Uk1XXD7JJhMecMpaTtuSlDXrjs/PahDxrMq7
 gG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741278401; x=1741883201;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P88s8ijDyDl014pRNdvWiHhjjv/J6gaml3H1P6W98Lw=;
 b=Xbx71urG8Lz6h3SxGEqvsa1x9dtCcc14D3dqoRsPfRS1F1OmYBxls3TFyLKfLXV7QQ
 ePPFelHz51HIq2RZ+GyIibgY6vRYqqxpwfm3L0xtEYIAgv/ZxBNEKasbZHB9f3NjQl+k
 eb39dYzOYuM1fwYH46qLIaJ9ttoHJSK7G+NolDvCRxV1Iw7eZkzYJ1nV/CXXe/QmKSDU
 dwJdP+UWKP2NIH9XrhNfhz600FIGyFjbonL4UXW87FVIEDdPXkl7b8IEDHUE4riQ9Onb
 BlclX/738l23mqH4tOd+sfWzVi+GRzRLJmfsDJfR6sI0Cuqpi+SqkQIuKJH7Q/bWiJig
 BH3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXmxz2x3rVMC6xtE/nOkv86FckGtUGUcjcRDJ6PurfB1kQjGx95vOm0oqwUtcZWGCegu7tI4PStbJ0@nongnu.org
X-Gm-Message-State: AOJu0YwX5sLQugyWyV+6QNvlmxCHT0GhgvT7yT+u/E8P+mleju3preyg
 VjrkqqmILJjK/0392g0U3DlvP+CeyvMZJ0ljxH/W08lcFODi2RwBuEhGeM7hVFQ=
X-Gm-Gg: ASbGnct+nmMKNp95MFDPc9Ix1ixRVdK+1ThCDkD0fHY3/jTZbF4LmNend/3K795MwoL
 RhuGF0d+F0kzE4Mw98rBaoQow7HqiX2Kla73NtEhcbP++zSfO2a3JIAgb5oZpsiKSfusm1OGOMT
 IwoOqCbBdRcD/zkCqB94M3/neI+5VliMl3UivNRoUPt2M4+QWlPPAMH44St6ecwUFACZjB3pHJY
 l2q+iOfkWzJcqhgUmU+IlaFj+/wmMHUegZb2lDkhxB0OqF5elNASTHYObwnPbdip6Av23clMqJI
 67qfziDwwtTNUV0YWninNS30TBsnIoDBw+8gxUxKC5W/tCRjGGMFT9v0c5c2wKtt6G2uNK1zhbP
 RtNQrCKpe
X-Google-Smtp-Source: AGHT+IF2L/lKg15OIAaCMIYLxQaKbWT7sQWPJ+xEc0jfrMHwXQV6p9m7lMIUPUnEh8yf9K51D9tM2w==
X-Received: by 2002:a17:902:e5c4:b0:223:58ff:c722 with SMTP id
 d9443c01a7336-223f1c989fdmr142423325ad.28.1741278401547; 
 Thu, 06 Mar 2025 08:26:41 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af281288790sm1247442a12.63.2025.03.06.08.26.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Mar 2025 08:26:41 -0800 (PST)
Message-ID: <0226e9d5-edbc-417a-8cf0-8c752f52b7ed@linaro.org>
Date: Thu, 6 Mar 2025 08:26:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] hw/hyperv: remove duplication compilation units
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, philmd@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, manos.pitsidianakis@linaro.org,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, alex.bennee@linaro.org
References: <20250306064118.3879213-1-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250306064118.3879213-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 3/5/25 22:41, Pierrick Bouvier wrote:
> Work towards having a single binary, by removing duplicated object files.
> 
> hw/hyperv/hyperv.c was excluded at this time, because it depends on target
> dependent symbols:
> - from system/kvm.h
>      - kvm_check_extension
>      - kvm_vm_ioctl
> - from exec/cpu-all.h | memory_ldst_phys.h.inc
>      - ldq_phys
> 
> Pierrick Bouvier (7):
>    hw/hyperv/hv-balloon-stub: common compilation unit
>    hw/hyperv/hyperv.h: header cleanup
>    hw/hyperv/vmbus: common compilation unit
>    hw/hyperv/hyperv-proto: move SYNDBG definition from target/i386
>    hw/hyperv/syndbg: common compilation unit
>    hw/hyperv/balloon: common balloon compilation units
>    hw/hyperv/hyperv_testdev: common compilation unit
> 
>   include/hw/hyperv/hyperv-proto.h | 12 ++++++++
>   include/hw/hyperv/hyperv.h       |  4 ++-
>   target/i386/kvm/hyperv-proto.h   | 12 --------
>   hw/hyperv/syndbg.c               |  7 +++--
>   hw/hyperv/vmbus.c                | 50 ++++++++++++++++----------------
>   hw/hyperv/meson.build            |  9 +++---
>   6 files changed, 49 insertions(+), 45 deletions(-)
> 

I'm reasonably certain that hyperv is specific to x86.
Are these only "duplicated" because of qemu-system-{i386,x86_64}?


r~

