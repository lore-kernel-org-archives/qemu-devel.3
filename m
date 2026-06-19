Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D79E1CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 14:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waaZl-0000hl-H3; Fri, 19 Jun 2026 10:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1waaZk-0000hY-3u
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 10:52:08 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1waaZi-0001ZB-I3
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 10:52:07 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4905529b933so21079675e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 07:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781880725; x=1782485525; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Z2PHbar6lZWZ63N8YG+oGxYu9rZ1FIGdAIhphQ1vLU=;
 b=KrcbaZqnZb7HB/cyPozUHaERl7RV0GAzIPvwz4kxyNbkDVGWWNYCNk+gWB3BCsRCYG
 EQCpf0PFHo2F549YHzDosvgkBStY6UGLstJnhyDGNtmJN2kp53wMsUix0HeWA/6WJsD1
 A47IdOtsSWEgDYX/tvWHrqHk8SVbNrhHbG6sBA0RUCnP7psuKwDKz/AckTadwKQJQ2/i
 8f2PlN9eDQeUmCUAY8jXoyCLqyPUwEmzcdmfTqFL9uNZvMoteNYQttNTsA088RTuGDDV
 83PAKb6fv0R9hG1gOOIIU4R6ycR5d6jxVpanSAQw6qMeCPIalDpTx6aquwamFtoClNpE
 73zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781880725; x=1782485525;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/Z2PHbar6lZWZ63N8YG+oGxYu9rZ1FIGdAIhphQ1vLU=;
 b=aaiMqSSbA5A7n2FXMfS/e+XvqZywQPUBDyxRuM+GZR7ruSHu7vXuNzPOgQSwpvRS+5
 DHKjR7gu0nn8Qs8JW9hhZJkAdaas0/t2p7LBW+irshdib8AhqJmBsFA8z7zNezpk8tht
 RSURg1em0P9w6io9JF4P4hcqnBTxXJgSi9+i8f6qlDUbF33R1UTGISZ51d7hYv3hUPrC
 W4+sqVUcq9WDjSk5MAKeGkytID110T5+c13r02cZfj740YX83/TyD0pHpX8iNiBQhYZV
 Sa33ocVcJc6NRoccA+2RXV5jSSKvUBTdlUgkIysdvUr16bBwWZDqcYh8hmFN97ejGSe+
 jQLw==
X-Gm-Message-State: AOJu0YyWszu3l3WQsUIPG7fp31ELn2HT1MG53k3YiXPoK49S4SGit54p
 3hAvGCVlP6wrIL8vSQsH5qZ3Z9CDXqLYO75OPTXNLRGOvRVwo/02l/Px+i/birkr+RHxjBEUSEa
 hlH/FpbE=
X-Gm-Gg: AfdE7ckBj82CsgGdGJi0PQeQhwVIAU9s8plQHnxQA64/XSrVRBsBMApgZQ7gEIU3c5x
 yrEYX8vKEYqbJ6A0OUq4m0dqu20ggZaHgORr3pU5eVixtOtHSE60pEYSt7dLvLCO7YM2JBau0N4
 QVapCSgCWdXdtzvFpUlSn3rwy1pAG48nuZpfTm2N6L373/Rj+exMkOtNgWKJllwb0KcZAp+NCPL
 o9ScS+VIokXXojSOkITXXydECdbm1bSplz204wLQ+PXI0wl1lAzZKTJ8Lhb58w8ZkfDcyGhINkH
 19m6R3QQS88J58c/YGhE0xhecJNwXIpQVkQ/fHRMuEojYwyFe3tpoCi7tbvzYKErRjLTZBWv+GN
 xT1y3CyQfbWw60+ecvFembnHF0v1Rf5dtmRXSoUl+FnPL0zFicusXd0M9ws2h1mODmpRcbQfVSA
 8l6kWfF1H5wjSK
X-Received: by 2002:a05:600c:5493:b0:492:33a8:5499 with SMTP id
 5b1f17b1804b1-49240e85b41mr60772825e9.17.1781880724650; 
 Fri, 19 Jun 2026 07:52:04 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49245bba787sm14339115e9.1.2026.06.19.07.52.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 07:52:02 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BD8705F814;
 Fri, 19 Jun 2026 15:52:01 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] gitlab: update bug template for sec issues & tool
 assistance
In-Reply-To: <20260619123632.1276476-1-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Fri, 19 Jun 2026 13:36:32
 +0100")
References: <20260619123632.1276476-1-berrange@redhat.com>
User-Agent: mu4e 1.14.2-pre1; emacs 30.1
Date: Fri, 19 Jun 2026 15:52:01 +0100
Message-ID: <87pl1meg6m.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> Warn that a security issue must have the "confidential" flag
> set and that any findings from automated tools must be validated
> before submission.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Queued to testing/next, thanks.
<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

