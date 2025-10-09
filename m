Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6AF0CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 08:26:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6lvg-0000Os-Fs; Thu, 09 Oct 2025 04:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lvY-0000JM-HU
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 04:23:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lvT-0000Fd-2X
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 04:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759998178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/HK56hU6PxQGlIwFZ3eOYR0vODaeLa5uXEYxsn7DXJw=;
 b=OoVNVqOZFDOif0R7AgDxIsnWiZb1XpBpWmcyQhuBVuwdLWFo/h/e5t8W2ij8d9+3QCn5bJ
 YE8hOz3hSpyGRtsz26zzbM8ym6FQDpSfuQDmWmTJIDLg4+b8mM8Ae758Z3SqgL0ebOqDwr
 81J/NzGxCXpJ7DyHsp5hrt4GYNjHBS4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-ealUis0APWGqd9UFRDuRWg-1; Thu, 09 Oct 2025 04:22:57 -0400
X-MC-Unique: ealUis0APWGqd9UFRDuRWg-1
X-Mimecast-MFC-AGG-ID: ealUis0APWGqd9UFRDuRWg_1759998176
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-42558f501adso689578f8f.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 01:22:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759998176; x=1760602976;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/HK56hU6PxQGlIwFZ3eOYR0vODaeLa5uXEYxsn7DXJw=;
 b=eL6Ejd3XfFxj5GNsPjTM/2iAzCqBbW+RsuAehbYA018w1JIirWzST73mM7km6JyFUA
 mwDMuGY4JJ6rxLB+JZ/GrNyObgyoaT5PjzuvExq5nkV9MJS+EqqBSZvRpFIbLR6FMNCl
 oyPYmwScCbJKCZCC+C3E32kERJQ2CTm2juRuC99v7zIPh7DLF6dQR/yxDHBxqrLWn/2O
 I+1Y5MQhGej8U5bq4ur60OEn0ouYhe7g0Zh9zKHDDdgpWVr8FhifdNpVh42d9LEefPdQ
 zE9V4gb93A7WQo1O4lzl8SdzfOLlt+UBgc0rInWRiv9cS4NZ8wFSNkz2czUcKpAyCpPS
 7q2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTD+EJalCgTBnTfjf82J4T/42NLLyltuBiXW3oLkPjqR4cvPo0cBusw4djrTffhzzfJX3Li3i48hGN@nongnu.org
X-Gm-Message-State: AOJu0YwOPOgLhMcJzKWFXhXGGP71M84uTmuOXPP+H1haTcxhf+nDxBbZ
 Eqfc1Q32sdyCq7g/89A/fhXv0q6EHpVjiRLfggESoQWkQPD678Wx+U68RTlomQDYLcUh/tGjPTn
 W+LnUHqk+AUtSsP3lf8Wg+yp4xf+9pdhuO4QFBFariHcJ32TuW7VZo2ZWT+BRTrB3/O7KVBiIjH
 hxJ8/9OR0bi34lxpmjixCbjcYjWd5Q3+s=
X-Gm-Gg: ASbGncvv5NjNDlNN6Q+fKWHanun0khEQr+F2rJM+aMTHwCxHhZ9+VDFLW5wJyJrzWYp
 JbW9qgOolfS1lDeDpj8w2ucHgMCTr5dKYR2cIyKF1gRmGHjoYWpum9AKq9x+ZXUNCSVBRcEmcbt
 wMOi1SIc44VGiAe7LUb9q69n9n39ldtXXFntdRS5d3Q9J53IonDZljzNt8uN9avHmWeIH5UGPmc
 btuGU103TNGsFy6EyT/RiVsrSgD6A==
X-Received: by 2002:a05:6000:2dc9:b0:425:8c14:1de0 with SMTP id
 ffacd0b85a97d-4266e8e6dcdmr4315813f8f.61.1759998175803; 
 Thu, 09 Oct 2025 01:22:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYZgXaCLzwnxXLID479VwlEQj3n3rHF/1T3HijojrFWCoWhkAFDnOM5vOSoWJrrpClrcmizJwGYuaX5NV+TYY=
X-Received: by 2002:a05:6000:2dc9:b0:425:8c14:1de0 with SMTP id
 ffacd0b85a97d-4266e8e6dcdmr4315800f8f.61.1759998175416; Thu, 09 Oct 2025
 01:22:55 -0700 (PDT)
MIME-Version: 1.0
References: <20251008063546.376603-1-pbonzini@redhat.com>
 <20251008063546.376603-3-pbonzini@redhat.com>
 <20251008175811.GB181748@fedora> <aOdpofyFVoYVQc3D@redhat.com>
In-Reply-To: <aOdpofyFVoYVQc3D@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 9 Oct 2025 10:22:43 +0200
X-Gm-Features: AS18NWCvnJcPbhXzlp5Alp8wEZGAAKNTdUtGYBhJOzGqdocyEWuQZ3bQ7khrY7c
Message-ID: <CABgObfYx8V+mUm-1eaimMeBmXyFiiBLBKWNc23_+HFXXFFb5sw@mail.gmail.com>
Subject: Re: [PATCH 2/6] tracetool: apply isort and add check
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Oct 9, 2025 at 9:52=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
> I've proposed removing them in favour of meson rules earlier
> this year:
>
>   https://lists.gnu.org/archive/html/qemu-devel/2025-02/msg04920.html

I mostly agree with the intent of integrating tests with the
configure/pyvenv/meson infrastructure, but I'd do things in a
different order:

- split part of scripts/ into contrib/scripts/ to identify one-off
scripts vs. what is really used in the build process

- move python/scripts/ to scripts/venv/, adjusting python/tests

- move tests/minreqs.txt to pythondeps.toml. switch from pip to mkvenv
in tests/Makefile.

- unifying the test scripts for all of scripts/, as much as possible

- integrate tests in meson, but keeping the shell scripts for now.
move python/tests to tests/python. add a custom_target() to do "mkvenv
ensuregroup tests"

- move tox usage to .gitlab-ci.d, placing tox outside the configure
script instead of inside. this makes the QEMU venv a "child" of the
tox venv rather than the opposite, and allows more testing than just
running the linters

- remove testing-related parts of tests/Makefile

Only then I'd look at opportunities for unifying all the settings and
moving away from the shell scripts

Paolo


