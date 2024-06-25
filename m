Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17347C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 02:33:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLvyj-0003i0-CI; Mon, 24 Jun 2024 22:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1sLvyh-0003h0-Fy
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 22:32:15 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1sLvyg-0007u3-00
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 22:32:15 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1f70ec6ff8bso60125ad.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 19:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1719282731; x=1719887531; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dxrBEQgedvq4g+dMHdBs0Prn1g4DmCljVDvrNprqzTA=;
 b=21gyRqg4nhj6FOh7hHwqCsIJE0gv3NPS0fA2iK2jPM6ykLUuyKxtnIhfWefxR0KTlP
 AN+QI1eI5aWvEb3xniCidUPOM+M0Caa8G83YEFxL7qOyYYPcwH9qtnd7yjMJWJTbmV+4
 agctwrGvfW3iCUkb/8nCQy3s0G5XVVSRPCG94FN/qvBj4/lUJnkWf5Ssnm9MN9PAi+Cz
 RlvjVtdYHP4CZJoy5X51Hyiy5M9ujSnrSF9YcvQNWoN0nuV8N8yLuFUF2seH6dh2h8t3
 TaVM9z9Tzg7Z1gWZJ9VOzn9TKae2lJGvCB81Z2i0DySY0+Q0pqwpgaem8R+rdGvIyOuq
 c0Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719282731; x=1719887531;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dxrBEQgedvq4g+dMHdBs0Prn1g4DmCljVDvrNprqzTA=;
 b=Mf/BPXxUtqgxO3meknSXAhJ0hXihMVIJt27Yt0VhWxe8Xh1ARTrmDx1bSnCmkgcZr2
 AFfsTv78vVW53nYtY2lS8MtknJ2KQxNDsYN/MMNjr2I+xJeGDG18Pv1s9uHmY6qN61/i
 1MLwbXxTrj3gZmJCeJTctb7zPQe5+m/UekukwwA8Tcj7LgGxi25v0zB2Zot2ZzDtaoe3
 okq/lPBXfCWEUtUWuSA/wsI7JcQlb6A5iTGVql7dSIHcwpH5K3+iYfgCHdK8xn+yGcbv
 S/TMOSntAXjs2bm/dZb0/T87fC6fdLl9gDhn2zYgIKdQRt3YCIEqYyUasTEc1emsHKKZ
 KCEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7Y9Ck+qJp/kWiqKq2Pw2swZ+xtZa10dvFGy/gAriutEBVJZfWYr9wyaFP4PA1vXJeuF/65HCpSp+OEeJWV2o2Z+blfQM=
X-Gm-Message-State: AOJu0Yxe2AlY29zXjmhUT8CXckoZTJ0HfJ/LPE4+yvthCrnnh4vH5G8G
 nPhx1eP2R1vQI3u2Ir01IVVm+dD7wlMyAj5SmxOjlga2pWcPQSxhRKrZPwIWYNwVtlydzTM11/F
 2LFP3yN7s37T0MAFzoS4N1Qow+NvZJTjsFyUd
X-Google-Smtp-Source: AGHT+IHh9bDierBYIaNMnMsdYuK1gwWIcm4O2nKoelh0vnZnUloGl+Y9ZjHdIwdIX1GVkztAlUmzfPjoRZo6+qtsbgo=
X-Received: by 2002:a17:903:288f:b0:1f4:d21b:6149 with SMTP id
 d9443c01a7336-1fa6ca1fa23mr1055385ad.7.1719282731364; Mon, 24 Jun 2024
 19:32:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240624205647.112034-1-flwu@google.com>
 <8e54bd41-9a7e-4b1e-ad99-33de1615374c@linaro.org>
In-Reply-To: <8e54bd41-9a7e-4b1e-ad99-33de1615374c@linaro.org>
From: Roman Kiryanov <rkir@google.com>
Date: Mon, 24 Jun 2024 19:32:00 -0700
Message-ID: <CAOGAQeq0b3_g80k5xa-6f+XPkv6C=nfMLkJt=X3-6FD_d3sJUA@mail.gmail.com>
Subject: Re: [PATCH 1/1] include/qemu: Provide a C++ compatible version of
 typeof_strip_qual
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Felix Wu <flwu@google.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=rkir@google.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -180
X-Spam_score: -18.1
X-Spam_bar: ------------------
X-Spam_report: (-18.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.453,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Hi Philippe, thank you for looking.

On Mon, Jun 24, 2024 at 7:27=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
> In particular this patch seems contained well enough
> to be carried in forks were C++ _is_ used.

Will you agree to take #ifdef __cplusplus  and #error to the QEMU side
in atomic.h and
we will keep atomic.hpp on our side? The error message looks better
when atomic.hpp
is somewhere near.

Regards,
Roman.

