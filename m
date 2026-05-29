Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FCDACD6E43
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 10:15:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSuEw-00032U-8E; Fri, 29 May 2026 06:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSuEu-00031X-HM
 for qemu-devel@nongnu.org; Fri, 29 May 2026 06:14:52 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSuEr-00018I-C3
 for qemu-devel@nongnu.org; Fri, 29 May 2026 06:14:52 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso119389015e9.2
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 03:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780049688; x=1780654488; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B6JQViPoFpTlcZyCfKBQhNm2HrN7IoYtR2ZHk+x072M=;
 b=mMGhwKclsXpOUFGZ2RFmbovrNUNBwephMdmjTaiTywNwWE1l2Fjb7rKoNXH46Z+9yQ
 g/ljDll3a3FE8C6/CPY1F26FXwgmXQWtXKBgO+kfqwbm8mF/bcs1YE4CyIl099pcMvFP
 F9nBd3GiVgsfusc08umM+91plrW3RPJpMjyHy48v5SiSo9CCCKiN0ouP2BNWiIvwNq9l
 LC3jxHpnNkVHPqF1CmHciPp19QYCO7bPs/o73Mi7s7fIVBCmEZVzAtC7Q17Z3ZJacg6E
 l8hUBwc1XLKTrkq/C9c0MQLLfhKLknDkN/6350gaYYBFbLgU8VKSxG7KxOdQkDBFcyTw
 SvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780049688; x=1780654488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B6JQViPoFpTlcZyCfKBQhNm2HrN7IoYtR2ZHk+x072M=;
 b=NsotkLHqpbha5R4oQ8bKrG8MoMvOpD5wXXgh6qdhfz+eAdeAhH7HsiLcXWYnFYahhk
 VwVmKlMb17yDJ64t6dyEvea7ApcidV+zynsemha88LuJIFFF2e7pwD4P4vr/VSERQGnV
 CfhztDS5Ude6LmIHlfA6Wn1qdpchKdTabVzxoeRouJIVrS5s3VWXIK1srVzBVeRZDwGB
 AwGxzYsD0RmXT+T6BB4EIHwPrb6Aya6/EIQTEH1UPwtO2VKV0FF5C4e4oMRjeoyp8fUL
 gRIKpARGz8tIRvXn2ULatrmF17NLIiDhrimUY1h5RmEzV6dQzyrGmdgJXe8jUO3l+yys
 PGkg==
X-Gm-Message-State: AOJu0YwkGYWw/PH4tkFdtp1VormdqV5Y5OGQ+1Z0q9HrSsede+qTVDdH
 yN/G+PSMZW/bo29zfc4/xGDTlR5Nj1z5q3Q2mlwyUAqHTaJJLS5eKGsjrAdZaE8umPYlSniB8De
 +TA5/
X-Gm-Gg: Acq92OGO+PdpgKygDGKC6JsVh4ADP2ZPkt4lMGkP3K6ntg4x/l55f+tMXd4hMruG+jo
 kapL5iOEdIBbu9l0RVD2q/K9QdyyV+B4UJsO+EMkRnkDCgQYb6aUsc4gbdy8QkLfNxBzniLBxl3
 3PYg6PT0UZ+LpPJoNYGdF6NAlPia1NBpfsJ9hgdo3zzMCI32hGSKZcsPiNP5zWc6PfaOj3ZPrNs
 XCOswWD1N/j2LkJy382bkRyVtJ6CMr3/m8JuHMGwjzhKp8qOJbQ3oxoWqUx+hQ7yJpDG0yGPpd+
 1BUFUhvgdLtumhzB0EiY7exly+r9TnZDr4Kzg4RCW0mwHmnIRc/fVnTgv4dDAPzySzcDqXoUssC
 UepiA6NZ4eIMgdWITCJnf3b13L867ndk4In7+vjKdWTolR067k1AQnqsCZ8c/D6mXJXs20hTxeL
 VmVDwW+Eb+cytOmQr8hS1RIf+GwkmnnFt5mQ==
