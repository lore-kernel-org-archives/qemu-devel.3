Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F35FBD25932
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 05:20:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkbRm-0006jj-83; Tue, 27 Jan 2026 00:17:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbRk-0006jE-Vt
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:17:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbRj-0008LB-Jz
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:17:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769491019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X/lBWdDVebfZe5D0jHJAAfOOk/PomlXvxepzVj2YvU4=;
 b=J+YplIdTEVxHd75kkjbiBDaczLQRAeESdItZtB8irFqEN6ETGXEsSUo7oZomP8siaNSg50
 jliv0F+4OTi0zluNikeER7u8ZGvvBPxhZLGP8n6iDxMx4eq+k2XVPJ9qFuiPK9x0rCqNxR
 jwX4oODlXhF52GSg4c9ttNnBNGI/99s=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-mQjmpdKqNoCgCQjv62cUsA-1; Tue, 27 Jan 2026 00:16:56 -0500
X-MC-Unique: mQjmpdKqNoCgCQjv62cUsA-1
X-Mimecast-MFC-AGG-ID: mQjmpdKqNoCgCQjv62cUsA_1769491016
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-34c38781efcso4920705a91.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 21:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769491016; x=1770095816; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X/lBWdDVebfZe5D0jHJAAfOOk/PomlXvxepzVj2YvU4=;
 b=qe4dY5G+CHFBYPPlHooyxeO9kv7pxtNgDZ9Hk+mhWCQ8P3jAxdZc4bgfhE2a1AhFQ+
 GmGiLJkC17Ba3dgYdvG0fwERar8qx8hE41hAdTCUxOsOL3qi1h4ZPLnlbLI++JhBEjSK
 lAXQjOzfFP9nPZgdzhRA21jBF6NDv88xWEkAHqDfVNK+6pF3yj4iWEOZSUQKvPCqqt8n
 n0+x2Sc+JdmxNPwSGM7CsEnKYhATv7479aCAqT/2O9jnbeHiW/KRnkb/hvhFO55zU5Kn
 F36c6sY9Mgl6j85Qd4o1iVHW1x99Tx2UajMYClawsuVtcvWSItJ/wObP2Ne1qUP37Kzr
 5p0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769491016; x=1770095816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X/lBWdDVebfZe5D0jHJAAfOOk/PomlXvxepzVj2YvU4=;
 b=CeOpuRJ1PgabeNhtr9G2zP8iqV+6L//Y3L4xAkOSwLREl9TeaDEEu4zZH+TibOJ/XQ
 /9aF7un4o45rbPvCebbIv5g/QOMId1YI77Qouw9NIAKebp9Q7LtJkYOT0Huxbrxn4UOP
 nD2cjlPYvv00RwK4SDDR2I6ZkMHCwd0MkOJlezukWiBb4oMN/e803e6SpdDt19AjmAW7
 RMJP6OxgmR8bVhGIJfngXSzeGSGCVLAk7Q50W8VTgEqzMpaIpUvuIc5Uj/amemC74Wo/
 CNki43aqjfJybOBdtTVnk1qSMk11/PKwim66lR3S/PX6sjmnBBHe2m6mnPN7Lgdn/TpB
 BYuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVphh4Tvzh54egTWmqFMP6fvUra2uU0037OhfAqJ1bnUibsqSWXAvWM+7tZDUu5Gl3brsUZCX58BfcJ@nongnu.org
X-Gm-Message-State: AOJu0YyC1j/azJ9560Qa1wxQf0b1/VOCSzobNhagid/iZAvJ/pecj0PA
 jxcddgT8cSd4dT+0CSlwSkuX8keicw2dEUd09/B0DL38ITg4V6Bk/hzCy/ULci/xIgR3z5YuU3M
 J88WprEVnYRDVVgqhFAK0oOK41yX9skkJeAdHqfrzlXt/VNHFfa5KI4Jl
X-Gm-Gg: AZuq6aLVAFUEP1PqKv8bW+6Lo26qzEfEY8Bz+PdRnDidYFX6xtiwOUnZgcjpZffzRDk
 tg8cXRZfEJvzQDSb0XjDTnJL2vV+eHVbJNprM7iKIhF26OB/OtoUyd4rVNuqGTfQ+ok707xtF0y
 rcDCYg3QnIcw5IjT6w+0NXG8qhs0cMpeFP3MLHn3NUENmdO04GKGKxrft+ouUoxS4v83atWnzJl
 bnTIc23D0bvkyBlvpsVPwpx1lhRoQX5jrblTMPnM/eSFmqLeDUXWZ2zhih09JTfJvQm2A5z9Iz7
 wXElA30T6QvqqnsV2Re6PE+z5JSxZWOdxFStIzZowvQtqpCmEvBUdrvHVq4f61eUfMNvIbtI/Bq
 O4+FkNMLL/mw1hadNCpOc0nWhHVVnXBwRVsgTxG8u/A==
X-Received: by 2002:a17:90b:3901:b0:32d:f352:f764 with SMTP id
 98e67ed59e1d1-353fecd08edmr647579a91.2.1769491015901; 
 Mon, 26 Jan 2026 21:16:55 -0800 (PST)
X-Received: by 2002:a17:90b:3901:b0:32d:f352:f764 with SMTP id
 98e67ed59e1d1-353fecd08edmr647562a91.2.1769491015535; 
 Mon, 26 Jan 2026 21:16:55 -0800 (PST)
Received: from rhel9-box.lan ([122.163.48.79])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-353f6230d5dsm1110925a91.17.2026.01.26.21.16.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 21:16:55 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v3 06/33] accel/kvm: mark guest state as unprotected after vm
 file descriptor change
Date: Tue, 27 Jan 2026 10:45:34 +0530
Message-ID: <20260127051612.219475-7-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260127051612.219475-1-anisinha@redhat.com>
References: <20260127051612.219475-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

When the KVM VM file descriptor has changed and a new one created, the guest
state is no longer in protected state. Mark it as such.
The guest state becomes protected again when TDX and SEV-ES and SEV-SNP mark
it as such.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 accel/kvm/kvm-all.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 46243cfcf2..834df61c31 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2650,6 +2650,9 @@ static int kvm_reset_vmfd(MachineState *ms)
 
     s->vmfd = ret;
 
+    /* guest state is now unprotected again */
+    kvm_state->guest_state_protected = false;
+
     kvm_setup_dirty_ring(s);
 
     /* rebind memory to new vm fd */
-- 
2.42.0


