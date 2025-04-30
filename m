Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC4BC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 11:36:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA5jq-0003Cy-4C; Wed, 30 Apr 2025 07:36:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1uA5jj-0003C3-VF; Wed, 30 Apr 2025 07:36:24 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1uA5jh-0002zQ-9f; Wed, 30 Apr 2025 07:36:23 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ac2af2f15d1so897398666b.1; 
 Wed, 30 Apr 2025 04:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1746012979; x=1746617779; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=U5LZ4IdMUrGAbmNWxjJYELXAVSH7/QfIsGDyAraRwQw=;
 b=Pf0NxVX52BPw19D2xDecMATTMyjrJ74Dp0EEFVroaWfEUol+tplBuEbHbKZyk+LPQB
 OsTOBNYbOaPWJ2tXtzTzLdSbxEs9NNkjFpMdhV+ux4uEYarFFqgK0sjok7qhVbTzJ8Ku
 cO1Waq7GE/t5UzLng+5itGeSn6HKsOpK13BC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746012979; x=1746617779;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U5LZ4IdMUrGAbmNWxjJYELXAVSH7/QfIsGDyAraRwQw=;
 b=CAdAx2wX4dLoXPJtD7SNCYjMJPvSQTltcuLcL5VDwuIJM4K0e1IDa/PQ8LdaehHG6C
 L4JQauPqHJSzX+7glg79JNhEeaFWiDMDAq+8pJ34y8PG5/hHwnfBgPGzlAmm/L1Ofc1w
 lmJRPA/F/uZ/eQ/4hNMC5N2CTS5igrohKSpiPQKcCmAov7KzLtKPnroKnjc3HAqo2Mnu
 QyoNesD6kn3L6eifl4onSUmdnJvnkbeJ66wY8IEw/IOY+/zsX/04qoLQaZHB/kj1LH81
 ZPD4rmx7L87IQtTlrqYpvVFOJxgfx2jItvM7qUgEo/Z05vEYR/TwzgHOsVAmhYssa6VI
 6EEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/VeaRzeaR/ExYYsSYrw6DRzEn6UTTPa8jaOz5icDJ0Q0MEZ54uTuGWl7LGapyY6tUi9j7gAM/8V00@nongnu.org
X-Gm-Message-State: AOJu0Yys8SzgL/GBNCSt0ljj+LQHxSBLHXs0ij6xplSzvXNxDVmqtjRc
 bPSkYQpY6FRtTKOPxDH5xtMsmQxT0PtaFnofmFMZwBbpG28Z8xXcRBZVj9CECrIPg8wWCbYyO3N
 NdTWsfJulttdMlSiSSeNt6qVsC08=
X-Gm-Gg: ASbGnctnS9LhsjbvOK/k5K2J0K32VjR5QO19sYtCNOPjwT0xbdKNvKeMw3R1LpbXOM9
 yO0IV2LNExhjhzuR6mKuMWtuNyVlMNKsRtJfNNNvM4gwcRc+JkBatExfbkr9nwqGX6vSzuGKD4p
 BvAluRI1govzIpvcqxIWtf3A==
X-Google-Smtp-Source: AGHT+IExfhm2Wx1Et4p4EzwmKhzcRT+wLhE9Iu+jqKbZP+Ivr41eNp4WkHlmLiKolnHPvnddA8KExf8T1gn/Jm11b50=
X-Received: by 2002:a17:907:78b:b0:aca:b72b:4576 with SMTP id
 a640c23a62f3a-acedc62100dmr334111266b.33.1746012978603; Wed, 30 Apr 2025
 04:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250429061223.1457166-1-joel@jms.id.au>
 <20250429061223.1457166-3-joel@jms.id.au>
 <c93ffa82-8ed6-4a1e-ad1a-9d4fc8940165@ventanamicro.com>
In-Reply-To: <c93ffa82-8ed6-4a1e-ad1a-9d4fc8940165@ventanamicro.com>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 30 Apr 2025 21:06:04 +0930
X-Gm-Features: ATxdqUFFq7MM39YiS0O6e6A-uWahlTlHmcIw_i9ao_flHDDdghLBBfCG4ozPp1k
Message-ID: <CACPK8XdNyahg9z27uVQvAJ+czM6Vup+tuEWgybumiA7smCWw0A@mail.gmail.com>
Subject: Re: [PATCH 01/13] riscv/virt: Fix address type in
 create_fdt_socket_clint
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, 29 Apr 2025 at 21:56, Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
>
>
> On 4/29/25 3:12 AM, Joel Stanley wrote:
> > The address is a hardware address, so use hwaddr for consistency with
> > the rest of the machine.
> >
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > ---
>
> I believe you have 2 patches #1 in this series:
>
> [PATCH 01/13] hw/riscv/virt: Fix clint base address type
> [PATCH 01/13] riscv/virt: Fix address type in create_fdt_socket_clint
>
> You probably renamed the commit subject to "hw/riscv/virt" and forgot to remove
> the generated patch, since both patches do the same changes.
>
> I believe we can ignore this patch and stick withe the first #1. Thanks,

Guilty! Thanks for the close review.

You're correct, the first one is the correct one. I pushed a branch
here if it helps:

 https://gitlab.com/shenki/qemu/-/tree/riscv-dt-props-v1

