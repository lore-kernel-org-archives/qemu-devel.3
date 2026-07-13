Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57356C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 11:47:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjF7Q-00046i-I5; Mon, 13 Jul 2026 07:46:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wjF7L-000469-R8
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:46:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wjF7I-0003ox-Mp
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:46:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783943187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=e4It8u2KpKs1trJIciaJQ4z1TShGKaqnv60R8EDCtCA=;
 b=G/iMVdF3Jn7WtuelmVTsKlQmaoBQbR9n2zEzxNoRe7jwwW2a0HDqKesFcpdVIgF9ZsSBCl
 ZwZVrhXr/va8ZagwZDy5BeAMdvLX4gIcbUX0nA3AZlKEBsrVhaWKwUmKRpaRlA3uhSHODC
 aSuAAjAYDNLaVkaeX7AoUoPz/vf0wZA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-V8856LaiOhKitwxspZFuBg-1; Mon, 13 Jul 2026 07:46:26 -0400
X-MC-Unique: V8856LaiOhKitwxspZFuBg-1
X-Mimecast-MFC-AGG-ID: V8856LaiOhKitwxspZFuBg_1783943185
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-472bdd6f529so1840705f8f.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 04:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783943185; x=1784547985; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=e4It8u2KpKs1trJIciaJQ4z1TShGKaqnv60R8EDCtCA=;
 b=lO+EX0VveK4dbAw3kT4G4HQVuCX6+17F+u14LfW5QbhlB41N5xYsTWDsKdCu+WVgyQ
 yMNwTBKbjPw7f1PJ/cyoUcjRtjGGgqcq3CB7xjUau7MDyXtBxi0qWmyORVYrRuAdNcjI
 LMbPspz1n4aPf09Ix4R+SHDBRPcKvvMbZV/TVg36VPZvtUDd1ZKx+GvtKZfD2LeKA0c2
 whPcaf8oCqAXhRymalfyGfkD9qmRoibQv+PaGdj7c6k2hmDrTJd73CVoLIVwtlHPQudC
 1FD0/NaFnsfxoBfXZ0c528RhfNIZSet9Y2logydIawjGcqUhXzY29v77i7we3ETDisrE
 +OaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783943185; x=1784547985;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e4It8u2KpKs1trJIciaJQ4z1TShGKaqnv60R8EDCtCA=;
 b=a/QHBWPNMqE5dJ/Ygzmd8PWFjYdOtuCWC4FYHPXcRM7i/6uHc8WIzvuLD2/Q0SF4RU
 QPmHk5H5pJY0FZXcLVtLA1Uk/qiVSrYcMc+N6GaAPRbrFWNVKRT3N8AfOlb+rrJjllMb
 Fs6rKxRRUWN+jRXk1Kldp4G4x7Q9RKA6P8u70xdM2w3/Ad902mrcrjv2IpVEFW2XJ5sx
 T/WZt6TwZ557bkcwxdJQmgEBivF+kM2j/EtnqFbQeTUCre107wx2hxOs9230Tttmqy22
 3IrFYs9hoWLLvddn4okbQACG3dietw+PPIRwrUbbJasc/uPAw9vVXCzGanu4BdW/n3L1
 5+5g==
X-Gm-Message-State: AOJu0YyOBE7Zb64ow9VLkPyvaolIVi+7qbDHBpDPss4qtqyUcaSNmFEJ
 p4mvhVKLfNsX0fe/bJ09tgWMgg+YX+Wafz5n0kRgJuwcRpSNC4HA4ySYQk02xZtuZp1t8GIeF8y
 xD89ikLLrt6K8zlDp6dIhXl0MiSA46QM3g3fTVIm7QiU4nU9/PixQGk8+Y0nkSYTChQi088Yhbm
 rpagYnk8CyAmtROyaw8RnTaObEbRZexGtJD6qgMlYP
X-Gm-Gg: AfdE7cmoSYfoMGkAC5RWWPhew3nn+WxisXGjaNiJUwtVjPiZIDaewXJfsPb0Z1L1V0H
 5eFA6lEnQ5K1izfkYDOYdenQkAUUVa5qv3nMGlkUSGhY7ccM1r3nXuoQakPwOqkXD/J1xfaEFUm
 zq2qhRz9LD1KlC8dt5KmStTm0ACxHkB2aRFZjUKwa8B03wVmi8lPKtqQq4RH4hJwQ5uUWNfYkU8
 oi526tQi3+wSt5eeM3XJb0YpzNDuwdjyzygtEnmMUnwIuW4vmCkMg/3YPqL0aDfYV3mWMYySDFd
 JUKiSBUc+pqSYW8xe9DmD1Xj8E6JOn3lFgsW7g/+xraCZQCuv/l5JfsdtjM2+j4dHV+WKlEYuIh
 r0KxvD6oSvrhT//WWC9kbuZpcPektRv+Pz7+Z7b79fj+wKzpqsXdRm3L+ppdpbfkEfPExZLcIW6
 Y+tZDTaJ0OSQU+I9c=
X-Received: by 2002:a05:6000:2086:b0:47d:d812:e067 with SMTP id
 ffacd0b85a97d-47f2dcc5bfcmr9576233f8f.29.1783943184759; 
 Mon, 13 Jul 2026 04:46:24 -0700 (PDT)
X-Received: by 2002:a05:6000:2086:b0:47d:d812:e067 with SMTP id
 ffacd0b85a97d-47f2dcc5bfcmr9576194f8f.29.1783943184315; 
 Mon, 13 Jul 2026 04:46:24 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.48.175])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f273195d9sm24938600f8f.3.2026.07.13.04.46.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 04:46:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
	qemu-trivial@nongnu.org
Subject: [PATCH] json-parser: fix formatting of comment
Date: Mon, 13 Jul 2026 13:46:22 +0200
Message-ID: <20260713114622.1950506-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=pbonzini@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qobject/json-parser.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 5935730c0c7..6b1b4762bda 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -29,9 +29,10 @@
  * object, an error, or NULL (if the object is incomplete and no error
  * happened) after every token.  Therefore it has an explicit
  * representation of its parser stack; each stack entry consists of a
- * parser state and a QObject: - a QList, for an array that is being
- * added to - a QDict, for a dictionary that is being added to - a
- * QString, for the key of the next pair that will be added to a QDict
+ * parser state and a QObject:
+ * - a QList, for an array that is being added to
+ * - a QDict, for a dictionary that is being added to
+ * - a QString, for the key of the next pair that will be added to a QDict
  *
  * The stack represents an arbitrary nesting of arrays and dictionaries
  * (whose next key has been parsed); it can also have a dictionary whose
-- 
2.54.0


