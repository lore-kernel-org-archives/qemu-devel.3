Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA4BCDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 10:19:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbbjv-00018R-V5; Mon, 22 Jun 2026 06:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wbbjt-00017t-Ea
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 06:18:49 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wbbjr-0007ZW-QX
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 06:18:49 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-6626cd98209so3602026d50.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 03:18:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782123526; cv=none;
 d=google.com; s=arc-20240605;
 b=LuyOsXVKCEEA2Lw7OY9pfqK34XUiZJMmPyRFNefW60oD6BZcT41lb2Y2c1etMuPJDe
 b0r58SGHViZ/4Zhtdnc6yYbDbJ/IwPy+LwBArdOMYU1Fd5uOZTAxvMnQdAyiqb/Y8SsC
 wbbUs4n3eudFippYu/0yydcW+wwVgq/3YNDGM10OrG0dtE4L3IfltWrdXKUMXxnJJd0Y
 NSez0fb+kHaHEZ3wsAIwJ+8xWHkTNDXkdYkwdS581sMEvOzITJBMkgJIvkokmwRqQ+yD
 Vsu+JmcWLA3OSNJgJyE4crc8rFNbjf158oncpHhtTIP83ejOUk1RSO7th+93LPW2go5W
 IYIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=B0Y+v+d6Wbeo6e4sE3jvGSH9/P4Ci+unxrfGdhbru4w=;
 fh=Rqj0BkhYVitrTp0C4VYnwdrjvLJ1P7MFwU8PrOExr5w=;
 b=IyYyoiToiNkThjZChUiYiT85WWGlqDWQokkQfm+K5BcN9Hy8xOM269zvbO80OV6wtw
 0wpPqj6jhiTEg6MmxnQunKzeHLIdjG7pnrPtYB7LJnwfXTOiP4ZqXK0OM45VpGugZnm5
 inzzd561xGCKMWo1ILRMvae85GRgVxNGWllxVT6SfJTQNemcyFPZTwbyEDJEqXUNJ71l
 3yAgrWnfSLGvsetJoyXmvxWE7I6fkDVRx+osTxLzHLyBeau4rHGqJfdkjVfEKtqurBSA
 HpMYKpNKgu+d6RbeeutCVZUqggxVE0fRRifhY4sX/6+1JwM23exH5e478b38o1HXatiQ
 d2oQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782123526; x=1782728326; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=B0Y+v+d6Wbeo6e4sE3jvGSH9/P4Ci+unxrfGdhbru4w=;
 b=h6STuFLl5BG24AKIPoQNogRwvSZ8HL2owld6PtB2fPfPd500Mt5LOV2aiyqRifx0kZ
 fmsuUJoKGU8vWQiVlNENmmgV+JaDOYicu6f9mq+4sHt9eOMmY/9ZdYcxm2XKccRuYD37
 W1es6GfebPPGvqzrXja+XHbU5+AdjQYWPiteuBByHhBKIWjFFZ0G/VifYT4bsQ6AP6lJ
 r8Py/wZ978111+PhfOJ+6+LlZxOHZbEGa5qDX5Rcs2y25JS48NsCn66kNfGxooCP37O/
 jKRTXmw28FBCI6gZiWK5Mo9rWvqNrgcPL7eJknmUPs6GhLjGwIR8AQbCWaOAbst0VF3i
 Lzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782123526; x=1782728326;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B0Y+v+d6Wbeo6e4sE3jvGSH9/P4Ci+unxrfGdhbru4w=;
 b=q4vi9mxtvow6MReaDAXaOAPMeqmDaElX/8pKKTjTryL7v6fyikUR6eWIeP1/39pgAN
 e9Ivx8LY7d7JhQX05x8ux7v9mn4iQ1pxYPjOvvOyC+hy6M7X9IXcfkT3brMwDq4Z2cao
 2hjRCCMEce5k9OTJ4/A+z5zMPNzaqprrBZlKSkH68+VzuW9xF9QsWADGs5LYsvYuhCmh
 VkfBVAoe74RnR4qHpbAlGIvxoUOh88nfcMUTDsFoPcydglU4j1S+mv08NEl2xpAqe3Ot
 WxuSzJdnIbVA5zQxdRkFnr1GQYOlVu9WoJ7c/ZDGHiWGTvcoaskGH9OT6Scc1WBeczh5
 BT4g==
