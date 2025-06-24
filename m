Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F2BC77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 11:22:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU1iN-00044W-AL; Tue, 24 Jun 2025 07:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uU1iJ-00044M-T4
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 07:21:20 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uU1iC-0000fE-Fu
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 07:21:17 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-60bfcada295so1964638a12.1
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 04:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750764067; x=1751368867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iRCVTfa8VuthZDRkWLHlmhFG8lrtRPaTCVONYiV0HNo=;
 b=YIFMLav/EqlGXMxrFSjlVunV+6gJMsfZwn6iLpSJFBsOC+XMTr7PToyBNBL/O2/lqK
 RXupJ61teYhlZZh/+8vVeeK+SUPhoZdMgoWNYUxly/2EhRCdUII/OzuP0Rbti/axOVvK
 MCyvOWOdJ8lvbGCI2jAguoG6/ruxm964csRRJL3ebkElwsXKQRRaTazVuMmypzqaX5Zk
 KgcvEQuz1dly5drr+5bSQqGJElv14meRbApdu08JAcnnQqhyC3kUnnAf7bshjN8AVdz+
 AsOu3JKcvtd3x+beY+DJsG2qy2CQG5NURsvrPq/Jcc1kFnm1XSHocX0BTs553sV7z9Yb
 YEDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750764067; x=1751368867;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iRCVTfa8VuthZDRkWLHlmhFG8lrtRPaTCVONYiV0HNo=;
 b=X2j0qG9oN6CXQJMWn8fhpcbeBBqRvlT+AtoCSqSKAvPFPCcGvOpcxRuAKeCfHrnmN6
 zNEI7v6/TjkNmqTyDsfgWCxKrbdzbqa5FtLeh9x6q4IH5NsQFxqU7BnWxrSj4zKa7TU/
 JAw/+NQUM1QSwgLAIJqxAAjOJyB196rtPNOYQ3bsTaqAdUm8zf+itV13z2+hkEWyygYC
 Pxd1aEJmmjPLiHnUKqNiRvJ0u4KiVdbDMlVW68B44qlQqiqLqAhNwVVh9Q9OuTQcxc4z
 jusXHqS/efJic2hPldhQ9icLJG682kM/n3SPv0g63ymsnzpVBullhcgBNMymGbodnR/T
 oMQQ==
X-Gm-Message-State: AOJu0YynMQqj2QaOQa5ALWqNAjxe2pJf9bDAAnPK6LB51eeLUx/ZkQym
 9itbpUQK1a+uP5bTczSKt4yXglBzTZpWgakn2DyB1zUN5iTmtSvglkCMrdLqJg8PyHI=
X-Gm-Gg: ASbGncsrZ7Ql/hxAz1t19gJ7uRDAPGm43dEw99iSNwnPDhxv31HFm7hhGcdvdsyeUwH
 iwJU6JIPaSNeiPQY4Jjdfv1rw0B9dVy4gz3UFPakrw52k/aS8gQVFQ5+HFB7zqxUz1Ovy1pftAF
 5jq3SZZv3XWUYlkkEnGfWZPQLsqG96RuS6DGWbn79DE+ywYgDpyXQeCPPJryex94aHgEj9W7Kc9
 kHDPT9mmLHmXeYdr23vxnD758XoIn5UMpLmmZ6fQ2nptQj9grHeOSCQiu31sQUMlYi0JgQx36JT
 yPaDu62kxNLjIRvCd7GggA/z+3LZHU5xbVNmafvEkJlZjcg8PJ1lhFhXNDPfbuo=
X-Google-Smtp-Source: AGHT+IE7kwiBsKrIYZMAaEaXAzibbGHJ/jV6wJBJ1XNYa5yeUB65YR5B0D7/9MIxJAj3wgUAo4ZZBA==
X-Received: by 2002:a17:907:3f18:b0:ade:4339:9367 with SMTP id
 a640c23a62f3a-ae057a222b4mr1558397766b.26.1750764066878; 
 Tue, 24 Jun 2025 04:21:06 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae053e7fbd9sm858446366b.33.2025.06.24.04.21.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Jun 2025 04:21:05 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 03D525F7C6;
 Tue, 24 Jun 2025 12:21:05 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Rowan Hart <rowanbhart@gmail.com>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  Zhao Liu
 <zhao1.liu@intel.com>,  Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  Yanan Wang <wangyanan55@huawei.com>,  Eduardo
 Habkost <eduardo@habkost.net>,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v13 0/7] Add additional plugin API functions to read and
 write memory and registers
In-Reply-To: <20250619161547.1401448-1-rowanbhart@gmail.com> (Rowan Hart's
 message of "Thu, 19 Jun 2025 09:15:40 -0700")
References: <20250619161547.1401448-1-rowanbhart@gmail.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Tue, 24 Jun 2025 12:21:04 +0100
Message-ID: <87bjqd1j33.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
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

Rowan Hart <rowanbhart@gmail.com> writes:

> This patch series adds several new API functions focused on enabling use
> cases around reading and writing guest memory from QEMU plugins. To suppo=
rt
> these new APIs, some utility functionality around retrieving information =
about
> address spaces is added as well.

