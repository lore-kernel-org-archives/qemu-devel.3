Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B017ED2FED9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:54:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkoCm-0005JV-T0; Tue, 27 Jan 2026 13:54:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkoBl-0003DO-Ts
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:53:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkoBk-0000lD-F1
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:53:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769539998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R76zFHA7mBI1q9eoSi77GT88w0pRMf4EdgqOQ6+Tjq0=;
 b=ZqiDWYqO16Zx8bj3mt3KgUcaIkvsyR7zZ6KA7vwPdSjbb750Cn7EpixXMwxbx6DWLhhypx
 bWoSRC5tqDE5KaAcEaV1oQMoN+WSpZqRcV9xHtdMxUu596vxfUFiIG04T1uKgy18ThJK8I
 a2Q6PPieqzjMAC9LIq+lv6yb3Rg5fwQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-Hg6ujGI0PQecGQG_gwah8A-1; Tue, 27 Jan 2026 13:53:13 -0500
X-MC-Unique: Hg6ujGI0PQecGQG_gwah8A-1
X-Mimecast-MFC-AGG-ID: Hg6ujGI0PQecGQG_gwah8A_1769539992
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-88a2f8e7d8dso202978546d6.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 10:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769539992; x=1770144792; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R76zFHA7mBI1q9eoSi77GT88w0pRMf4EdgqOQ6+Tjq0=;
 b=BLWYZhOPB7NmIopIkRJSqPk4PH/FZv9oHC3oUaO1hneM/jUGC+YdaNm3Bl4vtCsyEt
 pJddm5TqiSddpZ18s06ZeMGBjr9Jp1oOhpMK/FQtcGb/HZG9Qa0/CnfrN6cfTGSSWb0g
 0QW0sLyuTHXmBJRpAEbnaWKKtLoTyycxbdHcVFYs53CslMLdtBI36eJb5YpwHujXdZD5
 ei1anH1kth9xOThlYVcmXYFSOC7KLhpkFeavDuPZrkmzKzTtA39tvRaoW73IXtHYjQ8i
 L2jeVQAImWUtnzc0MzoXpcADOVXUw573EKArMTh6tB32vIKVDY+WlfOAVktoZJ20iJrm
 uivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769539992; x=1770144792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R76zFHA7mBI1q9eoSi77GT88w0pRMf4EdgqOQ6+Tjq0=;
 b=eCqdoWxAcmcPj0n/ImWo5ybUDE6XKxmAZz+fHJzeUJoSS7SqC9s3o7fZfKoeTf1Vsg
 QyJ2M3O/SLqHJJ8WJk/Tikma5F2LUFcLqhBeK4gjHoB/OkaPexjE0LpmqOLzl5eJRRDD
 SsYIYziEDTMl2uLxO6tdC/iZFMKY5nOkaBae7QaKzoB9Vs4hVNYyq6UCSpjJVdyaFROz
 oVmgcPZXDcFhBuxLG2BefEFg8yxyzcsFkvUKraZ1otUICGZGojJAHKwPnxMUS3nsFs13
 rELa91L38kGdyizZIB4+q3PBzuFNVn+2FRYn0fbgnAgoBb7NlGHgVihDq5xhZFHVgUJw
 ZrGQ==
X-Gm-Message-State: AOJu0YzZigxEIytCHbEiB/q98mMTyr2p7dT384PouXC2vJRV8USCe8IX
 MU7NVZffLj2Vl/3B75icD8jOtcJbjbbFoTyTyAbIRX123F9smbEYyMviFhQRoopc6Xcmuquq4h/
 YZn3CS2gzKMkvIHOg3rZFLbpjP7KDm1+8Nv2Gz0ZHM7aJhD1/GtLMiVIlImY7ZlK0ifOzHlYau8
 4X3QDd2TCMdScqMn2EEekIdZ5/kAfAo6t/M2/Myw==
X-Gm-Gg: AZuq6aLjcBJD0e2M+TT9KUnX6Fhoh7GdChehiTB2pDo684D2OwBiqKuMUQJzM2rKMsr
 QJaO8tOM9Nak0Mo81/tEZ/x7Gt4PiVrUwrJZeDfTyXbF4SqqMWJ31ogX4j1qyKbCgRj66Tlb1XW
 hQnzPsL8iHvrQa87zfJLRuDVEEATWnOAEEEPq462v4WNZ97ry46BYRiYH4JRA1f7bjVLHhAtIk1
 DDerwudKNvOHHXXYu2gyogp70FqfkFkp98OPd4ld56P5UzahXHMb93Hwc641BesVELsJ7YeRThB
 6qBxpsrtzj77jPv8fG6PLudz7gLOtVoAEgbzQMMe+5U0VLPzuGuiIWYpyy1exbjUiUJQNa6McEc
 n
X-Received: by 2002:ad4:574f:0:b0:88a:2444:36e9 with SMTP id
 6a1803df08f44-894cc9788bfmr37281626d6.67.1769539991937; 
 Tue, 27 Jan 2026 10:53:11 -0800 (PST)
X-Received: by 2002:ad4:574f:0:b0:88a:2444:36e9 with SMTP id
 6a1803df08f44-894cc9788bfmr37281166d6.67.1769539991474; 
 Tue, 27 Jan 2026 10:53:11 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-894d3740e54sm2338466d6.35.2026.01.27.10.53.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 10:53:10 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Lukas Straub <lukasstraub2@web.de>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v2 13/24] migration/postcopy: Send device states without
 copying buffer
Date: Tue, 27 Jan 2026 13:52:43 -0500
Message-ID: <20260127185254.3954634-14-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260127185254.3954634-1-peterx@redhat.com>
References: <20260127185254.3954634-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Put buffer can be async as long as the flush happens before the buffer will
be recycled / reused.  Do it for postcopy package data.  Quick measurement
shows a small VM the time to push / flush the package shrinks from 91us to
38us.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 9d2109718a..d41e89228d 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1136,7 +1136,8 @@ int qemu_savevm_send_packaged(QEMUFile *f, const uint8_t *buf, size_t len)
     trace_qemu_savevm_send_packaged();
     qemu_savevm_command_send(f, MIG_CMD_PACKAGED, 4, (uint8_t *)&tmp);
 
-    qemu_put_buffer(f, buf, len);
+    /* We can use async put because the qemufile will be flushed right away */
+    qemu_put_buffer_async(f, buf, len, false);
     qemu_fflush(f);
 
     return 0;
-- 
2.50.1


