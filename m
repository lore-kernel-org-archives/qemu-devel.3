Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A4EDC3ABDD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 16:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH3Ks-0006hY-FZ; Mon, 19 May 2025 12:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uH3Kp-0006gy-Ot
 for qemu-devel@nongnu.org; Mon, 19 May 2025 12:27:27 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uH3Kn-0004cA-3f
 for qemu-devel@nongnu.org; Mon, 19 May 2025 12:27:27 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a3771c0f8cso321569f8f.3
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 09:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747672043; x=1748276843; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3lbGJkoNWgPOKHNTtyf6gP1VQKuV33pn28tXKa2PyAc=;
 b=fmNo2cTGceMXpaFHg9gfskTAxJmryhiPAKtYKE0z9mF+v0MuH/S5Rakeu+1p51rtc7
 BEe6Blj/FO9NI8MjL1lRL+ali5W6JvGkjj37bsprBswzWDfD03Ashgz45bppbjZq8Z6b
 WyNxD4PgrX1NMk0nWccL/IMvPw51D0mpFTGx0Si0uPhIlva1tjE5/CCAJPpRvKWqrNl/
 C6wvZxptxiKM4HFD+UkQ/tbZ7Iwp6qdDeBY9cq/zuYKPb+45JuuuovQw/YLrdiUbF3BX
 Rauqyk9gN7ybcjrQea/TXrhdKhkVXpKrxRf2DJzbUfvWkj7MDsXXhAwMU7iwWBx6y8WA
 T1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747672043; x=1748276843;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3lbGJkoNWgPOKHNTtyf6gP1VQKuV33pn28tXKa2PyAc=;
 b=YD/aSpNLkK1WP/EjhGTTyJfTmXfODnQTQFkBcql0OsidKr50kl6mNBqNDdP5xji1uQ
 kdG4aSkKZC2TTFf7zwl78KbW0NRACcM8q+YKFNiXG3jVjU/fBTgc1OVdWCWUvLdXrhAt
 q7Sw3zMQhSdRRE1JAwRX3eFfvw06mA9yggfMVbuTuTWPIn5AmywhWzQ9Or2WE5wg48oN
 n2Atr1opT5nGsEP94r/enNqq8qvGRYo6gRuLR3IgUQQaiWHCpy+VE2/Q67+wigONYtms
 nDmbCj+bYn6h4Z9VJNhks6X3Vw8F8mNmqientSI5dOkSgxMB7UA/iXQTWL9vo3N9WXYl
 1BDA==
X-Gm-Message-State: AOJu0Yx1GMI7jgVNdNYlLK4qZQhd+dFChwSazgy7w3nX79Naa8Gd/srX
 24wxWiFfhNdeIUGT9zdM4GaIBNhNhA3QtJ0EpcCRkEDHyeQbiVd1+dxR+mjruGKG7a8=
X-Gm-Gg: ASbGncum1wek7aZ3eqfuA/guiskSzsNX2xyFdRcgXUt0zKVaB9G+YF9pWZowajarOHb
 imtv/LjLQglPCybsqf4EPcrsqW0mjbGrfQBt/qFOOPNtauASnM1oRbb7MoI3UF1A4w4eZ6iQMa4
 KGM7VP/XFoo6A2dl8GxmRtaBh44Wu4JaUk681qWvn/sGfRARLidCXZan0mM4w3szU8QpifOcjtZ
 vVS5fKzx9YFHOgoRk+D4jxKAmCWkuRMWShOsIdyYYVuEGorukFOCjklQUedkIJbi/JeDKT3kYxo
 dpbrhtTZoymRIQ5V1p4KBYbr6j1vSD0UEw9QkB7/1r1hFug/JhkI
X-Google-Smtp-Source: AGHT+IHkzVTJAoH4dG1PVMYkyQW9pFGadVj0GwHQIacBBc3l/sqmpWqau9PYjlMVW2DNZBrD3jCRkg==
X-Received: by 2002:a05:6000:2405:b0:3a0:7a7c:2648 with SMTP id
 ffacd0b85a97d-3a35fe95381mr11178553f8f.27.1747672043077; 
 Mon, 19 May 2025 09:27:23 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a36c6eeaf8sm5908155f8f.48.2025.05.19.09.27.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 09:27:22 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8D3B65F7EE;
 Mon, 19 May 2025 17:27:21 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,  =?utf-8?Q?C=C3=A9dric?=
 Le Goater <clg@redhat.com>
Subject: Re: [PATCH v3 2/9] scripts/checkpatch.pl: fix various indentation
 mistakes
In-Reply-To: <20250515135936.86760-3-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Thu, 15 May 2025 14:59:29
 +0100")
References: <20250515135936.86760-1-berrange@redhat.com>
 <20250515135936.86760-3-berrange@redhat.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Mon, 19 May 2025 17:27:21 +0100
Message-ID: <87ldqsr2fq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> Various checks in the code were under-indented relative to other
> surrounding code.

Are we accepting that we have hard forked from the Linux checkpatch now?

<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

