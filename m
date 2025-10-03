Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D1CCAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 15:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4hv1-0005UI-QK; Fri, 03 Oct 2025 11:42:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4hup-0005MF-84
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:41:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4htw-0007jp-3O
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:41:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759506047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WqocyWG1LBH4wXGlFGp2owmJemRIsk1aJQVQrVgGs88=;
 b=DjYD0WUBlMAZgwBJk0yvzZsapeMNfya+ZfkoM/v02T8GZ1ufscEVwPuRwVqLQ1o5qeLfA1
 6TXabiYJINtsgXiI2CQcgGh5Yjuej+zSfZc5LHva3FJOcpDkObKhj7WN9Kv0KIRRDhvGC+
 3uIRynXxWSDTwh7ymnNV+3d+xkXluLg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-NKttQMI7OrW1o2kKvzpEiw-1; Fri, 03 Oct 2025 11:40:45 -0400
X-MC-Unique: NKttQMI7OrW1o2kKvzpEiw-1
X-Mimecast-MFC-AGG-ID: NKttQMI7OrW1o2kKvzpEiw_1759506045
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-7a758650abdso78571006d6.3
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 08:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759506045; x=1760110845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WqocyWG1LBH4wXGlFGp2owmJemRIsk1aJQVQrVgGs88=;
 b=eiPToBjcaRCQ0iLmITSurHSWug2kYqMUlxtD/XQAN6A0e+ZZqAsQ7KYTt22MLCR/UX
 yvisKjNrzojVXJDI3vg6ODYm9FDZfv1I+C9AHCaRnuKjp2s3CoBpMQwq+oLvltdMkcDP
 rZTk4pV+0M0PB8FSGnW0z4CTe0yq3K0UNAb1B4HfNDh/rpNKTKu33xvxLus2KyNrit4M
 EEumyKDUVCEhMdH8cUgXQMQtxM6QScDVHED9AyCEzkqBHfNFzDocPGKMmXGXTg+2KsVl
 tALmY0lsyBd8n2LSL6V8/ItL2yvnZZupd9+X5SCiiY9+ORB3Ir/BYcPNCy4ys5pZUsJc
 21BQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKHjTeGaystIZ2dHoNRq4rliMtUNHj8w9cidCf9r/fSfHXcynxbDitmZleW43mOQPeI9P6aEhMoL48@nongnu.org
X-Gm-Message-State: AOJu0YyASyItYKPKC5x3q+D/GFSofXu+hMFIOnw8PKnlDHxTuOviD0wt
 49ba8z4Og1TriqtdV/L5OeVrOugXR6AfqMqCXOsGPBbR7FXDbUyMXNrD9DshIwd5tHt3ItKDL0t
 g+UueHRaziR27Ik1PMGh9R+x4bkXUKqqmT8voFNIUGFLyD1vWjn/1aKpn
X-Gm-Gg: ASbGncu6EK5IoqjqdLpHaFY/3AR7KvTmCSuy+9Gr3LqQTRP7T1BPePIkWaIIL1SyadQ
 Um4zLOv3RRv17g1m+WXD0z//7vjmCYgXwj8yMvKYQBG/TAu6L+8McLfdqfwtkXHuI8697fz691c
 CCp4af6mOQTxGgh7QAdtUKXhLT9jK2frWoEnVF4sPx0ZzpDz0Ur7UeQj/yawx7cW3gChuDrudxj
 8oMxlzcCwPFunlmI6n/FXSF5qSIE8KYY2lO9eqbU3+m8n1o6ii7lcQG6MkG8koZhr8gsEHKh5xG
 +MHvi30gS2Tn/inOLRLixnwlAk80N/czva/nfQ==
X-Received: by 2002:a05:6214:d0a:b0:78d:ae5d:961e with SMTP id
 6a1803df08f44-879dc82fab5mr47192816d6.44.1759506045338; 
 Fri, 03 Oct 2025 08:40:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHS7qnSlCVSinkZPEzu+BUfFPuub1Zo47fX1/tej294Ob+pbPO35C5bI46xp3ZUbnrgd+kaUA==
X-Received: by 2002:a05:6214:d0a:b0:78d:ae5d:961e with SMTP id
 6a1803df08f44-879dc82fab5mr47192436d6.44.1759506044842; 
 Fri, 03 Oct 2025 08:40:44 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bb53d91fsm40656746d6.23.2025.10.03.08.40.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 08:40:44 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 38/45] migration: add cpr_walk_fd
Date: Fri,  3 Oct 2025 11:39:41 -0400
Message-ID: <20251003153948.1304776-39-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251003153948.1304776-1-peterx@redhat.com>
References: <20251003153948.1304776-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Steve Sistare <steven.sistare@oracle.com>

Add a helper to walk all CPR fd's and run a callback for each.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/1759332851-370353-3-git-send-email-steven.sistare@oracle.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/cpr.h |  3 +++
 migration/cpr.c         | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index 3fc19a74ef..2b074d7a65 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -34,6 +34,9 @@ void cpr_resave_fd(const char *name, int id, int fd);
 int cpr_open_fd(const char *path, int flags, const char *name, int id,
                 Error **errp);
 
+typedef bool (*cpr_walk_fd_cb)(int fd);
+bool cpr_walk_fd(cpr_walk_fd_cb cb);
+
 MigMode cpr_get_incoming_mode(void);
 void cpr_set_incoming_mode(MigMode mode);
 bool cpr_is_incoming(void);
diff --git a/migration/cpr.c b/migration/cpr.c
index e0b47df222..6feda78f1b 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -122,6 +122,19 @@ int cpr_open_fd(const char *path, int flags, const char *name, int id,
     return fd;
 }
 
+bool cpr_walk_fd(cpr_walk_fd_cb cb)
+{
+    CprFd *elem;
+
+    QLIST_FOREACH(elem, &cpr_state.fds, next) {
+        g_assert(elem->fd >= 0);
+        if (!cb(elem->fd)) {
+            return false;
+        }
+    }
+    return true;
+}
+
 /*************************************************************************/
 static const VMStateDescription vmstate_cpr_state = {
     .name = CPR_STATE,
-- 
2.50.1


