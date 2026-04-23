Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F01B9F99368
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:32:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFrKn-00013Z-L8; Thu, 23 Apr 2026 06:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrKF-0000nP-0C
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:30:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrKC-0005nX-M1
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776940222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IvSIdII6V+yTFOn7yhXDIrp7CakQLXmMya/y/bCpBPA=;
 b=RPHpqyswnn4UzW0BgLBsuz8gE1ljalVShvvBakZge6pJIhCp3w6uRjc6nfARtHhrUWxaeg
 dV3+8IWrb/9bhJ5oFjGrIndWnIvAE53Z5yGJr9+SP/foxwSG6k3+RjepaO4k+dfpbdeojQ
 J258qpP9YDhgXUpXqZLKNYY8qg2cjr4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-AuHGB3TKNlquNde91OmEbA-1; Thu, 23 Apr 2026 06:30:21 -0400
X-MC-Unique: AuHGB3TKNlquNde91OmEbA-1
X-Mimecast-MFC-AGG-ID: AuHGB3TKNlquNde91OmEbA_1776940220
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4411a215f17so3386346f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776940220; x=1777545020; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IvSIdII6V+yTFOn7yhXDIrp7CakQLXmMya/y/bCpBPA=;
 b=UbZigWtJ7vqCDISiMJfwnKrkeaSnbQJUyPkbHkmsQUaqIMctXzL7CA5GpEouV5gHxH
 amZV6YTlaHut97iwaz55cq3BKA1RlH0m8Pb3wg+t0TSmB8FY5m4Zjl4NzdXrda2/y7tH
 9r4AT/t3v/sR3w6JZFi4j3WRYvUjA8kzMYC5VDiayBERCpEPNHn3iYsE80x8WP8tnFDt
 41LvxtmYbyiAAUIW9b6z4clPevcVE5hEG0VQg6detT++7jHuu5dC3IIXqCHAHQy9sNkd
 /o83Ajbv2MXSiBhlv6MCNDx/dHHjjWolwver2wkn3SbzZD2P0VzZKliXYVzG/21H+YOc
 hgmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776940220; x=1777545020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IvSIdII6V+yTFOn7yhXDIrp7CakQLXmMya/y/bCpBPA=;
 b=sli11mhDneP6XD6/GWpqYmG0Gc/dku2PW5qBQuVZnXrlpGClR3EwfzgczXiZ4KPqkv
 cdp0JUrdwK3r/4cOg8cSpVGcccyX3IuRYGJ9znTGcmzQs2G1fruqKckSgq8noGRL6Y6L
 AwIiD2yojzYi1EJs7YmXULp8Af46O32Z5xRCThVg2Mvq+0HAKvTbzl0VTtby4bLb9xUR
 f3tHmxaZPFt9IlkpjfjgIs2MlPQvj7fV3yfujPc5zalu9Tge4/BL1SHvvttXjJLqoZnb
 qEdF+m3QvFXy/ciUO+8W7gBxvfFAa1NdJ5+Pq3VxrYAL7qewelZqI5SgpDiVhHb/cMUh
 oNsw==
X-Gm-Message-State: AOJu0Yyj0oZ/wHWF+Q17sk3x1tq1mZp4DAsu2wbV3vYDh42A3DOe05MB
 9mlCswDIhePup0bg4iJVIwIcKvya5nkjweuvqqa+59zrLc661LcK53r71L311e626rUmKd7+JnE
 rKki9R3V7rpGYsjz3pVWSCFGIEfw8NSukNsjqJt9VputBBqa9+c3vBCfAi6pTnl2kxR6bNYTqHp
 6AbFLNv0tluwp6E5l+cuam1Sdt3cKTzv4Rk4ktB5Oi
X-Gm-Gg: AeBDieulUsj/U34TatS88Cx4Mp78j2YrN35WyPflArZ+IonV6a9LChuSSvH14/p5PEf
 r1DAQaw6VK9tLH+MsmovQaEaVkOy+ksTYUvl3rA3+Wzqjyp6yR6zPrxp34G0XUMG4bg55pLfE3b
 GCuJvZvbstlVHg0V1lw7/NlVY8YXRmvwYO8XlXKnVMgd0AN+QIBtnfhmOJDz3zC+jasSy0zttbr
 yLmSE1uqoGxNxi7CZjqzDUCt+RFWOIMqxAZunBZ4GXT8ZuSUAyLnRL8ASG92nAmX/MSAJZEe+PH
 /Kj6MdBfLYY+NMllCKcUb62qMjNW4Sn0x8RrIm2dIpbdTtKA9TAnhD8GHTYuwjbkygZHN0YEKsn
 Fty92h9INT7RMb2z9T7iX7kHeDlfJUmEEMaJhMy/LTx/hn9BUCd3WQW090fL8qD9uRNpBT9WIdj
 QCIEF4dUyQIoQ3Jq5WE5vy3StfobF56msSLF4=
X-Received: by 2002:a05:6000:1889:b0:43d:7b7b:ab76 with SMTP id
 ffacd0b85a97d-43fe3dc54ddmr40751332f8f.10.1776940219651; 
 Thu, 23 Apr 2026 03:30:19 -0700 (PDT)
X-Received: by 2002:a05:6000:1889:b0:43d:7b7b:ab76 with SMTP id
 ffacd0b85a97d-43fe3dc54ddmr40751259f8f.10.1776940219051; 
 Thu, 23 Apr 2026 03:30:19 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4d112sm56741935f8f.29.2026.04.23.03.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:30:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Aastha Rawat <aastharawat@linux.microsoft.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 20/25] accel/mshv: return correct errno value from ioeventfd
 failure
Date: Thu, 23 Apr 2026 12:29:17 +0200
Message-ID: <20260423102922.443639-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423102922.443639-1-pbonzini@redhat.com>
References: <20260423102922.443639-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Aastha Rawat <aastharawat@linux.microsoft.com>

Returning the raw ioctl return value results in misleading error
message. Ensure that actual failure reason is propagated by returning
-errno for ioeventfd failure.

Signed-off-by: Aastha Rawat <aastharawat@linux.microsoft.com>
Reviewed-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20260409-fix_ioevent-v1-2-053b810ae6fb@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/mshv/mshv-all.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index e1a8d62f8d2..58af674bd99 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -275,7 +275,12 @@ static int ioeventfd(int vm_fd, int event_fd, uint64_t addr, Datamatch dm,
         }
     }
 
-    return ioctl(vm_fd, MSHV_IOEVENTFD, &args);
+    int ret = ioctl(vm_fd, MSHV_IOEVENTFD, &args);
+    if (ret < 0) {
+        return -errno;
+    }
+
+    return ret;
 }
 
 static int unregister_ioevent(int vm_fd, int event_fd, uint64_t mmio_addr,
-- 
2.53.0


