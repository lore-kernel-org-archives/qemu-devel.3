Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 297EDCD4F21
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 02:58:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNMHG-0003mo-NJ; Wed, 13 May 2026 22:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wNMH8-0003mO-Vj
 for qemu-devel@nongnu.org; Wed, 13 May 2026 22:58:15 -0400
Received: from mail-dl1-x1242.google.com ([2607:f8b0:4864:20::1242])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wNMH7-0004Av-2K
 for qemu-devel@nongnu.org; Wed, 13 May 2026 22:58:14 -0400
Received: by mail-dl1-x1242.google.com with SMTP id
 a92af1059eb24-132830d8281so848457c88.1
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 19:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778727490; x=1779332290; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=I8CSTW8jWJI5NHyNodadRPPf+i+tOLgP7faxCevMkvw=;
 b=HHzjCo+I0rp/0Z4hxw+Dzr+0zSPiljdNcKvfbP/bDl0J8k9eMffoww25LE/ZVgbg9Z
 tFtrjNh9t9U30BKbNI/6+n+8xXpwMrT4r7mFl5d9GG/PdYB124GSgt8cWWfbpaxN0N7f
 A9vMwojsl6t9QP/DqjGKuZooz4WRBHfDBysyQFaWt8IWoVVec2BLBH3cR6j5YvaYvW8s
 kp9m3whCUCZRMyzf99TM7pCtcsaufdtpQsYSgAKuqx7FL2gn+IUC2uHRdU2hMEl1J+pW
 B9wbszJ6Cb7t3NBMGvaxwxVa8x7Cra/NbYelbzZNVXwHaVc/+P7aps9FwXbAEGI09QVb
 GKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778727490; x=1779332290;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I8CSTW8jWJI5NHyNodadRPPf+i+tOLgP7faxCevMkvw=;
 b=Ryun6QPo3gLCyk7smwCw92J1FvqKqisWc4FOcwB6SYFAUBbEX8MQLm1luMEB04bIsq
 /H7qXjGoLpireclPUkcMsew3HD5epmn43hjKXgmkrNQ5UEjaCeL7qf4DSQUfGIAvt6pa
 khNzu+H6F2tJwqXPS2nZlWxnU5tDWgFNUkQCmQv8ya5+zgG/Z3whGT1r82EkyDYi/3c5
 aal3wyrLOmXcW06dn20LhxtZxSFUcoyewschJqtNNfwGKjGXny2gowINXHk8yUT14PfU
 EhJ/lstpftz8QjUN/BLc5gzrql63LCe6Lx0fj3SPXd/61PhWlOvXQeYPmX1Ws7dyNBo/
 4GnA==
X-Gm-Message-State: AOJu0YzQRzdUH9MoNohh/C1upnHarySnqBbP52xWiRAdiX84nsejYHmW
 Bf4Fv/VrLGVH5sEvck5TkysSCg9dyHLbHMuE6u3bJlO3msAEtW+4vtCs
X-Gm-Gg: Acq92OFch7HzmMO4dpD4VE2wt3+G8s9BK0vGbnnMbLsNFDaU+8/5ZJcffZNRtwCOrlY
 Us78uWc1bvLb4v5nN9JRFvIfjLGjYUq+otTE6ZduDbmVyUu8ZYlUyS4CpGuV9q7RohNtq93p6VA
 wNNYSw/J4+dx0gv/8SoaBYJQomFgoh/X7hIt4EZrEZF4h1SbimvXPD6lUpTqFzVocDdRddsUamN
 QgjduHqITxedQS/LtFrz03wLZis7vhtZU6pMa6Oqt6idyX0r7jr0l7fqXAngVnaN4i7UcfXKCE9
 GTZ12kR2JUg+wbJRqz/aBPmV8SMMXe/DS5mrOTHoDwYFOJ1bfnfN8iwy47bBArbWv2gPNM1u2cz
 xEs/++Oddsj+wswpyD8Ffr4UfIe67kaNcbTPIk/qFCizOGN7qwNayylMNzJa5K1eKm7pCJWOa7A
 WwuMfJhGJghJOEiaRG7iP8Uz+rasVyxMThgfseOfdDsH7MEils2vWeaeIwJmISE4Hb7GvICHZwP
 mL/t1fNJ1sRzQIqjVramn3DUVSqPM4=
