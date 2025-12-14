Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 569B6D5B169
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Dec 2025 14:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vUn40-0003DL-Im; Sun, 14 Dec 2025 09:27:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1vUn3z-0003DD-8c
 for qemu-devel@nongnu.org; Sun, 14 Dec 2025 09:27:07 -0500
Received: from smtp237.sjtu.edu.cn ([202.120.2.237])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1vUn3v-0007L7-Fs
 for qemu-devel@nongnu.org; Sun, 14 Dec 2025 09:27:06 -0500
Received: from proxy189.sjtu.edu.cn (smtp189.sjtu.edu.cn [202.120.2.189])
 by smtp237.sjtu.edu.cn (Postfix) with ESMTPS id C0AD17FB89;
 Sun, 14 Dec 2025 22:26:52 +0800 (CST)
Received: from [10.0.1.62] (unknown [202.120.40.100])
 by proxy189.sjtu.edu.cn (Postfix) with ESMTPSA id C94B63FC1FC;
 Sun, 14 Dec 2025 22:26:40 +0800 (CST)
Message-ID: <297a6ffa-62a9-434f-8ba5-3028f7731072@sjtu.edu.cn>
Date: Sun, 14 Dec 2025 22:26:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] linux-user: add plugin API to filter syscalls
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20251214141022.173340-1-functioner@sjtu.edu.cn>
From: Ziyang Zhang <functioner@sjtu.edu.cn>
In-Reply-To: <20251214141022.173340-1-functioner@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=202.120.2.237;
 envelope-from=functioner@sjtu.edu.cn; helo=smtp237.sjtu.edu.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

On Sun, 14 Dec 2025 22:10:20 +0800, Ziyang Zhang wrote:
> We choose a smaller magic syscall number to avoid the illegal instruction
> exception [1] on qemu-arm.
> 
> PATCH v3:
>    1. Change to a smaller magic syscall number and add comments
>    2. Set register flags out of the for-loop
> 
> PATCH v2:
>    1. Rebased on newest version of master
> 
> PATCH v1:
>    1. Format the code
> 
> RFC v2:
>    1. Simplify the syscall filter mechanism and remove fork-cpu
>    2. Add QEMU_PLUGIN_EV_VCPU_SYSCALL_FILTER enum
> 
> RFC v1:
>    1. Add syscall filter registry
>    2. Add fork-cpu interface to re-enter cpu_loop when handling syscalls
> 
> [1] https://lore.kernel.org/qemu-devel/20251212141541.1792111-1-functioner@sjtu.edu.cn/T/#m0e6809c5a894d64a8b7e67324a4b7cb414c644bf
> 
> Ziyang Zhang (2):
>    linux-user: add plugin API to filter syscalls
>    tcg tests: add a test to verify the syscall filter plugin API
> 
>   include/qemu/plugin-event.h                   |  1 +
>   include/qemu/plugin.h                         | 33 ++++++++++++-----
>   include/qemu/qemu-plugin.h                    | 32 ++++++++++++++++
>   include/user/syscall-trace.h                  | 17 +++++++++
>   linux-user/syscall.c                          |  7 +++-
>   plugins/api.c                                 |  7 ++++
>   plugins/core.c                                | 37 +++++++++++++++++++
>   tests/tcg/multiarch/Makefile.target           |  4 +-
>   .../multiarch/test-plugin-syscall-filter.c    | 35 ++++++++++++++++++
>   tests/tcg/plugins/syscall.c                   | 19 ++++++++++
>   10 files changed, 180 insertions(+), 12 deletions(-)
>   create mode 100644 tests/tcg/multiarch/test-plugin-syscall-filter.c
> 
This patch is deprecated. Please ignore it and refer to the latest
version [1].

[1] 
https://lore.kernel.org/qemu-devel/20251214141959.175805-1-functioner@sjtu.edu.cn/T/#t

