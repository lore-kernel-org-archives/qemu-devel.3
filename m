Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B17C88E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 10:09:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4yB7-00075y-Ly; Fri, 11 Sep 2026 06:08:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x4yB4-0006wc-RO
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 06:08:14 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x4yB3-0007Le-5B
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 06:08:14 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2d8f265cbe6so6883745ad.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 03:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789121292; x=1789726092; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eT2z61ETCwbPUrXaErCLWHNfA53NPyn2CS022Z4AC04=;
 b=A88HGkXRv6Kq3ef8vqbm/cqVYAQy/RKoOrRXFLy1NJP0RhIPTgRHn5ZK7R+/ijq2+7
 dTVEtX1BGqLVPO+/X4owGEvUMbnLvX80n+npo+aF1jJ49ybvEjMRqNkqHy6m/Tfs/frU
 w9XQVaTxxfWVPrIURK3hkmOSg7gp7A+2Rw5nhoSgoCn41qjMLCexvoHXNaPPOfbOhdg/
 ixwvVe0mxe77iG2HUi7CFcM9kL8azpOYsou4pZKPBE403uoNaHVX2vh8Ftydom18GSeK
 gIQSoUc/G403mPiazk3ALXfhfCbToC3oLXCDmwkg/wS6JqucgFGJruZxbTVmg5lb2BQo
 5GgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789121292; x=1789726092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eT2z61ETCwbPUrXaErCLWHNfA53NPyn2CS022Z4AC04=;
 b=f/3Te+2F9MrKI/ExR6FMq8rR6lfYqs+ehKbnd+0r760hpyUxgOx/un1RIY05GeEkGT
 oGD2/OmFJwNDzPwqlDkEpI9QUuMn4tP+LYqkS0cA7w+/3xpKe9GvXeg+DbSw5w0HpArh
 +LqVQ24TtdtjuvbvS4LCiIPA70lMglCkDoESiegt4ZK0xV8r+vsLJPegx5VMfx+d6GvJ
 reqX5HaLMX2lF08h6fDXKiduo2656kKF7etTsgoEuEo2CEOzwGPA4B7ZQ5bRMPB1OXIP
 EAbU8norubvP66pxi87qd5R0eYK84H6MqdcRizYOrcIfvFe7NcPF0pQgzNV3oeI3EdTd
 7l0g==
X-Gm-Message-State: AFuF++kw3yT2ZNOaPhHTaOr9r5iOu0OGK6YAsNo4TIth//4ojC3uVzns
 2nym4Jx1tn5DX/1IxfU/Y+kCw/CfqT28Z3803M64hDpvVwcUmBKzBagEiK/RhlVI8qE=
X-Gm-Gg: AYBFou3otYYcMi9CY4h78Ai/beq9CmcxPu97GyAJmPZKR1ZpjmGtJxJSS3vO4Ok3IHm
 WW+LtLHW7NeziMU8UXUFGGIWH23pNHYKAMwBCwe1dlzczxMjA2mK5C9EHfAA2u04JIpabquM0DR
 ThqgF647TZWpDlWiXaurN5AuMy0jxO+p29fF2bh6CENX2av0OZDn/++izwTj4sL/HF8yTwfN8Oj
 tDZSufvO9CPJisE0K9+c5GfX7gYB9BXLYPZi6ozxOm64Y9P6vu96nydPN571ldad8T8VAFiUSkf
 BJncuPA5pYYzoudd5fmFU0KTeOfT23yIfsq+ADrTvquseZJ0QU5pfXqIUWyu/Eg+SPAIJfDNttW
 W/IjSB8TavHKoYnd1LPAuUZbOLWhFVzTHQhwMWQHjt2O6pDBO8651Q2+NUi+jgLoFMka9gfeREd
 oCHLo0/ChL136wSAVe8WGcAIcNnWLwl3xFm0eZlMqp7uZJP/k9/VCDdG70Kao1HLMhnAJdD5XD1
 rV6+gZDKiPitFmwsUlz0ZdRpJM=
X-Received: by 2002:a17:90a:da8f:b0:381:25ce:bcc2 with SMTP id
 98e67ed59e1d1-39d9bc10072mr5177160a91.6.1789121291620; 
 Fri, 11 Sep 2026 03:08:11 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d951d6b08sm4514800a91.8.2026.09.11.03.08.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 03:08:11 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V16 12/13] iothread: make legacy AioContext getter explicitly
 unsafe
Date: Fri, 11 Sep 2026 18:07:08 +0800
Message-ID: <20260911100709.726366-13-zhangckid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911100709.726366-1-zhangckid@gmail.com>
References: <20260911100709.726366-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Now that holder-aware callers have been converted, rename
iothread_get_aio_context() to iothread_unsafe_get_aio_context() and
update qmp_x_blockdev_set_iothread().

The block graph retains only the AioContext, while detachment happens
outside qmp_x_blockdev_set_iothread(), so this call site cannot provide
a matching holder lifecycle. The new name makes its existing lifetime
assumption explicit.

New code should use iothread_ref_and_get_aio_context().

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 blockdev.c                |  9 ++++++++-
 include/system/iothread.h | 11 ++++++++++-
 iothread.c                |  2 +-
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 6e86c6262f..3bd32feb39 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3683,7 +3683,14 @@ void qmp_x_blockdev_set_iothread(const char *node_name, StrOrNull *iothread,
             goto out;
         }
 
-        new_context = iothread_get_aio_context(obj);
+        /*
+         * We cannot use iothread_ref_and_get_aio_context() /
+         * iothread_unref_and_put_aio_context() here. The block graph stores
+         * the AioContext but not the IOThread, and continues using the
+         * context after this command returns. A matching put would need
+         * to be tied to the block graph's context lifecycle.
+         */
+        new_context = iothread_unsafe_get_aio_context(obj);
     } else {
         new_context = qemu_get_aio_context();
     }
diff --git a/include/system/iothread.h b/include/system/iothread.h
index f6c5f95dd9..9850cdb3dc 100644
--- a/include/system/iothread.h
+++ b/include/system/iothread.h
@@ -66,7 +66,16 @@ DECLARE_INSTANCE_CHECKER(IOThread, IOTHREAD,
 
 char *iothread_get_id(IOThread *iothread);
 IOThread *iothread_by_id(const char *id);
-AioContext *iothread_get_aio_context(IOThread *iothread);
+
+/*
+ * Return @iothread's AioContext without registering a holder or taking a
+ * reference on @iothread.  The caller must ensure that the IOThread remains
+ * alive for as long as the returned AioContext is used.
+ *
+ * This API exists for legacy callers without a clear ref/unref lifecycle.  Do
+ * not use it in new code; use iothread_ref_and_get_aio_context() instead.
+ */
+AioContext *iothread_unsafe_get_aio_context(IOThread *iothread);
 
 /*
  * Register @holder and return @iothread's AioContext.  The holder is copied,
diff --git a/iothread.c b/iothread.c
index 58dace351c..ae9290c733 100644
--- a/iothread.c
+++ b/iothread.c
@@ -422,7 +422,7 @@ char *iothread_get_id(IOThread *iothread)
     return g_strdup(object_get_canonical_path_component(OBJECT(iothread)));
 }
 
-AioContext *iothread_get_aio_context(IOThread *iothread)
+AioContext *iothread_unsafe_get_aio_context(IOThread *iothread)
 {
     return iothread->ctx;
 }
-- 
2.43.0


