Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07299C2A09B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 13:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsKJe-0000vp-3n; Fri, 07 Aug 2026 09:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wsKJT-0000vG-10
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 09:08:40 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wsKJQ-0003qz-UC
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 09:08:38 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-8228ed0081fso20109197b3.2
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 06:08:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786108115; cv=none;
 d=google.com; s=arc-20260327;
 b=qNM0H5V36SXISuAezgbIVmwwc2Ef6zf79VhkdXysp8M9FGLp+tV7dr0jO20AMJd8FP
 fFlkgBrRvgox/pgQf5W4ZhUggS6EqOQXqxjYgmzviSpNZzTf2pQPStUyj6q7cFFul0WS
 FgLDHh+Usjg4ZgsPf937dZ5iarWrXKBnIFC1wY/7SDwMADX5sypGQIKh74DIpI4oxCi1
 ADCdKnC79mlKz6vF62dWmtBVmAUslmTtFnlZhtKsor4wcmjrpCbTnt69F0MNM36PI3Ot
 fcrtPCP7gF8hcNlFdpXPc3er764Eo6a2SW8ucapMk0oBlMA1VpGv4VkMMNUQZruxSQj7
 zjlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZC1bpTzGtDOlOCPyTg9Zro82V4hMLSqK1OP0MQnP+8w=;
 fh=Byz0PHcDpfUh6gDZ2nqrGipMtb/BdgMohHzpZf8pAAM=;
 b=lFOuH9aih4BEe5vncP3+fcMHnQDTk39LV77/M3atbgOY5JEI6TThjw4SJ0+RHvsyJg
 9rF9UWaZ6ZLEDopjBgOZMorjvKW9rECxqXnTUVmEhXIo2OfbvrQgEg0h1DNQUHeoTfeR
 ha+Ti5KRRVJ1hUj3eV2jJ0JAqH5m+GqO4QmHcDl8ZjvpIXXwpoLxXVa5SQXxMFBEYY7O
 RMyX0MxBElpPCWNKZ2JBH47uJawLDyiS3awIPYmR3uf6WdykpMimZHLvM0ra/PBKg/Qa
 AirHYLfAth4WMFkbxpV8XDp1Yu0HzJW8poJ7uhCCdCM3QaiigQcP7Ee6Wv9cbRkvQm9v
 uZeQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786108115; x=1786712915; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZC1bpTzGtDOlOCPyTg9Zro82V4hMLSqK1OP0MQnP+8w=;
 b=RQD/ILfpXcG8KQpB8NlUnf9IYVQXcmZyW0bS25cJK/EioxBjsKb4gccBlggChZTT2P
 EN4M1twY4O/OTuSrhFYvEIA2ZSojrOZ0Bn/b9XtVuh2XrLylBqAiCcR8opR9r7t8jaHf
 qQBCEtE/2WTq/ApXfrkCI8oJ967aefMXwXEQ18ISCQNLjs2VPqZK9ptuUyNwXP7H4IKz
 KwmEJr5fsnMnfO88MGjaNn677coSH8EB7nAzXm/ADbb3F42r1wi6ys1EOTiNbs+ATxAM
 YgyQOcWZkkyF52G4a8YXiGPIzuVWZsXMyCmD521mzimyRPjfzTaXMZ6D6F+rtJ58X4sg
 pxvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786108115; x=1786712915;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZC1bpTzGtDOlOCPyTg9Zro82V4hMLSqK1OP0MQnP+8w=;
 b=pg0+pxyStEE9tufC1w3NJYSV7PVfJ0VtQQmt1FxXlkpWe2NTH27dGQN5dMQEGo1Qve
 jNyFzGyOrfONvvfumn0j4+qw7JTT23ux78ohwwUQAntl7/uOK9i3uA8U29p6MLx7dG8A
 p/7Tldy8KZw00P2z1D8C7PY9AEQ1UsWsEuuApOPO3nrnqJ71UAz6Qqfz/ajm4WjUyFxJ
 C/YQ7feRs2Vqr3lvbSCr5jy/Ohzid7WHmjI1zlhydedLju2u2FE02OxNvl3+uMdkr1H9
 hmjGNVJdy6lFxlvR5+dhuMMJX7kjmzijN2A9nqqmOxjxmgIlNwLNrI74MrcQ6vbEignf
 UymA==
