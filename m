Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BAAAD31A25
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 08:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfwP5-0003RG-42; Wed, 14 Jan 2026 03:39:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfwOi-0003Qf-VF
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 03:38:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfwOg-0001O8-Rr
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 03:38:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768379913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=TK6tDsdqqvDCVxtS+ZTrSupXzdkuGTJ324o1hkZm/Sk=;
 b=B32e5H/aCTSlO+R5/YG98sR+x5cqOooh8cal2jXIaqpYreEl9Wjv+DXLv9PS4zgig4QerU
 6ZvLV09uGaqBZePpkq6h1QYEDimly8xo64SWgfvqC/siEUYrUByQuZ8m/YipWCNkD7U/Pi
 P5+ra7vaeuPN1Vh9Y7JX3ftPiJKbFnM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-7LbuGy6JPwGTHJD_1SK9pg-1; Wed, 14 Jan 2026 03:38:32 -0500
X-MC-Unique: 7LbuGy6JPwGTHJD_1SK9pg-1
X-Mimecast-MFC-AGG-ID: 7LbuGy6JPwGTHJD_1SK9pg_1768379911
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-430f8866932so7073934f8f.1
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 00:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768379910; x=1768984710; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TK6tDsdqqvDCVxtS+ZTrSupXzdkuGTJ324o1hkZm/Sk=;
 b=ba8l+qxcqV1q0AAo6ImC818orKxC/voYiiwooyfevFx80qOvw0s5YGdgRShFNjjVOa
 mGDK5n+o3qrL6h1ExUWPk81/ZHe74eH8WPTIx0NyQwuUZBLsLjFWDo+FaPwv2Yk432/h
 IjIdfcRPVsRR40GvKYRXL+gJAjSq9YK+xV2BPyrc6MWwrIIcYQtkanfCdQPPcOb6JCM9
 PDvvt0G9+ViEDH60mvidFVL10WDVgboqcmpdUXu7UfH+bJXEoCsaM0NytitT81mqIeic
 FNKuNMjgzmp+4swliX/ysYHeaiW/kqJa8WzyYUgs/myudhNe4LYUofU5+xKrg/gfwWTe
 t7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768379910; x=1768984710;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TK6tDsdqqvDCVxtS+ZTrSupXzdkuGTJ324o1hkZm/Sk=;
 b=mLKZZBQDi/EqG5U/tY7fSK17M9EqllKDhYVrNJdHVo0mkXc1o4eJjBlECtVroQA2X/
 Onn3jXrcOcK2i0p8nOqq/tu5MHglAqouPhxLHDEc9gqzK23Vv2ZQSWeE/Z+JJF8sklph
 GGkNqlWQ2D1QT5eEu7agaPBCzo/VxjswFBwnvTZs8WABmOHM2TgT8+bPm+wKKnD7MBYm
 l56F3oQtxNW7Mh6JvwQBChLKnxnOAQFRtun6Ga71VVeqfuyjSs7H6086UVsuDivXGSnu
 r53VRMKBsYFelC51srQlx0+M+4Zpr8bIMgMuvmVZpTVD/RHtORqDkzNQAZvaLoWRIDg2
 p6KQ==
X-Gm-Message-State: AOJu0YweLHEegNYiQ0N77FR+TFBu85TJEClyGsQwV1MYMXXw/U8KwKyO
 wRqcFlBoc9JrbS79bJ51rHuz/nmFVqnkvjjusMCFVXcqxEzsh/+VDOGEjHZ191G/Ya4AXqaTZF8
 iI+QJJb8iM4H9sAeHxlddVF3e77vL/K9WoqPJ2g2SMq44Wsu/qj+S+qnCr6VlDej5ZbGWZ35uDB
 SIK0b9fh8XstxzxBGjhhmXk1K3aSIzeGKHmkgRhmzX
X-Gm-Gg: AY/fxX6c9sLTKJQlnFKVWgTCOJ88vzFJdwN3eLiHHAQFVuCxaQDx6SS+PBfBXFfF+AQ
 yptDm+9c8Z5OOZFmgN6korM2ETFX7OmCbgPJDj30GGeXXOC8xBhKebCCWx8cnKR4kBLjb2cbVhX
 lcx2y//b9hBrNIDSHZKxaM2vWYOvaPHCTxjQYPPOM2Rc0wzTDNyHF/yqJzvF7ayQSIqrpZvp73m
 K9UhArVwS8Azli0C62TWm580pO3AE/BZpuTFw+C0ceNqAUZma7iDFaU8leF6P1LaYmFyn0l/IXi
 izgAzWYGy/lVBZbRM0YulNdxSNanIYuUXeB0dOSzhR/tbwr2WvJ/8uWJ8Xutckvp9cwyndn0kiC
 H9VDV8OHSsy0y8q6ixGGeRmyxqAmUg8CEzAktvRLafDl/7i0K+z+9lYXNDA7Y1BGfBH7r/jNx+I
 B1luEeeJVCYjevbA==
X-Received: by 2002:a05:6000:2689:b0:42f:bbc6:eda2 with SMTP id
 ffacd0b85a97d-4342c54ad30mr1969111f8f.40.1768379910478; 
 Wed, 14 Jan 2026 00:38:30 -0800 (PST)
X-Received: by 2002:a05:6000:2689:b0:42f:bbc6:eda2 with SMTP id
 ffacd0b85a97d-4342c54ad30mr1969078f8f.40.1768379910018; 
 Wed, 14 Jan 2026 00:38:30 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df96asm47892412f8f.28.2026.01.14.00.38.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 00:38:29 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com
Subject: [PATCH] rust: trace: libc does not have syslog on windows
Date: Wed, 14 Jan 2026 09:38:10 +0100
Message-ID: <20260114083828.1305139-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
	This is not enough for the msys2-64bit job to pass, but it
	reaches linking.

 rust/trace/src/lib.rs | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rust/trace/src/lib.rs b/rust/trace/src/lib.rs
index c2abe430a52..143513891ac 100644
--- a/rust/trace/src/lib.rs
+++ b/rust/trace/src/lib.rs
@@ -3,9 +3,11 @@
 //! This crate provides macros that aid in using QEMU's tracepoint
 //! functionality.
 
+#[cfg(not(windows))]
 #[doc(hidden)]
 /// Re-exported item to avoid adding libc as a dependency everywhere.
 pub use libc::{syslog, LOG_INFO};
+
 #[doc(hidden)]
 /// Re-exported item to avoid adding probe as a dependency everywhere.
 pub use probe::probe;
-- 
2.52.0


