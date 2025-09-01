Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C27EACA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 17:08:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut80l-0003Rd-Uh; Mon, 01 Sep 2025 13:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ut80g-0003QG-Lj
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 13:08:03 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ut80b-0007PC-B1
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 13:08:02 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6188b72b7caso4686355a12.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 10:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756746476; x=1757351276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=orWjuVAFHst9T4fMpM5J41zgWDbGusSzw4sexZQPgNo=;
 b=s9400tAk7IgLyfQUhsgS5UxTNuN5EWpVghthSLlKe3jw9uy2gpTjsRl1p4JR0Yk1gZ
 CzjnGOaM0S8myZZ1swVHCwFeB9XStE3ZPBYYU1LdJ4brZEJg74mI51tUgHsoZ0MDrQiY
 xckbR5D8mK94Dtw9sM1iOo5iZb6QmxR/jgIMsnvo1YqPsRI/w1M2wUiWSreLF37IFc9c
 viZ3w0/V5FVNy4mnZL433Xr/rRRNsm9IUALUnk43wAe2CqDVwXxinMcwQn7KjlPrii61
 8Sa9eEGYtdfVJUTlq8Ikp1fFhHpJPpyFulsMT2zokMBOxCLlsF04pJlDozDzHwb7PSDz
 xbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756746476; x=1757351276;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=orWjuVAFHst9T4fMpM5J41zgWDbGusSzw4sexZQPgNo=;
 b=KdXzFiJ05YTeeUPncr1ulKWyI1+rmlzas2Ox/W3JlNq7BD0evbIIaUUofuhjaYN7Ux
 fjcbG2JEAkbZTjspiKeyYbM55u7ZoJ1rZ3GJ4BBOovqG1zU98ac3VBhmu/8+7GMgdrs8
 wxXzLNhRE2BDkQOVpVNAwlp380WJUlkYRHT4I/ElwK2n9YCJhvjBd/TOoNmginKyzCEr
 kLBUKLqODl4EEVgKPAEoMDTeOikWsizReAb7+NKvtW8dgmoUbIrJa8cov3nmRsHpOZdo
 Jd3wnVeHRbqUZyWo6tPRKKVJM6NiABnoVo6aSyxTalysrve0c2/hEiQP4WJJYRH11CFE
 d5qQ==
X-Gm-Message-State: AOJu0Yws84Q7aiSj3hzjtdUb20UiLp/CoXyR+u3M09HyIIMnXnu76Gvj
 7l3MlFFu4bGGVJltHyDyIIQ5ahvE7Nr/pm/ev0VEeOFpzoFILmnMUPQbhdF1kIbGevI=
X-Gm-Gg: ASbGncso2vi+tnW2SmHp5UZ4nyfScE38mAmVyppvTa82wvdTUfQVAy6QYi7RuovV9KJ
 /8M+Kg4gCKo8b6kUqqi3+CEsLggh8mFgf6WKbu3RybK+xSSbGKh6b/RIbMkitFqqwripBdcXiC+
 V/1P86eRUUYh3R4vmKVI3yy2wB/W4zRIId5YNa4vLe5zT8ig9Ghmvi2gcaO/i7aax9lPan+aKpb
 H4VSRKDliwXAGUTUcPV7YtEKmNJDN7BrFnyYWW6gmbmHUVK+owfcfaIglLDiJnd61TAt4+O37n+
 AIoLhd99QwZL+3bXcNoZYUnWMhXsH6zkVKTLH5bhD8Jqg5mTJkUW61WwV6LZ/YOW0Xx/+vKGFhj
 dvaBssD7StV4U+bq80TQ3EBkjkUKuAYqXaA==
X-Google-Smtp-Source: AGHT+IHmRK9wzccaOCME7xc0/Pfg9i3w1zxmEgHKO63SP55K15hPl2kSLaKq9eiZB4iO3xrdZY1/kg==
X-Received: by 2002:a05:6402:505c:b0:615:78c6:7aed with SMTP id
 4fb4d7f45d1cf-61d26ebcdffmr7147226a12.32.1756746475740; 
 Mon, 01 Sep 2025 10:07:55 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61cfc4ea764sm7521840a12.40.2025.09.01.10.07.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 10:07:54 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 025E45F81C;
 Mon, 01 Sep 2025 18:07:54 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  rowan Hart <rowanbhart@gmail.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Gustavo Romero
 <gustavo.romero@linaro.org>,  Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,  Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PATCH v6 0/9] contrib/plugins: uftrace
