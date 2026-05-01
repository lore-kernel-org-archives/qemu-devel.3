Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E06BCCFA13
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 15:52:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIq9k-0000JY-6E; Fri, 01 May 2026 11:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wIq9i-0000JC-NW
 for qemu-devel@nongnu.org; Fri, 01 May 2026 11:51:54 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wIq9f-0005hb-Uk
 for qemu-devel@nongnu.org; Fri, 01 May 2026 11:51:54 -0400
Received: by mail-wr1-x443.google.com with SMTP id
 ffacd0b85a97d-44a044cb827so1032406f8f.0
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 08:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777650710; x=1778255510; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Fj+vpUcgS+AUrB1kqd8Y5UU5FXDMZtAf4zagddR/a5Q=;
 b=cNZAS8diNPFZeqtrVQkLlnHqjiIKHOnS9vs+TMnC5qrU7PCGZd/PHLEKguKffKTfSp
 jbjfeVgZhpxLoGCiaci81yuAOeBKApGqWJ/NAlAyZPuI/H9oFtuNoT49z8kc1sURIeOe
 ZUZ6GkGmePP4tqhuweD5NTO6kj8d0ebByV5VQus4OCVGMZ/fRUTZba+ojzZl9eHHEU+9
 0Mw+nLguympls6Zh6NqJ1WQ1twn9phINqZrNG4m15XWQq4NqX+pmreZvFhlM8d+SmcFr
 5JRJ2kQX8nkJVM3yPgrq5VtJWxsEB01EpEH2kCQDjNjaCtXkEt/f6tUcittuulUXP/ED
 Dq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777650710; x=1778255510;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fj+vpUcgS+AUrB1kqd8Y5UU5FXDMZtAf4zagddR/a5Q=;
 b=f1DY6Pqx211UZh8hqcCiqTOxvkVjlH8sEz8ikWnd1P3izb3wCvwlpFVKGoIZPYO2r8
 cNgmitgZqvwVrZHdmryjuRk2owf6zFn/JfkQKspQemN0B/v8/S4KxiH++eVWSp3WYB6A
 h77PAijyG9Sp4DcjaKCQ2H0qGiTNMyY9NIhqoNAM1feYWb/wFKLzXnxRCYWsA7YhDMks
 48gW6SuqCK6CWUiZFIAxBqhXadLjmU3aoglyeO7XpmOZzbKRJ5n9xeKl/OuMkqHrfn65
 bK4deXTy7SmeBmjtQ79xahbKCa3aAV9H2SQ/nlCb5uKkOuasKdEg+vgz+EloDnlk/wpm
 W4aA==
X-Gm-Message-State: AOJu0YwrqDlPa23f0dgpwxH02a8dwicfuudU/hcTSK/DfnxWdipdzm3g
 35/a79W+9n0vN0EZO6Ugb8xlTaR3zr4f+Z7VpubwD4AFC/2pageOyJNlzkaJ458Uyg0=
X-Gm-Gg: AeBDiesbwv9aEa1PogrStMD/8znajCw3uB3kCYvUkHtb0ou/4QNCtDLc/CYe/TSjKzI
 D/x+V/JPL3Z5ws4Hws7SoyGjbY80JnKyNU2+VvbGoh5Z8fDH0liQI7MokTHS0ybTBeve5DVZVSh
 vNihRRcrAFU+qakEIW8ol7b4aOfBzc3+9Idkj39BfmxbzgUbAhLBg66jdn4FJQmT3AAhHaiNTl2
 VLQNZCXyC4HTPqFflSCbAsx3vGEm/ulmO8vQY//ltSqe3nsqZfzmtzhLX9MH7VDUOf2niG4SaSO
 qGX8Mzt2NMpnjEB8lXlpBvBxASqVgOrt2zo9XSEj56tzMDulpzUjb0OAn4hUvFrwH985hKulty1
 5VSysjR7XX+ET66boWbAwVlycnfUN9S8Ii77engI/CIGuRf/ZXLkWkkMb/94zi7zi59WWRLnp1c
 QKOBp47go67dqmEcNaXOnvqyP0pe/6VpYc0w==
X-Received: by 2002:a05:6000:1789:b0:43d:762e:76ba with SMTP id
 ffacd0b85a97d-44bb4dd9211mr44060f8f.17.1777650709696; 
 Fri, 01 May 2026 08:51:49 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44b63d78692sm1705171f8f.27.2026.05.01.08.51.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 08:51:49 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 13B385F8FC;
 Fri, 01 May 2026 16:51:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH] .eca: add an issue triager agent skill
Date: Fri,  1 May 2026 16:51:41 +0100
Message-ID: <20260501155141.2176290-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
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

