Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A257C0219B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 19:50:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg7sK-00043X-L7; Thu, 06 Feb 2025 14:49:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1tg7sI-00042K-PU; Thu, 06 Feb 2025 14:49:23 -0500
Received: from mail-vk1-xa33.google.com ([2607:f8b0:4864:20::a33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1tg7sH-0005Wg-CK; Thu, 06 Feb 2025 14:49:22 -0500
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-51f2ec5a5fcso40030e0c.3; 
 Thu, 06 Feb 2025 11:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738871358; x=1739476158; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1AHQGaQ6a+2WwzZc/NqArKgJbl25fEKxLjNub7Wpx0U=;
 b=DNdGMJYyFped6gSwCg+Syhof92txxdrOqwGMw8SBfYXq1KzbZTW9YF54XcuPRTDTEa
 1DXiVswWa8+zj4p1RjUSN0rbaqYcQ7Wzeumtpxm9Molg7nP5LWIYMsyE4YA0raEt/SuE
 wK2w6zVozLt+JNuHTr8f5om1MxXUI7j6k4g0Zos2N7gw+LkfD/TvpucBlZrUsTDm5wPW
 6YfBXbl4mhY6Fc47YomwhpTvjjwVfWJPlmMMmAFarxljv+p7ZTmyl6YnehDBYCTIOc6s
 9NiPyMB+xLOBSzH4RH/zmlZ8lYdDRHbZEurM5Gi0aAKYLhfbSJUpUqxvYIF6PqcMYP+c
 S5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738871358; x=1739476158;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1AHQGaQ6a+2WwzZc/NqArKgJbl25fEKxLjNub7Wpx0U=;
 b=EZ9So30ae/IE7JJ94AmQaXfsfrjdnVAza75LMYhVAakzn4zPPQ4OU8g5KkcQQ9sotK
 J3qlQblqHcLtxei6bhgofzKAervfaaYgFPB7OJjShyWXcpKBNnjsC0w3iAe3ggq1dNZN
 9ZlJWE9ETldCURR150Lyb80x2h5U29HZplww/pJU+AXUcwKDD7eIWTb8evgeSomfAbkL
 nDfz3G7LPyICYTvKtj33yJCmXjjeEhNwCJukGzDgMTMXYKBm5sfFSKQkHbo8TeACFXsb
 da1dKNo4PaK6Q0CUyYhTb30KIdi3fdOLLHrD15Xdjg12H6TJ1pY4iyDgONIZlFqd5sCV
 Omng==
X-Forwarded-Encrypted: i=1;
 AJvYcCUr2lt3dsvnvxpayibGI3aR9eLvzwZDqvujxuoK9Q1ydz1pza75A6KTywvtgGkqAHf+jMYnV9KacZAAvA==@nongnu.org
X-Gm-Message-State: AOJu0YwTJvPTji/t68E+KNiROqbEwxA2u6FctEEdOIcxMu7LxBYoIXfl
 5riFnldJpDcOUHWtXBxrQfL5pbwtDpd0Url5l6mHq3sdW46btPtpm67h6N6p
X-Gm-Gg: ASbGncu6EJT9WgPIPEX60mWhhkEpmFqcuD7UHJNC2+YtSfAGd/fSjv6fj/XyfHTBPUV
 bFCkiufPs46px2RqjUhpDIHgEPKRcPMZwz/np+rUvRT05r1t7e4q7yFPzGsogMSbqH4WiHfmZDD
 EbKfMZOJZ9bw/ZjoUULrhWMVKWsC/DQ5GUG9RbD4DHasQB7AAHMu3BoeafSeyUtCybFkp0XupwV
 AeKS7vpFiipW38+Wp4oa05I1yb9jTlV+vWetdb0Sd7wlnYAoXguH3jgET2FVqXO8zkxW0a9O+iO
 aDaNMG2MO2uP7fG3DGizZmCgmuSrNTQFEZJbNLP3sNkZLfkk1+afLAVKUF6aVA==
X-Google-Smtp-Source: AGHT+IFVsnACvhkr17SGqaghVSfNMb9sKxIujmMevzJ6uGZOdHm49960ITi5q9P0koSCvsuUZzIwGA==
X-Received: by 2002:a05:6122:8c0b:b0:51c:c23e:8cd3 with SMTP id
 71dfb90a1353d-51f2e151fbcmr630171e0c.4.1738871358385; 
 Thu, 06 Feb 2025 11:49:18 -0800 (PST)
Received: from gmail.com (ip190-5-140-142.intercom.com.sv. [190.5.140.142])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-51f22736ed8sm283221e0c.12.2025.02.06.11.49.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 11:49:17 -0800 (PST)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-stable@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 olaf@aepfle.de, edgar.iglesias@amd.com, xen-devel@lists.xenproject.org
Subject: [PATCH v1 0/1] xen: Remove invalidation of mapcache_grants on
 IOREQ_TYPE_INVALIDATE
Date: Thu,  6 Feb 2025 20:49:14 +0100
Message-ID: <20250206194915.3357743-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a33;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-vk1-xa33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Olaf reported a slowdown in boot time on x86 HVM guests and Stefano
provided a patch that removes the invalidation of the grants mapcache
since not needed, more details here:
https://lore.kernel.org/all/Z5oIvUINVDfrrVla@zapote/T/

Cheers,
Edgar

Stefano Stabellini (1):
  xen: No need to flush the mapcache for grants

 hw/xen/xen-mapcache.c | 1 -
 1 file changed, 1 deletion(-)

-- 
2.43.0


