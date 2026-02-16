Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C11E7BD83
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 10:54:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwEZ-0000Ub-Sy; Mon, 16 Feb 2026 05:53:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vrwEY-0000UP-A9
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 05:53:42 -0500
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vrwEV-0002Qx-J0
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 05:53:42 -0500
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-794719afcd4so27936997b3.1
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 02:53:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771239218; cv=none;
 d=google.com; s=arc-20240605;
 b=AsAJlw+LLimarQmSid4vA3JpnUneVM+juvG5ZFPyapbRnhI8YEIJ2PHWRnQEPDhU33
 jfOcaXUnsawittfQPucmajBQdBc8ixfcNiPZm1sUvVnbtIgftvUOT/l1hZ3lIeFqdobv
 zr99Te0uw9oXkC73U3odOVyLs8NGy+PsLFIvmd80FZxg6skILX/ftdPsAsJz4d42zJrO
 GvQ6NT079EQkVEzVpsl8KVo87727wr3IqXypu5C6glMhmHZ6SHiJ03F0fpQzzJcvlGG6
 lE1M9IxA9Nl/pAG9BLldliW8TXZqOrJsfB7ptFUbFqZKo4IZ7ttbZB40lvsimahSt7ZX
 UNLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3r6gceMc31Kn1NaBbHeBtt7sGJfmSVtZPxIASHmbdeA=;
 fh=NZfrAI7bq0DsDHYmdU1Dphm7+eiePN4L3xj1I6ew1oc=;
 b=lwDHeHHqH/14Tpw5ZOE8yTgOAXGJwFCY22qci9ENxzxosxArsOc9M8w2LxLjnNhj5X
 BXeH9VJUpKCurwLiPACB1HcvtubxYAnQ2FV2p3nCVRcVY5q2UiN9RYb0lv/qj7aFb/ss
 XHALKI7Ny+q7ylU8lzM/fwiFZTXL9kyvbqSHYTD8iCkuq6lwY60flUbOjXInUkHosog3
 z7hWs5gE/9TD+ai7ynwOqyufB5wFirtISDL9Wye9P4nIAjbOJWvVVjUztD05xW12fMU8
 xKlwhW0eSUjrMHPARA2tFqh7fVjCwptrbd3rkBlXWcWKqocaAncgcON1w+/jd68qE6Xl
 u8cA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771239218; x=1771844018; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3r6gceMc31Kn1NaBbHeBtt7sGJfmSVtZPxIASHmbdeA=;
 b=Xy2mtnOeWLtpxKNPEF2bPcqHCz0GWM1rg4oozz2eqvmZ0AkQdIAddhQ4GZ+oy95VeG
 osusq0aSF1QgUulH8p2wUInJ991R9k6GmN62neaxetNcfi1sZEwNMBNyiv7tImKgN1pX
 Ihk15W0qB2NAiGugTtBwqe6an6iPdrGkULad+KdGAmSuI6wVerFh/PTdp5LKdKwvCABY
 Hf1AU17ej6rd36yzZjiRRAyZZvoiTIUNw4WRTeRcfttZbffZAfQk6eKohd4WTC8cP/w5
 gVFwCuFoWDYolFmrGibZ3IXP1EUVLPxkfmdFC2FOwQWf/VT5RQFnmQQbSrF4zqe62zrB
 JG2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771239218; x=1771844018;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3r6gceMc31Kn1NaBbHeBtt7sGJfmSVtZPxIASHmbdeA=;
 b=BLYJk3YATI4b4b2yt9tWn/xmoghHdcqMtDJn7EFtaxx8MucuQSa2rD6hxtZUqR35U+
 eErcSn016ko9hIwiBcGOl+DtEU59HvlcXW0J9fzvlzFjyaRkMGR/560IZHse9o297rqT
 w4ivc1KGAswJW1b+4UMsWwgdMaV6HpmL2swKCMuFqNxeoP3JZ7w6VUgrQSPhm5p6TbbS
 ur5EsTytxo2OztZXcNB8uBzju64MazIODCkjkJl52XlqOjAtHGvMuefBoyJYsyP6WwVH
 xaiJGJjqJF5QsT853H/WF881A/6K+OST0YvebnVw0RkF2QAfeGVQT25/BhgxRj8kndHD
 GgXA==