Obviously this can't apply as is because it probably encodes too much
of my local setup (using pass for API keys) and uses the ECA as my
preferred coding agent. I assume at some point there will be agreement
between all the agents where skill live.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .eca/skills/issue-triager/SKILL.md            |  77 ++++++++++
 .eca/skills/issue-triager/assets/labels.txt   | 132 ++++++++++++++++++
 .eca/skills/issue-triager/evals/evals.json    |  17 +++
 .../issue-triager/scripts/update_labels.sh    |  13 ++
 4 files changed, 239 insertions(+)
 create mode 100644 .eca/skills/issue-triager/SKILL.md
 create mode 100644 .eca/skills/issue-triager/assets/labels.txt
 create mode 100644 .eca/skills/issue-triager/evals/evals.json
 create mode 100755 .eca/skills/issue-triager/scripts/update_labels.sh

diff --git a/.eca/skills/issue-triager/SKILL.md b/.eca/skills/issue-triager/SKILL.md
new file mode 100644
index 00000000000..2498687a217
--- /dev/null
+++ b/.eca/skills/issue-triager/SKILL.md
@@ -0,0 +1,77 @@
+---
+name: issue-triager
+description: can help triaging GitLab issues for the QEMU project
+---
+
+# Instructions
+
+This skill provides specialized instructions for triaging GitLab issues for the QEMU project.
+
+## Goal
+Automate the initial triage of new bug reports and feature requests in the QEMU GitLab repository.
+
+## Prerequisites
+- `glab` CLI tool installed.
+- GitLab API Token: Use `env GITLAB_TOKEN=$(pass gitlab-api)` for all `glab` commands.
+- Target Repo: Use `-R qemu-project/qemu` if not in a clone, or ensure the remote is set correctly.
+
+## Asset Management (Label Cache)
+This skill uses a cached list of labels to avoid unnecessary API calls and ensure consistent labeling.
+- **Cache Location:** `assets/labels.txt` relative to this skill.
+- **Updating the Cache:** If the user asks to update the labels, or if you suspect a label is missing, run the provided script:
+  ```bash
+  cd .eca/skills/issue-triager/scripts && ./update_labels.sh
+  ```
+- **Using the Cache:** Before applying labels, ALWAYS read `assets/labels.txt` (or use `grep` on it) to review the available labels and their descriptions. This ensures you use the exact spelling and understand the intent behind the label (e.g., `kind::Bug`, `subsystem::block`). Do NOT guess label names.
+
+## Triage Workflow
+
+### 1. Information Gathering
+Fetch the issue details:
+```bash
+env GITLAB_TOKEN=$(pass gitlab-api) glab issue view <issue-id> -R qemu-project/qemu --comments
+```
+
+### 2. Evaluate Completeness
+Analyze the issue against the bug template requirements:
+- **Host Arch/OS**: Is the host environment specified?
+- **Guest Arch/OS**: Is the guest environment specified?
+- **QEMU Version**: Is the version mentioned?
+- **Reproduction Steps**: Are there clear steps to reproduce?
+- **Expected vs Actual**: Is the bug clearly described?
+
+**Actions:**
+- If critical information is missing (especially repro steps), add the `Workflow::Needs Info` label and post a polite comment asking for the missing details.
+- If the issue is well-defined, proceed to categorization.
+
+### 3. Categorization & Labeling
+Apply labels based on the issue content. **Crucially, consult `assets/labels.txt` to find the exact matching labels for the categories below.**
+
+#### Kinds
+- `kind::Bug`: For unexpected behavior.
+- `kind::Feature Request`: For new functionality.
+- `kind::Cleanup`: For code refactoring or style issues.
+
+#### Targets (target:*)
+Detect the guest architecture being used (e.g., `target:arm`, `target:riscv`, `target:i386`).
+
+#### Accelerators (accel:*)
+Detect the accelerator mentioned (e.g., `accel:kvm`, `accel:tcg`, `accel:hvf`).
+
+#### Subsystems (subsystem:*)
+Identify the relevant subsystem (e.g., `subsystem:block`, `subsystem:net`, `subsystem:virtio`, `subsystem:migration`).
+
+#### Testcases
+- If the issue provides a minimal C program, a shell script, or a specific disk image to reproduce the bug, apply the `Testcase` label.
+
+### 4. Updating the Issue
+Apply the labels and optionally assign a priority if clear:
+```bash
+env GITLAB_TOKEN=$(pass gitlab-api) glab issue update <issue-id> -R qemu-project/qemu --label "kind::Bug,target:arm,Workflow::Triaged"
+```
+
+## Guidelines
+- Be polite and professional in comments.
+- Use `Workflow::Triaged` once categorization is complete.
+- Avoid assigning issues to specific people unless they are explicitly mentioned or are the known maintainer for a very specific subsystem.
+- Use the `scripts/get_maintainer.pl` logic (via file paths mentioned in the issue) to identify potential subsystems.
diff --git a/.eca/skills/issue-triager/assets/labels.txt b/.eca/skills/issue-triager/assets/labels.txt
new file mode 100644
index 00000000000..5fe8c28deac
--- /dev/null
+++ b/.eca/skills/issue-triager/assets/labels.txt
@@ -0,0 +1,132 @@
+ACPI                       Power Management related (ACPI / SMBIOS / HEST / GHES)
+Audio                      Audio devices; both backend (host audio) and frontend (guest audio)
+Audit Tooling              A group for bugs and issues found via automated tooling such as fuzzing, sanitizers or AI
+Audit Tooling::AI          For bugs found with AI assisted tools such as Mythos and other similar things
+Audit Tooling::Fuzzer      Issues found via fuzzing. For security issues, please consult https://www.qemu.org/contribute/security-process/
+Audit Tooling::Sanitizer   For issues found using sanitizers such as asan, lsan and tsan
+Bite Sized                 Candidates for first contributions; see also https://wiki.qemu.org/Contribute/BiteSizedTasks
+Build System               configure, make, Meson, ninja, gcc, clang, ccache, etc.
+CI                         Continuous Integration; gitlab, travis, patchew, etc.
+CLI                        Command Line Interface
+Chardev                    Character device backends and related issues
+Closed::Duplicate          There is already another ticket that is about the same issue
+Closed::Fixed              The issue was fixed. Yay!
+Closed::Invalid            This issue was not really a problem
+Closed::NotOurBug          This is a bug, but not a bug in QEMU. Please report it and/or include a link to the report.
+Closed::NotReproducible    This issue was not reproducible
+Closed::UnbackedFeature    Nobody was willing to work on this feature request
+Closed::WontFix            The issue was acknowledged, but the fix would be too complex, too expensive, or would introduce other problems.
+Cryptography               
+Documentation              Sphinx documentation, man pages, the wiki, --help output, etc.
+GDB                        Issues relating to using GDB via the gdbstub
+GUI                        Graphical User Interface (gtk, SDL, curses, VNC, spice, ...)
+GUI::Cocoa                 Cocoa
+GUI::DBus                  DBus
+GUI::GTK                   
+GUI::SDL                   SDL
+GUI::SPICE                 SPICE
+GUI::VNC                   
+Guest Agent                Issues related to the qemu-guest-agent binary. https://wiki.qemu.org/Features/GuestAgent
+Hard                       
+Launchpad                  Issues migrated from Launchpad
+Migration                  
+Modules                    
+Networking                 
+Python                     Python library issues (./python/)
+QAPI/QMP                   QEMU API / QEMU Machine Protocol, HMP and CLI, etc.
+QOM                        QEMU Object Model
+Regression                 
+Security                   
+Semihosting                Semihosting calls provide a simple ABI for early bring-up of embedded devices and provide a way to output to the console and do basic file i/o while being debugged
+Softfloat                  QEMU's FPU emulation code (TCG only)
+Stable::can't fix          The bug was reported on a stable branch but the fix is too invasive for backporting
+Stable::obsolete           The bug was reported on a stable branch that is not maintained anymore
+Stable::to backport        The bug was reported on a stable branch and needs to be backported on the next release from the branch
+Storage                    Block subsystem, Storage devices, etc.
+TCG plugins                Anything related to the TCG plugins feature
+TestCase                   The report includes a testcase
+Tests                      qtests, iotests, acceptance tests, VM tests, docker tests, and more.
+USB                        
+VFIO                       
+accel: HAX                 Intel's Hardware Accelerated Execution Manager (HAXM)
+accel: HVF                 Apple Hypervisor Framework
+accel: KVM                 Linux Kernel-based Virtual Machine
+accel: TCG                 QEMU Tiny Code Generator
+accel: WHPX                Microsoft Windows Hypervisor Platform (WHPX)
+accel: Xen                 Xen Hypervisor
+block:9p                   The 9p network file system
+block:NVMe                 
+block:curl                 
+block:nbd                  
+block:nfs                  Issues related to the NFS backend
+block:qcow2                
+block:ssh                  
+block:vmdk                 
+bsd-user                   
+device: PCI                
+device: TPM                Trusted Platform Module (TPM) devices
+device:graphics            Issues relating to display device emulation, or rendering in general. See also "GUI".
+device:input               Keyboards, Mice, Touchscreens, HIDs, etc.
+device:iommu               IOMMU and SMMU
+device:pflash              Parallel NOR flashes emulation
+device:sdmmc               SD or (e)MMC cards emulation
+device:virtio              virtio-related issues. https://www.linux-kvm.org/page/Virtio
+device:watchdog            
+efi                        EFI firmware related issues
+flaky-ci                   For test cases that are flaky when run under our CI
+gitlab                     
+guest: AIX                 
+guest: BSD                 Guest OS is BSD (NetBSD/FreeBSD/OpenBSD/etc)
+guest: Linux               Guest OS is Linux/Linux-based
+guest: Windows             Microsoft Windows guest
+guest: macOS               Apple macOS / Darwin as  guest OS
+guest: os2                 
+host: aarch64              Bugs reproducible on AArch64 hosts
+host: arm                  Bugs reproducible on ARM hosts
+host: loongarch64          Bugs reproducible on LoongArch64 hosts.
+host: mips                 Bugs reproducible on MIPS hosts
+host: ppc                  Bugs reproducible on Power hosts
+host: riscv                Bugs reproducible on RISC-V hosts
+host: s390                 Bugs reproducible on s390 hosts
+host: sparc64              Bugs specific to Sparc64 hosts
+host: x86                  Bugs reproducible on x86 hosts
+host:32bit                 These are mostly TCG related bugs where we sometimes struggle with emulating larger guests, especially atomic and address space issues.
+hostos: BSD                FreeBSD, OpenBSD, NetBSD, and derivatives as host OSes
+hostos: Linux              Linux-based host operating systems (Fedora, RHEL/CentOS, Debian, Ubuntu, openSuSE et al)
+hostos: Windows            Microsoft Windows host OS
+hostos: macOS              Apple macOS / Darwin as a host OS
+icount                     issues relating to icount, deterministic execution and record/replay functionality
+kind: Not user visible     
+kind::Bug                  Bug or defect in functionality.
+kind::Feature Request      Feature request or new functionality.
+kind::Task                 Research, investigations, and miscellaneous issues.
+libvfio-user               
+linux-user                 
+qemu-img                   
+spice                      
+sysadmin                   
+target: alpha              DEC Alpha [alpha]
+target: arm                Arm AArch32 or AArch64 [arm, aarch64]
+target: avr                Atmel AVR [avr]
+target: hexagon            Qualcomm Hexagon [hexagon]
+target: hppa               Hewlett-Packard Precision Architecture; HP/HP, PA-RISC [hppa]
+target: i386               Intel/AMD x86 [i386, x86_64]
+target: loongarch          loongarch64 target architecture
+target: m68k               Motorola 68000 [m68k]
+target: microblaze         Xilinx MicroBlaze [microblaze, microblazeel]
+target: mips               MIPS [mips, mipsel, mips64, mips64el]
+target: nios2              Altera Nios II [nios2]
+target: openrisc           OpenRISC [or1k]
+target: ppc                IBM Power Architecture, PowerPC [ppc, ppc64, ppc64le]
+target: riscv              RISC-V [riscv32, riscv64]
+target: rx                 Renesas RX [rx]
+target: s390x              IBM Z, SystemZ, zSeries [s390x]
+target: sh4                Renesas SuperH [sh4, sh4eb]
+target: sparc              Sun Microsystems SPARC [sparc, sparc64]
+target: tricore            Infineon TriCore [tricore]
+target: xtensa             Tensilica Xtensa [xtensa, xtensaeb]
+workflow::Confirmed        Bugs that have been confirmed and reproduced.
+workflow::In Progress      Someone is working on this issue.
+workflow::Needs Info       Issue has insufficient information to verify.
+workflow::Patch available  A patch is available
+workflow::Triaged          Issue has been triaged and given a topic label.
diff --git a/.eca/skills/issue-triager/evals/evals.json b/.eca/skills/issue-triager/evals/evals.json
new file mode 100644
index 00000000000..4cf60b60259
--- /dev/null
+++ b/.eca/skills/issue-triager/evals/evals.json
@@ -0,0 +1,17 @@
+{
+  "skill_name": "issue-triager",
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
diff --git a/.eca/skills/issue-triager/scripts/update_labels.sh b/.eca/skills/issue-triager/scripts/update_labels.sh
new file mode 100755
index 00000000000..550df07ff6b
--- /dev/null
+++ b/.eca/skills/issue-triager/scripts/update_labels.sh
@@ -0,0 +1,13 @@
+#!/usr/bin/env bash
+set -e
+
+if [ -z "$GITLAB_TOKEN" ]; then
+    echo "GITLAB_TOKEN is not set. Attempting to fetch via pass..."
+    export GITLAB_TOKEN=$(pass gitlab-api)
+fi
+
+echo "Fetching labels from qemu-project/qemu..."
+# Fetch labels using API and format as "Name        Description"
+glab api /projects/qemu-project%2Fqemu/labels --paginate | jq -r '.[] | [ .name, .description ] | @tsv' | column -t -s $'\t' > ../assets/labels.txt
+
+echo "Labels cached in assets/labels.txt"
-- 
2.47.3


