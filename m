Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6404EC3600C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 18:49:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twmp4-0001XP-Ep; Mon, 24 Mar 2025 14:46:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twmp1-0001Vi-V8
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 14:46:52 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twmoz-0008Sa-0V
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 14:46:51 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43d0359b1fcso30352465e9.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 11:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742842006; x=1743446806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s7H2XHk6YCrzpCT2rz8iyqMZS6d6X/wrnwDCxj4nPhU=;
 b=O+l0N3cae/2IL4RvZTOUa7NkAVi3gBFHzQ7/3UY1tp2I53g4GFOilqeNIGEDAGSVvP
 MeHnnNi1T+2xC6y6ZxTVsnt4UfaRNtXL880wG5SPDG9YXtrVN078mCl8ohoNXDfeh03+
 en1gvLeifUBlZD8jT88c5GrMgAg/sd6abwLEqBQaWlQY1ilO2pLqjqQ15vTkgYJzHcUJ
 ng10xf/DCZyfXZvio2LUphuQl47aud3Ty5wUK9pkx8PXSMFON9lbycHKWDLx6veECxyF
 ynrBpetvGJtioQpquA9iYayPTsP7m6fbmayAdPQFAwom58X3CqCRPiLNMAugnWP2OOjx
 BwqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742842006; x=1743446806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s7H2XHk6YCrzpCT2rz8iyqMZS6d6X/wrnwDCxj4nPhU=;
 b=I51Uce2jqpHyqJCutKtOMaoH+dfcRKNMD8EbckpbV2qCJgemc6oie9TJIlDCtPKSyv
 OVh5MHqw7OAqXy5Y6/0bkDnhvtDv2DhBbTaO4vkiX5WCUP8P5niamwBVp2QVQ7cqBW+/
 43tpfVTvV7+KwjBAGZNNAokJzckHotQ4hCXBGZNHklbXIqtecovlOX/DTQRR8b0aaMnu
 w/dc1M1/wBSV6dTvydPkE3QJ+g78lM5Sdb55sW+C0VdcfWit56VnaQ7OGb2D4jxxaXPm
 DPxWT1p6+IOCxgFGNKfsQ6NP89TALr/moaVcocavlrQEjxHyo1MMMBVW4Qr6Hmn/1O7p
 cFhQ==
X-Gm-Message-State: AOJu0YxWF6Nn0H2lEskfm2HfPITGj7mLYfuoIl5HmvNOwL6ttMW7QBsH
 ddhc/xnDIVS97Vb0XYXDBUaCw3dhNVYFksTku76BHVR//F+4eCc1txLr+a7VBiA1x9XMTT/IDG2
 H
X-Gm-Gg: ASbGncuyxNFjI5RZijJilJZEmHwSd1Q6psK1BD168gSQHiQXMPf37VSYHAN2nauAVae
 WQ8nyNsMR2oLkcnjnmxiT54QY8Iy8HE+uMVMDCs96gR5JabTDSKjXkEcBWMKG1ouNtKkTPRHxdJ
 0mEVMekThPTzBBZJao2fCcOB6u34KvVINsr3VxBFkH0g4mPUUdqfP2vU1i/2wdklJBrWft4RNqO
 vvSjwhFecBGP3V/8wx6VZCtjoM7dkj/x72JI4svUHec9SRLicPT4Q9BJ5STWLNiTR8uHNB+x8nP
 VDd5biWPEMheVxXMyNOyTpmb3w9yrMseA6ed9CYSUxrJp0iNVl4HEg0IA3R3UnH36YVMsPwCcdm
 wlq09VQp3MftMjTRN/0NI1lw6
X-Google-Smtp-Source: AGHT+IEg60/OZle+C70hTonPY2nA007ovpgbs59oWz0xEO6CaVk+5tssDzGG1Gj8aaXTgxJp5134RA==
X-Received: by 2002:a05:600c:3552:b0:43c:f509:2bbf with SMTP id
 5b1f17b1804b1-43d491bfe15mr216286005e9.15.1742842006399; 
 Mon, 24 Mar 2025 11:46:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed786sm177702985e9.38.2025.03.24.11.46.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Mar 2025 11:46:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v2 6/7] target/s390x: Register CPUClass:list_cpus
Date: Mon, 24 Mar 2025 19:46:10 +0100
Message-ID: <20250324184611.44031-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250324184611.44031-1-philmd@linaro.org>
References: <20250324184611.44031-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Register s390_cpu_list() as CPUClass:list_cpus callback
and remove the cpu_list definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 8449bfee5a9..2876f2c4eb3 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -385,6 +385,7 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
                                        &scc->parent_phases);
 
     cc->class_by_name = s390_cpu_class_by_name;
+    cc->list_cpus = s390_cpu_list;
     cc->mmu_index = s390x_cpu_mmu_index;
     cc->dump_state = s390_cpu_dump_state;
     cc->query_cpu_fast = s390_query_cpu_fast;
-- 
2.47.1


