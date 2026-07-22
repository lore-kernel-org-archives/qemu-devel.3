Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 030BCC4453A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 07:40:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmRYo-0005QN-J9; Wed, 22 Jul 2026 03:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wmRYg-0005P3-HU
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 03:40:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wmRYe-0000Sp-Qa
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 03:40:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784706000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X2cEn+7WktAkJCeArI/3pHUX+N1KMbDr4AYrLOAoPME=;
 b=CF5Q8RZHinZUNjvFPFycZGU2sn+N+o6ue/qCJfFaI5NAwdFCEgagXOqlrgHfnCT++C+OPr
 HtvYzzKWjyX6HVJRWSxHdSjfS0bhgj2uHI9MhUeMf1H9+zu1A6WppzdO2Lm5xO4L0Z9tNO
 xNtCXd2zPO77Uev4NY/7iiYheZ9TLL8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64--Hv_623wMvGkOVa7Dn6dqQ-1; Wed, 22 Jul 2026 03:39:58 -0400
X-MC-Unique: -Hv_623wMvGkOVa7Dn6dqQ-1
X-Mimecast-MFC-AGG-ID: -Hv_623wMvGkOVa7Dn6dqQ_1784705997
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-495529a93f9so26531425e9.3
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 00:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784705997; x=1785310797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X2cEn+7WktAkJCeArI/3pHUX+N1KMbDr4AYrLOAoPME=;
 b=pLwb+lM7Ztlfz2nFnW5cE/wWrmtHfEZAgdu+dQ0HEcU6qfVspNhPApTobARHEbumEz
 gBxOjVgz9Egm0TA+76z55zNSivCZcSiTyCOOC/bFLDgiB4uFUPYxYwZqjcepDQwEaPTB
 Su1u3Cpr5RHA6yH5+ussKnEFiM1eVNTgoBtcWw2AYi/n+rWO+B+MYFUNVDvpbqjnju6u
 tmehjaKIkdpySQDGK/83qZuUM9M9EZkLsOGIB6vp/tX7HmZXHYIoBl4vA4A5rJh068iH
 978OiV7ZcM3B+LMfiUJJgrfrB3Nc6pMyzF50qBz44Y1SrCv+FyDONZkbLwgHg36U7Qk7
 YqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784705997; x=1785310797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=X2cEn+7WktAkJCeArI/3pHUX+N1KMbDr4AYrLOAoPME=;
 b=sRKkC1Ptan7cq+niBXcriuWRHMgwKjPuUoOuUqCxyaKs6EmcxBav1k94kTHNt6Rt2f
 JxZ38tU1oW3iNI0QDPHvJIZdLwpbVHfYbZPCyk5saxiVwPWmHIo0lgfZkMyb3PFQfnJy
 Tu1qn7503TKn0q0DBuG8ddErOIjO6xfmKNr1S1xl8Q2Dq4x+6Vzmqfzg7lDs7Py6ycF4
 PQq6lGkfk0kaskrH2X9n8iAw4ZvKdTZvlwYO+cpLmY0pTZz244ZFyfrN7+DZ5XrsVLT/
 mycih3cJnoTWz0qftiZS0uPjqRQJCaa6JPMh/D0FGLxRWUfbUgP3BRvgczAAkDarF39e
 WgeA==
X-Gm-Message-State: AOJu0YxCyshkl5bQG+eZWiYPTpZNeoMdcCR+m6hkml22LSxDHQekcX0X
 n5z043x94AfL5uK3quOJYXLUoHOApo+8AdCjcqMwtSTCD1aBHNwqIuEJ+/iUPNKPkZzJJQnFMHv
 gGiRWHb5mvTYLfx4m7E0T77hajUMwm+DVnA3Q9x1MaddJKb5frnUH5ZGEqpaRJatXetL6cy5iri
 MLObnB5UbkRJ+dQ28RROINS48JBDb790W/Jdb/wfwT
