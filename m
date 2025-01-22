Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09076C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 21:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taiN0-00061O-K9; Wed, 22 Jan 2025 16:34:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1taiMz-00060p-Pj
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 16:34:41 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1taiMx-0000fi-B2
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 16:34:41 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-38be3bfb045so983919f8f.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 13:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737581677; x=1738186477; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7tVTH9Wmd2trk9qSfOwNc3dpidL7AwUwG2cJ08ySHlk=;
 b=nBXuJfy/PUpJGT2tQPCemzF9LPHAjbWJTlwyRenuNlfNOc7e7OaZ03jLDs+ltfJ7h2
 oRj3o9tPfX9IrYZbeZVsmdLV8E638US4BKXmlGQCKv8dQRXnTWnlcJba26B1aVR/Me56
 6jpylAr6CLV0YYQLB2baHJa3AfkPV/7p2Aj/+DwIg9P+bE246bEHnb2kBUYMb7CCNLT7
 U4tcEvdK2b5mQlcUGADmmpkNWdtTOnHxzfnF75tRcidDmyonolBwgyT+gv77Et2KJ0An
 GHpYgx+7rAlZoXdbsX9kY3PkkpjyMsjnodwkwG2HX530idvMnyiVs+el5RKLothM3YGI
 zntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737581677; x=1738186477;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7tVTH9Wmd2trk9qSfOwNc3dpidL7AwUwG2cJ08ySHlk=;
 b=gLBOr9ErBzrHai8/V77S32IbwhFy/ZSCh80rMI/wq1FGnRRoCVLP/SWNgwstHf+bIS
 HAAo/zBU0VLsdQCw26hfMxChUfT0tAbOVEIPcFVQuiSF/IIgIUR8nr+lwF8dDaZi4XhG
 q17MOPlCJaTdOD7KsD3QXgnAb/qv0uIdcXsr6R3flnLcN3m0v52/+GmUX5c+i463o/M9
 VSHq23momSHXGhalJmSv2wjQqoXNNFy6uJklZl3Q+nVuZYA1IU2bhUlVpjbUdCgcVypn
 +QQhpKXW5lx2wfVccJsg0dSKDz0TT2YLsoKdxjGhzzXUXR0VqI27BRr/vqDJT56+3UC9
 qwLg==
X-Gm-Message-State: AOJu0YwGJLnaavTQrM2rVvCw64rofll7bdTH/MOLdeYHKClf95JreUDa
 qzTpYxhiYz+kQqQmVUgsHdfpJf4xDubrIScEkE09G8tXKNfYBzKtbTXT1f+XDwo=
X-Gm-Gg: ASbGncvIFH5jqUllki+7oXsLRUCKQDNQjVv1+BzFN7U6m0QaUuOsEJeZehmvWTPsFyt
 l/8OaJBv8+mLLHcHfeVMwexPiwOZkoRvo+eVv9UDsdLY56lHwJZ0ysvT25V/33oQYkB3sZW/dyX
 /Pf0W7UKF3F4LL+ItwCGunLJcc0sNRh3yuIexVZF9PhNHN0pPQdRemn4kJdpyHf9axjZ7wQyx6S
 hMASVBtrwvzPSq3KddnB565t28ModJxd6SLhEPuFU+JGhizmW5+aLYgRZvRtsTgjWOI
X-Google-Smtp-Source: AGHT+IF0PXzW1doUy5F8dCesz/U/hE2G+0ZW+yjvjUE1MLZIkTif2BN25ejSJJnCQ3lyt1hpnJJLsQ==
X-Received: by 2002:a5d:5f48:0:b0:385:faec:d945 with SMTP id
 ffacd0b85a97d-38c2226c070mr790395f8f.9.1737581677400; 
 Wed, 22 Jan 2025 13:34:37 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf3275556sm17656999f8f.72.2025.01.22.13.34.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 13:34:36 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1859B5FA4B;
 Wed, 22 Jan 2025 21:34:36 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 08/10] gdbstub: Prefer cached CpuClass over
 CPU_GET_CLASS() macro
In-Reply-To: <20250122093028.52416-9-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 22 Jan 2025 10:30:26
 +0100")
References: <20250122093028.52416-1-philmd@linaro.org>
 <20250122093028.52416-9-philmd@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Wed, 22 Jan 2025 21:34:36 +0000
Message-ID: <87wmemlehf.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> CpuState caches its CPUClass since commit 6fbdff87062
> ("cpu: cache CPUClass in CPUState for hot code paths"),
> use it.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

