Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F35ACE77173
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2024 01:02:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJjD9-0003SM-Fs; Fri, 06 Dec 2024 20:02:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1tJjD7-0003Rt-1S
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 20:02:17 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1tJjD5-0000D0-B4
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 20:02:16 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7253bc4d25eso2182705b3a.0
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 17:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733533333; x=1734138133; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QLjMntMNYMt6ZCvmnvQ2+4GvszUDvk5iKu3g04zv9O0=;
 b=Fd50Z2aRWcyIKwxVsX6Lz2nnwuGUsNnaQZqt/M4ZHS2cPPVxZ1e81oYBCk4aigytNn
 zAZxzI88buXyVRdJe+YqNZZtZcDCX9WI/KO2P1/yD4SBSDvIGMq5ysA8qflzTdLyf8ng
 aDEgYH3zMWhfUXEONhiRCsD/hFxJD4OB6qkLWawhpIQY9gL8c6dDBiK7izGXWF+WQYw2
 MJWJfUpuMM1X4m7zUkjJPQGbPJRTmYBFFltNXJoe1+0KazsAQb/16UZk9+G7fLfKhX1x
 kPq5g84dzGKc/HrwYSgCKigi1THS0babwWoJnQrsHX9VJ5rBdJAtnq1zx5rDQTHsNqYv
 p3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733533333; x=1734138133;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QLjMntMNYMt6ZCvmnvQ2+4GvszUDvk5iKu3g04zv9O0=;
 b=dd+3CmW6EhqQqTrEqSf6k8RjBY2erLvkevZV4o8OEwDHcfNi4nePszq8FPMK8cioeR
 kFO0U6DutCL/XgZaOVI24ES/q9w4Z5xg0I0JVmAY/ugA72QPufuz+PNt2IwQwNY4ZOc1
 SQMtfJI58yiVIMPGNHZd9JojKSgDN5H16sfDGpMYNQ4MtOoU8WLb7DnjLekzGTjXfcOf
 mcv30TPRE2P3Dn6+av4aybcJCBwNuFYuwyhX+JwLuZBnWzdN+YNU5/VlilVN8iqLX1gE
 EQSGPtyxw2ybZ0g4rTUrWEm+W6LpLxRJS5PZhTSrZgCiSN8fLI3RiH4JP59TsgZDY48J
 Mv2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWR6lMYngq+qfEiIo6be3tU0vQLxuh2VLVcD37ldS8mDsBSZphNr+B9JHcaXcMSlvU91mKJYvKgYVU+@nongnu.org
X-Gm-Message-State: AOJu0YxIeSTxIZMfJcZGcyPnGAmnhZ0R2knoOHw/cqWWiltFEOQm0c9C
 SbZHR9FnSvPFzv77fEX+i0vxc+/z/BkEKwTeCwDnDssDlzRXaAOO
X-Gm-Gg: ASbGncsq9jo72qUvN397E9Kzwcu2VCOknQxkuuE+2EVA/BfbKhYv9iAV1krWpjrFo1T
 rddKpp2HQAXhvBeSatzzUJr3OhSMVuWW/nlwrcICCEyDGpv5VwKct+uPJxpcLR7lhkHFD/seKfu
 C9AHMYc6ilAOzYw3x8EzqUQoYFszSc35PTFBOW9C0QKWXuNU161hgbewWKcHUY89a70wIQZwfBo
 p0BDlOdKi4SR/b5fCr5sUuwBUafbjKGERpXN30rh+GAqT6SIfBKbYc=
X-Google-Smtp-Source: AGHT+IEuxrnOfzy+gi1Am5/yu1irnoXN3yMRiWKha8Zr586PmcrVUrP0lM2l48zGEskyJR+JuRNV7A==
X-Received: by 2002:a17:90a:cf97:b0:2ea:4c4d:95a1 with SMTP id
 98e67ed59e1d1-2ef41c98ac2mr14858541a91.17.1733533333194; 
 Fri, 06 Dec 2024 17:02:13 -0800 (PST)
Received: from [192.168.1.211] ([50.39.253.148])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2eeffb5fcb7sm5706256a91.0.2024.12.06.17.02.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2024 17:02:12 -0800 (PST)
Message-ID: <8e25cab2-6809-4a66-b3f1-f9570f408614@gmail.com>
Date: Fri, 6 Dec 2024 17:02:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] Add inject plugin and x86_64 target for the inject
 plugin
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20241206102605.961658-1-rowanbhart@gmail.com>
 <20241206102605.961658-4-rowanbhart@gmail.com>
 <5ec40cb8-8a9d-4d13-b78e-79ea30317dbf@linaro.org>
Content-Language: en-US
From: Rowan Hart <rowanbhart@gmail.com>
In-Reply-To: <5ec40cb8-8a9d-4d13-b78e-79ea30317dbf@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=rowanbhart@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

>> +++ b/tests/tcg/plugins/inject.c
> 
> Could we find a better name? 

For sure, maybe "hypercalls.c" since that's really what it's mostly about.

>> @@ -0,0 +1,206 @@
>> +/*
>> + * Copyright (C) 2024, Rowan Hart <rowanbhart@gmail.com>
>> + *
>> + * License: GNU GPL, version 2 or later.
>> + *   See the COPYING file in the top-level directory.
>> + */
> 
> We can add a comment here about what the plugin is doing. 

Will do!

> One challenge with picking a random value, is how to ensure this pattern has no other meaning for all architectures? I'm not sure we can find a single pattern of bytes that works for all arch, even though that would be definitely stylish :).
> 
> In more, it seems that we are reinventing the syscall interface, while we already have it. But as the current instrumentation only works for user-mode, having a specific hypercall interface might be worth it for plugins, so system mode could benefit from it too.
> 
> The work done here could serve later to define a proper interface. 


I'll see what I can do about this. SIMICS supports many architectures and has a
"magic instruction" interface[0] (basically hypercalls) and has these
instructions defined per-architecture in a way that at minimum there are 12
values available which work on every architecture the simulator supports. QEMU
supports more architectures than SIMICS but I think we could start there and
follow a similar approach.

[0]:
https://intel.github.io/tsffs/simics/simics-user-guide/breakpoints.html#Magic-Breakpoints

-Rowan

