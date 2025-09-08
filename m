Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B00B9CA1013
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 11:03:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvZSf-0006BK-Ky; Mon, 08 Sep 2025 06:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvZSc-00068i-Aj
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:50:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvZSQ-00062F-Lm
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757328639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=47n8LwzEZr6qlm365+Zp6w/BZTwoL+5sXtnwua+S3N4=;
 b=X851GZOD6dU6qKJiWvzrfRFBypc5A5GuiPTMXe361Gq3ERcs4VXU78421zYAqrTIc/j7Sy
 YgHq0JjQnwefWZqJvSmfmESLStzO/gWE7e4q6CLZ6uGChRuhAAID0wA5Sr8jDhgvM7AzDk
 EnQ38nB3goxHPnnaKvWVPCuj3js7uZc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-vU4h-XAuMAqE1kLDXlzSSg-1; Mon, 08 Sep 2025 06:50:38 -0400
X-MC-Unique: vU4h-XAuMAqE1kLDXlzSSg-1
X-Mimecast-MFC-AGG-ID: vU4h-XAuMAqE1kLDXlzSSg_1757328637
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45de18e7eccso9281055e9.0
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 03:50:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757328635; x=1757933435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=47n8LwzEZr6qlm365+Zp6w/BZTwoL+5sXtnwua+S3N4=;
 b=lWxWHoMwS7/Vb7jRBcSkzPH6VDvCYMPesSf7/J7/65Q5WLx5awvpv4Hr5Ifh2WRsFH
 omF6XKoawlewbkcYO2UiBCbTS8/xVwF0syT/4BjRDJdqRfQ0g9s/hb1Oi2vhhwyRXPoY
 P1yYHWXF43VeWDHS4ip0vN7vCcQaTEqx9I1qZbyzFNDpcCxVJSGDi+z+TU59wBIMgchE
 1fapR30PIAxEa7XT8ZNe7dvj5IYDUoyX5Rst7NmBExzJebHveWJF0iTxjeHqK9ZgaweP
 Yr6SCN0I8eJQf0gR/6xTU+fZd4VlXByu62U+DpSbhybLMmxYHFZalFXX+DsW2s/C8fKw
 BXLQ==
X-Gm-Message-State: AOJu0YzIBYcF4tw2cxxUi7AOp2yg8LL+9SDa8KAKN6L8Mq6STonrTXzu
 4Ge6C1CZzRpBA9OD1ph+ogZe8+NdD2qfoczlBymQGEsapDq57spFKilzIslG09rx2S06QqgUCxY
 db4UoMgSiTHHSpC/KuoS8kTd+0mW6BsiBbZTWAkta0R06n8HIOknsrKhqmrHyG7OjX7S3SzxMDH
 D1O7yijSnxdw0FFHhSLedk++XwzJq4sFlosBM9ava/
X-Gm-Gg: ASbGnctvbW+HMFy8cQAe3KuFhutIyDOiy0O7euVT6N1xs+qK1PO+iRnbbiieukbh4T2
 CrVc0yNHqxdwhhLNWoiq9kKZjNyl2sZEKXJw5SisB7USteCv8Gq3HDACs5kmhC29JMulHZNh2bz
 vy462879zRDIYv90bEm6byDylhaysXttUiBkHswbBjwxqiPx66XR6lIs+vrfCkUfpgVrvE+szvT
 EeZPW1Teb/BLTfBi+L39cZ3AqY0Oc02g3uwspbXnxPHXtxBXiWlq2oxnidm7psKMV4gU8WeMj7P
 qu73dER6XtpK2GOrfIV9XsFwn4a2jSqlO3TL/0kGSu18ApCrKF1KnnI9BwD+PQQ6d9ht5TOwl0G
 z39dnupCt6tZ/Z2EN29q+2CZzSyD3t5V64k3nIPfJ9uI=
X-Received: by 2002:a05:600c:1895:b0:45d:e0d8:a0bb with SMTP id
 5b1f17b1804b1-45de0d8a286mr39340875e9.23.1757328635597; 
 Mon, 08 Sep 2025 03:50:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERRT0pRHxQuTXhKfU+jbJbIpWyit1CKRbKTy/MuHJPSOA8kXAhMLSB2H6C3GjutVz5uyRTww==
X-Received: by 2002:a05:600c:1895:b0:45d:e0d8:a0bb with SMTP id
 5b1f17b1804b1-45de0d8a286mr39340605e9.23.1757328635100; 
 Mon, 08 Sep 2025 03:50:35 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45de16b8b58sm83489835e9.4.2025.09.08.03.50.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 03:50:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 12/33] rust: add workspace authors
Date: Mon,  8 Sep 2025 12:49:44 +0200
Message-ID: <20250908105005.2119297-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908105005.2119297-1-pbonzini@redhat.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20250827104147.717203-4-marcandre.lureau@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/Cargo.toml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index d98d2b77026..cd4bf8ef8e1 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -15,6 +15,7 @@ license = "GPL-2.0-or-later"
 repository = "https://gitlab.com/qemu-project/qemu/"
 # don't forget to update docs/devel/rust.rst msrv
 rust-version = "1.83.0"
+authors = ["The QEMU Project Developers <qemu-devel@nongnu.org>"]
 
 [workspace.dependencies]
 anyhow = "~1.0"
-- 
2.51.0


