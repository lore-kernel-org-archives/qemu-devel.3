Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2EA1C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 19:39:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udwMP-0000Op-Gu; Mon, 21 Jul 2025 15:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1udwL9-0007Jf-Bs
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 15:38:27 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1udwL6-0005Jm-9E
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 15:38:22 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-748d982e97cso4212627b3a.1
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 12:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753126699; x=1753731499; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XViM6QXmF9VO8rSgcGCXlbeuC1ZFPrMq/3E79Tz9DUw=;
 b=vCt0LdjEVqt/yMhwYahgKP7YdmwvguiHSIqiBPbkoNaBWYomo7g2Yh8jHjmBxN2Atv
 QZCWbFAWmWwON//s9du7Pek2riOtHhp0GG7aFe3h5zqpMagzr61xdrOTH68a+MmBTCI0
 hxzmp6I094SHajxW3nsEUOnUGsLYMGRZb7UMzjIHn25fBGbZqks8igt0U8JvcS01PZLe
 zUGGEaQoB8RRlVbKqNteS8EUdWn/wJzx4tb6O1khTuhiphgi4+2yLYy/cMkg55kGErUQ
 FsV+G/vAAtAhuH1O5v2HCw1Ub77bkVl5mVcuNR3oVnGG2+nCAXb7RL7ce8Ipes5p1mld
 5Qwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753126699; x=1753731499;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XViM6QXmF9VO8rSgcGCXlbeuC1ZFPrMq/3E79Tz9DUw=;
 b=wjLmyJ5kSssfYSZPyp09gsOeEFQfkS+JU+zvueMzR3PsJnPK4cvhv5roBGgblLwt7d
 32C+uJ96NzY2uksk26wfcLzVLHlYL9bTACQoaNRsZOqXG6v5OiOXtmbyWarwLyvj53j6
 UPTP7noLN1AALwLsLRassjqLhPZts74lYfH+zzSJiQ5xdQk446RwRUgeEkqJeLahi98n
 7U4KAOP/Vftd9vVqBlt9VFE0g/da+KITzwTVndjPcLLDwWPbsFHJaph4JDimmsNcV8rA
 jsW9r4rMpVexpfHmm91mvuDIexK0ctT2dxpuIMk2BEtJr3BSm66Ksao6LFfSgstd5eek
 Z0tQ==
X-Gm-Message-State: AOJu0YwbCWefiTILflS3Fyir4Sy7YYz5ka1VzKkiqe4QI0tRHOPMC4k3
 MMbARUhs4pKBAoNhZE0zuzqdT9PiF2bIHjLbg1W4oUBM0Z1Mr3e3Gitz50QlyrLWU8cfcCtwGP4
 0v8Lm
X-Gm-Gg: ASbGncu7Ecd6xrSDfe5l9zzbLPy89z6X9+6JKONe/25Zpp6obVW6KBQ0JqVzolWtFE5
 25GDBdD+BbsiQOd2IDth+CBMJ+IHapqIeGxElgBSy2vaWZNpjukIFVmmD8IYHZalL4RayVuF38B
 bEiv5wre3A0FIYnuaczehkgqvO0QmIQ4KFUVPSrUZxMXsVSQMLDGkl5x303t3RaUepFi0QPbF9l
 j/Wu/hkV/F0yOy9UmgfgXa2dktWkI34msgD/EK3ITkPhwaDCrEO+MwxZzO8l68tW+7wkjGL+cv/
 +scdlN/3V5qr+pP3sPQRp2pOKeIzo5JpYKrvWQPKPeicKKKgyR1vAyXitVXQND7iIehkwA1/btq
 PSyDDWoERwfansa4NWM7wzSyX8NzA+dcvqlE=
X-Google-Smtp-Source: AGHT+IFaoVrw1W/w/hMWgGInS45clIuXNMfqmWIZXp2WW/FDdfpdz6jV0RHDfGjrLEiw+ohY7fKfHQ==
X-Received: by 2002:a05:6a20:548d:b0:236:355d:5f27 with SMTP id
 adf61e73a8af0-23813664463mr31132025637.42.1753126698632; 
 Mon, 21 Jul 2025 12:38:18 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-759cb157b49sm6225648b3a.96.2025.07.21.12.38.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Jul 2025 12:38:18 -0700 (PDT)
