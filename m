Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9058CC3ABC9
	for <qemu-devel@archiver.kernel.org>; Sat, 10 May 2025 16:37:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDnBx-0004mv-1H; Sat, 10 May 2025 12:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <whitebox@nefkom.net>)
 id 1uDnBu-0004mi-Sj
 for qemu-devel@nongnu.org; Sat, 10 May 2025 12:36:46 -0400
Received: from mail-out.m-online.net ([2001:a60:0:28:0:1:25:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <whitebox@nefkom.net>)
 id 1uDnBs-0003ZF-Ey
 for qemu-devel@nongnu.org; Sat, 10 May 2025 12:36:46 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4Zvs2Y5R6Fz1sFNS;
 Sat, 10 May 2025 18:36:37 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4Zvs2Y4hxlz1qqlW;
 Sat, 10 May 2025 18:36:37 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id USUquRbOHs4S; Sat, 10 May 2025 18:36:27 +0200 (CEST)
X-Auth-Info: 5CDLlVmWbkMV3dPEGnz1QMyxbNmvNtzGb4t07QcR2l+wviQu5kFhQrMyQ+dMMEgi
Received: from igel.home (aftr-82-135-83-241.dynamic.mnet-online.de
 [82.135.83.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA;
 Sat, 10 May 2025 18:36:27 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
 id BE03E2C1955; Sat, 10 May 2025 18:36:26 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  laurent@vivier.eu
Subject: Re: [PATCH v5 21/24] target/m68k: Implement packed decimal real
 loads and stores
In-Reply-To: <20250507211300.9735-22-richard.henderson@linaro.org> (Richard
 Henderson's message of "Wed, 7 May 2025 14:12:56 -0700")
References: <20250507211300.9735-1-richard.henderson@linaro.org>
 <20250507211300.9735-22-richard.henderson@linaro.org>
Date: Sat, 10 May 2025 18:36:26 +0200
Message-ID: <875xi8zalx.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:a60:0:28:0:1:25:1;
 envelope-from=whitebox@nefkom.net; helo=mail-out.m-online.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_LOW=-0.7,
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

On Mai 07 2025, Richard Henderson wrote:

> +    /* Convert the 3 digit decimal exponent to binary. */
> +    exp = ((hi >> 24) & 0xf)
> +        + ((hi >> 20) & 0xf) * 10
> +        + ((hi >> 16) & 0xf) * 100;

This is backwards.  An exponent of 123 is stored as 0x01230000, not
0x03210000.

> +    for (int i = 24; exp10; i -= 4, exp10 /= 10) {
> +        res_hi |= (exp10 % 10) << i;

Again, this is backwards.  Also, the decimal exponent of an extended
precision number can be as big as 4951.  From the fpsp040:

| A15. Convert the exponent to bcd.
|      As in A14 above, the exp is converted to bcd and the
|      digits are stored in the final string.
|
|      Digits are stored in L_SCR1(a6) on return from BINDEC as:
|
|	 32               16 15                0
|	-----------------------------------------
|	|  0 | e3 | e2 | e1 | e4 |  X |  X |  X |
|	-----------------------------------------

That is, the fourth digit of the exponent is stored in the upper 4 bits
of the padding (OPERR is set if e4 is non-zero).

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

