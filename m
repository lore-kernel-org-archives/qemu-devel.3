Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B0C10A3D80
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 12:00:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5jNT-0006Yp-1P; Thu, 26 Mar 2026 07:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w5jNI-0006YT-Nn
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 07:59:46 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w5jNH-0006H6-4T
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 07:59:44 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-64ae222d978so930781d50.1
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 04:59:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774526382; cv=none;
 d=google.com; s=arc-20240605;
 b=Qoua1YEnqvdBZULifKutlKhW0wvM8/BT3A69hq3vxCCoeGWkl+feWnZ0jm9nIKt/BL
 jOBbvAp+ZlWTl+kEVnF/685KrV7d/bnI9Y2DrM6XuPEvgTf3pobjLBpJHqfRBUIw+Txq
 70+4DyF1tlPHNg5jTWFq9Ede2Iz7Ev38EjMmfDhTjiF6wb6QO7bGDBo8l5JQdEp+brNg
 xBGg4wIaeO5bV1OLM5d1Z7WQDvN7gqx71MH0+fbqd+90Qv2Zgv0vAM0wQIX6q1t7vSP2
 k88JdwKWPKN+9ZetWOfZ7ZSKT6wy70DKZUBYb2ipaubNlz4ed/9Bo1RO0uWsl60ZXRCA
 ogQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+daOsqgBZoh7MvQOdx6+MJb7MCpIGfWmBJ2vFK1wPrU=;
 fh=qIRbUau/68XnBAmiD27rrUxcnOG0pNPxjzyeFymZl84=;
 b=ERlsnWpvl6CSSkZe0iKBseTM4SRjbvScUfXZZGVdJa6UoYWsI5Q/5fxOunGRp3Zs/3
 LlN3gHThXXiYKK+UOb7DXsapFeVR8U+uA/e0VXQQXN8cP4yOQBjORLEE3yidEtUK4NjN
 bPg4nB7qBtJYuCc67ArlD2AgEolg0j1TZnH9RmdN+XVKNz8Mi/PTpe0fIYKmmxLKtJMx
 HDkNXfeOhqCPapiektErJwb4si1GE+sibFIGfdPKteN5AsPBP5GSaR1MhJnHBHz6Tsij
 b/GRkfJOR0KQypwjMttv/UqihgTfOuEZv3DyvS1YSVxhHshgEkdvqLmMc1ZGjil0CGde
 Y7Aw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774526382; x=1775131182; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+daOsqgBZoh7MvQOdx6+MJb7MCpIGfWmBJ2vFK1wPrU=;
 b=ffhLzwwpsIEVJYCY6tyH4y5xUUNFDen+24KjCTjJT4M5lSOA0NiuZ6j8tbzQLDetyv
 MxszKkuftf7wZmxX3gILJPl8j36dfAP+xGH8l4TZnQ20dwYhEuXKsYkU9n/PP19euhF/
 EUdNNjyzqo6L+RlkcSEJHpdvVfPccgXEgkEQbeb6f7O1blw7CtswgXFbef2OlwJwibjE
 /WGs+AiHNFiUTQhAkdff+CVg0hXCocKhf6x8Lo4E8nMTKZ5gCDygbKqLuIhbggvmCiqe
 FHLq4LspThJdEGHF2YBmwQMa8l3SSHLn5bKAWMkDk5qFi7RnU1ckB3r6J5004/88OtaA
 p/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774526382; x=1775131182;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+daOsqgBZoh7MvQOdx6+MJb7MCpIGfWmBJ2vFK1wPrU=;
 b=JdNKQfH8goqK4q7X99R10E5tcbZbQPP+qKNeFj4w6STnb6QPSmzrSfxaBuQf8tbr+H
 YO74FTymZzfNbmDCycoyYWmOVbOFLn+RjFcHZN+yJQOCt3UXMwXJTXyjsVJJmdCfJqee
 Sns5KXEvillCZouNe5wEzLLNXWxuZb/83xuwLMj97OPhFROkwzwRHO+Z2V/v2PEgqwnn
 /BI5QA/Qw4qkNZ6U79gxqt6vPHOEvFEXz+jTYZkoyL8LntY/ztg5Onm1sA6vc55KBibg
 ZhytKuh1UaR1pWPFD3kmkUziwJrdPZvJjNeSOcF8wf72t1SG7tyEx/HFTRfmW0R3yOgQ
 GQ+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWu3Cm8ZKD0YCwApL4+2/1Q8LlsRTPGHx3q1+P7rG73UMobpcuDysMmBnAuV/4/kFFVNz9jcij3O31S@nongnu.org
