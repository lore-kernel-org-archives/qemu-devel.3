Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C67C88E6A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x62ui-0003No-Rh; Mon, 14 Sep 2026 05:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x62uf-0003Mc-5s
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 05:23:45 -0400
Received: from mail-yx2-x10.google.com ([2607:f8b0:4864:41::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x62ud-0007Cg-HB
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 05:23:44 -0400
Received: by mail-yx2-x10.google.com with SMTP id
 956f58d0204a3-670fee39d73so1128654d50.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 02:23:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789377822; cv=none;
 d=google.com; s=arc-20260327;
 b=oBPNLjJ3oWxln12Z7waWdC6GAvP6D10Zx14oaVAGDFOYUknczqYCLWtorPl7wKyyfo
 crTLkleXS3y4GMSVQqmFv3dsM7zTKXDODn6Mv1htZ1lqUXqhJnD9Olm4hxzAMBsSeRzG
 PVMDtV1hvqtqFsl+ujlbtHhKFvpZ+DI5RqSsECE5v7kKf3m6raGI5qj62ytWgjCF6iWD
 debFNfEQowCgjxdHUEkAi86ZuE6gKEN9wxCs6vvr+EJmn23A4JFeFofE/8QtjFTQOYRm
 3NqhB+cibzff9d4MZPNO2mgPAz0wIzDnzt90mrjSeeu6se9ICERiQ4u9bDuy53EvriMU
 PxKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vCJaPpHRa5OqPZRC1vanYJmQ8zELdQg0oGsRjaaWozU=;
 fh=XKoZV3hgm4cLOVC44RsIg0ftjotH4rVwpewUeGAshSk=;
 b=M1p2j8sFe22bxRPADXAyCEGGqrY4J6EJ3OjLbGt/mh5+TimbyPUwd9uWBEcLloRaWa
 e0jqcisen5MfOmQCGr39RRxkTiLqvz4KGlvgDAjDZwt50lHHdUDm0jeONQj64cifEwDF
 S6EHs2Nq5RVP306BFo7vFXIZm0oC/2ffQDgd1aGqrZL8ChQze7RE51ynbTeIrS1eB9uu
 k8TUvaT1GfzVqyGYhkh5nN21kntxat7OtO/zY2ykSvvHbhmYm5Z1BCf2calhTbKTNTLt
 FnzyxJMPFp5/cNh9pBya0/e6Jrz9vwG4Cs5T+vTbK3o6fh/X3vwFcHl8it5dWguTim3H
 4xpw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789377822; x=1789982622; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vCJaPpHRa5OqPZRC1vanYJmQ8zELdQg0oGsRjaaWozU=;
 b=qR/Vp0ZaByh3uKYB3dRB7eDF27U3tozbGUfbqbZgMBV2B9P/yv3+k5dgJdAMf1mM2E
 vp1q9RvzCpsZn5kUkBuoo0W6IHuYNbSDXhLCEQkoDjc2zP1AphYT/MiuUvwcGxdxDXPl
 iiXdgtx6oko5a5Mtu9enr2xRIjUCJ/UzE5gq/za4vsATdCvVFpMa0mayncqbP5amWhUf
 JNnkiXS1k2DsesQH5+ERi+heenvJsW7Mo//RsMAT+FSXXFxXYMZoBIsqpjcnHqdQokDa
 r8uWk6xWxd033xVFO/lfXL2fvXlqi4+8kmPpsQQfqTpY4fP9FWqRqOVyR/HaE9UAqu5M
 FC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789377822; x=1789982622;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vCJaPpHRa5OqPZRC1vanYJmQ8zELdQg0oGsRjaaWozU=;
 b=eNzZj0IVuvGdKQsxrS/Zm22E2kxIpjpiOobzUmkT7wKEBHnettuQvC6kP5wGIjLL/0
 PDP7wT0A55Gv1SQqKGOcpbmOmt/F3JFZeNa80EXz/5Xw1PWLIN9dKA95TIjITtIbj1d6
 79TLyukzqq2ZuxhPgjP1bBCGms6ZKeBE4Q6n6BuR9hVtkiNMibmFNGFnupHRlcNrgegM
 nO6tnHAZIHNhECq1m6nhc9kwZ957j7RgZ90fM1aer44Sl+rrhoFusnxaU4eYniaH7OSr
 DiFPBOy+4N/VBpo0f898tHkexYz5JBsXhyt10YhXdLVVJG9RyTcHyDSVPA3o/MraAEZv
 7wXw==
X-Gm-Message-State: AFuF++k5fy5QrOJxz+l78JStfSSDQnjsHrK3T0nX4NIaarC7brGUSdfZ
 gSdouri8q3QN6AB/ZvE9/pnO4Q/iBvahS8LBFCmv21BcP9U8ZjfmfT+Gc91GWMjKd2UEslC6NY0
 FvifJit+4JxrZzZP4aQqnmd39a6c9MPtaDW0FV/ARNtwDfzpPvZuQOOM=
X-Gm-Gg: AYBFou3UiBEp3ay9AeOlMZPq+ODLOXC0vvXHmPEyrUnn9U0A5Bvk2IQIUBiLBbJqaqB
 qk18onKg7hET8v6zAzSXEJ83xsw7AydH7tnGo+1cOqTUTg73Ly4/o28LETlyCKBHZWvC3w5KDtz
 44BI5tBJ1ro/AD3azY8d9XN8gFrk2bRhQOaeVZ/+duG7H/awrq4P5UaEpsPzmRoTaLHMDFXhCm6
 SQztr+xN7YjbF/1wWiO3OOqClv2zC8EDzBTig5EBv7Oid8Gw0ck8HpPBzpKbyC1BF7F7fI8mJvR
 sI27HmZvWTI7u24Tduxbi/W1yKceYCfghGYr7C0EBCEYO2in7Pv8h/KOocqtiyEV8/yJEbyJRBm
 Pr8r0ARZrmuzIXy2fePO7sXqZdWVK2bL8au3hbtA=
X-Received: by 2002:a05:690e:1388:b0:671:2a73:3077 with SMTP id
 956f58d0204a3-6714defd477mr291438d50.0.1789377821664; Mon, 14 Sep 2026
 02:23:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260817011008.652105-1-satur9nine@gmail.com>
In-Reply-To: <20260817011008.652105-1-satur9nine@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Sep 2026 10:23:29 +0100
X-Gm-Features: AcwNN1WbF2m1A7bQ56JJf4lhGGbE3ugYTl6TJi7RdIZViL3D1E1Rn7er66F2tuw
Message-ID: <CAFEAcA9DGEO3yr0hgeyHjmenVvnYemqXUCHChPa9HDUsUvivGg@mail.gmail.com>
Subject: Re: [PATCH] hw/char/stm32l4x5_usart.c: Support writes smaller than
 32-bit
To: Jacob Whitaker Abrams <jwhitakera@gmail.com>
Cc: qemu-devel@nongnu.org, Jacob Whitaker Abrams <satur9nine@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x10.google.com
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

On Mon, 17 Aug 2026 at 06:03, Jacob Whitaker Abrams
<jwhitakera@gmail.com> wrote:
>
> Official STM32CubeL4 drivers use and require support for 16-bit writes to
> UART registers for proper function.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2540

This is a bug that was closed in 2024...

-- PMM

