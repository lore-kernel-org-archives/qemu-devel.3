Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2CF6C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 18:06:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqFbK-0001Qw-Q5; Thu, 06 Mar 2025 13:05:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1tqFb7-0001MP-4v
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 13:05:29 -0500
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1tqFb3-0001Kq-TY
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 13:05:28 -0500
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-4750a85a0ddso9221cf.1
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 10:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1741284323; x=1741889123; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h1KmfNYxKGtGgHY0ymgELcudFoIW5QI3uHOLWnlpF6s=;
 b=1iG1enuw9QFhwOKRYn4gxLJnrAqmZNpD9Nv/gTzhpUXDoxsGS6sv8mkRvJTrP7Zmu3
 Svrs+gppPtY3j5rJqR/LAqpj816rsg/qstNu1t5b70N07RoDgCr+DOlahQkN3c3hR0i0
 ZWmxJ9UKFpJiJOdaFS1bWG45PUzlXurj0qE8rHHhgmPQ58O1t7Fls+orInrzIKiAzQnT
 rw0jlenNAihVpxzYxUGKJYmRRcb7jPfPrw9JoXk//G/7Kfyx9iRVtzm+sfoFqn20D/+F
 vfAdeltm7ze4YQ84cEz5GlAEEB50Rcrtdnu9BuOtikh4niAbnH8E1x+fBDP5jxSY5wPJ
 I8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741284323; x=1741889123;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h1KmfNYxKGtGgHY0ymgELcudFoIW5QI3uHOLWnlpF6s=;
 b=h/lBiS6TdGVWWysHTIGtoav10+2O9+UM3lizUWEgb+1h8ywtlMpT54v185woOGa6d2
 RMJouQkA0jMkIWt6Ee6eI+QymlhUfyiJTS9ulvacYUoGXJjeaYPnM+zI+Je2Xq/OHyF4
 YfPFaccC/hO43Fk74UCIuCqKjUiwWGrL5KVu4QHGc0NlJ+XQ+0hX0chfBO5qkJvlsIOd
 DtJ5aUF8kKAcPxiCxI3xataQj3J9TLjvlh2v8Gt0Ieiq/5R8kybMmcz1R5669weop9Qs
 EJEkK2Su7+a6XDokc/2qVrwUJOWdVHp/uQno9qd1qfg6oDBWh+1MJ2LzDbK8SAbzQYLu
 xwNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXukLOYWz1XNKxmSLbHnJuPMVfru3fG6Ja/BUfv9gENvNEnyAhPqAkdcdGT71XKjjC7UU5gBUQKcWin@nongnu.org
X-Gm-Message-State: AOJu0YxmTFqOxvSm7e7lgzeeq5PEx5LQwHlfgH9eUT59HY+Gw/oSibGE
 v9T1/o9wg80XMxBNV1ORqAlUyHvlAGBtvcwccv2Ya5RsOuFT7wYy3CsiYDrHsGCwSsuRKlinKQN
 RyHmzpTyle7uyNhsukJzInyKEsuLIoepWpRmcM6sgNI21Ng+kILKecaDLQg==
X-Gm-Gg: ASbGncuGLQJ/T+KGHqO8CHRcFH+BmytfO+6g4GHHMTjNn41OL8G3jniaXyJ6jC2TF+L
 bBmfTbYJeDXF3KcamBLvzstJxFh1qSV1YMRsgSmW19Xti1Wv3EqGOGesrVMhObmccLpaxKre/Lk
 G8Ko2IeDQLBzBebuoj9HBSitmwdlnzR2KlWhgA8lMBLtsJPJW+7kFXEj2Q
X-Google-Smtp-Source: AGHT+IEpy4SMpwB76nHg+z7VDp6WUm74+d6waQr2dvTOPmTwYXiGRL+tCxd8ielTaklGQDYySdNL7wYGs172OcuXoA4=
X-Received: by 2002:ac8:590f:0:b0:466:975f:b219 with SMTP id
 d75a77b69052e-4751b01835fmr5128821cf.8.1741284322454; Thu, 06 Mar 2025
 10:05:22 -0800 (PST)
MIME-Version: 1.0
References: <20250306000408.2088020-1-nabihestefan@google.com>
 <310205a4-15b1-43b1-93ee-d20d47285478@kaod.org>
In-Reply-To: <310205a4-15b1-43b1-93ee-d20d47285478@kaod.org>
From: Nabih Estefan <nabihestefan@google.com>
Date: Thu, 6 Mar 2025 10:05:11 -0800
X-Gm-Features: AQ5f1JpGZPV9LXpzx4PWq8aUBA-kLwPnlE8xRLaDyU7KkUm0YEK2oncUfEWo56w
Message-ID: <CA+QoejW15VztgKQ8f2a_ApA=P+eC70Et80pUVcd9rBR=j+cRAw@mail.gmail.com>
Subject: Re: [v5,1/6] hw/misc/aspeed_scu: Skipping dram_init in u-boot
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: jamin_lin@aspeedtech.com, Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=nabihestefan@google.com; helo=mail-qt1-x833.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
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

Hi C=C3=A9dric,

We have a custom machine and a custom image using the AST27x0 A0. I ran
some of our internal tests using these patches. They even fixed some of the
errors we=E2=80=99d been seeing recently!

I=E2=80=99m also working on testing through the A1 patches, will reply to t=
hose soon.

Thanks,
Nabih

On Thu, Mar 6, 2025 at 12:05=E2=80=AFAM C=C3=A9dric Le Goater <clg@kaod.org=
> wrote:
>
> Nabih,
>
> On 3/6/25 01:04, Nabih Estefan wrote:
> >> Setting BIT6 in VGA0 SCRATCH register will indicate that the ddr trani=
ng
> >> is done, therefore skipping the u-boot-spl dram_init() process.
> >>
> >> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> >> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
> >> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>
> >
> > Tested-by: Nabih Estefan <nabihestefan@google.com>
> Thanks for the feedback !
>
> Can you tell us a bit more about your tests ?
>
>
> C.
>
>

