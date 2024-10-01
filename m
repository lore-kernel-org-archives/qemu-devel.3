Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F383CEACD5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 15:47:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svf5O-0002fG-Nc; Tue, 01 Oct 2024 11:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svf5M-0002eN-Tt
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 11:46:48 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svf5L-0007uL-Ca
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 11:46:48 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c42e7adbddso8071002a12.2
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 08:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727797606; x=1728402406; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2vIRPIva2oUSmXVkDJAitUMfHspseN0nhtWV3ZtInJI=;
 b=TIyZgARMZ2+sOf+mFMA24ySP4jTk1Cy9G4bgyJMtYEgxbiVosaC/MgBrlZt4/FfXab
 /yw7CnRypQPOuUCIUGdPM/FzQdzHl0RAekB9MGC2uMYdXO+qYs2dxw+w+qAdgXIhndfn
 1eVSTCHgNufnzYNzlPxj17OBc+xZ0tFR4tbDXAOj+iyNTW7tI37PgBbf2HphN4lmwDo3
 AWHXMY/GGOx/O3xxgY9QyUj/XzmHe6jVWja1Sp0bJuAqLm6xxVdMMjcYkPE6mjcx9a2v
 WoSDVorZodXDqyVJ82g/59vXEbH6GN2D6Biat6Mn5bRNGCZ3kn7ABRMPGGeFfqowt6FO
 3wAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727797606; x=1728402406;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2vIRPIva2oUSmXVkDJAitUMfHspseN0nhtWV3ZtInJI=;
 b=OJGn1b15pcTq2zoQVpfasBx7nlrqFdeIHL13wB1QVX9U6E95VjRSfhjMFcQ4Erjr6R
 2hKnlQLyPh1hmKxr2rzWGFU1c3xvTbiwgcbDjwGr7NtDRAppbtzJRyThVAH8v/TsTsjW
 CcuAbhNEA2AmYGcfeGpUgM7hrGom+y4tmuzjvT86dxBCMxFfbYzU0dK+eW0LF79idBII
 wZEHqzsLH1y87k31nycHhSxh3RJRpL2L3JRUAV+aoWRkrY6IZVlar5a47yyWG/QqomBN
 Bl1JsoETKMjbgVfvUGV/jutWliPKgnX1TXF0rVhEWxP6TZooFGWsJAjHZuFRtRSafySr
 E5IA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX44ALWZhuSW2qp1I4/xe5JU97TS0P75mEy+KEfYlbjTex+vRNW7rXptoY6OPHBAyfVHqx15es++Ls/@nongnu.org
X-Gm-Message-State: AOJu0YxLt26J0dN+ET5n+0bOmTxIwefYfrCh7m6ACTXnN1/ZSfsfkLS7
 rfDDzinR1R3E9L5sLexRoTxWAq/w8Qk6k9i4WxuxcLDQ2qb2LtcXCu5b8Ds9jvrQRyDBdyURWGp
 Rmj5XkOmhZeauS8igxuhksXOphF1Wgu97pn385roKaz3h/hl1
X-Google-Smtp-Source: AGHT+IHx1dvDkULkqr3OvASf3DAivfY1X3hPeUXYXsnY7v5AqNJLeErjFcRQUyXtKXXaz4a7tHbz6MvgkYo8pp0Bp3M=
X-Received: by 2002:a05:6402:358c:b0:5c8:9476:2bf with SMTP id
 4fb4d7f45d1cf-5c8947603c9mr7622108a12.35.1727797605501; Tue, 01 Oct 2024
 08:46:45 -0700 (PDT)
MIME-Version: 1.0
References: <20241001024334.834807-1-jamin_lin@aspeedtech.com>
 <SI2PR06MB5041260E63C468FB348E1F2BFC772@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <8e725955-8696-4809-a23a-87e390cccb5e@kaod.org>
In-Reply-To: <8e725955-8696-4809-a23a-87e390cccb5e@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Oct 2024 16:46:34 +0100
Message-ID: <CAFEAcA8cetzuXmwbTZFZC6fpBASwboiu2SSOznZ-GoFvQ6pfvg@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] Support GPIO for AST2700
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>, 
 Troy Lee <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Troy Lee <troy_lee@aspeedtech.com>, 
 Yunlin Tang <yunlin.tang@aspeedtech.com>
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

On Tue, 1 Oct 2024 at 12:56, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> On 10/1/24 11:43, Jamin Lin wrote:
> > Hi all,
> >
> >> Subject: [PATCH v7 0/8] Support GPIO for AST2700
> >>
> >
> > I don't know why I send this patch series failed to the following email=
 addresses and got the following errors.
> > open list:All patches CC here <qemu-devel@nongnu.org>
> > open list:ASPEED BMCs <qemu-arm@nongnu.org>
> >
> > 2024/10/1 =E4=B8=8A=E5=8D=88 06:43:04 - Server at nongnu.org (2001:470:=
142:3::10) returned '451 4.4.397 Error communicating with target host. -> 4=
21 4.2.1 Unable to connect ->
> > SocketError: Failed to connect. Winsock error code: 10051, Win32 error =
code: 10051'
> >
> > Do you encounter the same issue?
>
> There seem to be an issue with the mailing list. I don't know what
> though.

The data centre hosting the GNU servers (including the mailing
list server for nongnu.org lists) had an outage earlier, and
everything was inaccessible. It should all be back up now, I think.

thanks
-- PMM

