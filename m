Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D40AACD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 08:46:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZPQV-0006lq-Lj; Tue, 16 Jun 2026 04:45:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZPQS-0006lD-12
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 04:45:40 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZPQP-0007pB-5s
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 04:45:39 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-66067da0638so2208970d50.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 01:45:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781599534; cv=none;
 d=google.com; s=arc-20240605;
 b=YnY9fYdMWHABPPGPMRy/r0dMKAAlB4a86HHeNkV6g3JwEwTXp8NgIssd3GxPa0gJ8S
 G7OherryL8fG8DBb7w8RZ0IEtcwDFraigvo2Kg1EZom3kJwCxGB97EOMIZady6ESElH9
 2VriUV6narkUuQXXzD7TPmyQfduRtG0Bz4hgMkzyxwUdCHWwb6yAQYyzQmkirqAOe+65
 1l1ZelmLoueb3eZjeE9887dkoIrOXuX0lQtnUGIE17gyA36RBxl6DzyeSG0uAmWJLOQm
 OdIMZVNJPo1LxOuEyb325tNmYnTIZVvFtHix7F+HSJ6Joh2X1rPOn6pODcc5m3svusS2
 vG5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hLs5067oWnPkMIcP3oQvJ6cEIENiZFuK3UVjpv4V1r8=;
 fh=UioiJRd4SEsAyNfI6hUTMaKH/0U5VpW7uFx7kzf5Y5I=;
 b=kHyMdT8bPwS2v3gdInbZhJd2EMhRex7E54E0kbRSGgflF43FcBAJlXqDDMeKZ4ahUq
 4rKCmYyfuEvZRzrJpCYlQESgB0MVhtNhLfZCblqy+I6NNVNulNfuQbdT7O0HbrWBU2Mf
 5K9Mw5PluyW/wCUh4XgPCHTvjM/MRzKwR/HWSnpmDhq9M0OMP8VTk6icqMf8BMok16Pu
 AJ/LBO5Mze2J7p2pUP4CiLGMxFrRNXE4AmFT3SByyiplFR7oUyW4fC46sZRL53oRrGHj
 b6QkLAWV40gbvk3bRPldC2nTLpgFdKbgFnGQieS0K3PPW0PIZ4DUoBCMD8KQ4zsSH4uo
 Lk0w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781599534; x=1782204334; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hLs5067oWnPkMIcP3oQvJ6cEIENiZFuK3UVjpv4V1r8=;
 b=F36GYyDILQme3FZMCsyfvVdqu+awyEWNcgJ2nU3KEZXdYCAHHga+RiHQG+Wep5Hfa3
 kzdUyNT+dkl49B5+dqaVtdPsCRdygWSXiAWnYoa4JMQ8hMPthMWfJ+Hsz+DjXfDmpqaA
 pANGVIQkDWyg73ugj3Uv/T9Zsk97ZpgHzc0kSS28V3KS2+0sjIocaIJi8mQ2lOucA6ZE
 9WlkW1xSQV2dgptzgFTbtEWz0FpGplOhwDlbUu4WxPjod4MPWbJ6ZKgX3wqlB/DEt+5R
 vBRmj3jU1uaducXw3PEqW16TUAnzUh84hvMd9ncUCDz427WIW4FB0bWE7+1snHRCZnBE
 XfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781599534; x=1782204334;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hLs5067oWnPkMIcP3oQvJ6cEIENiZFuK3UVjpv4V1r8=;
 b=sx+eKRvF4vS2YwB0J2anHJYpNDLWkc3vklmT7/k5h61qgHSwstr7Go3fIpBUnR4Kbj
 wfxMExmnbOMhnD1kcKgspsl9MnydAlMttHA2EFbpAuN9DVb2IoxoUpX2fcLpyNu2BRtl
 dyebl3Z5xKMTXQY0yX/WC+Ks0qID+swdUwE7KlpNpRfa2bg4lx1xMXHF1BhytbGoFhFN
 JvTxXtpgpwoDTc9Cxju/Dw+pt1BIlVl9lNqNjeObL5d423j5zRE2+X9NH95gLeCEwzWd
 OyQr50r064sMRAj2Z2oSWFdKlM6Z9G1PnGO0pOhIte7cgIhdQP5mQ48oWWbkfZjHX4tU
 kiBQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+HUIV0uj37P/BEwlJpeosekXgAyguNJginLwm7RNNLFCdxPkqtCtExBPq8TWQHeHMC/1kspm+7YWlr@nongnu.org
