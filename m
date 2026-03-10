Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 214D0EFCD9F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 09:45:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzteO-0007YW-Kt; Tue, 10 Mar 2026 05:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vzteM-0007Xs-Qm
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 05:45:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vzteL-0001HY-0n
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 05:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773135911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7xCt7/ib1f44HpeDHXqi+BBxuN/RBrwTUM11Ei+wkzw=;
 b=ibc8AJSd5wmTtpnx8EUWiP40OtujJHzy6IuQeeW3OC7PTsBN4iQGXcCcqPHH52NwmgyRSk
 ijeJVCrMXqUrUvJde00G4mxKsDnrlg9GWQ5NxlwgerQ6CYdHkodOAuyPsLnRHXuTVKRuI1
 5gHDMJ3mNv4A39nUECGKxLLAyBoFz+Q=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-6QdE7UnFMOaPtCTL0Ep5Tg-1; Tue, 10 Mar 2026 05:45:09 -0400
X-MC-Unique: 6QdE7UnFMOaPtCTL0Ep5Tg-1
X-Mimecast-MFC-AGG-ID: 6QdE7UnFMOaPtCTL0Ep5Tg_1773135909
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-82984468f85so2977953b3a.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 02:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773135909; x=1773740709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7xCt7/ib1f44HpeDHXqi+BBxuN/RBrwTUM11Ei+wkzw=;
 b=QLHlm+vIi2WvGH5hFFo/zVRnbxo9TtxikDytC0ZFbNmkIlmHAY0cn5ycG4AxmVhrqQ
 ItGP1rYMjPl4LvlPNNP+Jgn0NCV9HnsIaO/9XSRA0YGOtBFJZf7t3LiyjHZsLt3kMDkc
 Sm7AHuUyIc1IsBaRFgvDod+U9qPTl44+5pGcD1MuiDAKLG4587XFbptavkq1pB0HYSh7
 hfttXWp6gG38QDC28rLI6maJXbW3mGfxX72NQLpQ7gPfGThvpG49CgdE0IeHLqbiOf/S
 rL7t0LyEPh2onATdg8VuQejVVu4Q4tDqu9XQcw74z4Nb9BzNmQA9M2MIVXVDmUa5Fjfl
 07QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773135909; x=1773740709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7xCt7/ib1f44HpeDHXqi+BBxuN/RBrwTUM11Ei+wkzw=;
 b=d4x1D7/IqZNCNU6HXJQb/SYdmSLbUsYMX2izIFxJIGXCjlQ5JosDHDueX6hxCtoNUl
 rC3aXB4R66JDmMaplZCK/MGWXD6RXTrloWERBu47tMtQUAm8dppio9u/b7FfPStNaYOe
 eeKK63J6+rlgiaYAiyvRywsh5T4ZB52XDnNeAGS3Hp6mUrXk5kRYfds1Ncc+VNkI8fXi
 2/5xT7wB/vTpsyOPGeq5LWUwvP+cwKnXDCtXWlkVKewS+NQ4UPWfzUB6j8WL1AIP3g0o
 WL18Lv8pDj/nMT3EQKpiWVTCV9kS3TiTKrgpKazJUWlfbrGBExb1Qu0FMNJMNHqaD5jL
 pnoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXT2ek3tknQn02Z40ah8dIBXQQGHBDFj/xxGwb+QJ8CisYyX8JDGjfQvJ/MLvF8GqgTneWEXEkJUDT1@nongnu.org
X-Gm-Message-State: AOJu0YxRiFEZ+Y1XYKu3bsql8pg51+CE2PYwraes26FCNLDGt+9cSVeM
 cWyb9W1akSYJpC2Lx6BmMJNLh+294Panxhk1jcbCEVghYyzEyJbdNKuBDPY1kXAq+dfO0oMyh4g
 CsJeemAaU/utoz/GFN87XIvdVn8a6+FdstV+MRG5bsCDHAkpSrqBKSHnZ
