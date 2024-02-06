Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F16C4829C
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 17:35:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXPLa-0004cg-6o; Tue, 06 Feb 2024 12:35:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXPLX-0004cD-Ph
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 12:34:59 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXPLW-0008Du-6J
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 12:34:59 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-51142b5b76dso5165309e87.2
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 09:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707240896; x=1707845696; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yF8BpSrmRLYzUWuqO5QJUnOLMwmeiMm/c0Q7pcVzuSM=;
 b=gjgjA1KR2pWhjsNGar5zvcVLEr91mfBkqdaQbKQ8YN5g+GtBZJuwzEy0RC0GssMVC5
 3Mp7psoJ2DX9sAPaykgNdg8w78y9OEss4KfBB459JTICEtLsBOCeCJrBY4BDMfo+INxg
 GkjNZsN5whODvdoPQkKvpK1mgt9ETQ8sNjXoGcpsz2gxi55yOEikg9HziOBFiTL9+dFM
 dKTvprYAJbq8ebxZa3wtafffHkVqnnZ1fg1Br33VRXyxSbmmE8W4se17MfZdVir9t9Sa
 fHbenlkcJyH5PCO4TaatY43k8UKHHzU3aWKVDJ2+9vthibsZ0Nj+ozjGS35IhJDEgX2H
 9KbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707240896; x=1707845696;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yF8BpSrmRLYzUWuqO5QJUnOLMwmeiMm/c0Q7pcVzuSM=;
 b=BNL/NDpP8oosTcYc+bvgc4BcTbK28KciKkA//xWYf7mGHpUS3kqXBw/eWxNZEIl3A1
 2BMBoPN0r0G5MrksWLE6nbe0rmIFg/X2azWpFqpuEqAK/PAADQgk8L/71QB87ZcepWb9
 dNdrMK2CS57XkjEZ5lO5iVWtBCSbZ7uiB+ZlipJmaHxG8++WusO8WIHJAQJt++hPDVKX
 l8iwQY36sbMm/u1xmG6RJIkayABSMle8Ogbn6q0islj3h609PlJJ5KSJLsehj0bWhCZC
 3q9ofqKoX93u1o4LlQnJ4puXWFHI1KFZDLXGCozUn7CNBsqaVH+Fx+cWR/DyAagjpucO
 t+ng==
X-Gm-Message-State: AOJu0YzVm4r/PTqtRspCwrzu9zLU5RfbbPduuzaOH33shWtPG4jYn0wt
 9AnMqmCD0mHzUc4z9mgJlehUAzYbLhXTP7ji7RWEi6vr5vNbpSKemxN0/r8hIZKewsvjpOhXBqE
 jxESt60jN+uwaV9HwgT8BNWyKgehT7/r7PgF1Jw==
X-Google-Smtp-Source: AGHT+IF9owPu7uAyQx0EyweYbkcq99Br69ihN9Y2Cy4Xb/QeFXwbM1w7zP6+3wG58U/ry4ZIxKGOfARssFFay4LuSCI=
X-Received: by 2002:ac2:550c:0:b0:511:577a:3647 with SMTP id
 j12-20020ac2550c000000b00511577a3647mr2390653lfk.11.1707240896129; Tue, 06
 Feb 2024 09:34:56 -0800 (PST)
MIME-Version: 1.0
References: <20240206171231.396392-1-peter.maydell@linaro.org>
 <20240206171231.396392-3-peter.maydell@linaro.org>
In-Reply-To: <20240206171231.396392-3-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Feb 2024 17:34:45 +0000
Message-ID: <CAFEAcA-DuVwhihFp2cDyWGSPk=fFOX8ctL0iLufKxdUJWhf4aA@mail.gmail.com>
Subject: Re: [PATCH 2/2] tests/qtest/npcm7xx_emc-test: Connect all NICs to a
 backend
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: David Woodhouse <dwmw@amazon.co.uk>,
 Nabih Estefan <nabihestefan@google.com>, Hao Wu <wuhaotsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 6 Feb 2024 at 17:12, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Currently QEMU will warn if there is a NIC on the board that
> is not connected to a backend. By default the '-nic user' will
> get used for all NICs, but if you manually connect a specific
> NIC to a specific backend, then the other NICs on the board
> have no backend and will be warned about:
>
> qemu-system-arm: warning: nic npcm7xx-emc.1 has no peer
> qemu-system-arm: warning: nic npcm-gmac.0 has no peer
> qemu-system-arm: warning: nic npcm-gmac.1 has no peer
>
> So suppress those warnings by manually connecting every NIC
> on the board to some backend.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  tests/qtest/npcm7xx_emc-test.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tests/qtest/npcm7xx_emc-test.c b/tests/qtest/npcm7xx_emc-test.c
> index f7646fae2c9..63f6cadb5cc 100644
> --- a/tests/qtest/npcm7xx_emc-test.c
> +++ b/tests/qtest/npcm7xx_emc-test.c
> @@ -228,7 +228,10 @@ static int *packet_test_init(int module_num, GString *cmd_line)
>       * KISS and use -nic. The driver accepts 'emc0' and 'emc1' as aliases
>       * in the 'model' field to specify the device to match.
>       */

Whoops, made the classic "create patch without having saved in
the editor" mistake. I meant to also include this change to
the comment:

     /*
      * KISS and use -nic. The driver accepts 'emc0' and 'emc1' as aliases
      * in the 'model' field to specify the device to match.
+     * We wire up the other NICs on the board to the 'user' backend
+     * purely to suppress the "warning: nic npcm7xx-emc.1 has no peer"
+     * etc warnings that otherwise are currently produced.
      */


> -    g_string_append_printf(cmd_line, " -nic socket,fd=%d,model=emc%d ",
> +    g_string_append_printf(cmd_line, " -nic socket,fd=%d,model=emc%d "
> +                           "-nic user,model=npcm7xx-emc "
> +                           "-nic user,model=npcm-gmac "
> +                           "-nic user,model=npcm-gmac",
>                             test_sockets[1], module_num);
>
>      g_test_queue_destroy(packet_test_clear, test_sockets);
> --
> 2.34.1
>

thanks
-- PMM

