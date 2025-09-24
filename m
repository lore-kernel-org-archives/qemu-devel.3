Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45545CAC5B3
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:36:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Lp7-0005N8-3X; Wed, 24 Sep 2025 05:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1Lp1-0005J8-HV
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:29:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1Loy-0004q8-44
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:29:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758706192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Lr8fIGw+ra7DxehRDJAgbjkaaSFobuUwVbfza7dpxE=;
 b=i/Kw9wSx3ToCViat8L16lrDB5IdqWnVMV89nfw+EMl4Evv03KHb0nsdxgxsUpFQs7F62Sk
 CGYZpPHk/Gi+7ll+jyVzTPEujAY/FfG59cJrPmSl49jX9BvDPhsWOkvMAxZCOShH9OwWvK
 5uypY2kpVhD9iLrUPOQRDC99obkHu88=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-G2xi3pd-M8SswEIwGpdwcA-1; Wed, 24 Sep 2025 05:29:51 -0400
X-MC-Unique: G2xi3pd-M8SswEIwGpdwcA-1
X-Mimecast-MFC-AGG-ID: G2xi3pd-M8SswEIwGpdwcA_1758706190
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b3347f0b205so37571266b.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 02:29:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758706189; x=1759310989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Lr8fIGw+ra7DxehRDJAgbjkaaSFobuUwVbfza7dpxE=;
 b=f/AI1ws7In8TENTsJqKSb3DsFOZQAL+UUhrV17EZ3Jziqa/xGd1La/g2l02+fniXIQ
 S55y4vPc4JHbqhFq613NfEic8pjxhHX7FuuoL64b270wezqRPc/5OzBTbtWX29zJq/ZO
 gB4Jn92BzOEJQi6zGuvr2dHLgWd6yCNIGe09YFFWKg8Kw9Z7hH0yajYuOb3khHSTNO6x
 lU24Y4BgahAv+z7r2liHzl3Ud6KeuL3QWKMKBPL/ZCNRedIlXqfGtqY8Y0zugdhhY9/s
 RW2RLuPygcaaZmgWhvUDms3Gt5mFSDdA66KhrhRb4ywvD3ad1HaZZW2nrqkD8SxZrIiE
 bVfA==
X-Gm-Message-State: AOJu0YzyhxBgszNK4YWr8ROgpHGlhtEX3A/q2YRwOn0Uv/8IZW7Jyq40
 8r5ia8JqQLByPwYhFSF4j9C40W8XvgUQ5y+iAuAUF9HMIGwlWZpJyBeqVRAEijawRVnBPCiw7Ra
 C0VIJmLs2QnqQgr+U8eYExYolGfRTppputbyVc9F5hrc+0i2+8jE43p80jtoMUEKIIXZtjtRS1g
 wzRWeE51D+fHIA8mtuXF3qFl0q85yW6JM6UutCQAbe
X-Gm-Gg: ASbGncuTrU9addeIlpCv3n6hW1/qVrQkQyzCWDq044Jti17Po2rXUnnTWIh//U8+qZX
 6ksbw0dbYEwIDFyP7PIsFawlEIctLjhGRYp3c7G/ilsiayaogqyNu/N5Q7WbU52uzOZ9fEeN17v
 7z43/ODrlCKZBaLEUc7d+zH4Q+MT/QZ0BZpF02nWI36oPw6F3Kjj58t5YvXIh1XKh4WjGFX3chw
 Kj8QdUFrlC0qdsXK1/DLNAw07sD/UuN7f9ebjImzYtXBLfqCckCFXcFeodweeJDVeRYzouPUHWj
 JyUsGS7rxRiL4+JgfRx/BjLGpR6YQVUzkBEdS/oNAzF+1IOA7VjjaYssfSOsADP7A4TH3E8jo+R
 PiLfa0nmDwBiRcjm05NbTv88l5hxlWrliP5CVp2JdOyZURA==
X-Received: by 2002:a17:907:d14:b0:b1d:285d:185d with SMTP id
 a640c23a62f3a-b3021ca6d78mr537924166b.0.1758706189067; 
 Wed, 24 Sep 2025 02:29:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMQNcYKQvCMZuf1j6Q0h3pUx+56rZgVUcElX3RFudcdOG4EbiU3uNSSjPlf2xO9OUrxqBuwQ==
X-Received: by 2002:a17:907:d14:b0:b1d:285d:185d with SMTP id
 a640c23a62f3a-b3021ca6d78mr537920766b.0.1758706188618; 
 Wed, 24 Sep 2025 02:29:48 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b32859673b4sm130560566b.30.2025.09.24.02.29.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 02:29:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 19/29] linux-user: avoid -Werror=int-in-bool-context
Date: Wed, 24 Sep 2025 11:28:39 +0200
Message-ID: <20250924092850.42047-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924092850.42047-1-pbonzini@redhat.com>
References: <20250924092850.42047-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

linux-user is failing to compile on Fedora 43:

../linux-user/strace.c:57:66: error: enum constant in boolean context [-Werror=int-in-bool-context]
   57 | #define FLAG_BASIC(V, M, N)      { V, M | QEMU_BUILD_BUG_ON_ZERO(!(M)), N }

The warning does not seem to be too useful and we could even disable it,
but the workaround is simple in this case.

Cc: qemu-stable@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 linux-user/strace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 1233ebceb08..758c5d32b6c 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -54,7 +54,7 @@ struct flags {
 };
 
 /* No 'struct flags' element should have a zero mask. */
-#define FLAG_BASIC(V, M, N)      { V, M | QEMU_BUILD_BUG_ON_ZERO(!(M)), N }
+#define FLAG_BASIC(V, M, N)      { V, M | QEMU_BUILD_BUG_ON_ZERO((M) == 0), N }
 
 /* common flags for all architectures */
 #define FLAG_GENERIC_MASK(V, M)  FLAG_BASIC(V, M, #V)
-- 
2.51.0


