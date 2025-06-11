Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 726D4C7113E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 19:26:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPR5S-00007E-KG; Wed, 11 Jun 2025 15:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uPR5O-00006c-DE
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 15:26:10 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uPR5K-0001Pr-Ed
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 15:26:09 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-234b9dfb842so2558955ad.1
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 12:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749669963; x=1750274763; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HZ0UJUhoS+8woREvP2CZpKuzXxVhx0tZiZ0xEWnSWlc=;
 b=qsWIHthzRSuvggiLRHemWNkHiEFTdrTytHevzRnSye6R3ZVpSNlF3PiPOwGDer46o9
 i6YdLf7fKCDp1yce5dRkh4PLvuXgWcbDgyraRDd4o48cYW1CQhybBuZYF5xoKaUVGM/6
 JBXU7CCkXr9jU5COEM+HB0AiH8BAh5KWnrgOlkJ/3nsOYjb0YS0I2Sgur92oHsiMcm6J
 kyLZ1sx/v12gcECihNFnmslwlq1qWR4EgWh2R3dClAx5K1D/wSIAtPVhGUPqTENHiBhr
 lbI0qfK9JqVvX97vyK8dSiJnh3lCXDnvi5fsZ0Y8Si3rvdVkkvWASFA5x0jLWh2TNB6U
 IKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749669963; x=1750274763;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HZ0UJUhoS+8woREvP2CZpKuzXxVhx0tZiZ0xEWnSWlc=;
 b=SPrsWqJRjBXfRpxg3iL24qCtEs3hs8LOLVn5JvsLBCNgPI9BJR5z8eNlV99DVC0se+
 Ix9nGsB983BCAJ+eOdbQlW4gMPKD6nEuq2+0quolWR6TybYcZWFqeV01HW2+v4N8QmDi
 LNJE/rfiWpeeDC57Al6NSJ2JE5R14ZcT+jOazLqIrWIOOMR80d+l/XC5pD4utiAuXfwd
 v75F+sWJL5H4mDbzBsv6JOY1F5vcVjHzhaTJRiJqHi6VqeQlBE57Jf4zlhiNd3wBWdzV
 RUyKF0/dsmSHJO0D2zKwtNNQq7hEiQHju90iE3sefG47WptWo3EtwfL1GlBeefhepv2a
 e4Jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4gp68lk5FQ/e3/mnkJX/MeSNjM8sneKZbDWhkBHNLNQNO0tdtVmm/YERUT89LdtHjbqnhuMHLqeME@nongnu.org
X-Gm-Message-State: AOJu0YwGHj5cpXcUEBY8EQi9++eqej5oldv7cRkYI56MDTC45kW3KNDY
 wN/RvUrTeVVW+VCAGsNzd5VAdyR7fVwJyI3kO7SMEaM1R+YBc5GBnUfcoKOHseTsrLU=
X-Gm-Gg: ASbGnctHt8R6SpqzQs4T6mTz+UB64wXL2MGODNtyscLmLrsoCL6gbR54D/uLH2eg63R
 Yp2aDejzOjpAoETAsgFdSkxBRBC6Ew0qzJmt8zyw/V1OX+pY9zcASkQNGQKNfrmBJzK7LTbd82q
 VDqOOhMzaThMrVtCWxD0XgD7XIaeQyWNNJongcpckcThD/cR9o0T9WS7mSVE/Cduxwq7dyawhn5
 quwqOi/AWxiyXoRvUmJuEsbDgZrePYi22m2+x7jPxCeRo963hYFoYqOEppAiXewCV6JJZl8cqKQ
 DVeIJHM2FbevfIqWA4OZRaSR3PsLBmco0pW8Ig7e4zyJwmGr4X07VAws8MgDPQKEspMxqZ17LdU
 =
X-Google-Smtp-Source: AGHT+IH6mtZc3MsnpVMi27oycK56bmbL/n1Vol56QcmcNPZAHT4ksdGALQ65mQ+jhyf3Ch/CTur3Ww==
X-Received: by 2002:a17:903:3c2f:b0:235:1b3e:c01c with SMTP id
 d9443c01a7336-2364d8ef6f9mr4365845ad.39.1749669963420; 
 Wed, 11 Jun 2025 12:26:03 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23603514b3esm91697095ad.258.2025.06.11.12.26.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Jun 2025 12:26:02 -0700 (PDT)
Message-ID: <02f706f1-4dde-4f6f-b806-7882d57e5de6@linaro.org>
Date: Wed, 11 Jun 2025 12:26:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 7/8] plugins: Add hypercalls plugin and test
Content-Language: en-US
To: Rowan Hart <rowanbhart@gmail.com>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Alexandre Iooss <erdnaxe@crans.org>
References: <20250609193841.348076-1-rowanbhart@gmail.com>
 <20250609193841.348076-8-rowanbhart@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250609193841.348076-8-rowanbhart@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

On 6/9/25 12:38 PM, Rowan Hart wrote:
> From: novafacing <rowanbhart@gmail.com>
> 
> This patch adds a plugin that implements a simple form of hypercalls
> from guest code to the plugin by using the register read API. It accepts
> only one hypercall, which writes a magic value to guest memory.
> 
> Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
> ---
>   tests/tcg/Makefile.target                     |   1 +
>   tests/tcg/plugins/hypercalls.c                | 547 ++++++++++++++++++
>   tests/tcg/plugins/meson.build                 |   2 +-
>   tests/tcg/x86_64/Makefile.softmmu-target      |   6 +-
>   tests/tcg/x86_64/system/hypercalls-target.c   |  40 ++
>   .../tcg/x86_64/system/validate-hypercalls.py  |  40 ++
>   6 files changed, 634 insertions(+), 2 deletions(-)
>   create mode 100644 tests/tcg/plugins/hypercalls.c
>   create mode 100644 tests/tcg/x86_64/system/hypercalls-target.c
>   create mode 100755 tests/tcg/x86_64/system/validate-hypercalls.py

Hypercalls are a very nice idea, and could help to write code aware of 
instrumentation, to send specific events to a plugin.

Introducing this in a specific plugin is an excellent proof of concept, 
but if we want something upstream, we'll need a proper plugin API 
implementation. That means one where a plugin can register a specific 
hypercall_nr (checking it's only registered once), and can read 
arguments and return values: in short, reinventing a proper syscall 
convention. This is what has been achieved in the current patch, the 
idea would to wrap all that on QEMU plugins side.

In more, we should provide a portable header, allowing any code to 
include it. All that with fixed width types, so it's not affected by 
differences between architectures. This way, any system code, or user 
code, can include this, and communicate with a (compatible) plugin easily.

No need to cover all architectures at once, we can start with only i386* 
and arm* targets, and extend that later.

That said, I think we should leave this out of the current series for 
now, as it's not directly related to what is introduced, but it's 
definitely something that would be nice to see in the future, with the 
requirements above.

Thanks,
Pierrick

