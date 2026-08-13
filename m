Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB323C5CFCF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 00:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuJEI-0007wB-Gv; Wed, 12 Aug 2026 20:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuJEG-0007w2-Kh
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 20:23:28 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuJEE-0007n5-Rt
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 20:23:28 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-38101f85591so432421a91.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 17:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786580605; x=1787185405; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MvUIngn5UnlN6Av1h/W2TzJe9/h2Fh6Y7NSkxl1TwZY=;
 b=e7ZKU4E4tx2J6gohxGK2EF4+P+VFJchfcXGpFhtlx8qXSGTlv+pzc/69LD0pGvAx+K
 R+rFy+MbQ/RhrfhVaHWP+LiMcAwhPQl/79jgyN8CIw85/oOofrNVtPGSX9yooO+VGI9u
 REJq1p7c8xw0P0jy+G0Fie0rBdJ8GTl+mAU3zzSpbdHnNYQL5wEQprtz+IE5N4OU859N
 5s1lLVY1xYd89qwhJ8GOmDCW+LIfTqZbNQRWyI+B3LgDE3Th+LwdhzSZMKR0gD2MEmzB
 bMbitTGZ3wDETYLDXL3jC7UhzhIYiQFhxg4TVPaiPiqnfx5nOU8EehP3U0bKHIKzxotZ
 MXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786580605; x=1787185405;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MvUIngn5UnlN6Av1h/W2TzJe9/h2Fh6Y7NSkxl1TwZY=;
 b=CrbFBBRSOnuX1gMvo3cF99BEMjxdaIk3KKMc9Wuu0x2PGit3FCeXkKB5e34b479fWx
 rBEsRt/7y6KC2ZTBqcVVcBaiy9eZXBrPhnd9Sv4QxKK93xmfJ1ovSQ4Pky9wz5BfXe0+
 O+/pXwyp+ls48LVlqTV8SnlealQleYmNvPpGlD5953kIk6Tdpw4GMVafz39MBLqqg8oS
 3PfMEF1WGd4F2N/l8oN5J7qgZRHZrO2h0ZaMySto26neKPzsuCqVMgJeg9mS9OlXteeO
 3vgbDBveGoZ0iqXM0ZADSNox/VO62JIalUJUdxZgPGFie4mR9UyrJgUMiO9HSA+ojGwS
 w0yQ==
X-Gm-Message-State: AOJu0YxAWZSsCJxoau7dQUTQElvWRQGATBeQ2kLwODTgtO1p/6W7yG7F
 JJ2W/gNSr2suCxEkG4bAp3CxM5D8XwwldeuqPNUcedD7LsPf1Toz+/MPf7Ngg78fbSen04qz3tV
 YD13E
X-Gm-Gg: AR+sD107eIC2j07q5Lu47nI9PxM2DL4Rbgs1VVrUUSuFwfJkMXgVe3wJBah+j19kH9z
 oQwF273Sw/na3+q1Jg5tBuHXo9CDGu0OUtmMnzrz8DAvWbWpG9l/N5mC9QVJuxk4nwaKE0W3JLe
 e4OxVkazlfbENcis5/hTBLhs7VPJyqD4q6gEru7GYAoXF4xDqqJ6ymh9gP+EtDXJIeq6sBGiBk0
 KXee5p+uYdnvn5jNTr+peOVIDfvxcxVEhjPxqggC1ga8g3opIF3FvSijl8FtLb9oXmHcDTUd/gJ
 ZHlPvQ/mLwWZ7G6ntKNZDWQfJ2JAKxExUs5GTKdq+tpTPuK1/RYtJ0eHJ5t22SQLNOvDVoe5PcS
 MzrzpuN0FUa2UKTczo3uaQB0cg4wJpmQR1NNUUnKFH3uokeNWU6LJEli3JtKORGZLJPS+NNpu13
 bn2ft6htq+j+7TnbGg0kVcUsCagjVccQ09qdkNYW+myXno3PsdIuBsDrlPCgWrdH+8j0bWsgvEG
 s7YZfKDIGSrQkTDTNZiIL5XgprH
X-Received: by 2002:a17:90b:4b8d:b0:390:b3c5:e2c9 with SMTP id
 98e67ed59e1d1-3931f965f34mr598794a91.17.1786580604865; 
 Wed, 12 Aug 2026 17:23:24 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3931db4e1d9sm330527a91.4.2026.08.12.17.23.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 17:23:24 -0700 (PDT)
Message-ID: <3305e838-5687-41de-a07c-9f9aaaee4c6e@linaro.org>
Date: Wed, 12 Aug 2026 17:23:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/7] Linux user patches
To: qemu-devel@nongnu.org
References: <20260812203725.10694-1-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260812203725.10694-1-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

On 8/12/26 13:37, Helge Deller wrote:
> From: Helge Deller<deller@gmx.de>
> 
> The following changes since commit 3e3ccab106f879b1512f8e0d51a827dd4de30e22:
> 
>    Update version for v11.1.0-rc3 release (2026-08-04 15:36:08 -0400)
> 
> are available in the Git repository at:
> 
>    https://github.com/hdeller/qemu-hppa.git tags/linux-user-pull-request
> 
> for you to fetch changes up to ce276ab1a92cad460930fada1bc2e2e4a96f7595:
> 
>    linux-user/sh4: write the floating-point registers to a core dump (2026-08-07 18:14:13 +0200)
> 
> ----------------------------------------------------------------
> linux-user patches
> 
> Patches from Mat Turner to support the mount_setattr() syscall and to add
> floating-point registers to core dumps on alpha, mips, hppa, riscv and sh4.

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.2 as appropriate.

r~

