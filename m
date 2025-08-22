Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F49CA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 13:48:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upS6v-0001mx-8z; Fri, 22 Aug 2025 09:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1upS6q-0001md-0r
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 09:47:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1upS6g-0003sk-OL
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 09:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755870418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=aYUI7WCHmlia3Yql7Y7DBmlq2WOST6tJVNOXgAbyF+A=;
 b=gU5U+Z4uY3Rk1Ot5KMuRjBC61rVDE2d3kc64QZ2SAmJvihbK2LL6qdbN+xlv3/JwUyAICJ
 9g30dz6Km44bRZAXOlJBu58txyO0tTdOq0U4syijkXa0k3WQ7VZWSU1M6CzhQx9QeXBN+K
 1mK/PXV26PBvTIdc782rtZU8woNfdto=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-QoMS3Ps-Mlq88rux8xVAKw-1; Fri, 22 Aug 2025 09:46:56 -0400
X-MC-Unique: QoMS3Ps-Mlq88rux8xVAKw-1
X-Mimecast-MFC-AGG-ID: QoMS3Ps-Mlq88rux8xVAKw_1755870416
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45a1b0071c1so10530145e9.0
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 06:46:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755870415; x=1756475215;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aYUI7WCHmlia3Yql7Y7DBmlq2WOST6tJVNOXgAbyF+A=;
 b=KZN6lw6C0jykyClL/vwld6gBaau2L/P7AC9Rl9QzVp5WQHwxqr4xXSviCoTUCVAkTg
 0BOUIArSpJl90lhlCe50II4zmzZHJxh+St7SuaSEkaGIDspM06lwYCnzoupnAFrudGOi
 FJlQyfSUVVWuip5Ij3hrDyOtYJ1LrraT+MX2jR/x+FoIwavc6qRYr57Bm5Gl70Dx3EMv
 sJX8MU/EI43FnPSLsbG8iwUQ23S0llGSjsbvbDYIvbx06bQh3Hnd6O7aVIPsMLdLGRZz
 7jLAb4QWBS59Cw4BYE53J/Q7jcTu2AEQnN4cb/Qw/q2JKInjytTrO8Dkt6nWmUuX+7hJ
 py7A==
X-Gm-Message-State: AOJu0YzlKn409Wpg1O+woXxRkFh36gEk/b2DYlBgMMh5mvDTZE+H2bPS
 ZkKLsvp1Njj0LDWHcsA1AsS/aUWWl9CswoTn/AVT9uUtDqwmyDj83E6nqi7PSZPGNi1lAQup06I
 lz35OkdGS09Ddx79Q2qy+DW9ocWQQhXszC3NkGl2L352AUkBmCfveVPwnYg+XicQ1x9ntd3M59W
 vvHHew1u51DYjnj3Wk1s1VLF4f0hidQ/YjS3grx7Pw
X-Gm-Gg: ASbGncv5mHw2oZgxOy7rKrMYDoF4Xa52qEnR8w2U/vA09XyqI89UkW4M/tN72c3OTBW
 18Cq+T3Y+sCHn0vICFcL29/oAXOa3I/YoxCpQjQyKhBNEYYjoALmGRnxjFQrYHDmYnvTa8iGrAC
 yVIVRx+llGUwZXwbmlOiAsnCN8RveOD9U6G95yJUx62Qm71mlxpV595sJm9p0eB/+lgoThoKBBS
 OLvy1aqcm/rbezn33x/cfja/QF0o7jB5AaYXehxqug5te1c/kbrd2KF+ce6hNjbgVR8JCbmgf9Z
 0WCcBLtbLgEKBXLVDyCHlNCO3cSMLzL4BNTpPB9eZLa1N9hajSMpNDL8dd29s6azXMG6jyE5m09
 T8Pc/ZNN8JmquESu0w7hVrT4YYkpdynjZuFpcGq7pQw==
X-Received: by 2002:a05:6000:2891:b0:3b7:6d94:a032 with SMTP id
 ffacd0b85a97d-3c5da73f498mr2189326f8f.3.1755870414728; 
 Fri, 22 Aug 2025 06:46:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7Ji3JnpkerEJGrM+z4Kx2hw5Sf0Id8I6Ug09Y2Tfqh+lwp14u6liE4y5Osf3zVIsZuGzZcg==
X-Received: by 2002:a05:6000:2891:b0:3b7:6d94:a032 with SMTP id
 ffacd0b85a97d-3c5da73f498mr2189303f8f.3.1755870414306; 
 Fri, 22 Aug 2025 06:46:54 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879864sm15904509f8f.13.2025.08.22.06.46.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 06:46:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	John Snow <jsnow@redhat.com>
Subject: [PATCH] python: mkvenv: fix messages printed by mkvenv
Date: Fri, 22 Aug 2025 15:46:52 +0200
Message-ID: <20250822134652.1366100-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The new Matcher class does not have a __str__ implementation, and therefore
it prints the debugging representation of the internal object:

  $ ../configure --enable-rust && make qemu-system-arm --enable-download
  python determined to be '/usr/bin/python3'
  python version: Python 3.13.6
  mkvenv: Creating non-isolated virtual environment at 'pyvenv'
  mkvenv: checking for LegacyMatcher('meson>=1.5.0')
  mkvenv: checking for LegacyMatcher('pycotap>=1.1.0')

Add the method to print the nicer

  mkvenv: checking for meson>=1.5.0
  mkvenv: checking for pycotap>=1.1.0

Cc: qemu-stable@nongnu.org
Cc: John Snow <jsnow@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 python/scripts/mkvenv.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/python/scripts/mkvenv.py b/python/scripts/mkvenv.py
index f102527c4de..9aed266df1b 100644
--- a/python/scripts/mkvenv.py
+++ b/python/scripts/mkvenv.py
@@ -184,6 +184,10 @@ def match(self, version_str: str) -> bool:
             )
         )
 
+    def __str__(self) -> str:
+        """String representation delegated to the backend."""
+        return str(self._m)
+
     def __repr__(self) -> str:
         """Stable debug representation delegated to the backend."""
         return repr(self._m)
-- 
2.50.1


