Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962B4C624C6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 13:54:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x12R6-0004CI-Hc; Mon, 31 Aug 2026 09:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1x12R5-0004C3-Qa
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 09:52:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1x12R4-0003xj-8p
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 09:52:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788184349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FxuTKKPfZBG3LeAl6yXpicni4GMm8MaEJLalJaIjD3I=;
 b=M3fbpimhoAWKd3SwmANXZVqD5qBIO3czfDrk1rYOs6pePqeBKnKDQNySwhGcGvzbFgSQLl
 YAyqC5kR0AmQ/l/buWlyOHEY3AOXTm47taJGfr4QM46QoX32XKWDkMOXuGNtAz3X2bluxo
 KlUjgGmr2idvhxHzvSl7/BLslf3s874=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-lcx5sD_OMtm3wSbrT3mgng-1; Mon, 31 Aug 2026 09:52:28 -0400
X-MC-Unique: lcx5sD_OMtm3wSbrT3mgng-1
X-Mimecast-MFC-AGG-ID: lcx5sD_OMtm3wSbrT3mgng_1788184347
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-496bbcf7d1eso27856595e9.0
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 06:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788184347; x=1788789147; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FxuTKKPfZBG3LeAl6yXpicni4GMm8MaEJLalJaIjD3I=;
 b=QocNMHG2P/2aS+ssTzmK4ET9sMX6bHDVqBmoLYnQS/vS+LJg3NGUMb6oat/x0dv15c
 fMrIrj5XygC75I9L/6EpTwjG792ooUffTZ4rGUvKyAYsvzqR9zxI1OrM48mQoGYEvYSg
 xB7m4hjaoXw3rKKC75PVPdQb3MXK9GMIH8ECfoyM8qI9ZGO+QUTA38VEwByfvbmOml/A
 zE25KH2htODQ7TsZkDoMQ/eO5+u4yeGnjBxzR9RRYzO/nB1ojXFpXGtjpAZNDoef9dez
 0mUd968EmZzqsCvLyXICNuvOP12EIW7zXJzQezjF/mVm9teLzTx2k+3Vpm28iG6Mzg9v
 i65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788184347; x=1788789147;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FxuTKKPfZBG3LeAl6yXpicni4GMm8MaEJLalJaIjD3I=;
 b=pLz6riet7ycSQvWIWnALPC6QioQrRF6p+PcRbMG5SKdnPynXcGPpT6NFCL2SrDH7R8
 0VupG+pkHlG8Iwbg6OJjUs09mK2EZBxFXbvAHXpKbMdlUWFIFoQeM3PzEgRp19iygZ4x
 1CS6R9w0TayC8hITJ/qN5sOeK8uP+YEa3HkfsCROAe/q/1tbtB+pXubNcEsKmWisln9C
 0J+S7w8/x1+lXHJATMZYy+XFwQOUsH2GSQqpoJbtEkvrrE3EwVVotz9UffKSkYcT559A
 WVviJrRQcKl7JetXj56ojhgaHX31L0Al1tb6y6YCYTruFu71Hff23Ebx7/FeGnTVuAQR
 eRwA==
X-Gm-Message-State: AFuF++kGoKK39fhU6v6eevD23MTYxLTO/UYRo/yh7rr0GJlnh6xL8Nnu
 JXOA76kmxHotaM/9Cl5YQK7Oi87pXUZHXeyFzqsssAxzTrR469ZPBVbXmAQaJDQislIDoM/3tPR
 hYM7tMDftDtB84Y1haQ/WEZB5Ra5TuBS3abDZ797VY+kkvF3OCY2Q9683
X-Gm-Gg: AR+sD12NMqOe7rVJgzJFox50kr+jhS7bEp53pmxv5b4tvb/aeKKMhUbXfftHhSETFz/
 Qygc1Q3zVu6ubp8Pd9Ab16ISJRIAFNNLcISjGArUTFd0TdN9KGNJvtgbDrSoZEyHcE+HzXa5Nxj
 7C5NCw0PwhX9QX3wnvF448g3RX9SV98XUkMqewdltOmjIA9Zn9VQbplRU5jL1hoHKytQK1WjxI9
 MKVA8RJ3sVaeIKas1cnApyohSC6cyUAdrRUdOpePIrs278gbEuBNh0q7Tqt+EE5D63qFn93alKW
 JeFuRpItg81BjnAYnKpRPa1LxO/CPXNfTYnPDynQEW9eUD7kGI8w0xO/DlPP1r0NhW4vQiLnsjX
 M9WTe9RhgHiGhPlpRAmI3VU7MUoSNYtwfGCrxLtdoGoRJ5S5qGpMXd5rlLrg=
X-Received: by 2002:a05:600c:5490:b0:49c:cf18:494e with SMTP id
 5b1f17b1804b1-49ccf18498emr249132275e9.12.1788184346794; 
 Mon, 31 Aug 2026 06:52:26 -0700 (PDT)
X-Received: by 2002:a05:600c:5490:b0:49c:cf18:494e with SMTP id
 5b1f17b1804b1-49ccf18498emr249131635e9.12.1788184346417; 
 Mon, 31 Aug 2026 06:52:26 -0700 (PDT)
Received: from localhost
 (p200300cfd72080187472d8ceb75e67b1.dip0.t-ipconnect.de.
 [2003:cf:d720:8018:7472:d8ce:b75e:67b1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb20122sm22604876f8f.20.2026.08.31.06.52.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 06:52:23 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 3/9] qapi/block: Add BLOCK_IO_DELAY event
Date: Mon, 31 Aug 2026 15:51:59 +0200
Message-ID: <20260831135206.126184-4-hreitz@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831135206.126184-1-hreitz@redhat.com>
References: <20260831135206.126184-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This event will be emitted when a disk operation takes longer than a
pre-defined threshold (as set on the block device).

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 qapi/block.json | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/qapi/block.json b/qapi/block.json
index 456118eb0b4..1cdaffd5520 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -625,3 +625,33 @@
 ##
 { 'enum': 'IoAccountingOperation',
   'data': [ 'read', 'write', 'flush', 'zone-append', 'unmap' ] }
+
+##
+# @BLOCK_IO_DELAY:
+#
+# Emitted when a disk operation takes longer than the pre-defined
+# threshold (as set via the delay-alert-ms property on the block
+# device).
+#
+# Note that delays deliberately incurred by throttling do count
+# towards the operation duration.
+#
+# @qom-path: path to the device object in the QOM tree
+#
+# @operation: I/O operation
+#
+# @duration: Ongoing duration of the operation (in seconds)
+#
+# @offset: Request offset in the guest disk (in bytes), if available
+#
+# @bytes: Request length
+#
+# Since: 11.2
+##
+{ 'event': 'BLOCK_IO_DELAY',
+  'data': {
+      'qom-path': 'str',
+      'operation': 'IoAccountingOperation',
+      'duration': 'number',
+      '*offset': 'uint64',
+      'bytes': 'uint64' } }
-- 
2.55.0


