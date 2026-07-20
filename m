Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 234D5C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 14:59:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlpSZ-0007Ij-LN; Mon, 20 Jul 2026 10:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wlpSS-0007HU-JY
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 10:59:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wlpSQ-0006kN-V7
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 10:59:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784559542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tT37CVdZFUfdLwzI+RtDkemwBSJZNYZtp/hv39esPxs=;
 b=KiecJeEuAJLDS+WfSqWzudvM3o6WpAwEvQANLnBCLPXYDUEhKXPTEa9oX9Co0OSGwkZQA+
 ZkFz99EEa+kV4DgZFny2j7uixBkQb35dhwjh8mF1RT5MEXI8BQlJLUI1W4m57A3Wdocu2/
 6ulWo9buP7XyhLoLrtplnH9DfOuopeU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-Y80jMTXpMSuWcK3N6ApO1g-1; Mon, 20 Jul 2026 10:58:59 -0400
X-MC-Unique: Y80jMTXpMSuWcK3N6ApO1g-1
X-Mimecast-MFC-AGG-ID: Y80jMTXpMSuWcK3N6ApO1g_1784559539
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51bff5c7035so94462971cf.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 07:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784559539; x=1785164339; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tT37CVdZFUfdLwzI+RtDkemwBSJZNYZtp/hv39esPxs=;
 b=JWMeCUg4nCk4/D+dhfYLDi8ppxzj8DDHnK+Fb3OCCS2HcBia2eDbONEOV4qHZk4njK
 vKHgVTZq9feuEUzikJqAx0aVMUK9fYCgOfdcM5A1ShTJ5eFTReJpxDBnJ2otd2uho9tt
 6Lho5QFowyBx3MYnzjZjPnZAhb+WIj8htLn9sa13hIl41PphW9jY5AyC5r49teJfbSTp
 Vp28e1hNT6z6/k49RyE3DH8HEY041YjPfG5OuaC9M4UHBOQpM/3WU+etBd6MxwGOFXdm
 1GgsfwHsIsXvktndNg30QfZC6OwydC+lWIQ62DoFES+tEtTJKOdks7YVbRpT4NRAmvo1
 ljnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784559539; x=1785164339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tT37CVdZFUfdLwzI+RtDkemwBSJZNYZtp/hv39esPxs=;
 b=lMgEosVeDZcMexMlCHC1rKPjC/BWboGBMb+pLmkSjVO+ghjt80gY9/wjH3Y+lAl0X/
 HBPMjdtQDdNBSZ5ijkKn11wdaLmhtbHhpmfSHb0irWc+HawpP/y1j+uQQdcxQLBfOYT7
 WCnr8Nulyxvavd3ZNEBbzIkqEU+TJwb/5Gx9ODt3++l48z06mLOrjjgy0GfYBJ4fCOKl
 Uc52rFaAQ7HrTLk8SPsgk4gW08DztlvJnc1o9soZvwjeB3ti+JPIPvjCZcWibgFtuzYu
 BRstfU8F/A+sl2FHgKO8iTogu/LCX77iPk3frhjouj08dCCcpEqSZ6WVuSkcwIAEC4mi
 OFaA==
X-Gm-Message-State: AOJu0YzdtqGOjaT6nhvwZk9KRh8oPM8AhrAUbOKbtf4RJTcDujrijNUF
 8TiByrOfYtMm/LB5rkSN9SjOhl7ruoi6/o1B1I1AiviZ/1qAFrmHCZb5buKH/V+GR6/1ZcQq/01
 qdL9J4TQBOjAQFKKyj8cD+Q8eRoJmGLzee8XUkhJbBoF0J38rfGfjfxWyrbfGzJA/Ed/N7dzlaB
 CuYojLHo9BvWS5daIhvfD+rpi1iJgAjJmel5UKdg==
X-Gm-Gg: AfdE7clOUTM0nPkJhhrlVpNawO/gcTSpwMh0wsCJNmhWLgUsDEdoQAGoejtbIYgkqsW
 mQzOE6BT4LHrwyc5ItuI5SeSESWv94ePF4Nt6g7L2FgBT9dhttGSKMpu09rOpAesclOzElReJsC
 UK9x9GZylVGOuzUKJXcago1Ma/Btc7Zj5bid6Pbc92bKUkXNkYo8kMJ9dbtc6Kl/1fzwvkIqYon
 4YZD1Lft+BtsdxGZwx2QXR9ZCgOVZNEkO4eMtYLb02QkuDApiEHUoREPzTpXWAFwFDNKogviyMZ
 pq8wtfRkIJ0c4Cy36r35ahccOOem2jzqtkFtEVQc6n9sEJWZS5X6//pEpPy1Fu3ywA==
X-Received: by 2002:a05:622a:181f:b0:51a:8c86:bd3c with SMTP id
 d75a77b69052e-5213c9d9a01mr147396581cf.57.1784559539191; 
 Mon, 20 Jul 2026 07:58:59 -0700 (PDT)
