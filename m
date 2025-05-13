Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E71C3ABCB
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 00:55:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEdvB-0000u0-31; Mon, 12 May 2025 20:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEdv9-0000tn-Fl
 for qemu-devel@nongnu.org; Mon, 12 May 2025 20:54:59 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEdv7-000657-R0
 for qemu-devel@nongnu.org; Mon, 12 May 2025 20:54:59 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-30c47918d84so3477047a91.3
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 17:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747097695; x=1747702495; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TRD8yRMAAGaI2UIcemd4wTkw17yH0HU/JAzRtU/MTD8=;
 b=lhWUunKd+XnIB8ixOmNDXPBfrvoXqGUZFkqLzOLV8dEfxVVuoPi/JlG6j6Q1cQFtCx
 5yooYDqd/LK8dK6cl/EbhEhHCOs+YyiI9LukpvkH9amGeJC7I6+OPwvuUpJ8eCoMM1Lc
 q6057xuBJISBM3fP6ZV//yUgHsLac3FRzy4YwaEtFvphjZGo/Y7t6H1SWmUHx+EGQsCg
 cB/DJuXDsatt2PnU2lTw+o3VVNnyQglpMfa1zoQFMZCPJH5vjE/0aH9BFcqeE6JTfqGI
 mAlUSaRrtA60ZllmLgqCoitAmsPZrCKrKBbgMohNRwqiGKvZgKViVLtkC1U57PjnF/tT
 CqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747097695; x=1747702495;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TRD8yRMAAGaI2UIcemd4wTkw17yH0HU/JAzRtU/MTD8=;
 b=KGHSMahu8cLX3bXxwjXWc3F3wEmGoI0ySvV1APRghDlKeTLiF4DIdcs09TgOrHM1/I
 XOZSDCjefZ1pspvDVGPcZ6YwtfpXlQwbzS6qZuLaEtb8a3gyPoJWV5/etV4c3DxwQJsw
 NENX8K/dheGx4HmmHovP+E+91w9tNpDu/4tuojta8kcNCQcn4+sWdsH+2IynSNe5GBW1
 zSuEGZ495YEyMKzaw/jiiyQbEW/UDgpSi2j8CU+Y4hnDeE1GXhiAZe1IoK3H6Cc/zkFk
 kBjoLXnKOjE8FHU+Fum3WCiXiMOLu17bWdDQuLECjT/y8fyVwSNrQIKIUqGW05ZoC6wG
 leeA==
X-Gm-Message-State: AOJu0YzFwusxF7WkM8UMDlkt8gL511Jk7rs4NpZSZKtfSU1ZF0E+isMJ
 rBAb9y8ix90/VW62oICTHKu3azn//4G/ZufNHmshVBgsWrOx1v7sTScouEqzM+A=
X-Gm-Gg: ASbGncupKenqblfqt8trGQEnWrnfHpD4Mz0gR1LxTg7JLn2daO653o61cLoB2PlBUi1
 obQ3R/VZEAHK2ULjfaBJsQvz4HZfmbO+5Sn+IgbjjUe+gMpkItVuEXoI0u9RsMFVtPd4YO4+eQk
 Sy/Jxtro1hne0zbX1dWboCGtFGel/IWBUQZL/RJrMO9uNlErLPYkE+FUNvfYhKMWkdC82IfFIsL
 /5fKxyvSeTHjNaY4zAEah1O2hlEFW6vvzlarQxrP735wOtwN4OHw7AaXapHGVaneZyAXrXXXT7H
 7HsVRdj74WD1wwAgHNlhTC0xzuIe6ZtAz3YF3F+IIG766xcLKREp+9bCF8O+3ziD
X-Google-Smtp-Source: AGHT+IHdop6i1VPz726VsZKd6KwfmqRIgr8t8i2n8+o5GMyTUHRZH6OsAv5QoRh/Kg4y5sxOhyNwew==
X-Received: by 2002:a17:90b:4acb:b0:2ee:f677:aa14 with SMTP id
 98e67ed59e1d1-30c3cefb8f0mr23876370a91.13.1747097695538; 
 Mon, 12 May 2025 17:54:55 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b2349ec78c3sm6164734a12.31.2025.05.12.17.54.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 May 2025 17:54:55 -0700 (PDT)
Message-ID: <b57200ba-4a5f-4788-b38c-2af064a15439@linaro.org>
Date: Mon, 12 May 2025 17:54:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] qapi: expose rtc-reset-reinjection command
 unconditionally
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250508135816.673087-1-berrange@redhat.com>
 <20250508135816.673087-2-berrange@redhat.com> <87ldr4zt3d.fsf@pond.sub.org>
 <aCI_A7ymWf-f3fOT@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <aCI_A7ymWf-f3fOT@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1031.google.com
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

On 5/12/25 11:33 AM, Daniel P. Berrangé wrote:
>>> diff --git a/stubs/monitor-i386-rtc.c b/stubs/monitor-i386-rtc.c
>>> new file mode 100644
>>> index 0000000000..ee2e60d95b
>>> --- /dev/null
>>> +++ b/stubs/monitor-i386-rtc.c
>>> @@ -0,0 +1,10 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "qapi/error.h"
>>> +#include "qapi/qapi-commands-misc-i386.h"
>>> +
>>> +void qmp_rtc_reset_reinjection(Error **errp)
>>> +{
>>> +    /* Nothing to do since non-x86 machines lack an RTC */
>>> +}
>>
>> I think I'd create one stub file per qapi/<foo>-<target>.json.
> 
> That's what I started doing but I forgot that doesn't work out well
> with the linker.
> 
> The linker's granularity for dropping stubs is per-file, not per-symbol.
> 
> If /any/ method in a stub/nnn.c file is needed, the linker will pull in
> all methods. This results in duplicate symbol errors if only a subset
> of stub methods were actually needed.
>

Richard mentioned this behaviour as well, but I could not see where it 
is implemented in our build system.

The only thing possibly related is the undefsyms mechanic, but from what 
I understand, it's only for ensuring modules can be linked.

> This forces us to have a separate stub file per build configuration
> scenario that can affect use of stubs.
>
> With regards,
> Daniel