X-Received: by 2002:a05:600c:1550:b0:490:846d:e2de with SMTP id
 5b1f17b1804b1-4909c0bedc5mr42360285e9.28.1780049687497; 
 Fri, 29 May 2026 03:14:47 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef34b47eesm2710550f8f.9.2026.05.29.03.14.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 03:14:41 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C536860EDF;
 Fri, 29 May 2026 11:14:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH v4 11/12] .agents/skills: add qemu-issue-triage agent skill
 (caveman)
Date: Fri, 29 May 2026 11:14:36 +0100
Message-ID: <20260529101437.410181-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260529101437.410181-1-alex.bennee@linaro.org>
References: <20260529101437.410181-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

While triaging the issue tracker I wondered if this would be a
suitable job for an AI agent. Unfortunately the OSS program doesn't
give any credits to run agents in gitlab. However I do have access to
models from my editor and ECA so I built one and tested it on a few
issues.

We might want to consider adding some common "issue smells" for common
problems in issues. For example triggering asserts that have been
added to the code and other such annoyances.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v4 (caveman):
  - caveman version
  - discourage deep code dives and running tests
  - teach how to find current stable versions
v4
  - fix a bunch of typos in SKILL
  - update evals
  - remove mentions of ECA
  - fix typo referencing old skill name
  - remove eca__spawn_agent reference
  - clean-up authentication handling
  - teach it about scoped labels
  - make less chatty in the comments
  - updated commit msg
  - suggest running things in parallel (use agents)
  - more pointers to incompleteness
v3
  - more imperative phrasing
v2
  - prefer sub-agent
  - mention parameters
  - don't be over eager to tag host or target for generic bugs
  - signoff comments as an agent on behalf of the user
  - detect patch available and apply appropriate tags
---
 .agents/skills/qemu-issue-triage/SKILL.md     | 100 +++++++++++++
 .../qemu-issue-triage/assets/labels.txt       | 133 ++++++++++++++++++
 .../skills/qemu-issue-triage/evals/evals.json |  18 +++
 .../scripts/update_labels.sh                  |  16 +++
 AGENTS.md                                     |   1 +
 5 files changed, 268 insertions(+)
 create mode 100644 .agents/skills/qemu-issue-triage/SKILL.md
 create mode 100644 .agents/skills/qemu-issue-triage/assets/labels.txt
 create mode 100644 .agents/skills/qemu-issue-triage/evals/evals.json
 create mode 100755 .agents/skills/qemu-issue-triage/scripts/update_labels.sh

