Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95EF5E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 06:42:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXacV-0007AE-3u; Tue, 14 Jan 2025 01:41:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1tXacP-00079V-L9
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 01:41:41 -0500
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1tXacM-00063x-Ic
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 01:41:41 -0500
Message-ID: <7dd7787e-4eb3-47f9-bca6-2bfab69caf4a@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1736836893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H2x+BuWZtdcG9IYNAQFbJhLkRv5Zg/wX0ShymTbchjs=;
 b=G87kMVwcbQQw2VwyA2ykcXEsE02eleR9KP/Ej0+cVxzh3dJ7H2G1zLdz0P0ES/Ra2nRLRG
 scGXFSOM4s+69CupvmvlHziwEckCZf5C2DXUip/9aIowmWSRyuQvitVFV97CX8pvXa2AWg
 EE0Z0+s7hNjC+IQztW7tUBt1w0kl1nM=
Date: Tue, 14 Jan 2025 09:41:33 +0300
MIME-Version: 1.0
Subject: Re: [PATCH] hw/timer: fix int underflow
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org
References: <20241106104041.624806-2-frolov@swemel.ru>
 <CAFEAcA-b+XcYEm1MASzedYchmy0TOpv2djqssJtQdu2CTw_jTw@mail.gmail.com>
From: =?UTF-8?B?0JTQvNC40YLRgNC40Lkg0KTRgNC+0LvQvtCy?= <frolov@swemel.ru>
In-Reply-To: <CAFEAcA-b+XcYEm1MASzedYchmy0TOpv2djqssJtQdu2CTw_jTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=95.143.211.150; envelope-from=frolov@swemel.ru;
 helo=mx.swemel.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hello, Peter.
I beg a pardon, but I guess, we have a misunderstanding here.

The problem is that comparison "if (limit < 0)" will never
be true. Thus, "true" branch is unreachable. According to
the comment below, it was assumed that "limit" may be
negative, and this means, that "QEMU is running too slow...".

"limit" is declared as "long long" and it is initialized
with diff of two unsigned values:
"timeout - imx_gpt_update_count(s)".
Unsigned subtraction will never give a signed result!
if timeout > imx_gpt_update_count(s), the result will be > 0.
if timeout < imx_gpt_update_count(s), the result will also
be > 0 (underflow). Then, actually, this (positive) result
will be implicitly casted to "long long" and assigned to
"limit". This makes no sense!

So, to my opinion, explicit cast to "long long" is necessary
here to get the expected behavior.

With best regards,
Dmitry.

