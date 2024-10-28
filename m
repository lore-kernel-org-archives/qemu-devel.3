Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63261D1359C
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 12:27:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5Opo-0002Qo-Sl; Mon, 28 Oct 2024 08:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t5Opk-0002Nh-Ml
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 08:26:56 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t5Opj-0003k0-4X
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 08:26:56 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-37d5689eea8so2870984f8f.1
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 05:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730118412; x=1730723212; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uBs5xDk4TGYtQdob6XEzJ6YA3qTpXTKOlDd65gE5D2c=;
 b=Tvyk0yUlsbL5pXhoBijIdH+bXAwl9Zu+APaMAT77A/OZF5Zlcg283agrE6i/haRYGu
 4ad2hPbqS6X4r+y8pxWZpJ9428S/IlN/N2iZpe98XMhgtg7UMX5GP/1nBJkio7zVzEhr
 6p9pbsdWKUUx0RzsQrxXqlrQkxoStflpTcYRr652Z3wE0S4WUzgYnqceacib1SMPcodq
 FWDy5XGyKT/em0eoaDN3oyHOI7+sbtmOJiEUrbZQHao+sZu6jkEfDXit2On7ncipdeKf
 5fBCTm3/qsbYlMtU8/3NuNOM0DiIzC8yK11TqgEeK/tAFa2xBEKu3wwOq3Klkzgt+7Db
 ex6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730118412; x=1730723212;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uBs5xDk4TGYtQdob6XEzJ6YA3qTpXTKOlDd65gE5D2c=;
 b=TZI3T4oLHUJrLjVIdbh74J1JYT1tbM9OsTzcJgAOD5hMURL32L0wvmRgOG1G+PMDN3
 g/nJ/Pp5dXSkB1txvRu7TrEEPs37QCqO3RmMXdPBW0oIJBmoSlJ4sFYOdqHP4QOdvM7b
 PcoUcNbP45DyfJP4eQpuaWq25f9vdYyO0x1xlieBUxbOQ06QU1jTudztPcWkNW2UUauX
 swLUv/mepfrjupTyrXT0c8vUfdyWhmPjveHUggcbEPKsxg2ivSYcZks+TEQgTE/38haN
 6a4ulexOXELch0gPjoun+cKICzxBJiBIaJz7zusKYxk0Ty1qXsLazm4nK+RjfbWB/RPI
 k6iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmf6lSG/KISXRDUtL43C5+n5CfDekKLxU2J0zL80CE8Cm4lQeD8pQQhcs9noyB8Edh3Zivp9MlLELB@nongnu.org
X-Gm-Message-State: AOJu0YxFhzZryHpSu3auTymOhN0ss7X4j34Xe5ScQFHEM8CDRdH4ngEh
 mNmpYK7d9JtmUA+chz3xtn0yMfSmpmGhCqBTChgBbv9KziShp+6bplNo8UWRjKs=
X-Google-Smtp-Source: AGHT+IHo4Z1T/Ivd1LWi11KJ+CWGtOEwlMrnE3rzvTwrnhxRGobBoZzu9ndMxIi8T9oztwdzSrmg0Q==
X-Received: by 2002:adf:e6cc:0:b0:374:c640:8596 with SMTP id
 ffacd0b85a97d-38061172331mr5561969f8f.32.1730118411872; 
 Mon, 28 Oct 2024 05:26:51 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058bac1cfsm9353511f8f.109.2024.10.28.05.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 05:26:51 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 702B75F8C4;
 Mon, 28 Oct 2024 12:26:50 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>,  Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org,  manos.pitsidianakis@linaro.org,
 zhao1.liu@intel.com,  junjie.mao@hotmail.com
Subject: Re: [PATCH v3 00/23] rust: fix CI + allow older versions of rustc
 and bindgen
In-Reply-To: <Zx9XbxxA5iXmfVWC@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 28 Oct 2024 09:21:08 +0000")
References: <20241025160209.194307-1-pbonzini@redhat.com>
 <95b07b6b-0980-4a32-86fd-602985750104@tls.msk.ru>
 <Zx9XbxxA5iXmfVWC@redhat.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Mon, 28 Oct 2024 12:26:50 +0000
Message-ID: <87h68w8lbp.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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

> On Sun, Oct 27, 2024 at 10:01:26AM +0300, Michael Tokarev wrote:
>> I think this is the wrong direction (ie, backwards).
>>=20
>> Sacrificing current code to be compatible with old stuff feels wrong.
>> Especially for really old, like rustc in debian bookworm.
>>=20
>> bookworm has rustc-web (and a few related packages) which is regular
>> rustc version 1.78, just renamed.  It is regular bookworm, not backports.
>> It has some packages disabled (compared to regular rust) and is a hack,
>> but it exists and can be used for now (dunno if it is sufficient for
>> qemu though).
>>=20
>> Also debian has backports mechanism, which also can be used for qemu -
>> I can try back-porting regular rust (and llvm) to bookworm.
>>=20
>> I think this is a better way (at least a way forward) than trying to
>> move backwards.
>>=20
>> But generally, what is the reason to support debian stable?  I understand
>> the CI thing, - we need a way to test stuff.  For this, I'd say a better
>> alternative would be to target debian testing (currently trixie), not
>> debian stable.
>
> The stable distros are what our community of contributors are usually
> using, as few people want non-released bleeding edge distros as their
> primary development platform.
>
> Custom installing latest upstream pieces is not a user friendly position
> to take. Occassionally it is unavoidable, but it is something to be
> avoided wherever practical.

At least rustup makes this reasonably easy for the rust bits. We do rely
on the excellent Debian backports for getting QEMU quickly into testing
images but I was assuming we would have trixie before --enable-rust
became mandatory so I'm not too worried if bookworm is the outlier for
old versions.

>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

