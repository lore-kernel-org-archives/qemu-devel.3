Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1BC510FCAC9
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 20:29:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w82BR-0004Kn-RO; Wed, 01 Apr 2026 16:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w82BM-0004Ik-Tm
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 16:28:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w82BJ-00037r-J9
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 16:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775075332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eRbvL+0t6sjZnldiXjIF1mD8feBd0aVCt4GXp2N7Shk=;
 b=GUC+Cy/9EtJrG9EmWG3s6PPHRpajmtgeiJmT7abHsiMmK/r4IxF0vrRwD4b7yE7eaggS1T
 nYMVcA3idKihxA1I9dngQaYuBlrAhb2+R5VUfouHotlgBChAESK8UWpuPGDVa5ZAzYZuYJ
 YCQLsEgHo/jlAeNmMS5ulPz6NofrXBc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-hNl_X9wDPvyqrP42-nHMbA-1; Wed, 01 Apr 2026 16:28:51 -0400
X-MC-Unique: hNl_X9wDPvyqrP42-nHMbA-1
X-Mimecast-MFC-AGG-ID: hNl_X9wDPvyqrP42-nHMbA_1775075331
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8cd767c51efso23209185a.2
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 13:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775075330; x=1775680130; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eRbvL+0t6sjZnldiXjIF1mD8feBd0aVCt4GXp2N7Shk=;
 b=BfR5clHOxv3cdlaifnv3Iv2o0L3iOb8jtBBa3tg/bQ+Mj16YdJylASIwF2qdAYIdWp
 s1eIGKfwqmAHHHD/Evo67No+GIOFBxs8Xh/4l9z9Q4Gl85dIByq/kuPYUfx8F8qKcxmh
 mmonToF63PYYBMG+C2PlbtVdd3VaN6lShX7+qP7ESx7CUczu7yVvvAU3Bs7X6X+5AcpB
 BrVsb9OO2oYAAVfEGF68kFYQ+0hK/otgexDctVSRZcDu8IJCZ6KF9s1E3+3wRCYompyJ
 0fdEYJhEN+Ry2kBoXGHLP6WM7hcZbRhdCqFJWotxvGdQIFtlI0DUSqU2CVXciDaaL4wa
 O6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775075330; x=1775680130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eRbvL+0t6sjZnldiXjIF1mD8feBd0aVCt4GXp2N7Shk=;
 b=CmtRwxx5ESEoJdR/Rg93K96fOKQ7d0lr0XEb2ArBwX6tNFL8eFA8BeTanMBKIUA7iF
 +32uuMRGRNpVST0uyeBG5YkYX55dF+WUUERagimHmNfn+ztAwx6su6FZWCjfF+bBiUS6
 Bu1aWuoHp3RWKLenuTSyimdeI6CBVv1xCSyTNyqnAu0Fb0eegsbQgPLRYHRzwsvxDwSN
 4BeLf+wqIRd4XO2+6Rv1rnUj9Oi2p5IANZQg+J/CMJfHVCiu4cnCQleug42fWZsSs9wh
 1RJifyoTvbFbwUZipctYfZ58511IhfhQBsGlTfe82JIHJ+EpippkiPepy64JEInhIO+/
 5yCQ==
X-Gm-Message-State: AOJu0YyYLL/JWMU4rk28G8c8sDTtC8AI4vnbIu8I/N5k357b0ozqhmAu
 IY/N2zz/nd8rZ8zRlzwbcWWlQTHsIHYNCekwyAiXSCk7YQPy/ZdNGX/MqLmUPxARIzwHhL+lrhX
 5Q83VMIrYEXmk1WNTFIdqgaeuoF2nO2RYZ7+fCDgkkugISti/NYyvovun3NiXkQuhZ+Kyjga5zF
 e7zo5hXgs1DkiO2itrJhUOVmIkVJ4aCaWHYKJzUA==