In-Reply-To: <a39236c9-d6e7-4ff3-81a0-bf83b579475d@linaro.org> (Pierrick
 Bouvier's message of "Fri, 22 Aug 2025 07:32:24 -0700")
References: <20250808204156.659715-1-pierrick.bouvier@linaro.org>
 <a39236c9-d6e7-4ff3-81a0-bf83b579475d@linaro.org>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 01 Sep 2025 18:07:53 +0100
Message-ID: <87y0qy14pi.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 2025-08-08 13:41, Pierrick Bouvier wrote:
>> This plugin generates a binary trace compatible with the excellent uftra=
ce:
>> https://github.com/namhyung/uftrace
>> In short, it tracks all function calls performed during execution,
>> based on
>> frame pointer analysis. A big advantage over "uftrace record" is that it=
 works
>> in system mode, allowing to trace a full system execution, which was the
>> original goal. It works as well in user mode, but uftrace itself already=
 does
>> this. It's implemented for aarch64 and x86_64.
>> Let's start with concrete examples of the result.
>> First, in system mode, booting a stack using TF-A + U-boot + Linux:
>> - Two first stages of boot sequence in Arm Trusted Firmware (EL3 and S-E=
L1)
>> https://fileserver.linaro.org/s/kkxBS552W7nYESX/preview
>> - Stat and open syscalls in kernel
>> https://fileserver.linaro.org/s/dXe4MfraKg2F476/preview
>> - Poweroff sequence (from kernel back to firmware, NS-EL2 to EL3)
>> https://fileserver.linaro.org/s/oR2PtyGKJrqnfRf/preview
>> Full trace is available here:
>> https://fileserver.linaro.org/s/WsemLboPEzo24nw/download/aarch64_boot.js=
on.gz
>> You can download and open it on https://ui.perfetto.dev/ to explore it.
>> Second, in user mode, tracing qemu-aarch64 (itself) running git
>> --help:
>> - Loading program and its interpreter
>> https://fileserver.linaro.org/s/fie8JgX76yyL5cq/preview
>> - TB creation
>> https://fileserver.linaro.org/s/GXY6NKMw5EeRCew/preview
>> Full trace is available here:
>> https://fileserver.linaro.org/s/N8X8fnZ5yGRZLsT/download/qemu_aarch64_gi=
t_help.json.gz
>> If you had curiosity and now you're ready to give some attention,
>> most of the
>> details you want to read are included in the documentation patch (final =
one).
>> Overhead is around x5-x15, and long traces can be directly filtered
>> with uftrace
>> if needed.
>> I hope this plugin can help people trying to understand what happens
>> out of the
>> user space, and get a better grasp of how firmwares, bootloader, and ker=
nel
>> interact behind the curtain.
>> v6
>> --
>> - fix types and spelling mistakes
>> - use _MAX for privilege level enums
>> - uftrace info file: use empty strings
>> - trace flush: assert we wrote all data
>> - doc: added style for keyboard keys
>> - added URL to document uftrace entry format
>> - updated comment in vcpu_tb_trans to explain why we always instrument t=
he first
>>    instruction in tb
>> v5
>> --
>> - addressed Alex comments
>> - split plugin implementation in several commits
>> - removed instruction based timestamps (only use time based timestamps)
>> - removed sampling implementation
>> v4
>> --
>> - add support for x64
>> v3
>> --
>> - fix missing include unistd.h (build failed on MacOS only)
>> v2
>> --
>> - trace active stacks on exit
>> - do not erase map generated in system_emulation
>> - add documentation to generate restricted visual traces around specific=
 events
>>    of execution
>> Pierrick Bouvier (9):
>>    contrib/plugins/uftrace: skeleton file
>>    contrib/plugins/uftrace: define cpu operations and implement aarch64
>>    contrib/plugins/uftrace: track callstack
>>    contrib/plugins/uftrace: implement tracing
>>    contrib/plugins/uftrace: implement privilege level tracing
>>    contrib/plugins/uftrace: generate additional files for uftrace
>>    contrib/plugins/uftrace: implement x64 support
>>    contrib/plugins/uftrace_symbols.py
>>    contrib/plugins/uftrace: add documentation
>>   docs/about/emulation.rst           | 199 +++++++
>>   contrib/plugins/uftrace.c          | 876 +++++++++++++++++++++++++++++
>>   contrib/plugins/meson.build        |   3 +-
>>   contrib/plugins/uftrace_symbols.py | 152 +++++
>>   4 files changed, 1229 insertions(+), 1 deletion(-)
>>   create mode 100644 contrib/plugins/uftrace.c
>>   create mode 100755 contrib/plugins/uftrace_symbols.py
>>=20
>
> Ping on this series.
> Comments from reviewers have been addressed.
> Alex, are there other changes you would like before pulling this?

I thought there were the some changes Philippe asked for? I can pull v7
once it is posted. There is no massive rush as the tree has just
re-opened.

>
> Regards,
> Pierrick

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

