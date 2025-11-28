Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33437D116E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 17:36:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vP2Nk-0006IU-Kv; Fri, 28 Nov 2025 12:35:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1vP2Nh-0006HW-Bq
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 12:35:41 -0500
Received: from smtp-relay-services-1.canonical.com ([185.125.188.251])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1vP2Ne-0003es-US
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 12:35:41 -0500
Received: from scripts.lp.internal (scripts.lp.internal [10.131.215.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id B56643F0D5
 for <qemu-devel@nongnu.org>; Fri, 28 Nov 2025 17:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
 s=20210803; t=1764351336;
 bh=ns+9XEVKfskcNr5Lou9+7jgsv31ezBPuRFbTlmnv9YE=;
 h=MIME-Version:Content-Type:Date:From:To:Reply-To:References:
 Message-Id:Subject;
 b=mGF6hZI0jX1iGtNLPnhs62XFwv5F7UqMpvnOAbITr9ZjQHx0pr4x5JGCzCjh/QvF0
 8BGZRMCVA9qmZ7lMtK2w0c0W0FBNVKBvJ9bk0LiT4g6r5eM5PezKbs2UIDQFEo0oeQ
 wLaV3fFWHQzbdMbW7rVeWD7/bSS7MnhqG/EaPj8C7CWIsoEI1eZfZLCNEh7kGGnZx4
 fewa/XkvvkQrJ3XJNzxK1h5wV4Tj+bGBz+DcufEA66zCZtBYiqJk5XwwoM2Keo6hJX
 LUdKa69wsRT5NZhf0LCAAeTTJXp0KprQplwCaRpvGxmcoCF/JDDfJDHpaR8+iVTypS
 +guqgxIGRsxAg==
Received: from scripts.lp.internal (localhost [127.0.0.1])
 by scripts.lp.internal (Postfix) with ESMTP id A975F7ED79
 for <qemu-devel@nongnu.org>; Fri, 28 Nov 2025 17:35:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Nov 2025 17:29:16 -0000
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
Message-Id: <176435095642.1077914.5835173029101108514.malone@juju-98d295-prod-launchpad-4>
Subject: [Bug 2133188] Re: Illegal instruction in memset under qemu-user for
 riscv64
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="bf536a74252f65aa2f145d87a74873da841e2ec9";
 Instance="launchpad-scripts"
X-Launchpad-Hash: ac5b2aa98c13d131a21d8d9fa7f4a08c6da368ee
Received-SPF: pass client-ip=185.125.188.251;
 envelope-from=noreply@launchpad.net; helo=smtp-relay-services-1.canonical.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Inside the noble image the following extension where shown in
/proc/cpuinfo:

rv64imafdcbvh_zic64b_zicbom_zicbop_zicboz_ziccamoa_ziccif_zicclsm_ziccrse_z=
icfilp_zicfiss_zicond_zicntr_zicsr_zifencei_zihintntl_zihintpause_zihpm_zim=
op_zmmul_za64rs_zaamo_zabha_zacas_zalrsc_zama16b_zawrs_zfa_zfbfmin_zfh_zfhm=
in_zca_zcb_zcd_zcmop_zba_zbb_zbc_zbkb_zbkc_zbkx_zbs_zk_zkn_zknd_zkne_zknh_z=
kr_zks_zksed_zksh_zkt_ztso_zvbb_zvbc_zve32f_zve32x_zve64f_zve64d_zve64x_zvf=
bfmin_zvfbfwma_zvfh_zvfhmin_zvkb_zvkg_zvkn_zvknc_zvkned_zvkng_zvknha_zvknhb=
_zvks_zvksc_zvksed_zvksg_zvksh_zvkt_sdtrig_shcounterenw_sha_shgatpa_shtvala=
_shvsatpa_shvstvala_shvstvecd_smaia_smcdeleg_smcntrpmf_smcsrind_smepmp_smmp=
m_smnpm_smstateen_ssaia_ssccfg_ssccptr_sscofpmf_sscounterenw_sscsrind_ssdbl=
trp_ssnpm_sspm_ssstateen_ssstrict_sstc_sstvala_sstvecd_ssu64xl_supm_smctr_s=
sctr_svadu_svinval_svnapot_svpbmt_svrsw60t59b_svvptc

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


