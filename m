Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87884E8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQv7-0004KT-Jp; Sat, 27 Dec 2025 04:49:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQv6-00048G-0h
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:49:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQv4-0006yn-18
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:49:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766828945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DxnDfLQvdu3TSi/2oTj0ek4cmNNQ1H4hkvCMk+FPjfk=;
 b=RzhCKZA7Pvir+nQPyJnLRJI/QpM0qZC6RIfK5QSxOIIPtc/q4Tziz4FpSx/HWVM4snIcSP
 rKBJb8u8zPC0Z58uxDfYuELq3uEg2EP97e46Rml2qOWlJ9qqh4R1W0vWzKPCcKYZZQODHJ
 1PVoeJQ1RxmrVLQ7fZjZZ6fo0DlIgTg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-Z6gY1cOROuOZjjZiB2FaPg-1; Sat, 27 Dec 2025 04:49:04 -0500
X-MC-Unique: Z6gY1cOROuOZjjZiB2FaPg-1
X-Mimecast-MFC-AGG-ID: Z6gY1cOROuOZjjZiB2FaPg_1766828943
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4325ddc5babso2696575f8f.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766828942; x=1767433742; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DxnDfLQvdu3TSi/2oTj0ek4cmNNQ1H4hkvCMk+FPjfk=;
 b=DmOwr7dVkcdS31O0oI35PFFuFiL9MnR2I+DFgq5RaC4XuW3it5hVohXcjJpK4h+MfP
 G1mTL1w5JMsina8Tvs8p3LnKe9ek6cdFNZViELQgaLeBuH0EOQGmUs99UttjmeuQTQWt
 /hYFDsdGxtuBFTZKjJnoCGaGrBi5to1pEnZ3u2lMtodlz2E3LApMIXqiMlm/OR8Ezifc
 8OmV5I1Z5pcITXzBw7YZfV0zoK31SMgiirTA4dPmEBboHo2bvqTftEByB+7PeI1o+XC0
 bKtlwbpWeh6fesk4maernMhXojZwawa3v7E9P2Clpb/bsrRj8qAUj2pQOG5Z0cgYaFRN
 kYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766828942; x=1767433742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DxnDfLQvdu3TSi/2oTj0ek4cmNNQ1H4hkvCMk+FPjfk=;
 b=q4+9uHFLyfHyoLsWGw1UdrRbOn+CA9On/wLF5wD7u9n4ZpHEdhKhNCJ8S2L2HJ1aJW
 VFbJGJc36aLoK51o79Qvtf3tkCHWq633dDV769ocNHbx3KuvdQYeGj/NGRCLmxua+sNy
 5lzO/X5h4Cf5A7zFO9TOsBoMEQIc/s2yo2diULF9t5XibxxIjAtw7lsKukrlI3kO1yQA
 4onctgCWTQNIzDIFJ7iPo4KFAncuLDAb3wXx5HtZAyY32FdTRrV0r7s/oxP+WFqpPBvz
 xw5oOe2upUxKL+zSDZQTcPVhnFsj0OR+4e7wVGxZ3HoOUmptM4FW5bZ3EWQ0n9B0BETM
 1G1A==
X-Gm-Message-State: AOJu0YxsLVtrwPNh8x/B/FQPyRcdqw8hhdeRS2AG4gflM5gyMfu3+b4o
 3qoCVyh6dSsQBDcvVKZW2ZZ89COypS7wV0AMFXwF3wQ/Q91kS+JPLk5ik8vrv6Zo60YRbZejMCR
 M24K4DvnH7ljSVVOJzC3BQY9nDe7Tm0tSN/n5pju+aiucZHUU0Tto6AP0Y+xRY9Gla3k6aVrziu
 4WbvLEdOennFf0fh80WGcIRzNoKyBzFSmMjnoAvz7g
