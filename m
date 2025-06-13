Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31CBAC71148
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 15:58:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ6mu-0000L8-Sw; Fri, 13 Jun 2025 11:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uQ6mt-0000Kq-CN
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 11:57:51 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uQ6mr-0008GE-BI
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 11:57:51 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ad8a8da2376so384295266b.3
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 08:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749830267; x=1750435067; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4MebXgKOFnN//odpzFbw1/yPlr8CUgURJ2O38A5IhnU=;
 b=Tta8U5WBoiuQ3gpCtOjbP838BKsB0xOcsFeTqJslGe+2nADgx6m/enDBl/zb0L1DpB
 e2DYdUy0AkT6r7FgQ6cRMIGMWYaiyA61xfuH8RCMZ35UlOl/qsE9uiZOXvPdtSp+Jtye
 oAQGXhJiAfVxX65JufYCsUe2die5cPxlktglW3zWB+1PsovJfy9rfuaazwYUVZA0vLTI
 5zWv6MMlQlo2rGTvkFO/3b3901ivu57r8P9YJDeHiQ8P140EFgiX+E+7B1irRZU4yMWg
 CeAvzApoP7i1fOHRl6kB34+ugRt0wfovD8SL/hV9sebBJLkOqxCSJ+owugXZ6U0ahn5z
 1ktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749830267; x=1750435067;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4MebXgKOFnN//odpzFbw1/yPlr8CUgURJ2O38A5IhnU=;
 b=ctlau9xuHBvNbWPpKZPJaDZrQ60ZkF8RJUayYqtn8Kl96aTa+xuV1rGx8YtcT1gIYG
 8WiliaoxWS1XIWjx5Hd/vzZCAgNHJd4OLJcEcITe3X2kV5TbYwjzCDIhNbj8UUhRm8Fp
 B15f4iY8XpZRyOU0tKh71Mw++3Bo+JfyrSKUK8cdu1H7e9HsbF7sv7rzKza7lbWj6qLC
 e+RWFar9EClUkDGDSNDhbZVW0HCRs7HENCJxvoPqrd+h3oEu+TR6n7aoWeYUUgdqk/QX
 82Krn/BRIR7lrW7UoUY5IEE3O6ZyQ259Uyk4e50LsA7aGdVLYdssOMM+AvWPLSwvxHe5
 HSMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNWUz2lGvdMjKm3N0gsmfC/zu8o0QQhF8jtUe7L8OLYrIXI2QICxHoc12WPsYDhDLDabQQZzwbsJUY@nongnu.org
X-Gm-Message-State: AOJu0YzSnFHs2iADe4Gc6DE8dJGCDL3TfYptzY3Vkir5R2GKnUVt0ZAA
 dtrxqCsKsDQdRrmb9bF/U1JlEt6IrGdF1y+5q8xkQQG8e+Qk+0bX+Zz0jmBp+mqrtTA=
X-Gm-Gg: ASbGncsrkGShOJLWk7DT8R7lLYcgc0Ky6gYm900faD2Vd0nVf9uKTPcQ03LBwghyGtc
 Q4QVAgX5Ddnko6naILm2XeKuv8AZDzpu8gd7QxQVIjzhL08dTwZeL5DBdVZeY0iSSeQYxDFPpt7
 U5/xOdhZ3bcec9GLFFRAnl/kMc/ae4roGFtYyQq5MnArVagJts5tnAz8YdOlC2RQeSvy/is03U8
 ZWpeBiZja/bKWEzbk4kqsMXyCGAreqXho5UucdhxuRt7rSwnoIpsfWqZn1kAP6ouOLjGb5XgIsM
 0Ao6LTanwEdYihMArKYoBRMK5zUINIyr0xxavM6LU5IKJdXhqQyNmHNSabwTuQs=
X-Google-Smtp-Source: AGHT+IEUyUsrmEIT2qGB0s4NrWmnvwVE1S31NPzMbdBBFi1d/gsY/It/kR/vY/qZg8EGHmRPCp1eNg==
X-Received: by 2002:a17:906:f591:b0:ad8:9ab7:a270 with SMTP id
 a640c23a62f3a-adec5c3d478mr376872466b.38.1749830267143; 
 Fri, 13 Jun 2025 08:57:47 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-adec81c2122sm149418766b.57.2025.06.13.08.57.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 08:57:46 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C35B05F827;
 Fri, 13 Jun 2025 16:57:44 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Rowan Hart <rowanbhart@gmail.com>,  qemu-devel@nongnu.org,  Paolo
 Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Yanan Wang <wangyanan55@huawei.com>,  Mahmoud
 Mandour <ma.mandourr@gmail.com>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Alexandre Iooss <erdnaxe@crans.org>,  Zhao
 Liu <zhao1.liu@intel.com>,  Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v12 0/7] Add additional plugin API functions to read and
 write memory and registers
