Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B2E8CA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 10:40:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvvlO-0005Ok-UV; Tue, 09 Sep 2025 06:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uvvlN-0005OY-PW
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 06:39:49 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uvvlF-0000hI-Hf
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 06:39:48 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-afcb7a16441so816720466b.2
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 03:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757414378; x=1758019178; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v2iD2WgTvm49Sz327ax9YCI9zxeTDiVW3nrrkGX2m7E=;
 b=mvpchdDr9Nn2F7clP6glh6wlFX413jdz4tqiLyxj1Vh7a7CdNnXsccOc71G/oZ0W+E
 l5BzA/CWGIQQO0/hFwboMh+MH4LZtHn0ZcbNE+aH5NavSJzuJp7QG9QiCD0BcHBvpMvw
 TMuz8RoSBZGh8RIB1lGTj46ZMPbukCPSGxvi9sm1fqPH2VO8QmyCE/Spk0ywIlSnFNxs
 2mdm+xEPUfcbh0mjV9WweZEciPKDfatkaP+1Ow78MFniuHlsP6rsX9boiIA/kSxU+cpd
 DWFGT1kHj0W57+wn4CZTAJLpOIK+l1N6Le1BkyVO9g2JT/V/mcqerNApBF0vcRMby4o5
 fFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757414378; x=1758019178;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v2iD2WgTvm49Sz327ax9YCI9zxeTDiVW3nrrkGX2m7E=;
 b=mu+nGHExMBueGYzsRytGJIyYU4vSD1LouB67znjsDiZLZhQNZa0m8u0z0cb48LaENI
 Xb4e+gz2v3psQ1fsI+/wToa4Oe251Dy6m/iW1hVlmmx/Zk4mUpCtiKjfswFdA4T2X7dd
 aYx5xxpSSuxPUsmx2FY++DZYBVwFYhEHCyX39MJ4cAg4R8kBoy65GGqO4ga+xkr86Nyu
 gtgoSlLTnGgLYNdO5n1lUCEAGcWnTp9JXy798z3EWya2lMtV+QMEMotXbmZouh68Xsm9
 4QfzlXB7hE8mW63BfFUT4OPYX1DS5bIu1RvyTR0f+iOc7jqgprW99gS/VQJGdOeeCKuL
 8GLA==
X-Gm-Message-State: AOJu0Ywv3SFsKw41dgNDkWIs69sdH1SwvmcZdU9rA1JRGF/KU2+B/sEv
 wF4FYZH7sKbu525Z1JiROAkcdEXXZaOTQLUwl8Y87GdAjj/NeYjlQXI5QrP7ckDHTU0=
X-Gm-Gg: ASbGncsHI9nhHTjsxcQomDlOmsjT+YyaD5h1Y0A/Y0CgoiFxewXKgbhBXNaj/OfN5Uq
 ZcrKGqw0ZfMPNiIzVDRORAp4QOH6opI1r7WhJ22BkaOIfREE66uPKo3hfc+kCiRsbw3C1gbvYXd
 SbyYWMx6YXr0ORLgTrk+LEnQK/33LwvgXmwuo/NRJyhFOj3jKOjPKQSVtpP+C2EDjpmesmw4za/
 rvelzPaQe015nKdQJPZHmnhfavqArF1XA0JNkvUKh1GhRidgTENAs5Y2OyylLDCPWZD2JG4Qqi1
 FFL5G4cVww9HvOzFHrL4m3u3CwctmaxBYmvAkiCmBAdjXqLquooUtt2Iey6apTtO2yl5TPjUDdf
 vkBEOnCl94fCa+0gfI3Rhaz5psSPATJPxkA==
X-Google-Smtp-Source: AGHT+IHSTML+PxXjSEgLfHdHELb7NDLoGjhYCgMZpkhDOVUSGRTrmLT2RXXpL5cXEl079v19hqWB/g==
X-Received: by 2002:a17:906:7304:b0:b04:5b0a:5850 with SMTP id
 a640c23a62f3a-b04b16c46b0mr1128408366b.40.1757414377964; 
 Tue, 09 Sep 2025 03:39:37 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b047011daa1sm1469463666b.79.2025.09.09.03.39.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 03:39:37 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4754E5F829;
 Tue, 09 Sep 2025 11:39:36 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 1/4] tests/functional: fix infinite loop on console EOF
In-Reply-To: <20250908135722.3375580-2-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Mon, 8 Sep 2025 14:57:19 +0100")
References: <20250908135722.3375580-1-berrange@redhat.com>
 <20250908135722.3375580-2-berrange@redhat.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Tue, 09 Sep 2025 11:39:36 +0100
Message-ID: <87ecsf7vvb.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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

> The 'recv' method will return an empty byte array, not None, when
> the socket has EOF.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

