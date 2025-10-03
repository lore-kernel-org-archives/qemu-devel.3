Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F30BCAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 03:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4WTE-00078O-2D; Thu, 02 Oct 2025 23:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WTB-000763-54
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:28:33 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WSx-0001EI-Tg
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:28:29 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-279e2554b6fso11736015ad.2
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 20:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759462094; x=1760066894; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4L1dP65ExrGrK+gLH5THctXyJB5NdQkz+xLUjnvqoQk=;
 b=YwLaStVIaT4ljW60XsYDo4UDTgxFpnZiwUoIKN6T9FVsBeBbiOjCQbHsERslvikmbi
 m1MTj/A8zuolvyftLaUibV4ttpNJR9y6f+2t3GaXOTmzgReu9+i1uemInwqb/9QOVB/Z
 J0cl06poW2g9TXc2lpOuiAp8/5s4uOEMmDagyVEjP5ZRDKM8exZMN+pe5PPtfbT0ScqI
 9+0lqmzaecOx7mdOct98qMUZm/Shb+p1g3Oj51jkzD7mO7sGLFt+pt53OE3D+AlLN5s5
 7DeO58T+rigxeMbrx0qlrTJV938D5790njROvkdnk1VxQkfgkWMau5FYNLznxE3oi6SO
 Hcaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759462094; x=1760066894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4L1dP65ExrGrK+gLH5THctXyJB5NdQkz+xLUjnvqoQk=;
 b=rR937MgJtYF0Ehi/mBSLM5UzAKFtV61p3/4981m0i3pPff4gBMGs8JyvxB3bXwlTF+
 2rgPENTqEIyl2kexuwhUGwHrAjsHHyZSHkAWSJNoOyvJNOndYYPLe1hgPCDMjiCW7rj4
 sw28uSdGo7o+EQK8ZKtJLFJmrrrYcDaT5puNgmJBXBrxY6QIKMq6eB53Dd2EfW2OuLl8
 gIIk7VUH1Anz8aMf+jrtpZZrvCbkJw5GshljbrpHGhEO84kz2AKJpzfgSSfSmmsYn/+1
 C1sXtWJKMVBdMXVQQAGOc7pWXO5UEkMRNCwCP/+tsw739firPIiVGaXM3JAXBBB3GjE9
 TDdA==
X-Gm-Message-State: AOJu0YwwbxGEmvV0isObkMyVUQ9IbtRzodmTUJ/lHfbSXOnQfuZwIRTx
 Mk8lDO06LrIqf1xHtos/ztEoY78Hy8dEUOHUPfd0LGms6RXWf0+7gtjuHxuePw==
X-Gm-Gg: ASbGnctrjuAwsV4aQMaxs+JpVMAgmlQHIyPEpAjDk7B5oziYYzHQTpb8RTHqDktnlJQ
 6s+RI7lWvPXwjvBFaKeAR07LjKbbhodMwFnaOuCKMIWsoqOFUISxJ23I+i9S0D838b4dowa6ryV
 I8kkF31oaLcuifHp+9UChlkhY70iKVpSVUrjPZMJkK2nZYfMcpwtuVO8mMKB/i6/KBI3LSaIqOq
 oYUMeAIavdKNwOXf+bDN+sCcgfp+SASsraH/hbYVMA0V5u+cGi5K5mQJ511pY/DyObPoBcdQpKG
 5mTejWZ5zAB1LIcZIDvloRlzdvBxhd2pdik/8aaPEZnR2OID7wnKQGrzsFoCtVXHamf58HVejlc
 a9GYPGt/tKwluCbcEOz+ggT3+PVXj0ZyhHCE1U6z/zQDr0ZcJr/4i62CJmKBTwYuQOC23zoYShk
 bBRhenIJiQPb1MevkNRjuHJ4sgb7JBtr3ZPMLWP5Gdqa96Q6RNdIbk
X-Google-Smtp-Source: AGHT+IGs9Ad7yrlRx0B5/kvHnDHE9Vr2d8KRPPqWeLZErAwUcV4HEVRMDkvCq6fofGjtOjkNP/FHcg==
X-Received: by 2002:a17:902:d54d:b0:261:e1c0:1c44 with SMTP id
 d9443c01a7336-28e9a61f1d4mr17293695ad.40.1759462094163; 
 Thu, 02 Oct 2025 20:28:14 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b62ce55205csm844202a12.18.2025.10.02.20.28.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 20:28:13 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, TANG Tiancheng <lyndra@linux.alibaba.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, Peter Xu <peterx@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 11/26] migration: Add support for a variable-length array of
 UINT32 pointers
Date: Fri,  3 Oct 2025 13:27:03 +1000
Message-ID: <20251003032718.1324734-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003032718.1324734-1-alistair.francis@wdc.com>
References: <20251003032718.1324734-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

From: TANG Tiancheng <lyndra@linux.alibaba.com>

Add support for defining a vmstate field which is a variable-length array
of pointers, and use this to define a VMSTATE_TIMER_PTR_VARRAY() which allows
a variable-length array of QEMUTimer* to be used by devices.

Message-id: 20250909-timers-v1-0-7ee18a9d8f4b@linux.alibaba.com
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250911-timers-v3-2-60508f640050@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/migration/vmstate.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 1ff7bd9ac4..1cfddf31b5 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -522,6 +522,16 @@ extern const VMStateInfo vmstate_info_qlist;
     .offset     = vmstate_offset_array(_s, _f, _type*, _n),          \
 }
 
+#define VMSTATE_VARRAY_OF_POINTER_UINT32(_field, _state, _field_num, _version, _info, _type) { \
+    .name       = (stringify(_field)),                                    \
+    .version_id = (_version),                                             \
+    .num_offset = vmstate_offset_value(_state, _field_num, uint32_t),     \
+    .info       = &(_info),                                               \
+    .size       = sizeof(_type),                                          \
+    .flags      = VMS_VARRAY_UINT32 | VMS_ARRAY_OF_POINTER | VMS_POINTER, \
+    .offset     = vmstate_offset_pointer(_state, _field, _type),          \
+}
+
 #define VMSTATE_STRUCT_SUB_ARRAY(_field, _state, _start, _num, _version, _vmsd, _type) { \
     .name       = (stringify(_field)),                                     \
     .version_id = (_version),                                              \
-- 
2.51.0