X-Gm-Message-State: AOJu0YwV+4xiV9fFM4UgbLj70H0iM9QRZ1AR+P2uJuEBDtXJYg6BQjNM
 ATyj3DRmEXQVvuPH7VE2ihVWAzjRiBbjlK4F6Mh2aiHyWPDPdkVnA++ohPvbNM95hHnjJMNvrDw
 uEdEyAdu0fBmuX0BXP8fhuHEOZgerlCdqe3z4ik09qw==
X-Gm-Gg: AZuq6aL9DcW3XmZtwsyojMAs/iMsmutvD/TpIwRzEcsi64umGDiY2VvKx2wejxjuHdZ
 CJfTsdXrxxSp0Gew7paxIy5bgt4MALRcAGUaKvzQcsj2LB6Rg4FtLDrK2ktV8tu1b+U+qpHZUIV
 NUDyzupGG6d9Ak/1O0R5Yw/PPh201VlRJHJL9wT6hGb4og5NTdkf1irFUu9XV8/pZMIHMBZypqr
 64TemDF3sa4ciz6V6lL5ds3yAFjW8MEuLydyxFsdfvbDu5UCDYtHB2Pt+19IeXIu2O9X/7RYR6n
 wmhQmqs3SK4UVYQcYFQbmvGDSjYF8zrJ78GuwfrxW0tC1nh6G50+2ELElv2bvEs9Who=
X-Received: by 2002:a53:b74f:0:b0:64a:dbb5:2849 with SMTP id
 956f58d0204a3-64c19b7b686mr4865378d50.97.1771239218299; Mon, 16 Feb 2026
 02:53:38 -0800 (PST)
MIME-Version: 1.0
References: <20260212104432.4168886-1-kchiu@axiado.com>
In-Reply-To: <20260212104432.4168886-1-kchiu@axiado.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Feb 2026 10:53:26 +0000
X-Gm-Features: AZwV_Qg2ou8jI52ex9Ood6Pt-5QN0WRtTzAWyX6bh6ir_CkCsSIsmoHsADzsgwE
Message-ID: <CAFEAcA_u5B2RdVEaGycCQ6gCx1pQuT8rvGVGZpoKLTK+2s72+w@mail.gmail.com>
Subject: Re: [PATCH v1] hw/char/cadence_uart: Add BXRS register
To: Kuan-Jui Chiu <kchiu@axiado.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, pbonzini@redhat.com, 
 marcandre.lureau@redhat.com, alistair@alistair23.me, edgar.iglesias@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Thu, 12 Feb 2026 at 10:47, Kuan-Jui Chiu <kchiu@axiado.com> wrote:
>
> The new CADENCE UART driver in upstream kernel access BXRS register
> This patch adds BXRS (RX FIFO byte status register) or there would be
> kernel panic if user are using the new CADENCE UART driver
>
> Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>

Hi; thanks for this patch.

> diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
> index eff6a3c4d1..f57cad57a8 100644
> --- a/hw/char/cadence_uart.c
> +++ b/hw/char/cadence_uart.c
> @@ -120,6 +120,7 @@
>  #define R_PMIN     (0x3C/4)
>  #define R_PWID     (0x40/4)
>  #define R_TTRIG    (0x44/4)
> +#define R_RXBS     (0x48/4)

Where is this register documented? The cadence_uart.c file
references the Zynq 7000 Soc TRM UG585; its URL for that
is out of date, but looking at the copy on the AMD website,
there is a table giving the register summary for the UART:
https://docs.amd.com/r/en-US/ug585-zynq-7000-SoC-TRM/UART-Controller-UART
and it lists only registers from offsets 0 to 0x44.

thanks
-- PMM

