Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E0AEE499F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:38:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMYu-0001uK-BQ; Wed, 11 Sep 2024 08:35:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1soMYU-0000H7-5r
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:34:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1soMYS-00017c-QR
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726058080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+s8ozgP3DcLfD8jX3L8PdVl6oakdD8m+hmmFQEParW8=;
 b=IUiKAv58fflowQ0daAxDaJOOX7iw1Bteb+VkXiLz8LPSD0aTWgOnVl+EJfFkn6LBmV3+US
 VU7nhYK7UYBUtgNA4nAeicS12rZtf60dcpiFBuvmZ0pcwmQwQ++jzUProRErj4F+vwEfrG
 5KDv0oowp/dpwzjQ7jmNJ9wO0lSDY8Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-9RHEHVGcMoOdxoKmMJcgLA-1; Wed, 11 Sep 2024 08:34:39 -0400
X-MC-Unique: 9RHEHVGcMoOdxoKmMJcgLA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42cb6ed7f9dso30854565e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:34:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726058077; x=1726662877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+s8ozgP3DcLfD8jX3L8PdVl6oakdD8m+hmmFQEParW8=;
 b=N0WNj3WDFzBWhQkiyG8C+xrSolkqcfVVRHeNC2FZgy9hICheMxguiFzPAp3QorS+nt
 0WHYrVJ7b9+IDAN8oMeen/7O1quMfV1bAc3Y3zh0Fm/yKyuCjhH3/fUcSj2bfaT674A3
 9LRMI81LpbMhaQyAYwsvF57T87Xkh1yvUM74csUhkSZOtwcbH3/cH6dfWZ5TkQWaiTwO
 YIW+8TaXaTuiwrJuK/QueMJdXkDW5pK4Q6k9aZyuWYSUbx99m7yE5zidbgNMg1UYsFYd
 gcI3Eok9oR4Em1s2vBwU7XF6Jhc/kpRVPdD3sy6PWFS2l/XYcJKrwVYxetWTyMqWhXIg
 sXig==
X-Gm-Message-State: AOJu0YzCVS8dhfAX9D1IS/kxD99xFoYQaRbLVfexR3mJXQwnwJngDXpo
 5GQSuE55TaWWJs5H374LdfUvVsPHdUwgoCgWnf/cDhwIHM7m/PxkEWPgyeIJFtsahCvVwyyWBOb
 XFOIImXQTCQn2j4shp21gh68parMZv/7tV1vZr4YELiRIyWm8KcF4GSukcR4u7w8GgKd1IsJn0j
 ILEJGfWgNfe8Uuf6XTYrnpW3uZYhqKIbywcz1MFWc=
X-Received: by 2002:a05:600c:4449:b0:42c:b52b:4349 with SMTP id
 5b1f17b1804b1-42cb52b45a0mr110784035e9.33.1726058077313; 
 Wed, 11 Sep 2024 05:34:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLJHmQLLPlLTiGLYkydQNnTc1h66Qf5WU2jEeOdW0sDC+aylLsa8N2YMpSiszvDnb0hHLgKA==
X-Received: by 2002:a05:600c:4449:b0:42c:b52b:4349 with SMTP id
 5b1f17b1804b1-42cb52b45a0mr110783685e9.33.1726058076804; 
 Wed, 11 Sep 2024 05:34:36 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956d367csm11329540f8f.68.2024.09.11.05.34.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 05:34:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 17/17] minikconf: print error entirely on stderr
Date: Wed, 11 Sep 2024 14:33:42 +0200
Message-ID: <20240911123342.339482-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911123342.339482-1-pbonzini@redhat.com>
References: <20240911123342.339482-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

While debugging an invalid configuration, I noticed that the clauses debug
ends up on stderr but the header ("The following clauses were found..."
ends up on stdout.  This makes the contents of meson-logs/meson-log.txt
a bit confusing.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/minikconf.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/minikconf.py b/scripts/minikconf.py
index bcd91015d34..6f7f43b2918 100644
--- a/scripts/minikconf.py
+++ b/scripts/minikconf.py
@@ -112,7 +112,7 @@ def has_value(self):
         def set_value(self, val, clause):
             self.clauses_for_var.append(clause)
             if self.has_value() and self.value != val:
-                print("The following clauses were found for " + self.name)
+                print("The following clauses were found for " + self.name, file=sys.stderr)
                 for i in self.clauses_for_var:
                     print("    " + str(i), file=sys.stderr)
                 raise KconfigDataError('contradiction between clauses when setting %s' % self)
-- 
2.46.0