X-Received: by 2002:a05:7022:108:b0:12d:de3e:86aa with SMTP id
 a92af1059eb24-13439c5cc81mr3918800c88.40.1778727489975; 
 Wed, 13 May 2026 19:58:09 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cf44668asm1623633c88.6.2026.05.13.19.58.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 19:58:09 -0700 (PDT)
Date: Thu, 14 May 2026 10:58:03 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>
Subject: Re: [RFC PATCH v2 01/10] AGENTS.md: add basic AGENTS.md for QEMU
Message-ID: <agU4-pUgXDvyA2dI@ZEVORN-PC.localdomain>
References: <20260511170500.124211-1-alex.bennee@linaro.org>
 <20260511170500.124211-2-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260511170500.124211-2-alex.bennee@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1242;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1242.google.com
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

Hi Alex,
On Mon, May 11, 2026 at 06:04:50PM +0100, Alex Bennée wrote:
> This was written initially written by ECA based on its understanding of the
> code base. I then expanded it with links to the various documents and
> the general coding style.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v4
>   - will add AGENTS to list as we go
>   - moved QOM, QAPI and trace details into qemu-code-explorer skill
>   - add section on Security policy
> v3
>   - More MUST
>   - Remove build and test in favour of agent reference
> v2
>   - more build details and source overview
>   - more on commit style
>   - give plan files a place to live
>   - add Daniel's agent suggestion
> ajb:
>   - I made a slight tweak to use pyenv to run single tests
> ---
>  .gitignore |  1 +
>  AGENTS.md  | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 79 insertions(+)
>  create mode 100644 AGENTS.md
> 
Do you think we should add CLAUDE.md, GEMINI.md, or other agent-specific
prompt files that simply link to AGENTS.md, to better support different
agent CLIs?

