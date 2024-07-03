Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0459EC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 09:51:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOwdf-00082i-2c; Wed, 03 Jul 2024 05:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sOwdb-0007tV-2e
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 05:50:55 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sOwdZ-0007sr-3B
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 05:50:54 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-58bac81f3f9so2222945a12.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 02:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720000250; x=1720605050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4gUsmWvhKjuLT/ywSUQEYdSOTXaTrJgIDoLP1BvLGNM=;
 b=GXy+IbLfegxyU+BSJtd3LbiemsnSaZ512w5eDVil2a7t/WayACpoKcib8f88cVhqSC
 o0UhA2Oo9kZrMWx52fEC29f0wii1VgFfKNVRBMb+sZ+socU8X0OdDgEYYBzcR4rKZ1cv
 B1remKuIE5gNC1+9Ot2P7pvdtDbwIUh7P4HqPYVK3crMaRhxKl4EGvTuDYY0deA0ye9O
 KzmLa9QRMAy75Dtd9cHXLOE+pb9nUFIvG3IjaG9A5SFwZWqnTXGJNibEpLKW862H++fk
 Nh14O91Jku6VBRuyTO6EU6WQMyothiCYfO02l9ueYvHT9RfsMc7tdFi0rhnk7GMnXPRB
 qLMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720000250; x=1720605050;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4gUsmWvhKjuLT/ywSUQEYdSOTXaTrJgIDoLP1BvLGNM=;
 b=bFRo6aQ9Bs45UJDjdW0MGsgNieg9lgIY4OrIJcSm+dLCz8AApfVIQRdsB5SKOPpeSg
 Ag1tM1mWD9+cd0HgPCVx9RYWDMkpX3bR0uW2K6FJwgYZ+4/b4gd+ojzddkwYWULkrdUD
 WryINnsmi9LambnCT26wRT0aCdW1hHTd4MbWipcUAzzXC3XNN+vDNnB+qxa3T4uWcYJM
 QOmHi/nQHj8IkEkSf2I+/tIW+c0odKmgExkbqGq448mGvydkQJZJC7JUlqR+rdK1us4q
 xM8XRoNxwRyMxKhSCVJvmhEJ+dpp5h3etYg0VDZP0KUGPNrMqeBMmR8yTn9hnsJZRt7j
 sdJA==
X-Gm-Message-State: AOJu0YyytX3sdEF89kUcyNGG6cSrfv4088hoFRcVXIwPYb3LaFj9NwfR
 DBtlHo+YeYZSZMyu0ELhYJYheN53B2h9yZZoolmTAApE3N65ezMUTiZLrTfyZ9M=
X-Google-Smtp-Source: AGHT+IGQeYKCTMP5HpQhWKTbP5as9bV7s6Z1m31//F21ytjnfhY4jzbIhLtZMJzCreWTynXgoErjpg==
X-Received: by 2002:a05:6402:40cc:b0:58d:318a:508a with SMTP id
 4fb4d7f45d1cf-58d318a52cdmr486337a12.2.1720000249467; 
 Wed, 03 Jul 2024 02:50:49 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5861503b4c5sm6746996a12.93.2024.07.03.02.50.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 02:50:48 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2341C5F841;
 Wed,  3 Jul 2024 10:50:48 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  Cleber Rosa
 <crosa@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Wainer
 dos Santos Moschetta <wainersm@redhat.com>,  Kevin Wolf
 <kwolf@redhat.com>,  Beraldo Leal <bleal@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 2/4] python: Do not use pylint 3.2.4 with python 3.8
In-Reply-To: <20240626232230.408004-3-jsnow@redhat.com> (John Snow's message
 of "Wed, 26 Jun 2024 19:22:28 -0400")
References: <20240626232230.408004-1-jsnow@redhat.com>
 <20240626232230.408004-3-jsnow@redhat.com>
Date: Wed, 03 Jul 2024 10:50:48 +0100
Message-ID: <875xtmreh3.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
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

John Snow <jsnow@redhat.com> writes:

> There is a bug in this version,
> see: https://github.com/pylint-dev/pylint/issues/9751
>
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

