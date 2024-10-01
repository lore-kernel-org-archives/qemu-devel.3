Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99402CEACD5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 15:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sveqj-0004PB-D1; Tue, 01 Oct 2024 11:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sveqW-0004MV-5b
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 11:31:29 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sveqR-0005gt-PH
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 11:31:27 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c8af23a4fcso429844a12.0
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 08:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727796681; x=1728401481; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ro7ApGiVvTZKwEYTfFY/fIfx4P0Ein+HWP5DeFKLDTo=;
 b=d2XbkcGORKcCIi3jg82HopjTh5he4X1kg4UNumcK76vJ07BNtPk/OUNHddfHv/NTFS
 nCwNzVWM/oO/6oy87k3LKLYomxcMR+NMWeCF8q0djWvR4lE0+h2xkkrPnDwvYt01+Zsp
 qvE4wmO0hG07XykBxAFTi26yzJtqRedQxgTBSF0FN5JY7XLQPtYuxZry2IKSvgfvNuTb
 M6n2SnMWDNir0uOuoh7YvVppAH2UCvVBQOVq0vyyfCf3JunZdHfMl4rUAXQSQxHR09/i
 6FULUOS0WAuSCarFp6gOkYeyIy791rtmVu6Cz6pY15haT/9WTZ+nHOFy+FC4VtDwq9rF
 exXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727796681; x=1728401481;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ro7ApGiVvTZKwEYTfFY/fIfx4P0Ein+HWP5DeFKLDTo=;
 b=I1aiouoREyJ/anJCXUZKlUssFU6AUt3T7xuZflBmRNINm+D5jkMJbfMXaI+Kz3R8m5
 Awim8ME/aZHWej88xPyKgk93Gd5oxo1Qz9Zy+j7oXnnaB8B27IcB2i+o1B4Kybts3AG8
 XUmP6G/ETyrxiw/XDy/ZCR72V6aRZoXPGaNJb2WNP4OHLSATq2pfM40HV6avuTc/j/ve
 ybJUguTfPeEqftUgM54JTla6gBW8BnU/kFr7r3QMtVPn21owkYNS82ZMF11GVnx2paUx
 ya1EyATH6s53FFcJDFE68Jdnvc/rxZxAimITJUKT6FSyfU1jx+p4Ie147yEK2hS5Pk7D
 s9PA==
X-Gm-Message-State: AOJu0Yz+rTz3d7VWeyO9DLyd/gA9XKaC//7bFXcm9LknrrsgNfErVYuJ
 1nE++niTgOxPHeA1ERTzIkJq/War+cLvtI0OWAFOt9GB8hxzvKBd8s2kilUn019IrJruVlyZZwo
 4FI/gAnh1QBQeKYgMilQjpC5ER7E97qIT7peAww==
X-Google-Smtp-Source: AGHT+IGSYVJUpBh3tI+qcrMUgDUIHUNiYRLcUSfuLn4tlt9+EgEfGKk6g1wANBT/VZZXPjtzSWK4zjR3kmF0WAhY+aw=
X-Received: by 2002:a05:6402:42d6:b0:5c5:b84a:8156 with SMTP id
 4fb4d7f45d1cf-5c8824e7174mr15297803a12.17.1727796680825; Tue, 01 Oct 2024
 08:31:20 -0700 (PDT)
MIME-Version: 1.0
References: <20241001152736.2684236-1-marcandre.lureau@redhat.com>
In-Reply-To: <20241001152736.2684236-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Oct 2024 16:31:09 +0100
Message-ID: <CAFEAcA-gciih5ePjcUi6MmpY9pdaXk1q4bxA-AYzZvvJhA=fmw@mail.gmail.com>
Subject: Re: [PATCH] qemu-keymap: fix a small leak
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Tue, 1 Oct 2024 at 16:28, <marcandre.lureau@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Spotted thanks to ASAN:
> Direct leak of 136 byte(s) in 1 object(s) allocated from:
>     #0 0x7fd0216f7350 in calloc (/lib64/libasan.so.8+0xf7350) (BuildId: a=
4ad7eb954b390cf00f07fa10952988a41d9fc7a)
>     #1 0x7fd0215d5d5c in xkb_state_new (/lib64/libxkbcommon.so.0+0x1cd5c)=
 (BuildId: 5e4eb795acbf75d373f2930e5d0e84a568225bab)
>     #2 0x5593b05bbb5d in main ../qemu-keymap.c:235
>
> SUMMARY: AddressSanitizer: 136 byte(s) leaked in 1 allocation(s).
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qemu-keymap.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/qemu-keymap.c b/qemu-keymap.c
> index 701e4332af..603bab4661 100644
> --- a/qemu-keymap.c
> +++ b/qemu-keymap.c
> @@ -261,5 +261,6 @@ int main(int argc, char *argv[])
>              "\n"
>              "# quirks section end\n");
>
> +    xkb_state_unref(state);
>      exit(0);
>  }

https://lore.kernel.org/qemu-devel/20240723-unref-v1-1-88606ffd4552@daynix.=
com/
from July is similar but seems to free slightly more xkb
data structures.

-- PMM

