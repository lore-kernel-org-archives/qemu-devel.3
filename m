Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3464C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 08:26:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh17f-0000Jr-S4; Tue, 07 Jul 2026 04:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dblanzeanu@linux.microsoft.com>)
 id 1wh17d-0000JX-Vq
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 04:25:41 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dblanzeanu@linux.microsoft.com>) id 1wh17c-0001DR-4M
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 04:25:41 -0400
Received: from laptop.localdomain (unknown [86.121.140.206])
 by linux.microsoft.com (Postfix) with ESMTPSA id 6E93620B7166;
 Tue,  7 Jul 2026 01:25:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6E93620B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1783412733;
 bh=1HSsuGq5OiXI7I3ShhonkNCHnaqsGaRUZDMsDnamtbQ=;
 h=From:To:Cc:Subject:Date:From;
 b=pXhPEml3MjkmtyTO9MxO/cdIl0TIzSKzW2+smQibSXgD8lAm1nN/2VpSodb4ESeRM
 RMmHJaxOzBO19yrMCUuaasrr2iKjlRnzABGojZDzWZwnpK+0IJtWCy4Ezd8lW7PYbS
 8/6oby38dHqud9Dgz+pnRkqj59LEVwvChgkLqWh4=
From: =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Wei Liu <liuwe@microsoft.com>, Magnus Kulke <magnuskulke@microsoft.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PATCH 0/5] Fix register page use for guests using mshv accel
Date: Tue,  7 Jul 2026 11:25:26 +0300
Message-ID: <20260707082531.178539-1-dblanzeanu@linux.microsoft.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=dblanzeanu@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
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

This patch series is a fix for the recent merge of the outdated patch series:
https://lore.kernel.org/all/20260428135053.251200-1-dblanzeanu@linux.microsoft.com/

The above patch series had some newer versions that fixed addressed feedback
from reviewers.

The commits do the following:
1. Moves the definition for the `hv_vp_register_page` to `hvhdk.h`
   Fixes: 8afb40b7fe
2. Changes the register page setup to fail in case the mmap of the page fails.
   This way it signals an issue early.
   Fixes: a173f8f170
3. Rename functions local to the `mshv-cpu.c` linked to register page get.
   Use the register page to read registers on VM exit. General purpose
   registers, RIP, RFLAGS, segment registers, and control registers
   (CR0, CR4, CR4, CR8, EFER) are read directly from the page. Registers
   not present on the page (TR, LDTR, GDTR, IDTR, CR2, APIC_BASE) are not
   fetched anymore for performance reasons.
   Removes the fallback to ioctls in case the register page is not correctly set
   up and aborts.
   Fixes: 40072a7391
4. Changes the registers storing to only use the register page and not rely on
   ioctls for perfomance improvements. From local tests, the special registers
   that are not stored, do not get modified when emulating. However, if there's
   an issue discovered, we'll fix later.
   Fixes: 80c7f8e9cd
5. When a device handler (e.g. vmport) calls cpu_synchronize_state() during
   I/O port dispatch, it sets cpu->accel->dirty = true and may modify
   registers directly in env. The old PIO code ignored this: it
   unconditionally wrote the stale info->rax from the VM-exit intercept
   message back to the hypervisor and then cleared dirty, discarding any
   register changes made by the device.
   Note: This was a change present in version 3 of the patch series but not
   present in the version 1 of the patch series (the one merged)

The register page is only used when it has been successfully mmapped and
the hypervisor has marked it as valid (`isvalid != 0`). Otherwise, an error is
returned and execution aborted to signal something faulty and unexpected.
-----BEGIN SSH SIGNATURE-----
U1NIU0lHAAAAAQAAAE0AAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgF4l9Pi
ZyIMDy0ZI4SCYaMCvjXS3h6Dpo3xDFvSh0I7oAAAAHc3NoOmdpdAAAAANnaXQAAAAAAAAA
BnNoYTUxMgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABA4egRAbnGLI
XkdzHMqxAMQj1wQNIw+Ja9we8xUkEiJW96FaummDyD2h2TxplwF93KnWYW/sUYZMX5b1C3
3OOcBgUAACUF
-----END SSH SIGNATURE-----
-----BEGIN SSH SIGNATURE-----
U1NIU0lHAAAAAQAAAE0AAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgF4l9Pi
ZyIMDy0ZI4SCYaMCvjXS3h6Dpo3xDFvSh0I7oAAAAHc3NoOmdpdAAAAANnaXQAAAAAAAAA
BnNoYTUxMgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABAqkJRImazba
3Xjj17Hi7FDcJ5XC7f+rFXUvDc58gax1GyCHtOu16ldDx3ldSi2Zl8iGFtauFsLHRAdPpK
IoPyDAUAACUR
-----END SSH SIGNATURE-----

Doru Blânzeanu (5):
  include/hw/hyperv: move hv_vp_register_page struct definition
  target/i386/mshv: abort when hv_vp_register_page setup fails
  target/i386/mshv: remove fallback for register page get registers
  target/i386/mshv: remove fallback for register page set registers
  target/i386/mshv: fix pio handlers clobbering device-modified
    registers

 include/hw/hyperv/hvgdk.h      |   2 +
 include/hw/hyperv/hvgdk_mini.h | 103 --------------
 include/hw/hyperv/hvhdk.h      | 106 ++++++++++++++
 target/i386/mshv/mshv-cpu.c    | 249 +++++++++++++++------------------
 4 files changed, 220 insertions(+), 240 deletions(-)

-- 
2.53.0


