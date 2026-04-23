Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BFEEF9936B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFrKm-00012g-IF; Thu, 23 Apr 2026 06:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrJv-0000gr-An
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:30:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrJs-0005gC-IJ
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776940203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=90Nm7NqoW1g4/eHo1L/Hmiw+1BI8KJhwBEhR9+JgtqI=;
 b=aYb0kL9EhJiLdlvwqtQMbpHINpoRsN7/QCX9i3WccYWgbbML008JOK73KaHjHVVjfky5gC
 51tNf4uWCHWBFgf4ZFZS4QLsscIoOOaw/oi4bb+FY7b8CJVyocIGRf6G/chq1SMSKM8qhD
 zY0joK9wH4ucSUD4K3fEhJg+ukShCQg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-XdF1ZRRLNqW72baUwtPSgA-1; Thu, 23 Apr 2026 06:30:02 -0400
X-MC-Unique: XdF1ZRRLNqW72baUwtPSgA-1
X-Mimecast-MFC-AGG-ID: XdF1ZRRLNqW72baUwtPSgA_1776940201
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43fe4674d3eso6130095f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776940201; x=1777545001; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=90Nm7NqoW1g4/eHo1L/Hmiw+1BI8KJhwBEhR9+JgtqI=;
 b=FBuVxmhYCdBL5zT7hjEmD+70ambo3GvDkyQtti+q+HHib07NGa93b1CK0+cFWg4EXT
 y59Ukv+MU5MdMgtxM+5jbkQlajpA7XwvGsIOsUPFvFJmibOUehb7ViEbEOhKziP9H5Vt
 HKZOYmahp+9f6bZVNg462Qc9TTZgaQMmnt8N4Ff7asWb3rLq/it2/eVZvD48foFNtzFw
 uWQwnTcp8McK2xZLiKTtd8/PAZbfj6fNnQQ+pH4nltCUX5mqhF2XUZJhcUw6yLtLdY6v
 j2L+j1meQDCgfgQkb7nL3hdIS8QHhU7P5Pt0S8Qf0nr63NRoBGLMPbXiALSAKFDZImj3
 7PqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776940201; x=1777545001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=90Nm7NqoW1g4/eHo1L/Hmiw+1BI8KJhwBEhR9+JgtqI=;
 b=QoWBhnM5mv/tiwbW3O3+51OPkDiCg01u8mjYH659OgMpgJuSp74Kr+97LEXIb4JBZv
 iFS2kqRK/6YVFvQs2WHLNcsBFzD/HtXS5P7HCpPgcOUn+lwz5L99VbPLROhnKcsvjG7j
 U5LZRGpq3ldMOF3dgSDJ0WaurjOhGlxpcyo9NRfSBCN4pETLjh1qnWzSiMYvx38Cprqt
 lSnLo5QZpZYZkhUvmiGhHXAmYtDqyhJSzMTS6UkPgeZ4GKD8Ba1PkwplqaWCG3aRluCR
 aHUXPD/qsUPLBgDP0rLmnkqnBrfcNGthBchHvVZaYNf/NVkvNoV3K2mUDRN/RVNlI+Ug
 0ypQ==
X-Gm-Message-State: AOJu0Yz6xAnHgPD0cDatpeAaRr56QkTwhP2BZSqQKSBJlweJliaEtue+
 z4QUrLjICwIgLI/4bS+KKPdAC7H2LEY2BCwck1IQKdiK0/MvdKK/mOBYoK9o7Ac6rkWBt9/KB1W
 3kuOY4e9fyFOaiHIyZwDaikpbGa4F/GSCWo+C1mC0aeNShLKe6S9jM0soxkPsXe7fiaEt4eNC/3
 5ZJQp6f29AcJAdMa5GiYortoiya1dfzDFPhHmTsfuQ
X-Gm-Gg: AeBDiesQIqdJluufK9L3RbjoYQSXHcxNp17RmKOzgyrsBA+3WuamzHpsyxWI+TTJVAz
 suRzzDnLjyE4F2OXpWsi7CtSrmeoRyLirg0VkNUr/l6cm8JLvofasc2yyBZpnFg1DCuri6dDNbG
 WD/dYKO1bQxj+5j2eBBl8VBP+XFFZubXuE9siR1bPr0AC3zov+iTkQR4ajvTREQDS1URC+3evLG
 DeEDdK1kz1mUdWD3H5c9Vw60UD4Irm3Ohd6wQxWumxfU1IE53KLm7xgylIRwcz8WENgrZMAWrpT
 N95sY8syqUB4as0OWWhkSm5eStKzyzP/VITOS6DCttGftXj9OCqk2c+nihsqYi5DH43z2EMa46N
 rn9569SdG1lQTH+xQXtDmAgevq2ystu6hJtXC7hzZkfEOD+7G3ugqoEHbz7qdscFNTMpMpa2pES
 7QiHnrUvVJDfLN0cQLqhKUMgLpoxfMXyVgs4Q=
X-Received: by 2002:a05:600c:5299:b0:48a:5342:36b5 with SMTP id
 5b1f17b1804b1-48a54514646mr174394695e9.21.1776940200644; 
 Thu, 23 Apr 2026 03:30:00 -0700 (PDT)
X-Received: by 2002:a05:600c:5299:b0:48a:5342:36b5 with SMTP id
 5b1f17b1804b1-48a54514646mr174394275e9.21.1776940200199; 
 Thu, 23 Apr 2026 03:30:00 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc18bccfsm466743445e9.8.2026.04.23.03.29.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:29:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 13/25] osdep: Remove unused strings.h
Date: Thu, 23 Apr 2026 12:29:10 +0200
Message-ID: <20260423102922.443639-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423102922.443639-1-pbonzini@redhat.com>
References: <20260423102922.443639-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Kostiantyn Kostiuk <kkostiuk@redhat.com>

We don't use strcasecmp/strncasecmp anymore. Also, we don't
use any other strings.h function. So this include is no more
needed.

Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Link: https://lore.kernel.org/r/20260327134401.270186-12-kkostiuk@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/osdep.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index f151578b5ce..2f0e61ad6b2 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -114,7 +114,6 @@ QEMU_EXTERN_C int daemon(int, int);
 #include <stdio.h>
 
 #include <string.h>
-#include <strings.h>
 #include <inttypes.h>
 #include <limits.h>
 /* Put unistd.h before time.h as that triggers localtime_r/gmtime_r
-- 
2.53.0


