Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB319EB2700
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 20:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpumi-0003W4-7F; Tue, 10 Feb 2026 15:56:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vpumf-0003Vm-H3
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 15:56:34 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vpumd-0007V2-VS
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 15:56:33 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-483487335c2so20122695e9.2
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 12:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770756990; x=1771361790; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zx6YtEc7AuZO26GcTS5nIEmDiU7hzmE3ne+1tMZ8k6g=;
 b=Ud+oXkmqD3Jmn/QLp2/r/h0vqEsvmXebvREURSC6z4P7THCTncSKUtxQ6D5g3Rm/k1
 FZWoOhX+hOFHWdpU7MMbNoIGawIre5o8bhycpqgsebu4myJVYwlvbXSV/06kqPTWje8E
 +7SmQezF7VSOJ76k09qWAVOur2Kxqi+Pos4j22JlATTQmJZYadhQzhwb4jbpVWjGIzLF
 1FxKFkgz+tNN9DBlgon7MQMZyaBkPWmkN/m57iK+5GzudRVu9fgIV1DDVFtuRz8b/NIV
 cY7IiSoJDNTUYNYrGzObeLJZWb45fEUPE/zTaM0k9hkhj9d6Xw+PUQOrF3UTBQDrVkZ6
 vsMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770756990; x=1771361790;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zx6YtEc7AuZO26GcTS5nIEmDiU7hzmE3ne+1tMZ8k6g=;
 b=kxrcleLIAyXJ/vS9TbJS4VW30vu+YDrsFLswrn+zFIbtg3DL+vflSWkJRQNFr29cyg
 f7s0gJuM7e1nyO4ujxUyLctGYlmk5jhwf2mInd4vJNg70YOqXh8GKk/lhIenIdzzUNlC
 cbxy2byFMqoFZYRXXIOA/frCDU7EEZKj0F4FDYbl2EEfUv/y+mWoUz+R4ZI0Jf2m9t8X
 yfctkGNT3Q6baBHn6gg7ocCm+eRaXWRXuRPnPPC6Mx1jbruuoOKhrU6ycausIzfHHieC
 p0MSp1eHIDU6WLZs4NbAfS1Tlx5oN+Bp3wKN+otl29kCpxvpFwtmhaOLRidZldmKGoJA
 fKqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCnLd9hniom/Te+IqGAGBiQdY0W9glvnxHcbjHh3AdqPoWBbT59OwnPIdu5Tb/VKmuXv/MlVgxt4U4@nongnu.org
X-Gm-Message-State: AOJu0YzMih7xAktkQXjGPXGgHJ28gNB3H7ElSAppGfFDqIwWW6cD74ki
 lOb7n7FzX5gZgByOjnbzgc4NSbVYJgfuxaNEbIeUnX4ehtds8Vt2a93C9N1QuWM7VRM=
X-Gm-Gg: AZuq6aKlQWod+CaPTpz9xlRSYEWeIMsRX73FsRPffWBuQ8iHe9hcaFzahkS9j0YncDo
 SaeaGdcDKQJJPOQPY2iXAKBqFWIt69BH/QybSURUIipXz48JexZR/i8SJ3AZfvEBOna9Sn8HPIj
 3fyjCSwYD7OIf+f9W+QA/1aHTY1KXRuBQco/qh3eWAri5J9EGVXBtsEb9O1Xtpp5nC83bKEK052
 udA9TO/8J3ZQ5OEhK66fN7ZgQuiiCJEiyMo46MgQ2ysLWnFcxyiPH78xubvsyfKSzX4q6BBWSvz
 mgau7FjstZ3CCCohhUuwTLerNVhfSNLWEcSkNY1qfi7/kCZQUEmT/mfkmV1GIiTNbbpJ7Ol6Sie
 9ZrjPND4N5UjUo9PjjKs7kCg7JVn1Ll5MW5uvUbggXnCJk/5HfBW7SC8j2CIRutC1OT+F0QgNoy
 ZNtiNo1ZVeYThEHoE/BI7yirX2zytIjAgO8fA4xAmjZUFBtgENd5CWxEY8zpIy75U=
X-Received: by 2002:a05:600c:8215:b0:480:4c20:6a06 with SMTP id
 5b1f17b1804b1-48320966792mr252273705e9.17.1770756990190; 
 Tue, 10 Feb 2026 12:56:30 -0800 (PST)
Received: from [10.123.89.66] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835ba3e4b5sm1992065e9.5.2026.02.10.12.56.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Feb 2026 12:56:29 -0800 (PST)
Message-ID: <def06a55-ab7f-4a2b-b43d-f9571c26a5a1@linaro.org>
Date: Tue, 10 Feb 2026 21:56:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] bsd-user: Remove NetBSD supprot
Content-Language: en-US
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Brad Smith <brad@comstyle.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, Ryo ONODERA <ryoon@netbsd.org>
References: <20260210-bsd-user-rm-openbsd-netbsd-v1-0-8b8b0f50c29d@bsdimp.com>
 <20260210-bsd-user-rm-openbsd-netbsd-v1-3-8b8b0f50c29d@bsdimp.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260210-bsd-user-rm-openbsd-netbsd-v1-3-8b8b0f50c29d@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 10/2/26 16:06, Warner Losh wrote:
> Remove the NetBSD specific code form bsd-user. It's not been maintained
> in any meaningful way since it was introduced to the tree in 2008. It
> hasn't been connected to the build since 2021, and last time (in 2023) I
> tried to mock-up the meson support it needed, it failed to build. While
> there were some out-of-tree work, I've not been able to connect with
> that code.
> 
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>   bsd-user/netbsd/host-os.h           |  25 ---
>   bsd-user/netbsd/os-strace.h         |   1 -
>   bsd-user/netbsd/strace.list         | 145 --------------
>   bsd-user/netbsd/syscall_nr.h        | 373 ------------------------------------
>   bsd-user/netbsd/target_os_elf.h     | 148 --------------
>   bsd-user/netbsd/target_os_siginfo.h |  82 --------
>   bsd-user/netbsd/target_os_signal.h  |  69 -------
>   bsd-user/netbsd/target_os_stack.h   |  56 ------
>   bsd-user/netbsd/target_os_thread.h  |  25 ---
>   bsd-user/qemu.h                     |   8 -
>   bsd-user/strace.c                   |  17 --
>   bsd-user/syscall_defs.h             |  13 --
>   12 files changed, 962 deletions(-)

Typo "support" in $Subject.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

