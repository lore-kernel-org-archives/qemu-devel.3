Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06854CAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 16:36:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyv7w-00011V-JR; Wed, 17 Sep 2025 12:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyv6J-0000Fc-Pa
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 12:33:52 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyv5w-0003wc-Ai
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 12:33:47 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-32ed19ce5a3so1044076a91.0
 for <qemu-devel@nongnu.org>; Wed, 17 Sep 2025 09:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758126802; x=1758731602; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m8EfKZOgtAYgRwNeg4TqygAyHqNXTgKjzFutAX4tPaY=;
 b=Z6TgHTRkiPJUQwL1xeGHIiah75sEAocpE00swLPpio0rfm1Et6y+YGhuI3DUeWJ+DZ
 476jIX2TbEPrpttjbSZSJ4BvvF6uKPcFU6FS6cCTBoy3s3geTzzDjYmCWLpgpwVN0KF5
 VcXGpbzQqXSv/OXk459llXHdySecqYt83TGElCukj3bO35jb6JIQ6lP5pesXrlWu9t3h
 BFcFd2Pd62NWxAFwNWAevALZ7OkkLwBd9zchjT3ARUrKAMNgVl6vy11LYc/Dm8aPfojc
 ejBAUXg5wd+akgz18GbfzA3j5QUhjswLk/ehLkgBmi5RDwtRNjsCTuIAxFPxT/ivnhB0
 0SZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758126802; x=1758731602;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m8EfKZOgtAYgRwNeg4TqygAyHqNXTgKjzFutAX4tPaY=;
 b=AH5+yUPk1rgIosYSD2RMZbYoZKTnsg6NCN1XXoAA2gkUK7SBWc23NuykAJUpaSLik9
 wo9utAH33YutVxSczp1NphyDEH3zyDXjDK886NvLC6yotnFtF5snIrqKeMq6M9Qc3P0n
 FC2ThqteCvLm7QC+IQsD0OlhEr20HrlDzTJyuiyH0ZEhvpus6SFn9cb0H472YmRfqqfr
 +0vfSrq0jDFhmTyoudiJkI5Ou6G4bKKOxSnolv2nfqEo3piwwZcmUYMJ5LmWLjuI61dD
 nnJ3jDWtlDHOEQDZp4I/k54GTM3g/WKFT2aTURnGUDTRIaTY4jXCO/Rmvi6RwJQAfBdz
 NUiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGtkO8EMQ5Tv4CWG9je6EH6ZrbqfMK5F+5J72Um60q6GY6uTMwnzSXdb+9Oa2ZTCga/cDzgoFT5OeP@nongnu.org
X-Gm-Message-State: AOJu0YzGkYjM1R0GGmbJxvHVkaPLv1WN/BAKSkDPQMWueDl1fnxdRHaX
 fz8sdtkRkbThnex/isiYlbRBpZXuLQ7/yY5VvKuITLllk7IlRZsCgApnwdFXW3Eio1c=
X-Gm-Gg: ASbGnctYjFZlHEO3rirDmMWinQxKoaNFikVmrn4miirSYnlTEmasPfCXwtIH1M5H1OZ
 aCr3Gk+oMdf19kSZopzgaM0wh0CQ24vNwdPaB+gemmBw9V2L6Yj35M4GFap76sQYrMvQWOxUeN5
 /xMqoMl92hGDWlgWGvamWQFdGeLrETGxlOIkM2GH9qutRbgW6AoBqlwryokikniaWbIzl4OrraG
 gsW/E7kTA+gvY32FCnZ1dpumu1tWZ1NhBridK1zh+p72oaqHDZiCdsniSqRQI5wB9RoZ+r7yo0O
 WsIaDWS+L3OXwv0FYdIDmeTAjwOALzWvJGSCqsBjI+IPopmqt4oaxbCBCfCftCabr2nRBRx6TzD
 jD/ivRc5W+N/nYNIVFwHpc3XDNFdeib8PeQgH
X-Google-Smtp-Source: AGHT+IHWN6lVpi8pe1Lnh8le40VdFsIB9FSWTp1rhk85VmPhU5tFq5Jg7ZXLC01zWqesXie/6dT1HA==
X-Received: by 2002:a17:90b:1fc7:b0:32e:e186:726d with SMTP id
 98e67ed59e1d1-32ee3f76fecmr2740111a91.31.1758126802036; 
 Wed, 17 Sep 2025 09:33:22 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77607a46b7asm19210124b3a.22.2025.09.17.09.33.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Sep 2025 09:33:21 -0700 (PDT)
Message-ID: <15b36cb6-69a2-44bf-80f9-46704d8d9e65@linaro.org>
Date: Wed, 17 Sep 2025 09:33:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/61] CPU, Rust, x86 changes for 2025-09-13
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20250913080943.11710-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250913080943.11710-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

On 9/13/25 01:08, Paolo Bonzini wrote:
> The following changes since commit 190d5d7fd725ff754f94e8e0cbfb69f279c82b5d:
> 
>    Merge tag 'pull-request-2025-09-09' ofhttps://gitlab.com/thuth/qemu into staging (2025-09-11 12:41:01 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git tags/for-upstream
> 
> for you to fetch changes up to 8733ddc08165d901eb2c87f364f814f58ab9fd19:
> 
>    accel/kvm: Set guest_memfd_offset to non-zero value only when guest_memfd is valid (2025-09-13 07:52:55 +0200)
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

Fails crash-test-debian:

https://gitlab.com/qemu-project/qemu/-/jobs/11390438959

qemu.machine.machine.VMLaunchFailure: ConnectError: Failed to establish session: EOFError
	Exit code: -6
	Command: ./qemu-system-i386 -display none -vga none -chardev socket,id=mon,fd=3 -mon 
chardev=mon,mode=control -S -machine none,accel=kvm:tcg
	Output: ../include/hw/i386/x86.h:109:X86_MACHINE: Object 0x556fd9ddf400 is not an 
instance of type x86-machine



r~

