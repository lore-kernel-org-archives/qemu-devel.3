Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1574ACD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 20:39:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrOR1-0002CA-Dq; Mon, 01 Apr 2024 16:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1rrOQz-0002C0-DR
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 16:39:13 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1rrOQx-00010H-S2
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 16:39:13 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-56bf6591865so6414537a12.0
 for <qemu-devel@nongnu.org>; Mon, 01 Apr 2024 13:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=livius-net.20230601.gappssmtp.com; s=20230601; t=1712003950; x=1712608750;
 darn=nongnu.org; 
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IqNLQ9d4+o0emflQmQyxV8Md19LdIY/a5HQ12Cufdvo=;
 b=gCq56sjCxOOqDiKWT/54gPp6uNmsHaGcefV3QdbJlA8NHulsOPaXobehQKtY+LbxeT
 le/T0KNjRAfPrMkMAiiv0HbAuW3SV5AB29iB7dInKMVe0vPoS6bwqeNIxVcjkzL24vU9
 Wlv/6UltriOxz/pfnmuV/Jk1NDeSvx0OWx2Pda0e90OT8PJhazpRByWMa577XTmTh2SG
 S/ZcjaybfAuJjjY7sPEINPddKWnBrdB1O3Tw9jjfOyLbtgRnllQ3qKVwDErkmt6s8TTa
 LnYGCuCl121penyI4dzzBVFN2Ij7HCqnevLC+NN1D4nl7h3jho0sQviBq9at46yiQ4TH
 3JFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712003950; x=1712608750;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IqNLQ9d4+o0emflQmQyxV8Md19LdIY/a5HQ12Cufdvo=;
 b=RkxM1KTsSXjQDrPdpBH6ecI+fEQ7yII2Qqcz2TtIDNUUFIfnsK3sri27+s6lugWWi+
 IoxjUEFxrFsFwIONewXgkmn+hfK7A6RmHSfZ43GgV9TMNrbIOtV194ehiiCm1osNFGDr
 P6UXENRRy1Ex51tufC18kbl75xd9xd5AGbPWafhlSNoZvhWpbgajTOmxW99HPuLWmAbW
 cIqz9JpIxz6+mvdpYnHWObvOrE2fQbQzgBVsZf4heymDx75TSKVb5WSFRh7WMIDbgx1v
 jkC7ofgTKp1kwHXW4vmu6fiCnHbfxnQuGcJiDOqaDsUTryzxjMl5+OvWV/s6lZIvA0sX
 0MZw==
X-Gm-Message-State: AOJu0YxEF9xelffyYBKyC5hGf4QwDZVP2/aUIzPRSQfOmVgwxTAudkv5
 73r4zz5LeLJSl47xSC5Fa+gwHVIdtC1pe0pDE4L4HOk5rvwljAzjClTXrLLPuIc=
X-Google-Smtp-Source: AGHT+IHzsUrRhf/9WWF+3oZXHnJFfnSZppCQ3+qS0Q5e6NtdFDWulyzaUdgiBDIPEPHzEIwbqtlEaA==
X-Received: by 2002:a17:906:248f:b0:a4e:4da:5ef with SMTP id
 e15-20020a170906248f00b00a4e04da05efmr6099228ejb.44.1712003949979; 
 Mon, 01 Apr 2024 13:39:09 -0700 (PDT)
Received: from smtpclient.apple ([5.12.109.62])
 by smtp.gmail.com with ESMTPSA id
 gc9-20020a170906c8c900b00a4e440989f5sm3663088ejb.159.2024.04.01.13.39.09
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Apr 2024 13:39:09 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: /util/cpuinfo-aarch64.c:58:22: error: 'HWCAP_USCAT' undeclared
From: Liviu Ionescu <ilg@livius.net>
In-Reply-To: <9719a94b-5ece-47d2-9f97-60f024db105c@linaro.org>
Date: Mon, 1 Apr 2024 23:38:58 +0300
Cc: qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <27B78923-1653-49BD-94E7-78195AF18052@livius.net>
References: <8386D452-771E-4E4D-ACD1-F871BA458691@livius.net>
 <A2BE1ACE-3764-454F-99B4-53FCA9127F0B@livius.net>
 <47998747-e990-4c4e-be4e-d0d38b43e9d8@linaro.org>
 <63E7268F-D9EF-4F7C-BDA2-469F0BED2423@livius.net>
 <9719a94b-5ece-47d2-9f97-60f024db105c@linaro.org>
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
X-Mailer: Apple Mail (2.3774.400.31)
Received-SPF: none client-ip=2a00:1450:4864:20::52a;
 envelope-from=ilg@livius.net; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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



> On 1 Apr 2024, at 23:04, Marcin Juszkiewicz =
<marcin.juszkiewicz@linaro.org> wrote:
>=20
> So ask Ubuntu Pro team for support?

I did not ask for support, I just notified the community of an issue I =
encountered while building the latest sources, driven by a sincere =
desire to improve the project.

If this bothered you, I apologise.

Liviu


