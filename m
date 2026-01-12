Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6193EC9EC90
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:27:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfHtg-0002pD-Fs; Mon, 12 Jan 2026 08:23:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHtb-0002ia-8Y
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:23:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHtY-0003ht-47
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:23:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768224223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9FW+RNoWUNg/DJr0t6Axhc3qYqFhjtvAQISw7/ozuW0=;
 b=N3VvS9EnBkriVjTMrXf7JCK2MdIoBBGv8RGJPKHieaoGdkXh0Dv6sWTpAkD1Iefq+WMasa
 ymGZ7QkDfCb7z4q1mnrN9Vcmkxwic9hTWNghe/wEKkiOD5hzpHyPQgEo9NRhDHaV7Jrj4d
 AGui59h2hbAPUSbYii+lAgPCEuKQp7Q=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-hpoW3tYiNZKbX97n1PsRmg-1; Mon, 12 Jan 2026 08:23:42 -0500
X-MC-Unique: hpoW3tYiNZKbX97n1PsRmg-1
X-Mimecast-MFC-AGG-ID: hpoW3tYiNZKbX97n1PsRmg_1768224221
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-81e6ec1da28so1867588b3a.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 05:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768224221; x=1768829021; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9FW+RNoWUNg/DJr0t6Axhc3qYqFhjtvAQISw7/ozuW0=;
 b=qzxbBtivVmuzKZsltMnCOtjD4mFAB2MhXkSNx7Uoqv03M0rUjsu9IlbK0vHh6sKN4s
 tAoPYKvns0cDab18pNGvu05X26DT2BJb8JPMqPKl6E51ophulm2sEUCKST+NwasIrw23
 LSXYZdjIdIgKYiM5PVDk5Rf4toeu/2TBXGRsuZOibgWoOGuT+/ArQ3kykl+N105mQiPC
 6AnPq2emavahLNtUwdVv6ArKG6AchCreLzSCNOo6rAN47bFBONli/CsqsASuniQRYlTc
 mXI5BV+j+TZN+J7r6sAHHt7rg+UgV6qyBwszDSCsrF4End+TQN4kM5daKTz3xT9rg3Hf
 sUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768224221; x=1768829021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9FW+RNoWUNg/DJr0t6Axhc3qYqFhjtvAQISw7/ozuW0=;
 b=c6E1/MKHdfrDSw7xDSvraa6m2E8YmG1DhoKJ0/m0LCIM0QS8ntYKLZawh+RdlUiXiG
 N4DzwqyKIHxKHBBjl9AcAHoUCIJQSFBC6/EfdjQsBKTXd3LTPY5PjXZd87M3BrpJVQJ1
 smqA/ixN15XAEF4rxTCgev57djXQrXu3FccZUE8hivD02cve9+8xTn2BMXDIOuyDEb2v
 YEo/AmT0H5RiVs15kwW+QLVCxA/4xxs14xR/UPT16NlBPnoBdWB0UlnUhXWQ9Z3Kwhet
 Mm0bIRB3gUyTqzwUDVFXdNPk9alhz7yOnr1pAvjU1g67djBSXV35xjeDMLpgaRhrCPoC
 fBIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxYW+sF0JZYAisjsHfCHITIbiDGflq4t4/kWONEoJzTBmrNt/vG48/OC4xaSn10u2OE5MmOzwwzYum@nongnu.org
X-Gm-Message-State: AOJu0YzgWr4s24U8f4uliGo8D/vRTyEAzSF+OrY5JdJFxYEMRwiX/06Q
 9wxS6klBsKlbxGJ+mkmFeOt7tKCaKIJnW4OExDegcWy0/K9qqN1Hif7pM6A3+Vqh+9t37ML+fyF
 PkaBKDCtvgX+ZmBr5xZQ9J3EqrAtO3caI4WijoDqWbFw1jTuI9dp+aLTM
X-Gm-Gg: AY/fxX6Y20w66ay4m2yEckOOp7p65hLcuevbASldPbZsnqKaZArWtv/tH4IU2+l7keM
 eR4Cv0hPKmyi/U2Ovcr8qJGbA9rzwBSiwn3CCvBTskWTUpA7dEKjNgNJeuCp+RFhG+U50smRtNJ
 XiZ2vE+aNiOaPxxQAZ2iB9K4FVMO/somB3Z4/aYbZ2gfzc4Dymih1FYhhcKPUVzDQAs9QvhQDmA
 WNOftloIvpzTfloOPwdKxUPFNeGKR9tkvT91JEwh2f17Hu+gw0PwX3xWO8xGUtmBhOVz0+yf3Bw
 3xKueXYocQ/6ogJI7WShowzMuYSdGba8OtSDysNAb67LalYYQPdkvCmymTE6+Z1tzWhIT4oielF
 2aabNA8xraX0ALHjAONdRGrfZxoCkPfPdqD5Emn/lPjo=
X-Received: by 2002:a05:6a21:3381:b0:366:14b0:4b04 with SMTP id
 adf61e73a8af0-3898f97be3emr17859378637.64.1768224221157; 
 Mon, 12 Jan 2026 05:23:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHzg6r/nlFCBwy29+gmS/Y3kVmX1P+W2vycZ7SAs4A65GkTF6SdC04/yGxH3/dD/Nwap7Ysw==
X-Received: by 2002:a05:6a21:3381:b0:366:14b0:4b04 with SMTP id
 adf61e73a8af0-3898f97be3emr17859363637.64.1768224220806; 
 Mon, 12 Jan 2026 05:23:40 -0800 (PST)
Received: from rhel9-box.lan ([110.227.88.119])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd87asm17544771a12.15.2026.01.12.05.23.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 05:23:40 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH v2 05/32] accel/kvm: mark guest state as unprotected after vm
 file descriptor change
Date: Mon, 12 Jan 2026 18:52:18 +0530
Message-ID: <20260112132259.76855-6-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260112132259.76855-1-anisinha@redhat.com>
References: <20260112132259.76855-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
index 762f302551..df49a24466 100644
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


