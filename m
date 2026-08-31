Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED68C624A5
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 16:03:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x14Sn-0003hZ-LS; Mon, 31 Aug 2026 12:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x14Sb-0003DR-73
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 12:02:17 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x14SZ-0001jY-Li
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 12:02:12 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2d71d1cc8b2so32635585ad.1
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 09:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788192130; x=1788796930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=clK7NAadLjai2hYCbo19w/+DIioUQ3aPdbUwnfpG/gs=;
 b=Xs32XbzH3k0UxsOJWJ6KkZGMt7sQrwZM6/pMtOZz89ztqLiuQGK4cTofSebmRpDOR9
 gitzqwNfy0xyiR8lX14XA9xXCS/z7KueSQsYy56cnGvPBmPRbf/Ibx+9YUakx+SVZ5Cs
 SPPODf12sDset/Y06yxSWULXgtSIzMgY5/1Mrz5VlAfQrh3okWWIFFilq1nyD/A1HGRk
 4IxLcS6XMcYkAfC8XkXuocf/OAOh9PeuT1xXmcqJYDKtp+fTgJapMlIje1WQeF2JCysq
 6O4Si1p49jF7QF4MXXaeBWclLj8Oe12pP+2RhQrjQRhy7cPnhZEZrVSrXRwLYxunsHyc
 OlWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788192130; x=1788796930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=clK7NAadLjai2hYCbo19w/+DIioUQ3aPdbUwnfpG/gs=;
 b=gxMdF6NusaMma8oolHEvuZBlpYagmDs0IBpeg1tSgvOvM2Yo6RJp5GvxsR6CZ8Rzdp
 QSw+EeCB0EOzPCZv4F9+52q50PEn6DxC73VA47rhiFz4CQWeInIhX1Fov4DWBtcJiv23
 w/7diKhFhmNnz07p556hyaunKa3mWHaajCP6sylWzEO1kKKEMt1EeXfCUOG75nOCiDDq
 pC10Dn7GGLOdueJw3KPKqnn5sUWXIToOmE9yz/Ka5MDM0SaxADsWtNLceoIFdjBBU+wD
 7ltm9wQGUGZ5YIaX3YJD2hQ0JGgRT0I5B4o5K28aOUUuh/q3NoiE2IVrAB79H32bIiG5
 J1MQ==
X-Gm-Message-State: AFuF++mq7ALLQ+D3PugwcOsQ1YEWUTXgPerskVHIniEb3ULLx19KVc7O
 DgjyjKK3430SPOILflUgRjoT752+b7jntQ9vUiD+iIUzwOuOwU56VTQ8e1lgSPYVeyoyMi0e
X-Gm-Gg: AYBFou0rtx51fMyHRZSz0BJLhFgUqWZYxXnRdCnA2ASDCXw4b7M6llM0McfCtfXqzxr
 Pxb1+BD+g4yrfnkW0bATPCtLpbK3PzwgBK2vOffodb5AWG61vx4LBKsQL9Lpz3/hsxywcXXoQIH
 /aQVID+H8Q2ZHHNSY2rHD/GY0rXT4s0r/zGbFoMtvsr55kwoyr5Sm6yYchOojrfo6hvdffEsxKV
 67tyD/7l5vghhzYq5V4+bahuEOXac7UGwU6vBlUsByvW5cVORoZs0HUchV6EhQLA4kztXMV/xxZ
 iiXvOyABieql6HMDFqe+fPXZhpZiBp+J+/gDb0oxqNPv0EMVIOpI+99bI9CUQje81BkI9PqBQhs
 Boy4zInZu3rmItyZeSesh8Y2QRgawIV5a1mmCeVxHuu9IAgDJFlotLPe6YEvrnvuRCy3rBTC90F
 Xyu3gCNqLjuifLJn7PGN8ZlU1IaKqmck/CVsxslVG94xtmz78NOdpAVoylah5syxV+hM8mYfDfR
 nh1JuO/
X-Received: by 2002:a17:903:38c3:b0:2ca:e19c:97b with SMTP id
 d9443c01a7336-2d74dc30f3cmr460226265ad.5.1788192129951; 
 Mon, 31 Aug 2026 09:02:09 -0700 (PDT)
Received: from catgo-fnos.taila0cd24.ts.net ([104.28.201.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32b28ab0571sm22689520eec.4.2026.08.31.09.02.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 09:02:08 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V14 14/15] iothread: remove legacy iothread_get_aio_context()
Date: Tue,  1 Sep 2026 00:00:35 +0800
Message-ID: <20260831160038.221776-15-zhangckid@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831160038.221776-1-zhangckid@gmail.com>
References: <20260831160038.221776-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: 26
X-Spam_score: 2.6
X-Spam_bar: ++
X-Spam_report: (2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

All production callers have migrated to either the holder-tracking
iothread_ref_and_get_aio_context() API or the explicitly unsafe legacy
accessor. Remove the now-unused ambiguous getter.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 include/system/iothread.h | 1 -
 iothread.c                | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/include/system/iothread.h b/include/system/iothread.h
index 2ef8c1a1bb..9850cdb3dc 100644
--- a/include/system/iothread.h
+++ b/include/system/iothread.h
@@ -66,7 +66,6 @@ DECLARE_INSTANCE_CHECKER(IOThread, IOTHREAD,
 
 char *iothread_get_id(IOThread *iothread);
 IOThread *iothread_by_id(const char *id);
-AioContext *iothread_get_aio_context(IOThread *iothread);
 
 /*
  * Return @iothread's AioContext without registering a holder or taking a
diff --git a/iothread.c b/iothread.c
index 803d6ce3c3..3a092119ee 100644
--- a/iothread.c
+++ b/iothread.c
@@ -422,11 +422,6 @@ char *iothread_get_id(IOThread *iothread)
     return g_strdup(object_get_canonical_path_component(OBJECT(iothread)));
 }
 
-AioContext *iothread_get_aio_context(IOThread *iothread)
-{
-    return iothread->ctx;
-}
-
 AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
                                              const IOThreadHolder *holder)
 {
-- 
2.55.0