In-Reply-To: <3743dd0d-0cfa-434a-ae19-54af637b1528@linaro.org> (Pierrick
 Bouvier's message of "Fri, 13 Jun 2025 08:19:59 -0700")
References: <20250611232409.2936521-1-rowanbhart@gmail.com>
 <3743dd0d-0cfa-434a-ae19-54af637b1528@linaro.org>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Fri, 13 Jun 2025 16:57:44 +0100
Message-ID: <875xgzhbwn.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 6/11/25 4:24 PM, Rowan Hart wrote:
>> This patch series adds several new API functions focused on enabling use
>> cases around reading and writing guest memory from QEMU plugins. To supp=
ort
>> these new APIs, some utility functionality around retrieving information=
 about
>> address spaces is added as well.
>> The new qemu_plugin_write_register utilizes gdb_write_register,
>> which is now
>> declared in gdbstub.h for this purpose instead of being static.
>> qemu_plugin_write_memory_vaddr utilizes cpu_memory_rw_debug much the
>> same as
>> the existing read_memory_vaddr function does.
>> The read and write_hwaddr functions are the most different. These
>> functions
>> use address_space_rw, which works well in most cases. There is an import=
ant
>> caveat that for writes, the page being written will be set dirty by the
>> write operation. This dirty setting requires locking the page range,
>> which can contend with an already held lock in page_collection_lock
>> when called in a tb translate callback with a write to the instruction
>> memory in the tb. The doc comments warn against doing this, and it's unl=
ikely
>> anyone would want to do this.
>> I've also added two test plugins: one that implements a simple
>> hypercall
>> interface that guest code can use to communicate with the plugin in a
>> structured way with a test to ensure that this hypercall works and writi=
ng
>> virtual memory works. And one that implements a simple patch utility to =
patch
>> memory at runtime. The test for the second plugin ensures the patch appl=
ies
>> successfully to instruction memory, and can use both hw and vaddr method=
s.
>> For v3, I've had a few comments from the last submission that I've
>> addressed,
>> and some that I haven't for one reason or another:
>> - Enforce QEMU_PLUGIN_CB_ flags in register read/write operations:
>> done!
>> - Fix my commit messages and add long messages describing commits: done!
>> - Un-expose AS internals: done! Functions operate on current vCPU, curre=
nt AS.
>> - Clean up use of current_cpu: done!
>> - Make functions take a vcpu_idx: not done. May revisit but it allows fo=
otguns.
>>    Even for translation, seems best to not do this now. We can easily ad=
d _vcpu
>>    versions of these functions in the future if we change our minds!
>> For v5, I've just updated the enforcement of the QEMU_PLUGIN_CB_
>> flags to just
>> use immediate stores, which simplifies the implementation quite a lot and
>> should be more efficient too. Thanks Pierrick for the suggestion!
>> v6 is a formatting pass, I left some whitespace that needed removal,
>> some
>> license text was wrong, and so forth.
>> v8 reverts a mistake I made extending the size of arrays of
>> TCGHelperInfo
>> structs, as I misunderstood their sizes. It preserves adding an explicit
>> zero as the last entry for clarity, however.
>> v9 fixes qemu_plugin_read_register to return -1 on parameter or flag
>> state
>> error instead of 0.
>> In v10, I relaxed the restriction on when the register r/w functions
>> can be
>> called, allowing all them to be used from any callback where the CPU is =
not
>> currently executing, with additional notes in the documentation for exce=
ptions
>> (atexit and flush, which do not operate on a specific CPU and in which
>> current_cpu is not set).
>> v11 makes the cb flags functions inline and fixes a typo where cpu
>> was asserted
>> but current_cpu was actually accessed.
>> v12 removes the hypercalls plugin because the functions it tested
>> are also
>> tested by the patcher plugin, making it redundant. We'll circle back on a
>> hypercalls API in the future as a part of the plugin API, not as a plugin
>> itself.
>> Rowan Hart (1):
>>    plugins: Add enforcement of QEMU_PLUGIN_CB flags in register R/W
>>      callbacks
>> novafacing (6):
>>    gdbstub: Expose gdb_write_register function to consumers of gdbstub
>>    plugins: Add register write API
>>    plugins: Add memory virtual address write API
>>    plugins: Add memory hardware address read/write API
>>    plugins: Add patcher plugin and test
>>    plugins: Update plugin version and add notes
>>   accel/tcg/plugin-gen.c                    |  30 +++
>>   gdbstub/gdbstub.c                         |   2 +-
>>   include/exec/gdbstub.h                    |  14 ++
>>   include/hw/core/cpu.h                     |   1 +
>>   include/qemu/plugin.h                     |  15 ++
>>   include/qemu/qemu-plugin.h                | 176 ++++++++++++++--
>>   plugins/api.c                             | 135 +++++++++++-
>>   plugins/core.c                            |  33 +++
>>   tests/tcg/Makefile.target                 |   1 +
>>   tests/tcg/plugins/meson.build             |   2 +-
>>   tests/tcg/plugins/patch.c                 | 241 ++++++++++++++++++++++
>>   tests/tcg/x86_64/Makefile.softmmu-target  |  32 ++-
>>   tests/tcg/x86_64/system/patch-target.c    |  27 +++
>>   tests/tcg/x86_64/system/validate-patch.py |  39 ++++
>>   14 files changed, 725 insertions(+), 23 deletions(-)
>>   create mode 100644 tests/tcg/plugins/patch.c
>>   create mode 100644 tests/tcg/x86_64/system/patch-target.c
>>   create mode 100755 tests/tcg/x86_64/system/validate-patch.py
>>=20
>
> @Alex,
> series looks good to me now.
>
> Would you like to add comments, or is it good for you also?

I'll do a pass through next week but I think we are in good shape.

>
> Thanks,
> Pierrick

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

