Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A76E9D591A5
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 16:38:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDRES-0000yX-6C; Tue, 19 Nov 2024 11:37:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tDRER-0000yP-Gw
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 11:37:39 -0500
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tDREQ-00034s-3Y
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 11:37:39 -0500
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2fb518014b9so10214151fa.3
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 08:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732034256; x=1732639056; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tCBl2AInR5C3oS0GW6Oo9XoTe6nI9JOOw2iJ9ksbd2o=;
 b=lSX5wZbO7NaqPf6z23De3xo2uTmeTW6v+InBObdZDH7r3IlZgjrljewjhKUf4Ny6+C
 cKo6wsjyhI8CsLcsn8bC6Hz0fSSiijfzld+SbMkql69HaGICCwgItM57gxRHvnzDACX/
 eg1Jyk3k/apP5sygnkuhGkCsuz8eboJgA3Qr21ZXO6bZRfzB21iM1fckKkgGLKDljAjQ
 c2wCx31Gf5M6eEggw0F7wsiTs6wHFQnKxIyFWDDmDUfLQULvlTr4Yn/0Pfrg70SSY7b1
 lLYyzePsgNhAdgmK7pJDRR+MuPtmrTBiZ/W3mbTY1/6/jqrswBUCiZ2kz9isTxOrheu7
 fI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732034256; x=1732639056;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tCBl2AInR5C3oS0GW6Oo9XoTe6nI9JOOw2iJ9ksbd2o=;
 b=vsGIGg7Dc+SbFwFedQgKRc61EL/rQY/+sK+ZduX2DSmgilK1e6iJZP78f1rD9tqE8S
 wJ6RXPoPeDhhkavRAZYWVaNoK8b9bV6sxdVA5eKTqn12s8xLb9PQzCqYZXyD8dwG0rIn
 3zL7RfGalIB6IqGMLT/nhQ+Dl/Ap1mc+aWuhH+nUjC4RQWm2kPV01iRcyJrDij0qBuPj
 7G8IdEDIKADgC39ADmQOo22FhYE1ckRHe+RHJyeRNJvzxsiicB+s9apfke4H2H1WIFfo
 93HFBNuHSIKU19Dw41wfrUt9sFYf2A3YjF6dWevFD3uz2nlnpl7F6p8t7lsBBYqMUV8k
 OOdA==
X-Gm-Message-State: AOJu0Ywtf37mnIbXTtcbW9Xn1lJ6zDGecPLYULWCzK/PKJbUAed8XMDl
 AZ2I8zCICFwc2y58vp6/6HZCUpduNvVPMEeKAbnkNO8DxrUNxiBKSJ7o/vQg+Gk=
X-Google-Smtp-Source: AGHT+IEQgxQGXaVBHEebD1hJewCNWFS8wn3497wHeGa4p95RXbRILM18EzGECEiInlMc06DMlQBfrQ==
X-Received: by 2002:a2e:a9a9:0:b0:2fa:de52:f03c with SMTP id
 38308e7fff4ca-2ff608f15a1mr65666411fa.5.1732034256175; 
 Tue, 19 Nov 2024 08:37:36 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cfc9804412sm2282811a12.86.2024.11.19.08.37.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 08:37:35 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A95B75F716;
 Tue, 19 Nov 2024 16:37:34 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Ani Sinha
 <anisinha@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 04/15] tests/functional: remove todo wrt
 avocado.utils.wait_for
In-Reply-To: <20241119150519.1123365-5-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Tue, 19 Nov 2024 15:05:08
 +0000")
References: <20241119150519.1123365-1-berrange@redhat.com>
 <20241119150519.1123365-5-berrange@redhat.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 19 Nov 2024 16:37:34 +0000
Message-ID: <874j43p4c1.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x234.google.com
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

> We're not using avocado anymore, so while the TODO item is still
> relevant, suggesting use of avocado.utils is not.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

