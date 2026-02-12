Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A4DBEE3691
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:49:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXvG-0005jV-2O; Thu, 12 Feb 2026 09:44:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXum-0005Ku-Dy
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXuB-0005k6-Qz
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770907375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5emFdi1nSDHv0zg/73xkIggYL3JZlaBDKu/OyPg2etI=;
 b=aKSmWj9US5yD/n8CprSZUBA6Q36Z+ojNv79eOz5MZeE7vv5gFbPbRGtF9lXWJeIU2dn8A+
 +V34C/38slCiyyalBTQQydCs+Ps70ncGmHNRk/ebDqrPga5Mc5d+Fo2+oUX09rD2bzcld8
 GNQeB4HcnlamXrFS3ZqNcdVavjSPwEE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-EknjrV1VMZe0cngKj0avsA-1; Thu, 12 Feb 2026 09:42:54 -0500
X-MC-Unique: EknjrV1VMZe0cngKj0avsA-1
X-Mimecast-MFC-AGG-ID: EknjrV1VMZe0cngKj0avsA_1770907372
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4806b12ad3fso78377315e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770907371; x=1771512171; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5emFdi1nSDHv0zg/73xkIggYL3JZlaBDKu/OyPg2etI=;
 b=MpQ0EnBSGhL58TuyMjqDg9fn7YMVk+RqH/lWLp90wGApcIsHdED5S71544SOtxiFDk
 JDo+du9GW3KH/CILjCSAjQab6Ow5PUW77ezGE6hqAvnyoVexIw4WrkbBGheDjDyPSQ6u
 UTc+t5aT8ZIEvMIy3edrelYCPxZYdhAaCbmRfgHu8CTEK0kOCllWLlITLSS1UU1ARlWs
 BHIbgG1W73N6ygwvQti6ZxPXFhVwq7RL52v4IABikMDy4w2CfIZ/mWFwpq9/NL1XskpC
 yXH+QWv2WwgZuHKBjIVnjhh4o2OsCdf4HNvcIegSQEDH9hp7cboL8J9fQwLJ4/JB8v+g
 d8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770907371; x=1771512171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5emFdi1nSDHv0zg/73xkIggYL3JZlaBDKu/OyPg2etI=;
 b=DfpDxS8qGSrmK6WV8SbJI6v5N+d5J9RGNKu/+DCR3Dvii/blzyYnosugo/+gUPKQUK
 AVOVzRVkp/f4HoDm0pkua7Sf04J9gzuXLrNuNafTJOOgR0p4MNjNFIkqkuL1h+HxTl7N
 Ag8fqLMTSXVByFs5jmeasU6FO3HlyA74ehoz4F0BK8jACBLZLqFnTnZOJj9FeJ4Timcm
 tVOoZW1cCIFUTNwYslSdMrHrHs2q+dev6KO8saK7UElmzhNFBH9zUs06f6hWuuP8FaPP
 TkbIDiofGjmbSSRW+mHrxd9ZWCcVyTbfeYHBFYnJ7ndCr5o5Chd011mi6qyYgaDCrAfx
 Rzdw==
X-Gm-Message-State: AOJu0YyUGFmJJZlUEYvC8wACp85CoggwAQoG3plDXtMeaxE+CL/X1UR0
 nrrDWu/02qsm+GHx5tyxJruOkom3a90l/kEGxeK4waeY8HcPNNKM87Go4f+ZpgeFClk6qItrOgm
 H9DpPEzhZ8+TnlVT66FETN9wzDsQx5PC3s1vOlARxhV3coLc3d6LOkrJx5qfU/9GXiGsah4qqL7
 zuhQ+bwByxfNR7SVo54FDuxXDIbJ0M/ZJs6CxLysUo
X-Gm-Gg: AZuq6aJj3mNYbfCsya7Jk2tHvb2yPbPjMHGFBzxdh5CFZSG+O4y2V8Yt9FLiAPuufG1
 bzjC5sx1H5qo2EFf6nGXngLFeeBDUqQac0lHPdMtFt7bNHOFCARPS8kP5bcNz5cj8pT+1+RZEFk
 +gM+vBBFAmaOhgNJudOcf3O2AfZejdlD2QMbjpftgBZwbCyZ7cIZjKGH+M00ZH7QhY4DsK/z/dZ
 1fqQXWdZAfLoW7049POS5MIgypNj8EOSmxOJNDO2Z5F30euEa5mzthNhcIxufV0hj9hxtP3ZS68
 sA+baU25IkNC+5MDAJ5TT56ijWzGMvwV0Pqm6vY7dRlmspJFHXNwjCC5CQoqCqJPZxOjKmmQijo
 Sd99KZAZqYHXF7EhQxmX+3zEn5y81I+PRnQT9DfECzEswqKqL3tdXAp6s2hzyDpem7bRV9IjFNB
 AypZNpNEN6or2LyFoyosm8EGzHORYfgMGKo/uvRTVZGOkYvBQa5p0=
