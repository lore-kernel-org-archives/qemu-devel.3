Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85494C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 02:56:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whevf-0002vs-MH; Wed, 08 Jul 2026 22:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1whevU-0002vI-8C
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 22:55:50 -0400
Received: from smtp186.sjtu.edu.cn ([202.120.2.186])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1whevK-0003Ml-Jn
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 22:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sjtu.edu.cn;
 s=default; t=1783565733;
 bh=gE5J388KiKTS/zGKxovQdf6eUr6MSb8ockYoHppkvSI=;
 h=From:To:Cc:Subject:Date;
 b=Aa8AYsH7cEV5YYP0CgCgx8rLv0/YqGjM/ozXMMuZIioseUGMfV6mEjNG6AFG0Du6n
 O3RffU/2u8R/UVvGyHOh+2oTJeDp1euxBC0Vjzh3XleaoEBfhoLSBnZwC38+rOix7W
 bVsVtgoURkML5ppp40TvtudXSOuyT6Ypho9XJKtrCwy0cr7faoAIRCuf7GffSbJen9
 w5WVX2vsHayKIor5EGEOsS5rgz5GCLpLhP6hHtkEtLLU87kEoRP1PhmOT9xz/TkQ/w
 B3ToXuUM8YkEydtlxVpSFPG1T6afxf/iBk/LTD0MHTZMIFzL0syVCaBoFZ2qSEANw3
 GxvMPzUCwwNkQ==
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp186.sjtu.edu.cn (Postfix) with ESMTPS id A8FC5300252;
 Thu,  9 Jul 2026 02:55:33 +0000 (UTC)
Received: from pc.. (unknown [202.120.40.100])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 17304380CA3;
 Thu,  9 Jul 2026 10:55:30 +0800 (CST)
From: Ziyang Zhang <functioner@sjtu.edu.cn>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>,
 Ziyang Zhang <functioner@sjtu.edu.cn>
Subject: [PATCH v9 0/2] contrib/plugins: add dlcall to call host functions
 from a guest
Date: Thu,  9 Jul 2026 10:55:26 +0800
Message-Id: <20260709025528.300019-1-functioner@sjtu.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.120.2.186;
 envelope-from=functioner@sjtu.edu.cn; helo=smtp186.sjtu.edu.cn
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Hi,

This patch adds a single plugin, contrib/plugins/dlcall.c (~250 lines,
no changes to QEMU core), that lets a linux-user guest call functions in the
host's native shared libraries instead of emulating them.

It is the natural next step on top of the vCPU syscall-filter callback that I
contributed and that was merged earlier:

  https://lore.kernel.org/qemu-devel/20251214144620.179282-1-functioner@sjtu.edu.cn/

Why bother? Because it turns slow, instruction-by-instruction emulation of a
library into a native host call. Some results, all on completely unmodified
guest binaries:

  * minizip (the stock zlib utility) compresses several times faster, because
    the actual deflate runs natively on the host instead of being translated.
  * Real OpenGL/Vulkan games run under qemu-user: SuperTuxKart and Hollow
    Knight are playable, with their graphics calls going straight to the host
    GPU.

How it works
============

The guest makes a system call with a reserved number (4096 by default) that no
real Linux ABI uses. Its first argument selects a pass-through operation, and the
rest carry operands:

  syscall(4096, op, arg1, arg2, ...)
          |     |    \............ operands (pointers / values)
          |     \................. which pass-through operation
          \....................... the reserved "magic" number

The plugin registers a vCPU syscall filter: before QEMU forwards a syscall to
the host kernel, the filter runs, sees 4096, performs the operation on the
host, writes the result back, and tells QEMU the syscall is consumed, so the
real kernel never sees it.

The whole interface is just a handful of primitives:

  * query a host attribute
  * dlopen / dlclose a host shared library
  * dlsym a symbol, and read the last dlerror
  * invoke a resolved host function with a void(void *, void *) signature

That is all the plugin does. It knows nothing about zlib, X11 or OpenGL, or
about any library's calling convention.

The same machinery also runs in reverse: when a host function needs to call
back into the guest (a qsort comparator, an allocator, a GUI or game callback),
control re-enters the guest to run the callback and then resumes the suspended
host call. This reentry is what lets stateful, callback-driven APIs work, not
just leaf functions.

Why the plugin belongs in QEMU, and the rest does not
=====================================================

