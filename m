Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA3FC3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 15:34:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCKFh-0004YD-Sn; Tue, 06 May 2025 11:30:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKFI-00043P-Hd
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:30:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKFF-0002CK-5V
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:30:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746545408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5VHgMfIC+s9fuauMpobbaoWCfcNnRXx+9S3XMDvhKC0=;
 b=P3U4XgsdGxv4buHYxGag4pMe6724S1qMCg8a1TyGQZBjXGm/2VwYXwFweWhFK890kpz2YK
 yjNbeRdcMufbZsIOdY9yUrP7L1+xZr2CKR6Pjf7zhuKkJsLUq0QbeYYvBdx/LSvZWSZ5wY
 Qh2LnmvvveDrbQ9BL2u5oKCYnv6kZlI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-AHhVQ6EWO52vFcneHNKBcg-1; Tue, 06 May 2025 11:30:06 -0400
X-MC-Unique: AHhVQ6EWO52vFcneHNKBcg-1
X-Mimecast-MFC-AGG-ID: AHhVQ6EWO52vFcneHNKBcg_1746545400
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43d733063cdso42634275e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 08:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746545399; x=1747150199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5VHgMfIC+s9fuauMpobbaoWCfcNnRXx+9S3XMDvhKC0=;
 b=ecNtEzhyYRdd6pdA+KkWIYULT+7JHvgVWICzXuWd0Hotg066e81732/xHC6d+eApp0
 2gN6rwp2rSWu74o70xd7IHke4HeLQiCoZgx2cKsu1O+PN3CKEiGqCl2JLjVJPNUJPN+H
 3wLxSqsXPH6Il+OC1z+I98f+ybOMk3y5Wtgsf0n0xpTOPJJptg70Fhxs+LnXJT+lcOQY
 63kU/x9hna3KXvh2eKfPaFqZV6rQYxx3qAKuuzmU2YhVrCWcRtSgYd08kj7QxAUgUIJg
 gKg3oKskGls9maWHJBSzM/eJkwmFE5B3B6xfCvuOO6UgbT0PdncxnEvt5sywcfAUlG9/
 RGYA==
X-Gm-Message-State: AOJu0YwGNeaeyRoyWXmY6WKhRIe1No1Xe7GpP8QrFQL/SmxkK2YXZPph
 Cspca13uj0/MBC+/10SArsMo8bmDWZk/4YkZn55QIPnL+Ze1BmeBzrrwsAWd0kLZfty0Su3D6xh
 +pHM4u8WkztM+VpGnAZQihcUXPs/aF3UyACeL34TjjYz/ziEwQ7tGypRYa9Ddit4KJIY6Xj+Xw8
 Ahwi6lI58OlVcgvG+8G/vz4AD/16L/H5NhjUH9
X-Gm-Gg: ASbGnctja762jElnxEBKtSYM37CkL90MQDG4+chylAdYlvK4KjprCDG7VlwYasp+mh+
 TIUEzMkRJ2cvukYMFsgUWYDu7epBKuJFhWzR7hMFzKI/Q1DA5hOf6cGGIhQIVVk4pDJSxarSEnv
 /+lqq01H0C1kUXjncVVAXID+qreoqTIdyf19XsWmRJn3/1C80bgKwNhsnj1X/KDnLiezKp1WiJV
 PjAPvPRrbwlcaJ4koiORwBU0ElwrRqIEMWHuvwOG+ER009+jMspqqoE48mwQGiUG0ceHgzZiJlq
 ZWe7Sz3naFfYSkE=
X-Received: by 2002:a05:600c:1e04:b0:441:b00d:e9d1 with SMTP id
 5b1f17b1804b1-441d0fbd63bmr32979165e9.2.1746545398933; 
 Tue, 06 May 2025 08:29:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzQzgSsJL/M3vA4/N8LKSLVSy8CpsiURBHRgcQgpUV+k+zJrMmRvIg+FpYEUg+Sqof3gp2cQ==
X-Received: by 2002:a05:600c:1e04:b0:441:b00d:e9d1 with SMTP id
 5b1f17b1804b1-441d0fbd63bmr32978865e9.2.1746545398456; 
 Tue, 06 May 2025 08:29:58 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b276052bsm219569375e9.0.2025.05.06.08.29.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 08:29:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 15/30] docs: build-system: fix typo
Date: Tue,  6 May 2025 17:29:10 +0200
Message-ID: <20250506152927.222671-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506152927.222671-1-pbonzini@redhat.com>
References: <20250506152927.222671-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/build-system.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
index 258cfad3fe7..2c884197a20 100644
--- a/docs/devel/build-system.rst
+++ b/docs/devel/build-system.rst
@@ -168,7 +168,7 @@ The required versions of the packages are stored in a configuration file
 ``pythondeps.toml``.  The format is custom to QEMU, but it is documented
 at the top of the file itself and it should be easy to understand.  The
 requirements should make it possible to use the version that is packaged
-that is provided by supported distros.
+by QEMU's supported distros.
 
 When dependencies are downloaded, instead, ``configure`` uses a "known
 good" version that is also listed in ``pythondeps.toml``.  In this
-- 
2.49.0