X-Received: by 2002:a05:622a:181f:b0:51a:8c86:bd3c with SMTP id
 d75a77b69052e-5213c9d9a01mr147396131cf.57.1784559538664; 
 Mon, 20 Jul 2026 07:58:58 -0700 (PDT)
Received: from x1.com ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-521502b9d5bsm75640391cf.31.2026.07.20.07.58.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 07:58:57 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Xu <peterx@redhat.com>, yujun <yujun@kylinos.cn>
Subject: [PULL 1/3] migration: Fix invalid %ud format and trace arg typo
Date: Mon, 20 Jul 2026 10:58:51 -0400
Message-ID: <20260720145853.1483307-2-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260720145853.1483307-1-peterx@redhat.com>
References: <20260720145853.1483307-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=peterx@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

From: yujun <yujun@kylinos.cn>

Standard printf has no %ud conversion; glibc treats it as %u followed
by a literal 'd', so postcopy userfaultfd error messages printed event
values like "5d" instead of "5".  The same typo existed in two postcopy
discard trace format strings.

Also rename the misspelled ram_save_iterate_big_wait() trace argument
milliconds to milliseconds.

Fixes: 00fa4fc85b ("postcopy: Allow registering of fd handler")
Signed-off-by: yujun <yujun@kylinos.cn>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20260630031324.43453-1-yujun@kylinos.cn
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/postcopy-ram.c | 4 ++--
 migration/trace-events   | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index f5ef93f193..980b938a4c 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -1368,7 +1368,7 @@ static void *postcopy_ram_fault_thread(void *opaque)
                 }
             }
             if (msg.event != UFFD_EVENT_PAGEFAULT) {
-                error_report("%s: Read unexpected event %ud from userfaultfd",
+                error_report("%s: Read unexpected event %u from userfaultfd",
                              __func__, msg.event);
                 continue; /* It's not a page fault, shouldn't happen */
             }
@@ -1443,7 +1443,7 @@ retry:
                     }
                 }
                 if (msg.event != UFFD_EVENT_PAGEFAULT) {
-                    error_report("%s: Read unexpected event %ud "
+                    error_report("%s: Read unexpected event %u "
                                  "from userfaultfd (shared)",
                                  __func__, msg.event);
                     continue; /* It's not a page fault, shouldn't happen */
diff --git a/migration/trace-events b/migration/trace-events
index de99d976ab..3b1258c3bf 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -21,14 +21,14 @@ loadvm_postcopy_handle_run(void) ""
 loadvm_postcopy_handle_resume(void) ""
 loadvm_postcopy_ram_handle_discard(void) ""
 loadvm_postcopy_ram_handle_discard_end(void) ""
-loadvm_postcopy_ram_handle_discard_header(const char *ramid, uint16_t len) "%s: %ud"
+loadvm_postcopy_ram_handle_discard_header(const char *ramid, uint16_t len) "%s: %u"
 loadvm_process_command(const char *s, uint16_t len) "com=%s len=%d"
 loadvm_process_command_ping(uint32_t val) "0x%x"
 loadvm_approve_switchover(unsigned int switchover_ack_pending_num) "Switchover ack pending num=%u"
 postcopy_ram_listen_thread_exit(void) ""
 postcopy_ram_listen_thread_start(void) ""
 qemu_savevm_send_postcopy_advise(void) ""
-qemu_savevm_send_postcopy_ram_discard(const char *id, uint16_t len) "%s: %ud"
+qemu_savevm_send_postcopy_ram_discard(const char *id, uint16_t len) "%s: %u"
 savevm_command_send(uint16_t command, uint16_t len) "com=0x%x len=%d"
 savevm_section_start(const char *id, unsigned int section_id) "%s, section_id %u"
 savevm_section_end(const char *id, unsigned int section_id, int ret) "%s, section_id %u -> %d"
@@ -119,7 +119,7 @@ colo_flush_ram_cache_begin(uint64_t dirty_pages) "dirty_pages %" PRIu64
 colo_flush_ram_cache_end(void) ""
 save_xbzrle_page_skipping(void) ""
 save_xbzrle_page_overflow(void) ""
-ram_save_iterate_big_wait(uint64_t milliconds, int iterations) "big wait: %" PRIu64 " milliseconds, %d iterations"
+ram_save_iterate_big_wait(uint64_t milliseconds, int iterations) "big wait: %" PRIu64 " milliseconds, %d iterations"
 ram_load_start(void) ""
 ram_load_complete(int ret, uint64_t seq_iter) "exit_code %d seq iteration %" PRIu64
 ram_write_tracking_ramblock_start(const char *block_id, size_t page_size, void *addr, size_t length) "%s: page_size: %zu addr: %p length: %zu"
-- 
2.54.0


