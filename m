Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1434D116F3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 20:31:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQAYJ-0002q2-AA; Mon, 01 Dec 2025 15:31:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vQAXV-0002dH-JH
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 15:30:38 -0500
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vQAXT-0003SG-GA
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 15:30:29 -0500
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-789314f0920so37515417b3.1
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 12:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764621022; x=1765225822; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ov3EybgAMbtVwYuIyFa8NYP2hqMmki9RGcBMXG7a/zY=;
 b=mCKNCvNOYJN+z3PN/p/CvpsrCf+NQj9SnEFqHf5JxZrBpdyixB8DDUkTA38NXAK89i
 e7vYUfurkPTfStpF3mOJuX8TK9+wd6ubJRfhi7EWYpF/5fNxF9WKTi6JXLg47W3CKdD+
 v8fYPo8OYcEouBCtlI00GXXiPIaEsiYNAzTIsy4IYBNnB95Ij0CV4KRo/S5MDK6/ZIaV
 4R6zBJLnPmqPALwsHxqe8J0oDWgIQRpwZ2ewm8zFkOIWiOo1XdfQ23kILHFW73SgRsrF
 kkthDkjy2PwkzRnWPvODTnytaH3r0n8WASyRSKUxKbtb3uhzmeV4NHglqdMcaTN+zEU7
 JPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764621022; x=1765225822;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ov3EybgAMbtVwYuIyFa8NYP2hqMmki9RGcBMXG7a/zY=;
 b=kvr0rRkCav2tfnQg25JD2nu1DOpae6WfQaJSG1HHG0iwz5pfgJrmrPMRC0cm70WYkp
 TJ8mNjYyMHmbpb7OorP6X1sRJ57AYe2dXjTDZDd6QsLIP/jvulcp/LB8QaOpCYo2RIp0
 SHjY0WLFhFs7UZ9K+frFGo46e9/XtJ9GDbjuDGTwudIROvfZaQPzuuIQvDvZoZqKdhem
 2GeylQChR4+ybHNPQNcjuiF74MKo880+3D73x1Xrz1uYR3lYpZEepg04iJyOCZKCvAFP
 KZuMrsvZG4fIpgDld7uKT4TYmdcCJc/FWnAqpn7rBdPH4hNNRXjyI0fQECor1uuXWeqg
 dNNw==
X-Gm-Message-State: AOJu0YxFFx/RnfdBPToGsz6RgT37EOYAB3dB0BDWSC1fepIKgxenc6Ss
 RRiojHgkKHPFylNVctACRXkiF3VgshjV7+kPE/rBrvSm/kwBYmyPlbu+ftvFMw8b6lb6njCjgw+
 wvukTJ0gvWU5JKyv7DbleqKm1QxVO1i8NTtHhKoboeQ==
X-Gm-Gg: ASbGnctCRv5I03n4GzUuxbpSRrLqd1iL0jdFn/C7QaSgk0eUXeSjLh04aDRglkZFyEN
 jTjOmOaq8yI0EAk5v9dciY/jAs9THh2NPPZX6H+A2KBe+lVoD100xqXM4ToH8N4HbVWAx9OhLE8
 QT0RY5Z/AQYhu8Kk6JX2D5c4dyonS+eyA51mGraqTVGbx6+QjhyBjkWGWxsIgwMhh7/82kRlR06
 HNIRpugmnf4Cfp3P8nD54zrnzqqvMNEzLE8DyuIHCrLEXbqXlsFvi9uiApwW223wNXn9CMb
X-Google-Smtp-Source: AGHT+IHnnWGle8Fdv3ZcelLkVLL6CtSlvhwHCPgWcAs0OJD5Xjl8EjdPhzt68EQab62lgVY3CQBShDis4WmHf2xExcE=
X-Received: by 2002:a05:690c:708c:b0:786:4ed4:24f0 with SMTP id
 00721157ae682-78ab6db1675mr216851177b3.5.1764621022354; Mon, 01 Dec 2025
 12:30:22 -0800 (PST)
MIME-Version: 1.0
References: <20251119130027.3312971-1-gaurav.sharma_7@nxp.com>
 <20251119130027.3312971-5-gaurav.sharma_7@nxp.com>
In-Reply-To: <20251119130027.3312971-5-gaurav.sharma_7@nxp.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Dec 2025 20:30:08 +0000
X-Gm-Features: AWmQ_bmOCBgzEjxq7sC6AFyONdsCxH33Egt4wlevNplWJpaah61P-1TDutYvSxU
Message-ID: <CAFEAcA_zH6ViL58OW2doYWDNyBsk4uueBP8MsT0C9EeG7Ss1rQ@mail.gmail.com>
Subject: Re: [PATCHv3 04/13] hw/arm/fsl-imx8mm: Adding support for USDHC
 storage controllers
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Wed, 19 Nov 2025 at 13:00, Gaurav Sharma <gaurav.sharma_7@nxp.com> wrote:
>
> It enables emulation of SD/MMC cards through a virtual SDHCI interface
> The emulated SDHCI controller allows guest OS to use emulated storage as
> a standard block device.
> This will allow running the images such as those generated
> by Buildroot.
>
> Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

