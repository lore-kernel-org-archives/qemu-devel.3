Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C8AE8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:50:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQvw-0008Kb-5C; Sat, 27 Dec 2025 04:50:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQvu-00084g-M1
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:49:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQvt-00075t-7z
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:49:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766828996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PMU0TbzHVCICIeQUh7syleLCdQedbGHpfCrxxYMN8JI=;
 b=fooZQ6I8QtwVd7vELPrpdUOkr/Z61ruih4tGPmNoptesYgLHrng9PxdUoPyo8zxafHjAiV
 kXvvsmvAz5zDNONQUzSqrKMT3cxcPbxLR59XbkGOkdKPh6gAgUOeU7B/EkThU87cTGfkkb
 uBQ5RiTLxhhhonThU4ckMlGzYBUqApY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-rpS8eLaEPrejxk36jAVEKg-1; Sat, 27 Dec 2025 04:49:55 -0500
X-MC-Unique: rpS8eLaEPrejxk36jAVEKg-1
X-Mimecast-MFC-AGG-ID: rpS8eLaEPrejxk36jAVEKg_1766828994
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-430fcf10280so5703746f8f.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766828993; x=1767433793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PMU0TbzHVCICIeQUh7syleLCdQedbGHpfCrxxYMN8JI=;
 b=a95G8cSkKTG6XTKFUBSZs+qNlfNFhprO8wZIFcwViObny/YXNAbPVLOGFIGCiQicMM
 qHZ+8te2hFLdbmU0/derN2rhTzeU9oZYVXX4Qe1EWGEC0ze620A56gFLf/MTM8HSyzLX
 49BKnPg6x73wbjMnhluupN1+3RzJrDWd/rJZqANQMXnkPvKku9MrbcGnaIYJ6XbevHXC
 1Osrj6GyaWDU3/sxF5nw97Ek4pDVkQII48Q+WU63pmC+Jo21q+wIHlw9m20gbfnvSaPf
 3WIUrxNDYkr9PBfnOMn6rAXIreCaS9M7lh2YN/CvDG6Vc6mzQMtV/wcnBwiqnNRiso1i
 RKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766828993; x=1767433793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PMU0TbzHVCICIeQUh7syleLCdQedbGHpfCrxxYMN8JI=;
 b=E68Xjd/PQZ+cfmqyeeqKwQq7zVf1vlpZC6luJ3zxBxqydf9htM2/ZnxnoR8fkKlaED
 9th8lYXQRCKIs44eFGxZU3YlsNm1MFU2cRbfRzlZqLYxsIqRD+eOiXXZOpurvQRiJDkV
 hKt/+wvQx7xoXXM1KH99a5F1OHdEgC1dl7QZco7or99S/ax8WY8qsjovTLao34grgxwL
 RhHArmtFBau37mnLPMwWRto1rFSGqe8C3tIU6E70lTbcV4radNSNyfenSorlmCMr0ANq
 PKBTPH5yYUy67vGEjMnCAn/5F1eujo4QE2J4wdkr3FN9woHuk6ZqxPOrbbPSrZMCptW9
 RQ0Q==
X-Gm-Message-State: AOJu0YyPD6LEw2OpNnLGHsyr6IsL7DyrJC+cenxvqj+JC2gX9COgLGk8
 bH9fRnECOG22hmo3WySgCGkfKnZlzTmnAFWjf5F3F2EEwQRr0yw75eqEkINuEOjrD7e5xxD9msi
 DXYb1cUbnadrlwz6ufQEZ4mD6VZVpNOYmiQPlw5UjtnlYrhvOVR2SIkPxLzBPviabJZzh5w6VVI
 gq8bpIe22Jwak8BBunIKQe0xcpxWaRLuaz63wMX+5M
X-Gm-Gg: AY/fxX4T+v6TwN4Yu9cQkbsDBvtyLINWTGLyvAn4deH0D4zzKL5FngZyDKmB02E56N6
 o9sHGMdCm5rqCjOKsIntFjWM84dWn0rQpWHhND1U8SNdymSLLcjGvjXCp3EasVd4gEjMhGoQCES
 sg/wL6Xb6zMH7tPLOKKM/IR8+Zz6j7B8VsGkflJ4JwGnPKQs/6PWVZmwbVjG6xsKHF8m8NZwes1
 lorjH5HBftO2LZeu4cz/PtJmbYbgeEwDmuSrUW3eGlAClBIj4bLrVV5s9ktZZKRsU6DatSXVzt9
 +H2Uod/TsQ+X8hxbfmlVyS/uyFAmSrjwA2ZC6cRsfUJ4zljd+8YXHJzV4zjBzXni3jiYEYbwY7d
 usWFsOHEZZ+i+4HycWTr3otwP3HWwJv9i4l7HB0m47rWrCUIOwKCkMeCdUBN8/SaaSpgGq5RRQ+
 ShOF49/XAvJSdbe64=
X-Received: by 2002:a05:6000:24c9:b0:430:fc0f:8fb3 with SMTP id
 ffacd0b85a97d-4324e506148mr32426808f8f.38.1766828992667; 
 Sat, 27 Dec 2025 01:49:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJXFnpu0JbO/6cFU3CuXRVr1tAiNx2eE8D8T+K2bq1tymmqAAiNjqCCXWJwrYn7I+UNa0R+A==
X-Received: by 2002:a05:6000:24c9:b0:430:fc0f:8fb3 with SMTP id
 ffacd0b85a97d-4324e506148mr32426785f8f.38.1766828992175; 
 Sat, 27 Dec 2025 01:49:52 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab33f5sm50352349f8f.41.2025.12.27.01.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:49:50 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 117/153] target/i386/tcg: update cc_op after PUSHF
Date: Sat, 27 Dec 2025 10:47:22 +0100
Message-ID: <20251227094759.35658-43-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

PUSHF already needs to compute the full eflags; set the cc_op to
CC_OP_EFLAGS to avoid duplicate computation in subsequent code.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/emit.c.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 1a7fab9333a..22e53f5b000 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -3250,6 +3250,8 @@ static void gen_PUSHF(DisasContext *s, X86DecodedInsn *decode)
     gen_update_cc_op(s);
     gen_helper_read_eflags(s->T0, tcg_env);
     gen_push_v(s, s->T0);
+    decode->cc_src = s->T0;
+    decode->cc_op = CC_OP_EFLAGS;
 }
 
 static MemOp gen_shift_count(DisasContext *s, X86DecodedInsn *decode,
-- 
2.52.0


