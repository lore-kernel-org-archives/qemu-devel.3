Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF947C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 13:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruBxH-0004kZ-1q; Tue, 09 Apr 2024 09:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ruBxF-0004kM-0c
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 09:56:05 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ruBxD-0003rZ-B9
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 09:56:04 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-56e6acb39d4so2230951a12.1
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 06:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712670961; x=1713275761; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cHPCBsDcTz30tRDtJBIJn02BAhV6REqcdmkmIsHcGYs=;
 b=g1/rDMBge4N6l/hVpPNoOky2Mv2AN6G0DzMasvmXdbAOHL0obstFqoRjLXDgUQAjQ2
 pD/8BVPzhdA5bIGGfhQmNWT5xAXGUQ2SmGVXNdXJ8QAsOvImNLHGtd7kqH2cJMgAEztJ
 6WrVfK4j7h1lSRzlW4PDgQeowBM9e5IlWw0SB0/TKMSqJbLiEFaqhi3/1CngoYqG4+xb
 e+wY0eWN5ncHjV/3xOmBpstKLLEnFeUWeAUnDidw1C1Wxakm/iFlYAPQYX2jt3m5dBWl
 Fmls5e2QZDRJyd14R9xnzLs3ACvDK/oVW4rEdvfa2GMpSDbfECqJzZ8EN3SlWGBD1Jeo
 lKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712670961; x=1713275761;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cHPCBsDcTz30tRDtJBIJn02BAhV6REqcdmkmIsHcGYs=;
 b=NMTUlaciICXKSWqdqNAlqXAmZhDHjM9fnb8dNDOcJ5Llq2b7G9V2IMzE1bQMEDTJ0S
 Y9cU4KECPumdTDWn2mTDd5mgD+0p6ZQrf+92wpxVkyawcd9M3bt2vjxgsOPflEyQvCp9
 7T0RrJ7UzCHCz2kCkEQhxj7rzAwdhSeKXKzYBt3Kg5qDsXZ/ao9bTPX2b0uLxBFGl7c1
 Tp3LBVv6/USmW1H1xMJqqoPIQA94EKLTjzqjYhwUJ+DVtqSVOywrg2UmlB5SGgZPgfeo
 5pwEbI2MQJBuq44Ie8ZmP4PY73Qdzbi51UdJeD7CtsIWg1Zy9ZYwxdUseSi5ZZT9lr1Y
 0hFQ==
X-Gm-Message-State: AOJu0YyvNvTwCb20PndbDJvKmZEPJsdNjE259vvuc7Kq8uK0cKyhbuxM
 X/X10Rc03gRflggEicqApYhX8S+YmPpKgYcEAIfZYP9LsdHzpyJldu3z80/Zl7JzPEOICzM67PK
 gmiukiO/+fNCD1Exz8/BIJmkYD1RvFuoZCW1Urw==
X-Google-Smtp-Source: AGHT+IFzf7X3OueHL6fFZZ8ELRe3tnqVcbdg4a8Tjw8Bx1i2N/KOm27kV60Q6mANWZ4W+j8erpK2/Yd8+hO4UcxJn5o=
X-Received: by 2002:a50:c016:0:b0:56e:de1:f427 with SMTP id
 r22-20020a50c016000000b0056e0de1f427mr7869546edb.25.1712670961247; Tue, 09
 Apr 2024 06:56:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240409133801.23503-1-philmd@linaro.org>
 <20240409133801.23503-8-philmd@linaro.org>
In-Reply-To: <20240409133801.23503-8-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2024 14:55:50 +0100
Message-ID: <CAFEAcA-qas2Qb1d6mZtWfrYFeXrcOE6rwsYMOHdQYF_Zr-yzqQ@mail.gmail.com>
Subject: Re: [PATCH-for-9.1 v2 07/11] hw/net/lan9118: Rename tx_fifo_size ->
 tx_fifo_bytes
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Chuhong Yuan <hslester96@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 qemu-arm@nongnu.org
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

On Tue, 9 Apr 2024 at 14:39, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> tx_fifo_size is a byte count, rename it to avoid confusion.

But we don't consistently use it as a byte count.
In tx_fifo_push():

    if (s->txp->fifo_used =3D=3D s->tx_fifo_size) {
        s->int_sts |=3D TDFO_INT;
        return;
    }

where fifo_used is incremented for every word handled by the
tx_fifo, not for every byte.

thanks
-- PMM