X-Gm-Message-State: AOJu0YyIRvQDCAOEENMebCK+FsAzVR2wgXj5PU9JgkLESoFKpsr68YFs
 mfDIXRF9gvZ503JeVN1uv5h72zJeOWl/E5QbpX9zjdCX8Z+a2TxzRkXBxkORN6GyVkiSaF4aT1B
 4qb83WtagfBvWWDTNJAVshZgLKWMsBwpzupUnIRf55A==
X-Gm-Gg: Acq92OEuXNRL0qFi0jscI+mXfSsQT1ZJkla+J2owhiMRVS/BhfojRcNtT9z4yzxdMpE
 NGUaarviFxz8egQHvdDEx4Gyy7CEoKpHtdKwwCoYjjVyUN36ARy58vBqSErxU0Gl3d6uDi0trxR
 8gKQlanAUwaF2Lt8D2tLQoOYZL3MKqfjXhX0vFR/T4xRSsBrDT7B5dVNj5b2NNDCvXYbiAsjmQ7
 /GyhQzI9zpE2XE2lR1h72hRQdINo5ob3jzAC7cDJzLC5s914XRLJFTi+djBscqDwYqSXEcy6aiz
 lV+rcbJEzfpudN44Of7fLV3q5tcqhiFGQxpjTUXW0tGKvKPzHgQBcM9hVoWx5B9wPbT95oAwxmL
 v/Q==
X-Received: by 2002:a05:690e:1507:b0:65c:477a:2ad7 with SMTP id
 956f58d0204a3-66284faf621mr11453987d50.25.1781599534140; Tue, 16 Jun 2026
 01:45:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260605034729.2874861-1-kylefoxaustin.github@gmail.com>
 <CAFEAcA_=2j+jHuqcCF0S9X=4q3dhY8=EKJuGCkuuUSG1jaO0bQ@mail.gmail.com>
 <CANqqvPeUAHNpw5_h=Lq4ts=W6sE49occngXga+o=Yezem0dr3g@mail.gmail.com>
In-Reply-To: <CANqqvPeUAHNpw5_h=Lq4ts=W6sE49occngXga+o=Yezem0dr3g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2026 09:45:21 +0100
X-Gm-Features: AVVi8CdQ61AByWKvvb7CGxL_maMOV9RrSpESmG2SL2JdfW-yU4LdS628497gfu8
Message-ID: <CAFEAcA8Q5=Ya3BhmhvpPGjs69KDH_H+9ZxD3q2fACMhuX-f1BQ@mail.gmail.com>
Subject: Re: [PATCH] target/arm: align down misaligned PMSAv7 MPU region base
 instead of dropping it
To: kylefoxaustin <kylefoxaustin.github@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Sat, 13 Jun 2026 at 06:22, kylefoxaustin
<kylefoxaustin.github@gmail.com> wrote:
>
> Hi Peter,
> yeah sorry for sending this in.   Based on your feedback I went a bit deeper
> and realized what you pointed out: I was chasing a software bug that
> exists in the guest and QEMU shouldn't emulate one particular
> implementation's choice as if it were architectural.
>
> It is based on NXP's proprietary M7 sdk firmware which I can't modify.
> Plan is to clearly document local workaround and see if I can
> later convince NXP to fix it on their end.

Thanks. As this isn't a particularly difficult or weird behaviour
to implement, I'm not 100% opposed to making QEMU do it, but
generally for this kind of thing I would want to see that more
than one piece of guest software was assuming this particular
UNPREDICTABLE case before we change QEMU.

-- PMM

