Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A36EFE7718A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:39:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJJH-0003oH-MQ; Thu, 19 Dec 2024 11:23:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOFOC-00064d-7Q
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 07:12:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOFOA-00085r-GG
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 07:12:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734610340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=77YL3CQju10w6bIct28lRddqtLIyFBtb4F+LLpwIWEc=;
 b=EpQzmvx7W/sqTp5NJfuPmf79lsJoBth+hfzAMxldide6ieRch/zPx91wc8xHKJuVRbj20Y
 37wtdcScNxznMeGMlGEiu1X3tDAmCQl1KDkZX9UQaYfpoqAbI0+SIkPyjrWpolumFwVtJP
 9XXtuSqcu33e72rioMjZQqnkfikdJI8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-c1jkF6TjPoWSv_WYV_q2kQ-1; Thu, 19 Dec 2024 07:12:19 -0500
X-MC-Unique: c1jkF6TjPoWSv_WYV_q2kQ-1
X-Mimecast-MFC-AGG-ID: c1jkF6TjPoWSv_WYV_q2kQ
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43610eba55bso5915645e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 04:12:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734610338; x=1735215138;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=77YL3CQju10w6bIct28lRddqtLIyFBtb4F+LLpwIWEc=;
 b=tcjUEtwzgTVZDBVQAgIfRYjlnAl1c7tTVmg+2v6SL9S9COhAG2ymAjoPWeLhWckwqK
 YsDHQJ5z5IETxADWkDBzYULnDfG92P1PKypPbL7G4AatzYn7tdoeJht0ZgPupNd0FjQD
 w8Y/5voBEDL7DEkXO46u5r14uj3Ort+dFQTOU1gp5zLVOoT538mknZF1nrcYORmr03jn
 ZnDhLILIplMX7QrgckYNQ/VqvT3/AYqvjS2QQdrmTWOF0fJSzi3Ujrs/T/XiOqJjN1iV
 zoA403O9EZaS8tXKOLJ3kPtLvw8hNWl8/xe5cU6z3WnrCrh4+jdyP/9O/281Xs8nHz6m
 kJyw==
X-Gm-Message-State: AOJu0YzQN9J4sHpUJZbSfjJYAZY1q6dLWpC4debW7FtEdJye4dl1vIA1
 RxcNWccwdClMrBbifWBfdRYABP17cVcmqqOHEyHU+B4K96Rm3zXb6iCSeRW39GwdHYTeYRxLfm3
 Av1R53kvX9IkFFEeIxehfzihMapG5CebtfOiqOw/dhMVaYix02LIALs/QhPFA90ZZ4ICbDph4/n
 3ET9qP18p5yUA9vW6A3LnLXuXzgLX6rA1i/Wud
X-Gm-Gg: ASbGnctdoe5M+wZE7v/5H6Oh9vy6tVu1aKjDUQdsExraQ/KVYNDVoKJjhc5ZTtFoTsO
 1D0I3GSvkkQjzhCgHgE4lMcd7umcF/LHN+zV5RHl8qkMa9LIZqMyPh1hoqKHKT4NUcagRFE9M/Z
 eGeXnxgU8E0PbW1NgAHKUxSZXmlyyvdiQvt9qU+93FCmPqTcD2wlRkSu+QVln72fuEaJyiVaWEB
 gnRcYzTtE6GLCPO9lueGwRB4LBXAGgKTYzkZenGhUrvg4Znj7IOP5488ZOn
X-Received: by 2002:a05:600c:4f94:b0:434:f396:525e with SMTP id
 5b1f17b1804b1-4365535b4d9mr63692305e9.9.1734610337921; 
 Thu, 19 Dec 2024 04:12:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF84SS2885omveEN4sf3Pnc/DAr4MWi0dYxPpARP8yxRQ5D3zhdzwtygH657rG0LyWPMBqPCw==
X-Received: by 2002:a05:600c:4f94:b0:434:f396:525e with SMTP id
 5b1f17b1804b1-4365535b4d9mr63692005e9.9.1734610337506; 
 Thu, 19 Dec 2024 04:12:17 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656af6c66sm52055805e9.5.2024.12.19.04.12.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 04:12:17 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com
Subject: [PATCH 00/10] Next round of qemu_api patches
Date: Thu, 19 Dec 2024 13:12:06 +0100
Message-ID: <20241219121216.416905-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

This includes:

1) the outcome of reviewing
   https://lore.kernel.org/qemu-devel/20241209123717.99077-1-pbonzini@redhat.com/T/,
   especially with respect to instance_finalize implementation and
   Rust-defined subclasses (patches 1-6)

2) the beginnings of separating instance_init/instance_post_init
   (patches 7-8)

3) extracting pl011's logic to convert an integer into an enum into a
   #[derive(TryInto)] procedural macro.

Zhao: I have placed these in rust-next, but feel free to ignore them for
your next HPET submission.  I have also included in rust-next your test
additions for usage in CI, but I'm not including them here to give you
the opportunity to post them with a commit message and a signed-off-by.

Paolo

Paolo Bonzini (10):
  rust: qom: add ParentField
  rust: add a utility module for compile-time type checks
  rust: macros: check that the first field of a #[derive(Object)] struct is a ParentField
  rust: macros: check that #[derive(Object)] requires #[repr(C)]
  rust: qom: automatically use Drop trait to implement instance_finalize
  rust: qom: move device_id to PL011 class side
  rust: pl011: only leave embedded object initialization in instance_init
  rust: qom: make INSTANCE_POST_INIT take a shared reference
  rust: qemu-api-macros: extend error reporting facility to parse errors
  rust: qemu-api-macros: add automatic TryFrom/TryInto derivation

 rust/hw/char/pl011/src/device.rs  |  81 ++++++++--------
 rust/hw/char/pl011/src/lib.rs     |  28 +-----
 rust/qemu-api-macros/src/lib.rs   | 150 ++++++++++++++++++++++--------
 rust/qemu-api-macros/src/utils.rs |  26 ++++++
 rust/qemu-api/meson.build         |   1 +
 rust/qemu-api/src/assertions.rs   |  90 ++++++++++++++++++
 rust/qemu-api/src/lib.rs          |   1 +
 rust/qemu-api/src/qom.rs          |  77 ++++++++++++---
 rust/qemu-api/src/sysbus.rs       |  12 +++
 rust/qemu-api/tests/tests.rs      |   4 +-
 10 files changed, 351 insertions(+), 119 deletions(-)
 create mode 100644 rust/qemu-api-macros/src/utils.rs
 create mode 100644 rust/qemu-api/src/assertions.rs

-- 
2.47.1


