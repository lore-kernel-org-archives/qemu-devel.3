Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B29C7115A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 16:21:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSI0f-0007Lm-5f; Thu, 19 Jun 2025 12:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uSI0c-0007LF-An
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 12:21:02 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uSI0a-0005Pq-0K
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 12:21:01 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-748d982e97cso830380b3a.1
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 09:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750350058; x=1750954858; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7Q/jPrFQks9CS5h/sXmHpIj3IDBJp4J/tZOP7tO+Kws=;
 b=luG4JgAkb14c38d6gUwttk+a9AGHT/zejbP7m3oqp9piB0bDANB18DzEjPlQlqKbN3
 aPyZ4FqnBjNHG15s5+Ab1kNIYYSGD96uH2vuRRMR413HSvxkrW1xXRS36DT4Jte5MfIV
 bsCSmqpqT8QjL54lSpYIttyXboShCJieZ5Zk4ig2uP2Kj/KPMeSyXNW/3CHHZ0wBVqeo
 bh1I5RmtCTK3wwJBkZgKV7moCBFMz6kjeBgkTt/Cs7fu0RjablyEWxc+eZxWjZb4Vku1
 niyVBEE8CcO7dDTBGhEjj0WQ2OKHxhUfyxz/r9ayUDJotBkbi35wJqHvrY1aPMpF++/U
 qzRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750350058; x=1750954858;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7Q/jPrFQks9CS5h/sXmHpIj3IDBJp4J/tZOP7tO+Kws=;
 b=fqqzdPGItgNqpPgotoRSPYg8SvAhF5HFKH13WEMLA4CwVMEWpFtIDCxhtB6EK0GQWO
 f6NYyO+gygokPjORucIS8TgYnA+bGSiXy12loXSo4Cliwl7YtuRaHp2JJTczp5BMzjw3
 jN8ctEuFdlOm1fem/c7XQB0Bo1/N/eb2X5FSAcT7zSP8DTi38TO4dhI/GDANYgIUJwx/
 3rhXzGGymRsZpLlHiUTcMdfM1Zpe5ztyG5cgoiym6tb09SoSuvXytfwg3aU1gfHcnUhI
 unOu5m6AQ+6PV6aF3y1BuwK1G6LGE+xiLKxEnDO3SC8yheydJjSoUa4BPWJOyJFRzGHZ
 qOag==
X-Gm-Message-State: AOJu0YxUBq68YlZdC4h0yMphLJdaEszNVW50UD5rcQ1kk201nsD1TbV7
 GzverHgoxKEtb2YnxmYy5yoVBR3THQeLgN4DqXAeWwljXKPXHQaCT2l9HEN7j7yh
X-Gm-Gg: ASbGncsbSNepOmkGZhaUv2ZYZn4lwhsE+bmq7g5FAx1tqoAp1SfDYXse84Gfwjw6BjW
 BwhYvp+2FusgEwMxz9NuaavT9apVn/I0p1OMV5AysKtyFxvgzXzCNccjjeeSw7pqSHqzzDwUpV7
 yu/eqv8YG4b/IsOCWOwsiPXyrtZMXx/xlwfdF932kqa9hqZXz8Gh6dgcFncQ5M/u31ArOYdXRsG
 uiHDKUj7ralCeB0YyyYooA+k8UktAg1PMxtY9oKkGn/Cuopbmms+/hTAiZSh9i9nRZq64H7j73Z
 l/AD3KLI0Re10sk2O7XmZeToWHauo//fiPqX/ovaouCcKigqzjBP5tGTyol7E/dCXt3Idfqjh8N
 f
X-Google-Smtp-Source: AGHT+IFj5DKBjuHdgXUjBTFKvNFo3ggplsCZV3GGk55jakvMtIOYcNMErZetyZofGUat/R0jQ7iovQ==
X-Received: by 2002:a05:6a00:4fce:b0:746:3200:620 with SMTP id
 d2e1a72fcca58-7489cfdb032mr27248929b3a.9.1750350058032; 
 Thu, 19 Jun 2025 09:20:58 -0700 (PDT)
