Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 491D9CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 18:00:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRw1e-0002A6-Ho; Tue, 26 May 2026 13:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRw1Z-00028r-1w
 for qemu-devel@nongnu.org; Tue, 26 May 2026 13:57:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRw1X-00084a-8f
 for qemu-devel@nongnu.org; Tue, 26 May 2026 13:57:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779818222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xeAc90a5JobVPESwPbooIYpcQ6eg5eVi/LK44TKf77M=;
 b=W8TsWQZYnW/N3zQlgCu5u2wVTiaBOVfy6H+MaHNKC1Eg/SbhMZ1V6hrtzLQ4ibYmEoKSA6
 28RxZrQe5vSWjHd3Vg/QgSIr/KAjUt+bYUrYkcB0KVdZBeKVY6zGBR4bj/qpGWEUKYAQqm
 bXX1PgBkkHY3Sm2U7o/XLGKO42C9Bac=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-o3vQ8yzLOtWEuWNoyxSzLA-1; Tue, 26 May 2026 13:57:01 -0400
X-MC-Unique: o3vQ8yzLOtWEuWNoyxSzLA-1
X-Mimecast-MFC-AGG-ID: o3vQ8yzLOtWEuWNoyxSzLA_1779818220
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-45ea19f2564so5598847f8f.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 10:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779818220; x=1780423020; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xeAc90a5JobVPESwPbooIYpcQ6eg5eVi/LK44TKf77M=;
 b=WqsUk4e/aywkSRSUBU2XRg1pOmzEsR7HZqkooA0T1js3pFjYc+7bxGV5ujNgwXkBL+
 4aPDjfZAcSRym2uRNEVvNvgRli+ex25nAejMz0I/gikWYUb7ZulYlubH7enRXxEeA4+R
 te3T57I9ZlmGQD8WwAQcCecm8n3Dbum1BeZiog+greh0diw6J3+emi0AzfO0csnWsfbe
 PgJuETRQernUijCAS0ZJO4sLvDirWLJP78Dp//FCPyta+jskur/YgwacQgFxMoIwDqB5
 nF2aqoxafAxuAAUqDb3wiYSA5OS9b3fprC/nBrYydpXhKbrJckfHLSzFwKYxM+YfU7iR
 RKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779818220; x=1780423020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xeAc90a5JobVPESwPbooIYpcQ6eg5eVi/LK44TKf77M=;
 b=aqDlvwCrU2EVB8MoB/hciKtcTjdyn2YKUKiUxOz4zz/ltIx5J0ykwyrYYe7dPE0QTk
 cZrxQNi5kJqLDZtJRQpkQR8rNYXlvCYglSbFmm8eH5VGyRoXpZ52eCHzRSohegGMKr93
 sR3M9+xeeCePqbq4vZLXqL1bt+W7t6TmNG0JNjZOVI0Snn2eIiX5Z8qOnz0VdoHwp4bi
 6NFjQqqZqxw/X/zreqOQLvgHGMfZYe5yRPBsoLfcccPJJp3e9mG5RKNuWhUE+7RXCsBd
 CNGQ7XZJv05L4o+rAEQCMY0qpvaOjqZxH9lZnPnUWo6ckYsBmc/HI1XCk0uYU2vA8zgZ
 tPJg==
X-Gm-Message-State: AOJu0YxRm3DlsN/9Q3NCsPgwOKUcbtaEANjr1pF9QYYsRme9+JHoq8Ju
 LRifEYPsfJdwIsbyyDFPI1KjO1CMusXwHhNW+Xg2fiz3mQLLAglzRTkMZxuHzpWIZsCkvikG4dW
 sZyQISqr7NSzI6FCTx9NGDOQubdn6e0ZEY8CQnbrDS6IZUxngMkCrgdxzwyX96UIS2rzG+GyCdA
 FuXppbtWxom4yRIKpIonfuDD4D2o3oul8gCpUB19LS
X-Gm-Gg: Acq92OHLPpoMzn3gmkAzFiWhRteuTSI8ynYSqpfe0BDLY6+yJglL7RqT3FKYsAwylKM
 QrWdz+0vV1wZtLN70o/1+2jpvbTGQdm7kw6KZFpfYtmUYNsiitX+C9rjVHdLNYcT9VyATIWceHe
 SqZt5aEPr3fkyYD8m8ebs/FPaNmwBKXdl3SvwtUd5MOEpwF3c9MBU7/KOtk5+7cjaLcdcifrVg3
 nj8zpLkIfy8hbFBoRigyctW79QGIFBoMaCmWLiOy+iLZYmp1J5HLCQ//B080bPs6/8cqQPUhWMd
 tPm1dsAqxkIqH2FGIydsvlQE4JFIcrwTr7wqc85gbCyn2U3qgdXcVpIXfYsqMinRdW7SpbcEsE2
 a9G+2Ryfkkg2UZi1f6lk73iEuHtIyI3MTDu/s8eeIN+kOMZF8N3bO8gK0fFIcUHbuJRaLMt8IoP
 9LZTN/mbyXK0I9urpoCf3XEvXnExY=
X-Received: by 2002:a05:600c:1c0d:b0:48f:d612:3c59 with SMTP id
 5b1f17b1804b1-490424b3927mr364696685e9.9.1779818220026; 
 Tue, 26 May 2026 10:57:00 -0700 (PDT)
X-Received: by 2002:a05:600c:1c0d:b0:48f:d612:3c59 with SMTP id
 5b1f17b1804b1-490424b3927mr364696345e9.9.1779818219652; 
 Tue, 26 May 2026 10:56:59 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d4ca0dsm37040170f8f.18.2026.05.26.10.56.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 10:56:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	armbru@redhat.com,
	marcandre.lureau@redhat.com
Subject: [PATCH v3 14/19] scripts/qapi: allow passing multiple segments to
 mcgen
Date: Tue, 26 May 2026 19:56:13 +0200
Message-ID: <20260526175618.227743-15-pbonzini@redhat.com>
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

Make mcgen more flexible to allow for easier removal of empty lines.
For example, in Rust you can have #[cfg(X)] lines that would often
be empty; let mcgen remove the whole segment or at least the empty
spaces and lines at the end of it.

Separate invocations of mcgen still preserve the empty lines
between them.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/qapi/common.py | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index c75396a01b5..44229c2e366 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -172,10 +172,24 @@ def cgen(code: str, **kwds: object) -> str:
     return re.sub(re.escape(EATSPACE) + r' *', '', raw)
 
 
-def mcgen(code: str, **kwds: object) -> str:
-    if code[0] == '\n':
-        code = code[1:]
-    return cgen(code, **kwds)
+def mcgen(*code: str, **kwds: object) -> str:
+    '''
+    Generate ``code`` with ``kwds`` interpolated.  Separate
+    positional arguments represent separate segments that could
+    expand to empty strings; empty segments are omitted and no
+    blank lines are introduced at their boundaries.
+    '''
+    last = len(code) - 1
+    result = []
+    for i, s in enumerate(code):
+        if s.startswith('\n'):
+            s = s[1:]
+        if i != last:
+            s = s.rstrip()
+        s = cgen(s, **kwds)
+        if s:
+            result.append(s)
+    return '\n'.join(result)
 
 
 def c_fname(filename: str) -> str:
-- 
2.54.0


