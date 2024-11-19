Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3205ED62073
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 17:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDRkp-0005NV-AY; Tue, 19 Nov 2024 12:11:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tDRkl-0005MD-Q1
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 12:11:03 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tDRkk-000143-7S
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 12:11:03 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aa4b439c5e8so421575766b.2
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 09:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732036259; x=1732641059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eosHa1R5FC10h07Q97gcOp5AetdoMSmREyTHgWERDFI=;
 b=Go1isor6oMcT9JnH3XsMFsS66uEjl61qxvMI78jR5YkADLYqjEYjU8kLDB45zc59pn
 KFvIu0Dh1Jdog4pqDCo/2uWL6TUJd38Uh3Oi27dC8oV28XnmeS5RpNID+Q4fjCCoYbvL
 PUxtG/WwKlckkP2njOoxOieARe3j30JqbO0HwpPYhhJ2S/QJKkZ6/AiBVnTgnmHkAfPR
 9pal/mSBh7omcWZ/wn1IIw9zvJKO0NZijd5Pq2oRc2VbhseIFC2FwBuZTDHKo/N4urDl
 Swm1Uc8a5Pa4dfe06a7OgByAaZhXVzuIWrObBkqvVYwiio5uX9d+Ue2vLopQCqe42z4W
 N1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732036259; x=1732641059;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eosHa1R5FC10h07Q97gcOp5AetdoMSmREyTHgWERDFI=;
 b=UTMUc4F3XTGB1Bkhc+4nB91rcpFQgmwqzsl0GBHOgBQLim9rFXFYxwobCQSzVWgj+j
 xCeB+nnAhs1L6pEpCvLuM6CDWETftSZNhQFxIVCUYRamiv+VDq67YvJ+l00zNilUaq8b
 qRbqe0nB44/Tez/TtElmNHIB9a8jM9m3lhO1I4QNn0c3SjfO2QIjYDTwir7pHxS427ot
 LCIzVQXlx0oh7Lk0gFYzzA+p+dDLlP3o8WG54RUBzzwnsILUn4tFtQ192OAok7+U5yJJ
 VvS98lQpd8P61opHEqGsvvFJdyrhhsUUYFt3tvKWkglOgKp0YlBBKO+HYy2vWOpt0x5V
 UlHw==
X-Gm-Message-State: AOJu0YzvOcs45iCIOU2VGQxwnVQBRtyLty2uY+Ign1H5JDUbDiiCdUXr
 mHhDymKhcXH/cVKz2SzKkBASkTE/m5NWFrHpijZ6DExNzBNr1XIKQinARBgbj2Y=
X-Google-Smtp-Source: AGHT+IFrEvkVNaljVDej/ftic64sUlQdGWzZ8re8jldkd8CWMSsko80FKQCVVDNfsSZYoDq4jlvzXA==
X-Received: by 2002:a17:907:9281:b0:a9a:673f:4dcc with SMTP id
 a640c23a62f3a-aa483422ef9mr1559430166b.22.1732036259632; 
 Tue, 19 Nov 2024 09:10:59 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20df515f7sm679843666b.65.2024.11.19.09.10.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 09:10:59 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 743535F716;
 Tue, 19 Nov 2024 17:10:58 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Ani Sinha
 <anisinha@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 09/15] tests/functional: put QEMUMachine logs in
 testcase log directory
In-Reply-To: <20241119150519.1123365-10-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Tue, 19 Nov 2024 15:05:13
 +0000")
References: <20241119150519.1123365-1-berrange@redhat.com>
 <20241119150519.1123365-10-berrange@redhat.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 19 Nov 2024 17:10:58 +0000
Message-ID: <87h683no7x.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
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

> We are not passing the 'log_dir' parameter to QEMUMachine, so the
> QEMU stdout/err logs are being placed in a temp directory and thus
> deleted after execution. This makes them inaccessible as gitlab
> CI artifacts.
>
> Pass the testcase log directory path into QEMUMachine to make the
> logs persistent.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