X-Gm-Gg: ATEYQzytwJc3ldkQ0Tj7KqcxzdozafrK/IKxvWVvmNv9sKZATorbLYMQIkwHgmn0/2J
 7lEaznMCuoLJ51HxAEO5i4wSM0VxxLzgJGGHhklsjrXHGFhq0Hfu8VHbxGieCQCCxtuzpime+Bo
 zQhnWGWhK1cmVvx15I00nqCAE8RIYYOQx+brjKcevgUjaOp0J2SEd492Hs6cGZJp3OXb7+AFk1Q
 GwopzqYhdJy3AdOh8HIjxQHPfCQY7x5l78OH2aR/Pk/5QJk+XV0jEEFP4er1+8Qhqel6PHTD9/v
 Op4n+CAjisAk4oqCXyBKFaP6GZvS/pmROZ9uru01Z0F0ORyjxtCSGt20ZiMsc09nnlD68NZwRYX
 khuYh4RcqvKaq5YDHDWTOxqMtJLQuLu0vcJb5OTYjCmLqUQSXg23Ws94=
X-Received: by 2002:a05:6a00:928c:b0:81a:b602:daf6 with SMTP id
 d2e1a72fcca58-829a2f83f20mr13463947b3a.48.1773135908718; 
 Tue, 10 Mar 2026 02:45:08 -0700 (PDT)
X-Received: by 2002:a05:6a00:928c:b0:81a:b602:daf6 with SMTP id
 d2e1a72fcca58-829a2f83f20mr13463914b3a.48.1773135908298; 
 Tue, 10 Mar 2026 02:45:08 -0700 (PDT)
Received: from rhel9-box.lan ([122.176.129.56])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-829a4636973sm16566142b3a.3.2026.03.10.02.45.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 02:45:08 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Cc: Ani Sinha <anisinha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH for 11.0 2/2] i386/sev/igvm: do not reset guest policy if IGVM
 does not set it
Date: Tue, 10 Mar 2026 15:14:49 +0530
Message-ID: <20260310094450.35861-3-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260310094450.35861-1-anisinha@redhat.com>
References: <20260310094450.35861-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The guest policy is set either through command-line or through IGVM. If none of
the above applies, default guest policy applies. However, if IGVM does not set
the guest policy, currently the policy gets set to 0 regardless of whether it
was previously set to default value or command line. This change fixes this by
checking if IGVM indeed has set a policy value. If not, do not reset existing
value.

This avoids guest crashes such as the following during reset when the IGVM
has not explicitly set any guest policies:

qemu-system-x86_64: sev_snp_launch_start: SNP_LAUNCH_START ret=-22 fw_error=0 ''
qemu-system-x86_64: sev_common_kvm_init: failed to create encryption context
qemu-system-x86_64: unable to rebuild guest: Operation not permitted(-1)

Reported-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/sev.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 549e624176..cddffe0da8 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -2760,7 +2760,11 @@ static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
                 id_auth->author_key[0] ? 1 : 0;
             finish->id_block_en = 1;
         }
-        sev_snp_guest->kvm_start_conf.policy = policy;
+
+        /* do not reset existing policy if policy was not set in IGVM  */
+        if (policy != 0) {
+            sev_snp_guest->kvm_start_conf.policy = policy;
+        }
     } else {
         SevGuestState *sev_guest = SEV_GUEST(MACHINE(qdev_get_machine())->cgs);
         /* Only the policy flags are supported for SEV and SEV-ES */
@@ -2769,7 +2773,11 @@ static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
                              "but SEV-SNP is not enabled", __func__);
             return -1;
         }
-        sev_guest->policy = policy;
+
+        /* do not reset existing policy if policy was not set in IGVM  */
+        if (policy != 0) {
+            sev_guest->policy = policy;
+        }
     }
     return 0;
 }
-- 
2.42.0


