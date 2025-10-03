Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB23CCCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 15:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4hv3-0005Ug-0p; Fri, 03 Oct 2025 11:42:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4huo-0005ME-8b
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:41:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4hty-0007kL-LF
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759506049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CwRpFMPDqsMFjDqWLCLJa2x6iFH7SrRG0NI2Wano0iY=;
 b=FsNiRcp7Od5f8zRV0B9f6hGhHjPUH6jCgyNHUKyNzwv9uEZhc8uxf14/UGSwVwhu/8R2/X
 ebM5t7vDhD8RIYMjzk1mTjMZ2JLfkdERnaQas2lXdSg6TVkra77B1W18Rh+m9vpZX5nvUp
 0o0v2SjMOTM+76F6mL6DcuoiKsOXH1k=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-YCbERX1EMfmxAjgrnTWOSw-1; Fri, 03 Oct 2025 11:40:48 -0400
X-MC-Unique: YCbERX1EMfmxAjgrnTWOSw-1
X-Mimecast-MFC-AGG-ID: YCbERX1EMfmxAjgrnTWOSw_1759506047
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-818bf399f8aso58423206d6.2
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 08:40:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759506047; x=1760110847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CwRpFMPDqsMFjDqWLCLJa2x6iFH7SrRG0NI2Wano0iY=;
 b=poxblUQWJ3FTu42iVnAOLESHuu9IQXmPom2hZeuyOkozXX9fgHBzPoR6k0QwoMU9R1
 Qxvro85lQDRDWC+cauC4VvCT3TDm5TzCk4xrEH+1B7JWzvygzRtt1tinClJs1ICpTJJ4
 SIknqfaux9TMGX3ez38I5WHvAUVwtLdl06IauV5C6QVebxhWnomSiwfATLudS9qla7wK
 1J6VN/v407ClNP2WzhDuv9QEzB2T6jv3tKSJCHMyoXCisAgr15ZxztIKp9JDHfiVDlzz
 SWlePRjCa8nFYzPOtOvBCPkjcr8i9vqnDHieWhDNt0hYScz5EpQ92K381ODOVncP2Ovb
 /bOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZp5SAx7S/6OoWMvXdfFMS1ayCZB4n7HfREZnrlSqalKWXCZcgIjUS5ypwoHTMCEOtipjn4pgxJavD@nongnu.org
X-Gm-Message-State: AOJu0YwGMu32Xo56kuppWX14zcq1gIBAybtDgMAgvWjueIl484ta7I4k
 1HXDdXUyY2mqyS85QOaNQLpRIeFthIjoEqwDNnIIuJgtOfock/hkxB8ZRChjNLuBwhgp5+ekuar
 oBW7iAAAYxLYtZohc5ZEM8R/nB3NhQIuUVTf7Y0IIGDmqkwymxBsmjhR0
X-Gm-Gg: ASbGncu7lgFK1nsudZyS6Z7NUccW2sunUVcIG2YK1DCHiLEyUNQkw9dFABU+e2MvlVx
 /4XSGBULm4BzUJ9n+EPZkrv2UKbSRNEf2aN6GCWEjiZKDw8lGF0cVa6IoTIy09twJtnNaolpbBy
 Ns+YrbNynSupPFdbZTET3SqK20lyVFz0pMK/FCtTporGe7ye4FLWrA+dm9/8y1VrYCQNsgPT/hu
 CL17yFS5PbHxczevdD2OeszFRGkXrWJCFrz0Os8nCY+psb8JYWo3s/aNfmpuTMh6/yOWICJeGdC
 hEDogt0vtlqGspuU+IGFUr6Gn7ntO/wFmfdNGw==
X-Received: by 2002:a05:6214:1942:b0:7d2:e1e6:f79f with SMTP id
 6a1803df08f44-879dc864efamr46959606d6.47.1759506046957; 
 Fri, 03 Oct 2025 08:40:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQYpQtp1ywhWg+KRyL43zFJOwtxERh4o3QdTCZ9yGy7+SPg/D9+AMzcYUR6Uylol1FMmhenQ==
X-Received: by 2002:a05:6214:1942:b0:7d2:e1e6:f79f with SMTP id
 6a1803df08f44-879dc864efamr46958726d6.47.1759506046076; 
 Fri, 03 Oct 2025 08:40:46 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bb53d91fsm40656746d6.23.2025.10.03.08.40.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 08:40:45 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 39/45] oslib: qemu_clear_cloexec
Date: Fri,  3 Oct 2025 11:39:42 -0400
Message-ID: <20251003153948.1304776-40-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251003153948.1304776-1-peterx@redhat.com>
References: <20251003153948.1304776-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Steve Sistare <steven.sistare@oracle.com>

Define qemu_clear_cloexec, analogous to qemu_set_cloexec.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/1759332851-370353-4-git-send-email-steven.sistare@oracle.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/qemu/osdep.h | 9 +++++++++
 util/oslib-posix.c   | 9 +++++++++
 util/oslib-win32.c   | 4 ++++
 3 files changed, 22 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 1b38cb7e45..ed3e511a8e 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -689,6 +689,15 @@ ssize_t qemu_write_full(int fd, const void *buf, size_t count)
 void qemu_set_cloexec(int fd);
 bool qemu_set_blocking(int fd, bool block, Error **errp);
 
+/*
+ * Clear FD_CLOEXEC for a descriptor.
+ *
+ * The caller must guarantee that no other fork+exec's occur before the
+ * exec that is intended to inherit this descriptor, eg by suspending CPUs
+ * and blocking monitor commands.
+ */
+void qemu_clear_cloexec(int fd);
+
 /* Return a dynamically allocated directory path that is appropriate for storing
  * local state.
  *
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 14cf94ac03..3c14b72665 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -305,6 +305,15 @@ int qemu_socketpair(int domain, int type, int protocol, int sv[2])
     return ret;
 }
 
+void qemu_clear_cloexec(int fd)
+{
+    int f;
+    f = fcntl(fd, F_GETFD);
+    assert(f != -1);
+    f = fcntl(fd, F_SETFD, f & ~FD_CLOEXEC);
+    assert(f != -1);
+}
+
 char *
 qemu_get_local_state_dir(void)
 {
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index 84bc65a765..839b8a4170 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -219,6 +219,10 @@ void qemu_set_cloexec(int fd)
 {
 }
 
+void qemu_clear_cloexec(int fd)
+{
+}
+
 int qemu_get_thread_id(void)
 {
     return GetCurrentThreadId();
-- 
2.50.1


