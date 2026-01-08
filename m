Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38643D185F2
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 13:12:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdpnO-0007fV-Eo; Thu, 08 Jan 2026 08:11:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdpnM-0007ep-0t
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:11:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdpnK-00082H-LA
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:11:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767877877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uACPJ3krJUuogeqFQ/FMG+kdPSn5YGZfGjsX3Hw0XBU=;
 b=eq/3xTcoPBeDu3qqSYwFNNNh2GpldPyQTAbxFkYgdlnJWAsgGMlpnxrZKwdSYR6F5hPd0G
 BjWUUvNPnbX4ASq9Zp/aDWlHaR4TmXjqAzj8G65QVG07LaHMb/1Jj2tToygNGXFfqL6gNK
 HwLh1XvXjUB0RU1MJjz9PNAHwxoHTUM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-H4epy9taP-SgW4d_Oq8RRA-1; Thu, 08 Jan 2026 08:11:16 -0500
X-MC-Unique: H4epy9taP-SgW4d_Oq8RRA-1
X-Mimecast-MFC-AGG-ID: H4epy9taP-SgW4d_Oq8RRA_1767877876
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-477cf25ceccso29459255e9.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 05:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767877874; x=1768482674; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uACPJ3krJUuogeqFQ/FMG+kdPSn5YGZfGjsX3Hw0XBU=;
 b=momTga1I2BL8NzajqUVfbH1bjEymUyZmsUJwYsWM/1edEu05oyM30riFjE7faBTszk
 hWO3hkvdIpxtrrr3EEVKxY8YZNXRjFWGAQ6hZhh8khpkl62IaHrAl9Eo63JKMrLcS2my
 eHBNbH2UoCotzULoEdytfILuIWolA14fTRJk3mT82RlefI4VqMnDkhO9UhQtjNjClOh6
 JC9XBb5S0qegs9zbUZwUM5jA0KqszZa+lOFPXkZW/BlzwsKSfamxz3Jy51sMHwjx/yhQ
 KQ0YqIyAXAYFxHqP4QSU9WWz+9aXNq9DxLX2MADGexJgJd+aUOSD+TDNjwByLqFloV8M
 XbmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767877874; x=1768482674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uACPJ3krJUuogeqFQ/FMG+kdPSn5YGZfGjsX3Hw0XBU=;
 b=DapvUQ6ZVX5WUOJOKt896qvtJRhg6KYekxG7ct5FTnPUJzrcUSlFAVH5C4soMb4qln
 QvtORaKkKWgmfAA4mvMq9yF5azRKL0NZl5RhATTtcPvlcS0Go8ADGBg2vyqs5LJVtbfh
 eiCBdma9MuJpR4lDhrYgQqZVsBf8tyzwLql09+fBsSspAd3F551RrGHbqV2nJRpaKm+H
 g9j6KAcOdqv/YftKSO14e7QGjLCfa8zoQO75wtkLR7lsA8OhHjkd4dnLZ9v9ITKJwBBP
 WOi36bCBiyGyYKaK4NuNGe9mGp9CYOYwjwps0HMA+l4hCjXCH7IXCZ7QKonLVkcITkFs
 oD1w==
X-Gm-Message-State: AOJu0YxCUK811C4MvxexLcGT/ltocsagTb7AN408Ggv2Z7IpEjLpu51T
 P+dLE3z5/BieS8ISZUrzn6Vc7kwF10Hx7SIR/dOX5nJyiPJ1b+XpTWA/npASdiyZGje+dKY8M4g
 JYDfeH+o7Ae7Kwbs9ZixB1AwXrLCqwhcAEws/WzirVK+2c3K7iEj7T8FeNPqogBMlMVFE7czQkI
 VZLawY8oYzIpLxEbjuwr7oO3uSJVQBjh1U3S4zbHwE
X-Gm-Gg: AY/fxX5QMGuoqh0+IeG39IEaNk9zJMLK7NphVMNo5rnjBt8hZO6lb4o3yckS5X9pdEA
 cjs6hwwAShqrFkQGbPLm18AecWjbQyMUMvfqeOFcfQJABofEy1c2NGJNN8mzitWVALIiNCrW//u
 R5bUq06jcAjyIMMfJWiezAJJwltvwrC0NIXwZRhUpJ5Za3aXATy4LCTwqxGlfT8LGdWHbY2HK8c
 D7GAHROCkOjy7a/0f+DNuoOOYMWFJ/NCZgmk+X+nw9nTs6ACKrh1TGUDrufMhcnMD1DUEoWkxKK
 KLiCi/6qD33ymCYsBAP6mv5hV6MXMcaP98JBDnWrgeV3j1B2Zqp/Awq7/iqFX7pE0MulkIBNmvY
 UL+tHKMwDcXUlKv1Z1zGB0t1hF7cB+92Nl0TIzKZtR1eDHjYzSr2r71zJhqroGTOisg3UwzD+Sh
 RIWxUVAC+eUI+FmA==
X-Received: by 2002:a05:600c:4709:b0:479:1348:c614 with SMTP id
 5b1f17b1804b1-47d84b41b2dmr72474625e9.26.1767877874433; 
 Thu, 08 Jan 2026 05:11:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzdn86O6GcGD3KNIx09WwJrMsgMzsGPd/wpZ83CXQPEcHNMRDuX6587bEr2jyIrHaOzHWwkw==
X-Received: by 2002:a05:600c:4709:b0:479:1348:c614 with SMTP id
 5b1f17b1804b1-47d84b41b2dmr72474355e9.26.1767877873993; 
 Thu, 08 Jan 2026 05:11:13 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d8384646fsm118672205e9.15.2026.01.08.05.11.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 05:11:11 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-rust@nongnu.org
Subject: [PATCH v2 10/16] scripts/qapi: add QAPISchemaType.is_predefined
Date: Thu,  8 Jan 2026 14:10:37 +0100
Message-ID: <20260108131043.490084-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108131043.490084-1-pbonzini@redhat.com>
References: <20260108131043.490084-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

It is impossible to call is_implicit on an enum type from the visitor, because
the QAPISchemaEnumType has already been exploded into its costituent fields.
The Rust backend is also not modular (yet?) so it is not possible to filter
out the builtin module; add a way to query for implicit type names without
having the object itself.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/qapi/schema.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 848a7401251..15f5d97418f 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -1243,6 +1243,17 @@ def _def_builtin_type(
         # schema.
         self._make_array_type(name, None)
 
+    def is_predefined(self, name: str) -> bool:
+        # See QAPISchema._def_predefineds()
+        entity = self._entity_dict[name]
+        if isinstance(entity, QAPISchemaBuiltinType):
+            return True
+        if entity is self.the_empty_object_type:
+            return True
+        if name == 'QType':
+            return True
+        return False
+
     def _def_predefineds(self) -> None:
         for t in [('str',    'string',  'char' + POINTER_SUFFIX),
                   ('number', 'number',  'double'),
-- 
2.52.0


