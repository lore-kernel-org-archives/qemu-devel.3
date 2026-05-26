Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA88CD6E42
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 17:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRw1U-00027j-W6; Tue, 26 May 2026 13:57:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRw1T-000271-ND
 for qemu-devel@nongnu.org; Tue, 26 May 2026 13:56:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRw1R-000808-QK
 for qemu-devel@nongnu.org; Tue, 26 May 2026 13:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779818216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x3lLT2zM00XZeVcrpc+cb0TqWQYGfu4gptrjRd0nz6o=;
 b=FAo7on2NHMzgNfweteSeKda6zihxGv2TXACUkoR20dTfyzhYo00wMEZNAIdJ63Oa8t8rSS
 nAilVg1elkmfFb8MaCJaRs2wv8TmbrzxpqYprChzkLpbwhjphWG9ElqFDWM3fW6Zgd6mUT
 yDPpqoktKXl51/WkxyFfxbCRotak7ks=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-_zrekPNZOkyZp2a0qkpihg-1; Tue, 26 May 2026 13:56:54 -0400
X-MC-Unique: _zrekPNZOkyZp2a0qkpihg-1
X-Mimecast-MFC-AGG-ID: _zrekPNZOkyZp2a0qkpihg_1779818213
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48fd3dbd16aso89637915e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 10:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779818213; x=1780423013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x3lLT2zM00XZeVcrpc+cb0TqWQYGfu4gptrjRd0nz6o=;
 b=bCjlcBJmyS7EVMEQ7yJ5R774x/VHZ0C6aPfWG5sDIGVvPqvO6mbgtaBQFap1UAE2Iu
 2nLqDI1lTcJHebvd0IUOot43hXCjSJ+zgrmHIdZneUggG3qDWS3gdCybZ8n0GyFHX+am
 ervW/LJ1O6UiYWhloRyQsOWWf+lah07jseXv8EugTSdmabg5iDQFOukhYDmXmzro9xBH
 gOvIWlMPHNVwS98VZ0VK/c38N5f4JkNViY8Pnybj2QsOkgw16J7Okz25B2CuJ8kv/sGJ
 CZAcUZYHCfrV/SW5pvtnAxOaLjCYlqoq67KhhFCGySo9kFIeAUi2poCiDKIZfrDA7zI0
 fYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779818213; x=1780423013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x3lLT2zM00XZeVcrpc+cb0TqWQYGfu4gptrjRd0nz6o=;
 b=oDDl5ENQiNANNm/gm/4ElSUdBtjqpSr0nSQdm3T7B3YU3nlW2ABIMMxyqFD16q10pi
 krmwwMtw3ZLspLX55YXp/DTT8UQwG6bbm+pyAP4JYJtIEQqtKO0YKZqWFAuUO0aHXmxT
 v7iKYnINACxFk9LEXwUHyUmzh+OrIBsscENK/UpN1sbWVugTKuLlM902QoY2e7uMxVfS
 ngbTRqJdmzpra85v7LCwrpbkiBWdKowDhoecl7nqFU6qAcXHLBbbmAnoQ6ibVWE739DP
 SLiR+MgakoPrmktr23NfNT+Df8JWurGs01ahF120+x2BBcQbiN+tF7eSu7WDUZD3xUNl
 aFHg==
X-Gm-Message-State: AOJu0YxqMYCBQ1Db4+4kRUnxQMTvyctpOfyZ9P9Lqqa/yVvxHgKjR5wd
 ZjS1fInl7HBEziex2bhKkerz7+J0LWy8QSIwaMZCP8QOrwz+D1VzaWuu+/NsbvWxyBNm8edDNh5
 L54t5st3I5nDaYg6i0H4kTwaHN9FLTFim5RpDNh3QJnq1wCHCSHWLsQ+whlfFcHO59FS+4NqZUl
 6iZaxrGshm8n6UQ0C6VHavfIWciVstsA27JSnWdYvK
X-Gm-Gg: Acq92OF1kGu5waqusLgfmLgx2HoimpAuKx5/uyj+nglMiQLlKWy2Wc3Pm0jegcJrX2m
 HW5HgH7DdKalip4R+PBgtTwWYIkB5qRJLjceHIb+j177Da3cA8fvDEn4IOGMiFnyy7E/laZqEVF
 FnSyvbptbTU2LEJxeU0bAdoEu/Xxf4axlC8hD6bIQtq1d94HGAZk1rMqOGJdLjQCpkN3oTu8DBR
 Qln6ZGbej+KVdZtDuihdrpL8S3XUFQYipIM0peokRwvKSNES+Rzfjd5sKzU0/L82yPeh+m3o+1I
 pumdZifgNwFg6MFd973WOGIQOr+1iB3D3hx1mewVh4WgUfO6hYsTy5oc9W7Tu8vnzwIXJsu4tTL
 /MJc+FxUlwp9y3vkGSw7fCTeztmPkk67O0M2mKALu5pH+ckjYJ3qp6mmmgTAiByhdBMQENT8qAL
 p2iTwe9W1hQqv8u61+HBomxKD+ats=
X-Received: by 2002:a05:600c:8484:b0:490:3b87:be0e with SMTP id
 5b1f17b1804b1-490428e3362mr339037765e9.29.1779818213280; 
 Tue, 26 May 2026 10:56:53 -0700 (PDT)
X-Received: by 2002:a05:600c:8484:b0:490:3b87:be0e with SMTP id
 5b1f17b1804b1-490428e3362mr339037425e9.29.1779818212907; 
 Tue, 26 May 2026 10:56:52 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454a0b9asm336811565e9.11.2026.05.26.10.56.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 10:56:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	armbru@redhat.com,
	marcandre.lureau@redhat.com
Subject: [PATCH v3 12/19] scripts/qapi: add QAPISchemaType.is_predefined
Date: Tue, 26 May 2026 19:56:11 +0200
Message-ID: <20260526175618.227743-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526175618.227743-1-pbonzini@redhat.com>
References: <20260526175618.227743-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

It is impossible to call is_implicit on an enum type from the visitor, because
the QAPISchemaEnumType has already been exploded into its constituent fields.
The Rust backend is also not modular (yet?) so it is not possible to filter
out the builtin module; add a way to query for implicit type names without
having the object itself.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/qapi/schema.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 7bb9fb712cf..3459b8038e5 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -1255,6 +1255,17 @@ def _def_builtin_type(
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
2.54.0


