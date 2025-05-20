Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A056C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 17:08:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHQRu-0000FI-Rf; Tue, 20 May 2025 13:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uHQRl-0008V0-ED
 for qemu-devel@nongnu.org; Tue, 20 May 2025 13:08:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uHQRj-00017g-Pv
 for qemu-devel@nongnu.org; Tue, 20 May 2025 13:08:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747760886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9r2K5IRydGAKK2ZqGpput8QmW6uoc48LgjM6fFzTJZY=;
 b=aJrusxoV2aUUBysLxOtH8Z0ffeI5lSm1mbT7JqXSIdgQ4pxYSafpyK6EYUPZsNAB4zOE5N
 JFbGZdyPh1lnn3Bwftcr9a3WOq5HOGrJqkaugcrYbhyzJVxDgZ7qfLIOOySRrc2lWyfSLR
 k3A+pOGURrmqd21Sadw5MXZKBczdLLk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-kKkKisOYMzC9HlvFLfP1Sw-1; Tue, 20 May 2025 13:08:05 -0400
X-MC-Unique: kKkKisOYMzC9HlvFLfP1Sw-1
X-Mimecast-MFC-AGG-ID: kKkKisOYMzC9HlvFLfP1Sw_1747760885
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7c760637fe5so1056809385a.0
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 10:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747760884; x=1748365684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9r2K5IRydGAKK2ZqGpput8QmW6uoc48LgjM6fFzTJZY=;
 b=VxuTxIUacxNQx+/0zKp3gFbU7tYnHi2nZW6qkfqGCGK4rVLl9sTOcvrS+jakSFiolI
 xo6TEDrjz9LqCLEo/1468tCv0TMSpZcoUr/Y6YvU5mxfy99h9MxdDknOUycEulpXfIHw
 xw+rtNGvxAhU1psBy3Jn6UsFW9l5U8/npB3/l3OVTHQVM7HyqrLstrX50YMZPzjlTOl2
 73B9aKXpRg6n++Pp7YHuPtWmeQkWuYF0NE2DYv931j8tzmurap58O9hzBZOFqbncGfN1
 QLspyCj3mFKd0QYKhtRMhZNw3Zx0QMo6yByFNP/Nc3CQeY1p36AOr58TTbOeNbtV0OKo
 a9FA==
X-Gm-Message-State: AOJu0Yy88SLl9brKEZ0WjKWN+zUN7xmkjPyOCptMON1RQBcDoBFFBP42
 M3RMrnOfzDpUAGu6qVZ9P1ybzz9axH+wkKIYdS8rjwcdXJnaXBRE8JSsF8h+OEYlX24e5IAflcO
 C3cpTZsV5XVeeifxn8cOqqHtY6G4E/oXME3W4h8dwXmg7FNOnPHQk5zTTMxM0Q0OUDRm4tPGovb
 y0k0aA0eI+MadYv/iiD4AIYA5AwISFjoqr0QBOyA==
X-Gm-Gg: ASbGncu2rNmAdXZyUKaObLsP8l0bzzHAmPUaOMlcKyWd91j0Na+YBS+ER6kjL7yTvmr
 yDgYcbopPr5hBq/Ovk7hz52jJn8qsoXU87Ujx2v1ZeHKWKKZBbTWZvNpyUuxnRRtyH/G2uicCc9
 7IjN/wSsDsBq6qVYIIyIBupXlNXQUEWbbwxfSh8x8NC8qG6SHQPfqEXS2YdplTCaGpKGu3vvEHK
 dE1pyuItHowaEeR8ZdDyqm+tqSr0vFvIN0C/aNjAfe2qj1ltfV7quhb6rvVG9a2Z8vwaEkRrA87
X-Received: by 2002:a05:620a:2948:b0:7c7:747f:89d0 with SMTP id
 af79cd13be357-7cd46721bc7mr2410086685a.18.1747760884213; 
 Tue, 20 May 2025 10:08:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECkjycnqg3O/94xSsEw97NNHZPc+JWixdlIYcpLvqI9zHoIeTO/6/SDpOZx0lSmzfU4dYEUg==
X-Received: by 2002:a05:620a:2948:b0:7c7:747f:89d0 with SMTP id
 af79cd13be357-7cd46721bc7mr2410080585a.18.1747760883570; 
 Tue, 20 May 2025 10:08:03 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd467be47bsm763846585a.16.2025.05.20.10.08.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 10:08:02 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 peterx@redhat.com
Subject: [PULL 06/12] ci: Reduce the size of artifacts for build-previous-qemu
Date: Tue, 20 May 2025 13:07:45 -0400
Message-ID: <20250520170751.786787-7-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520170751.786787-1-peterx@redhat.com>
References: <20250520170751.786787-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Fabiano Rosas <farosas@suse.de>

The build-previous-qemu job is intented to produce a build of the
previous QEMU release for consumption by the migration-compat-*
jobs. Keep only the pieces of the build that are necessary.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20250513133353.23022-4-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 .gitlab-ci.d/buildtest.yml | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index b4e39fd7c1..ca1a9c6f70 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -188,12 +188,11 @@ build-previous-qemu:
     when: on_success
     expire_in: 2 days
     paths:
-      - build-previous
-    exclude:
-      - build-previous/**/*.p
-      - build-previous/**/*.a.p
-      - build-previous/**/*.c.o
-      - build-previous/**/*.c.o.d
+      - build-previous/qemu-bundle
+      - build-previous/qemu-system-aarch64
+      - build-previous/qemu-system-x86_64
+      - build-previous/tests/qtest/migration-test
+      - build-previous/scripts
   needs:
     job: amd64-opensuse-leap-container
   variables:
-- 
2.49.0


