Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F865CD6E57
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 10:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV5C1-0001Aa-TE; Thu, 04 Jun 2026 06:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>) id 1wV5Bz-0001AL-U1
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 06:20:51 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>) id 1wV5By-0005oU-9v
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 06:20:51 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 42EF660219;
 Thu,  4 Jun 2026 10:20:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30EA31F00893;
 Thu,  4 Jun 2026 10:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780568442;
 bh=t32UCcdqzr85sSwnUwG9VfbZyyVpZARBWfAm1PwHlpU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=Ds1zq22uddwxA6eU1OayKfdHhp7IB2AQCbsMRREymJWDw1X9TcZEX6J0EOSTc8g7I
 ETdITDVYP9sFJs1KgpzoVXxtm/B0CxvMoZkr1hRWrGOm/H302LrOQRluBniS9wpc7K
 3YFnejchP2/O2eYE+U8Rd91hs+0UWpig7ZZ3LFt29VERonOIDvI2LDJhHuOz1wx/xK
 6LVxKVIlSU0GorCR9cOYzdQqzvc6hOlJlGMbAzVNUCtR11/60J4FbZSqFhnXv9xt+7
 89e0ozeIDOEeq7gsO+8OC8JNDS16CblspU+bvWFSIK+SaRSfoX6iZ7jnotr8KFEm3J
 xGHlct1mcqfww==
Date: Thu, 4 Jun 2026 11:20:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/4] hw/cxl: Use host-only coherency for default CFMW
 restrictions
Message-ID: <20260604112035.4a0ba93d@jic23-huawei>
In-Reply-To: <20260602231806.2469011-3-dave@stgolabs.net>
References: <20260602231806.2469011-1-dave@stgolabs.net>
 <20260602231806.2469011-3-dave@stgolabs.net>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=jic23@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue,  2 Jun 2026 16:18:04 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Change the default CXL Fixed Memory Window restrictions from 0x2f to
> 0xe, dropping Device Coherent and Back-Invalidate.
> 
> host-only coherent combined with Back-Invalidate is undefined behavior.

That one I'm fine with.

> Device Coherent alongside host-only coherent is permitted by the spec
> (multiple restriction bits may be set) but advertises conflicting
> coherency modes; neither belongs in the host-only default.

Why not in the default?  Software should be fine with it and it
means the default emulation is slightly more likely to function for
simple cases.  I don't feel that strongly about it given we don't
have an device coherent devices emulated in QEMU, but wanted to understand
your reasoning a little more.

Jonathan

> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  hw/acpi/cxl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
> index f92f7fa3d558..5ce5e8e083ba 100644
> --- a/hw/acpi/cxl.c
> +++ b/hw/acpi/cxl.c
> @@ -172,7 +172,7 @@ static void cedt_build_cfmws(CXLFixedWindow *fw, Aml *cedt)
>      build_append_int_noprefix(table_data, fw->enc_int_gran, 4);
>  
>      /* Window Restrictions */
> -    build_append_int_noprefix(table_data, 0x2f, 2);
> +    build_append_int_noprefix(table_data, 0xe, 2);
>  
>      /* QTG ID */
>      build_append_int_noprefix(table_data, 0, 2);


