Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D1FCD1296
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 13:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruBjl-0006F9-27; Tue, 09 Apr 2024 09:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ruBjf-00066b-DJ
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 09:42:03 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ruBjd-0000jW-I9
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 09:42:02 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-56e1f3462caso5795922a12.3
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 06:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712670120; x=1713274920; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=seoyXeyruefadi2eT8APGXSV51cRic55d3JTadMFQ5Y=;
 b=ADRqkII7cmFZDATYmrkfU8JgFtGkDk22P2XP7gbfKmoZlXXY7m151aSYg7i7CLGKx8
 Oahsa6IjsSkp4K9SNOIhy811uIb+kdDIuMrK7UeR3xk0sd43156aeB1pbc6GQyNY//fK
 qHZgPF9O96hsa1Mvf8qDRrhD2Sk0Q0REDDRALpASvdGhOC2CwJy2Z/YlO0hyuru2ybZV
 dLe1pLgU7Pm3GwfVBdmpcQTO5egNEgJZk0CWgqMB9QSleWuYfDLpFMyd3siM1/bJbeyN
 Bx6HnpBmOFeVW7cjO8oPxgfYf9lRtqHshUoqVP7xEI1w8NOqx2uSr8kqK+EOuhQdGx5v
 R8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712670120; x=1713274920;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=seoyXeyruefadi2eT8APGXSV51cRic55d3JTadMFQ5Y=;
 b=Kn478EGwRzNH9/UpRN+sCNqM6XkxdX6dsiwypVNVJyHA11KzNheOqDWO7j7zXN1KMj
 rNFYRnjrrg+kw0LCTtW/FgC/7UsYA4JiLIKqXhBI0HjY/mT1eSWcvLOzSefXofOx5l3N
 eoqx2n/tW+6r7fandEbJfv0JuuAZ8caDZyEWEsFiwYJxPIpn3iWtSEbalKqXybyG8ls2
 ij7EcNxUlrAK8lqJrLrIsrQpAe0iadMj6cDJRUJTftP8s3w6RiDrD0IMiBR8emyoGmZb
 QY8OX8Ure8caXGXx6XZcGqJ8GI0CZ0y1ind5F4O7FcQ1MbfV4LRdixjUh8Ju6n9CXTt6
 vRsw==
X-Gm-Message-State: AOJu0YyH/qm/AZxbTzd4zoi0ocZ2JQwpSVqAZXP/CmegK53rS/XuPZA/
 u80tBwYqiVeT5dd8JtO4iaHlLWe5Qi3z76Xjpp2MahWvwyFMZALK4ebOaq1BrjTFJpBojrUH152
 3YzlFR+6D5F+9ULxPEBK66Sw88EepnSE9g37Snw==
X-Google-Smtp-Source: AGHT+IGnKzf0N62iFiEwg+b8EGxWNuJ/E7335C5lU3fBCFvn1ilWhFpITWlxYEcSbhpwMfVCakfb+tAiqg6enmWfIgI=
X-Received: by 2002:a50:9eec:0:b0:56d:faa2:789b with SMTP id
 a99-20020a509eec000000b0056dfaa2789bmr7962495edf.40.1712670120065; Tue, 09
 Apr 2024 06:42:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240409133801.23503-1-philmd@linaro.org>
 <20240409133801.23503-3-philmd@linaro.org>
In-Reply-To: <20240409133801.23503-3-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2024 14:41:49 +0100
Message-ID: <CAFEAcA8EsUJ8mYJDQueZZip7xhipES1exK_FzQOVJ-QYTYqVbg@mail.gmail.com>
Subject: Re: [PATCH-for-9.0 v2 02/11] hw/net/lan9118: Fix overflow in MIL TX
 FIFO
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Chuhong Yuan <hslester96@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Tue, 9 Apr 2024 at 14:38, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> When the MAC Interface Layer (MIL) transmit FIFO is full,
> truncate the packet, and raise the Transmitter Error (TXE)
> flag.
>
> Broken since model introduction in commit 2a42499017
> ("LAN9118 emulation").
>
> When using the reproducer from
> https://gitlab.com/qemu-project/qemu/-/issues/2267 we get:
>
>   hw/net/lan9118.c:798:17: runtime error:
>   index 2048 out of bounds for type 'uint8_t[2048]' (aka 'unsigned char[2=
048]')
>     #0 0x563ec9a057b1 in tx_fifo_push hw/net/lan9118.c:798:43
>     #1 0x563ec99fbb28 in lan9118_writel hw/net/lan9118.c:1042:9
>     #2 0x563ec99f2de2 in lan9118_16bit_mode_write hw/net/lan9118.c:1205:9
>     #3 0x563ecbf78013 in memory_region_write_accessor system/memory.c:497=
:5
>     #4 0x563ecbf776f5 in access_with_adjusted_size system/memory.c:573:18
>     #5 0x563ecbf75643 in memory_region_dispatch_write system/memory.c:152=
1:16
>     #6 0x563ecc01bade in flatview_write_continue_step system/physmem.c:27=
13:18
>     #7 0x563ecc01b374 in flatview_write_continue system/physmem.c:2743:19
>     #8 0x563ecbff1c9b in flatview_write system/physmem.c:2774:12
>     #9 0x563ecbff1768 in address_space_write system/physmem.c:2894:18
>     ...
>
> [*] LAN9118 DS00002266B.pdf, Table 5.3.3 "INTERRUPT STATUS REGISTER"
>
> Reported-by: Will Lester
> Reported-by: Chuhong Yuan <hslester96@gmail.com>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2267
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

