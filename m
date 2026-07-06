Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A259C43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 17:55:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgnWG-0004x8-FT; Mon, 06 Jul 2026 13:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wgnWD-0004wh-Oz
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 13:54:10 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wgnWA-000889-Om
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 13:54:09 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-66628618509so4331512d50.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 10:54:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783360444; cv=none;
 d=google.com; s=arc-20260327;
 b=sYOH5sWNY7qZZkPJLhpRMx4zhLfosys1LICE040Bwe8LXmTIl6eaAnT3WAXTnHnqkt
 Csr/xGtgveabf6/gR/m9i5Z6dCh/Q70HxqiTHC8siUjDbLzL0X05YO4ti2RCztLI5NTF
 C2f+duj2Ta/5osgiueGkkVwPDCMqjZRhr3h42G1rqQiImnFwV9g/x4HeeTvazwCcCAlT
 H9pm2pOzdV6V4227uhVHmX39aDgPO4VgF3oovnsj4wj34Nit88WJMyxmggZOyyA0HHdO
 OefirGSzoJzQ6DcwC7ckh0Dpa4BiQhZLYC1+abfeMEqUVQc4PEyDA+ymOPWg+ycqvePI
 +MhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KPWU9zMPY6i0aneOZqqbvFptRwD37tmJvOurkiWj2m0=;
 fh=0mFKHTj7rKUBAFer4LtI90Y9CGG/Wq18PIkiexg+q+E=;
 b=mr0+Nf7cJpEyhldYTa6TC6ckZbqhdPxmdEcmhjsQke6jYmVZzfNDtwg9zeuY8uquQz
 2FXYv4f7wWbeUNYx2jj/5R473P5YDxGApirSMMpl4LKs4cW7mhGvEQhl9Qcqm20az6kT
 gH8hOMqKeLurpzCWtFH1ypF2LizOegSyesbHpOhafFBkz1i1Z0ibUNSHJKLJki7BVyCX
 bvPZ/QBL0aPDj3LpwGdoMOGzuOwKqK2RBqRScfO09v4tIaSkrIR8c4ahRCLF7LbrIT1o
 Sk38nZp2FApmYraUD9cthEF/h0UILOis+JEpYWtH/y89VgC4W6byEazRDdKjBbdjpdlb
 jlzw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783360444; x=1783965244; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KPWU9zMPY6i0aneOZqqbvFptRwD37tmJvOurkiWj2m0=;
 b=m9fAYk5OwB2kPQROqrNY1pAE3F5tppIxqzE9HAee5sFhBOmBlB/tGwDwTxAulB9MV0
 vLt+1zbr7dBXfCZZocDTaQ4LrhFZZ8/QXorZnU1KZxwXoJP4mvYC/W5GQCwTFa4Zrjil
 UGtVW87pzlp2isuAxDSRTIK3GHcqfa9e5EaGDexK3AScv/rrQii4qZRCPW6zjlj7cbCG
 xn+rUQde+bAvbYO3h8qoXB/f6RE6P4MVIfSxVKGa98jFhdGqapNFy9SG3IJ2a99IloP5
 cJuGWnd1f+MPv46yRxfM/14Xro9/FZy5Nfe0SlbgEq+cOZsKcJMMwXKsyhnx0yqZZujJ
 6qhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783360444; x=1783965244;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KPWU9zMPY6i0aneOZqqbvFptRwD37tmJvOurkiWj2m0=;
 b=rEvH3vjHDidU0LvGNUiO/OXqG/Q/FDnyXQlWrkpyv1tDTCqZNyhzs3zXp1+zeJ68pz
 ZsCgo1hUOD71pFIJyESQJTJzzyUfOy42QYiCdXlUpCQ6GK2y/h+L0Qchlm0qpsJgZBLV
 +kDb+Ht+u+A7WrGeC9eynvHqXh7sfWjbCK7RK6+H+F5aq3krLL0RIiHkoMJfd/e/rw7u
 1Ecz01VoXwlBFhmaOpr+QeTk7XU4KcDuL8bi7JNGWo3Sksws75+TDoPFAfn3UYZPoaHR
 bXTtJU/4E85j5/zkM4N/x9m+w0K8kVOOCfrvgfm7zg71fF0WC1jQA/r0qyFQ1NpXvXQw
 Hk8Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrQrwAWvEeWGp5pqWBcD+txjlqtLlmUtPfJkqDOKpY6yyki/K5a3biY+gin5Q+DRnGvsoGjJg+2/TjY@nongnu.org
