Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59927C53200
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 02:28:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woB3w-0006DT-0D; Sun, 26 Jul 2026 22:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flavien.solt97@gmail.com>)
 id 1woB3u-00067i-9i
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 22:27:26 -0400
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flavien.solt97@gmail.com>)
 id 1woB3s-0001AP-SZ
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 22:27:26 -0400
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-92e50979c71so227649785a.3
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 19:27:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785119244; cv=none;
 d=google.com; s=arc-20260327;
 b=eQzwla38e021/Ym0GpOnM+ebwWWmGBTY5/gCc4M14BbrSTlHrvqD52dvVZ7K7pWwRB
 hUsAlgN8hAx6JY6rQizYFASSK8KjcoB9Qc8ykuLEh+6nl61C0MZcMJb+k5SRbW6YHwz4
 fBkawPv+wtWs++4zqllJGSK4p7dTz8kP+PoT34L56Z4kCyefAmHXzO38XE+tOxMWFt98
 KcYUTd2kvnFR1XQJIlxaDR3pRn5UfiaV3aajW+i/KbHX25c70aFP/Rruve+GvIEEc9b0
 dXvZc62HPaNltP/VS+kQ7rDSkXgZhCpAAtxaZJaTTkoxUfwQXCfxxLDSJBw5kCS+uaGn
 RcdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=9GfBGEHDow035OD+L8EscRp3lbwrnjiH9DkJOcGBpc4=;
 fh=tM9uqhnisH6PlMOYdsdDavWujv1Qk2/fU/qZi5QboKo=;
 b=pKkgW/JxHZqNgnc06Foh4tz0qUwHCh3vI3KJSjvmzbFY5xf/warSn/B6/J0MFbEGS+
 /eohjx/t2/mHLDMs2AfJjeaiYO+e+FdWT8QRpbgMjCY8MSqS2YZsiWH0i3HJxiFHv8Fx
 aAUOcxYZSWDe0cgpNgLioOZgFkLsJLE1k3mbEgeNCkWSs4vn3oQb7d2irTpOUeGcJTcI
 +IQh06KSR+VxeKFxX4C90vTttcEQgXlhis0v1uIY6mOi1dxhWatqDWDQjTgsKaEC7+/1
 cYY03auWC3r7OOtsctScI7A4Vvb+fyLzPq+7ybpWkhweHIYWdG+6pcZ4iXLuQ49NOzOM
 Ie/g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785119244; x=1785724044; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9GfBGEHDow035OD+L8EscRp3lbwrnjiH9DkJOcGBpc4=;
 b=rh7wBNh4eWSBI+8TeoZG68nim9wKACmVOV6yGYgMCH++Rah0P7N19InXhQrXgYIWgB
 K5HYCLeL7KAi9e8KePNe+MXl9NX4n+W7UQlJNoVW7tPzFdJB4HlLcV0+p7YOnpk5knIj
 FtICG+NGhUlZOTfL/U6+WnuGo0J2P6+mhOy00bn+skUyVHwML90m6td3PauzJdYbMHwW
 99umds6j0VbXowazK+fhX2/dRv6yyLcmHvQJ0SnJ7ooflPjIB1SccGKmi+AUM63/4pDt
 qT+vWFSMZ0OYnywrfHTjU4QawFPvw2nVmlHUYBGz8vvQ3UplnQ1LvYtMellXfCTPyztZ
 dAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785119244; x=1785724044;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9GfBGEHDow035OD+L8EscRp3lbwrnjiH9DkJOcGBpc4=;
 b=L4eR1lUFSDA2+WuRklwObsfHAmICxU8ajBRLdO2EaYxerwbwuX++RjME2Dp8nv7nba
 K5/UCa32EEhzop6Hui8p+AxrdbE3ptEaZeRb3Awd6t8wV/jsZT/Ei9SWhK2ysCAGeCZ1
 awDkyEHo1QbvkH76tpDHnAvqoQxFgnuT6l0UxQ4qjP3hM/V8IkSKqs57al9WpYFG/UeB
 9eK+HVxjqBiqpKce4a3O/RNQIdb8mprX6IDGtSfYdry/m0IzXukrzaNnb9Mbft3illpE
 b8FEptk3vI0TES+f7hl+29VTGZE63DzBXqju7MGhulq39O/ZrzUZG4h7I15gbwh8Nwk/
 /bng==