Only the plugin lives in the tree. Everything else is ordinary userspace:

  --- userspace (out of tree, not tied to any DBT) -------------
      guest: unmodified program  ->  guest runtime + thunk libs
  --------------------------------------------------------------
                 |  syscall(4096, op, args)   (only crossing point)
                 v
  === inside QEMU: THIS PATCH, ~250 lines ======================
      dlcall plugin:  dlopen / dlsym / invoke a host fn
  ==============================================================
                 |
                 v
  --- userspace (out of tree) ----------------------------------
      host: host runtime + thunk libs  ->  real libz / libGL ...
  --------------------------------------------------------------

The split is deliberate, and it is why only this one file is proposed for the
tree:

  * This plugin defines the most general interaction interface for native
    pass-through: the magic-syscall ABI between an emulated guest and its
    emulator. That contract is what every pass-through implementation builds
    on, so it belongs in a stable, shared place.
  * It is also the only piece that is inherently QEMU-specific: it plugs into
    QEMU's syscall-filter hook and runs inside the QEMU process. The argument
    marshalling, calling conventions, callbacks/reentry and per-library
    coverage are not tied to any particular DBT and behave as ordinary
    userspace, so they should stay out of tree rather than couple QEMU to them.

Background: we presented this approach at KVM Forum 2025, "Lorelei: Enable QEMU
to Leverage Native Shared Libraries":

  https://www.youtube.com/watch?v=_jioQFm7wyU

The userspace side
==================

A fair point on v3 was that, on its own, the plugin is only half of an
interface: useful only if the other half (the guest/host runtimes and the
per-library thunks) is public and specified, rather than a private demo. That
half is now available as a standalone, documented, CI-tested project, Lorelei:

  https://github.com/rover2024/lorelei

Lorelei provides the guest and host runtimes and a Thunk Library Compiler
(TLC, built on Clang LibTooling) that reads a library's headers and generates
the guest and host thunks automatically, including the awkward cases of
function-pointer callbacks and variadic functions. It has CI for x86_64, arm64
and riscv64 hosts. Lorelei and its thunk libraries are MIT-licensed.

Adding a thunk is deliberately little work, and needs nothing but a release.
Lorelei's releases ship a prebuilt toolchain (a "devkit"); after unpacking one,
a single command reads a library and its headers and generates both the guest
and host thunks, with no per-function code, no manifest and no build system to
drive:

  devkit/bin/LoreMakeThunk.py --name z --lib libz.so.1 --header zlib.h -o thunks

Two runnable examples come with Lorelei, each with a Makefile that does exactly
this and runs the example under the plugin in one step:

  * hello, a minimal one-function library:
    https://github.com/rover2024/lorelei/tree/main/examples/hello
  * demo, variadic functions and a callback that reenters the guest:
    https://github.com/rover2024/lorelei/tree/main/examples/demo

If you do not have qemu or an x86_64 rootfs on hand, the project also ships a
small Docker setup that builds qemu and runs the examples for you, so a single
command reproduces the whole flow.

Because the plugin is not upstream yet, Lorelei currently builds and tests
against the QEMU fork that carries it. Its releases ship prebuilt guest and
host thunk trees for x86_64, aarch64 and riscv64 hosts, so trying it out does
not require building from source:

  https://github.com/rover2024/lorelei/releases

The plugin stays deliberately minimal and prescribes nothing about how
thunking is done. Lorelei is one reference implementation of the userspace
side. Any toolchain, or another instrumentation framework, can implement the
same dlcall interface.

A from-scratch walkthrough of the bare mechanism, with the minizip and
OpenGL/X11 examples above, is also available here:

  https://github.com/rover2024/qemu-passthrough-test

It is fully opt-in (loaded with -plugin) and targets linux-user, where the
guest and host already share a trust domain. The test cases use x86_64 guests
and run on x86_64, arm64 and riscv64 Linux hosts.

Feedback on the plugin and on the pass-through approach is welcome.

Changes since v8:

  Following Pierrick Bouvier's v8 request, the guest program in the
  docs/about/emulation.rst example no longer links with an rpath. It carries
  no rpath at all, so which libhello.so it loads is chosen entirely by
  LD_LIBRARY_PATH at run time: the baseline run puts the guest build there,
  and the thunk run puts the generated guest thunk there in its place. The
  plugin code is unchanged.

Changes since v7:

  Reworked the docs/about/emulation.rst example into a complete, self-contained
  walkthrough, following Pierrick Bouvier's v7 review:

  * Included the full source files and the exact compiler commands for the two
    libraries and the guest program, runnable end to end.
  * The example now shows the thunk as a drop-in: the same unmodified guest
    program prints "from guest" with its own library, and "from host" once the
    generated guest thunk is placed ahead of it on LD_LIBRARY_PATH.
  The plugin code is unchanged.

