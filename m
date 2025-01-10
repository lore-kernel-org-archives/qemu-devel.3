Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3903DE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 14:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWFqD-0002uV-Ci; Fri, 10 Jan 2025 09:18:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tWFq9-0002si-Oy
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 09:18:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tWFq7-00059k-G5
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 09:18:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736518698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4KwsNtiYMbIOm1t0dFJuAHnCJhsY/LCkChYkJlgCWT0=;
 b=SYw6GrojJ9FrPRS7ItfZvImVOGzVh7V7SnhviXSl0kBRvxYQQKzGOPAZQU5gFQSeoKyvS6
 b6OZcjPLUnKfN9YMnW03BhseahirzSFBPSx7XgfPlfGIGl3yd+LuOpokulqfinACD8Glmw
 IMjNspjeQeEPV1dVYpxtvqZ3eweW9rk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-fIM37G0_NJGCerzDB0WM-Q-1; Fri,
 10 Jan 2025 09:18:14 -0500
X-MC-Unique: fIM37G0_NJGCerzDB0WM-Q-1
X-Mimecast-MFC-AGG-ID: fIM37G0_NJGCerzDB0WM-Q
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 664061955DC8; Fri, 10 Jan 2025 14:18:13 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.35])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A424B195E3E0; Fri, 10 Jan 2025 14:18:11 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 3/9] ppc/ppc405: Remove CPU
Date: Fri, 10 Jan 2025 15:17:54 +0100
Message-ID: <20250110141800.1587589-4-clg@redhat.com>
In-Reply-To: <20250110141800.1587589-1-clg@redhat.com>
References: <20250110141800.1587589-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Remove the 405 CPU family and all SPR definitions that don't have
specific read/write handlers.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 target/ppc/cpu-models.h |  30 -----
 target/ppc/cpu.h        |   9 --
 target/ppc/cpu-models.c |  57 ----------
 target/ppc/cpu_init.c   | 246 ----------------------------------------
 4 files changed, 342 deletions(-)

diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
index 72ad31ba50d7..f23cb383d683 100644
--- a/target/ppc/cpu-models.h
+++ b/target/ppc/cpu-models.h
@@ -39,36 +39,6 @@ extern PowerPCCPUAlias ppc_cpu_aliases[];
 /* PVR definitions for most known PowerPC                                    */
 enum {
     /* IBM Processor for Network Resources */
-    CPU_POWERPC_COBRA              = 0x10100000, /* XXX: 405 ? */
-    /* PowerPC 405 family */
-    /* PowerPC 405 cores */
-    CPU_POWERPC_405D2              = 0x20010000,
-    CPU_POWERPC_405D4              = 0x41810000,
-    /* PowerPC 405 microcontrollers */
-    /* XXX: missing 0x200108a0 */
-    CPU_POWERPC_405CRa             = 0x40110041,
-    CPU_POWERPC_405CRb             = 0x401100C5,
-    CPU_POWERPC_405CRc             = 0x40110145,
-    CPU_POWERPC_405EP              = 0x51210950,
-    CPU_POWERPC_405EZ              = 0x41511460, /* 0x51210950 ? */
-    CPU_POWERPC_405GPa             = 0x40110000,
-    CPU_POWERPC_405GPb             = 0x40110040,
-    CPU_POWERPC_405GPc             = 0x40110082,
-    CPU_POWERPC_405GPd             = 0x401100C4,
-    CPU_POWERPC_405GPR             = 0x50910951,
-    CPU_POWERPC_405LP              = 0x41F10000,
-    /* IBM network processors */
-    CPU_POWERPC_NPE405H            = 0x414100C0,
-    CPU_POWERPC_NPE405H2           = 0x41410140,
-    CPU_POWERPC_NPE405L            = 0x416100C0,
-    CPU_POWERPC_NPE4GS3            = 0x40B10000,
-    /* IBM STBxxx (PowerPC 401/403/405 core based microcontrollers) */
-    CPU_POWERPC_STB03              = 0x40310000, /* 0x40130000 ? */
-    CPU_POWERPC_STB04              = 0x41810000,
-    CPU_POWERPC_STB25              = 0x51510950,
-    /* Xilinx cores */
-    CPU_POWERPC_X2VP4              = 0x20010820,
-    CPU_POWERPC_X2VP20             = 0x20010860,
     /* PowerPC 440 family */
     /* Generic PowerPC 440 */
 #define CPU_POWERPC_440              CPU_POWERPC_440GXf
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 0b8b4c051724..0fe44cedb1b3 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -270,8 +270,6 @@ typedef enum powerpc_input_t {
     PPC_FLAGS_INPUT_6xx,
     /* BookE bus                        */
     PPC_FLAGS_INPUT_BookE,
-    /* PowerPC 405 bus                  */
-    PPC_FLAGS_INPUT_405,
     /* PowerPC 970 bus                  */
     PPC_FLAGS_INPUT_970,
     /* PowerPC POWER7 bus               */
@@ -2172,9 +2170,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_BAMR              (0x3B7)
 #define SPR_7XX_MMCR0         (0x3B8)
 #define SPR_7XX_PMC1          (0x3B9)
-#define SPR_40x_SGR           (0x3B9)
 #define SPR_7XX_PMC2          (0x3BA)
-#define SPR_40x_DCWR          (0x3BA)
 #define SPR_7XX_SIAR          (0x3BB)
 #define SPR_405_SLER          (0x3BB)
 #define SPR_7XX_MMCR1         (0x3BC)
@@ -2223,7 +2219,6 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_40x_DBSR          (0x3F0)
 #define SPR_HID1              (0x3F1)
 #define SPR_IABR              (0x3F2)
-#define SPR_40x_DBCR0         (0x3F2)
 #define SPR_Exxx_L1CSR0       (0x3F2)
 #define SPR_ICTRL             (0x3F3)
 #define SPR_HID2              (0x3F3)
@@ -2232,20 +2227,16 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_440_DBDR          (0x3F3)
 #define SPR_LDSTDB            (0x3F4)
 #define SPR_750_TDCL          (0x3F4)
-#define SPR_40x_IAC1          (0x3F4)
 #define SPR_MMUCSR0           (0x3F4)
 #define SPR_970_HID4          (0x3F4)
 #define SPR_DABR              (0x3F5)
 #define DABR_MASK (~(target_ulong)0x7)
 #define SPR_Exxx_BUCSR        (0x3F5)
-#define SPR_40x_IAC2          (0x3F5)
-#define SPR_40x_DAC1          (0x3F6)
 #define SPR_MSSCR0            (0x3F6)
 #define SPR_970_HID5          (0x3F6)
 #define SPR_MSSSR0            (0x3F7)
 #define SPR_MSSCR1            (0x3F7)
 #define SPR_DABRX             (0x3F7)
-#define SPR_40x_DAC2          (0x3F7)
 #define SPR_MMUCFG            (0x3F7)
 #define SPR_LDSTCR            (0x3F8)
 #define SPR_L2PMCR            (0x3F8)
diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
index ece348178188..9d8f479fae70 100644
--- a/target/ppc/cpu-models.c
+++ b/target/ppc/cpu-models.c
@@ -67,56 +67,6 @@
     POWERPC_DEF_SVR(_name, _desc, _pvr, POWERPC_SVR_NONE, _type)
 
     /* Embedded PowerPC                                                      */
-    /* PowerPC 405 family                                                    */
-    /* PowerPC 405 cores                                                     */
-    POWERPC_DEF("405d2",         CPU_POWERPC_405D2,                  405,
-                "PowerPC 405 D2")
-    POWERPC_DEF("405d4",         CPU_POWERPC_405D4,                  405,
-                "PowerPC 405 D4")
-    /* PowerPC 405 microcontrollers                                          */
-    POWERPC_DEF("405cra",        CPU_POWERPC_405CRa,                 405,
-                "PowerPC 405 CRa")
-    POWERPC_DEF("405crb",        CPU_POWERPC_405CRb,                 405,
-                "PowerPC 405 CRb")
-    POWERPC_DEF("405crc",        CPU_POWERPC_405CRc,                 405,
-                "PowerPC 405 CRc")
-    POWERPC_DEF("405ep",         CPU_POWERPC_405EP,                  405,
-                "PowerPC 405 EP")
-    POWERPC_DEF("405ez",         CPU_POWERPC_405EZ,                  405,
-                "PowerPC 405 EZ")
-    POWERPC_DEF("405gpa",        CPU_POWERPC_405GPa,                 405,
-                "PowerPC 405 GPa")
-    POWERPC_DEF("405gpb",        CPU_POWERPC_405GPb,                 405,
-                "PowerPC 405 GPb")
-    POWERPC_DEF("405gpc",        CPU_POWERPC_405GPc,                 405,
-                "PowerPC 405 GPc")
-    POWERPC_DEF("405gpd",        CPU_POWERPC_405GPd,                 405,
-                "PowerPC 405 GPd")
-    POWERPC_DEF("405gpr",        CPU_POWERPC_405GPR,                 405,
-                "PowerPC 405 GPR")
-    POWERPC_DEF("405lp",         CPU_POWERPC_405LP,                  405,
-                "PowerPC 405 LP")
-    POWERPC_DEF("npe405h",       CPU_POWERPC_NPE405H,                405,
-                "Npe405 H")
-    POWERPC_DEF("npe405h2",      CPU_POWERPC_NPE405H2,               405,
-                "Npe405 H2")
-    POWERPC_DEF("npe405l",       CPU_POWERPC_NPE405L,                405,
-                "Npe405 L")
-    POWERPC_DEF("npe4gs3",       CPU_POWERPC_NPE4GS3,                405,
-                "Npe4GS3")
-    /* PowerPC 401/403/405 based set-top-box microcontrollers                */
-    POWERPC_DEF("stb03",         CPU_POWERPC_STB03,                  405,
-                "STB03xx")
-    POWERPC_DEF("stb04",         CPU_POWERPC_STB04,                  405,
-                "STB04xx")
-    POWERPC_DEF("stb25",         CPU_POWERPC_STB25,                  405,
-                "STB25xx")
-    /* Xilinx PowerPC 405 cores                                              */
-    POWERPC_DEF("x2vp4",         CPU_POWERPC_X2VP4,                  405,
-                NULL)
-    POWERPC_DEF("x2vp20",        CPU_POWERPC_X2VP20,                 405,
-                NULL)
-    /* PowerPC 440 family                                                    */
 #if defined(TODO_USER_ONLY)
     POWERPC_DEF("440",           CPU_POWERPC_440,                    440GP,
                 "Generic PowerPC 440")
@@ -742,13 +692,6 @@
 /* PowerPC CPU aliases                                                     */
 
 PowerPCCPUAlias ppc_cpu_aliases[] = {
-    { "405", "405d4" },
-    { "405cr", "405crc" },
-    { "405gp", "405gpd" },
-    { "405gpe", "405crc" },
-    { "x2vp7", "x2vp4" },
-    { "x2vp50", "x2vp20" },
-
     { "440ep", "440epb" },
     { "460ex", "460exb" },
 #if defined(TODO_USER_ONLY)
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index c05c2dc42dca..da92dce54624 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -1087,177 +1087,6 @@ static void register_440_sprs(CPUPPCState *env)
                  0x00000000);
 }
 
-/* SPR shared between PowerPC 40x implementations */
-static void register_40x_sprs(CPUPPCState *env)
-{
-    /* Cache */
-    /* not emulated, as QEMU do not emulate caches */
-    spr_register(env, SPR_40x_DCCR, "DCCR",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-    /* not emulated, as QEMU do not emulate caches */
-    spr_register(env, SPR_40x_ICCR, "ICCR",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-    /* not emulated, as QEMU do not emulate caches */
-    spr_register(env, SPR_BOOKE_ICDBDR, "ICDBDR",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, SPR_NOACCESS,
-                 0x00000000);
-    /* Exception */
-    spr_register(env, SPR_40x_DEAR, "DEAR",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-    spr_register(env, SPR_40x_ESR, "ESR",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-    spr_register(env, SPR_40x_EVPR, "EVPR",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_excp_prefix,
-                 0x00000000);
-    spr_register(env, SPR_40x_SRR2, "SRR2",
-                 &spr_read_generic, &spr_write_generic,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-    spr_register(env, SPR_40x_SRR3, "SRR3",
-                 &spr_read_generic, &spr_write_generic,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-    /* Timers */
-    spr_register(env, SPR_40x_PIT, "PIT",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_40x_pit, &spr_write_40x_pit,
-                 0x00000000);
-    spr_register(env, SPR_40x_TCR, "TCR",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_40x_tcr,
-                 0x00000000);
-    spr_register(env, SPR_40x_TSR, "TSR",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_40x_tsr,
-                 0x00000000);
-}
-
-/* SPR specific to PowerPC 405 implementation */
-static void register_405_sprs(CPUPPCState *env)
-{
-    /* MMU */
-    spr_register(env, SPR_40x_PID, "PID",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_40x_pid,
-                 0x00000000);
-    spr_register(env, SPR_4xx_CCR0, "CCR0",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00700000);
-    /* Debug interface */
-    spr_register(env, SPR_40x_DBCR0, "DBCR0",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_40x_dbcr0,
-                 0x00000000);
-
-    spr_register(env, SPR_405_DBCR1, "DBCR1",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-
-    spr_register(env, SPR_40x_DBSR, "DBSR",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_clear,
-                 /* Last reset was system reset */
-                 0x00000300);
-
-    spr_register(env, SPR_40x_DAC1, "DAC1",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-    spr_register(env, SPR_40x_DAC2, "DAC2",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-
-    spr_register(env, SPR_405_DVC1, "DVC1",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-
-    spr_register(env, SPR_405_DVC2, "DVC2",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-
-    spr_register(env, SPR_40x_IAC1, "IAC1",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-    spr_register(env, SPR_40x_IAC2, "IAC2",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-
-    spr_register(env, SPR_405_IAC3, "IAC3",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-
-    spr_register(env, SPR_405_IAC4, "IAC4",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-    /* Storage control */
-    spr_register(env, SPR_405_SLER, "SLER",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_40x_sler,
-                 0x00000000);
-    spr_register(env, SPR_40x_ZPR, "ZPR",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-
-    spr_register(env, SPR_405_SU0R, "SU0R",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-    /* SPRG */
-    spr_register(env, SPR_USPRG0, "USPRG0",
-                 &spr_read_ureg, SPR_NOACCESS,
-                 &spr_read_ureg, SPR_NOACCESS,
-                 0x00000000);
-    spr_register(env, SPR_SPRG4, "SPRG4",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-    spr_register(env, SPR_SPRG5, "SPRG5",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 spr_read_generic, &spr_write_generic,
-                 0x00000000);
-    spr_register(env, SPR_SPRG6, "SPRG6",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 spr_read_generic, &spr_write_generic,
-                 0x00000000);
-    spr_register(env, SPR_SPRG7, "SPRG7",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 spr_read_generic, &spr_write_generic,
-                 0x00000000);
-
-    /* Bus access control */
-    /* not emulated, as QEMU never does speculative access */
-    spr_register(env, SPR_40x_SGR, "SGR",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0xFFFFFFFF);
-    /* not emulated, as QEMU do not emulate caches */
-    spr_register(env, SPR_40x_DCWR, "DCWR",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-}
-
-
 static void register_5xx_8xx_sprs(CPUPPCState *env)
 {
     /* Exception processing */
@@ -1644,30 +1473,6 @@ static void register_8xx_sprs(CPUPPCState *env)
 
 /*****************************************************************************/
 /* Exception vectors models                                                  */
-static void init_excp_4xx(CPUPPCState *env)
-{
-#if !defined(CONFIG_USER_ONLY)
-    env->excp_vectors[POWERPC_EXCP_CRITICAL] = 0x00000100;
-    env->excp_vectors[POWERPC_EXCP_MCHECK]   = 0x00000200;
-    env->excp_vectors[POWERPC_EXCP_DSI]      = 0x00000300;
-    env->excp_vectors[POWERPC_EXCP_ISI]      = 0x00000400;
-    env->excp_vectors[POWERPC_EXCP_EXTERNAL] = 0x00000500;
-    env->excp_vectors[POWERPC_EXCP_ALIGN]    = 0x00000600;
-    env->excp_vectors[POWERPC_EXCP_PROGRAM]  = 0x00000700;
-    env->excp_vectors[POWERPC_EXCP_SYSCALL]  = 0x00000C00;
-    env->excp_vectors[POWERPC_EXCP_PIT]      = 0x00001000;
-    env->excp_vectors[POWERPC_EXCP_FIT]      = 0x00001010;
-    env->excp_vectors[POWERPC_EXCP_WDT]      = 0x00001020;
-    env->excp_vectors[POWERPC_EXCP_DTLB]     = 0x00001100;
-    env->excp_vectors[POWERPC_EXCP_ITLB]     = 0x00001200;
-    env->excp_vectors[POWERPC_EXCP_DEBUG]    = 0x00002000;
-    env->ivor_mask = 0x0000FFF0UL;
-    env->ivpr_mask = 0xFFFF0000UL;
-    /* Hardware reset vector */
-    env->hreset_vector = 0xFFFFFFFCUL;
-#endif
-}
-
 static void init_excp_MPC5xx(CPUPPCState *env)
 {
 #if !defined(CONFIG_USER_ONLY)
@@ -2138,57 +1943,6 @@ static void init_tlbs_emb(CPUPPCState *env)
 #endif
 }
 
-static void init_proc_405(CPUPPCState *env)
-{
-    register_40x_sprs(env);
-    register_405_sprs(env);
-    register_usprgh_sprs(env);
-
-    init_tlbs_emb(env);
-    init_excp_4xx(env);
-    env->dcache_line_size = 32;
-    env->icache_line_size = 32;
-    /* Allocate hardware IRQ controller */
-    ppc40x_irq_init(env_archcpu(env));
-
-    SET_FIT_PERIOD(8, 12, 16, 20);
-    SET_WDT_PERIOD(16, 20, 24, 28);
-}
-
-POWERPC_FAMILY(405)(ObjectClass *oc, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(oc);
-    PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
-
-    dc->desc = "PowerPC 405";
-    pcc->init_proc = init_proc_405;
-    pcc->check_pow = check_pow_nocheck;
-    pcc->check_attn = check_attn_none;
-    pcc->insns_flags = PPC_INSNS_BASE | PPC_STRING | PPC_MFTB |
-                       PPC_DCR | PPC_WRTEE |
-                       PPC_CACHE | PPC_CACHE_ICBI | PPC_40x_ICBT |
-                       PPC_CACHE_DCBZ | PPC_CACHE_DCBA |
-                       PPC_MEM_SYNC | PPC_MEM_EIEIO |
-                       PPC_40x_TLB | PPC_MEM_TLBIA | PPC_MEM_TLBSYNC |
-                       PPC_4xx_COMMON | PPC_405_MAC | PPC_40x_EXCP;
-    pcc->msr_mask = (1ull << MSR_WE) |
-                    (1ull << MSR_CE) |
-                    (1ull << MSR_EE) |
-                    (1ull << MSR_PR) |
-                    (1ull << MSR_FP) |
-                    (1ull << MSR_ME) |
-                    (1ull << MSR_DWE) |
-                    (1ull << MSR_DE) |
-                    (1ull << MSR_IR) |
-                    (1ull << MSR_DR);
-    pcc->mmu_model = POWERPC_MMU_SOFT_4xx;
-    pcc->excp_model = POWERPC_EXCP_40x;
-    pcc->bus_model = PPC_FLAGS_INPUT_405;
-    pcc->bfd_mach = bfd_mach_ppc_403;
-    pcc->flags = POWERPC_FLAG_CE | POWERPC_FLAG_DWE |
-                 POWERPC_FLAG_DE | POWERPC_FLAG_BUS_CLK;
-}
-
 static void init_proc_440EP(CPUPPCState *env)
 {
     register_BookE_sprs(env, 0x000000000000FFFFULL);
-- 
2.47.1


