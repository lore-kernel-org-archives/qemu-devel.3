Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E090E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 17:21:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVZkG-0008CO-Rn; Wed, 08 Jan 2025 12:21:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVZkE-0008BD-NE
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 12:21:27 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVZkC-0005Se-Ed
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 12:21:26 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5d3d14336f0so10408872a12.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 09:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736356883; x=1736961683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dnxgSEkG4KV9+x/d/BmwTJRhjB94gpcSPLQ6ZWPmJ6Y=;
 b=KxVY08ri0XtvpIdRT6WhlV9Ro7bYNMWmCdlDIQNvz4EwKQkcfEWx+CltGHW4NcLz3p
 eSKC2su2/nWcGwz/YMN02tgdYFcQYEvpGmpgegIgYrUsjRKIdizp3nWSC7U2klm00EUt
 rDsfcwE7tqb32PQJTU6yz3jOdrIEgrtvEAdUDD05O/SiRoVHMZs29Q/0q7p2a0ZfP3EL
 wGyrBZT9Eer2zUb2MaPpYP9e0290qgKqyeWu/O2pGUnx7MtV12LhpxI2SNsGCruWJO8b
 kV0b/TDutmTGMrEmboSb73ohcr83QrCf0Xl7Nq1K0pUIPaQz/ZwPrP5R84ERfKM9gsay
 oGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736356883; x=1736961683;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dnxgSEkG4KV9+x/d/BmwTJRhjB94gpcSPLQ6ZWPmJ6Y=;
 b=m3wl4/8i0kfg9qBM8SEe0VrJqFdI+94FMxaF/o8m5MGm3ZhsfGdhejoIG2YIcpOMq1
 DVbG9ERdI2eQKHAZWDbOTvsDdJIBAYfqzgA1s+ib+/EciN2CaseLTEe982ppgiveDWKI
 +iBeJWya5PGYK49BfXlHJ0F7WzCakNc2WIQFuX7oHQqaI79xUMVVpXCSCEUj/1SnKW3w
 0Znfoh6UEKGduue3y/mEwEVlkhyBML1rB5mRZPnCB1CK5iSMuLkaNbq4i82M8PphiLYA
 LMrpLgipqeHtDW8LGHJLA+/0wUCSVlwqtPRTAl0Om/IhPoHjSL9DMigPH2ND4s4cNA9a
 M53g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+IvdJmY+fMg8rxRjTGp8SVk2a7tI3B4y6hvL1NHu6yecvJxbHP8wkszDctrc/+OpCR0ZVRAcRsSpx@nongnu.org
X-Gm-Message-State: AOJu0YxerqmjtKtibyJRTFXBiVFMxdwFHs7U0VHy/wP/SgtenWP6ZjXi
 hjm1JqTuHnQJGQrhaIGm+7DHDXovZuuAyw1r2cDN+5J5Pf2DX8QYI2uv8SxdlX0=
X-Gm-Gg: ASbGnctwkfw02Gq14DOlJ6TULvaQIu56iinJGEqZwHpHmM0x5yWSPO1uCqfYCXlzr8V
 3fnBzHzekyMOXnVZURZMSCGKtkp8cTi7xGilHXRof0kg6CP9rnG/UxJh7StUYS35IDPLBQLvE06
 W+dvmwBSx4j7Nfb21hCYuax8Q9F60vR4nOvfKAlrtYfJodxTlGPeUwwxvGZfmgjuyUH0u4DIl/U
 q1cY5w00Dv4ZQNLDFPnVQ0KtqX7Q1fD4btPW2YSfFOIosyalTHi/28=
X-Google-Smtp-Source: AGHT+IFndgNT8+F0MK2jtyXoW+Vs9xygfV0uNFF+xC97H2AH3i8sMnZBpBK+dofc3zQC+ml04sebtg==
X-Received: by 2002:a05:6402:84f:b0:5d0:d330:c965 with SMTP id
 4fb4d7f45d1cf-5d972d28da9mr3284643a12.0.1736356882968; 
 Wed, 08 Jan 2025 09:21:22 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d8baa29afasm15022656a12.59.2025.01.08.09.21.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 09:21:21 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 39AF15F8AC;
 Wed,  8 Jan 2025 17:21:20 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Warner Losh <imp@bsdimp.com>,  Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>,  Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Kyle Evans
 <kevans@freebsd.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 7/8] docs/user: Document the %d placeholder and
 suspend=n QEMU_GDB features
In-Reply-To: <20241216123412.77450-8-iii@linux.ibm.com> (Ilya Leoshkevich's
 message of "Mon, 16 Dec 2024 13:33:25 +0100")
References: <20241216123412.77450-1-iii@linux.ibm.com>
 <20241216123412.77450-8-iii@linux.ibm.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Wed, 08 Jan 2025 17:21:20 +0000
Message-ID: <87o70h9q7j.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52c.google.com
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

Ilya Leoshkevich <iii@linux.ibm.com> writes:

> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