X-Gm-Gg: AY/fxX6C835IZk+pgsfqHmAf7TkcNe9QTr0CgZYxWgl8OmnNwezNYXdjsJ7AbVC1zV3
 0niToPZxRQixEgko38OQFO1HdHzUhLhwDnCyPPokujyDj7mFSKAYKZSZ2LiovBfX4+bD4V973cL
 a2WrGiVoLXfDpFgxJOv9xOpGT9WY7VNISBlkrDCDFM823M2bkbgdfKLQv0mkhl3K2q0uts3sK6Z
 AyIf50s8hiBXxLwMFkbbV86bOgX/wcjUiNpZq5DOF1hGgExnB/zFlIB75FqL0d532qjld33zW+2
 CDBm7i3LB9LEJtP4oLzmgI+PQ9jI8toqjTPMoApgHhoDGVwA61GgyC9N0C9F0Z6SzCDuUm42UV/
 h/85GQ4kFL5MExY/R7Lm3T5fn7mWjBkhrvu8ZTKRIIJ+qDWPsdyXL4JQAT5ICDtcVX8SqLntrG+
 i29pjJlDmlTFlahfA=
X-Received: by 2002:a05:6000:26d0:b0:430:fd84:3175 with SMTP id
 ffacd0b85a97d-4324e503ec6mr30504327f8f.38.1766828942113; 
 Sat, 27 Dec 2025 01:49:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbnaaZNWBa9BENaOGla9HJ1J0/EyvKnGMH7WYRPVI7pELzCQQv7qM0RNNTIaNGpqjvcoE9CA==
X-Received: by 2002:a05:6000:26d0:b0:430:fd84:3175 with SMTP id
 ffacd0b85a97d-4324e503ec6mr30504308f8f.38.1766828941683; 
 Sat, 27 Dec 2025 01:49:01 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea1b36fsm49869093f8f.5.2025.12.27.01.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:49:00 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
Subject: [PULL 100/153] i386/monitor: Support EGPRs in hmp_print
Date: Sat, 27 Dec 2025 10:47:05 +0100
Message-ID: <20251227094759.35658-26-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

From: Zhao Liu <zhao1.liu@intel.com>

Add EGPRs in monitor_defs[] to allow HMP to access EGPRs.

For example,

(qemu) print $r16

Since monitor_defs[] is used for read-only case, no need to consider
xstate synchronization issues that might be caused by modifying EGPRs
(like what gdbstub did).

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251211070942.3612547-7-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/monitor.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index d2bb873d494..99b32cb7b0f 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -623,6 +623,22 @@ const MonitorDef monitor_defs[] = {
     { "r13", offsetof(CPUX86State, regs[13]) },
     { "r14", offsetof(CPUX86State, regs[14]) },
     { "r15", offsetof(CPUX86State, regs[15]) },
+    { "r16", offsetof(CPUX86State, regs[16]) },
+    { "r17", offsetof(CPUX86State, regs[17]) },
+    { "r18", offsetof(CPUX86State, regs[18]) },
+    { "r19", offsetof(CPUX86State, regs[19]) },
+    { "r20", offsetof(CPUX86State, regs[20]) },
+    { "r21", offsetof(CPUX86State, regs[21]) },
+    { "r22", offsetof(CPUX86State, regs[22]) },
+    { "r23", offsetof(CPUX86State, regs[23]) },
+    { "r24", offsetof(CPUX86State, regs[24]) },
+    { "r25", offsetof(CPUX86State, regs[25]) },
+    { "r26", offsetof(CPUX86State, regs[26]) },
+    { "r27", offsetof(CPUX86State, regs[27]) },
+    { "r28", offsetof(CPUX86State, regs[28]) },
+    { "r29", offsetof(CPUX86State, regs[29]) },
+    { "r30", offsetof(CPUX86State, regs[30]) },
+    { "r31", offsetof(CPUX86State, regs[31]) },
 #endif
     { "eflags", offsetof(CPUX86State, eflags) },
     { "eip", offsetof(CPUX86State, eip) },
-- 
2.52.0


