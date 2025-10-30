Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052D0CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 17:01:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEVzw-0002MQ-Bj; Thu, 30 Oct 2025 12:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vEVzq-0002Le-Ux
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 12:59:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vEVzg-0005HI-CV
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 12:59:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761843555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hWmmkEUNuPGh9RNwegX9zD/J9TxS8gEM8JXHywhlakk=;
 b=aTTr0Z8EOWkcVgfeIvyXVyc0L1u/Fs+lXeoi8uIGrHwL/XpNCOzWvCXFPPGgGZywjavk6v
 EUwa5qrz4jCbq8CkSQfwK0l7fxwwryPAUiFwI3bEERDskzc3Wp3TGukeY6RzKvXIApmbRy
 Re0Q2c+1InH9mgRdJ3UmS/uwU1B8Luc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-fwTgCnxVNqWdbCr5oUbFCQ-1; Thu, 30 Oct 2025 12:59:13 -0400
X-MC-Unique: fwTgCnxVNqWdbCr5oUbFCQ-1
X-Mimecast-MFC-AGG-ID: fwTgCnxVNqWdbCr5oUbFCQ_1761843552
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-471001b980eso8319635e9.1
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 09:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761843552; x=1762448352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hWmmkEUNuPGh9RNwegX9zD/J9TxS8gEM8JXHywhlakk=;
 b=NRQwGMkKta7mXmzAylF6Uzr76a6CtnvRQGplYqzDDWExgJOETyqKFllo8l30OA+xic
 zwfb4+LbArD/f0jikSQTi4aVvlxCemZBUBPIhLrYUF65sfp+DFiBMhJFM3VL2D1i0opB
 JpCS07iPM8b407iA9OByt1XIL0jPTxuB9FzM2TV/MYOny2Pxeq0/sOAbpfvb+FHi8cyy
 zw8CVLMUD8t7HTa/dvlSfVmuikzbHLuy93SYzbNDBcxruRG960oocUwWzwK3CAliCtZw
 zNQ20KDMU5oiUA8yWvr1DJ8Ty+YnGrKlFN8yA/gcNCtVQdXt7DSRIyZ3fMNWf2KQ5pCD
 Qy1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSunt6nEM/TEa8JDHO6hFf9KZz6+EPU1bc9gfgi2QHEz1tFJvBOJ7IDWBxfQ9ENnIL0kIwFznOTWSD@nongnu.org
X-Gm-Message-State: AOJu0YwISrAKrbS6znmnxVAuxJMZl0+7hw39uZq412KE3DAr/FzDjGxy
 PAvA5s0tr63/Nq2h/kuHazkjOwlOmqqhJdr2WST233jjGAHmWGyq8PehE3EMoBpwlhOO2r8QEIq
 kTDQANsLKvJXnUC8CUZ/XX760SqTtYAkvHR0luXcVSeD9Md5ySS8H5BMz
X-Gm-Gg: ASbGncvfDYMwmcFOKwr3K3Y8GsOiUcfZ33BCnRzPubgyWO1gTn67M/vWiL91CZFMiSR
 7x+ubhhhm8Sp/YoJ8IfRYBAx6Oqm1l2AoXCOJQNY9qj4TjFWbkQtjnph0JO18Tz/CZMYuMFAdJG
 Kuj5ND3B6Wo/aUVrN4ywaBzJ6/RnHDWf0D/mZ4U4lInDSU/dwVetIsj6aPhEMHFRrhFZaKG/zwU
 rLC5dVoH+tY8Jr4Vs+ILG2KzJJkUFuWlrJPg0JUjOp4zA47iN38ELKsOZR/vtV8hAqvElafwdEM
 SDt6D8LAojV6Jh971pzO0dUd+K8TlzkreW1qej2Xrwx990HWn3MgTsazprVaxbrpP0WOXXzYY+V
 a3/Hx2PMzOQ/HtXTWsws9HuXxQJOUB3R/FFGFJu2BueBNtFVAzXc38ZOzEKyeWvo=
X-Received: by 2002:a05:600c:34d0:b0:471:114e:5894 with SMTP id
 5b1f17b1804b1-477308721b1mr4431725e9.25.1761843552026; 
 Thu, 30 Oct 2025 09:59:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdysDVvnycX2QFcyER9PBsXwHxfA4shM0ptgu5S+ePqTnpY3IFDLDiXiVx7sJ1KtjfLnplcg==
X-Received: by 2002:a05:600c:34d0:b0:471:114e:5894 with SMTP id
 5b1f17b1804b1-477308721b1mr4431485e9.25.1761843551618; 
 Thu, 30 Oct 2025 09:59:11 -0700 (PDT)
Received: from rh.redhat.com
 (p200300f6af131a0027bd20bfc18c447d.dip0.t-ipconnect.de.
 [2003:f6:af13:1a00:27bd:20bf:c18c:447d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477289e7cf5sm51104085e9.14.2025.10.30.09.59.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 09:59:11 -0700 (PDT)
From: Sebastian Ott <sebott@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev, Sebastian Ott <sebott@redhat.com>
Subject: [PATCH v2 1/2] target/arm/kvm: add constants for new PSCI versions
Date: Thu, 30 Oct 2025 17:59:04 +0100
Message-ID: <20251030165905.73295-2-sebott@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251030165905.73295-1-sebott@redhat.com>
References: <20251030165905.73295-1-sebott@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add constants for PSCI version 1_2 and 1_3.

Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 target/arm/kvm-consts.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/kvm-consts.h b/target/arm/kvm-consts.h
index 54ae5da7ce..9fba3e886d 100644
--- a/target/arm/kvm-consts.h
+++ b/target/arm/kvm-consts.h
@@ -97,6 +97,8 @@ MISMATCH_CHECK(QEMU_PSCI_1_0_FN_PSCI_FEATURES, PSCI_1_0_FN_PSCI_FEATURES);
 #define QEMU_PSCI_VERSION_0_2                     0x00002
 #define QEMU_PSCI_VERSION_1_0                     0x10000
 #define QEMU_PSCI_VERSION_1_1                     0x10001
+#define QEMU_PSCI_VERSION_1_2                     0x10002
+#define QEMU_PSCI_VERSION_1_3                     0x10003
 
 MISMATCH_CHECK(QEMU_PSCI_0_2_RET_TOS_MIGRATION_NOT_REQUIRED, PSCI_0_2_TOS_MP);
 /* We don't bother to check every possible version value */
-- 
2.42.0


