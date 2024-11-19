Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F533D4922B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 16:38:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDREp-0000zn-Ln; Tue, 19 Nov 2024 11:38:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tDREn-0000zR-1k
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 11:38:01 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tDREl-00036d-KE
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 11:38:00 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a9a850270e2so655133866b.0
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 08:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732034278; x=1732639078; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OH/cNwo8Xg/I1iSyVmLaw8K5ntTnn5UGtdLXgXdpc60=;
 b=m6LyDh2UX9Y1D74vAXUjYFbpj/2ytmoTk7mJ2toB0g4h/QHP9BzI7WQY07D+8hyYwL
 +rV31yjNdRTMT/VQgXaEvcaR1q7SFPY445zaEJfsrZDmsxetJgMeN804E9J25KH07M9H
 vswsu+FNEutqA8CwxUMjWZLrwDkZg6ffyhesVcfPwdPPI/B1L2e05OTSKNcDwcT9mKkO
 PdRRKIX0l7T7ToHcEjb4i8XZLWuTUp1kk+cbSTLape3u2KsROD9ij6xC5VUWQevBoG6U
 m9kgWBnVhMHT3coC2w+FFRkPJCqfGGAKFYeU+Lls9Tsz5URhJwn5hj0H6k48Y8YPRvl6
 H4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732034278; x=1732639078;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OH/cNwo8Xg/I1iSyVmLaw8K5ntTnn5UGtdLXgXdpc60=;
 b=JyFtCE1UpMiw2i3GhMt0foYoOmlYPsa0NmnTJNh3esYpXSRDQqMMyxabbA8aoFvVPD
 CBkB2jW137of47FjlyFDUQ+ejjEM1HZ4enEZ+3dklHhv83oLfcfigtv6JSHlUE8PH8NC
 SqnoUBFABwc05oOTlw5mK4+NWutOKBi4L/afodQY5uRdRXhAlQ+NDBOGOueQX3L7g0pW
 mP+qxP8WSVZQn/Cp4wwq70C0BuHNkRc2N+DM/ZNane06z3mAWR1m8ib4eC/giNwa8+Cb
 w2vfIMooaMzh4pyy732WREfUdokFosUy20YTSKuEyo3G8ZMm2itUZ2CGAGkFZxNYCx32
 EFtw==
X-Gm-Message-State: AOJu0Yw4WObcPudSwHqGOJkI6eFp6xSdlKfbP7Xp0ST6NCd+xU0uUSBA
 J5ydNizUhU5tJ3T5HyjI84v0eJUI+nb26wzT8E/QvOynFcedoThrjsyNn/8/z69toLECkzl6uPX
 r
X-Google-Smtp-Source: AGHT+IEw9pTtSoJzKJj3hDXdhJLH20OW4JZBGX+Q/7dc9y6FGWDxeDC0cvuVkxEAFTFg7O0Pz6FScg==
X-Received: by 2002:a17:907:846:b0:a9e:c881:80bd with SMTP id
 a640c23a62f3a-aa4835286demr1187323066b.37.1732034278040; 
 Tue, 19 Nov 2024 08:37:58 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20e045390sm665738466b.154.2024.11.19.08.37.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 08:37:57 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E23CD5F716;
 Tue, 19 Nov 2024 16:37:56 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Ani Sinha
 <anisinha@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 05/15] tests/functional: remove leftover :avocado: tags
In-Reply-To: <20241119150519.1123365-6-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Tue, 19 Nov 2024 15:05:09
 +0000")
References: <20241119150519.1123365-1-berrange@redhat.com>
 <20241119150519.1123365-6-berrange@redhat.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 19 Nov 2024 16:37:56 +0000
Message-ID: <87y11fnpqz.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
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

> These tags are not honoured under the new functional test harness.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

