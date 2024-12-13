Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF164E7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 12:35:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM4sf-0007SL-7D; Fri, 13 Dec 2024 07:34:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tM4sV-0007NY-S3
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 07:34:45 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tM4sS-0006bV-7k
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 07:34:43 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aa1e6ecd353so223065266b.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 04:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734093278; x=1734698078; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lb820BPZGlkFPsHAAB8Zud2O522WBf86Ci5SYkT61+w=;
 b=Oouf24qR7YbiYyAZoVYH7ZVqHDPgIRD5LrE/x9xk7DlUt7wokro+UnsZXczROefJ8g
 Y6U3dJ6i5dUUbamKTOZm8Tp/J56TLAarYnOQA/JztS6v1Pin5Xgp2XKrB7HX2pbCU7Ep
 BtK+fYbZjZx4FWk3Nq1W0p3rxfOxnvSjyZmQUnfKiXwAyqNEG34QAKiFYkwPKtdrYJEL
 KbUsdzYaRvcOaMEcoWWbNTSKs4Zcq67FEa9ycH0ndMToRDyh2Dxzqw6AxAI0v5jt60E2
 fPnNMzxGZuRkdRsdbyQoBTxJqfeUVJ7Ve1hDnn5mop8Goyb1KD9SYyGS2IXFl8KILN1i
 X/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734093278; x=1734698078;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lb820BPZGlkFPsHAAB8Zud2O522WBf86Ci5SYkT61+w=;
 b=eaUpobokuPzetldLsMB04R1Gz5EttjtsT4DFKHSu36ucLY9WhhA+/YWMIqhl5ge6aY
 siOVDQPYuWlX7/ARtPFcWWXxYKtgFa0X1Ay/AFLTspD5SRVnyujh2xiJvDWPb6W48vx5
 4zGumnIE+yuwEWsixn9KoA3t2B3zqm9AKU8AIgHAl+UB/yKoaYCz1x1mgQB+5IFxTq/4
 Ihth+ZXmSAmiQdP0F5gKwjRZQSwxFKczFQ9FGYAPe7qh+mUBGrs4dhgoG7XP/079Zp1n
 /VtFKGNhn8DOP4MkBp9zR5xCYszTHNjgXu3xFxbTyTpBv+dBiINOkm6zdMoQ4Jao3+65
 9yeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4DxEbRgTsMxP1BgYgWnd9+NM2eKzCdTC0HdXJPVMg/vSFfXltPhIBBJMT6dDYUomvAeNVaoRsx+ra@nongnu.org
X-Gm-Message-State: AOJu0Yxa4Y+MHPBoD5ljJxbvJy5SrE/d9fsiLeh8BEMnC7H8088hgNNe
 YNOXtwWwuvVUXUteQmd2celvQbE8VExZAR0I7b9OKJ8vciKSzvl/zfkm0CxrWGZNcowGuPZtvsJ
 zLa4ePt8vhuPTkY7ZFLqVLNHoDaI=
X-Gm-Gg: ASbGnctH1COX3Xs7J/Bk9iuIuzO2Hh6BTaw2LuqPg4OIKg/Q7v70pfHcCrw5+tgyGph
 Z5NVOh5gfqlzi6n/h3VQPwqDfHyt7EjL4o/E+
X-Google-Smtp-Source: AGHT+IH5yl/RTjAzQk0d+MIssD84pdVhzhIP062C2wWxU0eGF7D/mBx34d+NDqC6NapH7REEiAY8ihcBSU0PGcgLRpU=
X-Received: by 2002:a05:6402:34c7:b0:5d0:cfad:f71 with SMTP id
 4fb4d7f45d1cf-5d63c407452mr5010199a12.32.1734093277828; Fri, 13 Dec 2024
 04:34:37 -0800 (PST)
MIME-Version: 1.0
References: <20241212204818.2468583-1-richard.henderson@linaro.org>
 <20241213012124.GA395472@fedora>
 <6bfaf34c-84c2-487c-997f-6aaa0ad2506f@linaro.org>
In-Reply-To: <6bfaf34c-84c2-487c-997f-6aaa0ad2506f@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 13 Dec 2024 07:34:25 -0500
Message-ID: <CAJSP0QXDY8nxDo4i7oy6ENtAQ1nYAk04i+p6R0xzU6XfTKMs6g@mail.gmail.com>
Subject: Re: [PULL 0/4] tcg patch queue
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=stefanha@gmail.com; helo=mail-ej1-x635.google.com
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

On Fri, 13 Dec 2024 at 05:42, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Hi Stefan,
>
> On 13/12/24 02:21, Stefan Hajnoczi wrote:
> > Applied, thanks.
>
> I guess you are pushing to the 'master' of your personal
> repository, not the QEMU project's one.

You're right. Thanks for letting me know!

Stefan