Changes since v6:

  Addressing Pierrick Bouvier's v6 request that trying the userspace side need
  only the release, with no second repository to clone:

  * The thunk generator now ships inside the devkit that Lorelei's releases
    provide, as bin/LoreMakeThunk.py. After unpacking a devkit, a single
    command reads a library and its headers and generates both the guest and
    host thunks, producing all the boilerplate itself. It takes plain
    command-line arguments, with no manifest or config file and no
    cmake/make/git behind it, so the whole flow is: download a devkit, run one
    command, run the guest under the plugin.
  * docs/about/emulation.rst: rewrote the hello walkthrough to that flow
    (download a devkit, one LoreMakeThunk command, run under the plugin) and
    pointed the example links at the lorelei repository, where the examples now
    live. The plugin code is unchanged.

Changes since v5:

  Following a discussion with Pierrick Bouvier on making the userspace side
  easy to try, this version focuses on that.

  * docs/about/emulation.rst: expanded the example into a runnable hello
    walkthrough (the wrapped one-function library and its thunk manifest) and
    added links to the two example directories, hello and demo. Each example
    comes with a Makefile that builds the thunk and runs it under the plugin in
    one command, plus a small Docker setup for hosts without qemu or an x86_64
    rootfs. Also reframed the section as a dynamic linking function call
    interception mechanism (tracing/auditing as further uses, acceleration as
    one use) and renamed it to "Dynamic Linking Call".
  * The plugin header now names it "dlcall (Dynamic Linking Call)" and refers
    to Lorelei as one end-to-end userspace implementation. The plugin code is
    otherwise unchanged.

Changes since v4:

  * Added a documentation patch for docs/about/emulation.rst (Pierrick
    Bouvier): what the plugin does, its trusted-guests and guest_base == 0
    constraints, how to load it, and a minimal example, with a pointer to
    Lorelei.
  * The plugin's header comment now points to Lorelei as one userspace
    implementation. The plugin code is otherwise unchanged.

Changes since v3:

  * Lorelei, the userspace toolchain that implements this interface, is now a
    public, documented, CI-tested project, with a Thunk Library Compiler that
    generates the guest/host thunks automatically. This addresses the v3
    feedback that the interface needs a public implementation behind it. The
    plugin code itself is unchanged.

Changes since v2:

  * Dropped the RFC tag. The approach was positively received on v2.
  * Rebased on master and adjusted the syscall-filter callback to its updated
    signature (int64_t sysret, added userdata, dropped the plugin id
    argument).

Changes since v1:

  * Renamed the plugin from "passthrough" to "dlcall" (Pierrick Bouvier).
    The old name was too generic. The name "dlcall" reflects what the plugin actually
    does (dlopen/dlsym a host symbol and call it) and avoids confusion with
    QEMU's existing plugin hostcall concept (QEMU_PLUGIN_*_HOSTCALL).
  * Made the magic syscall number configurable at load time via the
    "syscall_num=N" argument, defaulting to 4096 and rejecting values low
    enough to clash with a real syscall (Pierrick Bouvier).

v1: https://lore.kernel.org/qemu-devel/20260617130742.769234-1-functioner@sjtu.edu.cn/
v2: https://lore.kernel.org/qemu-devel/20260619045404.820960-1-functioner@sjtu.edu.cn/
v3: https://lore.kernel.org/qemu-devel/20260622163438.130746-1-functioner@sjtu.edu.cn/
v4: https://lore.kernel.org/qemu-devel/20260629160217.1637276-1-functioner@sjtu.edu.cn/
v5: https://lore.kernel.org/qemu-devel/20260701155705.1737328-1-functioner@sjtu.edu.cn/
v6: https://lore.kernel.org/qemu-devel/20260705133943.113202-1-functioner@sjtu.edu.cn/
v7: https://lore.kernel.org/qemu-devel/20260708152043.251537-1-functioner@sjtu.edu.cn/
v8: https://lore.kernel.org/qemu-devel/20260709011945.282457-1-functioner@sjtu.edu.cn/

Thanks,
Ziyang Zhang

Ziyang Zhang (2):
  contrib/plugins: add a minimal dlcall plugin
  docs/about/emulation: document the dlcall plugin

 contrib/plugins/dlcall.c    | 248 ++++++++++++++++++++++++++++++++++++
 contrib/plugins/meson.build |   5 +
 docs/about/emulation.rst    | 202 ++++++++++++++++++++++++++++++++++++
 3 files changed, 455 insertions(+)
 create mode 100644 contrib/plugins/dlcall.c

-- 
2.34.1

