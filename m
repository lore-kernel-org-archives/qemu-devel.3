Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 717DDFF8862
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 07:00:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHFxE-0006C3-5O; Mon, 27 Apr 2026 03:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elisey.konstantinov@gmail.com>)
 id 1wHFxC-0006Bo-Fo
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 03:00:26 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <elisey.konstantinov@gmail.com>)
 id 1wHFx9-00076j-6a
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 03:00:25 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so65076175e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 00:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777273221; x=1777878021; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7yiLmNkwdMZRsXBfCaF+cA6/azykhAX+keE3eenbQBY=;
 b=a6C+TfYJyVVJv4pZ7Wd1riE8LXs4JVcqZdN76XdBOYqHspq++mbPDBF36da/YfJ3TD
 yZS4KcUI6YCwBSNDZgxE/LlODKSrPQQtRwdKbXwTf1n/J+S1ihW8zVtct3paDF5zXcte
 uJ+yHbcMG6lQeHBaFSELWnvv67/fFg3YvNnGH85truL4VFLaboyvB47ICP/htSq6FEJR
 tR6tSdgZ4lJUuSvj28W6AYLvgClp9h9QIJG/0DHB3TgIaA0++Yx3vHuCR/LWrkbBpN+9
 1OLfVdSW3q91Q2hQjck0vliZHfdMkKrfnt+LpuR6ayQMxdeibuF94NK6O+mbPAH0VVQ2
 W38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777273221; x=1777878021;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7yiLmNkwdMZRsXBfCaF+cA6/azykhAX+keE3eenbQBY=;
 b=AHG8SdE7tZXDjgpH5Th3JgQQXRE8NeUoo9QASnfMSDkfjUU5j1zaYvmStcvUyCpmeR
 Rzl8De8ikeyDF4UGDeJfEVLtcMcvx13xlMe5/Ce9nj5kqIFT0x/H+1Xvl+qXQp2SMnmL
 iOH52B2m4R0CarOUjgcR5AANN2DO+6j2n6KYxhsnqOR4PWX8iqLBvj0/xieUu3pcgxt4
 lSnmnifa9Z6WaxKrBajsTWsQ/dfaEAEcwGM5z/PrccXHQokclPIcwB0vXpmOBab02LNq
 RBmQFZseeyTI2fVwjk/rJ26rW7m4Y1HkORQQJau/aNndt6iURxfOvigxWccQkZSoE+UT
 kEGA==
X-Gm-Message-State: AOJu0YwyALl0PLBAFtuQbXuJGgSadwiPgLEM0BqFxvY4xmnfmmFsWj3F
 8XHPgj73loj5HhQBXBVHxy+W9Dy0eFxG65CMy2IdocPiE/pzzA3xJafS
X-Gm-Gg: AeBDieveQGKKq0zBjz5Civ4gmHTZqyfIK+D+Sv9zhMddgJHoNfAdn/QWOI6rQJrj2Vv
 B9MITOijFatAG/04j90MCBQVbeI1TrlnHHT4ul4hMyievWgOE1cX6/LXEFkarsyaZ02ZwCb4Ikt
 jCzPdnkX2WyXzoChGasI70nV3HW+MApC1EtSUrucEr5+Qs+zZbFGdFcEe/dXh7pLpzVBImbZkOf
 tokCQPUqnLHIgOjiVXwcHalpCRAO+uoPzNqaLNi5USgfI6YSpBB0U88x2wCWp6m2e1zf0F/5giQ
 cwMZpi/EWJz1C56E3Si2GBY2ZTeSKB5LoUVvGpe9A/YebEhfLTPFw8jKMkHoBKLQEE9RXnkwZC9
 FOBo2bMPauPdF+eend3bC0gBfrx1trjLkEkXo+oTK+1+TeVJ41HZZfgfGgcJ47HYmEmIQxwKpDd
 2wMw0dlBudjGtEQQ1uZldalXJBqg1MN/gw9EWtfrkCzHLXRZailg==
X-Received: by 2002:a05:600c:3546:b0:48a:5546:61a1 with SMTP id
 5b1f17b1804b1-48a554663d4mr368749035e9.15.1777273221097; 
 Mon, 27 Apr 2026 00:00:21 -0700 (PDT)
Received: from smtpclient.apple ([5.32.173.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891bb3d121sm858448185e9.14.2026.04.27.00.00.20
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 27 Apr 2026 00:00:20 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH] build: prefer sigaltstack over ucontext on Linux
From: Elisey Konstantinov <elisey.konstantinov@gmail.com>
In-Reply-To: <a4fd79f8-43fa-4894-80d3-ed31ffec1ff6@ilande.co.uk>
Date: Mon, 27 Apr 2026 10:00:09 +0300
Cc: qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, peter.maydell@linaro.org, philmd@linaro.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <127762B4-9E62-47FD-8F43-F739B733AF92@gmail.com>
References: <616E96C0-F0A5-4A9E-A63B-3BC1B5F18094@gmail.com>
 <aeswZxFn0zMj-3jb@redhat.com>
 <06C2CFB8-BA33-46D6-9F84-B1F81A2A319E@gmail.com>
 <aes4kEdQ_x8eI-m6@redhat.com>
 <4FFF1823-815E-4956-9C80-9C62A98033B0@gmail.com>
 <CAFEAcA_gX4N6YrhQBTi-YDvkafJXWEkkDU8Y9vz5nYce9OrHwQ@mail.gmail.com>
 <a4fd79f8-43fa-4894-80d3-ed31ffec1ff6@ilande.co.uk>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
X-Mailer: Apple Mail (2.3864.500.181)
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=elisey.konstantinov@gmail.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Thank you very much, I=E2=80=99ll definitely give it a go, but I doubt =
that CUDA timing durations work differently across different backends, =
so I=E2=80=99m not holding out much hope
Although it would, of course, be great if that were the problem=

