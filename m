Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF9F8C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 06:41:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCuwB-0007cc-IY; Thu, 08 May 2025 02:40:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1uCuw8-0007ar-8a
 for qemu-devel@nongnu.org; Thu, 08 May 2025 02:40:53 -0400
Received: from zuban.uni-paderborn.de ([2001:638:502:c003::17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1uCuw3-0002GE-54
 for qemu-devel@nongnu.org; Thu, 08 May 2025 02:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=uni-paderborn.de; s=20170601; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NnZoVKkLHN+FYnNREYkg/lZa/3aGf15DndGvLl62Ie0=; b=FO6Ly4wARzr5irA6NJ9tAmMVY4
 0SGrAAEU7/sHFntMvX5GDI2Rtg46l4ZKX+QJtSVfa4IgD+VRzn02jLexpnDrLNZ3bHKsLnYSil7sN
 u/4mhbtyQa7bR0W+AjcwzlrtO48NRehgq2DAwutFhHAX/bDxD612drEbeCgur04TWBNk=;
Date: Thu, 8 May 2025 08:40:30 +0200
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, foss@percivaleng.com, 
 Michael Rolnik <mrolnik@gmail.com>, Laurent Vivier <laurent@vivier.eu>, 
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Stafford Horne <shorne@gmail.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH 03/12] target: Use cpu_pointer_wrap_uint32 for 32-bit
 targets
Message-ID: <ma2ujmsw2mzw747azwohjxdqeu4j4wog24sxhvg2uo5hvf6xmz@kyep4r5ocrwf>
References: <20250504205714.3432096-1-richard.henderson@linaro.org>
 <20250504205714.3432096-4-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250504205714.3432096-4-richard.henderson@linaro.org>
X-IMT-Source: Extern
X-IMT-rspamd-score: -10
X-UPB-Report: Action: no action, RCVD_TLS_ALL(0.00), FROM_HAS_DN(0.00),
 FROM_EQ_ENVFROM(0.00), FREEMAIL_ENVRCPT(0.00), SUSPICIOUS_RECIPS(1.50),
 BAYES_HAM(-2.99), TO_MATCH_ENVRCPT_ALL(0.00), MID_RHS_NOT_FQDN(0.50),
 MIME_GOOD(-0.10), FREEMAIL_CC(0.00), NEURAL_HAM(0.00), RCPT_COUNT_SEVEN(0.00),
 TAGGED_RCPT(0.00), RCVD_VIA_SMTP_AUTH(0.00), ARC_NA(0.00), ASN(0.00),
 RCVD_COUNT_ONE(0.00), MIME_TRACE(0.00), TO_DN_SOME(0.00), MISSING_XM_UA(0.00),
 Message-ID: ma2ujmsw2mzw747azwohjxdqeu4j4wog24sxhvg2uo5hvf6xmz@kyep4r5ocrwf
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: kbastian@UNI-PADERBORN.DE
Received-SPF: pass client-ip=2001:638:502:c003::17;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=zuban.uni-paderborn.de
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
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

On Sun, May 04, 2025 at 01:57:04PM -0700, Richard Henderson wrote:
> M68K, MicroBlaze, OpenRISC, RX, TriCore and Xtensa are
> all 32-bit targets.  AVR is more complicated, but using
> a 32-bit wrap preserves current behaviour.
> 
> Cc: Michael Rolnik <mrolnik@gmail.com>
> Cc: Laurent Vivier <laurent@vivier.eu>
> Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/accel/tcg/cpu-ops.h | 1 +
>  accel/tcg/cputlb.c          | 6 ++++++
>  target/avr/cpu.c            | 6 ++++++
>  target/m68k/cpu.c           | 1 +
>  target/microblaze/cpu.c     | 1 +
>  target/openrisc/cpu.c       | 1 +
>  target/rx/cpu.c             | 1 +
>  target/tricore/cpu.c        | 1 +
>  target/xtensa/cpu.c         | 1 +
>  9 files changed, 19 insertions(+)

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

For the TriCore part:
Tested-by Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Cheers,
Bastian

