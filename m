Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88506CA1013
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 15:59:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzH2E-0002Yh-9d; Thu, 18 Sep 2025 11:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uzH2A-0002W8-10
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 11:58:58 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uzH28-0007Ru-9l
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 11:58:57 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7761578340dso1628289b3a.3
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 08:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758211135; x=1758815935; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xO7r/UkjJOpBdepZgahQXwA4UPtG8pwa1VMzQM5PCVo=;
 b=QIC+EgUX5qrkamxx8GF2nS5z84b6xfJp4sfNH1yxcMK/BF/mzzwAIBLyL7Co2L/S3D
 jP7D65Vt1EeYnRxJ2BfsJPlunhoi8n2O7M8T9CgPgZ/6fJfK+XaHwbOX25zt9869a3gb
 shlavRvhBNQnqJrb8dxc09EC7RUpfa/ZC3j3iIF9r0p1FIpACxn3KPEQ5mpOOMcU45Bf
 /x2xp0t4AKhpnHiFIV+Ers8RCLoL75o3i8P4zHc4fExEB8k8xI/SwlDMsQZPEEp7J3Ea
 6HhnPaW5kbf3sFGvEaLpKEq+furfNtnz9VQrSc+PDW/WdA+LFYOZTNnUXiqQDAaBwpNC
 9IrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758211135; x=1758815935;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xO7r/UkjJOpBdepZgahQXwA4UPtG8pwa1VMzQM5PCVo=;
 b=JlzT4fTTwnb2JTLmzRweVxF7y8nY90nVp5/gnQ7N+HiqTWaPAGCEMQQcMqgJMPQ6f2
 OixT8jirxvPgUgFUyABRRP8nmhG86Je94mLM3MyWbQku1PRzNg+9CO4epJAUpYwbRNGE
 yFpO0mMy18Es+AEJwbOezoX2ukb84pw8FxD/0SqriQGLrHpheymR/HT8WjqlcPkdIrve
 I72Zeby1eT4Ule5Of/7t+puR60gSwemRzGlkjTxJkOwQw5RA2jhNhENIAOVL1zn1t9y3
 guXn6YKjEBg2k4j5f60HTawxnzVUIchK+jROEiZ2igJM0sKEm6pcanG/T2Pice3Fgu0v
 cBgA==
X-Gm-Message-State: AOJu0YytZ3Gi2332R+Ha/Kh5VkxRYCjqe/oYjhWM6e4wuklhS6YArZcV
 z1UCKZtBGmimrHb5ep2Y7mrrCLK7YQndneoL95X86cKFpjdaheELGRNGfWVFrfl8IB2gb998oh2
 noMSq
X-Gm-Gg: ASbGnctXekkkY+NBgg+/SSgEwy8XOZLEMeXebR7RWBHCUBfcgVcoZK916KyKtRoBNoi
 0tqvwOEkr02Ycw6FUVDtw/0eRs8tIMKEd1LsdPQeJGgFjwXccAN1cfGshY9LKiJoSJo+9Z1pjde
 0nuFzt2y+vrqpjFXcxtcDji8VPymXgk1uMLXoFO5wUheP6rcLU5yF5mhacwFq51xu2nZqWKy3H5
 XqA9m2H1N/YWAdTUMETESRfWnd6j38iZlLXg0WlNfsXqyWHKIxnNbv+zmKG8u3sg81s6VtKj2Ga
 +9xqWDjsSJBBvtIcULiOBegaE7dyke/+wfbchkciDEn/sedXXfocbJyLHU8QDUqVzbSFDK2MZBI
 /9UYZ43WlOiBUKOih6vKNnfZPhyUvFSPD1iat5n+wQDfNnyISfl5Vs0Y=
X-Google-Smtp-Source: AGHT+IFPdZfehmTFNFMOPZ2dpfXLYHUJxLLrBVq4h9M+YRTq4CeFYSIHswRwtPZCeVqW0HnwfocXug==
X-Received: by 2002:a05:6a00:c93:b0:772:25f6:caee with SMTP id
 d2e1a72fcca58-77bfa648609mr6819451b3a.30.1758211134761; 
 Thu, 18 Sep 2025 08:58:54 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77cfbb7c127sm2723972b3a.21.2025.09.18.08.58.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Sep 2025 08:58:54 -0700 (PDT)
Message-ID: <5d52ba49-df38-4006-a900-b285093813fd@linaro.org>
Date: Thu, 18 Sep 2025 08:58:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/60] CPU, Rust, x86 changes for 2025-09-13
To: qemu-devel@nongnu.org
References: <20250918104624.441820-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250918104624.441820-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 9/18/25 03:46, Paolo Bonzini wrote:
> The following changes since commit 2e66fb24a0ca9750df0d1d5b35197ff89c4bbd46:
> 
>    Merge tag 'pull-misc-20250916' ofhttps://gitlab.com/rth7680/qemu into staging (2025-09-16 10:10:51 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git tags/for-upstream
> 
> for you to fetch changes up to 00c0911c68e5bd664de1a261b74c390f4c0be83d:
> 
>    accel/kvm: Set guest_memfd_offset to non-zero value only when guest_memfd is valid (2025-09-17 19:01:57 +0200)
> 
> ----------------------------------------------------------------
> * cpu-exec: more cleanups to CPU loop exits
> * python: bump bundled Meson to 1.9.0
> * rust: require Rust 1.83.0
> * rust: temporarily remove from Ubuntu CI
> * rust: vmstate: convert to use builder pattern
> * rust: split "qemu-api" crate
> * rust: rename qemu_api_macros -> qemu_macros
> * rust: re-export qemu macros from other crates
> * x86: fix functional test failure for Xen emulation
> * x86: cleanups
> ----------------------------------------------------------------
> 
> v1->v2: dropped "i386/kvm: Get X86MachineState in kvm_arch_init() without the cast check"


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