I think we are almost there but I ran into a problem with the test:

  =E2=9E=9C  make run-tcg-tests-x86_64-softmmu
    BUILD   x86_64-softmmu guest-tests
    RUN     x86_64-softmmu guest-tests
    TEST    hello on x86_64
    TEST    interrupt on x86_64
    TEST    memory on x86_64
    TEST    hello-with-libbb.so on x86_64
    TEST    interrupt-with-libbb.so on x86_64
    TEST    memory-with-libbb.so on x86_64
    TEST    hello-with-libempty.so on x86_64
    TEST    interrupt-with-libempty.so on x86_64
    TEST    memory-with-libempty.so on x86_64
    TEST    hello-with-libinline.so on x86_64
    TEST    interrupt-with-libinline.so on x86_64
    TEST    memory-with-libinline.so on x86_64
    TEST    hello-with-libinsn.so on x86_64
    TEST    interrupt-with-libinsn.so on x86_64
    TEST    memory-with-libinsn.so on x86_64
    TEST    hello-with-libmem.so on x86_64
    TEST    interrupt-with-libmem.so on x86_64
    TEST    memory-with-libmem.so on x86_64
    TEST    check plugin libmem.so output with memory
    TEST    hello-with-libreset.so on x86_64
    TEST    interrupt-with-libreset.so on x86_64
    TEST    memory-with-libreset.so on x86_64
    TEST    hello-with-libsyscall.so on x86_64
    TEST    interrupt-with-libsyscall.so on x86_64
    TEST    memory-with-libsyscall.so on x86_64
    TEST    softmmu gdbstub support on x86_64
  qemu-system-x86_64: -gdb unix:path=3D/tmp/tmp01eq35b3qemu-gdbstub/gdbstub=
.socket,server=3Don: info: QEMU waiting for connection on: disconnected:uni=
x:/tmp/tmp01eq35b3qemu-gdbstub/gdbstub.socket,server=3Don
  qemu-system-x86_64: QEMU: Terminated via GDBstub
    TEST    softmmu gdbstub support on x86_64
  qemu-system-x86_64: -gdb unix:path=3D/tmp/tmp4wf7k1fwqemu-gdbstub/gdbstub=
.socket,server=3Don: info: QEMU waiting for connection on: disconnected:uni=
x:/tmp/tmp4wf7k1fwqemu-gdbstub/gdbstub.socket,server=3Don
  qemu-system-x86_64: QEMU: Terminated via GDBstub
    TEST    softmmu gdbstub untimely packets on x86_64
  qemu-system-x86_64: -gdb unix:path=3D/tmp/tmpnagp6w_mqemu-gdbstub/gdbstub=
.socket,server=3Don: info: QEMU waiting for connection on: disconnected:uni=
x:/tmp/tmpnagp6w_mqemu-gdbstub/gdbstub.socket,server=3Don
    GREP    file untimely-packet.gdb.err
    TEST    softmmu gdbstub support on x86_64
  qemu-system-x86_64: -gdb unix:path=3D/tmp/tmpnkn1fbmsqemu-gdbstub/gdbstub=
.socket,server=3Don: info: QEMU waiting for connection on: disconnected:uni=
x:/tmp/tmpnkn1fbmsqemu-gdbstub/gdbstub.socket,server=3Don
  qemu-system-x86_64: QEMU: Terminated via GDBstub
  make[1]: *** No rule to make target 'patch-target', needed by 'run-plugin=
-patch-target-with-libpatch.so'.  Stop.
  make: *** [/home/alex/lsrc/qemu.git/tests/Makefile.include:56: run-tcg-te=
sts-x86_64-softmmu] Error 2

You need to ensure vpath is set, something like:

modified   tests/tcg/x86_64/Makefile.softmmu-target
@@ -1,13 +1,11 @@
 #
-# x86 system tests
-#
-# This currently builds only for i386. The common C code is built
-# with standard compiler flags however so we can support both by
-# adding additional boot files for x86_64.
+# x86-64 system tests
 #
=20
-I386_SYSTEM_SRC=3D$(SRC_PATH)/tests/tcg/i386/system
 X64_SYSTEM_SRC=3D$(SRC_PATH)/tests/tcg/x86_64/system
+X64_SYSTEM_TESTS=3D $(patsubst $(X64_SYSTEM_SRC)/%.c, %, $(wildcard $(X64_=
SYSTEM_SRC)/*.c))
+
+VPATH+=3D$(X64_SYSTEM_SRC)
=20
 # These objects provide the basic boot code and helper functions for all t=
ests
 CRT_OBJS=3Dboot.o
@@ -18,7 +16,7 @@ LDFLAGS=3D-Wl,-T$(LINK_SCRIPT) -Wl,-melf_x86_64
 CFLAGS+=3D-nostdlib -ggdb -O0 $(MINILIB_INC)
 LDFLAGS+=3D-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
=20
-TESTS+=3D$(MULTIARCH_TESTS)
+TESTS+=3D$(X64_SYSTEM_TESTS) $(MULTIARCH_TESTS)
 EXTRA_RUNS+=3D$(MULTIARCH_RUNS)
=20
 # building head blobs
@@ -41,4 +39,4 @@ run-plugin-patch-target-with-libpatch.so:		\
 run-plugin-patch-target-with-libpatch.so:		\
 	CHECK_PLUGIN_OUTPUT_COMMAND=3D$(X64_SYSTEM_SRC)/validate-patch.py $@.out
 run-plugin-patch-target-with-libpatch.so: patch-target libpatch.so
-EXTRA_RUNS+=3Drun-plugin-patch-target-with-libpatch.so
\ No newline at end of file
+EXTRA_RUNS+=3Drun-plugin-patch-target-with-libpatch.so

<snip>
>
> Rowan Hart (1):
>   plugins: Add enforcement of QEMU_PLUGIN_CB flags in register R/W
>     callbacks
>
> novafacing (6):
>   gdbstub: Expose gdb_write_register function to consumers of gdbstub
>   plugins: Add register write API
>   plugins: Add memory virtual address write API
>   plugins: Add memory hardware address read/write API
>   plugins: Add patcher plugin and test
>   plugins: Update plugin version and add notes

Could you update the Author fields so the Author matches the s-o-b tags
please and is consistent please.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

