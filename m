Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C18C5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 08:41:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxKms-0004u8-5c; Fri, 21 Aug 2026 04:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wxKmq-0004t8-NE
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 04:39:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wxKmo-0008IS-8v
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 04:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787301577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7hjxLnAVY/DURtZa77LbXggflUPsLfOq7SYe7f/Hv64=;
 b=DmwRuC9DmpYIeldXp87p7GDfKXngPjT88qbrBJBCIVmPILvnNgGqW9OGmW8flFbyktFe/w
 XjyUFx9McehdZ/r86PvuKyrW+A7nymhVjsACv3vR39+1OxzbxvxkDw6bk/u38+kzwp9d2t
 gQeozBL2HFxUCPnaAFhARoclNR3inMw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-pu3xNUsjO_-n4hL6_v-nWA-1; Fri, 21 Aug 2026 04:39:30 -0400
X-MC-Unique: pu3xNUsjO_-n4hL6_v-nWA-1
X-Mimecast-MFC-AGG-ID: pu3xNUsjO_-n4hL6_v-nWA_1787301570
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-c15f4732dfaso67074266b.3
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 01:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787301569; x=1787906369; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7hjxLnAVY/DURtZa77LbXggflUPsLfOq7SYe7f/Hv64=;
 b=Hw5y34/dx68ooDnJhjfhCvoROGqhWPZ9s7Fosl+vNfz403q9O7OF+vZilQmibktHxo
 MEoFZFIPWm67Gy8jrVRAjsnSlHNyrIVoVjKXyI9BmMcOW6nwkkDuQeC3JoZFXKmXF2oD
 X8ZFN6/GW9HW6UoEY7Z0rk0ilcW5KJN4bsD+VP2mLao08wyEus6BtkFbF2T3MHL72qMd
 oxOz6B5wqIuLuw/eT7/GON+CdwESvahd6gH1rKvBXtRSTjsjOSHvJzuc8sgNabfWtc6o
 opFmFGPvglHr7x82dylHLUTRqWRMdXFuRqXG0PsrT54GkBX54xLegZdLiO+9A6zQxsSb
 XPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787301569; x=1787906369;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7hjxLnAVY/DURtZa77LbXggflUPsLfOq7SYe7f/Hv64=;
 b=av+f/spXJalp2j58kl5cr+V5VhOD+QNWt1D6ruc16WOscIRuTgMJuGxav8IC02V73A
 an3c59luLScrclkwWBvko/iLj5c2KUhj+jLhB9jtimuwRzxTtN5XS0FmM0UO7X+H1dxH
 YEF452kzJGCfcxnnKNPES6BFdTp7Sg7xeiQXbg31WebJhiFReB0N8HNKzgEdoFo3sSeE
 hk7i4gM/1EB36p9NuvKG4HSydRAkso37Hm+TbQBoJHpa2L5AVjNxnsnaQQxs0LSRB6SL
 ifpGZ0cxi9k4QKRHEhfAmmTk5JKCITsInrvptDk9LHyn6rYZmicXWFLC+920tIsw/amk
 +kuA==
X-Gm-Message-State: AFuF++lJIHGqupQevcSurqLhfBv1vBQrgTHsppH9QgWC6N2JI7T72ui9
 RjTNmfpGYWa+x1YNNu/uQfeFsWGZO4j/e4njcf06vsyVCok41u+Dko79wbmiBuZwfad0ZsjXyRU
 WIYJhm2CYG81t/rOVZTjv8zPLMy+ACtZocfuS3gj+F+hWOFVkbQ0InFHVlz2V0SgcwQvAHiqDtH
 Mjz1qTmqNtjdJl3Q7pv7Wg1OwCnwpk3cWxstre5kJm
X-Gm-Gg: AR+sD11y5PYkqrA2QqTQRK4poF1H/V8cazCliBaG9HvcLzul2ZSnx5MgX2LA9kTtXLL
 odHUwK50ycWhTfQE5yugcQjYrxywaUXjM7L/T2EdQQFMAe2jeQQMXMWY1fnfCBs7x6L6Vt3bsRA
 gAKyRZyxt9pa2Ens1sz9+QTW60j3XcwOqg17VorZEBoWDwY9rMX/cNIIp7fLJ11XLwtPVz2EPgC
 DKdwwSqx3kMFpD/8cHA9yTrNMbeByu9SIlEeaFdOhK7ukvJipMT5C7k3aBB9ZUNFIjqMyqHgueG
 MEiO57GH23EKzZlyujgD2H9Ms5tqyrS0JwTu7GVlWTcHTv/4uZZM+4dXpCv5CZIS8KuUiQwOFAD
 WZErpLjojT428C9P3793ttIGxv0TBbExS42WbiSq211bPBppDbtDatQMhrTRSAYCubgv/u2hR1c
 CqRqI=
X-Received: by 2002:a17:907:7256:b0:c21:49df:1650 with SMTP id
 a640c23a62f3a-c246a5eededmr424106466b.8.1787301569405; 
 Fri, 21 Aug 2026 01:39:29 -0700 (PDT)
X-Received: by 2002:a17:907:7256:b0:c21:49df:1650 with SMTP id
 a640c23a62f3a-c246a5eededmr424102666b.8.1787301568941; 
 Fri, 21 Aug 2026 01:39:28 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2459198d64sm330336766b.36.2026.08.21.01.39.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:39:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 1/9] scripts: print build.rs diff
Date: Fri, 21 Aug 2026 10:39:16 +0200
Message-ID: <20260821083925.2008135-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821083925.2008135-1-pbonzini@redhat.com>
References: <20260821083925.2008135-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/get-wraps-from-cargo-registry.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/get-wraps-from-cargo-registry.py b/scripts/get-wraps-from-cargo-registry.py
index 3820d121183..84c652127f9 100755
--- a/scripts/get-wraps-from-cargo-registry.py
+++ b/scripts/get-wraps-from-cargo-registry.py
@@ -59,8 +59,10 @@ def compare_build_rs(self, orig_dir: str, registry_namever: str) -> None:
             if os.path.isfile(new_build_rs):
                 msg = f"build.rs added in {registry_namever}"
 
-        elif os.path.isfile(orig_build_rs) and not filecmp.cmp(orig_build_rs, new_build_rs):
+        elif os.path.isfile(orig_build_rs) and not filecmp.cmp(orig_build_rs, new_build_rs, shallow=False):
             msg = f"build.rs changed from {orig_dir} to {registry_namever}"
+            # diff exits non-zero when the files differ, which is expected here
+            subprocess.run(["diff", "-u", orig_build_rs, new_build_rs])
 
         if msg:
             print(f"⚠️  Warning: {msg}")
-- 
2.55.0


