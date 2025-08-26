Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E65CA0FE7
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 13:33:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqtmN-0002yP-C8; Tue, 26 Aug 2025 09:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uqtmJ-0002wp-4H
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 09:31:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uqtmD-0001j9-FK
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 09:31:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756215106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P6ZAzxZ4kYZdwbPijMw+l3qRLkMiqoJ/gdJ3+rS2Ges=;
 b=Kd4EdqeKTaiwx0CYsCGt39TOmyyd7JsFheSKd/9xI6DyybHq8+WhLonvBJaXPJQXy90Gvi
 LWIAHVCJ6WY5gsBoSUPxn2P5etdkEUCnJ1GuhkZZBRymukjFClSU12iaFBO8zNw4RXiZoe
 VaZPSuc+OVz1vmvtdDcJR5z2JB4Wcds=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-qDixAtaQNWagAclzFga5XQ-1; Tue,
 26 Aug 2025 09:31:43 -0400
X-MC-Unique: qDixAtaQNWagAclzFga5XQ-1
X-Mimecast-MFC-AGG-ID: qDixAtaQNWagAclzFga5XQ_1756215102
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F4791956096; Tue, 26 Aug 2025 13:31:42 +0000 (UTC)
Received: from localhost (unknown [10.45.242.16])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DC37819560AD; Tue, 26 Aug 2025 13:31:40 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 pbonzini@redhat.com, qemu-rust@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 1/4] rust: run cargo update
Date: Tue, 26 Aug 2025 17:31:29 +0400
Message-ID: <20250826133132.4064478-2-marcandre.lureau@redhat.com>
In-Reply-To: <20250826133132.4064478-1-marcandre.lureau@redhat.com>
References: <20250826133132.4064478-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Usually, rust projects have CI bots to do that and check that nothing
breaks. We should add this to our TODO list.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 rust/Cargo.lock | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index b785c718f3..3433cdcf6e 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -4,15 +4,15 @@ version = 3
 
 [[package]]
 name = "anyhow"
-version = "1.0.98"
+version = "1.0.99"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "e16d2d3311acee920a9eb8d33b8cbc1787ce4a264e85f964c2404b969bdcd487"
+checksum = "b0674a1ddeecb70197781e945de4b3b8ffb61fa939a5597bcf48503737663100"
 
 [[package]]
 name = "arbitrary-int"
-version = "1.2.7"
+version = "1.3.0"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "c84fc003e338a6f69fbd4f7fe9f92b535ff13e9af8997f3b14b6ddff8b1df46d"
+checksum = "825297538d77367557b912770ca3083f778a196054b3ee63b22673c4a3cae0a5"
 
 [[package]]
 name = "bilge"
@@ -46,15 +46,15 @@ dependencies = [
 
 [[package]]
 name = "either"
-version = "1.12.0"
+version = "1.15.0"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "3dca9240753cf90908d7e4aac30f630662b02aebaa1b58a3cadabdb23385b58b"
+checksum = "48c757948c5ede0e46177b7add2e67155f70e33c07fea8284df6576da70b3719"
 
 [[package]]
 name = "foreign"
-version = "0.3.1"
+version = "0.3.2"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "17ca1b5be8c9d320daf386f1809c7acc0cb09accbae795c2001953fa50585846"
+checksum = "bec05eb9c07a3f66653535e5e50eb5eb935eb00d3bb7e06ea26a9d3a1d016182"
 dependencies = [
  "libc",
 ]
@@ -78,9 +78,9 @@ dependencies = [
 
 [[package]]
 name = "libc"
-version = "0.2.162"
+version = "0.2.175"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "18d287de67fe55fd7e1581fe933d965a5a9477b38e949cfa9f8574ef01506398"
+checksum = "6a82ae493e598baaea5209805c49bbf2ea7de956d50d7da0da1164f9c6d28543"
 
 [[package]]
 name = "pl011"
@@ -118,9 +118,9 @@ dependencies = [
 
 [[package]]
 name = "proc-macro2"
-version = "1.0.84"
+version = "1.0.101"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "ec96c6a92621310b51366f1e28d05ef11489516e93be030060e5fc12024a49d6"
+checksum = "89ae43fd86e4158d6db51ad8e2b80f313af9cc74f5c0e03ccb87de09998732de"
 dependencies = [
  "unicode-ident",
 ]
@@ -146,18 +146,18 @@ dependencies = [
 
 [[package]]
 name = "quote"
-version = "1.0.36"
+version = "1.0.40"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "0fa76aaf39101c457836aec0ce2316dbdc3ab723cdda1c6bd4e6ad4208acaca7"
+checksum = "1885c039570dc00dcb4ff087a89e185fd56bae234ddc7f056a945bf36467248d"
 dependencies = [
  "proc-macro2",
 ]
 
 [[package]]
 name = "syn"
-version = "2.0.66"
+version = "2.0.106"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "c42f3f41a2de00b01c0aaad383c5a45241efc8b2d1eda5661812fda5f3cdcff5"
+checksum = "ede7c438028d4436d71104916910f5bb611972c5cfd7f89b8300a8186e6fada6"
 dependencies = [
  "proc-macro2",
  "quote",
@@ -166,12 +166,12 @@ dependencies = [
 
 [[package]]
 name = "unicode-ident"
-version = "1.0.12"
+version = "1.0.18"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec0fee4b"
+checksum = "5a5f39404a5da50712a4c1eecf25e90dd62b613502b7e925fd4e4d19b5c96512"
 
 [[package]]
 name = "version_check"
-version = "0.9.4"
+version = "0.9.5"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "49874b5167b65d7193b8aba1567f5c7d93d001cafc34600cee003eda787e483f"
+checksum = "0b928f33d975fc6ad9f86c8f283853ad26bdd5b10b7f1542aa2fa15e2289105a"
-- 
2.50.1


