Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E944CCFD313
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 17:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNZxf-0004DC-Us; Mon, 24 Nov 2025 12:02:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vNZw5-0003P8-S5
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 12:01:11 -0500
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vNZw2-0002fr-J8
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 12:01:08 -0500
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-640f2c9cc72so3422979d50.3
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 09:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764003665; x=1764608465; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jDye0m6Qzw37hhJGLyIViZrhdQfvJhhiOUM2fe+/k4o=;
 b=uTnd5QMzQDvWmyBsedgtHYbAGYkN/e61qMPFiIhR+VnBldyyCFzoFayMRX8IGPYbZq
 lbAZXe9n42kkuZFpPLb74LzCoMmXPrH/nZerKz8QRYbHcEwEV8xgxg15vZPGhBTgn3LX
 dYHi6xdGFALFN2Azd1/nHoMivWUCciVhXca2upibAwRkjYWEHTIKJGH4uVSo9S77yg6d
 wv6qZRmiF1sTby2ujZDewidBA4Ous8e5WB6g6yOIGoEeCF1sjTXevEmzT61UrFfWfJ/F
 TBlZfaWBiVAQt8Tc0Zm+Z58KX/eslVW7Z+reuCjcufkfJfCT4n2pZpB7TDp6m4o83w0k
 PZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764003665; x=1764608465;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jDye0m6Qzw37hhJGLyIViZrhdQfvJhhiOUM2fe+/k4o=;
 b=op51bNUJFDl359/gK1oqzllVLwTDr17OP5eHmH+a2FJcQ9tBLu9Cffw9vmne4oedww
 q3FmiAD8sH0/5t1urq+ylSitM8SW+amm7z5AcBCCwW/Dpvd6664wGhl7jX0qQCdgQvyJ
 DDbnewLpun8gyFKY1vq5c+fWCGQv6Hdu3dkybB7PvjGb9g9bU+janUwzHsjkV9aNJtYg
 DVgaQhnJZN4oAJ0pPBv4pVFpF5t9CD552Y1Ca76mssYGhFVDLIi0UgEtRbpFJ0F1lF9M
 IWZTBDMQX2OVxP/DTL7wperu/pJTC1XO+RckUC4BS6la2nwrPitiXP4rFjbjG6WSjYVW
 80nQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlX5im0P7Fc8OfUnytEE3Kq7ctjscBreo9GL9wn6VJkeTtv0XmeFPslPQ4/pYjBs1fEZnOgcZ6Pti+@nongnu.org
X-Gm-Message-State: AOJu0YzKeyWM/GKI7j7I+UHpep/CfV4ML1mvejk8bGExnJ6rYg4gz8SB
 rqkjXOVYA4Snd3/t+N8aEoD9GarjqmW1+XVd5Z6pH4oG+ocixtM9YNXvUQIXxn6ctlNcG0nDRP+
 zKBYBDMp0WAYXisjBxV6K3x04jwIWb5ZVsvuYga/ttQ==
X-Gm-Gg: ASbGncvKhv3zhkEO9J0MV14Jj0ZPp04CAWa9Xfa80/8XYO4QlWIJEkFgHzMhnR50VwO
 BbLGqxMLMuekeHjH4ZhzajUml7TMZHwtih7I4xr3hWyUCzJ6iE5qNIKTKJwKY2+Cgsq7phoTDbH
 BdrucGBdhFWXfl2qQuRLVCxghhOwWe/yTyGA9N/NYoWO4nQ27eqr1mQMRjL3BrNeI4U5XYLDYYv
 L1VL7Z2sgC2AItROP9Mp6d1FmwVZO7lWk+AZepumakqbMN1QSTJblulyhAzm5VVC4PXz8+h
X-Google-Smtp-Source: AGHT+IGM0x3utzQ0vrlbkMXn+5/5YAtoOpt2Im3kzH3pFHr1BKoSulD4sr5Hoi5Li8X0kTFnwWQqQs7yyFJJxsb80VA=
X-Received: by 2002:a05:690c:dc6:b0:786:62bb:f6f5 with SMTP id
 00721157ae682-78a8b496cadmr204303437b3.17.1764003663411; Mon, 24 Nov 2025
 09:01:03 -0800 (PST)
MIME-Version: 1.0
References: <20251119134414.2892640-1-cohuck@redhat.com>
In-Reply-To: <20251119134414.2892640-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Nov 2025 17:00:52 +0000
X-Gm-Features: AWmQ_bnWyvrMLAhUYFB-wo_YaV_sm7RBdPDudiG3K687B1RuzP_ckKApIYFUNaA
Message-ID: <CAFEAcA8r7_6fbEFtkEL4vi-wqABewcPU3P73RWh08RRQnQ5Baw@mail.gmail.com>
Subject: Re: [PATCH for-11.0] arm: add DCZID_EL0 to idregs array
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Wed, 19 Nov 2025 at 13:44, Cornelia Huck <cohuck@redhat.com> wrote:
>
> This requires a bit of care, since we still have to handle the EL
> specific part (DCZID_EL0.DZP). Callers can set/access dcz_blocksize
> via a wrapper working on DCZID_EL.BS.
>
> KVM currently does not support DCZID_EL0 via ONE_REG, and actually
> does not need to work with it, so provide a dummy value for now.

That seems like an odd (unintended?) omission -- is it worth
adding? (We would need to handle older kernels that don't
expose it anyway, of course.)

thanks
-- PMM

