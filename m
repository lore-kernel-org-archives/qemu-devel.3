Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE56FC61DBD
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2026 00:53:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x07Jb-0001b6-Kk; Fri, 28 Aug 2026 20:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x07JZ-0001ar-Ts
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 20:52:58 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x07JY-0000rR-5l
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 20:52:57 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-8520161fdb9so1927087b3a.3
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 17:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787964774; x=1788569574; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8H/Hrt2KtUR1TiWS9lEe47A+6+i/GN9W421RPW2Nmk8=;
 b=c84rOqqRNrGHmHMCwUDhScIRLQzHvpWVTa7EwvzVJEdItverUoxeKzSOpleNhEi7vr
 mMC/9oYm20eh5eUI1Uk3BL2boM76OQ/FUFr4KNS32cWbD03O6uwIzB5hfKHsSx7R9679
 oEqOG+QDLLM7uKfftoKbTERbRwZ26theQ4AeHG+kCZD49oqUO7havh3Jvo2fT26fnc6W
 pkUbD9XYRCjJ3pdtvUjqwSOknNaA+61+RcBtVC1fnYYrOpOPEKal9V9yOfJEEwJ34d44
 z6hNCo3FycwGm4E4jnv0JpJdyA5JzomRxjI5SH3hC5OvFd642hBkjOAcBL5P8n+o3N3c
 iKjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787964774; x=1788569574;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8H/Hrt2KtUR1TiWS9lEe47A+6+i/GN9W421RPW2Nmk8=;
 b=rAGaX0o68GtZHBFy01/DqsgKjgo/YZ+fRX/5e2IrfDWG6bZXkXeuu5BvNB8ux9Ux9H
 oxNoLbT/xC6aIq4nR2/AxXLqEe9oFYcJSnevnaUR5/8G87TSDOrEcziBl+Ud6iGMk9m3
 97etQfSQYLF53s94CMui/iuyTgP+Isuwo2+gLYINZfWvEd+PzSmF6kl29o6vXo1F2dW5
 DZlvhU5Q35ywyDf5BnrUnt1RreRpuYm+wX3yoaEhQNJob0jL0l4jN4zp2JnczdGHetJ9
 wjqMZou8mGkUN3FO4POKf2YJVjdRcSsOWeog5Uque2N8l5MdyBrHExFcTEdszUrMZ9RG
 OgzA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpOsyof2gI21oEr0/z8E/aXHCWLtSbOnCUDTQR/WRydDB/Go3z9SO6d5jp+nGDIiTWNQPo9yUI1B4eD@nongnu.org
X-Gm-Message-State: AFuF++kQMESXfYpuFKtAUwsdC2Bf9xdEUm6jy5kJDO7i10zcDlUBB0wc
 +7/IK1tv0XDhyjjL3fxBHJYd6iQwwdQPe4EAKPR03e4WNeRl9fZ4niKohwIzwL1eUYU=
X-Gm-Gg: AR+sD12Q3mXs0RAEL2A/WIsEURlz6mQylr0tuGZJzQ1BtFdRNsljwiMGCMXiqLdifbv
 0VnzoQT701mkkzHgMpHOcFvl3Zh+Ws9TeGefRfLazDBSEiX34RCs+1tFB9ESZBL2MfPWYuIdk/j
 hYruTfv0XnuRkvfEZPe8F+2L2gxRdpm6iblQ8zdanMISfmkG/er5X3YGHZC5j7MrIY4x8UsWYJH
 mpenZzi+8DvBuqNcdzsulfGXoFwuikb1zEvAnUtuzYjKY8/5/pY5MhdleK6RCqmFfxwI2Gbwtbe
 6l+GKzmalVp73loVq9s26CwvjM2mTlVfwGqdUGFyY0zB8WDvP6dc9m0xh4+0Wuci17/2/C/4FsS
 SjQBvm4PlDDa+nsDR5np67gTGfRpGdk/jexOTIZVn264qKbkCQ7hj9xKrcYnTH7aPOcYLSv0ght
 nLMvbunPsFH3NLf3QXrQRzRZdehamJTxYQB/vRo1Uq7I7X9P1exwDtThwVFvDLz0MB/dt+bEn9X
 QDu001KvaTy4LpgqPiPVIIr61jEoMM=
X-Received: by 2002:a05:6a00:4b49:b0:857:726d:2706 with SMTP id
 d2e1a72fcca58-857726d2de3mr5089822b3a.18.1787964774262; 
 Fri, 28 Aug 2026 17:52:54 -0700 (PDT)
Received: from [192.168.0.4] (71-212-39-143.tukw.qwest.net. [71.212.39.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8569f49f516sm1022850b3a.4.2026.08.28.17.52.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2026 17:52:53 -0700 (PDT)
Message-ID: <d07e2f13-2c3c-43b5-8ad2-cbd2299f90bf@linaro.org>
Date: Fri, 28 Aug 2026 17:52:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL 00/50] Make HMP optional
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 8/28/26 13:41, Marc-André Lureau wrote:
> The following changes since commit 0a1ebd448b38afaa118597cbb633dbec24ef74d3:
> 
>    tcg/loongarch64: Fix compile issue LoongArch host (2026-08-27 11:04:01 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/marcandre.lureau/qemu.git tags/nohmp-pr-v1
> 
> for you to fetch changes up to 7a3647d67a54728e8f88aa0fa7f5e9a98bf06a51:
> 
>    gitlab: --disable-hmp in build-without-defaults (2026-08-29 00:41:32 +0400)
> 
> ----------------------------------------------------------------
> Make HMP optional
> 
> Signed-off-by: Marc-André Lureau<marcandre.lureau@redhat.com>

You need to update some tests.  With just "configure --disable-hmp":

▶  178/1056 /x86_64/ide/migration/chs_snapshot - 
ERROR:../publish/tests/qtest/libqtest.c:998:qtest_vhmp: assertion 
failed: (ret) FAIL
▶  178/1056 
                         ERROR
  178/1056 qtest+qtest-x86_64+slow - qemu:qtest-x86_64/ide-test 
                          ERROR            1.61s   killed by signal 6 
SIGABRT
>>>> RUST_BACKTRACE=1 QTEST_QEMU_IMG=./qemu-img PYTHON=/home/rth/qemu/bld-pub/pyvenv/bin/python3 MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon G_TEST_DBUS_DAEMON=/home/rth/qemu/publish/tests/dbus-daemon.sh QTEST_QEMU_BINARY=./qemu-system-x86_64 QTEST_QEMU_VNC_BINARY=./tools/qemu-vnc/qemu-vnc ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1 MALLOC_PERTURB_=40 MESON_TEST_ITERATION=1 /home/rth/qemu/bld-pub/tests/qtest/ide-test --tap -k
――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― 
✀ 
――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
stderr:
**
ERROR:../publish/tests/qtest/libqtest.c:998:qtest_vhmp: assertion 
failed: (ret)

(test program exited with status code -6)


r~

