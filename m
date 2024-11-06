Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11FC7D44D42
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 10:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8dG1-0008MC-NS; Wed, 06 Nov 2024 05:27:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t8dFz-0008LP-Lj
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 05:27:24 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t8dFx-000071-0j
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 05:27:22 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5c984352742so7952461a12.1
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 02:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730888834; x=1731493634; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UnTHeVDTU+WUKoHgKPgKiaAKXCx5otbVlpqljeqLliQ=;
 b=PbdmqboOggrPMZBS+tnWhVpkkqQyXhuoqHoHO4o01j/8Vmnx8jEbpnMRdqSq8gRBes
 WKr7ROgMBkiFec16uAcKUq5jiQxvTOD3elOLVUUVhxD7LetkZoOTSToXW8RV9AuwPceB
 Lq3MmlGCGIzNGjC4YudI5muB3K33VZP+9d+uCGNLs+WNID+6n/v7KSaNJ5nmv/5Y7/8J
 Bd2qDBQ8/nN2t2PfF/xkJCxy6T1jiiJ+Cb/J31oGyzacKRYsAcXdsW8I8XugmLj8UegY
 EkFbYi/zuGUgoQP5tC7Fxa5b5GtTpIw4XJDQ4tfeODbng5kRxMtveqOn3dT/ZLvS0Tz/
 CEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730888834; x=1731493634;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UnTHeVDTU+WUKoHgKPgKiaAKXCx5otbVlpqljeqLliQ=;
 b=taQfdcbHBvSRAR5CIz3hVFdMUtlgiG0B9bMTzmHE9Rl5YXAlHlz/BqPuqlVz3qGs1M
 2nxFMMwKL2TBaXkjd5yf3+JufbH56vYry6uYZ1MAqFOzMBmj4Eu24CVo4FHya4yPJhVL
 zB9CkcEGCGo6xZWi/8yNq+IFiTE/FZ7lREYIS3iPwYCDLRd5oc/TEkkDcGszFcnE3J81
 Sm3W4IB9bOmcY2H3iWkarOB4dGTQ7TwgEGDzzBu4Go+ul+efviIOk5N29xI9dxUSS7IT
 PgyMm/0g1/BHojmjOuSWps4nxVIYHokmrD23rpxegv5GbpuIjsQzitqQ1UZt8ZWozxjt
 LtwQ==
X-Gm-Message-State: AOJu0Yzp99i2ARs5UU4nQtmg1Hd7ChIwzJr04b6Xa4zMHpI5M4+QuiZ4
 +joypNCmBX9TQ904IITWsHm29oqtY+UcPIpSsPb4dnshDtvKSA8+6Aua6zkHV/E=
X-Google-Smtp-Source: AGHT+IHhxdPqS9iAtR/FkIxOgArMfEBnViUGJ45oR5Uf3MQhchVJW4K7Krn9Zd58Opr7qggQ4GqCKw==
X-Received: by 2002:a05:6402:849:b0:5ca:e5d:f187 with SMTP id
 4fb4d7f45d1cf-5cbbf8b4f45mr33498331a12.17.1730888834291; 
 Wed, 06 Nov 2024 02:27:14 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cee6afe425sm2533035a12.59.2024.11.06.02.27.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 02:27:13 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6D77A5F8E0;
 Wed,  6 Nov 2024 10:27:11 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Wainer dos
 Santos Moschetta <wainersm@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2] tests: refresh package lists with latest libvirt-ci
In-Reply-To: <20241105162002.359227-1-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Tue, 5 Nov 2024 16:20:02 +0000")
References: <20241105162002.359227-1-berrange@redhat.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 06 Nov 2024 10:27:11 +0000
Message-ID: <877c9gejy8.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
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

> This updates the libvirt-ci  submodule to pull in various fixes,
> the most notable reducing native package sets in cross builds.
> Some packages were mistakenly marked as native, rather than
> foreign, in libvirt-ci. Fixing this causes our dockerfiles to
> pick up the cross arch package instead of native one, thus
> improving our test coverage in a few areas.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

