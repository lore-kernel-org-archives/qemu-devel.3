Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EED0DCCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 21:12:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6xw1-0004y5-TR; Thu, 09 Oct 2025 17:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6xvy-0004xh-AL
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 17:12:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6xvp-0004jJ-JN
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 17:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760044332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=8vFaQq5bO3QdHThnOZntVJqWF1rUBmNHmqnUMiGjqLQ=;
 b=LLu2YLI7Wux2zmnsVgJakVbycIXnkZ7cDnT+Jxp0gMBlyKdfMp5UapJdvSwrh4w9zSyWlK
 3LvVp3N1j16kVLj9wLywIuLtTHAwoXzPFgvwdm+jBrvhKel8lClMIDQpXmODNQJPwJGJpL
 T+Ot8iBVUUqUs4EGo35sR5CQL2bygJ8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-vNCGf7gKOnqOeF58G2Qoyw-1; Thu, 09 Oct 2025 17:12:11 -0400
X-MC-Unique: vNCGf7gKOnqOeF58G2Qoyw-1
X-Mimecast-MFC-AGG-ID: vNCGf7gKOnqOeF58G2Qoyw_1760044330
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-41066f050a4so810281f8f.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 14:12:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760044330; x=1760649130;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8vFaQq5bO3QdHThnOZntVJqWF1rUBmNHmqnUMiGjqLQ=;
 b=grbX4zSEQQqibCBjTQn6RmKphfnSKb/ELdo1HFnaltGGoQVK40pSOPUj1Xj4ptqv5w
 hR7H7Dbutv1E8uBNLUZsmjo0fyV8Jlo3/Nu88uDP7cdSY4dA58GdlMXL+9K0g07Cy3Lw
 IL+niQFKXhutOfykbYtlQyxiQqqNUhVJwmTv3A0vCKD+jc/ga2PJrPNXL6gO85ni2wWE
 XdWRfdUDiACTns4WNyzMyDsEDEmPqFrJ5T3YMDU9tRBVicOZmlFmkhz8WzqKispxKHRL
 nhLzPU4S0POe0jPkAiuZvipWO3PJpZUutjG1QX7wK5wCSytfHTCo6a0Fgx85xyQHirMj
 oRrQ==
X-Gm-Message-State: AOJu0Ywbh/39EMfdBPDxkg1VOCNgcCfnj+a1Km3kolwxzYsYTkYw62aP
 T8WTJnOKdg/rretXURnH4ETMRTA9x9lXURV5VejKlEBAyDtc9s8JCpbJMPJxWm2zhI2nVM1nvqO
 hqoUjJxDL8aE3D5mrhi/i9PdP1l0rPCCBZmQTcykar7PkN6vzcJGi/TNpsHUxbq0vQ9PqkX7eZr
 hnbj1uaWRYbwsBicgcgm/NY21XvSC+7g7GfHcFgBhk
X-Gm-Gg: ASbGncsxg+7XCytR+iEEx21khOGBnNpDlsKgQ2aNSpL1JT6f6wiMUnIgrPGcBQ7PHR2
 YMiqQwmT6o+eVoj8TyaK4dhPjAldRQS7ShNaEfWnP/7PJCv7EqBkPQUof1+KaaRSatn+QWyyLT0
 KBfRqNGXIzjBrrVFPhitKXvR2zZ+1dy8sG8WFczhkfrx+/O5704fVFz6jXWH5kUOoZQTSR/CmmZ
 3SwQx9IkM6igOaNwlQYk/W4i8UQ5olCjTr1aNxjoMnuKfbVdIdcv/jJkZbjhL0iO6jMmEHRJezd
 GP4ZjjWs3gmTvPj7gOlaRO9N4UMRCH10YG3R/Mp6ov9f2vjCSyucinzbuxqRc825sD0b7i9FRqZ
 Z3mhn5YGPr+IMvLx4Lg4NhMsnZ6UxbYOZllT6dT2fmQXy7xuFvA==
X-Received: by 2002:a5d:5f94:0:b0:40d:86d8:a180 with SMTP id
 ffacd0b85a97d-4266e7bf005mr6316333f8f.20.1760044329791; 
 Thu, 09 Oct 2025 14:12:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2YVuE57DYvf40C9YpShEV1rkDBw4MFIGfK0W8vvfGW4EFVS81w3dIV2RmFGi3s5XwGUPDBQ==
X-Received: by 2002:a5d:5f94:0:b0:40d:86d8:a180 with SMTP id
 ffacd0b85a97d-4266e7bf005mr6316325f8f.20.1760044329407; 
 Thu, 09 Oct 2025 14:12:09 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.231.162])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce57d3b9sm871873f8f.11.2025.10.09.14.12.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 14:12:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] rust: temporarily disable double_parens check
Date: Thu,  9 Oct 2025 23:12:08 +0200
Message-ID: <20251009211208.643222-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

It is showing in the output of the bits! macro and not easy to fix there
(at least not without making the macro more complex).  Disable it for
now.

Link: https://github.com/rust-lang/rust-clippy/issues/15852
Reported-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/Cargo.toml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index 783e626802c..4f98b2c03d3 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -109,6 +109,9 @@ used_underscore_binding = "deny"
 # nice to have, but cannot be enabled yet
 #wildcard_imports = "deny"   # still have many bindings::* imports
 
+# https://github.com/rust-lang/rust-clippy/issues/15852
+double_parens = "allow"
+
 # these may have false positives
 #option_if_let_else = "deny"
 cognitive_complexity = "deny"
-- 
2.51.0


