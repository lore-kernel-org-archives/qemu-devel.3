Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BF0E77173
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2024 00:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJj8s-0002eK-Ru; Fri, 06 Dec 2024 19:57:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1tJj8q-0002e5-Pm
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 19:57:52 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1tJj8p-000884-0V
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 19:57:52 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-215d92702feso22814445ad.1
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 16:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733533069; x=1734137869; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zDD4ieEHQBgq6iCHOmI86xja63Ks3TWXyk1SqpXsArU=;
 b=Ot4Fs4QvBcC0pQrz+6vzdhd0vANmFmUTXfdkCPtMMsxEoLObVOLBLqBziiFxikL7jh
 9gstJUjBSEO3tlJ82B7B1Tj8Eh9EzlPLbYGee/dABmh28Il+8h0jVJfhF8ObyI4r2GOC
 9WxRjN7gOr9xEqtB/D8a20qGUKH5imuXkdRmLftDpq4+cPtAd2xuAogtxEFU/kHispz9
 WEUcyw9LIIdfGRiltP3hNzYSChe9gYop2YiJSGt/zI0R8MWkvA6zB7OKh4QabmAgie3P
 q30OTgLnLkpzi4ebIHitx0MVzs1l7/xPtZA1ORPC2gsI0YO5nDH+grkKnrzj+mxwJvlU
 rSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733533069; x=1734137869;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zDD4ieEHQBgq6iCHOmI86xja63Ks3TWXyk1SqpXsArU=;
 b=O2EAqghT5Op/yCO+49faq2lmrRFjO7BRnGaRD3fzfOUuZrhqRSwbe6iSnvvfNIcU1+
 WxuqJgvYLQ/+XYaqB5IFI/DalPEHE4OfRBK+M83/HH7Zkn/3sgahl7nx+Rx12e96NjxD
 CeU50r3/ECV1Pp8eoe/RVCLYQ1G43iO5iI3ELPqK4In1gL/mqxRYFaD6dC3E24/gJXh+
 95jJvn+sYkvruQYLSrqBXBhsx/kV0Z3Ojqd0umYudQPzcIarFIdtCGPq9jzMMZqqqqP6
 I6z7Ajr1MjzvawQebcPsrA7eQkLFeCrftzuzJnLsYtfT8LpTz8iZ9mnP8daL6QTogmK8
 NVvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJ552y2PtVfn0wFbh9MxMouFbFHmsIGbLAW5EYSs6LraQM4LKnpzqxTGSUB3VRL96uWK4TRKHoRjv9@nongnu.org
X-Gm-Message-State: AOJu0YxhWyCOQx6jyULEUA9GfsDVxodsb0zM+/GfJzg7y/EUN+HXFrct
 0ANaNzVFaZWa7F5e6uLhU+VO8dYlPnke8szzbOTHgeNCM21e+Hl/
X-Gm-Gg: ASbGnctHdsYXC7SgFutMxMysyD5pjDeQMNtQ/dyWgElWoOGOosDHY6iCwnT/sAXBPSP
 JXlYQs0TzU9KZ/5jURbUNfCxk9hPafRs7+hsFo5qMNEPbhditMn3iHmQu8fLaVplHgf3llUr8th
 kcIRWR/HzP/HxE+L3mg2iU4Yih19x22Uiz4/xoEKQWZHGG6GTKzDTcdBYjLqUabNamEyBzksT62
 uVhGQ/fSvSb0msWBHGfjNVMeXGR2J5p4tx7qziuLdFYjK1cJUvrpyw=
X-Google-Smtp-Source: AGHT+IEqDxRpdeJVFCNaD+e8LIIjJOAhB2xt6YnjxlBAQWoQKZVsMCGofJZ83V9RDZbQ/5GZYOTycQ==
X-Received: by 2002:a17:902:ea02:b0:216:2b14:b625 with SMTP id
 d9443c01a7336-2162b14cdfamr12993155ad.31.1733533069110; 
 Fri, 06 Dec 2024 16:57:49 -0800 (PST)
Received: from [192.168.1.211] ([50.39.253.148])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215f8f0d18csm33551795ad.204.2024.12.06.16.57.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2024 16:57:48 -0800 (PST)
Message-ID: <2c0893fa-9d84-4003-861b-91a923f9439f@gmail.com>
Date: Fri, 6 Dec 2024 16:57:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Add additional plugin API functions to read and
 write memory and registers
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
References: <20241206102605.961658-1-rowanbhart@gmail.com>
 <55c95bd1-a1bc-460c-b4fe-1f52f8af2c2e@linaro.org>
Content-Language: en-US
From: Rowan Hart <rowanbhart@gmail.com>
In-Reply-To: <55c95bd1-a1bc-460c-b4fe-1f52f8af2c2e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=rowanbhart@gmail.com; helo=mail-pl1-x635.google.com
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

> I am personally in favor to adding such features in upstream QEMU, but we should discuss it with the maintainers, because it would allow to change the state of execution, which is something qemu plugins actively didn't try to do. It's a real paradigm shift for plugins.
> 
> By writing to memory/registers, we can start replacing instructions and control flow, and there is a whole set of consequences to that.
> 

Totally agree! As much as I really want this functionality for plugins, I think
alignment on it is quite important. I can see very cool use cases for being
able to replace instructions and control flow to allow hooking functions,
hotpatching, and so forth.

I don't really know the edge cases here so your expertise will be helpful. In
the worst case I can imagine: what would happen if a callback overwrote the
next insn? I'm not sure what behavior I would expect if that insn has already
been translated as part of the same tb. That said, the plugin is aware of which
insns have already been translated, so maybe it is not unreasonable to just
document this as a "don't do that". Let me know what you think.

> The hypercall functionality would be useful for plugins as a whole. And I think it definitely deserves to be worked on, if maintainers are open to that as well.

Sure, I'd be happy to work on this some more. At least on the fuzzing side of
things, the way hypercalls are done across hypervisors (QEMU, Bochs, etc) is
pretty consistent so I think we could provide a useful common set of
functionality. The reason I did the bare minimum here is I'm not familiar with
every architecture, and a good NOP needs to be chosen for each one along with a
reasonable way to pass some arguments -- I don't know if I'm the right person
to make that call.

Glad to hear you're for this idea!

-Rowan

