Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C02C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 09:53:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3sV6-0004Bz-U4; Tue, 08 Sep 2026 05:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3sV6-0004BQ-92
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 05:52:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3sV4-0002d5-S7
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 05:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788861142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o4wZ10w5TCyFWkISKjZMdAhqDtOFEX7Ga9DDoZ/ZUjk=;
 b=VLE2yb9X99k2PGLNP1mlwaM9oJQAPEsZleRzOrOPkr9M9tYo8/XARLsSBnbh67B/IFn8mZ
 jMpxnck7azeEwyiirt2dzTefeXGE28XfptBjznCRr9zoONhLFzDhKAZLoaL1GCwIKJFLl9
 xtrsCb9N1/tw8DWTQ2l8G+IqpcONudo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-F2IiXjQIPC6FjMf4t-3_RQ-1; Tue,
 08 Sep 2026 05:52:19 -0400
X-MC-Unique: F2IiXjQIPC6FjMf4t-3_RQ-1
X-Mimecast-MFC-AGG-ID: F2IiXjQIPC6FjMf4t-3_RQ_1788861138
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 12F86195DE2F; Tue,  8 Sep 2026 09:52:17 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5110718005AD; Tue,  8 Sep 2026 09:52:14 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 08 Sep 2026 13:51:54 +0400
Subject: [GIT PULL 05/10] tests/ahci-test: replace HMP usage with QMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-nohmp-v1-5-b19b693a5665@redhat.com>
References: <20260908-nohmp-v1-0-b19b693a5665@redhat.com>
In-Reply-To: <20260908-nohmp-v1-0-b19b693a5665@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, John Snow <jsnow@redhat.com>, 
 "Denis V. Lunev" <den@openvz.org>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1464;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=b+lTBCsun6YleRr58wgZMzenJkZsl+BywditbLZ0aZE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqn9q6mSq1RDJSe/mJ4J0zWjIcUI0EarLt1FhA/
 DGlvE5hdW6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap/augAKCRDa6OEJdZac
 5eeoD/9iElKdEuMic/HLymtC8JgwaOAtFssu8cYHsKGKllAA8bV1sdd6rFCRBAA5yzC4kfV2k6W
 0rQcVNKhn9cybY8QSKBi4gzqR0461f+5pMp7C+lTqDbtgmAa/IhkGo2/AlqYlkXqKfo4FiuAss0
 9AtEmhT0wpk73uUnZLlGAk6Jpyu92choePo9z8l5lmF1BvKTX9u43gSKMr/loopd5pQLG9HpamL
 E39EK5CUUNJIyalZqIEASCYAN68ki9jHTSou4ksGK1tAoJXHJbvsexwhAESX/8925gSZ9FWFfzM
 N6x0LCDmRIDr4dq+IW5UTRiuMgIdxcrzLjUPbdvUVdpVjP1D5rodrTbfiPOZm/ho3h2KMEqxFmz
 lAalD0ZB7sOVwtrvxZX1EM3K5iwZnATJYjh3ChQYdmw7ZIQiCvThhUnMBE3pqejiEb7ddZtW82j
 QXdqm3zRCEG1NrA1W1Mfna179TlNjlrrcSg9jfaiMhK4ZzUB+nMzqxh491oVtve47iLj3+SRpOU
 8TijkPIXgisQX+EQ3O4jssTDR9ypkAoZifcutWJ4sDUL4bmdDUtCxZEGmlo/H/qaE6ScS0I2aOy
 rMRsdYgQ9TV2JlUNejSBs/lwcA+GA399EjaeagDs2jkMtv66j7GYEKipANpmHsjU53AJH46bG5z
 Z2+MQb8wIUkB3Ng==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Use qemu-io command instead.

Reviewed-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/ahci-test.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index 3406ca884fb4..eb8d23999738 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -1900,8 +1900,7 @@ static void test_write_engine_stop_in_flight(void)
     ahci_io(ahci, port, CMD_WRITE_DMA, rx, AHCI_SECTOR_SIZE, 1);
 
     /* Suspend the backend write so the first sector stays in flight. */
-    g_free(qtest_hmp(ahci->parent->qts,
-                     "qemu-io drive0 \"break write_aio wr\""));
+    qtest_qemu_io(ahci->parent->qts, "drive0", "break write_aio wr");
 
     cmd = ahci_command_create(CMD_WRITE_PIO);
     ahci_command_adjust(cmd, 0, ptr, bufsize, 0);
@@ -1911,7 +1910,7 @@ static void test_write_engine_stop_in_flight(void)
     /* Drop the command list while the write is still outstanding. */
     ahci_px_clr(ahci, port, AHCI_PX_CMD, AHCI_PX_CMD_ST);
 
-    g_free(qtest_hmp(ahci->parent->qts, "qemu-io drive0 \"resume wr\""));
+    qtest_qemu_io(ahci->parent->qts, "drive0", "resume wr");
 
     /* Round-trip through the device to confirm qemu is still alive. */
     ahci_px_rreg(ahci, port, AHCI_PX_TFD);

-- 
2.55.0.543.g5ebe2ebe4ea8


