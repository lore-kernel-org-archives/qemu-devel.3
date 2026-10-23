Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EF6606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 14:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=rev.ng header.i=@rev.ng header.a=rsa-sha256 header.s=dkim header.b=V28BYfR/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKFpQ-0003H6-9i; Fri, 23 Oct 2026 10:01:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1xKFpN-00038A-J9
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:01:01 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1xKFpK-0005Ap-3X
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=Mo3b7t6yCNl6+Imrnm8rp/yMNV7hTzYtCtLz83uo454=; b=V28BYfR/mB48OSy
 gHWwu+j39ep0f9GBMu0htXT3ejynuDAQx2tuFdNIwfAIQbQ2StPhFLpDfaIu+3bQ3DCMjT8HXXhY2
 9TbKffxrywU5vNQkK3NhtRL0VRtkqyXrHgD+uJ8QFaITI66v1cA6nAy0PbT1x3wuGjU5v6YwzTMIr
 Xo=;
Date: Fri, 23 Oct 2026 16:06:17 +0200
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH] target/hexagon: Expand gdb_get_regl() -> gdb_get_reg32()
 again
Message-ID: <attpx9SQxuO1PH3w@hive.localdomain>
References: <20261023135336.49641-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261023135336.49641-1-philmd@oss.qualcomm.com>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 23/10/26, Philippe Mathieu-Daudé wrote:
> Commit 780fbbef2a2 ("target/hexagon: gdbstub - Add sys reg
> support") re-introduced calls to gdb_get_regl(). Since
> Hexagon target is only built as 32-bit, replace them again
> by gdb_get_reg32(), similarly to commit previous 7831e5f48d2
> ("target/hexagon: Expand gdb_get_regl() -> gdb_get_reg32()").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  target/hexagon/gdbstub.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/hexagon/gdbstub.c b/target/hexagon/gdbstub.c
> index ca6d4a98369..85d9845cc94 100644
> --- a/target/hexagon/gdbstub.c
> +++ b/target/hexagon/gdbstub.c
> @@ -96,12 +96,12 @@ int hexagon_sys_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
>              val = cpu->globalregs ?
>                  hexagon_globalreg_read(cpu->globalregs, n, env->threadId) : 0;
>          }
> -        return gdb_get_regl(mem_buf, val);
> +        return gdb_get_reg32(mem_buf, val);
>      }
>      n -= NUM_SREGS;
>  
>      if (n < NUM_GREGS) {
> -        return gdb_get_regl(mem_buf, hexagon_greg_read(env, n));
> +        return gdb_get_reg32(mem_buf, hexagon_greg_read(env, n));
>      }
>      n -= NUM_GREGS;
>  
> -- 
> 2.55.0
> 

Reviewed-by: Anton Johansson <anjo@rev.ng>