X-Gm-Message-State: AOJu0Yxp8if56p+yFNZ13aUP0Q1JPs5OvpKIsXIKsTSg34Y7qn3XTR+v
 wbrBbvLOTqrFjFcT5cw3LmBi1G2QNohO3hgdj4WcZAZD8XyBIcNr/XkzGRhOTYR5XKWKzICtnvk
 Il9rdDUnsEzOPxYyhSwawnKDSbH5iKfSTAYru/K7KEQ==
X-Gm-Gg: ATEYQzySH8zquEs3/Drd9KTHnYr5wGKuu6scXaJFmq8IOQduiKeb6wOQFn2gAce7W7w
 N3brpn9v6EW/6yaEovDxJd4zZjJGy1ULASNThjoxU1QgUuR9r1S7gzoafOhOuf11brvzH3+cahp
 sd5VSD32Z0M4Vod17TAGIKqI5njTpwqPwspYTl5Js4blE8ofoCXpU1o03essC6QxtVcjnKhmf03
 OE53IK1tIhcwjlIZnCTv/yE25BgC801BlxAcoJHfgwHLAXk53z34xggvKzoG2BYyhSErpJea6rY
 f25p7NhrBE6SO//g28X9fGKF64gUUSqqwvebHNAW9wdIiTW+Me44UnZFaEkGVsJCe8Ao9w7jN3R
 ZaQ==
X-Received: by 2002:a53:5011:0:b0:64c:b68a:f519 with SMTP id
 956f58d0204a3-64ee618b729mr5622533d50.80.1774526381795; Thu, 26 Mar 2026
 04:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260326113457.159065-1-thuth@redhat.com>
In-Reply-To: <20260326113457.159065-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Mar 2026 11:59:30 +0000
X-Gm-Features: AQROBzDMtZMohbF7R_RUzgNbSrhXqBCmu98R5aqI7AtFShILrXnADzHTErJwxsM
Message-ID: <CAFEAcA-xWtr=Xgst=MOVcm+TxegSvNVXmDP_RDVDOvJJW76Qeg@mail.gmail.com>
Subject: Re: [PATCH] hw/display/vga-isa: Fix migration of the isa-vga device
To: Thomas Huth <thuth@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Thu, 26 Mar 2026 at 11:35, Thomas Huth <thuth@redhat.com> wrote:
>
> From: Thomas Huth <thuth@redhat.com>
>
> QEMU currently crashes when migrating a guest that uses the
> isa-vga device as display. This happens because vga_isa_class_initfn()
> registers a vmsd for vmstate_vga_common that operates on VGACommonState.
> But the isa-vga device is derived from ISADevice, not from VGACommonState,
> so the migration code tries to fill in the data for VGACommonState to
> the memory that is a ISADevice instead, which is of cause causing trouble.
>
> We need an indirection here as it's also e.g. done in vga-pci.c, so
> that the migration data gets filled into the right location.
>
> While we're at it, also drop the "global_vmstate = true" here. Since
> migration was broken for this device during the last 15 years (!) anyway,
> we don't have to worry about maintaining backward compatibility with this
> switch for older versions of QEMU anymore.

That means the only remaining users of global_vmstate = true are:
 * TYPE_VGA_MMIO : used only by the MIPS Jazz board, which is not
   versioned, so we are OK with migration compat breaks
 * TYPE_ISA_CIRRUS_VGA

I don't suppose that migration is also currently broken for Cirrus ? :-)

-- PMM

