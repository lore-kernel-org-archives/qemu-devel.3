Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD99C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 14:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruC6d-0003sp-JS; Tue, 09 Apr 2024 10:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ruC6c-0003sK-KN
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 10:05:46 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ruC6Z-0005bq-SL
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 10:05:46 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-56c404da0ebso8425120a12.0
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 07:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712671542; x=1713276342; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kq74n8QmF/8vkVCgPiL8KHqd0m7ZYpshZwl+KVQquYY=;
 b=gHpkQ0Vl8nD/euS0Ra9kKydYdldMStD/oxqyZx7Tpm2CnMLUg1cBjObsiEiWO2/D1g
 9C5xVs4S/fhNrvzCM9Y+DXxantCWoUbRTZb4Fi+4UhJPzplD10VoTeqOVNT1ALcKIS7W
 iW8dil6zVKReNEa/rU5/7Ot8dIPBf3fq2pnjFyDeqFCZnfkxhguAM2WxbCioN0ADj7LF
 +2OznMJO2rg80+roLXcFZ10FhTx5YowuZAuPaiKv3nJaZYbdYf279/N8L0pYYen4a3Sb
 DCDxfjFaV3yw6gXiXhTztPBtYUcySH62+tTLiAhW9Eodc1T7LJoznfsh+cJsSsZU8Bhk
 Nkzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712671542; x=1713276342;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kq74n8QmF/8vkVCgPiL8KHqd0m7ZYpshZwl+KVQquYY=;
 b=lRcd+52Ne00qWL4WO1XP5rT+tufGtW9DDu8cEhr5vYLvkbonvR+t3bds+vWCHZ/2Hm
 2vsdKaq44VWXk870szUQZ+ITqyQSfxJ+YBbpAUgRyEfc5IOkrLz34Y971uIrW28I+hqy
 BPFwCOP+FTwET11VBSwiH0oXcplwU14D3rQVIdGtTHV7K7dOgdP70VYsujFjbOAeqQnT
 63qqQfQMeAReHuhlaq+Uq6CmloWMr7eVma0M1OM9P4QyYd7FFuC2iqUhzE6okkXEqQAA
 oQ4uPLiKK2Gy7wZBPi6J+RzKkOBzgFqdXBQNgIMUQDxDiufU6FEzKWv9RCI9B8KpRrGQ
 37SQ==
X-Gm-Message-State: AOJu0YyaFgl7K4a7IE6P615/FVItZCpAeIISbkcT93d//JaNQpX4Uwi5
 iV1FsCQII4d3dIY5Re0DVPnBsTBxb7uc3AsUIE2jHDi1+8t5SiKb2+mNiEfa5sKM6I6PDa/o0kG
 r6fn2maAgs8VPJFCYgTGEW/50i1u7jFX9Lg/flg==
X-Google-Smtp-Source: AGHT+IFMoa++aWPFu+6luj+brxClVFw1JuK+DC8pJ3uYk2ERGfIxsj1fk1/1rryjyR0QsCD3keUmPgkCiPqubMDw1aU=
X-Received: by 2002:a50:9e44:0:b0:56b:9f82:4a40 with SMTP id
 z62-20020a509e44000000b0056b9f824a40mr9019832ede.11.1712671542100; Tue, 09
 Apr 2024 07:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240409133801.23503-1-philmd@linaro.org>
 <20240409133801.23503-11-philmd@linaro.org>
In-Reply-To: <20240409133801.23503-11-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2024 15:05:31 +0100
Message-ID: <CAFEAcA-HN=AL+af2QgvASr0YaUDVgtckpB=ay9sTuHd4m_hRTw@mail.gmail.com>
Subject: Re: [PATCH-for-9.1 v2 10/11] hw/net/lan9118: Use RX_DATA_FIFO_BYTES
 definition
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

On Tue, 9 Apr 2024 at 14:39, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> rx_fifo[] is an array of words,
> rx_fifo_size is a word count.

True, but that's not why rx_fifo[] has been sized to 3360.
It's 3360 because that is the worst-case RX data FIFO size
in words (if TX_FIF_SZ is 2 then the RX data FIFO is 13440
bytes, which is 3360 words). So in this case the array size
is correct.

thanks
-- PMM

