Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B300FCD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 17:59:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRw1U-00027f-Lk; Tue, 26 May 2026 13:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRw1S-00026S-JV
 for qemu-devel@nongnu.org; Tue, 26 May 2026 13:56:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRw1Q-0007zp-G5
 for qemu-devel@nongnu.org; Tue, 26 May 2026 13:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779818215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8gANO1dHY/McFEVD+OLbOHVJl89l7bOu5SWe3UKWw+s=;
 b=e8JNOSc3xLizmHbBb/kleWYeIskD/UoNEFIjEFXWzSfsiIGIErT7IRxHbkUyxDd1BoEEYP
 bBpNnuTqOdoZ9tVYeesBO3bUD4H/KJMx++nnV1WJZ7LAv3e3ZqETvNQdQTPomVR1tfwzEd
 pDTxX/SlZpIT9YZ++6cxEQ4YU2k4UI8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-o8Dxr3FuMGGs9xxV9w2g7A-1; Tue, 26 May 2026 13:56:53 -0400
X-MC-Unique: o8Dxr3FuMGGs9xxV9w2g7A-1
X-Mimecast-MFC-AGG-ID: o8Dxr3FuMGGs9xxV9w2g7A_1779818212
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48fed2519daso50325825e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 10:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779818212; x=1780423012; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8gANO1dHY/McFEVD+OLbOHVJl89l7bOu5SWe3UKWw+s=;
 b=nL+j+3yqldfVveJyP85QQrG+/164sLvD4q62M4zqjG4xA0UjySK7EHJalcWkbGRr3R
 l7R6H0qb4zqTk8AJMHGu2yPEUYgfQxdYlFupaF/y4kWVcZovxOAuYDh1O04OxNpifD1s
 4YO+q5+YkyuStM/d2s5DtdcBQyCe8pAyjsG9J+fa0xDmEWJao0E1yQPVi3rRCBzk2wET
 7rhLVjN/lKLowfdovzYA0cu5UrAF27DdhuAYoqu31RgVEk5M7ysm5w5XdOhtR8ZVC+Cc
 u4SSUJEdbPuYRYFlwfu8HwkMc/Tf0LyKiA+Byn4ukNudvPcbhPJVdDtEoQQYldKZVJdv
 gauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779818212; x=1780423012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8gANO1dHY/McFEVD+OLbOHVJl89l7bOu5SWe3UKWw+s=;
 b=oNjAWMx3L+ryZAMzD1U/pC4PSt+4X3vvdga1gUABKCjI9jkQR2KhDyZCW2AAJo3GP8
 ulWRIUcf6eUy+poZwHviHXs5ihQQxX57KW3SH3Og0c+LvJE7JulGqpjRv/QILDlS6tgi
 fXAwxA75LqM6GZTN2Sw0OlWTqzH0h9ppSsqG4RkE67ETDnEn5YmkGpG7jHn3ahyBGDmU
 dXLp5+YwmjeIxib+Te21pWKGR7+/GJtD/C7cyryOSlBuqYdopqxlpdOFG8ZhX/h8hCnL
 +DrGu3jGAmjO5jpOE08ma2IHaaJd9GsEtiBVekDwmuJax6qygDA83j2aciRwR3mzqGn7
 V2dw==
X-Gm-Message-State: AOJu0YyES6uwH2DxdakZb1bNe3Oyy9hbE7mwP8x5+/q68db7eDQ3+P2M
 FuPTgcHcLhNTrL35LEFotlPDktQ9dFT7ozuYGt71uB7Ga6mu9HMZNHOtFoxny4hrFCNwTn88Q1o
 CCFusddl3Cx2DV8Bx8C+GUb4y1HTKntv0723EBaCG2/KIhCkECY92wRl4b6bjD3oj8CrR8A255I
 qUJfquP1CyjGQl/wbLiQV965Bz9z9iaX/Cy3g8aEo5