X-Gm-Gg: AR+sD10hq8/Sebc9J37JPJOsmmaEb9EN1/hf1vgCMKKHqpsprCHOQJkCQHEAhFbEg8a
 lyQ70EXLGlkBYM7BY/Fq4LOSx8p+eN+eq9rVX99k+ht/YtFDuSZAEHsW36CG03yVWCQIiUHDbD8
 JN8t6U/ZYOm8t/s0E4LAeJaAJgHPjGuVisXZmZP3WWLD17dbT/rTLjNAA1iIkAXeSIaTFT67e8v
 k6A7rdQcCc80NrQr0fM/QMv+vUt6rIKzsxDPbB1TdN6LUB/m70JTh1Dt7iwUI+nmWURFPqb4Z7R
 jHU12i35gfWAy9r1TUQdzWSdh+ReE571Jkfuz2RJB9NKU18eAauKPDFkzw6DMDLJMoD08AnBNTk
 lFT6HBQagfSlI6ukE3GbCbD5zwsk4VJqxuY2iIFdvwK+MnUhBDbbQeoy3wqbvq2MQnJHVQsJ1Nf
 50H1oB
X-Received: by 2002:a05:600c:4585:b0:493:b87c:c87d with SMTP id
 5b1f17b1804b1-4954a3f3644mr233083495e9.11.1784705997201; 
 Wed, 22 Jul 2026 00:39:57 -0700 (PDT)
X-Received: by 2002:a05:600c:4585:b0:493:b87c:c87d with SMTP id
 5b1f17b1804b1-4954a3f3644mr233083135e9.11.1784705996766; 
 Wed, 22 Jul 2026 00:39:56 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.94.110])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c67339sm3648414f8f.31.2026.07.22.00.39.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 00:39:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 2/5] meson: propagate qemu_ldflags to Rust link step
Date: Wed, 22 Jul 2026 09:39:40 +0200
Message-ID: <20260722073943.396872-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722073943.396872-1-pbonzini@redhat.com>
References: <20260722073943.396872-1-pbonzini@redhat.com>
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
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

From: Brian Cain <brian.cain@oss.qualcomm.com>

Sanitizer flags are added to qemu_ldflags and applied globally for
all_languages, but all_languages never includes 'rust'.

Fixes link errors like the ones below:

    -Wl,-rpath,$ORIGIN/../qemu-macros:<sysroot>/lib/rustlib/x86_64-unknown-linux-gnu/lib"
      = note: some arguments are omitted. use `--verbose` to show all linker arguments
      = note: rust-lld: error: undefined symbol: __ubsan_handle_type_mismatch_v1
              >>> referenced by event-loop-base.c:104 (../qemu_before_fix/event-loop-base.c:104)
              >>>               libevent-loop-base.a.p/event-loop-base.c.o:(event_loop_base_class_init)
              >>> referenced by event-loop-base.c:105 (../qemu_before_fix/event-loop-base.c:105)
              >>>               libevent-loop-base.a.p/event-loop-base.c.o:(event_loop_base_class_init)
              >>> referenced by event-loop-base.c:58 (../qemu_before_fix/event-loop-base.c:58)
              >>>               libevent-loop-base.a.p/event-loop-base.c.o:(event_loop_base_set_param)
              >>> referenced 11240 more times

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20260714021236.2361604-1-brian.cain@oss.qualcomm.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/meson.build b/meson.build
index 164328ded83..5f42bbf40c7 100644
--- a/meson.build
+++ b/meson.build
@@ -767,6 +767,9 @@ endif
 add_project_arguments(cc.get_supported_arguments(qemu_common_flags + qemu_cflags + warn_flags),
                       native: false, language: 'c')
 add_global_link_arguments(qemu_ldflags, native: false, language: all_languages)
+if have_rust
+  add_global_link_arguments(qemu_ldflags, native: false, language: 'rust')
+endif
 
 if 'cpp' in all_languages
   add_project_arguments(cxx.get_supported_arguments(qemu_common_flags + qemu_cxxflags),
-- 
2.55.0