X-Gm-Message-State: AOJu0YyrfqoExutdGTi5j6Ykkw+g66ux0CbvBO30lh4qA7J4QcIG74xk
 UBCl7MZFnei2Pxeot8qMTaTebF2niYNp+8ne1ODosNzCQYfkYQ1ZZKOcM+7o7nfoZEHXzpN6Mfg
 eZv+upDMjwDcqLr7IxaCu4jgUvWjA5/R7mO9eMqnkzg==
X-Gm-Gg: AfdE7cnypbq2eimi6+ZA7MuEyAnFjm9n/FYnryl9kjEixR40VNpxZN/LUNddL9zh+LX
 KzORB2fORPEYKX2semYhcitHSL9MUazAvJU6gn0koTujm8OvplY+Cp1xeYiEhHlXW0FsF+9foqE
 BF2UEbR2j35J682LlRGmBLbXyMqK3ltPvBjWzCSHdzCfR8608cLoSnMQ+Et29DaPIer8DvXmXgs
 7T8h6SZeal4laPH6mfBKX0qwL0q47eGkZo7UPz99khj38IFYUjImrk/MjZiCab5NlVIUIzKmDJR
 CLa1DLFhzzqZsfewucfoJbMHRo9rjrkRof0hySk0NKC70kPHYODS4XLi
X-Received: by 2002:a05:690e:d54:b0:664:b27c:2b4f with SMTP id
 956f58d0204a3-6677fb0362bmr1453001d50.5.1783360443902; Mon, 06 Jul 2026
 10:54:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260309181452.83702-1-thuth@redhat.com>
 <00c4ab4b-a58b-4de4-8e41-566b2cb7f920@redhat.com>
 <124bd918-f2ab-43e2-bd2d-fc824de62c40@tls.msk.ru>
 <fcbe3d7f-64d4-4b13-b930-a81e77db4784@ilande.co.uk>
 <df7a091c-a8a1-416a-acf3-28a0cbd8dd2f@redhat.com>
 <c7d6b801-449e-4f55-9c1d-ebec7a0e9595@redhat.com>
 <c0cd50bd-e054-48b6-af54-1050e13bb720@ilande.co.uk>
 <baf0b727-d53c-4717-b4e8-9c8603b2fa75@oss.qualcomm.com>
In-Reply-To: <baf0b727-d53c-4717-b4e8-9c8603b2fa75@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Jul 2026 18:53:52 +0100
X-Gm-Features: AVVi8Ccn38g7Hit4O71HuRDN6SsoLBDmlWqjIzpdjYQIdM1Emf0YXyQjCdJ7I8k
Message-ID: <CAFEAcA_oFFEyRfXjRZR7+nLOE5fgzDi1kHQop=s1Q4EzYvaVxg@mail.gmail.com>
Subject: Re: [PATCH v2] hw/sparc64/sun4u: Mark unusable PCI busses as full to
 ease device plugging
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>, 
 qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>, 
 QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Mon, 6 Jul 2026 at 18:29, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
> - Bus capacity is odd. We have a generic Bus-class @max_dev field but
>    do not use it with PCI variants. If set, it limit the instances
>    capacity. The capacity is tracked in the instance state, and when
>    no @max_dev is set the only way to mark a bus full is using the
>    qbus_mark_full() helper. Then if we remove devices, the bus remains
>    full, and there is no helper to restore available slots.

The qbus_mark_full() function is intended for the use case where
a machine has a bus which in real hardware is entirely internal,
so you have something like an I2C bus which has some on-board
I2C devices connected to it, but there's no external socket
that the user could add more to the bus for. The idea is that
the machine model creates all the devices for this bus, then
marks it as full. The devices never get removed from the bus,
because they're hardwired in, not user-unpluggable.

thanks
-- PMM