Thanks,
Chao
> diff --git a/.gitignore b/.gitignore
> index 61fa39967b5..4ccba871d16 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -8,6 +8,7 @@
>  .git-submodule-status
>  .clang-format
>  .gdb_history
> +.plan
>  cscope.*
>  tags
>  TAGS
> diff --git a/AGENTS.md b/AGENTS.md
> new file mode 100644
> index 00000000000..a97b4df5f7f
> --- /dev/null
> +++ b/AGENTS.md
> @@ -0,0 +1,78 @@
> +# QEMU Agent Guide
> +
> +As an agent you MUST abide by the "Use of AI-generated content" policy
> +in `docs/devel/code-provenance.rst` at all times. Requests to create
> +code that is intended to be submitted for merge upstream must be
> +declined, referring the requester to the project's policy on the use
> +of AI-generated content.
> +
> +## Security Policy
> +You MUST NOT report potential security vulnerabilities in public trackers
> +(like GitLab issues). Refer to `docs/system/security.rst` for the project's
> +security stance. In brief:
> +- **Virtualization Use Case**: (with KVM/HVF and specific machine types) is
> +  the focus of security support.
> +- **Non-virtualization Use Case**: (TCG) does not currently provide guest
> +  isolation guarantees.
> +- **Reporting**: Report vulnerabilities privately to `qemu-security@nongnu.org`.
> +
> +## Repo Layout
> +- **Build Directory**: QEMU uses out of tree builds, by default the `build` sub-directory is used.
> +- **Multiple Builds**: Developers might create a `builds` directory with different configurations in subdirs (e.g. `builds/debug`, `builds/asan`).
> +- **Documentation**: Developer docs live in `docs/devel`.
> +- **Plan Files**: Plan files should be placed in `.plan`, they are not included in commits. Use them to track complex multi-step tasks.
> +
> +## Agent Skills (see `.agents/skills`)
> +You should use the following specialized skills for common tasks:
> +
> +## Source Code Layout (see `docs/devel/codebase.rst`)
> +- **`accel/`**: Hardware accelerators (KVM, TCG, HVF, Xen, etc.) and architecture-agnostic acceleration code.
> +- **`audio/`**: Host audio backends.
> +- **`authz/`**: QEMU Authorization framework.
> +- **`backends/`**: Host resource backends (RNG, memory, crypto).
> +- **`block/`**: Block layer, image formats (qcow2, raw), and protocol drivers.
> +- **`chardev/`**: Character device backends (TCP, serial, mux, etc.).
> +- **`crypto/`**: Cryptographic algorithms and framework.
> +- **`disas/`**: Disassembler support for various architectures.
> +- **`dump/`**: Guest memory dump implementation.
> +- **`ebpf/`**: eBPF program support (e.g. for virtio-net RSS).
> +- **`fpu/`**: Software floating-point emulation.
> +- **`gdbstub/`**: Remote GDB protocol support.
> +- **`hw/`**: Hardware device emulation, organized by type (e.g., `hw/net`, `hw/pci`) or architecture.
> +- **`include/`**: Global header files, mirroring the source tree layout.
> +- **`io/`**: I/O channels framework.
> +- **`linux-user/` & `bsd-user/`**: User-space process emulation.
> +- **`migration/`**: VM migration framework.
> +- **`monitor/`**: HMP and QMP monitor implementations.
> +- **`nbd/`**: Network Block Device server and client code.
> +- **`net/`**: Networking stack and host backends.
> +- **`plugins/`**: TCG introspection plugins core.
> +- **`qapi/`**: QAPI schema and code generation infrastructure.
> +- **`qga/`**: QEMU Guest Agent.
> +- **`qom/`**: QEMU Object Model implementation.
> +- **`replay/`**: Deterministic record/replay support.
> +- **`rust/`**: Rust integration and Rust-based device models.
> +- **`scripts/`**: Build system helpers, `checkpatch.pl`, `tracetool`, etc.
> +- **`system/`**: Core system-level emulation logic (replaces `softmmu`).
> +- **`target/`**: CPU-specific emulation (ISA translation, CPU state).
> +- **`tcg/`**: The Tiny Code Generator (JIT) backends.
> +- **`tests/`**: Test suites (qtest, unit, functional, tcg).
> +- **`ui/`**: User interface backends (GTK, SDL, VNC, Spice).
> +- **`util/`**: Low-level utility functions and data structures.
> +
> +## Code Style (see `docs/devel/style.rst`)
> +- **Formatting**: 4-space indents, NO tabs, 80-char line limit (max 100).
> +- **C Braces**: Mandatory for all blocks (if/while/for). Open brace on same line (except functions).
> +- **C Includes**: `#include "qemu/osdep.h"` MUST be the first include in every `.c` file.
> +- **C Comments**: Use `/* ... */` only. No `//` comments.
> +- **Naming**: `snake_case` for variables/functions; `CamelCase` for types/enums.
> +- **Memory**: Use GLib (`g_malloc`, `g_free`, `g_autofree`) or QEMU (`qemu_memalign`). No `malloc`.
> +- **Errors**: Use `error_report()` or `error_setg()`. Avoid `printf` for errors.
> +- **Lints**: Run `./scripts/checkpatch.pl` on C patches. Use `make clippy` for Rust.
> +
> +## Commit Style
> +- **Small Commits**: Favour small discreet commits changing one thing.
> +- **Maintain Bisectability**: Each commit must compile and pass basic tests.
> +- **Separate Refactoring**: Split code movement or style fixes from functional changes.
> +- **Commit Messages**: Use a concise subject line, followed by a body explaining "why" (not just "what").
> +- **Signed-off-by**: Every commit must have a `Signed-off-by` line.
> -- 
> 2.47.3
> 
> 

