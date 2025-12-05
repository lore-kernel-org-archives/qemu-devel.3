Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D76D32D62
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 14:46:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRX4R-0002It-9F; Fri, 05 Dec 2025 09:46:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1vRX4L-0002CW-1t
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 09:46:06 -0500
Received: from smtp-relay-services-0.canonical.com ([185.125.188.250])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1vRX4H-0002Ew-1T
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 09:45:59 -0500
Received: from scripts.lp.internal (scripts.lp.internal [10.131.215.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 40F7F45B56
 for <qemu-devel@nongnu.org>; Fri,  5 Dec 2025 14:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
 s=20210803; t=1764945954;
 bh=cvAIgWL/zRJLy4qAyI846+kweVa9jrEqpI1lW5AY/A0=;
 h=MIME-Version:Content-Type:Date:From:To:Reply-To:References:
 Message-Id:Subject;
 b=Uwh/QLf3eH8qBHi1mYn5djokqY6heoboPrpO70ItioTGg+2k4yi9340deiai708Tn
 ckqbgErJTUV1GPPs9eetsv7CTH9wU2iIPRIDb0TVJEhGkx2fgwc3ntSOCykN8DEvtV
 QojCclmeux1q2TPZEbDUM4g5VftUgTRbD7TPBqlZJiUmMgSNF3smCDqczeGfVuLt9j
 dRCvtkBE3LNup+GAZYAQudE3Ove9WJi4p8GvH33BtLdT3665xy48aw5OkIyusE5sMD
 bTfaJrNiSPcQg0NrPKwA1+egf9hl+Htrq6tTHpEfPcw273mPwzDu214PM5ftOICN8c
 ZQ5Eq8jCUjDeg==
Received: from scripts.lp.internal (localhost [127.0.0.1])
 by scripts.lp.internal (Postfix) with ESMTP id 20AD87F8FB
 for <qemu-devel@nongnu.org>; Fri,  5 Dec 2025 14:45:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Dec 2025 14:36:15 -0000
From: Heinrich Schuchardt <2133188@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Unknown; assignee=None;
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 status=Confirmed; importance=Medium;
 assignee=heinrich.schuchardt@canonical.com; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: janitor qianqiu-2020 xypron
X-Launchpad-Bug-Reporter: qianqiu (qianqiu-2020)
X-Launchpad-Bug-Modifier: Heinrich Schuchardt (xypron)
References: <176429928488.3164788.8613118615925713152.malonedeb@juju-98d295-prod-launchpad-2>
Message-Id: <176494537542.3632552.1557367056911669683.malone@juju-98d295-prod-launchpad-7>
Subject: [Bug 2133188] Re: Illegal instruction in memset under qemu-user for
 riscv64
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="379e22b8475e3402088a4cdb4a6e7936a4d28414";
 Instance="launchpad-scripts"
X-Launchpad-Hash: a520f02585ef6c5385998f6431dd406353814820
Received-SPF: pass client-ip=185.125.188.250;
 envelope-from=noreply@launchpad.net; helo=smtp-relay-services-0.canonical.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 2133188 <2133188@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The error can be reproduced outside of Docker:

$ /usr/bin/qemu-riscv64 -L chroot -trace "*,file=3Dtrace.out" chroot/usr/bi=
n/cmake --system-information
Illegal instruction        (core dumped) /usr/bin/qemu-riscv64 -L chroot -t=
race file=3Dtrace.out chroot/usr/bin/cmake --system-information

The trace file ends with

...
qemu_mutex_locked taken mutex 0x5555565d9ac0 (tcg/region.c:228)
qemu_mutex_unlock released mutex 0x5555565d9ac0 (tcg/region.c:230)
exec_tb tb:0x7726d1ee9340 pc=3D0x7726cf50095a
riscv_exception 2 (illegal_instruction) on epc 0x7726cf50095a
qemu_mutex_lock waiting on mutex 0x5555565da718 (cpu-common.c:352)
qemu_mutex_locked taken mutex 0x5555565da718 (cpu-common.c:352)
qemu_mutex_unlock released mutex 0x5555565da718 (cpu-common.c:354)
user_queue_signal env=3D0x5555565dd100 signal 4
user_handle_signal env=3D0x5555565dd100 signal 4
user_dump_core_and_abort env=3D0x5555565dd100 signal 4 (host 4)

--=20
You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/2133188

Title:
  Illegal instruction in memset under qemu-user for riscv64

Status in QEMU:
  New
Status in qemu package in Ubuntu:
  Confirmed

Bug description:
  # Title
  qemu-user (qemu-riscv64-static): intermittent Illegal instruction in mems=
et (vse64.v) when running cmake in riscv64 container (Ubuntu 26.04)

  ## Summary
  While running cmake (and other build steps) inside a linux/riscv64 Ubuntu=
 26.04 container on an x86_64 host using qemu-user (qemu-riscv64-static) re=
gistered via binfmt_misc, cmake sometimes crashes with "Illegal instruction=
 (core dumped)" or "died with signal 4". The illegal instruction is observe=
d inside glibc's memset implementation at an instruction that uses RISC-V v=
ector extension (vse64.v). The failure is intermittent (~50% reproducer rat=
e). Using a scalar-only memset (libnovecmem.so via LD_PRELOAD) or running u=
nder gdb / enabling QEMU_STRACE significantly reduces or eliminates the fai=
lure, which strongly suggests a qemu-user/emulation bug (vector handling / =
code generation / state corruption), not a cmake bug.

  ## Affects
  - qemu-user qemu-riscv64-static (as packaged in Ubuntu qemu 10.1.0+ds-5ub=
untu3)
  - Running in Docker container for riscv64 on x86_64 host via binfmt_misc =
qemu-user static interpreter

  ## Environment / Context
  - Host CPU: x86_64 (Docker multiarch running qemu-user for riscv64)
  - Host OS=EF=BC=9Amultiple Ubuntu releases (22.04, 24.04, 25.10)=20
  - Container image: ubuntu:26.04 for riscv64
  - qemu package used:
    - downloaded .deb from Launchpad: qemu-user_10.1.0+ds-5ubuntu3_amd64.de=
b and on several Debian qemu-user packages (qemu-user_10.2.0~rc1+ds-1, qemu=
-user_10.0.6+ds-0+deb13u2).=20
    - copied qemu-riscv64 binary into /usr/bin/qemu-riscv64-static inside h=
ost and registered via /proc/sys/fs/binfmt_misc/register
  - CMake version used inside container (bootstrap/build may use system-pro=
vided cmake binary): cmake 3.x (bootstrapping cmake while building also tri=
ggers crash)
  - Reproduction frequency: intermittent, ~50% (can get large variance: sev=
eral consecutive successes or failures)
  - Observed behavior changes when: LD_PRELOAD libnovecmem.so (scalar memse=
t) =E2=80=94 almost completely avoids crash; running under gdb or enabling =
QEMU_STRACE also makes it much harder to reproduce.
   =20

  ## Full reproduction steps
  1. On x86_64 host, fetch qemu-user .deb and extract the riscv static bina=
ry:
     wget https://launchpad.net/ubuntu/+source/qemu/1:10.1.0+ds-5ubuntu3/+b=
uild/31393935/+files/qemu-user_10.1.0+ds-5ubuntu3_amd64.deb
     dpkg-deb -x qemu-user_10.1.0+ds-5ubuntu3_amd64.deb qemu-user_10.1.0+ds=
-5ubuntu3_amd64
     sudo cp qemu-user_10.1.0+ds-5ubuntu3_amd64/usr/bin/qemu-riscv64 /usr/b=
in/qemu-riscv64-static

  2. Register qemu-riscv64 with binfmt_misc:
     echo -1 > /proc/sys/fs/binfmt_misc/qemu-riscv64
     echo ':qemu-riscv64:M:0:\x7f\x45\x4c\x46\x02\x01\x01\x00\x00\x00\x00\x=
00\x00\x00\x00\x00\x02\x00\xf3\x00:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff=
\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff:/usr/bin/qemu-riscv64-static:POCF'=
 >/proc/sys/fs/binfmt_misc/register

  3. Start riscv64 ubuntu container:
     docker run --platform=3Dlinux/riscv64 --name ubuntu26 -itd ubuntu:26.0=
4 bash
     docker exec -it ubuntu26 bash -i

  4. Inside container:
     apt update
     apt install -y build-essential cmake

  5. Reproducer 1:
     cmake --system-information
     -> Often fails with:
        bash: [15: 1 (255)] tcsetattr: Inappropriate ioctl for device
        Illegal instruction (core dumped)

  6. Reproducer 2 (minimal C project):
     Create test_cmake/CMakeLists.txt:
     cmake_minimum_required(VERSION 3.10)
     project(HelloCMake C)
     add_executable(hello main.c)

     Create test_cmake/main.c:
     #include <stdio.h>
     int main() {
         printf("Hello, CMake!\n");
         return 0;
     }

     cd test_cmake
     cmake .
     -> Crash with:
        -- Detecting C compiler ABI info
        bash: line 1:  8489 Illegal instruction        (core dumped) cmake .

  7. Reproducer 3 (rebuild cmake from source inside container):
     apt source cmake
     cd cmake
     apt-get build-dep .
     dpkg-buildpackage -us -uc -b
     -> Bootstrapping error:
        Illegal instruction (core dumped)
        Error when bootstrapping CMake:
        Problem while running initial CMake

  8. Observed crash location (from gdb/QEMU_STRACE when available):
     - Illegal instruction is in memset@@GLIBC_2.27+0x52
     - Faulting instruction: vse64.v v1,(a5)    (RISC-V vector store of 64-=
bit elements)


  ## Workarounds
  - LD_PRELOAD a scalar-only memset library (libnovecmem.so) to avoid glibc=
 using vectorized memset.
  - Run the failing process under gdb (slower) or enable QEMU_STRACE=3D1 =
=E2=80=94 both make the failure much less likely.

  Note: The same workload does not reproduce the crash when run under
  qemu-system (full-system emulation). The issue appears specific to
  qemu-user

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/2133188/+subscriptions


