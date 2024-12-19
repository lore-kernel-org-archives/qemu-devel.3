Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53091E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 22:20:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOOs0-0004Px-DT; Thu, 19 Dec 2024 17:19:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1tOOrv-0004Pe-Su
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 17:19:44 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1tOOrs-0000PN-EU
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 17:19:43 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43622354a3eso9300325e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 14:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734646779; x=1735251579; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=Bpd13/5GdFSVjNHRFyKX+774YaM7QfECr/XelYmgTGs=;
 b=NlGmuBnGNwdHRQgElTuDKrF+YVV12WNkVjneL2PMtxcwraIVoRDl/YxkgDj91Hltvk
 jguL4V17xJF53cMaAdnq99lwkbptKK3umjz9pv6u/Q0iLoaoS5n9ud5g4MAhae1IUCNX
 NALb7tRoxKszALCdhEfQRwYQ8L8V1uI3ofdRw7Rvhxuv2pgKGiOi+M258mFFcCCaLr1P
 HXt81y293hZZS6xw06KbGcPNQwCWD+yNGjeCRi2kpHcSq2EAHw3Nx5oJhzfMR/s2MGKz
 M6gVJMIhRWpkzkaLrx5OBcti0UkYZ8ZuHXDJbYyc00H/IdRz0zEVQYqB2/5zps9r3+8F
 ogCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734646779; x=1735251579;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bpd13/5GdFSVjNHRFyKX+774YaM7QfECr/XelYmgTGs=;
 b=QHgt2KUcj/ooyRzKT1RjJ7ETECnNoUorHKHMxlDV1UdwyLYuOkjtdQUT8MZn3eyake
 BzJLF9PSEQR/USVd+jm8PXKTM+GbHCxNNmSmLQAPcbIlnTfpeTdOMqTInfDDQH0YdWvD
 iF9+TNWnq4A6EL/SJtTrQyYwKv137exg8shhr6PhS8h7NgQgwt7Ko1nqjHbeoDASkmer
 n0MrtNRuPpL6ACcOXT17bNFVvvy+m0F/34by2T4EeTdZjrxplEqmDW/5wYFEzEvMHHSY
 dlFc2Mr3En3qmDSQn3AyYkwL8Wixsp4tglhKA5akSLPJMRbxK97DCYqz1UvZAF+5E2XL
 +vnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+HpyneeiIZQfi65TRfcQE7RrZJQe8K20YGVV0y8iZm3ZZPiv8ypCadhF6GDtMtZsCqc28CBi1VWnC@nongnu.org
X-Gm-Message-State: AOJu0Yyb5sNyKrIFwbiZkehympfFysseE+vm/ayOvq4ga9SLV8i8OE4M
 H8+8YM+dgShrnhJf4rTnErU8yh+HM5lCyfLyKI88It7qR7KahNvr
X-Gm-Gg: ASbGncuABatbuc/oJSRrJWf/NrzInr6OnWT40x5uiP3VJPASZ6BAlkGnfbD3UeuxzuW
 +JyU+cCXo1nAiOAGzSPXPD/G23Epw+PUYsanyhIaR8NvmXcfcJbUpHQe2AItWSDmTeBy5hkNNB0
 sdcPdCdwq+4KXT8DjdYSsdGHqV1MNqUrF+G3U0J0wa8Wo1k+RwLNfq81Roiimf3u2oG3zrl+fgG
 LzhXnwIBaOJHNHNHcx7uxhieu0rH2K0xoO5TqazpM9jsQz8Ud6vkc5/zQWJsyll05uTamcdPF18
 foM82AkAzHmtPrRIYgNbRnxX7HK9T7Y=
X-Google-Smtp-Source: AGHT+IHHap07XxAU6JIZXZzMCO10fAaVmR+1DbAK9gObWbat9eqfI9nosMKQeJnLyWLVs12D8zP6Vw==
X-Received: by 2002:a5d:5f8a:0:b0:385:e3d3:be1b with SMTP id
 ffacd0b85a97d-38a2220044emr579894f8f.28.1734646778478; 
 Thu, 19 Dec 2024 14:19:38 -0800 (PST)
Received: from [127.0.0.1] (dynamic-077-191-068-081.77.191.pool.telefonica.de.
 [77.191.68.81]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c832e8asm2465992f8f.37.2024.12.19.14.19.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 14:19:38 -0800 (PST)
Date: Thu, 19 Dec 2024 22:19:37 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] rust: fix --enable-debug-mutex
In-Reply-To: <20241219153728.460672-1-pbonzini@redhat.com>
References: <20241219153728.460672-1-pbonzini@redhat.com>
Message-ID: <2FC23C0C-F50F-4462-9538-A461653B8332@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32f.google.com
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



Am 19=2E Dezember 2024 15:37:28 UTC schrieb Paolo Bonzini <pbonzini@redhat=
=2Ecom>:
>--feature is an option for cargo but not for rustc=2E
>
>Reported-by: Bernhard Beschow <shentey@gmail=2Ecom>
>Signed-off-by: Paolo Bonzini <pbonzini@redhat=2Ecom>
>---
> rust/qemu-api/meson=2Ebuild | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/rust/qemu-api/meson=2Ebuild b/rust/qemu-api/meson=2Ebuild
>index bb779364cb2=2E=2E0c08d2e51f5 100644
>--- a/rust/qemu-api/meson=2Ebuild
>+++ b/rust/qemu-api/meson=2Ebuild
>@@ -7,7 +7,7 @@ if rustc=2Eversion()=2Eversion_compare('>=3D1=2E77=2E0')
>   _qemu_api_cfg +=3D ['--cfg', 'has_offset_of']
> endif
> if get_option('debug_mutex')
>-  _qemu_api_cfg +=3D ['--feature', 'debug_cell']
>+  _qemu_api_cfg +=3D ['--cfg', 'feature=3D"debug_cell"']
> endif
>=20
> _qemu_api_rs =3D static_library(

Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

