Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34ED8E9A049
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 11:45:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsfz9-0004pD-B5; Wed, 18 Feb 2026 06:44:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfyY-0003xI-Ih
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:44:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfyW-0007wU-5X
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:44:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771415045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1p5ZbFdSM+FDKoKqpM0RbDlLtsFLRzSauSxJ1myhHy4=;
 b=MDbHzOYz+hQCX2kuXf9s42TsiqCENPhntJsc3jQpWaF/ShgLtN41bbVbzxY0TPNNETXaHe
 2o3kzOehzBa2tZMu3jbuCcAqO8JLil4NS2NdKP22l6qaygY217Wht7LRawVOKPBszzbQBu
 uo87xAy6XQ5i2gcNoRjzBu+7O7RE3AY=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-q2So8HxEPlOox_Y0CIelQA-1; Wed, 18 Feb 2026 06:44:04 -0500
X-MC-Unique: q2So8HxEPlOox_Y0CIelQA-1
X-Mimecast-MFC-AGG-ID: q2So8HxEPlOox_Y0CIelQA_1771415043
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2a79164b686so70805925ad.0
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 03:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771415043; x=1772019843; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1p5ZbFdSM+FDKoKqpM0RbDlLtsFLRzSauSxJ1myhHy4=;
 b=Kg9AuDCYhPq+0NoaF89lc/hnePdr7Q1wFifILIEIWnnK2KMLnxoCikd8MkIbXAtKkB
 Q3ktesvqmAGbCu0Tmp3cqCFs2TrYMWNuwKQxZ04PIwa1KdEduHzgc4IrPsIZmFTopIyZ
 GKOA8MHtCyaJGV3HPqphfmyg8idCdVMhJlFK6h4XM5yOKmbUoh7Rp3tsyiPs7ot2CXWn
 Wih5Fh9AofxgAMDWP/31x1FxI6Kptwx4njHZNP1HJsV2Euriuu/kzGqDuFpVq6oJ9hRr
 df5f8Owzao4SEeoj9nIjanyAZcfBtAGXFwWi/mLoQTzCPW4V/llWQ5cmS/RtYNStXrXl
 MYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771415043; x=1772019843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1p5ZbFdSM+FDKoKqpM0RbDlLtsFLRzSauSxJ1myhHy4=;
 b=wuNgdOaZ+5x7Okl0c23MBtYWouN7CsveFyuEuXNWs0ckBmloQRisbNjGXQrVqT4KOI
 fhxy/yKtoM+XncX07GiKjrwg6oItTt+GzaZAbkgheu+UkBUcGqfWeL+Sqp1iGBXQaTYT
 yq1WAHW9YsCwcOV8HrsvZdyXsfGlCVYEBEWXBqksDwENIs7+YOz3dO85pAZah9pMVr/w
 cQFRwoAsPw6LL0HVVsL+CzOWhb7trKmhYRryLBcDGHguV7SYYAgroE3HcOcbSEBWxuNV
 54xeX017eFWJZsBW2WNDgjFfHZPQGG9pW3fAkpGMEvSABMj4u8GoHgrwh9fNkHfqBdBS
 ZXUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlbH1GF5F+Aba5WLTMQ8VLKiA2+3VJs9ebzH/joFnpnTnLAL6Q5z9fBkBVbfM4JFfRfsKguXVmX13j@nongnu.org
X-Gm-Message-State: AOJu0YzcFfgIb6NveMdVJ8M2+tTBZIbhig4F3qi9rvwV1ZF1PfX0YkXX
 mGnSSawcAnH89WTsCCqruE5H3jgUGxMelHwF6qpEBzLP4JknzPzNEWAzJLQAGDsrewnwL9zUtWJ
 /MNureHb4Z+r5TGG4lD5RO2XZYRI+EZu7KgwuW1wAwFMRu9iShwNuRepZ
X-Gm-Gg: AZuq6aI6ICZMbkkw8aRLswqucITs5QaLo9U3/kWVAdIUMZeHa/JTJfFhr2PATkrT8OI
 qQAKuqqNkh7es4RYUR7veGnFA9JmPpbUMWqQolwnJoqhLY7Iy9a7stNVBsGmQgjr4ISyEMx+kHE
 ZsfXCPEVPKP6NfngbO7E6ZFPpSyxlcpaH0xr5MVIieOT7BlW3Q4RpsRldgfjX7aty/bPukwzajZ
 4ucIhnL6XdxBmJp0QWQasVpj91Cyp7U48YcxKTQ0hmfA3G5S0+jBAnBodgX8GqTLbaTUHfKqQhI
 ShULwPKuzjmCR+oXXG7EJsRr99aAuMl0x1fpnVcCH0WTCZEOUJz/f/q4NHBZhwBgQf1aHIonfqB
 bgORtP4Yo0BhyfDcvUfC2eaul/tcU2eGX24udlDot9FG1foGPjQbV
X-Received: by 2002:a17:902:f681:b0:2a0:fb1c:143d with SMTP id
 d9443c01a7336-2ad50e74e46mr13383125ad.1.1771415043428; 
 Wed, 18 Feb 2026 03:44:03 -0800 (PST)
X-Received: by 2002:a17:902:f681:b0:2a0:fb1c:143d with SMTP id
 d9443c01a7336-2ad50e74e46mr13382985ad.1.1771415043043; 
 Wed, 18 Feb 2026 03:44:03 -0800 (PST)
Received: from rhel9-box.lan ([117.99.83.54])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2ad1aaeab38sm127803425ad.82.2026.02.18.03.44.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 03:44:02 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v5 25/34] kvm/hyperv: add synic feature to CPU only if its not
 enabled
Date: Wed, 18 Feb 2026 17:12:18 +0530
Message-ID: <20260218114233.266178-26-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260218114233.266178-1-anisinha@redhat.com>
References: <20260218114233.266178-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

We need to make sure that synic CPU feature is not already enabled. If it is,
trying to enable it again will result in the following assertion:

Unexpected error in object_property_try_add() at ../qom/object.c:1268:
qemu-system-x86_64: attempt to add duplicate property 'synic' to object (type 'host-x86_64-cpu')

So enable synic only if its not enabled already.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/kvm/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 5c8ec77212..ff5dc5b02a 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1761,7 +1761,7 @@ static int hyperv_init_vcpu(X86CPU *cpu)
             return ret;
         }
 
-        if (!cpu->hyperv_synic_kvm_only) {
+        if (!cpu->hyperv_synic_kvm_only && !hyperv_is_synic_enabled()) {
             ret = hyperv_x86_synic_add(cpu);
             if (ret < 0) {
                 error_report("failed to create HyperV SynIC: %s",
-- 
2.42.0


