Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8005BD49236
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 15:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU4i6-0002dn-4I; Fri, 12 Dec 2025 10:05:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4i0-0002JF-Kp
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:05:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4hv-00064N-BA
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:05:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765551920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W1D9QAx3RYKk+TBo6axZVKqP/pAZIQxzOmmqfA8IeuY=;
 b=ZgBs001qoQ9x6yTw4wEv3j3LE5Rq6cPfOkJhgnYvZL4BtKBIFEPE9Xg13hgXxETkAAhTxA
 cGk7IMjPBC0CuK1kf/wUbI1IGADtV2Vf8FLX4cFle4T0XabJadSKL/XBc5877HsRZwMZUW
 SqMkp5K+L6aQNxdMj1kGMl3DqC45VpE=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-sYbKolKEPW-hhHRXQ4CY3A-1; Fri, 12 Dec 2025 10:05:19 -0500
X-MC-Unique: sYbKolKEPW-hhHRXQ4CY3A-1
X-Mimecast-MFC-AGG-ID: sYbKolKEPW-hhHRXQ4CY3A_1765551917
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-295952a4dd6so13072185ad.1
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 07:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765551917; x=1766156717; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W1D9QAx3RYKk+TBo6axZVKqP/pAZIQxzOmmqfA8IeuY=;
 b=mw+jVJ+/59YZHKLEoE0go91b6fWj8SPPzWrLiHxH5Ft1wrGreKJor/tZ2hwZw02/Fy
 RcyqYcS9RcHZ3cNqo9SlsJe0amLywWhbMqvA+BlITApiJJDHpl4tNZ7xq2CazSGMZrkd
 +jfDfUkfNxa8MtOPFXY1a5QRtZpjC72kDx/lh9B2BICZSiDDBXfAB8r9qhcSirc27Uss
 +02DBF/NjUha3Md99baHt1tjXbQh/G92qVck+CUXAK3J1xCVXjmS/CG68uaheyckAAJ9
 1bwRXcc7SFBLc40olYx/64lGFbuxT2lQIVSyqStlh7tM28akNTG+Hk3wAsWc2psFby35
 FF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765551917; x=1766156717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W1D9QAx3RYKk+TBo6axZVKqP/pAZIQxzOmmqfA8IeuY=;
 b=egSW3hzH31/WflM4qlXcH8BjEBQ02D3gMzTawSJYpw1gy6LGzREKfOSmSwJFN9bXg/
 L3NNMAlUD5C1osMRQcUW9Xd893J7NMps8drGbj7P+Eov7Ls80T7G3FQFF2lK6X+Jd69g
 TWbE9eUdNXxF1ZBBQH21eajmbI6GBflZ6uTpy7v4TMjAnugz0TL1/005br8iETwO5Oqc
 a1ydXN/A4z0zoQdLoNCn0Ec1ZA03thhjfzNggcrTXoXVW+vJ0TVCpUC2dvUHn5801mft
 gJUxL+YUYSaI+DPkp5W1nrF8nWQzk03VjDb8Sms3ifg/60dYgIfhS8vQQLZzRUQJqQnf
 LtTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5K+YkM4VIuCE52bBPrLDS34ekQVx/rlPa4fxz8v+xvQ2L/wyUmwkwZt9Z9nI3l+3aPqJUZ5FAyOSw@nongnu.org
X-Gm-Message-State: AOJu0Yzl6l9EaOX3kUE/+q7XGJtmWjgfuSX/XOgFZdajRgwoKqC2Wzup
 Mix6o/68PiAiGj0BVDG6agoldY3Az0ub7+YcyshGBA1tGkbvuiQt1B+kqTWkVPsjl7OWCElizbZ
 yKnQ7BnnlWSV23CqizIE5k9yR5PGxAV690KZgCJbBCxbc7ommecTEk+saKpghHWeH
X-Gm-Gg: AY/fxX56MJBCSi8EltYsT4Kt53Lri5PbJvPc5mV5MkMqKnVBXv6a+aRT2KDFh2x1UcL
 jJoPGWa4iL8cboiStoksZWF3M/aF7EwSK2WyUqqbGbdAaz3OcR09hiO9xyf/958QAeyliIrSexv
 wKr1qJ3sEUj01XkPl0GCcPMIOdtftZXgEe1fjt0nOeTE3RMYD5KIr5VU0pzNp0YrM1TxlcjKVAI
 b5QfmvBqFDjmmFBYZBAZT6dFGGM8AhuiFdQKTy8Dg5PPkajXQ4G8PZBhVh48OivBw3rC2yWyNiy
 S6HRxj3k11M23elyReW4/95VO4m5/vqTcA+cCoRriXtZQKpaMdmZAEJoKubWS1PX0KjXLxsuJi0
 77E6rjVde6MpBQFMS9sldQcV3fzAv8u/kBRvK1XJ6P/s=
X-Received: by 2002:a17:902:d50f:b0:267:8b4f:df36 with SMTP id
 d9443c01a7336-29eeec1e3edmr62250385ad.29.1765551916622; 
 Fri, 12 Dec 2025 07:05:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErKXvfIsf0XdT2uZ5tfa/p411BIgMfaEjii4Bb7zfmVemQkpUTySz8wUPcvpT+r2XZ3sY+qQ==
X-Received: by 2002:a17:902:d50f:b0:267:8b4f:df36 with SMTP id
 d9443c01a7336-29eeec1e3edmr62248315ad.29.1765551914504; 
 Fri, 12 Dec 2025 07:05:14 -0800 (PST)
Received: from rhel9-box.lan ([122.172.173.62])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-29ee9d38ad1sm57046655ad.29.2025.12.12.07.05.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 07:05:14 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: vkuznets@redhat.com, kraxel@redhat.com, qemu-devel@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH v1 16/28] i386/sev: add notifiers only once
Date: Fri, 12 Dec 2025 20:33:44 +0530
Message-ID: <20251212150359.548787-17-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20251212150359.548787-1-anisinha@redhat.com>
References: <20251212150359.548787-1-anisinha@redhat.com>
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

The vm state change notifier needs to be added only once and not every time
upon sev state initialization. This is important when the SEV guest can be
reset and the initialization needs to happen once per every reset.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/sev.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 9a3f488b24..1212acfaa1 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -1789,6 +1789,7 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
     int ret, fw_error, cmd;
     uint32_t ebx;
     uint32_t host_cbitpos;
+    static bool notifiers_added;
     struct sev_user_data_status status = {};
     SevCommonState *sev_common = SEV_COMMON(cgs);
     SevCommonStateClass *klass = SEV_COMMON_GET_CLASS(cgs);
@@ -1939,8 +1940,11 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
         return -1;
     }
 
-    qemu_add_vm_change_state_handler(sev_vm_state_change, sev_common);
-
+    if (!notifiers_added) {
+        /* add notifiers only once */
+        qemu_add_vm_change_state_handler(sev_vm_state_change, sev_common);
+        notifiers_added = true;
+    }
     cgs->ready = true;
 
     return 0;
-- 
2.42.0