X-Gm-Gg: ATEYQzz+OtqNc0JlKiPeAl5oDi9czOmJZtNZYn5tfgAExz8yss5clQlf6vlUXWrZRg4
 TBHOMqpb/yGJGkSxOmd66wA6eLWfrNa6aKZ19npqr7QWAI16InLM03LgSOJchnT2RWOH2Yz99/E
 IOX8mCfBOJQ9uBWGlyUoxZP/2BLZDyNyIOoeTHJSaDXeZ5duG8bzZLMzSxTIHetgp2iZkQLwESY
 oNvfyALzwBPSLIWdgUvdx5z4cnw0l12PjBQItfKBNExpCr4M46KLCRtmeL26wOw1Qi8XjyOKM2h
 e2o3bv+Qun5oSha9rrCGXQjc1Y/2xHwnQxRiSfuR9QY7FRNPLrB3Z0ppBqSU4K9WYCivIqCmsEc
 tevoRkUpMC6aPxsNgZ+ixPEdoS+7vnTdUZkNK57e2A4c=
X-Received: by 2002:a05:620a:711a:b0:8cf:d2a0:d8b6 with SMTP id
 af79cd13be357-8d1b5a9fe41mr744037985a.10.1775075330282; 
 Wed, 01 Apr 2026 13:28:50 -0700 (PDT)
X-Received: by 2002:a05:620a:711a:b0:8cf:d2a0:d8b6 with SMTP id
 af79cd13be357-8d1b5a9fe41mr744030285a.10.1775075329556; 
 Wed, 01 Apr 2026 13:28:49 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d2a548a4efsm68194085a.8.2026.04.01.13.28.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 13:28:47 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 02/11] vmstate: Pass in struct itself for
 VMSTATE_VARRAY_OF_POINTER_UINT32
Date: Wed,  1 Apr 2026 16:28:35 -0400
Message-ID: <20260401202844.673494-3-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260401202844.673494-1-peterx@redhat.com>
References: <20260401202844.673494-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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

Passing in a pointer almost never helps.  Convert it to pass in struct for
further refactoring on VMS_ARRAY_OF_POINTER.

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/hw/intc/riscv_aclint.h | 6 +++---
 include/migration/vmstate.h    | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/hw/intc/riscv_aclint.h b/include/hw/intc/riscv_aclint.h
index 5310615cbf..0e0b98acb0 100644
--- a/include/hw/intc/riscv_aclint.h
+++ b/include/hw/intc/riscv_aclint.h
@@ -80,8 +80,8 @@ enum {
     RISCV_ACLINT_SWI_SIZE              = 0x4000
 };
 
-#define VMSTATE_TIMER_PTR_VARRAY(_f, _s, _f_n)                        \
-VMSTATE_VARRAY_OF_POINTER_UINT32(_f, _s, _f_n, 0, vmstate_info_timer, \
-                                                        QEMUTimer *)
+#define VMSTATE_TIMER_PTR_VARRAY(_f, _s, _f_n)                          \
+    VMSTATE_VARRAY_OF_POINTER_UINT32(_f, _s, _f_n, 0, vmstate_info_timer, \
+                                     QEMUTimer)
 
 #endif
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index d4880e75c2..32bb8e8ebc 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -567,9 +567,9 @@ extern const VMStateInfo vmstate_info_qlist;
     .version_id = (_version),                                             \
     .num_offset = vmstate_offset_value(_state, _field_num, uint32_t),     \
     .info       = &(_info),                                               \
-    .size       = sizeof(_type),                                          \
+    .size       = sizeof(_type *),                                          \
     .flags      = VMS_VARRAY_UINT32 | VMS_ARRAY_OF_POINTER | VMS_POINTER, \
-    .offset     = vmstate_offset_pointer(_state, _field, _type),          \
+    .offset     = vmstate_offset_pointer(_state, _field, _type *),          \
 }
 
 #define VMSTATE_STRUCT_SUB_ARRAY(_field, _state, _start, _num, _version, _vmsd, _type) { \
-- 
2.50.1


