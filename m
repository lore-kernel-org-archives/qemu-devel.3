Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8CA2CA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 11:57:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGEep-0003vO-Pf; Mon, 12 Oct 2026 07:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGEe5-0003WD-LK
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 07:56:46 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGEe4-0002OD-4z
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 07:56:45 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a168355946so15143355e9.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791806202; x=1792411002; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HSrF1Uf2SYNIft95MB9XFCC5nKQU5xHB3kHJUqzeVuY=;
 b=qaX5/pSAYzZl/IiI91eg9BrSrG+sr1xhmp9Cj29hXlFWA5SqI7uy46is/bQ5/pwGG/
 wzLHBlM0SEQ0b/RamrgHxrI41OxYuwl2OIEARyhP0evXVADX2ME7mKtovy/ROZm1DUxC
 IzYxoXdGF3PcjdYGr1YSH2a5M2hncSTAXldzfbxxUm7C+YRhZtrtG6bny0cc347327uz
 I+ixdziOmCumsG6oVf+eB9e8OVpj+GY4Fr2veFX99+yclO9MNm0I5E87zLbR76iMHdSi
 3z8II4PFdVD8g0us3JwQUVIKeXhAVRF5dawDHcNonfhcbPApbkk1vWl148JSlYEyeN5U
 PqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791806202; x=1792411002;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HSrF1Uf2SYNIft95MB9XFCC5nKQU5xHB3kHJUqzeVuY=;
 b=h64Es7G3daUykzi+E2D5hUEcG7wpVO8pozsCppnLBWY8MetoLOKwsy49wtbOFIsmZ0
 EYC6r1Qc8bzxOYW5Q85/ATSGqNimIKjoSQEHxNVS2NekZixZHKUoj3tMv1gy7lSQ5jel
 TzYp56o3lGyBd5S+XmHrm+hRTnALyplNNFEmSWCteNNc7oYR1lNYa7GpvB/944/qWgqo
 mi064kZsCH6u8Fj/ExWJcM6zl13brMdEass/Q8eFiQ+k6IjmeKaTgtrERcFtsg13/X82
 fzXFhRAj68mqsb+TdLMiG05HDXvlGKs77S25GmEfGFmqHBHD0o8HhyM7MGzO8J0RqJgy
 m70w==
X-Gm-Message-State: AFq9FYJuJCoUxchJTtTRZoAefSNeI1IwrojCzeKlfIW0GTUAcGq1t3WK
 W2oxXfgQIIY6PTR5Ka7jIc0TVir5Tyki0BgxRLPx9DYs0Trfd6NN5t3R
X-Gm-Gg: AYBFou19FfG0qmsZYpmGOC7sJY0xnUo6+1l5sUgoyWHNCuAeMPKapLPatrWyaBVpKdS
 BWdC1vIPvO/m9XZ7N17A7CWmmGITtZbTCLieOGhWshWCTSzYIP8+YePSoyepDpFc6+LSHt+4nCW
 32+nqowf1kZFauz4hUKhQEHyunCW921WIasasoc/SzCgLpmVTOoPU76zW0Jba2yfGrHEXn8W9hw
 NK7QPdFupREoRIm9dYq1PLkh8W9X80sqzSDzGYQ4vS8GpxZ27lfiPWrlNATatT1H9Zjw/pJQ1gI
 ne8CASyQuR4msvjfGEfsLNbCzlYvkcFigJQ1lw70k0q+v+B0e1tR7feb5e4LrYiVwU0GU/hzcV6
 eVgNL2KYzS64rRi3p3ILxepdhx/ejfdd8v1iK9LP+35S9vXDbUZ6gPCq6QA3zw1OQ6hSPz2H6g+
 F9lG4/jn9xO/KsKQ7IKJhdHjMNDNDttgmnUgFdbyyYz3e6RIvzOyvY8WKjEj2z/KeSLnJHWeWwZ
 7DvLgO3qDkbhiVyK+3vtaDJHTY=
X-Received: by 2002:a05:600c:609b:b0:4a1:83f0:7c91 with SMTP id
 5b1f17b1804b1-4a18e4ca1dcmr163055785e9.18.1791806202342; 
 Mon, 12 Oct 2026 04:56:42 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18dd15659sm188345675e9.4.2026.10.12.04.56.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 04:56:41 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Mon, 12 Oct 2026 13:55:59 +0200
Subject: [PATCH v9 08/12] ui/console-vc: forward text console size to vc
 chardev
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-console-resize-v9-8-8db78320ba81@gmail.com>
References: <20261012-console-resize-v9-0-8db78320ba81@gmail.com>
In-Reply-To: <20261012-console-resize-v9-0-8db78320ba81@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791806189; l=1675;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=+THDUz5FDYTrq+3UbYN01djura7EAPA8bWNZTUjGcf0=;
 b=us4+DqO1NNXUbKSPQHTl92pacZeB6fsZuQFZ04KX6b7IlzI/O3JMiCkL4DeRS2sDjl8pgtdIT
 JYKSyHezrplC4+3vt/dgXGVwZlTK73t+Q/WTzuk2VPTbBUJpt1XpLwQ
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Update the vc chardev size when initializing the console and after
changing the surface image.

NOTE: There seems to be a bug in the code where the dpy_text_resize
      callback is not called when the size changes due to changing the
      surface image. (Though it doesn't cause any problem in practice
      because the callback is only used by ui/ncurses for fixed
      consoles, whose size never changes.)

Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 ui/console-vc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 53d9e9d39b..99cc8f09c8 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -115,12 +115,19 @@ static int vc_chr_write(Chardev *chr, const uint8_t *buf, int len)
     return vt100_input(&s->vt, buf, len);
 }
 
+static void text_console_chr_resize(QemuTextConsole *s)
+{
+    qemu_chr_resize(s->chr, s->vt.width, s->vt.height);
+}
+
 static void text_console_invalidate(void *opaque)
 {
     QemuTextConsole *s = QEMU_TEXT_CONSOLE(opaque);
 
     if (!QEMU_IS_FIXED_TEXT_CONSOLE(s)) {
         vt100_set_image(&s->vt, QEMU_CONSOLE(s)->surface->image);
+        text_console_chr_resize(s);
+        /* XXX Shouldn't qemu_text_console_update_size() also be called here? */
     }
     vt100_refresh(&s->vt);
 }
@@ -254,6 +261,7 @@ static bool vc_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
         s->vt.t_attrib = TEXT_ATTRIBUTES_DEFAULT;
     }
 
+    text_console_chr_resize(s);
     qemu_chr_be_event(chr, CHR_EVENT_OPENED);
     qemu_console_notify(QEMU_CONSOLE_ADDED, QEMU_CONSOLE(s));
     return true;

-- 
2.56.0