diff --git a/.agents/skills/qemu-issue-triage/SKILL.md b/.agents/skills/qemu-issue-triage/SKILL.md
new file mode 100644
index 00000000000..814038d5e04
--- /dev/null
+++ b/.agents/skills/qemu-issue-triage/SKILL.md
@@ -0,0 +1,100 @@
+---
+name: qemu-issue-triage
+description: Triage and label GitLab issues for QEMU project.
+license: GPL-2.0-or-later
+---
+
+# Instructions
+
+Triage GitLab issues for QEMU project.
+
+## Parameter Handling & Execution Strategy (CRITICAL)
+1. **Multi-ID**: If multiple IDs (e.g., `#3430, #3426`), treat each as independent.
+2. **Sub-Agent MANDATE**: NEVER triage in main context. ALWAYS spawn sub-agents to avoid context pollution.
+   - **Parallel**: One sub-agent per issue ID in parallel.
+   - Do NOT run `glab` or read label cache in main context.
+   - Pass `<issue-id>` in `task` argument, instruct sub-agent to follow triage workflow/asset rules.
+   - Report sub-agent summary back to user.
+
+## Goal
+Automate initial triage of new bugs and feature requests in QEMU GitLab repo.
+
+## Prerequisites
+- `glab` CLI tool.
+- Auth check: `glab auth status`. Set token via `env GITLAB_TOKEN=<token>` if needed.
+- Repo: `-R qemu-project/qemu`.
+
+## Asset Management (Label Cache)
+Cache list of labels avoids API calls.
+- **Cache Location:** `assets/labels.txt` relative to skill.
+- **Update Cache:** If requested or outdated, run script:
+  ```bash
+  cd .agents/skills/qemu-issue-triage/scripts && ./update_labels.sh
+  ```
+- **Use Cache**: ALWAYS read `assets/labels.txt` (or grep) before labeling. Do NOT guess names. Use exact casing/spelling.
+
+## Triage Workflow
+
+### 1. Information Gathering
+```bash
+glab issue view <issue-id> -R qemu-project/qemu --comments
+```
+
+### 2. Evaluate Completeness
+Check template: Host Arch/OS, Guest Arch/OS, QEMU Version, Repro Steps, Expected vs Actual.
+
+**workflow::Needs Info Triggers (CRITICAL):**
+Request info and apply `workflow::Needs Info` label if:
+- **Missing Command Line**: No full reproduction command (`qemu-system-* ...`).
+- **Old QEMU Version**: Version older than last two major releases.
+  - **CRITICAL**: No guess/hardcode. Read `VERSION` + `git tag -l "v*"` for real releases (e.g., `11.0.50` means `11.0.x` released, `11.1.0` in dev). Ask to re-test with master/latest stable found.
+- **Distro Version**: Version has distro-specific suffix (e.g., `.el9`, `.fc40`, `-ubuntu`, `7.2.0-14.sc05...`). Ask to reproduce with clean upstream source build.
+
+**Actions:**
+- If info missing, add `workflow::Needs Info` label and comment politely asking for missing details. Sign comment as "Issue Agent Bot on behalf of the user".
+- If issue is complete and on recent upstream version, proceed to categorization.
+
+### 3. Categorization & Labeling
+Add labels. Consult `assets/labels.txt` for exact names.
+
+#### Scoped Labels (Prefix::Label)
+Mutual exclusion: only one label per scope. Adding new removes old.
+- **Prefixes:** `kind::`, `workflow::`, `Closed::`, `Audit Tooling::`, `GUI::`.
+
+#### Kinds
+- `kind::Bug`: Bad behavior.
+- `kind::Feature Request`: New function.
+- `kind::Task`: Research/investigations.
+
+#### Targets (`target: *`) and Hosts (`host: *`)
+Be conservative. Only apply if bug strictly architecture- or host-dependent (e.g., ARM CPU emulation, macOS-specific build). Do not label target/host if bug is in generic device (USB, PCI, block) that happens to be run on that target.
+
+#### Accelerators (`accel: *`)
+E.g., `accel: KVM`, `accel: TCG`, `accel: HVF`.
+
+#### Subsystems
+E.g., `Storage`, `Networking`, `device:virtio`, `Migration`.
+
+#### Testcases
+- Apply `TestCase` if minimal C program, shell script, or disk image provided.
+
+#### Patches and Fixes
+- Apply `workflow::Patch available` if link to patch on mailing list (`lore.kernel.org`, `patchew.org`) or patch mentioned.
+
+#### Workflow Management
+One `workflow::` label at a time. Transitioning auto-removes old (e.g., adding `workflow::Patch available` removes `workflow::Triaged`).
+
+### 4. Update Issue
+Apply labels. E.g.:
+```bash
+glab issue update <issue-id> -R qemu-project/qemu --label "workflow::Triaged,kind::Bug"
+```
+
+## Guidelines
+- Comments MUST end with: "Issue Agent Bot on behalf of the user".
+- Avoid comments unless info needed. No "thank you" comments.
+- Apply `workflow::Triaged` once categorized.
+- Do NOT assign to people unless explicitly requested or known maintainer.
+- Use `scripts/get_maintainer.pl` on path to find subsystem.
+- **No deep code dives**: No deep code dive. No long root-cause search. Focus labels and metadata.
+- **Do NOT run tests**: No build, no test. Metadata triage only.
diff --git a/.agents/skills/qemu-issue-triage/assets/labels.txt b/.agents/skills/qemu-issue-triage/assets/labels.txt
new file mode 100644
index 00000000000..12d3cc7e6f0
--- /dev/null
+++ b/.agents/skills/qemu-issue-triage/assets/labels.txt
@@ -0,0 +1,133 @@
+ACPI                            Power Management related (ACPI / SMBIOS / HEST / GHES)
+Audio                           Audio devices; both backend (host audio) and frontend (guest audio)
+Audit Tooling::AI               For bugs found with AI assisted tools such as Mythos and other similar things
+Audit Tooling::Fuzzer           Issues found via fuzzing. For security issues, please consult https://www.qemu.org/contribute/security-process/
+Audit Tooling::Other            Some unknown/unclassified type of audit tooling.
+Audit Tooling::Sanitizer        For issues found using sanitizers such as asan, lsan and tsan
+Audit Tooling::Static Analysis  Static analysis such as Coverity or more modern compilers.
+Bite Sized                      Candidates for first contributions; see also https://wiki.qemu.org/Contribute/BiteSizedTasks
+Build System                    configure, make, Meson, ninja, gcc, clang, ccache, etc.
+CI                              Continuous Integration; gitlab, patchew, etc.
+CLI                             Command Line Interface
+Chardev                         Character device backends and related issues
+Closed::Duplicate               There is already another ticket that is about the same issue
+Closed::Fixed                   The issue was fixed. Yay!
+Closed::Invalid                 This issue was not really a problem
+Closed::NotOurBug               This is a bug, but not a bug in QEMU. Please report it and/or include a link to the report.
+Closed::NotReproducible         This issue was not reproducible
+Closed::UnbackedFeature         Nobody was willing to work on this feature request
+Closed::WontFix                 The issue was acknowledged, but the fix would be too complex, too expensive, or would introduce other problems.
+Cryptography                    
+Documentation                   Sphinx documentation, man pages, the wiki, --help output, etc.
+GDB                             Issues relating to using GDB via the gdbstub
+GUI                             Graphical User Interface (gtk, SDL, curses, VNC, spice, ...)
+GUI::Cocoa                      Cocoa
+GUI::DBus                       DBus
+GUI::GTK                        GTK
+GUI::SDL                        SDL
+GUI::SPICE                      SPICE
+GUI::VNC                        
+Guest Agent                     Issues related to the qemu-guest-agent binary. https://wiki.qemu.org/Features/GuestAgent
+Hard                            
+Launchpad                       Issues migrated from Launchpad
+Migration                       
+Modules                         
+Networking                      
+Python                          Python library issues (./python/)
+QAPI/QMP                        QEMU API / QEMU Machine Protocol, HMP and CLI, etc.
+QOM                             QEMU Object Model
+Regression                      This is a regression from previously working behaviour
+Security                        This is a security issue - see https://www.qemu.org/docs/master/system/security.html for guidance
+Semihosting                     Semihosting calls provide a simple ABI for early bring-up of embedded devices, see https://www.qemu.org/docs/master/about/emulation.html#semihosting
+Softfloat                       QEMU's FPU emulation code (TCG only)
+Stable::can't fix               The bug was reported on a stable branch but the fix is too invasive for backporting
+Stable::obsolete                The bug was reported on a stable branch that is not maintained anymore
+Stable::to backport             The bug was reported on a stable branch and needs to be backported on the next release from the branch
+Storage                         Block subsystem, Storage devices, etc.
+TCG plugins                     Anything related to the TCG plugins feature
+TestCase                        The report includes a testcase
+Tests                           qtests, iotests, acceptance tests, VM tests, docker tests, and more. See https://www.qemu.org/docs/master/devel/testing/index.html
+USB                             
+VFIO                            
+accel: HAX                      Intel's Hardware Accelerated Execution Manager (HAXM)
+accel: HVF                      Apple Hypervisor Framework
+accel: KVM                      Linux Kernel-based Virtual Machine
+accel: TCG                      QEMU Tiny Code Generator
+accel: WHPX                     Microsoft Windows Hypervisor Platform (WHPX)
+accel: Xen                      Xen Hypervisor
+block:9p                        The 9p network file system
+block:NVMe                      
+block:curl                      
+block:nbd                       
+block:nfs                       Issues related to the NFS backend
+block:qcow2                     
+block:ssh                       
+block:vmdk                      
+bsd-user                        
+device: PCI                     
+device: TPM                     Trusted Platform Module (TPM) devices
+device: iommu                   
+device: mmio                    mmio and other directly emulated devices
+device:graphics                 Issues relating to display device emulation, or rendering in general. See also "GUI".
+device:input                    Keyboards, Mice, Touchscreens, HIDs, etc.
+device:iommu                    IOMMU and SMMU
+device:pflash                   Parallel NOR flashes emulation
+device:sdmmc                    SD or (e)MMC cards emulation
+device:virtio                   virtio-related issues. https://www.linux-kvm.org/page/Virtio
+device:watchdog                 
+efi                             EFI firmware related issues
+flaky-ci                        For test cases that are flaky when run under our CI
+gitlab                          
+guest: AIX                      
+guest: BSD                      Guest OS is BSD (NetBSD/FreeBSD/OpenBSD/etc)
+guest: Linux                    Guest OS is Linux/Linux-based
+guest: Windows                  Microsoft Windows guest
+guest: macOS                    Apple macOS / Darwin as  guest OS
+guest: os2                      
+host: aarch64                   Bugs reproducible on AArch64 hosts
+host: arm                       Bugs reproducible on ARM hosts
+host: loongarch64               Bugs reproducible on LoongArch64 hosts.
+host: mips                      Bugs reproducible on MIPS hosts
+host: ppc                       Bugs reproducible on Power hosts
+host: riscv                     Bugs reproducible on RISC-V hosts
+host: s390                      Bugs reproducible on s390 hosts
+host: sparc64                   Bugs specific to Sparc64 hosts
+host: x86                       Bugs reproducible on x86 hosts
+host:32bit                      These are mostly TCG related bugs where we sometimes struggle with emulating larger guests, especially atomic and address space issues.
+hostos: BSD                     FreeBSD, OpenBSD, NetBSD, and derivatives as host OSes
+hostos: Linux                   Linux-based host operating systems (Fedora, RHEL/CentOS, Debian, Ubuntu, openSuSE et al)
+hostos: Windows                 Microsoft Windows host OS
+hostos: macOS                   Apple macOS / Darwin as a host OS
+icount                          issues relating to icount, deterministic execution and record/replay functionality
+kind::Bug                       Bug or defect in functionality.
+kind::Feature Request           Feature request or new functionality.
+kind::Task                      Research, investigations, and miscellaneous issues.
+libvfio-user                    
+linux-user                      issues with QEMU's lightweight user-mode emulator
+qemu-img                        
+sysadmin                        Issues related to QEMU project infrastructure. You should probably also check on the projects IRC channel if the issue is urgent - https://www.qemu.org/support/
+target: alpha                   DEC Alpha [alpha]
+target: arm                     Arm AArch32 or AArch64 [arm, aarch64]
+target: avr                     Atmel AVR [avr]
+target: hexagon                 Qualcomm Hexagon [hexagon]
+target: hppa                    Hewlett-Packard Precision Architecture; HP/HP, PA-RISC [hppa]
+target: i386                    Intel/AMD x86 [i386, x86_64]
+target: loongarch               loongarch64 target architecture
+target: m68k                    Motorola 68000 [m68k]
+target: microblaze              Xilinx MicroBlaze [microblaze, microblazeel]
+target: mips                    MIPS [mips, mipsel, mips64, mips64el]
+target: nios2                   Altera Nios II [nios2]
+target: openrisc                OpenRISC [or1k]
+target: ppc                     IBM Power Architecture, PowerPC [ppc, ppc64, ppc64le]
+target: riscv                   RISC-V [riscv32, riscv64]
+target: rx                      Renesas RX [rx]
+target: s390x                   IBM Z, SystemZ, zSeries [s390x]
+target: sh4                     Renesas SuperH [sh4, sh4eb]
+target: sparc                   Sun Microsystems SPARC [sparc, sparc64]
+target: tricore                 Infineon TriCore [tricore]
+target: xtensa                  Tensilica Xtensa [xtensa, xtensaeb]
+workflow::Confirmed             Bugs that have been confirmed and reproduced.
+workflow::In Progress           Someone is working on this issue.
+workflow::Needs Info            Issue has insufficient information to verify.
+workflow::Patch available       A patch is available
+workflow::Triaged               Issue has been triaged and given a topic label.
diff --git a/.agents/skills/qemu-issue-triage/evals/evals.json b/.agents/skills/qemu-issue-triage/evals/evals.json
new file mode 100644
index 00000000000..572c0723fd4
--- /dev/null
+++ b/.agents/skills/qemu-issue-triage/evals/evals.json
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+{
+  "skill_name": "qemu-issue-triage",
+  "evals": [
+    {
+      "id": 1,
+      "prompt": "Update the cached list of GitLab labels for the QEMU project.",
+      "expected_output": "The skill should fetch the latest labels from GitLab and save them to the skill's assets directory.",
+      "files": []
+    },
+    {
+      "id": 2,
+      "prompt": "Triage issue #1234. Assume the user provided clear steps but no subsystem label is obvious.",
+      "expected_output": "The skill should read the cached label list (not fetch from GitLab) and apply relevant kind/target labels.",
+      "files": []
+    }
+  ]
+}
\ No newline at end of file
diff --git a/.agents/skills/qemu-issue-triage/scripts/update_labels.sh b/.agents/skills/qemu-issue-triage/scripts/update_labels.sh
new file mode 100755
index 00000000000..1605eab4de5
--- /dev/null
+++ b/.agents/skills/qemu-issue-triage/scripts/update_labels.sh
@@ -0,0 +1,16 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+set -e
+
+if [ -z "$GITLAB_TOKEN" ]; then
+    echo "GITLAB_TOKEN is not set. Attempting to fetch via pass..."
+    export GITLAB_TOKEN=$(pass gitlab-api)
+fi
+
+echo "Fetching labels from qemu-project/qemu..."
+# Fetch labels using API and format as "Name        Description"
+glab api /projects/qemu-project%2Fqemu/labels --paginate | \
+    jq -r '.[] | [ .name, .description ] | @tsv' | \
+    column -t -s $'\t' > ../assets/labels.txt
+
+echo "Labels cached in assets/labels.txt"
diff --git a/AGENTS.md b/AGENTS.md
index d842fc62e98..3c108d3324b 100644
--- a/AGENTS.md
+++ b/AGENTS.md
@@ -52,6 +52,7 @@ You should use the following specialized skills for common tasks:
 - `qemu-code-reviewer`: For pulling and applying patch series from mailing lists.
 - `qemu-mail-thread`: For analyzing and parsing mailing list threads.
 - `qemu-issue-helper`: For fetching and summarising issue details from the bug tracker.
+- `qemu-issue-triage`: For helping triage issues in the bug tracker.
 
 ## Source Code Layout (see `docs/devel/codebase.rst`)
 - **`accel/`**: Hardware accelerators (KVM, TCG, HVF, Xen, etc.) and architecture-agnostic acceleration code.
-- 
2.47.3


