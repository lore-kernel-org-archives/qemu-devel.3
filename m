Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB525C27C75
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 12:32:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH0fT-0001Qy-K0; Tue, 11 Jun 2024 08:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>)
 id 1sH0fR-0001QD-VA; Tue, 11 Jun 2024 08:32:01 -0400
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>)
 id 1sH0fQ-0000t6-28; Tue, 11 Jun 2024 08:32:01 -0400
Message-ID: <4f9e536c-1dd8-43e3-8c0b-cc4ee5832e10@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1718109116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AhH1WYkiF+1NPJkaIk1wcbcYku6uZVNzMKCMpAeKbmo=;
 b=kZl30vRdKQSRrN/7O82IzSERA6nz1iVLAzUjgsnbo+urlkBzUz3mFZjq/wW5TkFtWkUyiU
 /n6QFsoMvR6o7oU75exhlvq/gmi0A7BBVNu7W4F+oxckavMMaZd/YJaBsibvUJRjJNB3Je
 gAKWroPeAoLEcx5k47d170XW1R89Upo=
Date: Tue, 11 Jun 2024 15:31:56 +0300
MIME-Version: 1.0
Subject: Re: [PATCH] tests/qtest/fuzz/virtio_net_fuzz.c: fix
 virtio_net_fuzz_multi
Content-Language: en-US
To: alxndr@bu.edu
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, sdl.qemu@linuxtesting.org
References: <20240523102813.396750-2-frolov@swemel.ru>
From: =?UTF-8?B?0JTQvNC40YLRgNC40Lkg0KTRgNC+0LvQvtCy?= <frolov@swemel.ru>
In-Reply-To: <20240523102813.396750-2-frolov@swemel.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=95.143.211.150; envelope-from=frolov@swemel.ru;
 helo=mx.swemel.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

ping

https://patchew.org/QEMU/20240523102813.396750-2-frolov@swemel.ru/

On 23.05.2024 13:28, Dmitry Frolov wrote:
> If QTestState was already CLOSED due to error, calling qtest_clock_step()
> afterwards makes no sense and only raises false-crash with message:
> "assertion timer != NULL failed".
>
> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
> ---
>   tests/qtest/fuzz/virtio_net_fuzz.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/tests/qtest/fuzz/virtio_net_fuzz.c b/tests/qtest/fuzz/virtio_net_fuzz.c
> index e239875e3b..2f57a8ddd8 100644
> --- a/tests/qtest/fuzz/virtio_net_fuzz.c
> +++ b/tests/qtest/fuzz/virtio_net_fuzz.c
> @@ -81,6 +81,9 @@ static void virtio_net_fuzz_multi(QTestState *s,
>           /* Run the main loop */
>           qtest_clock_step(s, 100);
>           flush_events(s);
> +        if (!qtest_probe_child(s)) {
> +            return;
> +        }
>   
>           /* Wait on used descriptors */
>           if (check_used && !vqa.rx) {