Message-ID: <8144efbd-99ba-420e-8012-d3e30e49d0b8@linaro.org>
Date: Mon, 21 Jul 2025 12:38:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] contrib/plugins: uftrace
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 rowan Hart <rowanbhart@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250716053407.2814736-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250716053407.2814736-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

On 7/15/25 10:34 PM, Pierrick Bouvier wrote:
> This plugin generates a binary trace compatible with the excellent uftrace:
> https://github.com/namhyung/uftrace
> 
> In short, it tracks all function calls performed during execution, based on
> frame pointer analysis. A big advantage over "uftrace record" is that it works
> in system mode, allowing to trace a full system execution, which was the
> original goal. It works as well in user mode, but uftrace itself already does
> this. It's implemented for aarch64 only (with the intent to add x86_64 later).
> 
> Let's start with concrete examples of the result.
> 
> First, in system mode, booting a stack using TF-A + U-boot + Linux:
> - Two first stages of boot sequence in Arm Trusted Firmware (EL3 and S-EL1)
> https://fileserver.linaro.org/s/kkxBS552W7nYESX/preview
> - Stat and open syscalls in kernel
> https://fileserver.linaro.org/s/dXe4MfraKg2F476/preview
> - Poweroff sequence (from kernel back to firmware, NS-EL2 to EL3)
> https://fileserver.linaro.org/s/oR2PtyGKJrqnfRf/preview
> 
> Full trace is available here:
> https://fileserver.linaro.org/s/WsemLboPEzo24nw/download/aarch64_boot.json.gz
> You can download and open it on https://ui.perfetto.dev/ to explore it.
> 
> Second, in user mode, tracing qemu-aarch64 (itself) running git --help:
> - Loading program and its interpreter
> https://fileserver.linaro.org/s/fie8JgX76yyL5cq/preview
> - TB creation
> https://fileserver.linaro.org/s/GXY6NKMw5EeRCew/preview
> 
> Full trace is available here:
> https://fileserver.linaro.org/s/N8X8fnZ5yGRZLsT/download/qemu_aarch64_git_help.json.gz
> 
> If you had curiosity and now you're ready to give some attention, most of the
> details you want to read are included in the documentation patch (final one).
> 
> Overhead is around x2 (sampling only) to x10-x15 (precise), and long traces can
> be directly filtered with uftrace if needed.
> 
> The series is splitted in:
> - implementing the plugin
> - adding useful options (especially sampling and privilege level tracing)
> - add a companion script to symbolize traces generated
> - add documentation with examples
> 
> I hope this plugin can help people trying to understand what happens out of the
> user space, and get a better grasp of how firmwares, bootloader, and kernel
> interact behind the curtain.
> 
> Pierrick Bouvier (6):
>    contrib/plugins/uftrace: new uftrace plugin
>    contrib/plugins/uftrace: add trace-sample option
>    contrib/plugins/uftrace: add trace-privilege-level option
>    contrib/plugins/uftrace: add timestamp-based-on-real-time option
>    contrib/plugins/uftrace_symbols.py
>    contrib/plugins/uftrace: add documentation
> 
>   docs/about/emulation.rst           | 184 ++++++
>   contrib/plugins/uftrace.c          | 899 +++++++++++++++++++++++++++++
>   contrib/plugins/meson.build        |   3 +-
>   contrib/plugins/uftrace_symbols.py | 152 +++++
>   4 files changed, 1237 insertions(+), 1 deletion(-)
>   create mode 100644 contrib/plugins/uftrace.c
>   create mode 100755 contrib/plugins/uftrace_symbols.py
> 

v2 was sent:
https://lore.kernel.org/qemu-devel/20250721193340.1059019-1-pierrick.bouvier@linaro.org/T/#m58e124c05b43d7b0a73ce62080f45e166f7e01e7

Regards,
Pierrick