X-Gm-Message-State: AOJu0Yw5arVuIkOMeqhSFiYp+jX313SHawgmKKvHO7adNxvjTwX9Jfdb
 GDZ4cajwDYC0GDJlZyaDjN4p3VPPQACi2dT/9/nQWXFgJVk512fu1vZJiSh7M0hjMQxEIcgssat
 gbhIMbwnZCmtH0bTmlQuUvP7UCOHPhuz8Ow==
X-Gm-Gg: AR+sD12gNgXouaLn+XxIJc0sqDLR7SWRL8P3NI/yIpVdhwTEYmNlK/xB6TzCrVG95/I
 pG0LUnZslVtXiZooXvn5LSTgwvb8ITc0cYbM0eIn+0UsGKfc3ADqKEbW1r5SCN+GHpmwcE/eaAh
 V4hDxV6uWwBLv0F8/L/HsB9wFdAntOwUzdemrrlwEnYxHN8mLJ9v0RnoJMFRd/ucpyEkv0CEn2N
 KU0FDFKBqfI5cRZXg5r+tcAKVkVDdYkPz5Tn2wDppo6vFNI1+6AiHuB/WBfkR5vfSvK0XVmmQgk
 ZVJLucBMdGS0nZU2g1wAOw9BkzA=
X-Received: by 2002:a05:620a:371d:b0:92b:6805:9190 with SMTP id
 af79cd13be357-932df6be119mr672460385a.72.1785119243794; Sun, 26 Jul 2026
 19:27:23 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Sun, 26 Jul 2026 19:27:23 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Sun, 26 Jul 2026 19:26:54 -0700
MIME-Version: 1.0
From: flavien.solt97@gmail.com
Date: Sun, 26 Jul 2026 19:27:23 -0700
X-Gm-Features: AUfX_mx5NsBXFPq6M4X--OaKlWR560mf-Nal1wpBiPyQEKFcV0heJ_FyOlFYcsg
Message-ID: <CANVUYGvOyZdCwXOtDkS7bXY3Z2HGK1b6QWKttCVUjhnpH65g5A@mail.gmail.com>
Subject: [PATCH v3 0/3] riscv-iommu: always send MRIF notice MSI
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Andrew Jones <andrew.jones@oss.qualcomm.com>, 
 Tao Tang <tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::730;
 envelope-from=flavien.solt97@gmail.com; helo=mail-qk1-x730.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From a13bfa64b84ac70c9e257253616ce650fc3e794b Mon Sep 17 00:00:00 2001
From: Flavien Solt <flavien.solt97@gmail.com>
Date: Mon, 27 Jul 2026 09:45:06 +0800
Subject: [PATCH v3 0/3] riscv-iommu: always send MRIF notice MSI

The AIA specification requires an IOMMU to send the configured notice
MSI after storing an MSI to an MRIF even when the destination interrupt
is disabled. QEMU currently reads the MRIF interrupt-enable word and
returns without sending the notice when the matching bit is clear.

Patch 1 lets iommu-testdev select an MSI payload and supplies its PCI
requester ID. Patch 2 removes the invalid enable-bit gate. Patch 3 checks
both enable states through qemu-system-riscv64.

The complete RISC-V IOMMU qtest suite passes:

  MRIF notice: enable=0 pending=0x20 notice=0x12d
  MRIF notice: enable=1 pending=0x20 notice=0x12d
  6/6 tests passed

This revision resends unchanged code after hunk headers in v2 were
hard-wrapped in transit. The messages use patch-safe MIME transfer
encoding. Patch 1 now carries Tao Tang's Reviewed-by tag.

Changes in v3:
  - Resend with patch-safe MIME transfer encoding.
  - Add Tao Tang's Reviewed-by tag to patch 1.

Changes in v2:
  - Wrap the fix commit message.
  - Keep the existing notification comment.
  - Add deterministic IE-clear and IE-set qtests.

Flavien Solt (3):
  hw/misc/iommu-testdev: support PCI MSI test writes
  hw/riscv/riscv-iommu.c: always send MRIF notice MSI
  tests/qtest: add RISC-V IOMMU MRIF notice tests

 hw/misc/iommu-testdev.c         |  14 ++++-
 hw/riscv/riscv-iommu.c          |  13 ----
 include/hw/misc/iommu-testdev.h |   1 +
 tests/qtest/iommu-riscv-test.c  | 102 ++++++++++++++++++++++++++++++++
 4 files changed, 115 insertions(+), 15 deletions(-)


base-commit: 499039798cdad7d86b787fec0eaf1da4151c0f05
-- 
2.54.0

