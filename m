Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA12DD1039A
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 16:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Mlm-0001Rq-W2; Fri, 25 Oct 2024 12:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4Mlg-00012b-Kx
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:02:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4Mle-0004lZ-W8
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729872146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/I8P+Tgh/EAn+u3w8+IqULH94EfyesPkxVcOlTYfu04=;
 b=YzL3+4OAQA98lTBgkcFiKHzbnCOkpv2KLkxDdjnkxKPhXPAUT9+B4MogcLNtk4Arki652w
 vflsg8LGyYsAQgjjYRGdsbvAGqrAyzoEQnNwGQAacWeN9AXcPGM7tdKV4fZxkfKDIE/KI2
 9bBXBtdhehNM7VYgcMBy7H9KBilKRyQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-vY2DUq66NWuI786Jo_ZkHA-1; Fri, 25 Oct 2024 12:02:24 -0400
X-MC-Unique: vY2DUq66NWuI786Jo_ZkHA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a9a22a62e80so163728366b.1
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 09:02:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729872142; x=1730476942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/I8P+Tgh/EAn+u3w8+IqULH94EfyesPkxVcOlTYfu04=;
 b=r/lEJhi1OLPODToPaY2XPRmH4sxrPVWR877jDPDV3LVvpRxCJQblGk3z4tNHpfPyCV
 iKrbOhK8ObP2MchBZnejZzTDHM3sj/ZxOJmNtquZkvgRHtBzcis+xjAA4irpxFGZwvrC
 J/Kd6mP/T4vER+h+DhuTk15RfN1IoyXjWPShG0VVuitPMPUBXi9VWptMxr96DDEkY/ZZ
 wPs7meOVMLtpHkGAcwCC0L68Zri9IrwDwX4GFCybZQ3PonqXAKZkd37kwb+iQkabbpvU
 HtjAqLUfeiFVt9soAjXao0L7KBnkMN8G4FIAFY5Q6UBwY4dxa/vA+kk49W90GHPiQ27Q
 ub0A==
X-Gm-Message-State: AOJu0Yy2bSzGfunjk4yAYLGg7KkYjoqiKgouusigM4sOFHYDuaS7jGnF
 RhyqqKaM+mFtZGotoKaOYSWrYE70ZlV6gJGf3ZIDibjY6X0s3lC5EiKB/TSCNxuuS2qP/ye/KdO
 t6/ssZKZ5OySXHYGZ5yK/ZfEYATxHz5wSQx6SJK4GyoF/vCXKXZJ99Nfc6EJsYi6Lf/DfKgZJAs
 mkd5nQpI3dCrhprFngKLQWmz+CBlVXWDNUUd+Krvo=
X-Received: by 2002:a17:907:3f1e:b0:a9a:161:8da4 with SMTP id
 a640c23a62f3a-a9ad285f285mr623455566b.55.1729872142330; 
 Fri, 25 Oct 2024 09:02:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9A+WR7gQD8FPzzMqXXrrkVK681k/tGh3Sza9ZGt95DpvEmjkrf34QT/3FiecCFHjQLIRiOA==
X-Received: by 2002:a17:907:3f1e:b0:a9a:161:8da4 with SMTP id
 a640c23a62f3a-a9ad285f285mr623450066b.55.1729872141824; 
 Fri, 25 Oct 2024 09:02:21 -0700 (PDT)
Received: from [192.168.10.47] ([151.81.112.43])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b3a086de0sm84191566b.218.2024.10.25.09.02.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 09:02:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, zhao1.liu@intel.com,
 junjie.mao@hotmail.com, berrange@redhat.com
Subject: [PATCH 02/23] rust/pl011: fix default value for migrate-clock
Date: Fri, 25 Oct 2024 18:01:47 +0200
Message-ID: <20241025160209.194307-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025160209.194307-1-pbonzini@redhat.com>
References: <20241025160209.194307-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device_class.rs | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/rust/hw/char/pl011/src/device_class.rs b/rust/hw/char/pl011/sr=
c/device_class.rs
index 08c846aa482..9282dc4d151 100644
--- a/rust/hw/char/pl011/src/device_class.rs
+++ b/rust/hw/char/pl011/src/device_class.rs
@@ -29,7 +29,8 @@
         PL011State,
         migrate_clock,
         unsafe { &qdev_prop_bool },
-        bool
+        bool,
+        default =3D true
     ),
 }
=20
--=20
2.47.0


