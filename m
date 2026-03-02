Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B6F1D58E7A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:59:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyzD-0004y5-Oa; Mon, 02 Mar 2026 03:50:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwywy-0003I5-3s
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:48:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyww-0002E1-Jy
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:48:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aEovutUanaTMVZLmJhDrriEKNRGQaiFuuqtZvfjvSwg=;
 b=GILCPwQ+oF2X68ueKZlIokOU3yCQMFAsMyVFyXzaVS2WqUNJ5yoKn7ljVvDFVsLSKc04Fo
 zGfBxxaCUS/B7VA2o7Z81p+ubsrnFAarHGAPJIWLXur5ao4LIJyWF3fVFXROTuLFV5VHEH
 t8cCPl980pjtTaZIC/ftPj6dX4Z+Xcs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549--6As2UMBOqu4fJmXZ0vc6Q-1; Mon, 02 Mar 2026 03:48:20 -0500
X-MC-Unique: -6As2UMBOqu4fJmXZ0vc6Q-1
X-Mimecast-MFC-AGG-ID: -6As2UMBOqu4fJmXZ0vc6Q_1772441299
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4837bfcfe0dso53826195e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441299; x=1773046099; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aEovutUanaTMVZLmJhDrriEKNRGQaiFuuqtZvfjvSwg=;
 b=RVuZcwn8UU2HX9NOA423r27YWgA0dhlLBjTpU+A4w0XrJSmBOLsrMQ4aCnYo+yFgmZ
 u+exxMKR/mc6pI4tCJjVIeL9raFDmksLgsGiZJkGvJnqE7dwH6+uw6TjJ/PlYsZ0tTKT
 o6EYh+GMvzPPfS3qVA+Hd6kw4f+OqaQDCGeqrb3DVlCc8osjC3RmQ486siKPA6mtgDzs
 fnGOorta22L1rahY55KLGfPYQj2emt2bfXboSwk855XfKBwK3Tp5EpuV2mnC85m32ISv
 5dKAXqC7K3+3/CPYphBtsFDyIMLUVxF2R0UEo2fwWHUvwl2gLA84h2gFvGErE2ZterhI
 tG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441299; x=1773046099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aEovutUanaTMVZLmJhDrriEKNRGQaiFuuqtZvfjvSwg=;
 b=SCliGYEbWHqMGKlF2mlFJrr3dWUmRGoeceRE1orPit8r0tI4bYjofxISZuO2jLeY+f
 UlglyobABWkwN1pqfgs1EXtdITRhmyKtYAxRsGv9X5cSSwfyTigg4tFnsd9vcTjiyGSc
 tblefmlxK07OFoTFs/SxYtDY9hkG2jBWe6k8Ng0GgJRo08918dOTvrIX7TBA+eAhHHLN
 yjGj2KNJ9N8LDGY3dkm7F+QVTZvWVy+vz7o0DwCfkP0CUjj0dk/bZH+s6Mky+wP8rTyO
 ij6yEWzp4z/ltBbaqjrAH5Hu1VPEc4n5G0s+GtBBdyZU65opN9mVPxDUKP0E3VjolUpl
 SBuQ==
X-Gm-Message-State: AOJu0YxhkGySvSGUZkjLiM+jcm+w6giqKpHQhv9AwxmysfoRh24RTGTa
 3ny5AcZci9QISbwTsJsQ/7p/rUEzNkg2vAq+6+yEoTOdfz64Je79s00l28ejRXExwZ4BLEjFDx+
 L3aySs9MYB30Vms0jPLTmHwyZQdEVXftdviWgzf6oqpqSP7hpXQMLifUgrgb13/M0/fKjaJEJ+A
 zGgcvezXWXNuBYqRGaxFJ+9lddnlZmvaneV4wcEE5X
X-Gm-Gg: ATEYQzwLq6Ao9rRC2KzbO+WWMPCO5qWYrGG8HGC2BoW3kL2bFPDPdY5EVjnK0LUui8x
 U91iIHOQWDQXgc5BiEzd7KBq9cNeEoroLj8btW7YqVuiJ9PCGIRj9HXPQOnbeiKcFDrO0k36I39
 CT84goEzfoDhHVAGsH+He5rod9na6LhvtOytsHs3DtUZbQ2+uoR7nXzG9ozUiYzyB+MuwwYR6av
 y1kygK+IYYWAOvgOathYfa+fmYrci1PQ7mQZclao46qkKsp1UoSHNN3+xlBiRPweBXRkyNRGuoO
 Oj6W9XQI+kD7xqaUSHe2pGTca60Ce5OHTxYjpzkZAV0Gh5+CA95uv0/6vRoVQZoL8jgpQD9NESX
 pUj/mLqh2EGepTOyj6cFJtXdfamarEEAAdXjLthemI2ykHwifhLmXs0f+LUtVYup5YTYiBB8n0J
 Kflzlgvy6q8KCodij6R+dAe+eqikw=
X-Received: by 2002:a05:600c:8711:b0:47b:de05:aa28 with SMTP id
 5b1f17b1804b1-483c9b9701amr226249425e9.2.1772441299160; 
 Mon, 02 Mar 2026 00:48:19 -0800 (PST)
X-Received: by 2002:a05:600c:8711:b0:47b:de05:aa28 with SMTP id
 5b1f17b1804b1-483c9b9701amr226248795e9.2.1772441298710; 
 Mon, 02 Mar 2026 00:48:18 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b03db76bsm11002060f8f.18.2026.03.02.00.48.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:48:17 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 078/102] scripts/vendor.py: add pycotap
Date: Mon,  2 Mar 2026 09:47:24 +0100
Message-ID: <20260302084749.474955-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Related to commit 5ec1eec11000ef118b2a87c330245ffaa475f5ee ("python:
Install pycotap in our venv if necessary")

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Link: https://lore.kernel.org/r/20260211-cleanups-v1-3-e63c96572389@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 python/scripts/vendor.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/python/scripts/vendor.py b/python/scripts/vendor.py
index 46ce2980d5d..78058183e4c 100755
--- a/python/scripts/vendor.py
+++ b/python/scripts/vendor.py
@@ -45,6 +45,8 @@ def main() -> int:
         "4b27aafce281e652dcb437b28007457411245d975c48b5db3a797d3e93ae1585",
         "qemu.qmp==0.0.5":
         "e05782d6df5844b34e0d2f7c68693525da074deef7b641c1401dda6e4e3d6303",
+        "pycotap==1.3.1":
+        "1c3a25b3ff89e48f4e00f1f71dbbc1642b4f65c65d416524d07e73492fff25ea",
     }
 
     vendor_dir = Path(__file__, "..", "..", "wheels").resolve()
-- 
2.53.0


