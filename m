Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 276DDCD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 20:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKMMO-0004cq-QA; Tue, 05 May 2026 16:27:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKMMH-0004Ve-GD
 for qemu-devel@nongnu.org; Tue, 05 May 2026 16:27:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKMMF-0002er-8p
 for qemu-devel@nongnu.org; Tue, 05 May 2026 16:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778012826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yk4IP3x6GBLA9Cfka7+splQgVMlDUHi53tCTj7JWBn4=;
 b=aNeWGeNgHRT+bvKNYJvvDNfA/ZP03c41Pt85N3G/uICn+TPJtgc8eXNHQZ0Lv9pgHZPUti
 QzGsKRDxeAcsMo5HTVK+xtYYEXCkKC83F8QQLzSXprVQ+VjttjahjbYhF5xfBjGvxmSBm+
 anD9ESgqqOnmY7e2ig+SOBh3mePgj+Q=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-Z6N0sNZdMHuojv8MEiyQLw-1; Tue, 05 May 2026 16:27:05 -0400
X-MC-Unique: Z6N0sNZdMHuojv8MEiyQLw-1
X-Mimecast-MFC-AGG-ID: Z6N0sNZdMHuojv8MEiyQLw_1778012825
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50ff0bef198so145539621cf.2
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 13:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778012824; x=1778617624; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yk4IP3x6GBLA9Cfka7+splQgVMlDUHi53tCTj7JWBn4=;
 b=VSV6jYxlFqB74LfR+vabyflNWUSwboSW+g78NOpSySYSCkJ6dzMc7u+9bkoY5irLXD
 I7E7LmwzYJEoGuMc7iIsMqPN/0H6gJ8IfEBhylQv/hdtGPziPO2jYu7drtM9Q6f89iUK
 hl+SvM/Gc1HnvHzZKirg5w5+z50Hk6BTEjnrmaLkOGSr1y3Oc3ymRpnDmMz4EIww3IsP
 AOj2u28wr7+BVL5UrbEEN30qOibbiyk0Ll6yMZuJqf8S7hb0T5yo6KYhj65qlqO3ZFd8
 mTsPhko+4FUU8U5x+Qe6wHCJKx4RKmC6NN02z+yW2CEPohFTs8dcSAlm3ggScoWqQsld
 7kVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778012824; x=1778617624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yk4IP3x6GBLA9Cfka7+splQgVMlDUHi53tCTj7JWBn4=;
 b=TEjQrqEgTn7i3IppK02Znmy4s5KrOdX96NkR8BRZ6oiqvbxb4Ci8+h5/wScJjfz8y4
 13rU6lbllHY/dyxwyDRnpp/8Nz5WdiygDPhj/P7misC5yyLXajA/sqtVSz/NQv5TnoM1
 rmkIy3bUmbRkljZRwF7oDW2QPuc84WABQQQAzmmP7LqyQHKkN1bycHjzz+oezoE+aXuC
 VBrLNuJ7e8pFKfaG2QeLcX6Q1BPRRaONZ8+A5LlXHlv3XR20tEck+GxrruQB8wiW9v4N
 QkLV8iRLFWzVxWUr9WBP2MUjLq1jtTPKRI+zJdotxImUUBAde56TL2reKZl/VyIIi6gN
 9ekw==
X-Gm-Message-State: AOJu0YyJU2R4P2yeQ3pEPuraWfz3tAmNOK9AXuH6cDIuNRx6xMwURtBk
 GSTxXqwXyUkDT/+vlDQv1vMAFeTtEo9UNkM816QkieoYoMeitydTavNoepUI1RB+wuNaNmsUn8c
 6jnheWNw8w+LzqptNun5ys4x3FbSCVTHyvlQaeJOXeXtz3HcBIu3WCD/1o3a0d4ZXaqOpVwdk/L
 yJzBReMjGdfxv+y3B5rKvpwLxAWHVIQUFzeUEgpw==
X-Gm-Gg: AeBDietT7ORfA5wlsz4aQfvMxTJw78UlicbmfzAxE1KgWMK7u2OoU4bmliECAsZ1a9u
 t+KRp2OvN9a3CX3njJygGJSJW1ZZ41HTQB6dRqXb5qASFzFIm1nqWBICtL79S3G5BGIVqUxa/Ud
 WSx7V+kYXUFfS+Sj4H4TZocqUmqGdGBzUz+0K4xgbQKClxegvT5loEu8yKgVJuM9Z16z/VWRbDE
 /obDNKPACyf/SNMaH7RsganphQRlQvpzA9o/D9jmxZWMqzrluu94jD5vB9pWAxdJIuYwasWjEFX
 4pqVv0D6Eyq5YFP4ysuh/Z3/F/DA2YEnAXqpW8VgfRfj7F9hZy4BdOQSmPOwzG0dDjdeq6t6NPe
 ZCxUGNkC+4LZXnZ5PaAzW9YqmH0ZtZplZZ738IZTxnZEMcWE7dI/QWtc=
X-Received: by 2002:a05:622a:5c0d:b0:50d:a644:699d with SMTP id
 d75a77b69052e-51461fb988fmr8260881cf.46.1778012824199; 
 Tue, 05 May 2026 13:27:04 -0700 (PDT)
X-Received: by 2002:a05:622a:5c0d:b0:50d:a644:699d with SMTP id
 d75a77b69052e-51461fb988fmr8260251cf.46.1778012823512; 
 Tue, 05 May 2026 13:27:03 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b53c6b8123sm155283806d6.35.2026.05.05.13.27.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 13:27:03 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 17/23] migration/qapi: Update unit for
 avail-switchover-bandwidth
Date: Tue,  5 May 2026 16:26:34 -0400
Message-ID: <20260505202640.1011006-18-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505202640.1011006-1-peterx@redhat.com>
References: <20260505202640.1011006-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add ", in bytes per second".  Unfortunately indentations need to be updated
completely, but no change on the rest.

Cc: Markus Armbruster <armbru@redhat.com>
Suggested-by: Juraj Marcin <jmarcin@redhat.com>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Link: https://lore.kernel.org/r/20260421202110.306051-16-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 9a4817ec73..27a7970556 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -922,15 +922,15 @@
 #     (Since 2.8)
 #
 # @avail-switchover-bandwidth: to set the available bandwidth that
-#     migration can use during switchover phase.  **Note:** this does
-#     not limit the bandwidth during switchover, but only for
-#     calculations when making decisions to switchover.  By default,
-#     this value is zero, which means QEMU will estimate the bandwidth
-#     automatically.  This can be set when the estimated value is not
-#     accurate, while the user is able to guarantee such bandwidth is
-#     available when switching over.  When specified correctly, this
-#     can make the switchover decision much more accurate.
-#     (Since 8.2)
+#     migration can use during switchover phase, in bytes per
+#     second.  **Note:** this does not limit the bandwidth during
+#     switchover, but only for calculations when making decisions to
+#     switchover.  By default, this value is zero, which means QEMU
+#     will estimate the bandwidth automatically.  This can be set
+#     when the estimated value is not accurate, while the user is
+#     able to guarantee such bandwidth is available when switching
+#     over.  When specified correctly, this can make the switchover
+#     decision much more accurate.  (Since 8.2)
 #
 # @downtime-limit: set maximum tolerated downtime for migration.
 #     maximum downtime in milliseconds (Since 2.8)
-- 
2.53.0


