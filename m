Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE72EC021AD
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 16:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkQQc-0004qC-N8; Tue, 18 Feb 2025 11:26:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkQQV-0004o5-TP
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:26:28 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkQQR-0000hM-7Z
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:26:25 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43948021a45so58911095e9.1
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 08:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739895981; x=1740500781; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2VWhH/aV83Ufh8SIHunv7uipo1SrYPllVbk9DR0oCs0=;
 b=jngmf6FgsDsaIZNkVE3eal+FekeQi0Jau72wW6qz/pbof99WH5mIPYvY9WtBcScT6N
 kWTtJRLTI69mE5LCjBLA9yegSCjkb68uOF+cPzCT8vpHM8cJLpc9DLMYDJ56aB7a4z4k
 rPjp7vtfzRCwL3q26y7JUBV93AyjlM1/bpUqZ0JyPycPrRM53ev59pVS8ooxhy8XC7Zy
 dTMqDjX5rB7ARPlbY4uro1Wqn40iHbBnG+zZtPNVx2lbU7TwYb+5fEjF5IuHEuZ4p2Ii
 PIq9XE20m4640EQ+Jrds3uihz18xUYx7xYaymr0ZwIQY+6oCGSaFuQdHDBSxT+7xFplG
 TNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739895981; x=1740500781;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2VWhH/aV83Ufh8SIHunv7uipo1SrYPllVbk9DR0oCs0=;
 b=bik5c8L36iyfhpum3oKdVQywigI7BFeg/0z42zJLfhkqw0H03j7vST5x80n8SShyjn
 JD31QRRwugwrqafW6wjhROauV/y9gEhZYJLIqdUX0qRpOD5tXCpV4dFL3y/h4jRcuK1c
 +pfU60AToZS+LiUWrSvqmhqZovQySL6yZGAsgtmLxFmlWp56vKUZKu5Chrv+35HslJyh
 yXQ/P/vSTxwhCexVZetI1WZef+WYPLgwYYRCPbVAW5R7U5ykjo0NU+LdYrP3bjbpxssY
 5dIfL6smfir3gt06QY6cHFk6aAaDtW3jQtbo86ucjt1SyoGhTesRARZ1B9MEOGSO4bsh
 l2QA==
X-Gm-Message-State: AOJu0YxsxnzrcCqH1kZKTa6vSj0DrzCrHCS5iXvKSm0yrOQLuLV/OzO5
 R8lF7+Xw2+jTeGd91mctruVGRICjPvfMNVMu6UTj3pLUDb72J23ZvxLqJSck07yhlQ99BcYOEwM
 80Pg=
X-Gm-Gg: ASbGnctxAs+ANj3HUKeCJoRBB0eAW6NjcE7nUKy1OZTrAy1uqvbhFWYLcgvEQzPFqtB
 coOv24BTSTk2lsIT6vgbcGtqPQ3G+x703fhXZ5HXLelP90qDAxf28W3aSHIFTHIKeOeBRAsWk7b
 EsyrH7WSEDzBlfi0oT/msjkwislWnqmW7A+i4JpPkcXnEnTqeCPCBXpGnhJuO/WTrK8qw2Z4soe
 JxvSwWJSxO+wVXTJ5sUfOzWeKZMZx8N/ZlJMD/djvwxHR26D/rKhUUF/06W266Z1YwvXyaplRiK
 vuNDXUh3xq0bBw94H8pE3bTVO4U1Ui2Kp6f7KaonBF9JG5UdLuVWQAlV2mU68uTIVQ==
X-Google-Smtp-Source: AGHT+IFltgIW1pf2A6pUM0b/oA9q9b3pyi2cmLiOj30p5/uqeQ9g6h67rtI/kDn+UE0OnBoMAdnj3g==
X-Received: by 2002:a05:6000:1565:b0:38f:3e39:20a1 with SMTP id
 ffacd0b85a97d-38f58782cb8mr86075f8f.11.1739895980927; 
 Tue, 18 Feb 2025 08:26:20 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258dd5acsm15632990f8f.35.2025.02.18.08.26.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Feb 2025 08:26:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anthony PERARD <anthony@xenproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>, Juergen Gross <jgross@suse.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Thomas Huth <thuth@redhat.com>, Jan Beulich <jbeulich@suse.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH 0/8] xen: Build fixes and dust removal
Date: Tue, 18 Feb 2025 17:26:10 +0100
Message-ID: <20250218162618.46167-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi,

While preparing another pull request I wanted to run my changes
with Xen and failed at testing on a 32-bit ARM host. Apparently
the config isn't used (at least we don't test it at all since
more than 4 years). Therefore I'm directly dropping it.
The rest are #include and Kconfig cleanups.

Regards,

Phil.

Philippe Mathieu-Daudé (8):
  accel/Kconfig: Link XenPVH with GPEX PCIe bridge
  hw/arm: Do not expose the virt machine on Xen-only binary
  hw/arm/xen-pvh: Do not allow specifying any CPU type
  hw/xen/xen-pvh: Reduce included headers
  hw/xen/xen-hvm: Reduce included headers
  hw/xen/xen-bus: Reduce included headers
  hw/xen/xen-legacy-backend: Remove unused 'net/net.h' header
  meson: Remove support for Xen on 32-bit ARM hosts

 docs/about/removed-features.rst     |  5 +++++
 meson.build                         |  3 ---
 include/hw/xen/xen-bus.h            |  3 ++-
 include/hw/xen/xen-hvm-common.h     | 14 +++-----------
 include/hw/xen/xen-legacy-backend.h |  1 -
 include/hw/xen/xen-pvh-common.h     |  8 ++++----
 hw/arm/xen-pvh.c                    |  2 ++
 hw/arm/xen-stubs.c                  |  5 ++---
 hw/i386/xen/xen-hvm.c               |  5 +++++
 hw/i386/xen/xen-pvh.c               |  1 +
 hw/xen/xen-hvm-common.c             |  6 ++++++
 hw/xen/xen-pvh-common.c             |  6 ++----
 accel/Kconfig                       |  1 +
 hw/arm/Kconfig                      |  1 +
 14 files changed, 34 insertions(+), 27 deletions(-)

-- 
2.47.1


