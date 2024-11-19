Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A10ADD62077
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 17:10:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDRje-0003s0-IG; Tue, 19 Nov 2024 12:09:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tDRjd-0003oi-As
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 12:09:53 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tDRja-0000gk-As
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 12:09:53 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a9e8522c10bso915111866b.1
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 09:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732036188; x=1732640988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7plZDG8qCbNPeD92WJKa+5AzrWCbVHRFbpqUwZgc0VA=;
 b=Mec4KP3gcvmSy2TdS2ZhTtbm33HK2MOVaDX6H0C21VF5oWbdoiuLlivuWL9bGtlra2
 LBF2po2y0Zvpf4N8RzN6yACCDkL4VyXCa9zYFvKYJXBFZlkZibpbTHTGx3XByFrd2JxR
 M7187JwlF7VLks6ezWi285wDGQ4ksdjvY8otwacmpvW40CQae5OR4wPinTSRJK3+KcbU
 CN/eV4qpqD2lThkxO3x5CIJusY7gjwgFL/60NWR1dwf8/vMyUY4fjIW3KkBVkXsZBNQt
 bRzMNSKwKvE5H3gJO9MRfVQwhH+ok2ftY0OsDRvObalONQtOBxswAKqaw7GIgNMIwrqv
 93gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732036188; x=1732640988;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7plZDG8qCbNPeD92WJKa+5AzrWCbVHRFbpqUwZgc0VA=;
 b=qDL5ljTAFNeohK18HawcfKDskc827GDrBo3nKI4ogbaAg4M7udC9ZkUJDFtCJmEAcN
 SXUyItE7WIuo4HO400S773p5rC97piYnjW+Tgg4bnhCUNaz3ThEgbfDBrXv09u0kLKDK
 rwLzzmsn+t0+R+2DhDwBBzaI8nUl6FJvAFRb+dY//kYR+qWpB7JzUWc8nBYzUM0068U6
 nEaMuJ4KIb2Mq+cstg6qT2DPf/TmKsA08KUtUhaAyH3xZhrm6R0iG8dB76km/mAJGQ8S
 PNxM/5NvP7hAI5b8QlzwxeG+ooTIY3Q5yPCCYSr1fko+iXmAEHSkxP8K9hznCYrpTAxn
 cJwA==
X-Gm-Message-State: AOJu0Yykcopm9nlMwvHICY7kh5CEKISLOcGYrLKAuYXRdsD6HHwDcGka
 z5hG8wjaTqdJQPA7t89lapNiS1Vtsm/+/lOSXKyTlFJxCkfgeKH+5jdzmxc3wOM=
X-Google-Smtp-Source: AGHT+IFMfaZkTlY8YzjG275XKKaNGxXMHLxjtQsOulPnCSEfgobP2FAz9hqK0L63mG8tk+Y5zuafZA==
X-Received: by 2002:a17:906:d54c:b0:a9e:b5d0:4714 with SMTP id
 a640c23a62f3a-aa4c7e4cca4mr357359666b.21.1732036188632; 
 Tue, 19 Nov 2024 09:09:48 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20e08162asm679830866b.180.2024.11.19.09.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 09:09:47 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0A5215F716;
 Tue, 19 Nov 2024 17:09:47 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Ani Sinha
 <anisinha@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 08/15] tests/functional: honour self.workdir in ACPI
 bits tests
In-Reply-To: <20241119150519.1123365-9-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Tue, 19 Nov 2024 15:05:12
 +0000")
References: <20241119150519.1123365-1-berrange@redhat.com>
 <20241119150519.1123365-9-berrange@redhat.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 19 Nov 2024 17:09:46 +0000
Message-ID: <87mshvno9x.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62e.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> The ACPI bits test sets up its own private temporary directory into it
> creates scratch files. This is justified by a suggestion that we need
> to be able to preserve the scratch files. We have the ability to
> preserve the scratch dir with our functional harness, so there's no
> reason to diverge from standard practice in file placement.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

