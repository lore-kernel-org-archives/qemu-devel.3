Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44EA5E7717B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 19:30:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJe1Z-0003Ei-5d; Fri, 06 Dec 2024 14:30:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJe0y-0002tm-4J
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 14:29:27 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJe0r-0005Gm-76
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 14:29:22 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-725c49b5e45so671018b3a.2
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 11:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733513355; x=1734118155; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=quNdZOi6vs/DfPqpA5a+RAcvgntK93hl6bq6i2nnsOE=;
 b=UarycTlhe+mKADcTE11bfOq3slZak4/7/HIyrwoQsZUV/VrGeHS5qC274VfBtwugQY
 7NVv76vutpQps+l5MUsIPd7i26v70yM4b1kaaLidm82s7UU/qOR4rRgorzKD/JTapwIp
 FMbVzYOOMTJ2EBdnj6DRcudMQGe/dkCh1XFS9gNWceRYR7LY+pR6E1m/bk8LLfWbR/Cy
 a4eGqgNYlSok0pWxKR1ngqx5szFhE7hB3Q5awUvd+vRRr5A03D4BZ/Nf4cxWXLcFKBMx
 xHEMmVBjEHPInyfIdd6gndU0sU2PDuzRAIC468I7A5HmdJIk4/O10DomkweItXr4SN0i
 DhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733513355; x=1734118155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=quNdZOi6vs/DfPqpA5a+RAcvgntK93hl6bq6i2nnsOE=;
 b=TrJJpa90Uw9xKq9M+tJzDg58oy9Xz3l0zIbD0VNS7uPukyye1UAZVI5QDrRWuYBW2h
 0cCoxjVfUmNHIRb4jlv5pWnnwNxsWMSB2MDZIZZrPLk9k8qGvTZ2hGqdMrWpu6fyzG4L
 b/m0YEci/9OSi1xp7A1UZpn5h/mKdyN0u4GjbNb29Eg1WUyDu5oFz+r9EPk49R6SQbEc
 hcUCqD0Da8D2TfYNNdo7A7/W4qQQLg6peZnN3Ze128kYZnMHnRCPlyZPcdnJFtzStS2t
 cvBvrASSEqghLasZTBlkC6tt0T7JRe7EO2sJCaIhgUd9cU7lpcXmgSwLkat1eL+sWy2I
 OmjA==
X-Gm-Message-State: AOJu0Yw9ABVMbg9xs3YzDP1MSbLqLomfQz6aSyPsv1MlBLdp+VMb5RtV
 Q1lCdWTXJfwQAI6rRvllN5FtEdVIPJRSgDSu4PLnjxvUs851oQGbbr0Mhzo5lGVJ7zQwxbRmWsc
 cjCE=
X-Gm-Gg: ASbGncuPLvmBajZDQHUcQfjhng0iaALzzoJQNL+cuS71/TjrKl8gKYMfZqcY+sdo/eM
 tJcgzzSwnbdAAA9HHD+4NIPdsoBtsvBcSbyWNImpC0fgsWM6NiApk+dkgHmVpnvZ+xdswtbZbYD
 56cArIyYi+ZpH7NVE6ilsvejO3vmyIDm7SCIZSPXkxWP7lNDaQ/mqWtXYOIgEVDEgWgmUbiEmnW
 8kZjhQTio1h4BH74Xux/uBPmh5gwYM1myp4zLcKe+E2QDi5SqypWLK0yTMQV/6nbd0kIOrmdaS2
 7Xn4GDI4
X-Google-Smtp-Source: AGHT+IGZsUXSt52km/1r7xB9d39g1BI3rKVqOew8JPbcuvyepXAAKMac45yeCuu0QYSXIjhX2gN8HQ==
X-Received: by 2002:a17:902:c407:b0:215:b45a:6a63 with SMTP id
 d9443c01a7336-21614d7e213mr58883275ad.32.1733513355310; 
 Fri, 06 Dec 2024 11:29:15 -0800 (PST)
