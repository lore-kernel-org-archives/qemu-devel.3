Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF64EC021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 21:09:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tigSW-0005RP-O8; Thu, 13 Feb 2025 16:09:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tigSU-0005Qq-HK
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 16:09:18 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tigSS-0003hl-Vl
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 16:09:18 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5deb1266031so2311835a12.2
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 13:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739480955; x=1740085755; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dIYHRooJD6hgluEJZVvH9n64y4PCXSpPpOmf+gqwDRk=;
 b=ExI6j7lYm6QjfHieTzpgSNRdx27Ao0QWC7y90lE9/Dtr6gWrPS5fGsvq+47IeQ8u5+
 5VM32RBaQZ+KzhsZiSADhqUIKL99uLXha2Tx6bqQ1NMmV0x5aElDjYGX+EqV1L+ok+oO
 SjXlwHw8eqjC7tee/8ka85oDYe3zuAdcLZ2qSbiyDylsNAVotAqD2sxlJFfA6AtR4QNf
 MtJVikjM4BsXfchrRJKtVimaEG5YtWvYkRbvIVnGujnb0zP73WitaxFvDSjc9obDIeEQ
 4hF7XdBP9+NXHPIP7fWXqBs5XqE5AUR/JMH3aiyJuWdylaBCtROqgoC2iB+vj6LqkJS7
 UpQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739480955; x=1740085755;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dIYHRooJD6hgluEJZVvH9n64y4PCXSpPpOmf+gqwDRk=;
 b=tlkIDinWJWIYhnR/59pqGA82OeocnRbDtCavdI4ucNA8SC9SfXb/dFdioC7FniO/iG
 OzB56URYRUaQbfeO2iGgt6DBkLp295QCWT7LoUuF5T8LOV8gogCGKLY81GvPlldyAHb/
 Ge/U4TuSnT2BBpDUNImaMzNBjBvZPuGR0qQlRT2ZsC9nckMghwS6Io3xR/qLIViD0I2J
 alUMvjtOhtli5xA56hDiGZUp0D7QnAlsJ0/t9GWEe/UAoUdeHYhn+mz3mNkGV9JjXyYK
 Py6AWHypQPnzmm7t3ermEYuuS0Z0J9t6JmZs8YA9G4fV88E0Jy1ukMhcD0/TBK5hYWcC
 1Gqg==
X-Gm-Message-State: AOJu0Yz3MnPJMjk0aFyDNMmLoa4uo1BbkhBmkQaOR1CtPwiiDSstCRcq
 3akWuieC5KcLgkfk8j8d0WikwRMJv6VDjs1bfA+hRd7O/aSwcLGpS/lPd3BHqlM=
X-Gm-Gg: ASbGncsbj/Qh3VOrLYH5mKX2h15+u+ZnBXSsoOZOU/fZ/K65oXJ0ZcHfU8NVejy8lbB
 RtdKcdSba50FW0ERYQAUPgUGFBnxlAsuTUZ6GiNgutCt5mWai2SxLSSAOqplveCC+baRitPO0rJ
 irHW9S8Baq7KKZjcGXkJLaiYcYG3UxmjFVCngfw/9VWlHKxxCWhh+Ele0n6Ol82kTHxZFW29quk
 1R9AtngPPCwu9FMxikETzh2tdG9Jom51p5rTQA4jAN9RN7khHbaCYvTMjmTBQ8UdVvqSj8z/X3T
 3fctt+UuySvPA6jKxQ==
X-Google-Smtp-Source: AGHT+IES4R/SyHF3AuijAe4NdJyDFGdIXWIrJQABVktnHqkxwfFUstlS+MXBFvSMDRYtkDX9h8wlWQ==
X-Received: by 2002:a17:907:2d91:b0:aae:85a9:e2d with SMTP id
 a640c23a62f3a-ab7f34a2225mr974153966b.45.1739480954966; 
 Thu, 13 Feb 2025 13:09:14 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dece28808fsm1729099a12.75.2025.02.13.13.09.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 13:09:14 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D273F5F7DE;
 Thu, 13 Feb 2025 21:09:12 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org,  maz@kernel.org,  Joel Stanley <joel@jms.id.au>,
 Ninad Palsule <ninad@linux.ibm.com>,  qemu-arm@nongnu.org,  Andrew
 Jeffery <andrew@codeconstruct.com.au>,  Peter Maydell
 <peter.maydell@linaro.org>,  Alexandre Iooss <erdnaxe@crans.org>,  Jamin
 Lin <jamin_lin@aspeedtech.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@kaod.org>,  "Edgar
 E. Iglesias" <edgar.iglesias@gmail.com>,  Eric Auger
 <eric.auger@redhat.com>,  Yi Liu <yi.l.liu@intel.com>,  Hao Wu
 <wuhaotsh@google.com>,  Tyrone Ting <kfting@nuvoton.com>,
 sebott@redhat.com,  Steven Lee <steven_lee@aspeedtech.com>,  Zhenzhong
 Duan <zhenzhong.duan@intel.com>,  Troy Lee <leetroy@gmail.com>,  Alistair
 Francis <alistair@alistair23.me>
Subject: Re: [PATCH v2 1/3] docs/cpu-features: Consistently use vCPU instead
 of VCPU
In-Reply-To: <20250213135032.2987289-2-kchamart@redhat.com> (Kashyap
 Chamarthy's message of "Thu, 13 Feb 2025 14:50:29 +0100")
References: <20250213135032.2987289-1-kchamart@redhat.com>
 <20250213135032.2987289-2-kchamart@redhat.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Thu, 13 Feb 2025 21:09:12 +0000
Message-ID: <87v7tdpn5z.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Kashyap Chamarthy <kchamart@redhat.com> writes:

> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>

Should we add vCPU to glossary.rst?

Anyway: Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

