Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F222AEE57F8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 12:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sojBf-0001qb-4r; Thu, 12 Sep 2024 08:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sojBd-0001l0-J8
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 08:44:37 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sojBb-0001n4-PV
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 08:44:37 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-374d29ad8a7so756412f8f.2
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 05:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726145073; x=1726749873; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HqriCKUEWeKgEXArwVf2e03/WsK4aafWukqhg5BtCUo=;
 b=Zq9rVYKDG3aeJTIbIt/bWNTSYdXdJ71il4vVh/wKbd/KBxL4+sjl7xC7y8PurdS3yC
 syC1cjOd5a7A5IQmMG2LX50DAZKfE7a1Esdjeyq2XhOa4cicORnS1z+Egc/ShfNZmKSe
 rxkaUvDnaK8Fo2pELeBzzn5VRVly/C59JD+fQVFij0kLYnHYJA0PlyEpWgcztZ7mv/qp
 xIQNZlBQNEAhn4n53D3fM5G1+83Ng37vkL8VmmOyLmmmn0ekD1o/jU64GEFAL6Wxs0U8
 kVT0/G2qce8lT/vUi63vwx0ISIh6vxSC46p+ed7qBtsIH7+YQziLabLlS10fkVY8rdqy
 IW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726145073; x=1726749873;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HqriCKUEWeKgEXArwVf2e03/WsK4aafWukqhg5BtCUo=;
 b=JVYsagux/7Q0L4FdQaY4+Xm/ny2/Eof4Nen9qA/pZf+IFGKnKaFWZ+esQqgEbyjw3H
 T5o+ZTms5vv4tV+ohNcwtTMcq1cjcYEViJKXcHLqNsX4tn3GclZD2N+koSxpl39LwbG0
 AFP4e/yEOIVYw6QZyN0lk53yxTmYCj3D+C9C/31VTYDBuo61YDrlry1uyd4G5ns9pnt6
 pfH/JRI+GNhTNgAz3HEiLDiNlKbJ/I+LsSaG2XBrUoQxX3Hj9rHXwvbUGDqo0+Beinpq
 KAp/z1xsHNNYZoygRwroXg6xyXx4tGeWYCXkexZIdrn9rfKgnRZJrmXHWl2FEU4rTQmJ
 RM9w==
X-Gm-Message-State: AOJu0YwiO1uGOhJ3ZLSt2fbzrh6nfN98vvhakV2B2psSmdkv+oZxnrOU
 Var6IdpA5PM7ph5GDGktA/WJWZHweFMC1pcL+qnabEEp7XGg/ay/L4fV/qz0PS8s8A6bU9FK9Rw
 U9/9qK7bs1SXdnNIZHuvJHOzPyNV/DXme8/cu5a3h0vLFpADL
X-Google-Smtp-Source: AGHT+IFqH9zhnIlnoN2hZhjamt3zH+y3bVunEdPvGkycwLd9pRGXaypyASR30zm0KMaCSmjTkBktsNpGQ6F+FXp/p6w=
X-Received: by 2002:adf:a458:0:b0:374:bfe5:bbf2 with SMTP id
 ffacd0b85a97d-378c2cfec81mr1499794f8f.23.1726145073301; Thu, 12 Sep 2024
 05:44:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240911114826.3558302-1-jan.kloetzke@kernkonzept.com>
In-Reply-To: <20240911114826.3558302-1-jan.kloetzke@kernkonzept.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Sep 2024 13:44:21 +0100
Message-ID: <CAFEAcA-gd5-Nh3SjHQFKcQBuCRNqk4OW_C5L1qhL6NtbCM40ZA@mail.gmail.com>
Subject: Re: [PATCH v2] hw/intc/arm_gic: fix spurious level triggered
 interrupts
To: =?UTF-8?B?SmFuIEtsw7Z0emtl?= <jan.kloetzke@kernkonzept.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

On Wed, 11 Sept 2024 at 12:49, Jan Kl=C3=B6tzke <jan.kloetzke@kernkonzept.c=
om> wrote:
>
> On GICv2 and later, level triggered interrupts are pending when either
> the interrupt line is asserted or the interrupt was made pending by a
> GICD_ISPENDRn write. Making a level triggered interrupt pending by
> software persists until either the interrupt is acknowledged or cleared
> by writing GICD_ICPENDRn. As long as the interrupt line is asserted,
> the interrupt is pending in any case.
>
> This logic is transparently implemented in gic_test_pending(). The
> function combines the "pending" irq_state flag (used for edge triggered
> interrupts and software requests) and the line status (tracked in the
> "level" field). Now, writing GICD_ISENABLERn incorrectly set the
> pending flag if the line of a level triggered interrupt was asserted.
> This keeps the interrupt pending even if the line is de-asserted after
> some time.
>
> Apparently, the 11MPCore behaves differently. A level triggered
> interrupt that is disabled does not get pending. Thus we have to retain
> the get-pending-on-enable logic just for this model. For GICv2 and
> later, the pending status is fully handled by gic_test_pending() and
> does not need any special treatment when enabling the level interrupt.
>
> Signed-off-by: Jan Kl=C3=B6tzke <jan.kloetzke@kernkonzept.com>
> ---
> v2:
>   * Keep existing logic for 11MPCore
>
>  hw/intc/arm_gic.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
> index 806832439b..4333d52ee2 100644
> --- a/hw/intc/arm_gic.c
> +++ b/hw/intc/arm_gic.c
> @@ -1264,8 +1264,9 @@ static void gic_dist_writeb(void *opaque, hwaddr of=
fset,
>                  }
>                  GIC_DIST_SET_ENABLED(irq + i, cm);
>                  /* If a raised level triggered IRQ enabled then mark
> -                   is as pending.  */
> -                if (GIC_DIST_TEST_LEVEL(irq + i, mask)
> +                   is as pending on 11MPCore.  */
> +                if (s->revision =3D=3D REV_11MPCORE
> +                        && GIC_DIST_TEST_LEVEL(irq + i, mask)
>                          && !GIC_DIST_TEST_EDGE_TRIGGER(irq + i)) {
>                      DPRINTF("Set %d pending mask %x\n", irq + i, mask);
>                      GIC_DIST_SET_PENDING(irq + i, mask);

Applied to target-arm.next, thanks. (I added some extra text
to the commit message to give a bit more of the historical
backstory about what's going on with the 11MPCore GIC model.)

-- PMM

