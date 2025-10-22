Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB7DCCD1BE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 06:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBSib-0005WE-6K; Wed, 22 Oct 2025 02:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1vBSiS-0005UV-7U
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 02:53:00 -0400
Received: from smtp233.sjtu.edu.cn ([202.120.2.233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1vBSiL-0007IH-UB
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 02:52:57 -0400
Received: from mta91.sjtu.edu.cn (unknown [10.118.0.91])
 by smtp233.sjtu.edu.cn (Postfix) with ESMTPS id 64878101737B7;
 Wed, 22 Oct 2025 14:52:26 +0800 (CST)
Received: from mstore136.sjtu.edu.cn (unknown [10.118.0.136])
 by mta91.sjtu.edu.cn (Postfix) with ESMTP id 21C6D37C8FB;
 Wed, 22 Oct 2025 14:52:26 +0800 (CST)
Date: Wed, 22 Oct 2025 14:52:25 +0800 (CST)
From: Ziyang Zhang <functioner@sjtu.edu.cn>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, 
 alex bennee <alex.bennee@linaro.org>, 
 Alexandre Iooss <erdnaxe@crans.org>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 richard henderson <richard.henderson@linaro.org>, 
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>, 
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
Message-ID: <1341969682.5812455.1761115945695.JavaMail.zimbra@sjtu.edu.cn>
Subject: [RFC PATCH V2 0/2] linux-user: add a syscall-filter plugin API
MIME-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
X-Originating-IP: [119.237.255.163]
X-Mailer: Zimbra 10.0.14_GA_4767 (ZimbraWebClient - GC141
 (Win)/10.0.15_GA_4781)
Thread-Index: O8UVQ/TJHmck9snQ4N2r1rVTqb8mpA==
Thread-Topic: linux-user: add a syscall-filter plugin API
Received-SPF: pass client-ip=202.120.2.233;
 envelope-from=functioner@sjtu.edu.cn; helo=smtp233.sjtu.edu.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi,

This commit introduces a syscall filtering mechanism for user-mode
emulation, allowing plugins to intercept and handle system calls.

The filtering mechanism works by allowing the plugins to register a
callback that is invoked before each system call. The callback can decide
whether to filter and skip the current syscall.

The syscall arguments will be dispatched in sequence to all the plugins
that have registered the filter callback. If a plugin returns true,
indicating that it has filtered this syscall, it needs to set the sysret.
After that, the syscall will no longer be dispatched to the rest plugins
and will also not be dispatched to the default handler (i.e. do_syscall1)
of QEMU.

The original syscall tracing will not be affected. If syscall is filtered,
then the callbacks used to track sysret will be recorded to the filtered
sysret.

Key changes from RFC V1 [1] to V2:
- Simplify the syscall filter mechanism and remove the fork-cpu-loop part,
  which may be implemented in the future due to its complexity.
- Reuse the existing linked list registration utility, following the
  registration style of the original syscall tracing APIs.
- Add the QEMU_PLUGIN_EV_VCPU_SYSCALL_FILTER enum to qemu_plugin_event.
- Introduce a new plugin API: qemu_plugin_register_vcpu_syscall_filter_cb.

Though Florian's set_pc method [2] offers greater flexibility, I believe
that the security and reliability guaranteed by this event filtering
approach is more important.

## Work Presented at KVM Forum Conference

At KVM Forum 2025, we presented Lorelei, a system designed to enable
guest programs executed by the QEMU user-mode emulator to accelerate
performance by invoking natively compiled host libraries via syscalls.
We have successfully supported libraries such as SDL, OpenGL, and
Vulkan, allowing QEMU user-mode to emulate GPU-dependent games.

Following an invitation from Mr. Bouvier to upstream Lorelei to QEMU, we
refined its architecture to load the Lorelei module as a TCG plugin.

Slides: https://gitlab.com/qemu-project/kvm-forum/-/raw/main/_attachments/2025/Slides_DQPMaZE.pdf
Video: https://www.youtube.com/watch?v=_jioQFm7wyU&list=PLW3ep1uCIRfxwmllXTOA2txfDWN6vUOHp&index=22

The core features required by Lorelei are the filtering processing of
system calls and the reentry and exit of CPU loops. We can start talking
about syscall filtering first.

This site [3] shows the currently supported libraries and games by
Lorelei-patched qemu-x86_64. The original qemu-x86_64 cannot leverage the
host hardware accelerators, thus fails to run these games.

We will gradually update this site, including adding the usage of
qemu-lorelei, allowing users to run games and other GUI programs using
QEMU by themselves.

[1] https://lore.kernel.org/qemu-devel/625873322.3277896.1759930752814.JavaMail.zimbra@sjtu.edu.cn/
[2] https://lists.nongnu.org/archive/html/qemu-devel/2025-08/msg00656.html
[3] https://lorelei-project.github.io/

Regards,
Ziyang Zhang

Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
---
Ziyang Zhang (2):
      linux-user: add a plugin API to filter syscalls
      tcg tests: add a test to verify the syscall filter plugin API

 include/qemu/plugin-event.h                      |  1 +
 include/qemu/plugin.h                            | 28 +++++++++++++------
 include/qemu/qemu-plugin.h                       | 24 +++++++++++++++++
 include/user/syscall-trace.h                     | 16 +++++++++++
 linux-user/syscall.c                             |  7 +++--
 plugins/api.c                                    |  7 +++++
 plugins/core.c                                   | 34 ++++++++++++++++++++++++
 tests/tcg/multiarch/Makefile.target              |  4 ++-
 tests/tcg/multiarch/test-plugin-syscall-filter.c | 21 +++++++++++++++
 tests/tcg/plugins/syscall.c                      | 14 ++++++++++
 10 files changed, 145 insertions(+), 11 deletions(-)
---
base-commit: 37ad0e48e9fd58b170abbf31c18a994346f62ed7
change-id: 20251022-lorelei-rfc-b4-03297a039dae

Best regards,
-- 
Ziyang Zhang <functioner@sjtu.edu.cn>