Received: from [192.168.1.119] ([50.46.174.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a4a3528sm212521b3a.70.2025.06.19.09.20.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Jun 2025 09:20:57 -0700 (PDT)
Message-ID: <767979a5-95be-490d-a135-74a3e5a4e2f6@gmail.com>
Date: Thu, 19 Jun 2025 09:20:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 0/7] Add additional plugin API functions to read and
 write memory and registers
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20250611232409.2936521-1-rowanbhart@gmail.com>
Content-Language: en-US
From: Rowan Hart <rowanbhart@gmail.com>
In-Reply-To: <20250611232409.2936521-1-rowanbhart@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=rowanbhart@gmail.com; helo=mail-pf1-x42d.google.com
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

I've updated this patch to address some notes about the build/test 
configuration for the patch plugin. Please check 
https://lore.kernel.org/qemu-devel/20250619161547.1401448-1-rowanbhart@gmail.com/T/#t 
instead.

On 6/11/25 4:24 PM, Rowan Hart wrote:
> This patch series adds several new API functions focused on enabling use
> cases around reading and writing guest memory from QEMU plugins. To support
> these new APIs, some utility functionality around retrieving information about
> address spaces is added as well.
>
> The new qemu_plugin_write_register utilizes gdb_write_register, which is now
> declared in gdbstub.h for this purpose instead of being static.
>
> qemu_plugin_write_memory_vaddr utilizes cpu_memory_rw_debug much the same as
> the existing read_memory_vaddr function does.
>
> The read and write_hwaddr functions are the most different. These functions
> use address_space_rw, which works well in most cases. There is an important
> caveat that for writes, the page being written will be set dirty by the
> write operation. This dirty setting requires locking the page range,
> which can contend with an already held lock in page_collection_lock
> when called in a tb translate callback with a write to the instruction
> memory in the tb. The doc comments warn against doing this, and it's unlikely
> anyone would want to do this.
>
> I've also added two test plugins: one that implements a simple hypercall
> interface that guest code can use to communicate with the plugin in a
> structured way with a test to ensure that this hypercall works and writing
> virtual memory works. And one that implements a simple patch utility to patch
> memory at runtime. The test for the second plugin ensures the patch applies
> successfully to instruction memory, and can use both hw and vaddr methods.
>
> For v3, I've had a few comments from the last submission that I've addressed,
> and some that I haven't for one reason or another:
>
> - Enforce QEMU_PLUGIN_CB_ flags in register read/write operations: done!
> - Fix my commit messages and add long messages describing commits: done!
> - Un-expose AS internals: done! Functions operate on current vCPU, current AS.
> - Clean up use of current_cpu: done!
> - Make functions take a vcpu_idx: not done. May revisit but it allows footguns.
>    Even for translation, seems best to not do this now. We can easily add _vcpu
>    versions of these functions in the future if we change our minds!
>
> For v5, I've just updated the enforcement of the QEMU_PLUGIN_CB_ flags to just
> use immediate stores, which simplifies the implementation quite a lot and
> should be more efficient too. Thanks Pierrick for the suggestion!
>
> v6 is a formatting pass, I left some whitespace that needed removal, some
> license text was wrong, and so forth.
>
> v8 reverts a mistake I made extending the size of arrays of TCGHelperInfo
> structs, as I misunderstood their sizes. It preserves adding an explicit
> zero as the last entry for clarity, however.
>
> v9 fixes qemu_plugin_read_register to return -1 on parameter or flag state
> error instead of 0.
>
> In v10, I relaxed the restriction on when the register r/w functions can be
> called, allowing all them to be used from any callback where the CPU is not
> currently executing, with additional notes in the documentation for exceptions
> (atexit and flush, which do not operate on a specific CPU and in which
> current_cpu is not set).
>
> v11 makes the cb flags functions inline and fixes a typo where cpu was asserted
> but current_cpu was actually accessed.
>
> v12 removes the hypercalls plugin because the functions it tested are also
> tested by the patcher plugin, making it redundant. We'll circle back on a
> hypercalls API in the future as a part of the plugin API, not as a plugin
> itself.
>
> Rowan Hart (1):
>    plugins: Add enforcement of QEMU_PLUGIN_CB flags in register R/W
>      callbacks
>
> novafacing (6):
>    gdbstub: Expose gdb_write_register function to consumers of gdbstub
>    plugins: Add register write API
>    plugins: Add memory virtual address write API
>    plugins: Add memory hardware address read/write API
>    plugins: Add patcher plugin and test
>    plugins: Update plugin version and add notes
>
>   accel/tcg/plugin-gen.c                    |  30 +++
>   gdbstub/gdbstub.c                         |   2 +-
>   include/exec/gdbstub.h                    |  14 ++
>   include/hw/core/cpu.h                     |   1 +
>   include/qemu/plugin.h                     |  15 ++
>   include/qemu/qemu-plugin.h                | 176 ++++++++++++++--
>   plugins/api.c                             | 135 +++++++++++-
>   plugins/core.c                            |  33 +++
>   tests/tcg/Makefile.target                 |   1 +
>   tests/tcg/plugins/meson.build             |   2 +-
>   tests/tcg/plugins/patch.c                 | 241 ++++++++++++++++++++++
>   tests/tcg/x86_64/Makefile.softmmu-target  |  32 ++-
>   tests/tcg/x86_64/system/patch-target.c    |  27 +++
>   tests/tcg/x86_64/system/validate-patch.py |  39 ++++
>   14 files changed, 725 insertions(+), 23 deletions(-)
>   create mode 100644 tests/tcg/plugins/patch.c
>   create mode 100644 tests/tcg/x86_64/system/patch-target.c
>   create mode 100755 tests/tcg/x86_64/system/validate-patch.py
>