X-Gm-Message-State: AOJu0Ywbd0mpHbup67dzHG2acJrlkqBhmZYesEvLtvcKSAWDNPQeOIs7
 N4EngSyqRhVancESZ7yEEVuETXEpvMxU2d+pL8ZVBg4aYS1OXzMIizhvTQnG/gCRM5e+GELgBGL
 86e4hu6ulNEr8Se0LKENpfQTFaU3MJmuuRJw1hNT5ug==
X-Gm-Gg: AR+sD10ZRQcHwc8MxWkcccp6nmp6AYgm+C0NioV7eeaHT/BI9h4mpWwu7g0cY5zq7+2
 Ws7hpqghoAMewYL7uvDdVuM/zumbrf7ZGZ26TwmwwtxPABq2k91bESMFgJvMpEp+ke4eP2U0mFU
 2VXnxpBikAGb7MpgN++EM2zqPaDnm7646tygncPNfpR58NZoduqnoWrqr8uhdWGzbL9LOVZw7Fw
 u3bnlWJBrlXd3UB1UHzrVwlhIBB4o6h1epI0Gf4TS/4kku+xjh0u2ikQU8btsOkvin9jS8jieuW
 Dnl+wWJSFiNBxNoEQ5Jjvq7WRPyv6URoMBeCFkM3wuHY5L4RQwhuDtzg/sYZI5pY7DXZzHJjWad
 crfwlF30zE4lTivPBcFo3Rs7rtBBy
X-Received: by 2002:a05:690c:9b0c:b0:824:a7ec:e33b with SMTP id
 00721157ae682-82579bb0611mr1226627b3.34.1786108115263; Fri, 07 Aug 2026
 06:08:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260803041808.58174-1-guobin@linux.alibaba.com>
In-Reply-To: <20260803041808.58174-1-guobin@linux.alibaba.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Aug 2026 14:08:24 +0100
X-Gm-Features: AUfX_mwRzQV065_6Rnf5Wuh958xPpZHtclr84h7SwcG6EZ1XiWjyuBymXfepm8M
Message-ID: <CAFEAcA-P6RH7nJK0KQ1H8576ULFA7nocB0EkhhZf6Rw3g0WCag@mail.gmail.com>
Subject: Re: [PATCH] hw/block/pflash_cfi01: Restore ROMD mode after migration
To: Bin Guo <guobin@linux.alibaba.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, 3 Aug 2026 at 05:19, Bin Guo <guobin@linux.alibaba.com> wrote:
>
> pflash_post_load() did not restore the ROMD mode of the memory region.
> Although cmd and wcycle are migrated, the destination retains the
> default ROMD = true from realize.  When the source was in a non-array
> mode (e.g. ID read, cmd = 0x90), reads on the destination bypass
> pflash_read() via the ROM fast path and return raw storage bytes
> instead of the command-specific response.
>
> Derive ROMD from the migrated cmd/wcycle in pflash_post_load.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4042
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> ---
>  hw/block/pflash_cfi01.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index 5b9ddb20b1..a13b91967e 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -1030,6 +1030,16 @@ static int pflash_post_load(void *opaque, int version_id)
>  {
>      PFlashCFI01 *pfl = opaque;
>
> +    /*
> +     * ROMD mode is not in the VMState; derive it from the migrated
> +     * cmd and wcycle.  Only (wcycle == 0, cmd == 0x00) is read-array.
> +     */
> +    if (pfl->wcycle == 0 && pfl->cmd == 0x00) {
> +        memory_region_rom_device_set_romd(&pfl->mem, true);
> +    } else {
> +        memory_region_rom_device_set_romd(&pfl->mem, false);
> +    }

Confirming that this is correct is a bit tricky. It relies on:
 * when we set romd mode to true we also set wcycle = 0, cmd = 0
   (which we do, in reset and in the mode_read_array code)
 * when we set romd mode to false at the top of pflash_write(),
   all paths out of that function either go through the mode_read_array
   path, or else update pfl->cmd to something non-zero
 * nowhere outside pflash_write() udpates cmd or wcycle except
   for the "clear them to 0 and set romd mode" places

This is almost but not quite true. In pflash_read(), the default
case for the pfl->cmd switch sets wcycle = 0 cmd = 0 but doesn't
change the romd state. Luckily the "this should never happen"
comment is true -- there's no way to get a pfl->cmd that falls
into the default (except for being deliberately fed a bogus value
via inbound migration).

It might be worth having that pflash_read() code also set the
romd mode when it clears wcycle and cmd, to make the invariant
more clearly preserved.

But this patch is correct, so:

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

