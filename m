Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886C2C79F9E
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 08:45:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x38Sj-00041z-SR; Sun, 06 Sep 2026 04:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x38Si-00041M-H4
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 04:42:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x38Sf-00082P-1S
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 04:42:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788684168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JrJhywk8/K5k8v1E3xkVd/lzm4DImmTxfdFH6qyJ30o=;
 b=DXbk4LMfU1zqdgNcjFNNJqmtzbFsqFbrQKjpZzJUBZsB1jMMeheGqMgzVrnKWty0C3dynG
 8cbgbYDVUuZp91/lmzWUczvStOkAQMREc57kMSx9NTST4IocPMY2NPmV4hSrXXMCX852EF
 CoZ3RnR68uHs+etITmf1nGXMqFuJLkY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-EaVXwDFyNzysJI4hJHp2Ew-1; Sun,
 06 Sep 2026 04:42:46 -0400
X-MC-Unique: EaVXwDFyNzysJI4hJHp2Ew-1
X-Mimecast-MFC-AGG-ID: EaVXwDFyNzysJI4hJHp2Ew_1788684164
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E15219540C0; Sun,  6 Sep 2026 08:42:44 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 60D44180034F; Sun,  6 Sep 2026 08:42:42 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 06 Sep 2026 12:42:32 +0400
Subject: [PATCH 1/9] tests/ahci-test: replace HMP usage with QMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260906-nohmp-v1-1-daee96491c43@redhat.com>
References: <20260906-nohmp-v1-0-daee96491c43@redhat.com>
In-Reply-To: <20260906-nohmp-v1-0-daee96491c43@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, "Denis V. Lunev" <den@openvz.org>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, qemu-arm@nongnu.org, 
 Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1362;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=WbTBvG9oIgUqKrxgbCJu2F2Gsj/vybEY1oWEEdcSspk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnSd5v8D/V3ivWlmzTn39mRmZrPNyiMB+aQylZ
 SJm3huKaCuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap0neQAKCRDa6OEJdZac
 5cSBD/4vCgwQ/qkJL1S+O4MwQCJESLBr4CZM/Yyx8vfhEWuTMgVLWLWxinwiPIkRc6DfcFJgFDY
 QHTWkY6dXxfm0G/WXcYGj43bub5JvFOx3/T/tCN5rIpzvRb/fSieK4dL2dD3fbvyedKyx7gNxfb
 kATlAgQxuE/pN2txU3Jef5DecX65LdQKfeCgqLqRkpacL2yE8paDayUmiRYnK/lhXj9CZqVd35c
 yDBdgncQKGByMXamtiNCduyVXV7aD2V/nSMuT/YApwI7XLF8FZtwLvYEHBzwZKTMYVWYn2j2K3+
 gGU6HSHCOwF4Tat8HvBVpMP84U3cwIshfn0U6evQScvA9qL1+mhEMIrsqwVxKySp/Kju7NRa1Iu
 IMsrU/VT3URvLuoJSil45fTA0pFFqdDLaPswhPe0jpSB/do+jwuDVbOEbCLxhoFk0Ys0x1gbc1I
 mW4zS/eGYmk0r6pfOsFfWvS3gCOWPFdPTCFowkdP9phzXbChbqTJ0IXhDWpSxzrowo3j6PzWBI6
 +Br4UddCxwJev5IBAQ89lRbHiKWn4pHIRtJWWVaI0qAPOIwGRyYTa/Ks0PW/RVWAKSEeenywF/3
 TlznvyMCHbnMs1xojbE8HVPjIOY9F9BFJEUx7X1r4AeZSuwqHbrYaMMwSn6d6vDJ2QI4PsbFjNd
 c1ik2U7uFn/5EYw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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


