Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F2DEE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 17:13:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVw5y-0007Nw-QR; Thu, 09 Jan 2025 12:13:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVw5x-0007Ne-Ks
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:13:21 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVw5w-0007uU-3P
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:13:21 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aa6a92f863cso242265066b.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 09:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736442798; x=1737047598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pERnavJS02WsVkpfgEIKcxRU3EPSk+CF5JdtAAMvhiw=;
 b=y6zN5sNLLiQONLptSrJGCRsYMfKk4LTnGQgTh9r+tLsqMYR+SPdHeQJB1XZA5ENjTG
 1ZvCveQga+PjlKe3AAhwhfaGRnhqzl9EXqnNJ154JV+c/JCWThRIXpYYosYIeqOQ76Q4
 67In23Rmu2pmVbH+hQ56vYbtOqcWRTC/CvF17fPOXB9yPjo4k2xwo9C9wadBulbp0Ree
 z8wqHhiPa+wt03LImBDH0wphRhAbZ8BEA/Tds0X3YrGK9TOTBVE1nQDGAnisef8spkzm
 sR3/3fIlNv0uZuIYb3i/XCnekgTCtQ3P7HsSNgsoFuJfo5IW0faIHcSepWTQOm0RsKy8
 ZcFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736442798; x=1737047598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pERnavJS02WsVkpfgEIKcxRU3EPSk+CF5JdtAAMvhiw=;
 b=WJzZOU+L886W4I6fKW96u/ukGCY6vs+MM/TwZ4VM9UPu+ELgAFv08bSaSxcW9v7eb8
 arYroRHQCPsvo11IspO5/uCe2m0L9AEtX2K5EGSbWM1w3IUHfTbDLTecfzoKhIVeC4iy
 8y9bpP8LnRizXX9xyEcdjEUi5iPw6i+CJx+M2CKSU9StQevLcYeVvTQkdZ36+Lb1vHe+
 PSfHuvMaaPE8rr6CGqsHQFedkwX5Q2q5aESJs5qE+n6XgyzC7HB8IEOjEHG+6XGcPg6m
 Qp7l+dnC/bdqCcBbJtoAh4598MFDIR7KTlU+hWUohskOSuFdBVgnTZL93Z/r41coafm6
 sfMA==
X-Gm-Message-State: AOJu0YxfZz0tIux8dW4999nRNniOaJlF+gCUTFa5TvADtrccaeqFmKNT
 mCmvNedxfzl5r8buarPYhfU9M7i7uwLcnDfCw2V+ppl63UGS8UGheYze9NGxwVc=
X-Gm-Gg: ASbGncv+S254AgdrmZOQFy4/KzMsbJhQIEUenoPSBKd7kcuQQliN3AWqNOZzsgEtnKl
 3IIsga3a46NsbsdCKBs6wDn11M4Xulw+0eKgkYsCz/p9+811s9MRED2uQ5lsB+z2o0PpUKe97wH
 BLNPEJKqOwC+mv6HSyZi8lYkLmmidR3/Ac1Afj8ruSEL0H+xm55Xvuecw03CryJE4fEdOD5/NM/
 D3+6CFI/zqH8unC5CbaBmIxYS0M+z0CI31OSJD9DWOBaIAcsuv1VEI=
X-Google-Smtp-Source: AGHT+IHm7ePGY5gC4l9POwviXmHLNUcstEddBRA+C1rwep573Sy+//z5S41Jmsb3mEd4+DeEbbet9Q==
X-Received: by 2002:a17:907:1c22:b0:aa6:80fa:f692 with SMTP id
 a640c23a62f3a-ab2abcb0a84mr757450666b.49.1736442797767; 
 Thu, 09 Jan 2025 09:13:17 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c9565517sm89120466b.130.2025.01.09.09.13.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 09:13:17 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AB9116142C;
 Thu,  9 Jan 2025 17:06:21 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 20/22] contrib/plugins/hotpages: fix 32-bit build
Date: Thu,  9 Jan 2025 17:06:17 +0000
Message-Id: <20250109170619.2271193-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250109170619.2271193-1-alex.bennee@linaro.org>
References: <20250109170619.2271193-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20241217224306.2900490-11-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/plugins/hotpages.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/plugins/hotpages.c b/contrib/plugins/hotpages.c
index 8316ae50c7..c6e6493719 100644
--- a/contrib/plugins/hotpages.c
+++ b/contrib/plugins/hotpages.c
@@ -103,7 +103,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
 static void plugin_init(void)
 {
     page_mask = (page_size - 1);
-    pages = g_hash_table_new(NULL, g_direct_equal);
+    pages = g_hash_table_new(g_int64_hash, g_int64_equal);
 }
 
 static void vcpu_haddr(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
@@ -130,12 +130,12 @@ static void vcpu_haddr(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
     page &= ~page_mask;
 
     g_mutex_lock(&lock);
-    count = (PageCounters *) g_hash_table_lookup(pages, GUINT_TO_POINTER(page));
+    count = (PageCounters *) g_hash_table_lookup(pages, &page);
 
     if (!count) {
         count = g_new0(PageCounters, 1);
         count->page_address = page;
-        g_hash_table_insert(pages, GUINT_TO_POINTER(page), (gpointer) count);
+        g_hash_table_insert(pages, &count->page_address, count);
     }
     if (qemu_plugin_mem_is_store(meminfo)) {
         count->writes++;
-- 
2.39.5


