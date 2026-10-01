Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD14CA5FCE
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 23:34:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCQHn-0003WC-SY; Thu, 01 Oct 2026 19:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xCQHl-0003VA-Ol
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 19:33:57 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xCQHk-0002DD-56
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 19:33:57 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 d9443c01a7336-2db425c8ff1so5334085ad.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 16:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1790897635; x=1791502435; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ruvoRhnnsi30rjj0KB8ImDUhrr8e0NpGQKtL3X4JwoE=;
 b=HbSIDwCA/uU7iRMLlJEBeRhav19zoppbxwxJUbQRjaxo9KbPb3rBMQGxYi0c/dXFUG
 l2sfqBX6AYBvYv9eIZloCdKLHddBfZ8BWRKaLZMs4nG0kalKR3J4HAAR7avSWH9P/Ccy
 3X1XAvtQc8dVa/jtMwWNOI+LDaBI5P+eBGcIWlZDcbjX6lEYqcuC6ZaHBN3opNk97jx3
 m5tIliVXYGy9GIuVWyk5w/y6Od0hPwbEYjaNPweMJH80CyoQwTfktchrX+AMi6CROYpG
 jdxOtUkZmKiCREwG5nY4d7jtQL31RCaiJ/ceIcnXJ3DQyCS8UpuaJWog87KycyLN8CBW
 55Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790897635; x=1791502435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ruvoRhnnsi30rjj0KB8ImDUhrr8e0NpGQKtL3X4JwoE=;
 b=FUjnEEyZd+5XK7X7YIS9JwHsl6KWObt04eoyoFtJU1ZXi+b2Cg/mQNhm2KeckFMoOy
 o/pZDN9CfnQ0VqEL82esAG2jAH+BhrknPLaziI+pchzv9UGdzE4yROXnUZ37S9aNwnuW
 dN4JjJESFkp9uYZM53EIEhjVyTxAc6GkQifdusuLgXKVsrVVJAIx4iVDCXlxy/IdAv8d
 FIT19Ma0iAZgQJP5gtylGWKRvKRBbjJyFc+xj9ZxgvLOuEnBH0kNSrtAIyVnEB9NGLBk
 VUKwrpA2EMxcSH1Nyk+lIkE3dQKw9KtCoBLYv4bogUF53N8oVPQwenGVp1r+vlt2TjS9
 x0JA==
X-Gm-Message-State: AFq9FYLIgrKT0smQEh1XQ+XFT2EK1HJyTmIT+04TnKliseyYiXKPTDvl
 ilHzOvzV/nqq6M7SIqkJNqTjgl44IfUeQmalIOgN/yU9YVTwtEBVtIX1llL5gjbIJU7RyngqMY4
 sZXLpu3o=
X-Gm-Gg: AYBFou0KKUiDsiD0gxNZ/PG1VTszrn2mpITDAwC2JfI5UywOLNZZuYFDbMxUlcAoK+0
 mM+5dk9OWukaHaO22meOEk/bL8BbVG/OkufnvtfDd+cnA92Cy7V2mT7VdONlbNtSIQKK5rOt86f
 1RvNMy96Xjcg1xxI457A3nX6QApabnacAryJE0LBKmJTgUJNHXAX/dwghw/Hnv1IyJ03iJHkxXQ
 UFVhe2ixuVdWctqOQgRYhee2ADNtdznJvGbBV3F/PDrzrCdhikK37RewmM9IuNKDd5Q1yc+D494
 IvN4ws1BbtoQlvg42FPM7Cd/Mv3E5SPJnvl8OHZePVp4zNUgsFT5iu+lxdwgwY6sW2T7XOiJfBJ
 qtTUUbNWXgmI7/9+Ks74p5ZD2mDQeWQl6YjUB+JcjQUslO0pGp/xFGmNkp0j7jt5bPfdGkkvorQ
 CqQ12xTf2nR3UQU23FbeiWwW9p9LPdqp9ELMK/T3x24vq1cjIDd/dNuRe7lGPki9XB1a9w2eXUF
 E2hwy6mT5lm2LS9PpsPgOtsatQFBTqHgxtildaNG1fteX5/GZ2wAC5CPA==
X-Received: by 2002:a17:902:e802:b0:2e2:dbfe:8623 with SMTP id
 d9443c01a7336-2e49a20e27fmr15178565ad.1.1790897634777; 
 Thu, 01 Oct 2026 16:33:54 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e49f6aea97sm1851855ad.45.2026.10.01.16.33.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 16:33:54 -0700 (PDT)
From: Portia Stephens <portias@oss.tenstorrent.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Joel Stanley <joel@jms.id.au>
Subject: [PATCH v3 4/4] docs/atlantis: Update Atlantis UART documentation
Date: Fri,  2 Oct 2026 09:33:24 +1000
Message-ID: <20261001233324.2636629-5-portias@oss.tenstorrent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001233324.2636629-1-portias@oss.tenstorrent.com>
References: <20261001233324.2636629-1-portias@oss.tenstorrent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=portias@tenstorrent.com; helo=mail-pj2-x11.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add documentation describing how to use the console machine property to
control the console.

Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 docs/system/riscv/tt_atlantis.rst | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/docs/system/riscv/tt_atlantis.rst b/docs/system/riscv/tt_atlantis.rst
index 1f2880d617..0bfa82eb77 100644
--- a/docs/system/riscv/tt_atlantis.rst
+++ b/docs/system/riscv/tt_atlantis.rst
@@ -13,7 +13,21 @@ tt-atlantis QEMU model features
 
 * 8-core Ascalon-X CPU Cluster
 * RISC-V compliant Advanced Interrupt Architecture
-* 16550A compatible UART
+* DW8250 compatible UART x5
+
+Boot options
+----------------
+
+ * ``console`` to change the UART which is on the first serial interface.
+   Most users will be interested in the Ascalon boot console ``UART1`` but
+   Ascalon has 5 UARTs and this may not always be the case. The RCPU console
+   is on ``UART0``.
+
+To change the serial console and use device ``UART3``
+
+.. code-block:: bash
+
+  -M tt-atlantis,console=3
 
 Known limitations
 -----------------
@@ -24,9 +38,6 @@ real platform. Notably:
 * There is no PCI host bridge, so virtio-pci devices cannot be
   attached. Boots that need block storage must use ``-initrd`` with
   an initramfs.
-* The DesignWare UART is modelled with QEMU's ns16550-compatible
-  ``serial_mm`` device; DesignWare-specific registers beyond that
-  set return 0.
 
 Supported software
 ------------------
-- 
2.43.0


