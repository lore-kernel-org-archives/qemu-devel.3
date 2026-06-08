Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90984CD8C92
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 09:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWWi1-0002mo-3b; Mon, 08 Jun 2026 05:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wWWhy-0002mV-4s
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 05:55:50 -0400
Received: from msg-3.mailo.com ([213.182.54.8] helo=mailo.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wWWhv-0003FK-4y
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 05:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailo.com; s=mailo;
 t=1780912541; bh=cr63psHMod4DLEqZihUjxIgm1T6x8wdtDF+X/3kgGNQ=;
 h=X-EA-Auth:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 b=ZfDzGP+wrsuvFcN8piPlQDfNHa5qxZYVTr1joX3jU64n4+VVkymVRj2YrGHcdkC0P
 75vLSdDMnqiLw7QjwKxdH8LYSXI9GP7jaXj7yfPlUrfO9XbOjN81V6uHNx5vHeRL/c
 f8gz7ZlGVEswn8fV47lvl9zEjjd64f8hJHeu0A/s=
Received: by be1-8.in.mailobj.net [192.168.91.18] with ESMTP
 via ip-20.mailobj.net [213.182.54.20]
 Mon,  8 Jun 2026 11:55:40 +0200 (CEST)
X-EA-Auth: vN0hgSelzfsoJAxmDguCMJyuXofxCyev5qAxCWQBMSYlfJFd+jppkJA0Qx972Yvs7ezUoy3rXN/W0pva0p6zaLOCQcB6nNCJ
Message-ID: <1c091e2a-2fdf-43fa-b52a-c225a000d023@mailo.com>
Date: Mon, 8 Jun 2026 11:55:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tcg: Silence ubsan error on tcg_splitwx_diff causing
 overflow
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260605132539.2775364-1-farosas@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Content-Language: en-US
In-Reply-To: <20260605132539.2775364-1-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=213.182.54.8; envelope-from=philmd@mailo.com;
 helo=mailo.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/6/26 15:25, Fabiano Rosas wrote:
> UBSAN complains:
> runtime error: addition of unsigned offset to 0x7bc06e1f5000
> overflowed to 0x7bc02e1f5000
> 
> Change tcg_splitwx_diff to ptrdiff_t and silence the error.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   include/tcg/tcg.h | 2 +-
>   tcg/tcg.c         | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>



