Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16225F357DA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 10:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvC1m-0005NK-6Y; Wed, 25 Feb 2026 05:21:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean.christian.cirstea@gmail.com>)
 id 1vvC1j-0005MJ-Sn
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 05:21:55 -0500
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean.christian.cirstea@gmail.com>)
 id 1vvC1i-00038R-Kn
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 05:21:55 -0500
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-506cb1b63d0so71257961cf.2
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 02:21:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772014912; cv=none;
 d=google.com; s=arc-20240605;
 b=XpEV42WXMGxoQNI780+9SqyE7fsF0pH2fqrRQERrDnAuy6v8Wigja8My9Z0n/mnocJ
 Kco4t8KwvW1ZBNJFf58mQYTcCFs4XU23/vdSr+pAfEL7sPIvGr7r7t8ltmXo/J3JATvb
 Ur9dkRiQwnRj1EnVuPG4V/MgbYuLBDfWT0zMzibWkXuKYYcmCQaX8I3g5DVy0IME9cJZ
 esg0oB+dkBUBUyTkn6eeq20O4FvOwEBeEHkx9I4WHXqx/keyNXIlvAkS6XicFEsk0J7M
 lDPs78yiyAiE6Sw6I4fgwsmtCgNdBpTVgOuK11fBNEq47A19kgXrAeWvKl64o95bvYHm
 U36A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :dkim-signature;
 bh=gC/DatMn2x8zdlKRe7LPhKEiMtmoevwWY1c5PCeUObw=;
 fh=tL/A3IgPU4rkxag7zJH/C9s9OrGXisRzOk5fhYA1A2c=;
 b=epPlXKNdzZcSKlGwnU0mId6fylEQrR1xSXBPhPR3NsnGTLF/O2luW/xWpNL2ES7HDN
 yB0dSw0RRnJa9FAQ+9iFaTM4weNGpe5yXN86l0KRwHKTUhO/9GppaUy+mAY60mpTNj7F
 Shtlh4slspbosjsDomL5Yzfse45teagkGEy4tvej4wzz9o/ecaLb29FvraWAvkYw5prX
 lV5xiYXPi8b+75z+vVFV9jJT+HAx4fVKgSq+RpbR4r48QDOnQ18UREq2W792r9Y8DQGO
 EacvTxfhvzPtO0DCgfdSTlLY+HBIu3ZVgkIQAg3jyGDbMKUEQ9TPCUqh64MbUFF4aE2A
 09tA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772014912; x=1772619712; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gC/DatMn2x8zdlKRe7LPhKEiMtmoevwWY1c5PCeUObw=;
 b=Qpf5TU6EwJoRcpSQo/LMB6vRhoe4GnNUBxWP8802yokCWHzW5y7HWou4da3BJ4TVuE
 zB3EaGHa4p/mn3RNWsOYJBiQWaD4MTUibSZf4PuXXzVoi0FUE31i540GKIz8Msm6jk93
 KsrU93D1TfKFN0aj+wzMCWO2TdXUAbg6Yig2SjRLUOCIxVBbIfeiaroe7GiCCau4T5DU
 M7jKFTLYIe3Oh6vPaGrHF0A92MDXGV6hc/M4AzEy5YOXH/v8d3MLsXSudBTz9XUlQXC9
 /x8BiubdaQpNu0cWnlBn0YWNsZGvjCrzlrmi3FAQcsKi0tyi90ndGGUPaRrPtDOGVVj+
 lNBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772014912; x=1772619712;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gC/DatMn2x8zdlKRe7LPhKEiMtmoevwWY1c5PCeUObw=;
 b=hI3onw2QZ/zvMtsikyL4JcrFyFhX6M5GTRYY+OB7qyKdB5/J6i3CIi9LQI2rmMx7Sd
 IJcjmeyb4VkeG3G8KTY/bmi9wl4jap8IqIWZ5chQc5wRLEgtXoNioLWu2KZMCmaRIY0Z
 ickaMifScZnjKUfyMTIKip4/DLRmiY8Wda0OXMSqXIiRe56bShobWdNHPc6x/SVDOSd7
 FrbRII6Iuk+vR/E+41l1FCFPXt9wW/5ym2Gw5Uc4jXcV1cK6awq7ijw9PaC8nIdBA3eo
 KyQHIrnIdFM99UsPnVvDkHehQpDMeVtIImNfhqCtI4ox6LS/Z3J43VFo3Becj/unX/HR
 rKGA==
X-Gm-Message-State: AOJu0YzkK+V2pK7eVHw/e1sQOvvk1KyNrRpoehilTbGTZwo028tWGIOA
 iDNtzvuImqgInYPCE5pxAOE4kEev1i76uBBV5cNTVPyHKt0SFvCPCrI0n3YlCZqHjgAajZ46BlS
 T0rg0vSHptfeQ/qZe+KASyfI1J85sT/wzxQ==
X-Gm-Gg: ATEYQzz1anGodKMy9mGgt0fVEjJP/+cWOXZAqhGh/ztmilq9bEs3BXfQS+oxxijiLsj
 /R1PkglflPgtP9RVGnpx4ZcvOGlX+7SbPBIiKPAclW0ujnobCtJ4bVB6SX51IOXcCIGvECnVac9
 EFeF11TXOkc4iVXctCnxeWw1a4MDk+PUwc1+kZb5nbEDh2c1GvmtP2NdnLLVGUz7NVaAJLmQsca
 c7jYNmchA6hqEyv5dsqkrkGecXtcu/VX/SgrEmT2upRl9OVoYv0OGRLiFH0tPxQcV2EJnLDNY7B
 I585PsE=
X-Received: by 2002:a05:622a:5c9:b0:506:9bea:3229 with SMTP id
 d75a77b69052e-5073a35e80dmr19923141cf.69.1772014912120; Wed, 25 Feb 2026
 02:21:52 -0800 (PST)
MIME-Version: 1.0
References: <20251226173521.1957025-1-jean.christian.cirstea@gmail.com>
In-Reply-To: <20251226173521.1957025-1-jean.christian.cirstea@gmail.com>
From: =?UTF-8?Q?Jean=2DChristian_C=C3=8ERSTEA?=
 <jean.christian.cirstea@gmail.com>
Date: Wed, 25 Feb 2026 10:21:41 +0000
X-Gm-Features: AaiRm51vkqkBvqPposAEUkwRjFNlIAeCik4ZXShWjinCvCrXBY-1yNkPDeyj44I
Message-ID: <CAFZ6uLk_HKs5Ub5N0kmfpfXsW=DZEUHKJ+aOyTsxkOuFdGvdqA@mail.gmail.com>
Subject: Re: [PATCH v2] linux-user/strace: fix printing of file offsets
To: qemu-devel@nongnu.org, laurent@vivier.eu
Content-Type: multipart/alternative; boundary="0000000000005faa4d064ba35fae"
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=jean.christian.cirstea@gmail.com; helo=mail-qt1-x829.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000005faa4d064ba35fae
Content-Type: text/plain; charset="UTF-8"

Are there any outstanding issues with this patch?

--0000000000005faa4d064ba35fae
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Are there any outstanding issues with this patch?</div>

--0000000000005faa4d064ba35fae--