Received: from pc.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215f8ef9fcdsm32110205ad.146.2024.12.06.11.29.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 11:29:14 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-block@nongnu.org,
 philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 Michael Roth <michael.roth@amd.com>, Peter Xu <peterx@redhat.com>,
 gustavo.romero@linaro.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Eric Blake <eblake@redhat.com>, Andrew Melnychenko <andrew@daynix.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>,
 manos.pitsidianakis@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 6/6] docs: add a glossary
Date: Fri,  6 Dec 2024 11:29:00 -0800
Message-Id: <20241206192900.3893118-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241206192900.3893118-1-pierrick.bouvier@linaro.org>
References: <20241206192900.3893118-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/devel/control-flow-integrity.rst |   2 +
 docs/devel/multi-thread-tcg.rst       |   2 +
 docs/glossary.rst                     | 280 ++++++++++++++++++++++++++
 docs/index.rst                        |   1 +
 docs/system/arm/virt.rst              |   2 +
 docs/system/images.rst                |   2 +
 docs/tools/qemu-nbd.rst               |   2 +
 7 files changed, 291 insertions(+)
 create mode 100644 docs/glossary.rst

diff --git a/docs/devel/control-flow-integrity.rst b/docs/devel/control-flow-integrity.rst
index e6b73a4fe1a..3d5702fa4cc 100644
--- a/docs/devel/control-flow-integrity.rst
+++ b/docs/devel/control-flow-integrity.rst
@@ -1,3 +1,5 @@
+.. _cfi:
+
 ============================
 Control-Flow Integrity (CFI)
 ============================
diff --git a/docs/devel/multi-thread-tcg.rst b/docs/devel/multi-thread-tcg.rst
index d706c27ea74..7fd0a07633d 100644
--- a/docs/devel/multi-thread-tcg.rst
+++ b/docs/devel/multi-thread-tcg.rst
@@ -4,6 +4,8 @@
   This work is licensed under the terms of the GNU GPL, version 2 or
   later. See the COPYING file in the top-level directory.
 
+.. _mttcg:
+
 ==================
 Multi-threaded TCG
 ==================
