Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F41F9936D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:31:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFrKB-0000bz-VV; Thu, 23 Apr 2026 06:30:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrJU-0000Vu-63
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:29:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrJN-0005GL-EI
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776940169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uYphRU7kz9gFoWjRUHCk/rn7ErgA8kbffjc6IiVv/rQ=;
 b=PyLG/P/p6h9ny9SQJGzSlG51tlr6snoqleAwsJq6uxnPvU3pPScTEpnvEaqSLu4Vq6At7f
 N0Y6AVltEzfVKxtbeIsxce+UA/hlB0ty0sni808uU5HGsr6Xf9oTQh77gPPR/fR91ZjEaq
 1Dlewt8mI7ns+9RuzaXSwP4StQ9BD8o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-ni9tgMkpNsCfJSClubtazg-1; Thu, 23 Apr 2026 06:29:27 -0400
X-MC-Unique: ni9tgMkpNsCfJSClubtazg-1
X-Mimecast-MFC-AGG-ID: ni9tgMkpNsCfJSClubtazg_1776940167
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48a5952c635so20519725e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776940166; x=1777544966; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uYphRU7kz9gFoWjRUHCk/rn7ErgA8kbffjc6IiVv/rQ=;
 b=GWoE0j6LRtyt9B71l7KVVRhFDAFzSPKviZEPVNOjaKq5yAKdsc7lIFKWyJlQ2iPG6z
 w3w4+hnf23nqvIhU7smThoTfiFLchQudlzEa7rFYm3pqOUK1PY1VhhWlqat3nDXtA9Hb
 5OQ55flVqPG4XgeyIzhfjDLTHXrMCInTK+0hzjPmsG5e5crB/JZkAH458r3iFmh9AHFq
 rgnoB0zx3NCN71dRYMAkPvcqrGDEJSgqJO21HY2r1t+wdA5qN55P1ly9I33HZW8y11mi
 ugfF29lQuwtguBEFdM0E+tLUOYqdUpLx15ZuPbSATlLl2hnAGsxIqw8rgxgCNr8MAj2Q
 zL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776940166; x=1777544966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uYphRU7kz9gFoWjRUHCk/rn7ErgA8kbffjc6IiVv/rQ=;
 b=GmCQx3I93wpOSqYWH+tnydioXHh8P+zke6p00b/eY7KfiksHUj8yiiNmTsvfGnQImR
 7Gl4gZctQmuI9NA4YtBJFLY2KlRwiWL/JeUP8vGzaMGyYpszs+DTZMIb2sB/xPx+AR4w
 R+b0JuyQO+ih48FN9wGmoVf3UC/w55iZ0hFLd43SKxVqa4/Rmw30lfYazUgyZwj01v1m
 Vagj0t0kz4c+qteC+UjbRZnLr7ffywUORQJqOK5zRIxCSq3eeYwTaMoQlhfV+H3/dMRQ
 qnhpId+gqlh50jlIdv6zatsvQKU0B2ihZU6eWIO7YHEoykrDm4YVx8YNUKaPH/xg52q0
 SdtA==
X-Gm-Message-State: AOJu0YyHXTLHnTvvK1sfN+5lgv7ZoCORaKmzntATQMLW4ld1vreuQ5lw
 Ww1qLs64bzD7u2ecK/Diny43/JbzGWMudgLLzQUTu2B1uTGY0lyNX4aQHzqvAUnZUe8ikOCFY61
 lb2OaCEwGb+XUBIVy1juX0n/ovkWNN41EZ0mYtc5hTZKYTW+6z/eweRyJHPb9GPIqnE4dgqurDV
 3LGEH8WfdCfcKWqz3KOlWE/ceCUw3pA3lzt5fJb0ly
X-Gm-Gg: AeBDieuqU7GNl7LqvayXM8b/eRHcG4H+r5uvcoOGFOKDXC+KShuHVXpf/zFtPNphhV9
 cZa1HIMhd/ns0M2o401vOIFPJQbD3OS8P9gp8zxG2MYks2Rw+YApqZuVvyj1p7hJ1L6sXlUSnut
 K6Ao46YMpKbRTy8PSHVacpuDz78w+bfDwNqHJ8n/ltu2257t2f/0V+RLwhnLOy61ZFQtLJ98YO/
 7H7N9ihY3ThtF1aryuIInnAPw1nh32h+XM0oaJfMEe/GOX2PeFEwGaZNdtY8c89UtkGose/f3Mi
 TVWxTonXbFjhcLyp+ZGLQ0p82XRlLFm63m3JQG2HhA9QTE7RrWZyrQZ45VM3jbT3sshmLsrmaeD
 fs7OEKJgnn2lM77d0Iza36gH4ZqCVe8ClmTHMVxsfO+Ij77mdukAA9xSTiP/BY6khwLb9Owp3ED
 dgCoL2ib1iKBmzaLutSBRyVqpZ1nPbN4cCZuc=
X-Received: by 2002:a05:600c:a40a:b0:489:1ba8:5bf0 with SMTP id
 5b1f17b1804b1-4891ba85dc1mr217400795e9.21.1776940165994; 
 Thu, 23 Apr 2026 03:29:25 -0700 (PDT)
X-Received: by 2002:a05:600c:a40a:b0:489:1ba8:5bf0 with SMTP id
 5b1f17b1804b1-4891ba85dc1mr217400565e9.21.1776940165543; 
 Thu, 23 Apr 2026 03:29:25 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc558f2sm377062475e9.1.2026.04.23.03.29.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:29:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-stable@nongnu.org
Subject: [PULL 01/25] target/i386: fix strList leak in
 x86_cpu_get_unavailable_features
Date: Thu, 23 Apr 2026 12:28:58 +0200
Message-ID: <20260423102922.443639-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423102922.443639-1-pbonzini@redhat.com>
References: <20260423102922.443639-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The result list built by x86_cpu_list_feature_names() was never freed
after being visited, causing a memory leak detected by ASan.
(the getter visitor is VISITOR_OUTPUT kind and doesn't own data)

Fixes: 506174bf8219 ("i386: "unavailable-features" QOM property")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20260413125040.3842686-1-marcandre.lureau@redhat.com
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c6fd1dc00eb..9d126600c05 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7842,6 +7842,7 @@ static void x86_cpu_get_unavailable_features(Object *obj, Visitor *v,
 
     x86_cpu_list_feature_names(xc->filtered_features, &result);
     visit_type_strList(v, "unavailable-features", &result, errp);
+    qapi_free_strList(result);
 }
 
 /* Print all cpuid feature names in featureset
-- 
2.53.0


