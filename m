Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20680D5E387
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 22:46:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9uDj-0004LA-Ng; Sat, 09 Nov 2024 17:46:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1t9uDh-0004KG-PV
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 17:46:17 -0500
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1t9uDf-0005SY-Mw
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 17:46:17 -0500
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e29267b4dc4so3000235276.0
 for <qemu-devel@nongnu.org>; Sat, 09 Nov 2024 14:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1731192374; x=1731797174; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=on65vZ9eyegTreiHezAgauYBQCExFVG4sEO5EQG3PPQ=;
 b=Hhj3WJaQSAEmMvNPk7VPYdugwR45OR/h/GkKdE56l7kalCfhl+lTWMumZiJugxIxAb
 UMaKuUIx7K0Py2mPqnKRyHHRx/V9QATA/TD//Q++RnS0Q22DCeCi2cTrRdrtKqZfpLdG
 Am/mBcFt59yf3DhuDoQxuhQskDd48YEjNZTzsKJ+kir+Z/DYL6vnngW4bbmNmnfrIbS5
 oK8wPHxrxZYnOXuhTezfmnxtgXWQxbK15Oc+RUvF44Yx2XWnk4dO4Q8ZpOhFZU4sFdM9
 7u0xbSlyWzR2K2Y+EJbUP7c8G8K1p8Lkzlqxw5OGmYLfixe+4fLp6d5jYL+JUUfWF+pj
 eO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731192374; x=1731797174;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=on65vZ9eyegTreiHezAgauYBQCExFVG4sEO5EQG3PPQ=;
 b=ozW4+UosfSzIbPSi/G3/aSzVWJ+/opqF7egHkiYcSHEMsfX+uqXwDIfo4QNhdJHJah
 AfmVU6qwTFIYoZgSnuNuoIdgS2qBdhL02q26Ps02z+TuTmDEqg1LPnTca68cVQKtoWNW
 1XBGiuLrYM+EcUUtrcmlY5ZkFvchuowztGolHibHVk8ubVkoO1psfNXYop6VGv8Niky5
 mkuiXQgnw+47z+ffFRyc59qXttSflit1K04q/ZFDZhFe5h1K2HtRhGknmuRUFl2wXH39
 LLLM6RH0modo2PICwZ9MCElAuurYfbzCYbNOUY0GX6igm9dub3yNKG5ScMeEdoi6ye6d
 XVow==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0AYS+4CVbE2eg5kU5W8TU67KKzo9OPl3i3HQLTx/D3sEjf6ZD9H7bKcvtE2/lCI0SPTYi0Wwa9JaA@nongnu.org
X-Gm-Message-State: AOJu0Yzk1j+q1Kiruv61SEqA8sjGKyuTiggvt1hzZ0C6dvJkNPk7TP5+
 qr3x2/L5kak+v7Zko2dWNwsZv2/xrtXNzqbCHsuhfgW7BYwktG4dGMDIsPtah0y9j9hPpqSlVIc
 wgTRaeZLFdze2EWkF6ac/GXWPWo7uEao45IUONw==
X-Google-Smtp-Source: AGHT+IFZRrq3f7IX9SJCz0lSa6rpUg3e094vNoRxmd6/2ju9cDrqZYx9cmUXWpXV9AWAJW3Z7G8Bw6N/6rgYIZllRIQ=
X-Received: by 2002:a05:6902:2a4a:b0:e30:c4b2:7c62 with SMTP id
 3f1490d57ef6-e337f8e458emr7418200276.46.1731192374350; Sat, 09 Nov 2024
 14:46:14 -0800 (PST)
MIME-Version: 1.0
References: <20241108230709.1466634-1-antonb@tenstorrent.com>
 <4e7a4a10-bea3-4f43-b091-6a30c400b8bd@linaro.org>
In-Reply-To: <4e7a4a10-bea3-4f43-b091-6a30c400b8bd@linaro.org>
From: Anton Blanchard <antonb@tenstorrent.com>
Date: Sun, 10 Nov 2024 09:46:03 +1100
Message-ID: <CAN7m+mCqXz1YaBZpA-TFWz_TX0HiRorzXbaadn+L3fnigWBR1g@mail.gmail.com>
Subject: Re: [CAUTION - External Sender] Re: [PATCH] target/riscv: Add
 Tenstorrent Ascalon CPU
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b29;
 envelope-from=antonb@tenstorrent.com; helo=mail-yb1-xb29.google.com
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

Hi Philippe,

On Sun, Nov 10, 2024 at 5:21=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
> Generally speaking (I'm not objecting to this patch as is), for
> DEFINE_VENDOR_CPU() it would be nice to have reference to some
> documentation -- at least to review whether the cpu features
> announced make sense or not --.
>
> For this particular IP I'm not finding anything on the company
> website...:
> https://docs.tenstorrent.com/search.html?q=3DAscalon

This has some more details, including a 1 page PDF. Should I add the URL to
the commit message?

https://tenstorrent.com/ip/tt-ascalon

Thanks,
Anton

