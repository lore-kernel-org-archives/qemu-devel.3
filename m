Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC25CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 21:10:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG1lO-0000w6-FK; Mon, 03 Nov 2025 16:06:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1lL-0000uw-15
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:06:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1lB-0005Cm-QC
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:06:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762203998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uF31ZFegjjtG5ASzXGR3Xx9ULt+da5E2N+ZHHsXG0v4=;
 b=AlsQ2CjA/DxTTUfdVO+ZKFGZ74VaZdwrMmcX57+cw4KeMJjI424I9WMJaZmalMjlYAZiO+
 gJ7owfk85YJeYrA2YFQQ0m3qOaCzsKqkRjZz1wAqPtajOeKebnu33TTGPPoVve7bpypa6o
 TZG0sncApnJPkhiYWFij5nPnBf1zodk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-dtTxbPuONwOYo7LyotS_GQ-1; Mon, 03 Nov 2025 16:06:37 -0500
X-MC-Unique: dtTxbPuONwOYo7LyotS_GQ-1
X-Mimecast-MFC-AGG-ID: dtTxbPuONwOYo7LyotS_GQ_1762203997
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8801c2b9ea7so130577126d6.0
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 13:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762203997; x=1762808797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uF31ZFegjjtG5ASzXGR3Xx9ULt+da5E2N+ZHHsXG0v4=;
 b=beO340fQHcXuTdIOtdp2rFSAoQBX+MkvQRGDOz8BJzjDPlz6NUC8nZO4/8jQNVOaEu
 2jHS9fKMLYD3gKtWSRsJFfvxRpSVzhm35U30JcuDn1eIDQ4t/CHgoBsGrBD0F3NTmnCP
 OtBDB9GFogo4dyTDz6CisAsr3sli3NsRjhF1MMQoPECB4CGCkdKsrr/L408E3Hv9dXxl
 mA+T2DS8zFe6/5D/F5mTzSrA0XyCyc08sYrbfvc4tOUiYZrzGLtse8csKPBUIUbw2kaC
 woUKlMACViGKBvCibaVN2USIUYil2ixyPvDd6zZv37iKS4MHhUOAjPJO3RRoyNsaBEd+
 /97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762203997; x=1762808797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uF31ZFegjjtG5ASzXGR3Xx9ULt+da5E2N+ZHHsXG0v4=;
 b=qifMJhEE+2qjlmz7y5BJgnXQust1ihdx4qwF6gkDXvlP3MK5UdfpVOpjcjdvR1QK6Q
 tjlXmwz8pnRuCTovIivqDjXKSy015GrHRqnIUR2Y6iUkRVW9gBUdgt9IK/0Rs3r7luf0
 GrONo7d7GzOc0wzJ9YKbaAv6FdQb0kWdbWjr1YeHc8GgXS5dAvt5ld9PjDJ3z/aZd5DG
 tPwJ0uhUdYF4pd/1MXNtn9Ii8/trkWStmVc+WrokF7kg9h1hHeP0ZC00Zs91sZe0ejNG
 XyaHAclTdOWF+9yttSCBwCN8uO6Te3T4WVcYEzMIIyBm85Kb7Pqsiw67cVdJjN8seH4/
 xWUQ==
X-Gm-Message-State: AOJu0YxQxaWEXUe+CwP2wlfPLSwDXTuHY4u1lyutullFIC0vx8LcY2UK
 X3YkVZPLW+Z8OZsjiF9I4Y125BoTR/ee3ww61mQri8CzHPvcq8B8Ha1F98nplPFD1CzaRm2ESpD
 JZa5ngGlBHkgq5apVmiT9pZkirE/P5JEm67YtzoeJUheo/LzQSnqjn9b+UeRnvk0wT+s5GNrRax
 ifgo8KKbf2/K/vRXeKa4RhQLzdZ5SqEy+vUToa+A==
