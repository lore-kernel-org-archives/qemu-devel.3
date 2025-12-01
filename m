Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 346E9D116FF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 19:46:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ9py-0000nw-Qt; Mon, 01 Dec 2025 14:45:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vQ9pw-0000nD-VX
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 14:45:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vQ9pv-0005IJ-13
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 14:45:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764618326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EQ1mPqJCFbzyT5uTHkDEJzo5K/xfvLuXsCDQhe1Tzzg=;
 b=SM3j70fD/CLGY1ZdLGQxmOni9Ybspmbq2m9qJIKenf3dDL/+vbWlRQe4JO+kGozCvUrAe4
 w4NDnSxzZPSDldIs9nXS7/x+F5754uoWs1krE3Y0XFLiaTgmPEJlvM4OIKZGyeYjo093Tt
 pHy2expDKI1aiwJ68iNlZWecKtiBch8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-UBgrdvXZPsOK3xyEkIXxcQ-1; Mon, 01 Dec 2025 14:45:20 -0500
X-MC-Unique: UBgrdvXZPsOK3xyEkIXxcQ-1
X-Mimecast-MFC-AGG-ID: UBgrdvXZPsOK3xyEkIXxcQ_1764618319
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-880501dcc67so147473956d6.3
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 11:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764618319; x=1765223119; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EQ1mPqJCFbzyT5uTHkDEJzo5K/xfvLuXsCDQhe1Tzzg=;
 b=Vp2KndKLFQhmUBOhhTZOkOEZWv+oV/1uh1R0ddOkhVKql8cv6LCDy7LdruRFFb+Uij
 eT4LyRyi0o6ke32TwcxotOTt8nTE2fg+gZvbub23+lPl6Puk6qLs75Z/iNTxx5dV73gx
 /K2TMfEBwud8gEAFmTAfhhY9DPRBqGvTUtwMy8ndq+voKAZ5yKLqtPBnfewZTjBNrfnG
 IVN/hKC4XnqbvogMd3ib3IOecfJbyAtdLCL/444/CQco90loRsv3ZI19RYvQWs3Vh6f6
 Auo80bQciMwawGfuk0mlYJIrF8wfTN8WwqCCL2Y5K0+uB3zgzZjo0dGC3G3Oyiuf22DB
 Uf6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764618319; x=1765223119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EQ1mPqJCFbzyT5uTHkDEJzo5K/xfvLuXsCDQhe1Tzzg=;
 b=FboT2Vf13H72tRRwQF6eBwLNiSueZw2BXwCaUfNcQeDB0OwO+xHFSYnVA6lEAyaSPw
 qKQOP31A9r1YQ0qd4FbVluRb1JJTAteQjO6m9/dPr8yIDjFsp4NBQtuixm1Mvm4y9/pI
 xsGF4U2F2FZWNxwYFIcS+izKLnYHWurerEJ5/zGWaNQOmrGHmi7EPDeGyAsJxMAmy+me
 /ppa53RBFBCv5T2ooXXOBQd7GKtCiA/4Yl7ulH7tniixcd2VVNiAfQANpQ0VkJiNk7gt
 4GqweeRmvdKwO0+foi58ZRu/it4p+u7eHUdiSzsT+kCQneLtWXldf33KgAzK5R06ionZ
 Zyzw==
X-Gm-Message-State: AOJu0Yzgvo9n+oSanDsfT2GeqRnNKf7jGAoL4Nio9omR0fqXT2jyPr7I
 eMji/qDn7bsQaJEQ11G96omUF0UX3NEydlc5G3EheBwGRayUEDMSlZccDSTJiUIKY/5SsvOPfkv
 2Mc9Y2Rclff+GR/y7nFKysEBhpfCtm6sK1+nWc48GS6lVfDioyCMCiCNo6heS1q/Fb2sa9msg3b
 BZAR/r279zeVonZbJqT5vGYwkVoB40lGk0TEyA8g==
X-Gm-Gg: ASbGnctYrFQKrReT2mSDIjvduHPODpAxOz86dbEQBxKGzZzI2l5dLLRwUi7WsHqLMwt
 baluOdqS1bkhJeUj+oACjNavp4XpeXqPJJVUHEgfrLCYdUE3P8muOVqd7TKBQykE5+jojKFfiQ6
 lXTrgaRsTWJKPQFq2ywxnkaUT38J8nBovEK25My7LMm1UViTo2/C+LRnt8LGRJNf8PI1XFUTADC
 XluT4nEyl8LthcOSiL53vJVP9uDFp7iKYrkpdfDCY0TBKMRiSz1QOIfgMp+iUwztSDslfd2XVBT
 JCm0Z7LNw/ioCgWr65TnQ/AuawscT67h75wNpzqgEZToJ9L4LEGBnWcWoatW538405iIOItr8Hr
 n
X-Received: by 2002:a05:6214:448f:b0:87d:e32:81c5 with SMTP id
 6a1803df08f44-8847c498571mr548828836d6.20.1764618318783; 
 Mon, 01 Dec 2025 11:45:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOtApF8DmjtEs/fysvXlnNsLRXOfJUkCIEWsHoTJbkLgiCCmsAuBgbU3vSS+MtJNU27gl2YQ==
X-Received: by 2002:a05:6214:448f:b0:87d:e32:81c5 with SMTP id
 6a1803df08f44-8847c498571mr548828256d6.20.1764618318338; 
 Mon, 01 Dec 2025 11:45:18 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88652b91ba3sm88835156d6.53.2025.12.01.11.45.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 11:45:17 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-11.0 v2 3/7] error: Poison g_autoptr(Error) to prevent its
 use
Date: Mon,  1 Dec 2025 14:45:06 -0500
Message-ID: <20251201194510.1121221-4-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251201194510.1121221-1-peterx@redhat.com>
References: <20251201194510.1121221-1-peterx@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Markus Armbruster <armbru@redhat.com>

The previous commit reverted support for g_autoptr(Error).  This one
should stop it from coming back.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/qapi/error.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/qapi/error.h b/include/qapi/error.h
index f3ce4a4a2d..2356b84bb3 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -437,6 +437,26 @@ Error *error_copy(const Error *err);
  */
 void error_free(Error *err);
 
+/*
+ * Poison g_autoptr(Error) to prevent its use.
+ *
+ * Functions that report or propagate an error take ownership of the
+ * Error object.  Explicit error_free() is needed when you handle an
+ * error in some other way.  This is rare.
+ *
+ * g_autoptr(Error) would call error_free() automatically on return.
+ * To avoid a double-free, we'd have to manually clear the pointer
+ * every time we propagate or report.
+ *
+ * Thus, g_autoptr(Error) would make the rare case easier to get right
+ * (less prone to leaks), and the common case easier to get wrong
+ * (more prone to double-free).
+ */
+extern void
+__attribute__((error("Do not use g_autoptr() to declare Error * variables")))
+error_free_poisoned(Error *err);
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(Error, error_free_poisoned)
+
 /*
  * Convenience function to assert that *@errp is set, then silently free it.
  */
-- 
2.50.1


