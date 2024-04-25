Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34BFBC10F15
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 07:41:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rztj2-0003jz-5v; Thu, 25 Apr 2024 03:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1rztix-0003iT-De; Thu, 25 Apr 2024 03:40:56 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1rztiv-0002XI-M6; Thu, 25 Apr 2024 03:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=pnepO0zBuqc+XAIncvP9cfmf9PXJe6QI78Je+G6F3xE=; b=fG/8cL9mS/mOuvv
 WyvlKssUpi75mDcXtszxhRej4+TCnuJsHnMmv0/w1mPpnPcGcgCfvQfYDoNjZQvf01oHSfNMq2DAd
 /8+Vnl5+Ndg37gz2nLEjPn36I1lKONMZ0oSOPNGa9drOIx4sfqOlAumA/20ceghWxmY/Tl9TZyT7k
 yU=;
Date: Thu, 25 Apr 2024 09:42:03 +0200
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, 
 David Hildenbrand <david@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH 15/24] exec: Restrict inclusion of 'user/guest-base.h'
Message-ID: <mq2o3t4pyz4g7yczjryzztv6cslctqfkgktrznmsietkieg6fi@as6hdgvawnie>
References: <20240418192525.97451-1-philmd@linaro.org>
 <20240418192525.97451-16-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240418192525.97451-16-philmd@linaro.org>
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
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

On 18/04/24, Philippe Mathieu-Daudé wrote:
> Declare 'have_guest_base' in "user/guest-base.h".
> 
> Very few files require this header, so explicitly include
> it there instead of "exec/cpu-all.h" which is used in many
> source files.
> 
> Assert this user-specific header is only included from user
> emulation.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20231211212003.21686-23-philmd@linaro.org>
> ---
>  include/exec/cpu-all.h    | 3 ---
>  include/exec/cpu_ldst.h   | 2 ++
>  include/user/guest-base.h | 6 ++++++
>  bsd-user/main.c           | 1 +
>  linux-user/elfload.c      | 1 +
>  linux-user/main.c         | 1 +
>  6 files changed, 11 insertions(+), 3 deletions(-)

Reviewed-by: Anton Johansson <anjo@rev.ng>