X-Gm-Message-State: AOJu0Yz3Cdvy3J39LZ8aGOOu7SEQaKzfulMIUFfIgxhfldjR1PfRKzc7
 1V1hYu79cexmi48gUVCkpSyqNlM+kI3iMmvIyk503rL+HZbAboqioBMiuDUb7dOdviXwEKG2H5K
 JhC0bse4MbgYr2vSafAaTmkQ5i4+N6DPtKCigWSOcog==
X-Gm-Gg: AfdE7cl9Hh6pyIMTHMsS8CZ5gI5FnH2uz9m9PcIl437KW2blXKRvqDz36LpYoILCc/K
 7+eEqrdMVyNIJ8m1KAfd/P12QlKiKp71fXP2hCWqA4RAPZoH5H5QYaUEEQtG09wInsGLBu8fmwZ
 3c0X35wFrwPgBPDVtwWmvPXtQGzi/BXfQsCHS7x/HRmKMQG18opFr/lgSW2GRTixI557Eoo3Gdf
 FL/BUMD81OYcvyQOlVmP6ufu4N3gcznQyDyF8RnTe0yzpV1P4jE6LK+nMq2hyfEZL4SwAJ+QpiG
 cbPQLHTVfgsY+1ljKB/X2wGzdR6Q3EaKlbUCYp6x/9wvN1g1YSsgy/gY
X-Received: by 2002:a05:690e:488c:10b0:662:f28b:7c6b with SMTP id
 956f58d0204a3-662ffea96e9mr8253701d50.62.1782123526167; Mon, 22 Jun 2026
 03:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260614222131.5795-1-imaginos32@gmail.com>
In-Reply-To: <20260614222131.5795-1-imaginos32@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jun 2026 11:18:33 +0100
X-Gm-Features: AVVi8CfVzsIwfHqz8sQwNEfORvuodRiTIQbxY3HZMY8vwi3bzlk-JUGm1Byf784
Message-ID: <CAFEAcA-GGP6aALn4Az5By31q1R3d75Mm+p_YXN0y=tO3GxDYrg@mail.gmail.com>
Subject: Re: [PATCH] hw/i2c: pmbus: NUL-terminate strings received via block
 write
To: imaginos <imaginos32@gmail.com>
Cc: qemu-devel@nongnu.org, Titus Rwantare <titusr@google.com>, 
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Sun, 14 Jun 2026 at 23:22, imaginos <imaginos32@gmail.com> wrote:
>
> The PMBus string registers (e.g. MFR_MODEL on the ADM1266) are writable
> by the guest. pmbus_receive_block() can fill the destination field
> completely, leaving no NUL terminator. When the value is later read back,
> pmbus_send_string() calls strlen() on it, which reads past the end of the
> array and returns a length that trips
>
>     g_assert(len + pmdev->out_buf_len < SMBUS_DATA_MAX_LEN);
>
> aborting QEMU. This is guest-triggerable.
>
> Add pmbus_receive_string(), the write-side mirror of pmbus_send_string(),
> which reserves the last byte of the destination so the stored value is
> always NUL-terminated, and use it for the ADM1266 MFR string registers.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3388
> Signed-off-by: imaginos <imaginos32@gmail.com>

Thanks for looking at this. Notably, the bug report in #3388 makes
a completely incorrect claim about what its repro case is actually
doing. The repro case does the "write 32 bytes to trash the NUL
terminator, then try to read back", which is what this patch addresses.

I'll let the pmbus maintainers review the patch from a technical
point of view.

-- PMM

