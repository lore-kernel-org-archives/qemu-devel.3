Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54BCDFF8864
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 08:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIixZ-0007bM-AN; Fri, 01 May 2026 04:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <makovick@gmail.com>)
 id 1wIixV-0007bA-Ro
 for qemu-devel@nongnu.org; Fri, 01 May 2026 04:10:49 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <makovick@gmail.com>)
 id 1wIixT-0002n2-DC
 for qemu-devel@nongnu.org; Fri, 01 May 2026 04:10:49 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488b0046078so14209145e9.1
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 01:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777623044; x=1778227844; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OJUhC55K9A0xZ0ORpMZG0kGY/2Fw7VzTRIPuHLeV+Xw=;
 b=KKaXmBhbqleAC13a0ZE9iRB9F0t/KxD+ZzlIquRyHwSqmzmycTL/keHaSeLEd8bwcu
 h9AnCXPeslYR8rcdN04TkNgvvKe5KH0o5h9m5S8TxPvzx4xl7PCH1d42V9ONwttA2p8H
 7ydfQKitUNnm8+R6gVufvVQRJh6W8lF176gVXLna+/b0coyKfz6oHtB5tucCetzszm/j
 i2WKEp0RkL8LGYB6NG+dmZv6aJ6eBOw9NFJWZ4egOYwMnZ8ZypVqP1niaXR/7srGlK+L
 hnGdfMFd5iPaLsJmBrqIHw2LAtqlQwlE83vD7v92tkN5S67AYvrzyWtMSSZ+F0WbUdzj
 sWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777623044; x=1778227844;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OJUhC55K9A0xZ0ORpMZG0kGY/2Fw7VzTRIPuHLeV+Xw=;
 b=e1Zfg77HN0YCrA3GM5nSUTk+Tmp+u3vqL+368+wiedREhWZ6C08uJJmodSv8RG9bCa
 JEMkNy2dFX9o6Tgp8bLGGIJKFqsQ1BmW2rCk1YNuHGksi08z8Q7Aea4oFhi4vyhpzYPV
 KDujnpZGyJfUYRApv3g4Y1uLMHxctU69iWxXgKwo1Lphuyy8ku6fGFEjQVccupEC071R
 xIesVAJj/Glhy+aj3LVXrJeRt3ASRL1pK888O1r2SXMbX5cTBVvORL6oqSlUNmywr+fM
 WF7SbDzIe0CW8J+QRhTjL8v2Lyl0Y+UBmuN/nhOHcs0l2TGHesAltUPa1a7P+4H6i0SL
 YGAA==
X-Gm-Message-State: AOJu0Yw/klQrsOmrI0dpxuladrscWe+eFF0xAKMN4ZrgG00kcCtYpax3
 RtyRehke3aJuwIWNbJ1UNlXPc+3VPmroO+St7OdQyiNslRQIWVzV49iPwy2pTdT2
X-Gm-Gg: AeBDietGt7Mn/jJPp+WBf5fbOuqkZioqGmGEAm6WW/urxS8n4jxqH5En0n83kE7GCLW
 Lu2kY8D5hqjWnm6Od7cbV08sVwQ2cWHKkdZ3Zmo8h/T3KU6xxMSmukeGbicI4QaAomhCUSbDH45
 /cbx2w6nVlm572Y0Ga83X6EWn4MIrqO5DmuZp4KTS9BNePbwZ31hHpcL0aGITgqVz9fS9KOBcBn
 gAvtw7KDAtHpTBwF4M18O6VeNbz1rFVE9cyeYvXqZAmfpaDVRm8n34DGQV0qUuZGvOWB+t4GGrp
 TdOldzqQSBDCxLapGn9NWJxTcCQds0tfV4iVZ4fFLbp9jYQlu8gmth7osnWZL7iJEDGqqGwWU5A
 z9BRvhICp96w2T4dtqzY/81XsWIozFurXG4T28IEh/vvVcTYYhUTX3PZm1PqJGlbCrzYEeAcAOT
 RshyoJvN/KrBDCuWR6JHWnjQvB62KKW3L3Oy0e96A=
X-Received: by 2002:a05:600c:859a:b0:489:1ba8:5be9 with SMTP id
 5b1f17b1804b1-48a8ebaed76mr20781565e9.29.1777623043669; 
 Fri, 01 May 2026 01:10:43 -0700 (PDT)
Received: from [192.168.0.10] ([2a03:ab00:1000:1b60:331a:b316:78f6:effc])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8fe92b3asm9151955e9.4.2026.05.01.01.10.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 01:10:43 -0700 (PDT)
From: =?utf-8?q?Jind=C5=99ich_Makovi=C4=8Dka?= <makovick@gmail.com>
Date: Fri, 01 May 2026 10:10:38 +0200
Subject: [PATCH] ui/gtk: Fix GTK assertion failure introduced with
 clipboard fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-clipboard-assert-fix-v1-1-e549243e4583@gmail.com>
X-B4-Tracking: v=1; b=H4sIAP1f9GkC/x2MSQqAMAwAvyI5G6gFq/gV8dAl1YCotCJC6d8NH
 mdgpkCmxJRhagokejjzeQh0bQN+s8dKyEEYtNJG9apDv/PlTpsC2iztjZFf9F67OJpBk7Mg6ZV
 I9L+dl1o/5KY382YAAAA=
X-Change-ID: 20260501-clipboard-assert-fix-cc2bf8672eba
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Jindrich Makovicka <makovick@gmail.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=makovick@gmail.com; helo=mail-wm1-x32c.google.com
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

gtk_clipboard_request_targets actually returns n_targets == -1
when targets ==  NULL instead of zero. This result in failed assertion
within GTK:

qemu: Gtk: gtk_targets_include_text:
assertion 'targets != NULL || n_targets == 0' failed

Extend the check to require non-null targets and positive n_targets.

Signed-off-by: Jindrich Makovicka <makovick@gmail.com>
---
Hi,

with my latest gtk-clipboard changes, I introduced the following GTK
assertion failures due to unexpected n_targets value returned to
callback from gtk_clipboard_request_targets

qemu: Gtk: gtk_targets_include_text:
assertion 'targets != NULL || n_targets == 0' failed

from

gboolean 
gtk_targets_include_text (GdkAtom *targets,
                          gint     n_targets)
{
  gint i;
  gboolean result = FALSE;

  g_return_val_if_fail (targets != NULL || n_targets == 0, FALSE);

  /* Keep in sync with gtk_target_list_add_text_targets()
   */
 
  init_atoms ();
 
  for (i = 0; i < n_targets; i++)
...

GTK actually returns -1 instead of zero when there are no targets,
triggering the assert. The following patch extends the check to
non-null targets and positive n_targets to be on the safe side.
---
 ui/gtk-clipboard.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/gtk-clipboard.c b/ui/gtk-clipboard.c
index 463ed4e905..ea9444be70 100644
--- a/ui/gtk-clipboard.c
+++ b/ui/gtk-clipboard.c
@@ -175,7 +175,7 @@ static void gd_clipboard_owner_change_targets_received_callback(
 {
     QemuClipboardInfo *info = (QemuClipboardInfo *)data;
 
-    if (n_targets) {
+    if (targets && n_targets > 0) {
         if (gtk_targets_include_text(targets, n_targets)) {
             info->types[QEMU_CLIPBOARD_TYPE_TEXT].available = true;
         }

---
base-commit: 3d626609ccae61a2e552bccd59c7a0931bab8261
change-id: 20260501-clipboard-assert-fix-cc2bf8672eba

Best regards,
-- 
Jindrich Makovicka


