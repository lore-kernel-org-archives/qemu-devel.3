Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35AADC44507
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 03:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkCaN-00054E-RL; Wed, 15 Jul 2026 23:16:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1wkCaL-000546-PX
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 23:16:29 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1wkCaK-0002ss-8o
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 23:16:29 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-845b6d9bf39so135630b3a.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 20:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784171786; x=1784776586; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=J9SHSHGaMDhzEdYig4rHjyeCc5RdRtng5d4klL7ZpBE=;
 b=noaaYp8gu63nZxsbBdO7mQG5Op3Jv1qsxIYM/Eekd3e2BGg6QXnd3sHeHX0J3MyDVN
 YjJGWbjlr0TIag5pTbWK5vuyJ09hLUwHIcwSfZvLrVCMhqRGFwLsHpQCRBdpVeb1mQqI
 BTX4fvJDzN+zZPFacbQzo8/QguY2gHTs+RgM9nR/w6uN63ftzo5aW2pip2MFddU/p3G+
 l27VZorRdXRM8fBmCx7DPO58iyLgr997kAb/JvXHqw0jk8hIKyYegvnifX5aMQcP+Oc7
 TTdNzycPBEBwYk+BL/8GsKCNeDyQAgWz9GPxAVkqRmsp2NJNQ+SS+28Iftizt3vu4AV7
 +LcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784171786; x=1784776586;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J9SHSHGaMDhzEdYig4rHjyeCc5RdRtng5d4klL7ZpBE=;
 b=b3FQmQqGC1hsu65UAlA4BmUkeDRIpsg5QClGDDrAGL/UUrd3W4KQpxRsArD1vMx2kh
 leBvALUtny8T8sJ3Qk33vyFVpFsPWl7kv0XcJvMAUl++dBF9thHX1N09x/MVHlLbpopG
 JZPfa/8UHIqqhz8FvsHj5auwY3XphOfN4is4kY7e480uIfan1SbFm93N6ahxy96grV8E
 ZXGFrdi2UvZLyIrcZXnG3efNKmwOBYAbm8NVBOdvMYMdlQb10fb82eqDS2LNAcfVC24U
 tTHIt+w6IqD8f+nA2p2QZKiAep1/lYCLLR25MmOhq+zCf6fydO3bFAuAEIH7vKTLz+2K
 Havg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpPKgIQWWD59Ect5jfEutAUNiDnegG9HD73YD9SybWBmCq/QxlwYWHAB67gadmkUSutI9mC4AsgqyZ0@nongnu.org
X-Gm-Message-State: AOJu0Yw4AdPqQUoPqms6CXJg41pGVhDlZQoawdGTtYMad5WrXw9Og8ap
 JpBz44Yg2vloPsg8nMjsYAizk+VQRg2wGHpdK60R2XgmbnHkf8g7aX5l
X-Gm-Gg: AfdE7clqO/6eiaMj5RlaIp+XISTm7K+ZMapaeh74pI4PWYFghIfqxuwX3plb69FFNs8
 59X4uKJjJwehN84e4RK5nJHP8iL2vYIyK7aAosMW3coO3M94t+Tp/BleUv3FhQuxN9g18EsCrdF
 cF/9eAFDISVfk88o2LhRNcxittiQOz9E8ai5h0YA6vIWki1qCjI6R1w24vjUxMruUbBs6H2Be32
 +uz9hEtUrTTs0+ZN5//9z0E2aXi4oYHXkML9jsobW3gI8NbhUlP7k9P8hvTv4vtRl6I12mULty9
 /K5Ij+9W58qAtm4NtG2rqgN7hagqWA75kAgWxfk4FjPPZf8M3gwE/h8KTtuPRQvjtqKfqTYqvHE
 jQTsOa7QbIlcfaEW6HL58h0FPmGJvWxDdfFY7IBSahJBDnKlP3jp4BIH/JypePS4Iyl1F1rnZHc
 Lp6+HjI4Mrgf0=
X-Received: by 2002:a05:6a00:12e5:b0:842:446a:4cb5 with SMTP id
 d2e1a72fcca58-84be686c3c1mr784326b3a.0.1784171786323; 
 Wed, 15 Jul 2026 20:16:26 -0700 (PDT)
Received: from [10.239.152.184] ([134.134.139.77])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84a4f23a600sm4082818b3a.6.2026.07.15.20.16.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 20:16:25 -0700 (PDT)
Message-ID: <821c7aa772d03e29991c35e75d312c71bf64894a.camel@gmail.com>
Subject: Re: [PATCH 7/9] contrib/gitdm: add more individual contributors
From: Weifeng Liu <weifeng.liu.z@gmail.com>
To: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org
Date: Thu, 16 Jul 2026 11:16:22 +0800
In-Reply-To: <20260709080040.4157324-8-alex.bennee@linaro.org>
References: <20260709080040.4157324-1-alex.bennee@linaro.org>
 <20260709080040.4157324-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=weifeng.liu.z@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Acked-by: Weifeng Liu <weifeng.liu.z@gmail.com>

On Thu, 2026-07-09 at 09:00 +0100, Alex Benn=C3=A9e wrote:
> I'll only add names explicitly acked here as its quite possible
> people
> are using different addresses than their company affiliation. Let me
> know if you want contributions mapped to a company or academia
> instead.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Amarjargal Gundjalam <amarjargal16@gmail.com>
> Cc: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
> Cc: Tomita Moeko <tomitamoeko@gmail.com>
> Cc: Julian Ganz <neither@nut.email>
> Cc: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> Cc: Roy Hopkins <roy.hopkins@randomman.co.uk>
> Cc: Phil Dennis-Jordan <phil@philjordan.eu>
> Cc: Jackson Donaldson <jackson88044@gmail.com>
> Cc: Weifeng Liu <weifeng.liu.z@gmail.com>
> Cc: Roman Penyaev <r.peniaev@gmail.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Tanish Desai <tanishdesai37@gmail.com>
> ---
> =C2=A0contrib/gitdm/group-map-individuals | 11 +++++++++++
> =C2=A01 file changed, 11 insertions(+)
>=20
> diff --git a/contrib/gitdm/group-map-individuals
> b/contrib/gitdm/group-map-individuals
> index 178b393b8c3..42bee15d933 100644
> --- a/contrib/gitdm/group-map-individuals
> +++ b/contrib/gitdm/group-map-individuals
> @@ -46,3 +46,14 @@ amarjargal16@gmail.com
> =C2=A0me@sean.taipei
> =C2=A0kosasihwilliam4@gmail.com
> =C2=A0philmd@mailo.com
> +soumyajyotisarkar23@gmail.com
> +tomitamoeko@gmail.com
> +neither@nut.email
> +ktokunaga.mail@gmail.com
> +roy.hopkins@randomman.co.uk
> +phil@philjordan.eu
> +jackson88044@gmail.com
> +weifeng.liu.z@gmail.com
> +r.peniaev@gmail.com
> +linux@roeck-us.net
> +tanishdesai37@gmail.com

