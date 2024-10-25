Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA6AD149C1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 16:10:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Mp6-00065i-23; Fri, 25 Oct 2024 12:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4Mo4-0004uj-Co
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:05:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4Mo1-0004zU-Iy
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729872292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qVfnkITdEn2MeEyLCW+ZaeMcn0OTk4tm0g2ItZpiqB4=;
 b=TUuWDgI5wcoEXdLidEn98IzGFcIs5s2sokJFlhR/whHMFPK/CFN+v3C2HcXHDMcveMyI8a
 DNsOzYVBlQYLX6Tw9t7veh93pnqFmjro91W1Onz4+qhIynWsnN8+HnXY65RaKHwLrVlk2B
 JhWyQBw1ynDO7NEaS76DL/0pImbIIbs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-KA-g50cTM4-ESIitmzBNXg-1; Fri, 25 Oct 2024 12:04:51 -0400
X-MC-Unique: KA-g50cTM4-ESIitmzBNXg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a99fc3e2285so146514666b.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 09:04:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729872290; x=1730477090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qVfnkITdEn2MeEyLCW+ZaeMcn0OTk4tm0g2ItZpiqB4=;
 b=cAGkfOna1+Rjgg3MPxkqPl1bmU7F6aa9HKHdK+WkVfbsPfvOkTxIv/IAqDPrE4I9Xn
 KmJ0uMb9SCTnbdKvXud6c1hFEcSTiyxMa/h3UON1wPPZ/srs/EX/Oh/m3iaQT3jCuVao
 U/hBn7FwlZCx53kQistZ7xn/eZhMAvaSr7HdZAKH9Z49PjEYGbVz1219y9erJMwbYtdF
 2Ty0wSWLOWixpNizatyyPzjNWazBU1bF7vqMKPMlfNfGXF7tI0TgwvfwnkE5XKE6DK76
 WkTNR/tt0r+AGJTzDDqSXcyu2dA0Sdy8R7MSs3AnKbOT2WbvfrEo+RgCR3/AjqQ6F1QQ
 l18g==
X-Gm-Message-State: AOJu0YyNxD6hE0e6FFn/TgdqGXtW7h9/wdcL6MnJwgCAJreZfAfFV8FP
 cBhIsZWoYR4ux2zvfu1jmIpqciDpOyeK+fHMoxLBOGWnjOtgST9Q7aWhTHyTZEJgr1DvQeG8fCP
 0xnDZuZliKpJm/vpGC9URGsb5/R7MdhTowzeRqIxP8MnawYni8E3VAgUNXvF75vPqfQOkZpwCM3
 WxAJZuftkD17kDChATgz6R4uQoiHc+QlnjG0AxshQ=
X-Received: by 2002:a17:907:7e86:b0:a9a:3f9d:62f8 with SMTP id
 a640c23a62f3a-a9abf867613mr1005590866b.19.1729872289760; 
 Fri, 25 Oct 2024 09:04:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuJ0f1bm+cMXyzf1JkOSc/LB6RigVs1wTsRsdqwGgzzrDx3qGBky7YCgwWdxhmW01WCYO+0g==
X-Received: by 2002:a17:907:7e86:b0:a9a:3f9d:62f8 with SMTP id
 a640c23a62f3a-a9abf867613mr1005588066b.19.1729872289335; 
 Fri, 25 Oct 2024 09:04:49 -0700 (PDT)
Received: from [192.168.10.47] ([151.81.112.43])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b3a084ae4sm84618366b.197.2024.10.25.09.04.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 09:04:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, zhao1.liu@intel.com,
 junjie.mao@hotmail.com, berrange@redhat.com
Subject: [PATCH 21/23] rust: make rustfmt optional
Date: Fri, 25 Oct 2024 18:02:06 +0200
Message-ID: <20241025160209.194307-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025160209.194307-1-pbonzini@redhat.com>
References: <20241025160209.194307-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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
 meson.build | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/meson.build b/meson.build
index fb0295b312c..3db4dcc8a24 100644
--- a/meson.build
+++ b/meson.build
@@ -115,6 +115,10 @@ if not bindgen.found() or bindgen.version().version_co=
mpare('<0.60.0')
   endif
 endif
=20
+if have_rust
+  rustfmt =3D find_program('rustfmt', required: false)
+endif
+
 dtrace =3D not_found
 stap =3D not_found
 if 'dtrace' in get_option('trace_backends')
@@ -3973,6 +3977,13 @@ if have_rust
     '--allowlist-file', meson.project_source_root() + '/.*',
     '--allowlist-file', meson.project_build_root() + '/.*'
     ]
+  if not rustfmt.found()
+    if bindgen.version().version_compare('<0.65.0')
+      bindgen_args +=3D ['--no-rustfmt-bindings']
+    else
+      bindgen_args +=3D ['--formatter', 'none']
+    endif
+  endif
   if bindgen.version().version_compare('<0.61.0')
     # default in 0.61+
     bindgen_args +=3D ['--size_t-is-usize']
--=20
2.47.0


