Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE65CC6B2D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 03:20:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHBzo-0006oy-Iq; Wed, 14 Oct 2026 23:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xHBzn-0006o7-9L
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 23:19:07 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xHBzl-0006nr-Ij
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 23:19:07 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-89a837bf00eso394514b3a.2
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 20:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1792034344; x=1792639144; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9f2qwDesQVGTqAvTPeviHK7poyR3BmaQPfmYG/9x+2Y=;
 b=ZChdw1EtVCxztMTGLdBjFkKB9yYrnb1k30SMM4755P4jLskcDpfaeaDyQF0GdJoUCb
 bTCnDPapTe5jHEHTZ/C3MdPJnOIctC6B+61UwP9bRWU0cVM0BfYHhWGl8RJOGs+9Oyb4
 rzllNL9FfnvkOzH3+ZNvpw7B+2YOvZdRYNX655MC7IuiVm6xZHyn2sMG5ElPGtaHGOxA
 dokZ9jDgA2RIl/dr7MYQ2jVxkHdgkfhyCmenMktR5Z39p0xBQED1xHoxvjBnA/W0GkDx
 U4rLqg9jFu5T1DbCkjBFsu6ueQvkdlR+93aMngcVhWd2kujPFZ/v92yjcJOwcKDWAoyP
 dQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792034344; x=1792639144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9f2qwDesQVGTqAvTPeviHK7poyR3BmaQPfmYG/9x+2Y=;
 b=O8VEhad5Nfm7wGck0TUqUUBAnRLd8+zIoM0Wd5YxI/w7fhecugFDsH6QYFvMkxIjap
 XT49y2nkMQCkks+k/IQY1z+MMLQN9GyZubk3pTJaIb9YIZtt1Qena0FxXYABMKYM2a0r
 9kza7W4yqmcqVhJeI8lcbJ3QIeqKwHIjSU3kNxaHo2idlVYTPwI0x4rynkYZQPf7MiCC
 XXgoaFZWjQjHcr55eYslhHuEEDyBy/uJKE5pw1ykzX2+DndL1JgJyen19xo/49yaBUiM
 r1yg9rHU/vxsaCrfuqd03Xab8hkzn09W1OpwhSdp6et/F0i0MqIYFKD9MDFP/PBihwRm
 3l+g==
X-Gm-Message-State: AFq9FYIY+03TrnXcIxtT02eOnfTdYAL9oxo785CqE9QDk3VwKtM84Pfc
 /n8B3NWBFK05rlIoJtujIK0dX4wMmNar7rGkjQRomG9ihC6cMdTVWVzl1+7FeTaC9HQINrAlSAM
 JF5hf
X-Gm-Gg: AYBFou3DaC2a1P3E/7aW4xOo4bXlMh03K6AyfbdlVqvYFOwh2iVDU8vfkylMd3fQ/Qo
 oMsLifuuavcaK9YlG9q2rCqpxJ8Xlz9Jf+YmxTD4xg/l4iCHkGe+M/yc9m7qEEyrNONj8FBnjAr
 2fXv6MR8jw4BBFMu+p/5jbblS4VTMmRlp7hk8AvAH1CoM7yWU9E4AS2CCMPEiDSFj4L3Nlixjo7
 xEarx+Fnw2qzJHNfe5dSE7U2yOxPIaBCQhzbqn5YKzssV610U7XPwAetDH6N6Z2n7GyQIvL/Vbb
 giODoqoaTrA3/ScKKGRca/CtWS8vmuTMwf6n/mrwUJhWX/qCeFtLm4bBG4qIjAAUVye9RCg/ypt
 dd9ONwWSNkOaq2Uz2OoxJHsk+pTuJRIk1EO2AqFfLeaG3E+naVJalG3O5MAQiF/E8QBh1kmzF/P
 jbkdCD2/CEvx98X6RmN903cDbvKvVrWGdSih6l3J6RzEyq7OgsNWx9uaKHIWLX/5yh6QLuan7LI
 iSfboaFCNgewt3AgL3JG6i6hvyfFInHVDlkczO2iitZ9YE=
X-Received: by 2002:a17:90b:1d4f:b0:3a8:736e:c19b with SMTP id
 98e67ed59e1d1-3ab3ab31007mr24696440a91.4.1792034344035; 
 Wed, 14 Oct 2026 20:19:04 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac93049ec2sm1321725a91.1.2026.10.14.20.18.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 20:19:03 -0700 (PDT)
From: Portia Stephens <portias@oss.tenstorrent.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>
Subject: [PATCH 07/12] machine: Support extra board CPUs outside -smp
Date: Thu, 15 Oct 2026 13:17:59 +1000
Message-ID: <20261015031804.2406055-8-portias@oss.tenstorrent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015031804.2406055-1-portias@oss.tenstorrent.com>
References: <20261015031804.2406055-1-portias@oss.tenstorrent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=portias@tenstorrent.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Joel Stanley <joel@jms.id.au>

Boards may instantiate one or more CPUs that are not part of the
user's -smp layout, for example an a management or boot core of a
different CPU model. As TCG sizes its vCPU context from smp.max_cpus
during init, creating more CPUState objects than smp.max_cpus trips the
assert in tcg_register_thread().

smp.max_cpus is finalized before the accelerator is initialised and the
board's init() runs later still, so a board's initialise cannot influence
the count TCG uses.

Add a MachineClass::extra_cpus that boards set at class init time to
declare these additional CPUs. TCG can then add it to max_threads. The
field defaults to 0, so existing machines are unaffected.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
---
 accel/tcg/tcg-all.c      | 2 +-
 include/hw/core/boards.h | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 767e880555..655609ebbb 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -126,7 +126,7 @@ static int tcg_init_machine(AccelState *as, MachineState *ms)
          */
         if (mttcg_supported && !icount_enabled()) {
             s->mttcg_enabled = ON_OFF_AUTO_ON;
-            max_threads = ms->smp.max_cpus;
+            max_threads = ms->smp.max_cpus + MACHINE_GET_CLASS(ms)->extra_cpus;
         } else {
             s->mttcg_enabled = ON_OFF_AUTO_OFF;
         }
diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index d0e4ad9820..575c6bcb31 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -189,6 +189,9 @@ typedef struct {
  * @max_cpus: maximum number of CPUs supported. Default: 1
  * @min_cpus: minimum number of CPUs supported. Default: 1
  * @default_cpus: number of CPUs instantiated if none are specified. Default: 1
+ * @extra_cpus: number of additional CPUs the board always instantiates beyond
+ *    the -smp topology (e.g. an always-present management core). Accelerators
+ *    add this to the per-vCPU state they allocate. Default: 0
  * @is_default:
  *    If true QEMU will use this machine by default if no '-M' option is given.
  * @get_hotplug_handler: this function is called during bus-less
@@ -287,6 +290,7 @@ struct MachineClass {
     int max_cpus;
     int min_cpus;
     int default_cpus;
+    int extra_cpus;
     unsigned int no_serial:1,
         no_parallel:1,
         no_floppy:1,
-- 
2.43.0


