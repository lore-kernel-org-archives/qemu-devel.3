Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 938BCC8303C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 17:17:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYpSi-0004QX-HB; Mon, 07 Jul 2025 13:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uYpMx-0005vG-B4
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 13:11:10 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uYpMt-0003dG-T8
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 13:11:05 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-453749aef9eso11763645e9.3
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 10:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751908261; x=1752513061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Fgd69cZqDaChk8ERhuyQQvu9jACIRvRjPskHMA1WZtM=;
 b=z2ziWuCMs94YdI41ZOHZvSdxhywi7IV8g7HxDB8qVMGYSzUDNu96FDD72vPwPwWOIc
 9WXwqwICNiIW02OD48/yq4lbVc0/g/s0wkRpgsY65xd+NYB07FJ1TDErDtB99FR1XMxS
 /nMRY5grm7a+if56BPixR5qMf0sH1X6tbSZnNzGXbXfcbvUO7iC2oW2FXkkOT+Maa8Z3
 z7QRzf18r+wV72XObpIu+99ctwFr+95ZiGzobR37nmDwwdZjmdzH9nUz/7OElXhfH6Tj
 wSXEAxH4IN2QGujBy6CywJoOQsg53zU5kwGYgqnylxHRKRe43H2/hatVPBIzjCRD5cfa
 8zMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751908261; x=1752513061;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fgd69cZqDaChk8ERhuyQQvu9jACIRvRjPskHMA1WZtM=;
 b=L9Zg8TyPfMj4DMk6TAKsB0A0K5Js//QuUn4GI1IJB6cKSLmqPExeAPR6RGzytCMAH1
 p7LTALAkrOwwFoSYJx5dee++fyskJ8seBcVeQZLAEPY1bfK//MDn/EniXemMrKeFwXxV
 OU9GvcwFE4K2WvrTLVAzbxCoE7RvJeBed0WDjt3eXLhP3UQf97JilWmnWSkXnIMHXcwN
 2Z2cFCukZ+HNxWXZ9qqtUak4GAZfSdKSCxeyXmouhXAO0KBGgXk6o+hYJYh1Hh2qMwTr
 6Qo751W9pBtaYSykwh3i4xbPWY1I97gk5TRHczBk/yScU6mF3zVY+SGOu7PQSX6M5pqB
 N3mw==
X-Gm-Message-State: AOJu0Yxj41k6cwwJ+NRzEKWKSAvushhK3xQM8wzSe9EY3HTh+agKAd0x
 9n79naFUnoohLyLfjmW1fuH6Qpqi0s7T3FYRiTuGqdZ+AxjHJH2/brOS1OoNUjDJkMXwUSP8A25
 P8CnpeaA=
X-Gm-Gg: ASbGncvSXQpixk9qZVoswLDAZ3ACWpbeuR/YXg80rZFvxkYBx+h46R/MJdgOmFBIbw1
 5C6KzFfkaTo9U9YqxdUe23tFnvpEHj17weeQGMnVIkw/aqV+bdd/pgOrq2gWCt3qF9hcvxQm8Gw
 nIPfMTV1AusXTur2lR2FZg+WfjfbNOZKlI+mXjuJ7hUhrkM5lrnTXPFkZwaZA2sVf1ZREa8V8lo
 yPNLs1DLZ+z0XVxvyM5VBf3zVnWrjSA94Gslsg15quATjzIsywCOo5kJI1EX/whVJgW3Fb0BE4v
 49uCwQAfVJ1JcSbYVv991XerJZBAfqItZB8h0ehpZpY9uphTArQpK4k9bgQKfTPfCooGmFp8g6t
 ohYMM0uEK1MbfSZ/NatjSWBZvwph5dia6rN0KN0+VBGT07LY=
X-Google-Smtp-Source: AGHT+IHK/YvK0FcUw32PYkwoncGJsxPLWdir28p/MyjapjmeE5aehVHThBXSHF8+AF/xpx7EoMfHjQ==
X-Received: by 2002:a05:600c:8b2a:b0:43d:9d5:474d with SMTP id
 5b1f17b1804b1-454ccbe922emr4976365e9.0.1751908261583; 
 Mon, 07 Jul 2025 10:11:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47225a4e1sm10775447f8f.74.2025.07.07.10.11.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 07 Jul 2025 10:11:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] target/s390x: Few target_ulong -> vaddr replacements
Date: Mon,  7 Jul 2025 19:10:57 +0200
Message-ID: <20250707171059.3064-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Replace few 'target_ulong' by 'vaddr' in target/s390x/
(the other lefts aren't in my way, so I'm ignoring them).

Philippe Mathieu-Daudé (2):
  target/s390x/kvm: Use vaddr in find/insert_hw_breakpoint()
  target/s390x/tcg: Use vaddr in s390_probe_access()

 target/s390x/kvm/kvm.c        |  4 ++--
 target/s390x/tcg/mem_helper.c | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.49.0


