Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98972CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:15:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uraax-0007oA-41; Thu, 28 Aug 2025 07:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uraaL-0007XH-6L
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:14:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uraaH-0006Tq-EK
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756379660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XYu8JU564jljryyvQud9D5awkvjG3aBJFBzP1tkhusc=;
 b=aUOuuqjur0VAcUAJ5VXK5D3QqtCBbfG88NMLWE9SMxCFU85SKJ4dqzare+oWORvcQJx9PE
 uSwFXC5HdW9tYIu9koBlgEDqdiECAFusySKR4/x27UgkZvrovpVVF3i7L+HUGXIZvuJ42D
 YNn/eNs8msO635L5RYLL/k0kCRbq9vU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-K2-zz6B9NEqNF4Jsdv6z8g-1; Thu, 28 Aug 2025 07:14:13 -0400
X-MC-Unique: K2-zz6B9NEqNF4Jsdv6z8g-1
X-Mimecast-MFC-AGG-ID: K2-zz6B9NEqNF4Jsdv6z8g_1756379649
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3cba0146f7aso402162f8f.3
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 04:14:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756379649; x=1756984449;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XYu8JU564jljryyvQud9D5awkvjG3aBJFBzP1tkhusc=;
 b=Qh8PBZj415TKJ+8grONNFLznNxc4CRqTysX3bAJzz9hZ+JMOR3Jfft6d7AN1ZHTROc
 kHjlMFwzGwKcdFm/OPdtU8IvxVSA2hfKy6LVYiGyOMH95UmuKUpHaDAeDmU0UZfEEg8i
 OxtoNMegnrn56F30Rgd3PZiqARSbA7C3eLx1B4WD6gb7a0XzSDSt9Z8QJzbzzsKYAnE9
 nNN6eyeNHu/HV+OzTtGW7dSnfZ5KL2hxwOJkKz7D37kQVi+EcVk0EqM+Zy6ubshOUj2c
 Uzuum5mqFiSshtqxB9MWya40viJr6T3LBG2/huRLM9lrhS27AQSyBcTZjkZdjsrPY4Dt
 gQ2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqSaoRpUlb36rmU2/3foQCRb/M7QcpFb9ik90QLFjIR4gdDMP/h0cQLRxZgSMZhzWWJrTItqEX8d14@nongnu.org
X-Gm-Message-State: AOJu0YxVu2j6ANUdYaveFYXWyBHnxELeNlbdG7lqxzNH8hszG7Un4xWK
 sL3ezzJklG3dzxYqzjwO44ncoMmtzDFvlJmZ28dYNxIEl7cxZfRzQrmgsz+dR0U3K1FHQsfeif5
 zaBuuwBnkUmOuNorNqv3i0e/n//J/YH0B6mHEls0+AZfUNL2CUXEXN6OYBl9kK+CGjFoaV39cWF
 GbKRBRuWVcDzO1Xwc8HjAS/SwtHC2bYr0=
X-Gm-Gg: ASbGnctb3AwXs5wOA3eh5hCPibSMdqc0WAeGnj/I5IDmbEapHaNG01o3+XDet9UdjJO
 q7/N/hOkCoyMjA9/NomZVfdM2u44dWBuoa3IN7Rd9qhy79kftftKCC5gqO2I6KM/2dgOl7yfNtl
 +Qw8NKEbc6Tu/lc07k6DlfduS1F8mO3TPsrq9DDFOlSJEvu3QW27Ak6feS/nLk2rA+ojIRZegyn
 ETyv0no1bH0y9JaPJMbVqWX
X-Received: by 2002:a05:6000:40ca:b0:3ce:81d:6c38 with SMTP id
 ffacd0b85a97d-3ce081d6f97mr1794163f8f.29.1756379648887; 
 Thu, 28 Aug 2025 04:14:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQJsYZOI5RJM8QpY61MuGOK/Kx+TVWNNvGiJpl0gUDsby9Pw2dJRfvMZUWUCqQzQzdgGbnH4zJBrfJgnsfOq4=
X-Received: by 2002:a05:6000:40ca:b0:3ce:81d:6c38 with SMTP id
 ffacd0b85a97d-3ce081d6f97mr1794140f8f.29.1756379648465; Thu, 28 Aug 2025
 04:14:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250708204806.1898-1-shentey@gmail.com>
 <87c791c8-accb-40de-9ed8-d86bd179dd47@linaro.org>
 <ef55eda3-fc4f-45dc-9f35-6502efeec381@redhat.com>
In-Reply-To: <ef55eda3-fc4f-45dc-9f35-6502efeec381@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Aug 2025 13:13:56 +0200
X-Gm-Features: Ac12FXzlalTmjGtgF_-uO80mPtMvqX6w_qWGsyiXPwctbM0vDzq8FM9oSJrbL8o
Message-ID: <CABgObfYETqXrVNxs=FEg1=O1MAZsQ2Diib7-rL_Wyz+39pnsVA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] DTB build housekeeping
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Aug 14, 2025 at 7:15=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
> > Being not familiar enough with this meson fu, I'm only queuing the
> > first patch, being a good fix in its own.
>
> I queued the rest for 10.2.

Unfortunately this doesn't work because meson doesn't want to have dtc
from the subproject and libfdt from the system. As a result, I need to
add dtc to the containers, which I did, but then I have failures in
macOS and FreeBSD because they cannot use the libfdt (from
respectively homebrew or ports).

In both cases, dtc and libfdt should be packaged together though. For
macOS, I even downloaded the dtc "bottle" and checked that it has both
dtc and libfdt, but libfdt cannot be found.

So, the "simplest" way to get these patches unstuck is to remove
support for bundled libfdt altogether (and add libfdt to all the CI
environments).

Thanks for your understanding :)

Paolo


