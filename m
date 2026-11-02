Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C9B606A930
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dg0Z/GG4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNuw2-0007Be-BR; Mon, 02 Nov 2026 11:31:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xNuvz-00071X-Pn
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:31:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xNuvx-0002PS-TT
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:30:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793637057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=86i0rL7DSjfukYaVRwz3D8TPMjjCzRt+nIoB6lLMD7A=;
 b=dg0Z/GG4tzSKv4TickP4v+hshP1ON7HQ6VEewwh2MmaVNVlZWImTvYUkq+Dw9kSaQMfl1t
 L1L557ImuvTH4LQMq7jugcaT7GGEqZt0EJLswg9zm1F4Y3CwYEDWVluf9cLc/oTvIvaq+t
 UIwkLLezergonpP9urdvqzLzxWgr+1I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-532-CRXO7bpKOnqVZLpWtTh6Hw-1; Mon,
 02 Nov 2026 11:30:55 -0500
X-MC-Unique: CRXO7bpKOnqVZLpWtTh6Hw-1
X-Mimecast-MFC-AGG-ID: CRXO7bpKOnqVZLpWtTh6Hw_1793637053
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E99C1955F08; Mon,  2 Nov 2026 16:30:53 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.48.50])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B78C51800347; Mon,  2 Nov 2026 16:30:51 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Junjie Cao <junjie.cao@linux.dev>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 3/5] usb-host: reset the open retry count after a successful
 open
Date: Mon,  2 Nov 2026 17:30:42 +0100
Message-ID: <20261102163044.644663-4-thuth@redhat.com>
In-Reply-To: <20261102163044.644663-1-thuth@redhat.com>
References: <20261102163044.644663-1-thuth@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Junjie Cao <junjie.cao@linux.dev>

usb_host_auto_check() gives up on a matching device once three opens
have failed, and clears the failure count only when a scan finds no
matching device at all. A device that re-enumerates, e.g. after a
firmware reboot, is closed on NO_DEVICE and usb_host_close() rescans at
once, while libusb still lists the old address: that open fails and
counts, the next 2 s scan opens the new address, and nothing clears the
count. After the third such cycle the device is skipped until a scan
finds it absent or the usb-host device is re-added.

Clear the count once an open succeeds. A device that cannot be opened at
all still stops after three attempts.

The source-level fixture attached to #4673 reproduces the same sequence;
its remaining cases expect a failure budget per enumerated device, which
this change does not add.

Fixes: 3ee886c5ba77 ("usb-host: limit open retries")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4631
Buglink: https://gitlab.com/qemu-project/qemu/-/issues/4673
Cc: qemu-stable@nongnu.org
Reported-by: Farid <fa1rid@live.com>
Reported-by: Prateek Rungta <https://gitlab.com/prateek2>
Suggested-by: Farid <fa1rid@live.com>
Signed-off-by: Junjie Cao <junjie.cao@linux.dev>
Message-ID: <20261028160727.780978-1-junjie.cao@linux.dev>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/usb/host-libusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index 8f7ced95cfe..5a369e2ebf5 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -1924,6 +1924,7 @@ static void usb_host_auto_check(void *unused)
                     s->errcount++;
                     continue;
                 }
+                s->errcount = 0;
                 break;
             }
         }
-- 
2.56.0


