Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0789C71148
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 15:20:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ6Cg-0005He-QF; Fri, 13 Jun 2025 11:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uQ6CK-00059Q-Hw
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 11:20:04 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uQ6CI-0003GR-HQ
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 11:20:04 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2353a2bc210so21326365ad.2
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 08:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749828001; x=1750432801; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nheOvm5jSiPjAJDtQHF4YVCBm7ZH6RNRamec+O4KyUc=;
 b=MlFjZUjaldaK2AHwvTubiZSZPJOzuIoyckY5bd9eaNSni6MBDk1gSj5AgcPsnW8sHx
 lIXTYBPLlEkcr52QPZYvWMx55h9bd1Mkon6CBH+LF7RrNcXjRYyK4L1DbnEdYAgVinSM
 cS4mFALzlG40oM6+tZCEvx8/rB4TylUkuEDPM98zN0FWFPFXSSmE4jtlkdRZnlZTFSfQ
 4zwuH7HiC51BdC7b+2om8I5KQUs6Wx4iOtZR1APJpHn/ZKoatneIolSB3Vbb5OIUUkb0
 IioXhXbwuvmXIu1eN+Zd5fdDOyp3Ex6ISrPe/yTlRWsebupRSc6zkVhwRL8bza9eVfTB
 D4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749828001; x=1750432801;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nheOvm5jSiPjAJDtQHF4YVCBm7ZH6RNRamec+O4KyUc=;
 b=YM22CAdlyyst8HgutOs1n0oRiIszbd1a9XQqAPlq+b7Ybu2DcYcyUgDU7k10S3TSGV
 VbxRS/D8l4hFAOeEGbAynsX+tQFP3YFkT6Hu+FXKbODEy79iFxkls5UT2u3/zodABvEI
 sYZFo6/CA9xNFMKFGz75G0y4VCZ48IIZJZ+eY75a4izLM5IggO+x4B3QYQ+dFTwnu19c
 b0Mm0iAx3IXv9tys6dUSzQg6lnP0/M5oPkhrn33G6F/VXMtAXykTvK4sKYnHkSLM1sCT
 RMX/klyIU/xuDWctpFJzi1XHp5qymw6vGN4uT+X7j5VgcYWjtViUGBkNSYgKD8E6I65x
 bmdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKlUsgFFFp7kGwW8ZRV4+Y9m73jJE5dJ988MCS7hgzWVKkPxYirDND6VhNOpUtKgbaV1kfWqHeqvvE@nongnu.org
X-Gm-Message-State: AOJu0YweqjNIAsqSMZau1gs0zVZ8s1skweQ+JsTDDv0WJC8RyWKz9/O3
 znR46ctRgjIjKBLGtWmxw0FbnCbCF6vY1Fm7nSO3B1SWCom5Q10zUSqbzrV6fYqhIJE=
X-Gm-Gg: ASbGncs1th01ooxjx2CVoVNmhEmnX/rAukxG9Zxo9FRUps3kc9tPjIq5+5fA0NCsQpV
 bBWYOgE/0ykzyVKhLFiV0mRsGlCgUBVmGDqG86bNIUh5Z9jweq1tAEnwFxVREM00qNz8SdsPFs5
 Zd3RDmW0UbDgdMVoFu0uaBltlW39MYOceKzBM5jFhDVr/p6M70rnlj8zgKe5BZ1tt9paJ5uT7GG
 Mh+ty/SjrNpI4G8D2nMNNaOq0x9EES3aF73iPJhZvw7ghDZxgQWcjtpe9ZZp70RpeVgK0WvXG8D
 z9/jQjVLFSDISAy3ipJ01WY8CDaos5cJCq7hWiCGA5cyzOiHxZDHxzxYObP5+NDWmh5Y/cdk3Pc
 =
X-Google-Smtp-Source: AGHT+IF3AJY/KKnIW9KraCt7CZaYKGDAZJsZkp4tTQ8bs9Xlpw1MqhUSBlPTxQGOBOjAJG9F9xO83w==
X-Received: by 2002:a17:902:ccc8:b0:234:bfcb:5bfa with SMTP id
 d9443c01a7336-2365d8a506dmr52650675ad.15.1749828000886; 
 Fri, 13 Jun 2025 08:20:00 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2365deb87ddsm15534215ad.177.2025.06.13.08.20.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Jun 2025 08:20:00 -0700 (PDT)
Message-ID: <3743dd0d-0cfa-434a-ae19-54af637b1528@linaro.org>
Date: Fri, 13 Jun 2025 08:19:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 0/7] Add additional plugin API functions to read and
 write memory and registers
Content-Language: en-US
To: Rowan Hart <rowanbhart@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20250611232409.2936521-1-rowanbhart@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250611232409.2936521-1-rowanbhart@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

@Alex,
series looks good to me now.

Would you like to add comments, or is it good for you also?

Thanks,
Pierrick

