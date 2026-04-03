Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A875E88D72
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 23:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8nek-0005AJ-BX; Fri, 03 Apr 2026 19:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8neh-0005A7-JG
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 19:10:23 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8nef-0007o7-HO
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 19:10:22 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-c76c067bc51so859498a12.0
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2026 16:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775257819; x=1775862619; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Vtu3++4bHZsPuF2kuzUUioLGhPqBLhqys8hkU1odsK0=;
 b=L/TMkTDsr19sCliKXxeXc/0FbldM2VObGpV1j55SGYsxztLJKDQCTiWxpfXphC4AcS
 /IfKn27I7Cie83mV7DNBamg7S0VYKXm4GnzHqZ+rn3hNTWpiJ6HJgIQO6wcabRqsnnIr
 Tw+kjFXBIG4i0dGKxj6nHmTlA8u06a4ee95GKShs8edthRQfuvOLlXaB73kRK8Z20Q67
 icZ9q4xe3hc9r79ALLSCitOD8XEy1ExaTqN9xvmbAk29nDTovTRXIQZqIMgYxaMiROpu
 4oSDDwlBUWbzuo8+Cyz5FmjFejwV4iIXg5NVYbW849inpPxuP+KRqCH4nVMZS8Psb++c
 VwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775257819; x=1775862619;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vtu3++4bHZsPuF2kuzUUioLGhPqBLhqys8hkU1odsK0=;
 b=VVs6czW+81vrV+wRjBtacuo/r8eOhCKq31ljP4oqGxVZxdnfpmXRUvXBbwXzXCHfe4
 k9ocRARNdOkN76k4ZB9MgOsMYZDNz0c5v9NQkf9+ogDOuMYi1ZTF0O0pUK3wSg76RQDV
 JnWHG0Dx/Vgwj+7J+OGkaLeyAgtKiBDkazBnKpvfiL7EPU1Pm1euAGuPjBCmrl5rVwFV
 2qOWmHhAT1rBB5UWZf6NyqsPTnVAG/walPzmVzL05xcLCO2nFbbf1hniAxdFzWIjHpv2
 JrjkF2PkeelfvDXGo+tAm+MVnivk0g4T7U9lBsZLdoJJSA6tj6abdCfJqF11Bt34/gIL
 e7Mg==
X-Gm-Message-State: AOJu0YxDNJyOC+T6DIM3B4wA0TGKl4j16RUYwZxLQdMPfJva5s0gY9yv
 1BIbAejfan7E9x9WSKukCR/sTHzyRSRdl/eRMWjTl8Mm0nZzzZ3iP4wDMUPKFI59KiqdPj58SyD
 zQ6NRVNk=
X-Gm-Gg: ATEYQzyFH/EXycksgwUZaEvXwUs1X+QOaXZBFG7AeDuZ5W6Adw2wqLZPJjALLrSxtJi
 J/zF9ryJscBh4Iq8iJlMm/lhRuHwd/esFIewDyEEeKf52vqg0qZy/9RZ8rzWboYQ4cHT4HwcHds
 McdX5hixow05tEVaEBtYXbQLdUPsmywF5EEE8I2oECFDAuLPKkmNckiun92Eyt1fmR5UA2NELL/
 U7tIvkel7u6XjOoMt0SNgAfczCFiB89IHHRD4i/BE0cYlIKOwIp4BSQP7sIniQrtc1oF7ZZTpg7
 6u/0GzWeqYemJELTNij2UrYThP6M8Ctbo37fYAWcx40L0z8fMcC8Nmtt8I2REtqtUwaunXXwPYf
 DCXDpwp9vvSpREQcMSyNGlq3d5cB1j3X974uFiEl1YgHAwL20kYOiSvb7ehRe8IFkB5sFJ+KA6s
 aIQTnTZ+eOlHJCY0fbipgVheTRcCb+mWBrbKS+t3k3+xisUKWlryPkzNNqzAZ9ZGxqEOhVWP/wb
 WYy9w==
X-Received: by 2002:a05:6a20:9195:b0:398:7357:bb91 with SMTP id
 adf61e73a8af0-39f2f2b25b2mr4329474637.33.1775257819073; 
 Fri, 03 Apr 2026 16:10:19 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9c4126bsm6782420b3a.36.2026.04.03.16.10.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2026 16:10:18 -0700 (PDT)
Message-ID: <027b8930-0e78-4501-b412-37128d299d01@linaro.org>
Date: Sat, 4 Apr 2026 09:10:13 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RFC: Allow building qemu tools on 32-bit hosts
To: qemu-devel@nongnu.org
References: <20260402132801.16053-1-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260402132801.16053-1-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

On 4/2/26 23:28, Helge Deller wrote:
> From: Helge Deller <deller@gmx.de>
> 
> Qemu's tools like qemu-img are often needed on 32-bit platforms,
> although the actual qemu emulators have been discontinued on 32-bit.
> 
> To allow building the tools on 32-bit this patch implements two small
> changes:
> 
> a) The check in meson.build is changed to still error out if the user
> tries to build qemu-system or qemu-user on a 32-bit platform, but allows
> building tools (e.g. by "--enable-tools") alone.
> 
> b) Remove the compile time checks in atomic.h because:
> - for the qemu-system and qemu-user emulators this check is redundant
>    since we only allow 64-bit platforms anyway (see a)

No it isn't.  It double-checks that we don't pass e.g. Int128.

> - it breaks those 32-bit platforms, which do provide (slower) 64-bit atomics
> - 32-bit platforms without 64-bit atomics will fail instead with linker errors
> - the runtime speed of the qemu tools aren't actually that important.

Only i686 and armv7 have these.

I agree that other 32-bit hosts could fall back to libatomic, but we'd need to actually 
use it.

> I've sucessfully tested building qemu tools on 32-bit hppa.

Really?  So where does the 64-bit atomic come into it?
Was it in code that was compiled but not actually linked?


r~

