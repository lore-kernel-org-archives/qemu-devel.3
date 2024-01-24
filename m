Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A96C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 17:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSgqx-0000wZ-TP; Wed, 24 Jan 2024 12:15:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rSgqi-0000ue-CO
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 12:15:41 -0500
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rSgqe-000543-En
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 12:15:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fCa8GlC9TURTumaUxW2c0Yr4NmJxu+xnymHwGlJW4Tw=; b=ZumNgcmy9NLIit8wpGNQcCjPqV
 0oWUq4si08+pM630YLYwjNEZPYsy7nT9vvY1qLUNbxynl3QkDJlYEY0vA1tJe1KiB6qxXwWUI9JOn
 8FfLUj0fL+jzgaELSB8+Ki0z3qFK/HP5JfFKSUxoHv30f9G75fAcH4f8DYlGWMgi4GWI=;
Date: Wed, 24 Jan 2024 18:15:42 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>, 
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH 5/9] accel/tcg: Hoist CPUClass arg to functions with
 external linkage
Message-ID: <xw77z5w543t4v56c5giqbzdxlu32vh5yg3aq4c6irrrzhszbu3@occtjm3grqsb>
References: <20240124101639.30056-1-philmd@linaro.org>
 <20240124101639.30056-6-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240124101639.30056-6-philmd@linaro.org>
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 24/01/24, Philippe Mathieu-Daudé wrote:
> Hoist the CPUClass argument from most of these internal helpers:
> 
>  - check_for_breakpoints_slow
>  - check_for_breakpoints()
>  - cpu_tb_exec()
>  - cpu_exec_enter()
>  - cpu_exec_exit()
>  - cpu_handle_halt()
>  - cpu_handle_debug_exception()
>  - cpu_handle_exception()
>  - need_replay_interrupt()
>  - cpu_handle_interrupt()
>  - cpu_loop_exec_tb()
>  - cpu_exec_loop()
>  - cpu_exec_setjmp()
> 
> to the following ones with external linkage:
> 
>  - lookup_tb_ptr()
>  - cpu_exec_step_atomic()
>  - cpu_exec()
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  accel/tcg/cpu-exec.c | 82 ++++++++++++++++++++------------------------
>  1 file changed, 37 insertions(+), 45 deletions(-)
> 
Reviewed-by: Anton Johansson <anjo@rev.ng>

