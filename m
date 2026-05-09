Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B59CECD3447
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 05:24:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLa9t-0000hz-Go; Sat, 09 May 2026 01:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wLa9r-0000hX-Us
 for qemu-devel@nongnu.org; Sat, 09 May 2026 01:23:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wLa9q-0007Mg-JO
 for qemu-devel@nongnu.org; Sat, 09 May 2026 01:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778304201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rmcvllseInYN32LRwlJ5uUOWOG56WIpWVcOlOni/BfM=;
 b=eMSpaJbitmwaPM4fZjACOd6ENM4zU2ZGlqoQUuLHsazdiiPYyyz5Si4lB558TVirBdyBVY
 u/rBhiY52pjLx2+XAeD8otn2U0/eg7ML4Lvz5WBEf+66iuvbMf1N7GXCfpFeGHPn54Xcvs
 uWwFyMUCd+Yv9EynIPEQFuq2BDHpCUQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-k_hXZmF7N-O3itZJIESlmg-1; Sat, 09 May 2026 01:23:20 -0400
X-MC-Unique: k_hXZmF7N-O3itZJIESlmg-1
X-Mimecast-MFC-AGG-ID: k_hXZmF7N-O3itZJIESlmg_1778304199
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48e60b55de2so21798215e9.3
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 22:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778304198; x=1778908998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rmcvllseInYN32LRwlJ5uUOWOG56WIpWVcOlOni/BfM=;
 b=C6VXP+Iwdhso8s74xxnq0bo0Rpb8OsQ8a5wqOIMTbvIjp0fhpeR9ZPbStaGhE+aGE1
 /LMC7pHZiw/kTUZhaqhWqXcxzbAFtflCDhyTp4YM0s+o9S+5qTicW9zoQnzP0eKfVnfN
 gl8VmDoOQaoghm5Xqsf1bpPFxKgvgea+jTLn9v19aYEyUm/IPKUGfGfeFZMpKNENfIOe
 /SJgHhFm7exlu9hDCQxWmaWl+dmaX/L2ZWqEl/F3rsag9i8W5h5pQ2G13NpkSia2DiS2
 H7DZscQOVMxuJtjFYssYv6qPeYI7ZkFzOiX1GBTsYzBJAyJfqGxJ1hSguGnFIsIIU5Lj
 KG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778304198; x=1778908998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rmcvllseInYN32LRwlJ5uUOWOG56WIpWVcOlOni/BfM=;
 b=Jk32HkUHyQeCUgG8DljuDIpPz2eNahlbC5uvFZ9uSaHFLdzrpn2eVJqK/Zw1JgIrpf
 HKdQ7tg6wmufZj1Laa39KyWrcLFMvfpqbLFbJElfR4CI5t24vGLEsEV0bw+8AlqyTwQD
 lG1EBcNhcvzr+xU7q7rG7XCSAOXqHgu7ahH1Jpuyf22o7woVEr5ffgjUaQSYJxTS8FmN
 sIFow81HsHGf/SGNOI35pl21dgSFVlLVt6B+CjCYHBmorJFkQYTvmLS1HD45LhYHv7up
 EONZ/L9RY96yweUXMfgqyVlDYiYUK1CKhXCKF4qIZN5R9Vt97h2PDCW/N/V66NyLWaED
 vAJQ==
X-Gm-Message-State: AOJu0YzHxIDtNjTlwazMnKU/KIEQukFGhgewnR/dn59PqNKtS3aW+02/
 Z1A75N5ryG4tRaaut9lfJOw18SC/CxfjSQFjvZN/JsxGVBZKMejaQTopSn2Vo5xtRtPreTxSix5
 S2onveERbOTCEamDpKd9+uU9UFJ5PrFxUY+21K8W136lgTkte+dks6dcVSisrGBdR7734MaNav6
 J/8E3eqUzcNyYtolX1omG6ql0IYMowyFyQHRa/l8+k
X-Gm-Gg: Acq92OGqVYETG24hFqG157rfC5zk7B8hCWFiFKJiDG9fex3KwuGMhg4cQt7MQ0On55y
 7+bGoxQR8pB6wmt9h+HFJ/T5vpHyi4PoIy9K0tG6/8MobiotBm052/yaiAGE40kpQnfLe5lS2Ll
 +keYPck2tjy2wC6kGDNebGFXMtUlrKsjnc9nntLDpIvuryMWMJ8jblZvSm7T1VAaLA/mDdWhsCj
 jBE8mZpwY7Lb6GvPBPvVGOV/072aYU0c1HMJUKmcJMJNi1IpzBZlLDe5Yij/QlR4+E6DM9p6u3B
 7FAK34+caB++1upYPiLRmMNckGT0sW7HzUGX11uOOxOT3sBYPsalof/bAHmNX59el8aEWa4WtK4
 e1vjj9mY4MWicT6NkFLUNCL8YJhsJDHAxfJo82hoxo8LEacL5amWw0xPxoRmSULPUk6o/WNfEzB
 SdI0F/dE5nj25Wy10Ys9A4AfSaNA7/
X-Received: by 2002:a05:600c:8485:b0:489:1f3e:5f6f with SMTP id
 5b1f17b1804b1-48e51f327f0mr248797865e9.12.1778304197856; 
 Fri, 08 May 2026 22:23:17 -0700 (PDT)
X-Received: by 2002:a05:600c:8485:b0:489:1f3e:5f6f with SMTP id
 5b1f17b1804b1-48e51f327f0mr248797475e9.12.1778304197449; 
 Fri, 08 May 2026 22:23:17 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e6fff9c91sm23821715e9.1.2026.05.08.22.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 22:23:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 4/5] scsi: register again after PREEMPT without reservation
Date: Sat,  9 May 2026 07:23:03 +0200
Message-ID: <20260509052304.2159829-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260509052304.2159829-1-pbonzini@redhat.com>
References: <20260509052304.2159829-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

The SCSI specification says PREEMPT without a reservation removes all
registrations with the given key. Try to register again after PREEMPT
since our key will have been removed.

In practice some SCSI targets keep the calling I_T nexus' registration
instead of removing it. Therefore we need to handle both the
spec-compliant and the non-compliant behavior.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20260401171927.396672-4-stefanha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-generic.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index f1c328e6da6..29bc952af5d 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -513,6 +513,16 @@ bool scsi_generic_pr_state_preempt(SCSIDevice *s, Error **errp)
         if (!scsi_generic_pr_preempt(s, key, resv_type, errp)) {
             return false;
         }
+
+        /*
+         * Some SCSI targets, like the Linux LIO target, remove our
+         * registration when preempting without a reservation (resv_type is 0).
+         * Try to register again but ignore the error since a RESERVATION
+         * CONFLICT is expected if our registration remained in place.
+         */
+        if (resv_type == 0) {
+            scsi_generic_pr_register(s, key, NULL);
+        }
     }
     return true;
 }
-- 
2.54.0


