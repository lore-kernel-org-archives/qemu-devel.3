Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67FECC88E41
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 01:12:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4poD-000713-PP; Thu, 10 Sep 2026 21:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x4oPc-0001gN-N6
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:42:54 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x4oPZ-0007AU-Vs
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:42:36 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49cd6185db7so2003995e9.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 16:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1789083751; x=1789688551; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=prD5E0dEw6BGQrNnryKTNEUWkZGVuVEP4Po4nI7jckI=;
 b=MZ1mGYfxAtOyO5cZ6woHM+pkazak59JZt3CDJRIrm3DfiCfkYX+Ej0RG1LRYmjDBO3
 r6YRzoWrtpu/4pdZ9wyzr+FvHbBaaL9d4UqK2SLFUcgRbdeXc9XD1JWz25OLcpKcuRC4
 /c7YYd5/bGXWdOpyB0Se4VjouSEnIBweby0L7DCbKognDFUUaKDJan1afwV0Ddli7iZg
 L549RdwsnPv5yi0TSFLxqIvN70LIPqXdQ78C+IQHjEBGkBtj6xWTQzTFR48nDuj84o0t
 fbYA4OuOrOv4uzLW9bKoZatOMrk0d+AQAN8TvaJ+MFce2Ea4uds2+N+caUyHrwruF0/r
 JxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789083751; x=1789688551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=prD5E0dEw6BGQrNnryKTNEUWkZGVuVEP4Po4nI7jckI=;
 b=afFd0Z/ZKA0RFeJE8i8w4Q2nDAuKuSE6bsPi0PyUfVtJKY99u4l2h7bLtb2FAy6BZh
 pcNbPqHZVS/sHS3usiO0/UXecr8L354uWiZIECNevA6oGqIA/0v/G36TUHRXtoSGzZCB
 xZO258qFqh3OyHS6FJazBFeisyIXhsXiSp3UA6RFVsdLhxf4n4T3i99Qw/B1z0979XC+
 yLnoQN1b0h3tQVTcVYMUihKwAVL6rmZAGU1YO70Zur/UqEZzS+cS2dB9v+2Ef6dLQlHz
 P+oszct2SoKiFfK5B/TuWQrgScBoimGrmJenKebIK9/F04kbQ9JX73ov6HUVGZycK00W
 B9AA==
X-Gm-Message-State: AFuF++nVi+8hSlBmPyJBwPbWbe/zEfSqm1vJ4uicdYubcomECTMaV40o
 LWsKuAZ9k3q3Olb86OaSfw76rdxlpSkZ98WRMvi7Wr1xbJ2cueSnUkx1GEuPiy/mVfs=
X-Gm-Gg: AYBFou0sbPs/DdVMu12UMqyUww3IkuesHoIMdmcqZQm8oywm0EVqZWGFzWHUclKlf+j
 FlROZ7Zo21f6RIBJFV0wpdGa+qa+ze8cO3dyF6mvMNy0sahrkHU9+4c54UNKFcmSM7HxjSPFg8e
 sWzDcnmJ4p4DSovBEoCqIYXzEqdPNvKDOD1U7xL4tBOYF1HwoukjtjkEpjzjxUDTt2EBBrYO1J/
 DoDku0ecEWWEBUSSIUe3yGi+l1DSjdCC8rBLxNwqwqgC4gRZSW5t0ngYqB+iMntrUmF+Hdczook
 PULZNQI7+/gCtimfbGX2q4qBmUin1PH9Jb5/S0AECjwsjT1LoCDyILcRfcrC7JUJJ1heh6Hxh10
 pszhwjzCrLB/psW6/kbDhS9F63rQi4qiGgkp3uO9oGgRwfBGg6ceqMJhYfPpQTTYsKz2VKbqyuw
 5e0b1youIDef/4UMkClqW3rn/OFacIn7jgsCVoqzfct8ovKvqEvi8n6GNhZC0I+t+uK94E
X-Received: by 2002:a05:600c:3509:b0:49c:f13e:e4d with SMTP id
 5b1f17b1804b1-49e61082a1dmr19729965e9.10.1789083751426; 
 Thu, 10 Sep 2026 16:42:31 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:54f3:cc87:964b:3604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e62231360sm7726775e9.4.2026.09.10.16.42.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 16:42:30 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PULL 06/29] parallels: fix GSList leak on the format extension
 success path
Date: Fri, 11 Sep 2026 01:41:59 +0200
Message-ID: <20260910234222.3039975-7-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910234222.3039975-1-den@openvz.org>
References: <20260910234222.3039975-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=den@openvz.org; helo=mail-wm2-x10.google.com
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

From: Denis V. Lunev <den@openvz.org>

parallels_parse_format_extension() returns directly on the end of
features marker, leaking the list which tracks the loaded bitmaps. The
bitmaps themselves belong to the block driver state, only the list
nodes are lost.

Fixes: baefd977002e ("parallels: support bitmap extension for read-only mode")
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels-ext.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index 89fab36039..21f54e4e3e 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -290,6 +290,7 @@ parallels_parse_format_extension(BlockDriverState *bs, uint8_t *ext_cluster,
 
         switch (fh.magic) {
         case PARALLELS_END_OF_FEATURES_MAGIC:
+            g_slist_free(bitmaps);
             return 0;
 
         case PARALLELS_DIRTY_BITMAP_FEATURE_MAGIC:
-- 
2.53.0


