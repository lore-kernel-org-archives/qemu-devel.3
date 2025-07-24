Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB70C83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 07:55:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueqmr-0007fH-3Y; Thu, 24 Jul 2025 03:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ueqmh-0007dI-Jm
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 03:54:35 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ueqmf-0002Xq-AD
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 03:54:35 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-60789b450ceso1302919a12.2
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 00:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753343670; x=1753948470; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T27osyQ2p4Ri8mGg1jnmFmmFTCjZyMOUjuM38C5sD4w=;
 b=gSK7pWSo5xyIQtUHVZhXCxARQ8in8l021S68HRFemZE0qz93bAHTBDiwf5zyJUwzY/
 n1Y1R19cuzSCqbDWPUGd06GqVaRNfPudqOqm5uS6hPbBTIpaPtcZIdqhlzk6LOpzlZ+R
 ovju+T6jKLB6QwbatNSiXdhFpe5s7jVoz0jI667iv9IXDYcMtvFsrWw2nH40JDZ1rZFk
 slIF4Ou48BusTJG+Ih3LDy3lic3Eua7Rs6zu6GcUsFqCPtZzzIE0zYmX8JQCpZ/8fZlb
 Dyq3LNfoVxsklBGolX4pxnCfvlTxII1SsBElunTEHb90zkWAm4U90ImfoRD0caqXGUPM
 gjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753343670; x=1753948470;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T27osyQ2p4Ri8mGg1jnmFmmFTCjZyMOUjuM38C5sD4w=;
 b=l1KHjHf+t5YHY8+3fQ9lJnp+ruNcuVahM7jswRwP7eJEHBMwW7dyaHVGFtB+mWed6w
 BFBkfVWuELxBU19oED3RMIlfm9Ud/1JRQBJIP4QVkyHfNbQLCqcpAGROB1DNBMjz5AEO
 MZFSv6ajn60UrVjM08TiYwoyo3TzMLTLJAQjLd4GtTZ/5zX14M3g0JrrHdHY3NP0j11D
 yDHEaLzfOwQo5em9oaUHJG6Wg+MQHGQpqzMDP8zDlFU3OjlJE0zSVbF1kze2GSwokaxJ
 vYzkkZGZH4LRVcVqwzrI7GVq0ktv35XSchWnU2WYj75PEAk77Ju+WBETrGQZnjwA73Rq
 f6wQ==
X-Gm-Message-State: AOJu0YwtpYdYHdDG7cnoPNIftyXXTNfZhNdz8Qy/fwyxPpZqe4PXpHqS
 lPQ0mBuniQhTjyK31HDglWWfKWFcTTnwDlUdHbFolYUr/69xm/D+TZ4KVXp8x3H0BU9m164W5wl
 941jOWJp+RzKUB/Ujx9jYW9kEA1P4c1MFAXboJUNx7qGcW2RgY9/Z
X-Gm-Gg: ASbGncvhZPvwSeLf6WJwzMNtVoRWKabzdPDGMsqrhpQBfVIupxazn6F8TYWNcqWnqGd
 u06UXT6URKe/b/kvY+1Pj1uWWMPy3revOTzV1lGPRgCCNhOJHxoHws6hzEsQ3sE3y6Bb1ySdR/K
 MlLGKb2TysjBgUQOmRTsmiyD08wPy2u4YS6N1AbRJxuUKMBwSBhSyTV0r1btF3wUApWx3wYIiP4
 tEf9w==
X-Google-Smtp-Source: AGHT+IEW08JpsIeVuCBLsC4DNK0QBVTjnX2Xcr46ptPQnbMEqbgF1iZWlhsdY8o8WYOasepn9tcyf9Jfk3/5qFzsdU0=
X-Received: by 2002:a05:6402:40c8:b0:611:f4b2:379a with SMTP id
 4fb4d7f45d1cf-6149b59d2afmr5601617a12.27.1753343669790; Thu, 24 Jul 2025
 00:54:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250718-functional_tests_args-v2-0-cde6e08bf98e@linaro.org>
In-Reply-To: <20250718-functional_tests_args-v2-0-cde6e08bf98e@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 24 Jul 2025 10:54:03 +0300
X-Gm-Features: Ac12FXyMwQ3vGpjCb7VCxDQre9vwSpCA2qJ8zp-khnIPEN3iyaOjVe3rhBEQvBg
Message-ID: <CAAjaMXaAbOjfvaWzxRDxsuvAVqNDyznfjQTQ2_E-kx7OKt9Y1w@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] tests/functional: add more CLI args
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x536.google.com
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

On Fri, Jul 18, 2025 at 2:04=E2=80=AFPM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> This series adds extra CLI args for functional tests, useful for
> developers that run test files directly.
>
> It depends on a previous patch that adds a --debug CLI arg, and is
> encoded as a b4 change-id dependency, so it should be fetched and
> applied automatically when using b4.
>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
> Changes in v2:
> - Fixed invalid -k value passing when -k was specified more than once
>   (thanks Paolo)
> - Link to v1: https://lore.kernel.org/qemu-devel/20250718-functional_test=
s_args-v1-0-54d4c6207690@linaro.org
>
> ---
> Manos Pitsidianakis (3):
>       tests/functional: add --keep-scratch CLI arg
>       tests/functional: add --list-tests CLI arg
>       tests/functional: add -k TEST_NAME_PATTERN CLI arg
>
>  tests/functional/qemu_test/testcase.py | 51 ++++++++++++++++++++++++++++=
+-----
>  1 file changed, 44 insertions(+), 7 deletions(-)
> ---
> base-commit: 3656e761bcdd207b7759cdcd608212d2a6f9c12d
> change-id: 20250718-functional_tests_args-12cdb5e56d84
> prerequisite-change-id: 20250716-functional_tests_debug_arg-aa0a5f6b9375:=
v2
> prerequisite-patch-id: 4ccc8f39ffb382d31c8e6450c43a5f8d177af044
>
> --
> =CE=B3=CE=B1=E1=BF=96=CE=B1 =CF=80=CF=85=CF=81=CE=AF =CE=BC=CE=B9=CF=87=
=CE=B8=CE=AE=CF=84=CF=89
>

Gentle ping

