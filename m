Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FCDBE6F095
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 14:31:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY3Q0-0002Wa-DH; Tue, 23 Dec 2025 09:31:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3P6-00016E-Bk
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3P3-0003kF-9f
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766500220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JehPj5TZr+uKMtkS/2KpWg/wrctBO/xMsTh7F8UK8JU=;
 b=bZ2PIlay9YvNKesL8JE6tDV09T46vjGXeqlQfBUV8w1GnwUcwzZeoGe+mYmEcYoTXyVj4l
 NAL3d+9dRYGkv9RuHRyeHIJAWPVtqSeHJRAMN9H5pVJDH+xomWJ9NNJzyDjvwFctwY9AXH
 85t6j9rzK4RMac3wdTXkbWO8KajG/Ck=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-HCiS7govM1WKncJNfzHjbQ-1; Tue, 23 Dec 2025 09:30:12 -0500
X-MC-Unique: HCiS7govM1WKncJNfzHjbQ-1
X-Mimecast-MFC-AGG-ID: HCiS7govM1WKncJNfzHjbQ_1766500212
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-88a2cc5b548so135124726d6.0
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 06:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766500212; x=1767105012; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JehPj5TZr+uKMtkS/2KpWg/wrctBO/xMsTh7F8UK8JU=;
 b=L+dZNoP4YavFZZByRTEy/WVfFvgRVyZHuH3IoYpLUef92pVDvaMTlSp5ZBrTxmGSKS
 BFAkx15rIiPaYphY0J9BYdVFAjunT4/+LgjNXaPaFHmBzIA3obq74yEEANX1izp4wVmh
 94ta/N5PIaHvdzDkZhzssB+kwr3SrsCC4UGIb0chMniIZuk1pbrRf5XdBpGrgTlXSe+Q
 wKHG1ZZfDnamJ0nYZAkq/fa1lCFkwpFFevOxJ4+lXPDmyf1MrJNBz16x/QZGqltqMqjX
 DQ+f0Dn4VYmNtPkbbSVKt2lcDRnIQHAl2VV+fAF4bQjuriUjLSWo3SkzFb4UohDZIdex
 Emxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766500212; x=1767105012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JehPj5TZr+uKMtkS/2KpWg/wrctBO/xMsTh7F8UK8JU=;
 b=EQFLlpTdBFPTFXaQMd7aeG0RqZTHHAHnk0sw/jySkaHXmBhrddlKj6e6FJEcvs1gTP
 3Kx56rmmI7i2vk2wDAIfjgQYjj/E3O9a3syhEj9Fd3Y9d4tFM8bYBsGPklphooYZB/7/
 gwU/lUlFTwbnVOKjp11/3mTWRKg56r4SV3jyj8CT7tCdvHBtEsbTIvZv8rXojuAMXaqi
 c3JI2YkeMusy4RvO805gCYbEzDT7vRzWb+anrRFG6Xe7nBfMpgk/OfrKIIzgw1YRGMBD
 kXU6vyc2XsXSHvNXgHmcIaNYyM9gYpMHvhfs4GuTK/zBwLwQIFF273ADEpSUdh6ELE7o
 AWHg==
X-Gm-Message-State: AOJu0YwRP6SfJ5OEZvVQWD6I8Zw2yGGVMQfH/qSf/q7z+J/0qvJWUdZR
 IwK04YBNak1cXtBzcUpzzxoU7uBK6IV71H2jh7OYmamYuL/YR8x/C3uRXDB2UX1dR8iQSH7Ia3Q
 +b/uwerNPUE23VfOlbYJrCtk0k8Gu4wKwqJKjOfUTu2FAnYk1Iar/GO7SYRjEGmxsO8bocXGTSp
 AY02onYQYBNDV8nsbppLOMi2h79z/SFyTWRny4XA==
X-Gm-Gg: AY/fxX6FGf2d1oHl8XCQcMZWDJhavEFyS4ZXG/HYsCKmaE9UecPAOuACwDmc/4MRhI6
 dIfqI9Yxmuv05KRIYLSHO5ByOy5gJBkHnVBowANIocTsHJFdel1DrNzZDVPDTe1ORujSYFPK7pb
 w47icYQnNBet9XPKP8xPWi3BaFmYkBrS3109bcpJhPXdbdPAVzHkrzqouUEtRKxtKzZ5ehX+Ctm
 tYBVZCDFRSnqVnvJfDuhiorDSQ6toysKT8aoCKYIbXj9F9IHnY1ZpQumLGQNPLCdseYcTthP0bG
 MSGW6rLnz8reEKGrQKPOkdZljD38oRXjtj4rOduA8qbcdVaZI3vPm5wHnOWQSi0zE9cNMs4yGLL
 Rn2Y=
X-Received: by 2002:a0c:cd91:0:b0:88f:ce0b:a008 with SMTP id
 6a1803df08f44-88fce0ba2dbmr93961016d6.3.1766500211748; 
 Tue, 23 Dec 2025 06:30:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5ewQLS2t/3mdlpDnEEO3m7bTVgNdkSOJdCFVBTHu9OTrNNWEitDHiFqFBxvf7BkSoW1Pj8w==
X-Received: by 2002:a0c:cd91:0:b0:88f:ce0b:a008 with SMTP id
 6a1803df08f44-88fce0ba2dbmr93960276d6.3.1766500211198; 
 Tue, 23 Dec 2025 06:30:11 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c096787536sm1096163285a.4.2025.12.23.06.30.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 06:30:10 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 07/31] error: Poison g_autoptr(Error) to prevent its use
Date: Tue, 23 Dec 2025 09:29:35 -0500
Message-ID: <20251223142959.1460293-8-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251223142959.1460293-1-peterx@redhat.com>
References: <20251223142959.1460293-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Markus Armbruster <armbru@redhat.com>

The previous commit reverted support for g_autoptr(Error).  This one
should stop it from coming back.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/r/20251201194510.1121221-4-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/qapi/error.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/qapi/error.h b/include/qapi/error.h
index f3ce4a4a2d..2356b84bb3 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -437,6 +437,26 @@ Error *error_copy(const Error *err);
  */
 void error_free(Error *err);
 
+/*
+ * Poison g_autoptr(Error) to prevent its use.
+ *
+ * Functions that report or propagate an error take ownership of the
+ * Error object.  Explicit error_free() is needed when you handle an
+ * error in some other way.  This is rare.
+ *
+ * g_autoptr(Error) would call error_free() automatically on return.
+ * To avoid a double-free, we'd have to manually clear the pointer
+ * every time we propagate or report.
+ *
+ * Thus, g_autoptr(Error) would make the rare case easier to get right
+ * (less prone to leaks), and the common case easier to get wrong
+ * (more prone to double-free).
+ */
+extern void
+__attribute__((error("Do not use g_autoptr() to declare Error * variables")))
+error_free_poisoned(Error *err);
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(Error, error_free_poisoned)
+
 /*
  * Convenience function to assert that *@errp is set, then silently free it.
  */
-- 
2.50.1


