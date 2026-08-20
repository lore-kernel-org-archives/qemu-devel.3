Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFCE9C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:51:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5zF-00063f-Uh; Thu, 20 Aug 2026 12:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5zA-0005kT-M5
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:51:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5z8-0005fQ-KD
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:51:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sxn/uzqSPQpS6n/ktNic7zpaVmCAciSa5XkWjGHf4kU=;
 b=Sh8c0sn0Ttzo8rHAjrI91+7iTmPp1TUhqP7a3DUELEB8X50NvbpWqjD2MlPl0cmaRC4gzB
 hvXeTNrKOj//McHjxg/LMZd+2YKdZQBooykhuPDd7hjVWjP8ov/7kGZ5h40VKlBqVD0ugL
 +KcVQibFeMNNtKFvbAND6J+L7UAWgtk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-NAPIXRceNCOpNOmFQSMxeQ-1; Thu, 20 Aug 2026 12:51:10 -0400
X-MC-Unique: NAPIXRceNCOpNOmFQSMxeQ-1
X-Mimecast-MFC-AGG-ID: NAPIXRceNCOpNOmFQSMxeQ_1787244669
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-496b61bd846so173705e9.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244669; x=1787849469; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sxn/uzqSPQpS6n/ktNic7zpaVmCAciSa5XkWjGHf4kU=;
 b=nSMgeGkn4tEeGIHckdPJlZY4ZgMhIC1117/pbTzXBTqYi0TKKua4eVBGs4pFjS6beL
 zMHHq/DuWjhxx4mUn4Rsva1neFlm4l0MlusNLw30yJIX6BKSVDl/J/HzJPRDmrO8Apfn
 rE13P8IXkFqI6xIOucWeVfqwv2MjJXoc9Cv6thbV52l92hPZygDAc0K1g14hxvopOVvh
 pmfA8d6OJmbSKZ6lhnoYMpqYonCvnQp04ZvBd52pydJFjdnGHMK0dKl7opPo6tjlDBej
 3gaheUHxGViuCAIxj6TZEio/kAo7IVlHGtnVeqgXGyGQXuUC4kdkgogfcSsCF1IcJ549
 vaAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244669; x=1787849469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sxn/uzqSPQpS6n/ktNic7zpaVmCAciSa5XkWjGHf4kU=;
 b=VqIqJvu81Wkk4YHjR/P+xqYLBa+XuFCD95eadsHfZqROrv15HiQisMSoefQV+zWsD/
 WGYH2a5i7oxpcF8r1SMPgZBOIEWtKUlzaOZCuTK+38ozBpXqrJVWpakf2s2zmkoLkY5x
 +rhyra/qW46+LQPMEGhgrKjX5pryoXHOmfi8ZllEIT2wA0LnGK1ITE42Wq34UfKkd8dm
 BMV0Mh9dAuFSPpG/LVFQnMc5jwzNCwCJkQaACO1qlpjjfVWMhWASkwJt3IVqjTw/C938
 F8MtK9B2N6nbbKrmbwOlB34wS6Uqs4vwl1TtHH7o/jCoAypppaIOcpBZ547UL+SQyuT0
 pdTA==
X-Gm-Message-State: AOJu0Yyn5DpDvUZb/K0zKytrcUj5goDCZqg8EeBN3TQZmjV79I4IfjKm
 HucBmDhmc+rMf+ykDD07Y3TlikWJo8BuHLyNga4jW+6Zn/c//ZA7MdSzqDMeojaQKrLOkj3bATO
 z3mI7yuk2OhpfAV6h/11Ro51sVchA5ArkusfBJaZ1AqzD1u1vy9LTLQgAheNRhyl6yIEDIutwO9
 nKYglfsOwA8rGIyWfa/Tpc2T48Yrfh19gD9IyWSxnG
X-Gm-Gg: AR+sD11xtbx8E8C6fo2gcpEQjRm0yLtcPLknv086evoDj8j4VuoLMcpYu3m0v7ARrk3
 dtpRCneqMNyN+z7ms0Ilj58+s6yoA+XQENR9Z8ZOzUUdERa9AgKslznH6SxEg+FrHoxHzVNWdp6
 zdKiJMe+Lkk5Dojvu4rwsSwWX4dlqcgGDPwrkMBPLA202qbelQ6LJvySYUiqMKzlX7/Z3WKtTvG
 TKvQQQp90RBdrPO7QhqSN3oSaFialywBSUGNPM2pupaC2G1IRo+d3nTkZMYBvkUg93EGpBlho2a
 fMdq8tiw4iz1AKzCPP0k6khrDMIHUVEGChCQf51n+ooR7Ida+Nee9Tw6nimjP+c96Z0Vyrawc9N
 BnF7zX9L1YbWVpiu6sK1XwsjZejBnzYs/wRysKQ6jXeuTZMPpd9uYy5vsqgDnsPgoJTpJlU8fo3
 Lme7U=
X-Received: by 2002:a05:600c:3588:b0:496:c18c:f9a3 with SMTP id
 5b1f17b1804b1-499b83184eamr3693995e9.5.1787244668480; 
 Thu, 20 Aug 2026 09:51:08 -0700 (PDT)
X-Received: by 2002:a05:600c:3588:b0:496:c18c:f9a3 with SMTP id
 5b1f17b1804b1-499b83184eamr3691835e9.5.1787244667458; 
 Thu, 20 Aug 2026 09:51:07 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b20a14c6sm59749525e9.0.2026.08.20.09.51.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:51:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Naveen N Rao (AMD)" <naveen@kernel.org>,
 Nikunj A Dadhania <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PULL 23/53] target/i386: SEV: Validate that SEV-ES is enabled when
 VMSA features are used
Date: Thu, 20 Aug 2026 18:49:26 +0200
Message-ID: <20260820164957.1895963-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164957.1895963-1-pbonzini@redhat.com>
References: <20260820164957.1895963-1-pbonzini@redhat.com>
MIME-Version: 1.0
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

From: "Naveen N Rao (AMD)" <naveen@kernel.org>

SEV features in the VMSA are only meaningful for SEV-ES and SEV-SNP
guests, as they control aspects of the encrypted guest state that are
not relevant for basic SEV guests.

Add a check in check_sev_features() to ensure that SEV-ES or SEV-SNP is
enabled when any SEV features are specified.

Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
Link: https://lore.kernel.org/r/11e34ae3db91643e45e097404d1aa949a820aa0d.1779281646.git.naveen@kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index d8fb88d2b21..52379855b3e 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -523,6 +523,12 @@ static int check_sev_features(SevCommonState *sev_common, uint64_t sev_features,
             __func__);
         return -1;
     }
+    if (sev_features && !sev_es_enabled()) {
+        error_setg(errp,
+                   "%s: SEV features require either SEV-ES or SEV-SNP to be enabled",
+                   __func__);
+        return -1;
+    }
     if (sev_features & ~sev_common->supported_sev_features) {
         error_setg(errp,
                    "%s: VMSA contains unsupported sev_features: %lX, "
-- 
2.55.0


