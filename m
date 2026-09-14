Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D241DC88E6F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 19:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Coa-00089l-3o; Mon, 14 Sep 2026 15:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1x6CoT-00089b-3T
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 15:58:01 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1x6CoQ-0001qd-Qb
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 15:58:00 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:6522:0:640:3362:0])
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id 52A7280605;
 Mon, 14 Sep 2026 22:57:52 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:65c::1:a] (unknown [2a02:6bf:8080:65c::1:a])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id pvZ3k40hTiE0-WkhwDK0H; Mon, 14 Sep 2026 22:57:52 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1789415872;
 bh=JIRXnDr5PQUo2FM/QgI3Pg6aB/SvO6pOK89MsE2K2JE=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=cfzEGZBO9hTzVUF0V7UoaN2rwBbESqY7i9FXJYqCSTIPI32Tzud7XNn6OX43fBCS7
 mP2WBpAJAF/WvrLxX0LHMm6Ogn3FZosKjODQuJuAzqGbm6ahatMdjcD7XSTsHONVbm
 7zfAAXZLJLDjO1ZC6/SBvrS2gUVjX7nPQ0hFHpBI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <78ca5b84-1c7b-4367-986d-4cad3b21df61@yandex-team.ru>
Date: Mon, 14 Sep 2026 22:57:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 0/2] x86: fix a stale ExtINT request after LINT0 is masked
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260905004153.836866-1-d-tatianin@yandex-team.ru>
Content-Language: en-US
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
In-Reply-To: <20260905004153.836866-1-d-tatianin@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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

Ping :)

On 9/5/26 3:41 AM, Daniil Tatianin wrote:
> This fixes a few problems that eventually lead to the guest receiving a
> bogus #GP due to a stale interrupt still being asserted. Either patch
> fixes the problem, but the first one fixes the actual root cause, and
> the second one simply aligns interrupt handling with KVM, which made
> the bug invisible by simply dropping the IRQ targeting a bogus vector.
>
> Daniil Tatianin (2):
>    hw/intc/apic: don't drop irq line re-evaluation when LINT0 is masked
>    target/i386: drop attempts to deliver an interrupt without a vector
>
>   hw/intc/apic.c                      | 3 ++-
>   target/i386/tcg/system/seg_helper.c | 3 +++
>   2 files changed, 5 insertions(+), 1 deletion(-)
>