diff --git a/docs/glossary.rst b/docs/glossary.rst
new file mode 100644
index 00000000000..693d9855dd1
--- /dev/null
+++ b/docs/glossary.rst
@@ -0,0 +1,280 @@
+.. _Glossary:
+
+--------
+Glossary
+--------
+
+This section of the manual presents brief definitions of acronyms and terms used
+by QEMU developers.
+
+Accelerator
+-----------
+
+A specific API used to accelerate execution of guest instructions. It can be
+hardware-based, through a virtualization API provided by the host OS (kvm, hvf,
+whpx, ...), or software-based (tcg). See this description of `supported
+accelerators<Accelerators>`.
+
+Board
+-----
+
+Another name for :ref:`machine`.
+
+Block
+-----
+
+Block drivers are the available `disk formats and front-ends
+<block-drivers>` available, and block devices `(see Block device section on
+options page)<sec_005finvocation>` are using them to implement disks for a
+virtual machine.
+
+CFI
+---
+
+Control Flow Integrity is a hardening technique used to prevent exploits
+targeting QEMU by detecting unexpected branches during execution. QEMU `actively
+supports<cfi>` being compiled with CFI enabled.
+
+Device
+------
+
+In QEMU, a device is a piece of hardware visible to the guest. Examples include
+UARTs, PCI controllers, PCI cards, VGA controllers, and many more.
+
+QEMU is able to emulate a CPU, and all the hardware interacting with it,
+including `many devices<device-emulation>`. When QEMU runs a virtual machine
+using a hardware-based accelerator, it is responsible for emulating, using
+software, all devices.
+
+EDK2
+----
+
+EDK2, as known as `TianoCore <https://www.tianocore.org/>`_, is an open source
+implementation of UEFI standard. QEMU virtual machines that boot a UEFI firmware
+usually use EDK2.
+
+gdbstub
+-------
+
+QEMU implements a `gdb server <GDB usage>`, allowing gdb to attach to it and
+debug a running virtual machine, or a program in user-mode. This allows
+debugging the guest code that is running inside QEMU.
+
+glib2
+-----
+
+`GLib2 <https://docs.gtk.org/glib/>`_ is one of the most important libraries we
+are using through the codebase. It provides many data structures, macros, string
+and thread utilities and portable functions across different OS. It's required
+to build QEMU.
+
+Guest agent
+-----------
+
+The `QEMU Guest Agent <qemu-ga>` is a daemon intended to be run within virtual
+machines. It provides various services to help QEMU to interact with it.
+
+.. _guest:
+
+Guest
+-----
+
+Guest is the architecture of the virtual machine, which is emulated.
+See also :ref:`host`.
+
+Sometimes this is called the :ref:`target` architecture, but that term
+can be ambiguous.
+
+.. _host:
+
+Host
+----
+
+Host is the architecture on which QEMU is running on, which is native.
+See also :ref:`guest`.
+
+Hypervisor
+----------
+
+The formal definition of an hypervisor is a program or API than can be used to
+manage a virtual machine. QEMU is a virtualizer, that interacts with various
+hypervisors.
+
+In the context of QEMU, an hypervisor is an API, provided by the Host OS,
+allowing to execute virtual machines. Linux implementation is KVM (and supports
+Xen as well). For MacOS, it's HVF. Windows defines WHPX. And NetBSD provides
+NVMM.
+
+.. _machine:
+
+Machine
+-------
+
+QEMU's system emulation models many different types of hardware. A machine model
+(sometimes called a board model) is the model of a complete virtual system with
+RAM, one or more CPUs, and various devices. It can be selected with the option
+``-machine`` of qemu-system. Our machine models can be found on this `page
+<system-targets-ref>`.
+
+Migration
+---------
+
+QEMU can save and restore the execution of a virtual machine between different
+host systems. This is provided by the `Migration framework<migration>`.
+
+NBD
+---
+
+The `QEMU Network Block Device server <qemu-nbd>` is a tool that can be used to
+mount and access QEMU images, providing functionality similar to a loop device.
+
+Mailing List
+------------
+
+This is `where <https://wiki.qemu.org/Contribute/MailingLists>`_ all the
+development happens! Changes are posted as series, that all developers can
+review and share feedback for.
+
+For reporting issues, our `GitLab
+<https://gitlab.com/qemu-project/qemu/-/issues>`_ tracker is the best place.
+
+.. _softmmu:
+
+MMU / softmmu
+-------------
+
+The Memory Management Unit is responsible for translating virtual addresses to
+physical addresses and managing memory protection. QEMU system mode is named
+"softmmu" precisely because it implements this in software, including a TLB
+(Translation lookaside buffer), for the guest virtual machine.
+
+QEMU user-mode does not implement a full software MMU, but "simply" translates
+virtual addresses by adding a specific offset, and relying on host MMU/OS
+instead.
+
+Monitor / QMP / HMP
+-------------------
+
+The `QEMU Monitor <QEMU monitor>` is a text interface which can be used to interact
+with a running virtual machine.
+
+QMP stands for QEMU Monitor Protocol and is a json based interface.
+HMP stands for Human Monitor Protocol and is a set of text commands available
+for users who prefer natural language to json.
+
+MTTCG
+-----
+
+Multiple CPU support was first implemented using a round-robin algorithm
+running on a single thread. Later on, `Multi-threaded TCG <mttcg>` was developed
+to benefit from multiple cores to speed up execution.
+
+Plugins
+-------
+
+`TCG Plugins <TCG Plugins>` is an API used to instrument guest code, in system
+and user mode. The end goal is to have a similar set of functionality compared
+to `DynamoRIO <https://dynamorio.org/>`_ or `valgrind <https://valgrind.org/>`_.
+
+One key advantage of QEMU plugins is that they can be used to perform
+architecture agnostic instrumentation.
+
+Patchew
+-------
+
+`Patchew <https://patchew.org/QEMU/>`_ is a website that tracks patches on the
+Mailing List.
+
+PR
+--
+
+Once a series is reviewed and accepted by a subsystem maintainer, it will be
+included in a PR (Pull Request) that the project maintainer will merge into QEMU
+main branch, after running tests.
+
+The QEMU project doesn't currently expect most developers to directly submit
+pull requests.
+
+QCOW2
+-----
+
+QEMU Copy On Write is a disk format developed by QEMU. It provides transparent
+compression, automatic extension, and many other advantages over a raw image.
+
+qcow2 is the recommended format to use.
+
+QEMU
+----
+
+`QEMU (Quick Emulator) <https://www.qemu.org/>`_ is a generic and open source
+machine emulator and virtualizer.
+
+QOM
+---
+
+`QEMU Object Model <qom>` is an object oriented API used to define various
+devices and hardware in the QEMU codebase.
+
+Record/replay
+-------------
+
+`Record/replay <replay>` is a feature of QEMU allowing to have a deterministic
+and reproducible execution of a virtual machine.
+
+Rust
+----
+
+`A new programming language <https://www.rust-lang.org/>`_, memory safe by
+default. There is a work in progress to integrate it in QEMU codebase for
+various subsystems.
+
+System mode
+-----------
+
+QEMU System mode provides a virtual model of an entire machine (CPU, memory and
+emulated devices) to run a guest OS. In this mode the CPU may be fully emulated,
+or it may work with a hypervisor such as KVM, Xen or Hypervisor.Framework to
+allow the guest to run directly on the host CPU.
+
+QEMU System mode is called :ref:`softmmu <softmmu>` as well.
+
+.. _target:
+
+Target
+------
+
+The term "target" can be ambiguous. In most places in QEMU it is used as a
+synonym for :ref:`guest`. For example the code for emulating Arm CPUs is in
+``target/arm/``. However in the :ref:`TCG subsystem <tcg>` "target" refers to the
+architecture which QEMU is running on, i.e. the :ref:`host`.
+
+TCG
+---
+
+TCG is the QEMU `Tiny Code Generator <tcg>`. It is the JIT (just-in-time)
+compiler we use to emulate a guest CPU in software.
+
+It is one of the accelerators supported by QEMU, and supports a lot of
+guest/host architectures.
+
+User mode
+---------
+
+QEMU User mode can launch processes compiled for one CPU on another CPU. In this
+mode the CPU is always emulated. In this mode, QEMU translate system calls from
+guest to host kernel. It is available for Linux and BSD.
+
+VirtIO
+------
+
+VirtIO is an open standard used to define and implement virtual devices with a
+minimal overhead, defining a set of data structures and hypercalls (similar to
+system calls, but targeting an hypervisor, which happens to be QEMU in our
+case). It's designed to be more efficient than emulating a real device, by
+minimizing the amount of interactions between a guest VM and its hypervisor.
+
+vhost-user
+----------
+
+`Vhost-user <vhost_user>` is an interface used to implement VirtIO devices
+outside of QEMU itself.
diff --git a/docs/index.rst b/docs/index.rst
index 78285ebd6a4..5665de85cab 100644
--- a/docs/index.rst
+++ b/docs/index.rst
@@ -20,3 +20,4 @@ Welcome to QEMU's documentation!
    interop/index
    specs/index
    devel/index
+   glossary
diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index e67e7f0f7c5..11ceb898264 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -1,3 +1,5 @@
+.. _arm-virt:
+
 'virt' generic virtual platform (``virt``)
 ==========================================
 
diff --git a/docs/system/images.rst b/docs/system/images.rst
index d000bd6b6f1..a5551173c97 100644
--- a/docs/system/images.rst
+++ b/docs/system/images.rst
@@ -82,4 +82,6 @@ VM snapshots currently have the following known limitations:
 -  A few device drivers still have incomplete snapshot support so their
    state is not saved or restored properly (in particular USB).
 
+.. _block-drivers:
+
 .. include:: qemu-block-drivers.rst.inc
diff --git a/docs/tools/qemu-nbd.rst b/docs/tools/qemu-nbd.rst
index 329f44d9895..4f21b7904ac 100644
--- a/docs/tools/qemu-nbd.rst
+++ b/docs/tools/qemu-nbd.rst
@@ -1,3 +1,5 @@
+.. _qemu-nbd:
+
 =====================================
 QEMU Disk Network Block Device Server
 =====================================
-- 
2.39.5