X-Gm-Gg: ASbGncuU14jTXZiyvsUJDiawuV0aJmpPYXMGO+xDR6SQw0idiLnz1TXTUIXs5Tw5YC0
 V+f+ArSVValOyrJuLa3FeNPvYNQAIu/rQDNMVGqCIkT3M0lFqJBXGSsXba8NF1QkmzcQ3m6PCl6
 2UyIqmROK/z1IlViGVMmrEoYe0TpdgGquSFYYykw6WDcN+OoaI/o9knXW+SZpqYcNFFdPruIQFi
 Pu2BDWSYDtqkbNlNjl4cyjDFREYbvXIruEjt4OV9eZFp1/ax2ddIHZJh+uKyFaMUAhh5r0tW+ox
 hK4OhrQ8gB7ITxCc/2DDEBohwTAcsEZcVcjwm4fYmZKE41APDl7vcXt1gieVLsQd
X-Received: by 2002:a05:622a:2b4f:b0:4eb:a228:7f4c with SMTP id
 d75a77b69052e-4ed30f2297bmr174268351cf.35.1762203996638; 
 Mon, 03 Nov 2025 13:06:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsKTf4x5Sc3CYtEqvuGKBohvzR5vXyXJBekKl5JmJ2UsQXignVg50kxi5tZa+lDbCMctj8Ag==
X-Received: by 2002:a05:622a:2b4f:b0:4eb:a228:7f4c with SMTP id
 d75a77b69052e-4ed30f2297bmr174267831cf.35.1762203996166; 
 Mon, 03 Nov 2025 13:06:36 -0800 (PST)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b0f5468968sm57428185a.19.2025.11.03.13.06.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 13:06:35 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/36] migration: Remove unused VMSTATE_UINTTL_EQUAL[_V]()
 macros
Date: Mon,  3 Nov 2025 16:05:55 -0500
Message-ID: <20251103210625.3689448-7-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251103210625.3689448-1-peterx@redhat.com>
References: <20251103210625.3689448-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The last use of VMSTATE_UINTTL_EQUAL() was removed in commit
16a2497bd44 ("target-ppc: Fix CPU migration from qemu-2.6 <->
later versions"), 9 years ago; remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20251016160313.25751-1-philmd@linaro.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/cpu.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/migration/cpu.h b/include/migration/cpu.h
index 65abe3c8cc..ca7cc0479e 100644
--- a/include/migration/cpu.h
+++ b/include/migration/cpu.h
@@ -19,8 +19,6 @@
 
 #define VMSTATE_UINTTL_V(_f, _s, _v)                                  \
     VMSTATE_UINT64_V(_f, _s, _v)
-#define VMSTATE_UINTTL_EQUAL_V(_f, _s, _v)                            \
-    VMSTATE_UINT64_EQUAL_V(_f, _s, _v)
 #define VMSTATE_UINTTL_ARRAY_V(_f, _s, _n, _v)                        \
     VMSTATE_UINT64_ARRAY_V(_f, _s, _n, _v)
 #define VMSTATE_UINTTL_2DARRAY_V(_f, _s, _n1, _n2, _v)                \
@@ -40,8 +38,6 @@
 
 #define VMSTATE_UINTTL_V(_f, _s, _v)                                  \
     VMSTATE_UINT32_V(_f, _s, _v)
-#define VMSTATE_UINTTL_EQUAL_V(_f, _s, _v)                            \
-    VMSTATE_UINT32_EQUAL_V(_f, _s, _v)
 #define VMSTATE_UINTTL_ARRAY_V(_f, _s, _n, _v)                        \
     VMSTATE_UINT32_ARRAY_V(_f, _s, _n, _v)
 #define VMSTATE_UINTTL_2DARRAY_V(_f, _s, _n1, _n2, _v)                \
@@ -53,8 +49,6 @@
 
 #define VMSTATE_UINTTL(_f, _s)                                        \
     VMSTATE_UINTTL_V(_f, _s, 0)
-#define VMSTATE_UINTTL_EQUAL(_f, _s)                                  \
-    VMSTATE_UINTTL_EQUAL_V(_f, _s, 0)
 #define VMSTATE_UINTTL_ARRAY(_f, _s, _n)                              \
     VMSTATE_UINTTL_ARRAY_V(_f, _s, _n, 0)
 #define VMSTATE_UINTTL_2DARRAY(_f, _s, _n1, _n2)                      \
-- 
2.50.1