X-Received: by 2002:a05:600c:8411:b0:477:9dc1:b706 with SMTP id
 5b1f17b1804b1-4836570df2fmr36677875e9.19.1770907370970; 
 Thu, 12 Feb 2026 06:42:50 -0800 (PST)
X-Received: by 2002:a05:600c:8411:b0:477:9dc1:b706 with SMTP id
 5b1f17b1804b1-4836570df2fmr36677535e9.19.1770907370406; 
 Thu, 12 Feb 2026 06:42:50 -0800 (PST)
Received: from [10.60.241.123] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835ba1670fsm77334905e9.4.2026.02.12.06.42.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 06:42:49 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 03/41] tests/acpi: Allow DSDT table change for x86 machines
Date: Thu, 12 Feb 2026 15:42:05 +0100
Message-ID: <20260212144244.22579-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212144244.22579-1-pbonzini@redhat.com>
References: <20260212144244.22579-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: Igor Mammedov <imammedo@redhat.com>

Before dropping legacy CPU hotplug code, mark and allow the affected
ACPI tables, to avoid breaking ACPI table testing.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20260108033051.777361-3-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 42 +++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8bf..eed8ded6933 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,43 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/x86/pc/DSDT",
+"tests/data/acpi/x86/pc/DSDT.bridge",
+"tests/data/acpi/x86/pc/DSDT.ipmikcs",
+"tests/data/acpi/x86/pc/DSDT.cphp",
+"tests/data/acpi/x86/pc/DSDT.numamem",
+"tests/data/acpi/x86/pc/DSDT.nohpet",
+"tests/data/acpi/x86/pc/DSDT.memhp",
+"tests/data/acpi/x86/pc/DSDT.dimmpxm",
+"tests/data/acpi/x86/pc/DSDT.acpihmat",
+"tests/data/acpi/x86/pc/DSDT.acpierst",
+"tests/data/acpi/x86/pc/DSDT.roothp",
+"tests/data/acpi/x86/pc/DSDT.hpbridge",
+"tests/data/acpi/x86/pc/DSDT.hpbrroot",
+"tests/data/acpi/x86/q35/DSDT",
+"tests/data/acpi/x86/q35/DSDT.tis.tpm2",
+"tests/data/acpi/x86/q35/DSDT.tis.tpm12",
+"tests/data/acpi/x86/q35/DSDT.bridge",
+"tests/data/acpi/x86/q35/DSDT.noacpihp",
+"tests/data/acpi/x86/q35/DSDT.multi-bridge",
+"tests/data/acpi/x86/q35/DSDT.ipmibt",
+"tests/data/acpi/x86/q35/DSDT.cphp",
+"tests/data/acpi/x86/q35/DSDT.numamem",
+"tests/data/acpi/x86/q35/DSDT.nohpet",
+"tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator",
+"tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x",
+"tests/data/acpi/x86/q35/DSDT.memhp",
+"tests/data/acpi/x86/q35/DSDT.dimmpxm",
+"tests/data/acpi/x86/q35/DSDT.acpihmat",
+"tests/data/acpi/x86/q35/DSDT.mmio64",
+"tests/data/acpi/x86/q35/DSDT.acpierst",
+"tests/data/acpi/x86/q35/DSDT.applesmc",
+"tests/data/acpi/x86/q35/DSDT.pvpanic-isa",
+"tests/data/acpi/x86/q35/DSDT.ivrs",
+"tests/data/acpi/x86/q35/DSDT.type4-count",
+"tests/data/acpi/x86/q35/DSDT.core-count",
+"tests/data/acpi/x86/q35/DSDT.core-count2",
+"tests/data/acpi/x86/q35/DSDT.thread-count",
+"tests/data/acpi/x86/q35/DSDT.thread-count2",
+"tests/data/acpi/x86/q35/DSDT.viot",
+"tests/data/acpi/x86/q35/DSDT.cxl",
+"tests/data/acpi/x86/q35/DSDT.ipmismbus",
+"tests/data/acpi/x86/q35/DSDT.xapic",
-- 
2.52.0


