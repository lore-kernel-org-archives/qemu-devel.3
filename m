Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 285A1E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 20:37:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWLl0-0003PD-BR; Fri, 10 Jan 2025 15:37:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tWLkz-0003OP-2m
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 15:37:25 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tWLkx-00062U-3I
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 15:37:24 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2ee51f8c47dso3403854a91.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 12:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736541441; x=1737146241; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p8DmYKFWWsyjc4B3ztk4tJe7NDrLkV1jaoXYH/suVI0=;
 b=nbUdF8aqL8PiHv4hol0mfV2FjegeqBCALQCoSpoRVTWsWld3felTZaEOsFGBujrCFx
 N7H/3chVanw9N/n8eI32ZYrpd/TM0zx0yOLMaZY69kvnL6OPXox+ZOgIPWiOn/bPkyEe
 lEOEq4rl4nSPE8aWfvxqUHPMt2/TsUHUsY+gyQJvTRvKME2YWufpo9yc1t+jq1og+fow
 /2/F/dDWq1+6MpNINapmZ6E76iVlaAIVSOsjACDFoizJ9yVLkjAS7ASZJ7sUuhrRu16t
 IMPuyBiCVAbXyUiJiWhPpvapT2lNBA1IaKTUGJ4hWNtJ4KrLKP6Z0QVrwGp6CWQajSZ0
 dZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736541441; x=1737146241;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p8DmYKFWWsyjc4B3ztk4tJe7NDrLkV1jaoXYH/suVI0=;
 b=Ud5QZgh//WnNCnu+NW2ftVs1FA6BURWcmc8YSzM+ynt5g6P+wK46R02vBHAvT0GrBI
 2Ee+L9e46icYEAAr9zwRzJSMJ3mb7ULeIflNDHUV51M7tkLyUTktgYRzWCLTYM+HNOiy
 HHqODKMYz/0sSppOziT5yyjyPXWr5fmC+D0p9zMMJvuxBTwR79Nccc1oasGdjTdBSmIT
 nxfqPPVtqNYcs2/dgDhxQpihQC/QsCFETCc5anZsT9Cuk31KwZp0XbMw7m8iordLx3XU
 owL2k+JuvdqqIsew3qXkykgxTgpe2gHZg32rTobDI1ntbFIpXZ7MFhTR2enoSfAXVyTG
 pToA==
X-Gm-Message-State: AOJu0Yw+0jQmFXwz6vBncOADiJDrNIB86LfNsvHdzyo5V2wZpdoSEjoZ
 ijA94HVM9j7j95h06tDRs92H5VVoz+sYwUFrt4iKOrC+6F9eBzYgN4a9TthFvOYbeed8E0eGKGF
 Xf1SEcw==
X-Gm-Gg: ASbGncs1mu03iX7AD6/4PhKEXhFQxXUgDcI5n8iB+pnu9hSezCU0cl0kcvugTZ/WGwg
 QiqcTQg1AbU/3if2dUJpnnC9CSMwzeCCr+izGmNn16i0H3APXY/06K39yCOF0Jf++NKh2lQ6nMD
 aGtk+ZsLzicXQeC2nNq84/av0QJ0CknWlsOV3vXvy+q+o5X1XZ14U4NlR3d5dm0HdF+DDshty8O
 tdvnsbv4B3qn4DrDUFiFqWCkcg5y+cyXfF2YTIHXDHVeFEjXnAbgsWESBa0FtwUOWsxPQ==
X-Google-Smtp-Source: AGHT+IG44Z6RlBj1wfrHpGEUul0QD5bXXMebAVm16vZbR5ofgSoAw1fOQRqUqO0ZR5xIVC2VgXKQ/w==
X-Received: by 2002:a17:90b:254e:b0:2ef:19d0:2261 with SMTP id
 98e67ed59e1d1-2f548eae703mr19700429a91.16.1736541441219; 
 Fri, 10 Jan 2025 12:37:21 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f5594512f0sm3644612a91.36.2025.01.10.12.37.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 12:37:20 -0800 (PST)
Message-ID: <73fd2f38-76a0-4274-875a-6f96faed79f6@linaro.org>
Date: Fri, 10 Jan 2025 12:37:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] Enable clang build on Windows
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20250110203401.178532-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250110203401.178532-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102a.google.com
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

On 1/10/25 12:33, Pierrick Bouvier wrote:
> For now, it was only possible to build plugins using GCC on Windows. However,
> windows-aarch64 only supports Clang.
> This biggest roadblock was to get rid of gcc_struct attribute, which is not
> supported by Clang. After investigation, we proved it was safe to drop it.
> 
> Built and tested on Windows (all msys env)/Linux/MacOS for x86_64 and aarch64
> hosts.
> 
> v1 contained warning fixes and various bits that have been upstreamed already.
> The only bits left in this series are the gcc_struct removal, and fixing the
> plugins build with clang.
> 
> This series is for 10.0, as we decided to not include the gcc_struct removal is
> 9.2 release.
> 
> All patches are now reviewed, so this series can be pulled. I'll report that to
> MSYS2 too, so we can enable clang environments for QEMU.
> 
> v1: https://patchew.org/QEMU/20241031040426.772604-1-pierrick.bouvier@linaro.org/
> 
> v2:
> - drop attribute gcc_struct instead of using -mno-ms-bitfields option
> - add a section about bitfields in documentation
> 
> v3:
> - explain why gcc_struct attribute matters in packed structs in commit message
> - reword the bitfields documentation with suggestions given
> 
> v4:
> - edit for bitfields doc requested by Philippe
> 
> Pierrick Bouvier (3):
>    win32: remove usage of attribute gcc_struct
>    docs/devel/style: add a section about bitfield, and disallow them for
>      packed structures
>    plugins: enable linking with clang/lld
> 
>   docs/devel/style.rst                      | 20 +++++++++++++++++++
>   meson.build                               |  6 +++---
>   include/qemu/compiler.h                   |  7 +------
>   scripts/cocci-macro-file.h                |  6 +-----
>   subprojects/libvhost-user/libvhost-user.h |  6 +-----
>   contrib/plugins/meson.build               |  2 +-
>   plugins/meson.build                       | 24 +++++++++++++++++++----
>   tests/tcg/plugins/meson.build             |  3 +--
>   8 files changed, 48 insertions(+), 26 deletions(-)
> 

It would be nice if a maintainer could pull this, so we can get this 
merged upstream.

Thanks,
Pierrick