X-Gm-Gg: Acq92OF0rwwdPmy2pN2SmPxKnU8hbD/LWbKAU96fVUZVZuo2CmzSdADiIJuG4HYvj+l
 ke+p3sYkMU01vVn6D876pjYZBsbijtqqwhN/YRhXIgEqZ4BiFdejrD0XLW8Zps2Knjce+SnVD8w
 ENfLs5gdOTCf+zl0Ae/W9SXbbrZ5EIVGF9bnH/4bMLO+VuslHANsSMadWnYZyEFU9OjdbNVZDXP
 OtJJij9nQ1brdDknUiQVARTqxI8VcAXqaU+T/O0w7MxYBh8Up2GlWiTGJlKcN2YTSGlv9JBNkHu
 U5JUIp7CfOhyvDL74dSqKhOEUhcoOXXZ4YrI81b7f1RFyNUt5VK56iiRssjN4nd8onCESPKAigv
 rjImXHZKs+vR1E/zBuj1/BBUHxjmoinXeZzR14TVSV2UyfvlpxStYsElHn2ZCJ+uP2sZvVESd3J
 liEM1CP69hNrdDUE9CUojy0rY7/x29LpefmCydXw==
X-Received: by 2002:a05:600d:6451:10b0:48a:563c:c8c0 with SMTP id
 5b1f17b1804b1-4904249d11amr239850625e9.7.1779818211988; 
 Tue, 26 May 2026 10:56:51 -0700 (PDT)
X-Received: by 2002:a05:600d:6451:10b0:48a:563c:c8c0 with SMTP id
 5b1f17b1804b1-4904249d11amr239850315e9.7.1779818211595; 
 Tue, 26 May 2026 10:56:51 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454a0b9asm336803755e9.11.2026.05.26.10.56.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 10:56:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	armbru@redhat.com,
	marcandre.lureau@redhat.com
Subject: [PATCH v3 11/19] scripts/qapi: add QAPISchemaIfCond.rsgen()
Date: Tue, 26 May 2026 19:56:10 +0200
Message-ID: <20260526175618.227743-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526175618.227743-1-pbonzini@redhat.com>
References: <20260526175618.227743-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Generate Rust #[cfg(...)] guards from QAPI 'if' conditions; it
turns out that they are very similar, with both of them using
not/any/all, so just walk the tree.

The next commit will put it to use.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20210907121943.3498701-15-marcandre.lureau@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/qapi/common.py        | 19 +++++++++++++++++++
 scripts/qapi/schema.py        |  4 ++++
 tests/qapi-schema/meson.build |  1 +
 3 files changed, 24 insertions(+)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index d7c8aa3365c..14d5dd259c4 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -199,6 +199,25 @@ def guardend(name: str) -> str:
                  name=c_fname(name).upper())
 
 
+def rsgen_ifcond(ifcond: Optional[Union[str, Dict[str, Any]]]) -> str:
+
+    def cfg(ifcond: Union[str, Dict[str, Any]]) -> str:
+        if isinstance(ifcond, str):
+            return ifcond
+        assert isinstance(ifcond, dict) and len(ifcond) == 1
+        if 'not' in ifcond:
+            oper = 'not'
+            arg = cfg(ifcond['not'])
+        else:
+            oper, operands = next(iter(ifcond.items()))
+            arg = ', '.join([cfg(c) for c in operands])
+        return f'{oper}({arg})'
+
+    if not ifcond:
+        return ''
+    return '#[cfg(%s)]' % cfg(ifcond)
+
+
 def gen_ifcond(ifcond: Optional[Union[str, Dict[str, Any]]],
                cond_fmt: str, not_fmt: str,
                all_operator: str, any_operator: str) -> str:
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index a5a11298817..7bb9fb712cf 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -37,6 +37,7 @@
     docgen_ifcond,
     gen_endif,
     gen_if,
+    rsgen_ifcond,
 )
 from .error import QAPIError, QAPISemError, QAPISourceError
 from .expr import check_exprs
@@ -63,6 +64,9 @@ def gen_endif(self) -> str:
     def docgen(self) -> str:
         return docgen_ifcond(self.ifcond)
 
+    def rsgen(self) -> str:
+        return rsgen_ifcond(self.ifcond)
+
     def is_present(self) -> bool:
         return bool(self.ifcond)
 
diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.build
index 3b0c16a8b67..40429a22774 100644
--- a/tests/qapi-schema/meson.build
+++ b/tests/qapi-schema/meson.build
@@ -97,6 +97,7 @@ schemas = [
   'enum-bad-prefix.json',
   'enum-clash-member.json',
   'enum-dict-member-unknown.json',
+  'enum-empty.json',
   'enum-if-first-required.json',
   'enum-if-invalid.json',
   'enum-int-member.json',
-- 
2.54.0


