Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45312CD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 14:59:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKHEX-0001QA-Cd; Tue, 05 May 2026 10:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKHED-0001KP-JW
 for qemu-devel@nongnu.org; Tue, 05 May 2026 10:58:36 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKHE7-000479-Uc
 for qemu-devel@nongnu.org; Tue, 05 May 2026 10:58:28 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-65c396d3b36so3548631d50.0
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 07:58:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777993101; cv=none;
 d=google.com; s=arc-20240605;
 b=ihcPhCrp402IxL1iDoz5MROyBCRAiIBm73n6ut6I6OB0WMWioCLVP9HXfrm73Ny8Ig
 Wc5oIzpoAvfDXoTnAMQ1MKLfwzNO15KxIODjYO/yMve/Wzuyzn5yXD9m8fef5906lp6i
 vBBBvZT6CNx/tUZlS3OMo3wo7M5W1YybWoVUtpZQp600PFvjbdlgu4A59hg+/lIywMYR
 23J3EuauPndMK3i1uNa8AEQK5KoWUA0pLJ1yw0ViJfaNi4ujoBipRwisMGeb2y58GDyp
 F0gLiXkBWbj2Gazg3nXw49OsUYyB8xofgZ6gFclB/hvWYLNBgzeGFACIRqNHVe+HHYvw
 hxGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rNzsOHwukFP9Klru5SwEhYlCs7rmLk1wL9R/sX4SOT8=;
 fh=Ooov+i9AeS1BcC1vonK1zlp0+cy8hPMIIb5HY6/nc/g=;
 b=XPk8jQ9tlr3LnPpZOMtEmVVBcmuOxKNlZ33gDFxvV4zH+mMO6R4Ev9te6k6z5xpTZJ
 EoST2I75IJgTVRft92RkXohCS6JXbelKNkDcJ1TQ2IlagRXQfB0cjMsfeHUtOnfSS+ho
 2HbaTJMQPcWQGs+g/8jWLrTDlDZ90yguGq4dTaGHfFNOVtg1yx1jrqzsw+LqsmbLPzMQ
 sPwHUabh3iswyEJzxfkwVMwLT9Bsl+Or9Ntoc7Vpvxz8ZPmLOEErzLbvPR6B2Un7JPmE
 nbbJYrTJteLEbLF3J9a0a6gddqF+uegXzc7NtJXT2Np+yqo0AHP45mWkaK1CyFKyArxr
 hJBw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777993101; x=1778597901; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rNzsOHwukFP9Klru5SwEhYlCs7rmLk1wL9R/sX4SOT8=;
 b=OrAzl+3EFOKAq89zZkv61fKXDe9NveYdV47AQKUMgIq1WXLsErLlrll5891kCxeJ0H
 TVP3FXqoiWecDpLldzhyt/iQHw+/2rC9/0ORTKfdbZHO5dwZnkhi+R3m9bRrnwvvBLry
 msS3T6mumbXgX18IFf+Kso9RKNaZqC0Ms7OVTzn4M1mnKwDDKLzHv//2aIt6RnV+geB9
 OuOmAif8E/Zy/GZXqKCYiGhuXOOK2tvRyKdT6LP9gNJ+POO4JgrBB7tAruOQr0gddPCC
 CTM5ldh/X6HysdPKsyKwG9IKzjJCr+0ZR+iGuNbnE8bQ7efSM+8lOA6RaL4cjjSyiebb
 vZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777993101; x=1778597901;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rNzsOHwukFP9Klru5SwEhYlCs7rmLk1wL9R/sX4SOT8=;
 b=JOrDBXE70a3SYiXkmnxEXkeJE8gv+507M8vOq3BtTgF8HjNcQ1nwd6NO0xIh8NAn7C
 A3VEApg9ng4kyNxItEoSLmuycC7Svn/pobWkAgRI4rn3IJuJbBkN8oWiRfGXEawZBEUi
 M+pzbms9u1AS0UCbNC9ohQIMZBusWbD6k0jI1sMliQnWtX5+bYcIJsVFfnTUdAx4xMG1
 sKl/8gi0pomKHFwcfetk7M4ebci0zrMXjuVQ5tT3gkpwOmeX6/Hua1RavyzDPKkQyDBW
 kOus42+NTsESrK2xYF9nXUfimbrfgGyI9Wxuphg/GAUqnlJomiYx+c8hYvJVvPncaD1w
 ylMA==
X-Gm-Message-State: AOJu0YxuRLqf8oC5dVdpLvOoRHpPSb65b1l36PJ7M8lGyGhEsjtMy7AS
 jXhjnGkZCNpqDu0XCbU3MQB82KqGjkHwaIHwJ2cR4u+BsrA5mplsq7dJRt/1wkAYv8al/VU1NiB
 kjOSgqaSkdbIgXrpXYm3LNybyqR9heRORn5xJnS6YLQ==
X-Gm-Gg: AeBDieunOyrj4ZIux1PJtHT/DS5AmYPGavaJglOO2jWoVV3ZOVwWAkM08TS2w9QzoYp
 oIsd9hs8Z4ANZ5Ug4keGbu8bqYDN+UPY3XurgXbytKB32QAHSjz4XqVFaYUYzrMeJVmZiENFDQg
 C9VOgQX0Pd/t641/O8be6ocE3bTLKVERG2thoQC1qYZ/qzPtuIznP9gpKcgT0XCYh5jO4+f6z+c
 2PGQlNcHIKRtN5wiuU/FEYI3LKpknoaI5WiWDN57oQy0+x3wU3lc1LcjNcJWpNscP89gAFDpFZ4
 qM7d2GBYAsFq84p2jyZYArd9Jaix78jUePaWjIz1Ncetimxrmhk1JkFWW7b2VbiJaFl6lqeTsUZ
 roQ==
X-Received: by 2002:a53:d0d1:0:b0:650:2257:e085 with SMTP id
 956f58d0204a3-65c69ed055fmr2765124d50.30.1777993101225; Tue, 05 May 2026
 07:58:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260501231353.63184-1-mohamed@unpredictable.fr>
In-Reply-To: <20260501231353.63184-1-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 May 2026 15:58:08 +0100
X-Gm-Features: AVHnY4J0kvIwZxi4pjf5VtQKVktAeLFZS329s6lNkKZtm9teJkrJH4B8IHKZ8Q4
Message-ID: <CAFEAcA-xJcSq8XcWeZh3SnOjbWiZ8G4RQ+MyE_jGhJa1k5kvfQ@mail.gmail.com>
Subject: Re: [PATCH] hvf: arm: override HV_SYS_REG_MDCR_EL2
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sat, 2 May 2026 at 00:13, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
> In older SDKs, MDCR_EL2 was defined incorrectly.
>
> As such, override it with a #define if compiling with an older macOS
> SDK.
>
> This is a workaround because the macOS CI setup we currently rely on
> has not been kept up to date, to be able to land nested virtualization
> support.
>
> Once CI is updated, the SME stubs can be removed and this
> commit can be reverted.
>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

I put this patch into my v2 pullreq; hopefully it will get through
the CI gauntlet this time :-)

-- PMM

