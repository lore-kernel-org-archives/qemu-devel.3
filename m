Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37F2CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 18:15:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9STs-0000v2-6D; Thu, 16 Oct 2025 14:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <linux@weissschuh.net>)
 id 1v9STg-0000uE-FT; Thu, 16 Oct 2025 14:13:29 -0400
Received: from todd.t-8ch.de ([2a01:4f8:c010:41de::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <linux@weissschuh.net>)
 id 1v9STY-0004rY-Jr; Thu, 16 Oct 2025 14:13:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
 s=mail; t=1760638387;
 bh=fUV7Dr5PuelM18kPCjjHLViu8bL7/o8iLZn3bWfWtR8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hntXYy6J8qO8d5r4sOlNqtVvMnasSh9XZPXyVPAJLaohjk6xtrvZ6tuxow7ZPAzB0
 RVVwaUuulQF52hcKmuCHnUlBEZFAUvE+yD1Y8F9pBd6MeS6qp38qL81/LY2PzKZekx
 gKAzlYE4mTlP9qjLQsyReJ2rwlbT9RW5ua5rJuhk=
Date: Thu, 16 Oct 2025 20:13:06 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, 
 qemu-devel@nongnu.org, Heiko Carstens <hca@linux.ibm.com>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH v4 3/4] target/s390x: Use address generation for register
 branch targets
Message-ID: <b766e295-1bd0-4ac1-988d-9a2cdd47a4bf@t-8ch.de>
References: <20251016175954.41153-1-iii@linux.ibm.com>
 <20251016175954.41153-4-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251016175954.41153-4-iii@linux.ibm.com>
Received-SPF: pass client-ip=2a01:4f8:c010:41de::1;
 envelope-from=linux@weissschuh.net; helo=todd.t-8ch.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2025-10-16 19:58:32+0200, Ilya Leoshkevich wrote:
> Indirect branches to addresses taken from registers go through address
> generation, e.g., for BRANCH ON CONDITION Principles of Operation says:
> 
>     In the RR format, the contents of general register R2 are used to
>     generate the branch address
> 
> QEMU uses r2_nz handler for the respective register operands. Currently
> it does not zero out extra bits in 24- and 31-bit addressing modes as
> required by address generation. The very frequently used
> s390x_tr_init_disas_context() function has a workaround for this,
> but the code for saving an old PSW during an interrupt does not.
> 
> Add the missing masking to r2_nz. Enforce PSW validity by replacing the
> workaround with an assersion.
> 
> Reported-by: Thomas Weißschuh <linux@weissschuh.net>
> Reported-by: Heiko Carstens <hca@linux.ibm.com>
> Link: https://lore.kernel.org/lkml/ab3131a2-c42a-47ff-bf03-e9f68ac053c0@t-8ch.de/
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Thanks!

Tested-by: Thomas Weißschuh <linux@weissschuh.net>

(...)

