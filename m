Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24223CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:00:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNHf-00012t-TP; Sat, 30 Aug 2025 11:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryi9-00013e-25
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 09:00:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryi7-0008AQ-6A
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 09:00:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756472406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=noc8iObEd+MZKrTyFBC0mTkl2iu7mUTZ+GAJ8gLX478=;
 b=g8zMK1FFe+knJgoSKS3jnSINvtYEEMqMrJKasV6oeoB99tx92P8Z6imJ4G9EULqp8IdGZG
 vM62uvVZxqH7ydqJifo6r4Rd5VcWezUp/74NRgP900KOg69AlJFDDdSLNwq2lejTqsIzDH
 y4Bll88PA/RzcwghYO+pA0wIkNeVi+M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-jHSSGCDRP3O4EUC4E2HlbA-1; Fri, 29 Aug 2025 09:00:03 -0400
X-MC-Unique: jHSSGCDRP3O4EUC4E2HlbA-1
X-Mimecast-MFC-AGG-ID: jHSSGCDRP3O4EUC4E2HlbA_1756472402
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3b9dc5c2ba0so983424f8f.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 06:00:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756472400; x=1757077200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=noc8iObEd+MZKrTyFBC0mTkl2iu7mUTZ+GAJ8gLX478=;
 b=JdDHvMlmgcS29HIP6Telr+uZJvvadG7oMTsrLMYsKBUfkLjoqxHQCpKTzxukLNw+c8
 LpHTqDRdgYImNqtrdRlIufiU/ZvKIIqEmtcOPnt7KKPhGk4D6m895Dlafsz2pdmXDW6r
 MyJmsgG6qpiB7WvWZJNMp23RzSkPVHDJsmy2Y+W60vtoZn67ullAxmtsGYx/duChjLfi
 L/wFglJKp1HnwzzKsoJFjL3ypmuf8SSAi2UkvIXqb/fDAmWit1B9j0o0nCpXmtB6g78u
 sE3VJZETH4F6GEgtMYecCiyGnBVLY7ZahPkLUuQ0cQdufKV6+Qi9YupyjbP9X+i0YwmT
 1kZA==
X-Gm-Message-State: AOJu0Ywj60vdKw03XFwvMCf7tyEqKqNhNKqHP9M2q42H8j3P/LhqslER
 TnIE11iCeESyWIl50o5yl+Hn7OQeLJUqg6GAODdAiThVf4Jyl1gEt2Snqf+uU9kxojcJgH5z8Z1
 dsxVU+qGLGrexHgr/4nD+z7KIF3GR7XQiB50KTrk2t33r/xjbE0EXsnQlg+IywDu30l9WeM65CL
 j3oXJ29DspssmY7Znb8Q0sYdh16DDyaiPGfXTEAEHa
X-Gm-Gg: ASbGncu5Pb6wc8CoZAaafdmlgd7n8Mg/zVoGHpzaEGPlwwzIiuIil9bIaWW7LMZRZS7
 XP5BnvdZeE9AfK0DSA1Gt64lMkRQpXTaDTWk34/W0uvLzIt1Bq9ABXcTZIVrlNRyXpe2QbR8eRf
 N/2lNB4hCnaEhzNxMi0S2fSe5n/dJ374sNvi7JQ+hqbNmaOgP/xV22rwBRUPaheC9vHwUpf0X1d
 I99iwAHdRGNoaLrLM/bDfK2tmMWxlUQR8/7M4kwn/ce5DcQebbfG3ZxUZQtDUCRty44kCerbz2x
 M0YgC7mN0ngTC+boavkMyYXiOE0ZZ8tiQQ20ERgEJ5DXPVrZ4qnWDGAYyK0qc52avLOnTp37+bj
 hfi1PTexL+OmH/u9riM4cS9xvNQaWLCfpoRCfeqvK3Ko=
X-Received: by 2002:a05:6000:18aa:b0:3cd:7de0:729f with SMTP id
 ffacd0b85a97d-3cd7de074a5mr5454204f8f.4.1756472400651; 
 Fri, 29 Aug 2025 06:00:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0Hn5+Og9blKbVwxOitJAIRTpFJsvQ0/ZpPEwV3a+lVvqexgSnn9w2yQfnmVB8oy91IDmjeQ==
X-Received: by 2002:a05:6000:18aa:b0:3cd:7de0:729f with SMTP id
 ffacd0b85a97d-3cd7de074a5mr5454186f8f.4.1756472400157; 
 Fri, 29 Aug 2025 06:00:00 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d1052db1f0sm1615092f8f.23.2025.08.29.05.59.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 05:59:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 09/28] hw/i386/pc_piix.c: remove SGX initialisation from
 pc_init_isa()
Date: Fri, 29 Aug 2025 14:59:16 +0200
Message-ID: <20250829125935.1526984-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829125935.1526984-1-pbonzini@redhat.com>
References: <20250829125935.1526984-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Mark Cave-Ayland <mark.caveayland@nutanix.com>

The Intel SGX instructions only exist on recent CPUs and so would never be available
on a CPU from the pre-PCI era.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20250828111057.468712-10-mark.caveayland@nutanix.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc_piix.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 57b02da5a82..9a2eee8ab0a 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -541,7 +541,6 @@ static void pc_init_isa(MachineState *machine)
         }
     }
 
-    pc_machine_init_sgx_epc(pcms);
     x86_cpus_init(x86ms, pcmc->default_cpu_version);
 
     if (kvm_enabled()) {
-- 
2.51.0


