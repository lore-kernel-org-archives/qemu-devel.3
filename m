Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 287DCC28B2E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 09:41:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trZck-0000j9-5Z; Mon, 10 Mar 2025 05:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trZci-0000iH-T5
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 05:40:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trZch-0001Qm-EG
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 05:40:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741599633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tmHJxcFEh1mCYGlFaYkTPG9EB1Ca7iOETAPsywJY5Uc=;
 b=PxmWAwgzjDjN7dTdJcrUpEJlfH5p3x7xytX+g05cNLYBLcojknFJhmtygKCPtp2Fqqj0jf
 YxQd4FAsPvqVMYzqCgPsNiFX7YHq0pL8UH3rH2oZSX4FhfKWqENV09RUy1FHHh/Akq3m4l
 LVTZYAfeywbb7BD9knl52HvSBxqIv2U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-0fLw6ybXMwKtKQ4F59RoeQ-1; Mon, 10 Mar 2025 05:40:32 -0400
X-MC-Unique: 0fLw6ybXMwKtKQ4F59RoeQ-1
X-Mimecast-MFC-AGG-ID: 0fLw6ybXMwKtKQ4F59RoeQ_1741599631
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4394040fea1so18810535e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 02:40:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741599631; x=1742204431;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tmHJxcFEh1mCYGlFaYkTPG9EB1Ca7iOETAPsywJY5Uc=;
 b=uKVcIo11e6sxE6p1bjsGQE2awaRBmwA+moD1McOK/hcCWVy4PpA/9Lui1OHCzq7qxF
 drfGEuK+R6PNGqBTviWShBH1tqylbD8Q8Kqbt8EwScwOee+8OPMAVS9NqpPTpBWsXy/a
 KVNMF6l3pryxuaxVL4je8jau+dKb4bOJcbrUlPOcZUt7txLzZMW9kW7CpAYW708Ts3/J
 DWD0uWJuYTczVMs9mrIvPuy6ZSlLGqJbDM0PC5Jz2bfnJhfZFeTrkyd7Goerj+67fD1Z
 64vR8Zd8RSAmsREn+IhiCtYhNetoFrHg5VJGu9yHDuR9afXBjg+7Lgh9aMmmrapHfLMo
 hLsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVG/VKAk+M14U241hiHg8QML+lsUPJ2ruhfnrotFYoibNuEDswE8nMoJshkrhDrwhQk38meBex5D71u@nongnu.org
X-Gm-Message-State: AOJu0YwMGfHn6IgChJfjSnNHeBNqvqF1pIPnbo7swyiWI1jbnAHbjJPH
 ugADFc3LzpKhg8dAMMVJAMRNkXiYR7mWPyg42kBhz9wCpRSghCo5PA96VG64APdlvSc7ZNONHq6
 YDkWPIiwZLECVnUB2MBFW096+KBmXS65PdYkTECjk6GgRD++42mAbEkoBspmYvNa7qZSOFisSoo
 1ARIM+jAY6nI7nteUywyuzaE6bEA0=
X-Gm-Gg: ASbGnctqCw0n7e6dOoJzv7awpDaL9RHtgAa5gd4encXsWpD3iBNiUo/qxjfYUi3tdd/
 3eXBL+pGbpnKOPeWE/EkmMrj4qtVYEDCvZzyLuBQNtsIQRwSINvmaH+oaJQu11abfA0vUBtW8YY
 4=
X-Received: by 2002:a05:600c:354b:b0:439:4b23:9e8e with SMTP id
 5b1f17b1804b1-43ce4ab02eamr53337105e9.3.1741599631040; 
 Mon, 10 Mar 2025 02:40:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7CaPMMGzDZlld1SXT9851VkaXhrciPGHpJyPGEGV7kDWaYqRL7tlM+RkJ1Uff5ZsmvcQUST0OfxOAMsawnBQ=
X-Received: by 2002:a05:600c:354b:b0:439:4b23:9e8e with SMTP id
 5b1f17b1804b1-43ce4ab02eamr53336995e9.3.1741599630720; Mon, 10 Mar 2025
 02:40:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250129082045.1319203-1-pbonzini@redhat.com>
 <CAFEAcA9=G4sdXrxWcmq9wMqu1-ZRNxObQD3hmnFauYwiQr_8YQ@mail.gmail.com>
 <Z86v8Y70sGThWb_V@redhat.com>
In-Reply-To: <Z86v8Y70sGThWb_V@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 10 Mar 2025 10:40:18 +0100
X-Gm-Features: AQ5f1JqE_EJtHsDcLYrqTIo9M39ZhXOvT9g86e4DvDv8JT9wrzpfsP65WKVSOSI
Message-ID: <CABgObfbuj3SbqpDkUnKux1EWCudiksQxbWr_4Sck5tTLr5QqeA@mail.gmail.com>
Subject: Re: [PATCH] gitlab-ci: include full Rust backtraces in test runs
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Mar 10, 2025 at 10:25=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
> > This will only add the rust backtraces when the tests
> > are run from the CI logs, not when you locally run
> > "make check" or similar. There's probably a better place
> > to put this...
>
> Meson's  'test()' command accepts env variables, but it'll be somewhat
> tedious to add the same env to all case where we use test. Might want
> to define a common 'testenv' set at the top level meson.build and then
> reference it from every 'test()', unless meson has built-in support
> for globally applied env vars that I'm missing.

It can be added to add_test_setup().

Paolo


