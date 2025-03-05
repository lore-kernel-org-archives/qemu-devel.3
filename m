Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D99C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 07:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpjX8-0004Z5-Ci; Wed, 05 Mar 2025 02:51:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tpjX6-0004Yt-14
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 02:51:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tpjX4-0007Gc-8g
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 02:51:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741161069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uJQO/sqhJmJh/dpa1Nv55qy+Z1WFxKUSDUXkgLMB7RI=;
 b=NT4puPyF9cObA5+xVqTFf1Pw8bl7ZGzaKb988ZazVEtom38ZRCnNTttL9AM+RgSxRT57jC
 FszjdSMwiG3s6suB0gda85lnpkeqOJDbB0z0dyeLQDx/b1Tapba8wtxTPut9mE7SQOI1c6
 /kRtesmNtvTeFefciTYlrFB3ifu1Xeg=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-1VyNPR4tO1inGaYdVcKBGQ-1; Wed, 05 Mar 2025 02:50:57 -0500
X-MC-Unique: 1VyNPR4tO1inGaYdVcKBGQ-1
X-Mimecast-MFC-AGG-ID: 1VyNPR4tO1inGaYdVcKBGQ_1741161056
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-223551ee0a3so153331385ad.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 23:50:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741161056; x=1741765856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uJQO/sqhJmJh/dpa1Nv55qy+Z1WFxKUSDUXkgLMB7RI=;
 b=uCL/6tuMHBNOro1fKIDxPbSY7j1YBa/WM6kYsWQKKd12s/L4LxEewVTHeQMQem6sVw
 EXKdiSJdbyrNIi8QS8AwSQRhZBVrUlogRZX1B36JvNA1if7Zw5DrkMqh4zFq+uo7X4/E
 ThVJLNl8jU8hJrxQBlUe/8dIKB5cx/QgJA7F7yDtkikx45Muh4QC4PG3XOuEo8ixbuTO
 W6iy0WeVu1w2WHHWsnHwlKN3H7OReMAj0gU0iQEv6gsgu2ZbZQvqwAwS2Hh5E9kWVqel
 4tYDq36AWkHWhnHWJN+m8/W1tszltdkE7a3h5ajb8wg2KPrj6CP2aZA67OSPxnuyc81z
 wKqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEDkZiJ9lVXxbxGvEzHQLs83xqotu/aJ4H17RuUgyC3f7h5hYrr5eBpvXa1SZKT9GxsxViag1Rb7Um@nongnu.org
X-Gm-Message-State: AOJu0YyBpfYkLnMICdmFkb30Li6cMXAT9nPrq8Pbam336PLsykuxrcZZ
 9BL6l27Ca9LgFO48y1G4IzwwVuYvQ8Wmd+S/H2d5TvO4aFoa6LGumpxDPoMdyMQ2ltIaAffR05v
 1NzjXl14aUe1k6eW6nbIJwQdVs3XEDjCE0ZoYthEb+R+IMWp+7ND/
X-Gm-Gg: ASbGncu1ngAHGoj3NP3nl6k/8J0kJDkzbn2MrgiHToXpLLqAg/8QZvF1MbdBpxgaIX2
 s4ibTPnY9E3F6HVgtI1bTwzTsmGal4ir0V6fJpQO8w9Snqiqffev/tG6BD2ptyCvUTeeMH+E55l
 xsmDi5cKj7MTQveiRjJRODAEN+n3DAMB2VCl3J+4hlEHxFDLwhZR96uLjFeyNs+q01OrSoSQys1
 hOqQX5XTSo7D7c7NcoX0h3y0U7HEpEbCxP2I7+85VXR/JkyujHtD17ZWsYxZPgutfhwE8qo+m3X
 56aH3dqQ/R1NBlnJbWBnjXB+7dE=
X-Received: by 2002:a17:903:8c5:b0:223:f7ec:f834 with SMTP id
 d9443c01a7336-223f7ecf8a5mr17739665ad.31.1741161055982; 
 Tue, 04 Mar 2025 23:50:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXU1B1JcGQTMlqXXan+JhbuUQpcbKd5VDvptLjdnXzUlMCc+I9+8T5jnWKgnhS6oWObYElUg==
X-Received: by 2002:a17:903:8c5:b0:223:f7ec:f834 with SMTP id
 d9443c01a7336-223f7ecf8a5mr17739325ad.31.1741161055596; 
 Tue, 04 Mar 2025 23:50:55 -0800 (PST)
Received: from localhost.localdomain ([115.96.122.38])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-223501d2778sm107425355ad.36.2025.03.04.23.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 23:50:55 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Sergio Lopez <slp@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, imammedo@redhat.com
Subject: [PULL 3/3] microvm: do not use the lastest cpu version
Date: Wed,  5 Mar 2025 13:20:15 +0530
Message-ID: <20250305075015.26892-4-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250305075015.26892-1-anisinha@redhat.com>
References: <20250305075015.26892-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

commit 0788a56bd1ae3 ("i386: Make unversioned CPU models be aliases")
introduced 'default_cpu_version' for PCMachineClass. This created three
categories of CPU models:
 - Most unversioned CPU models would use version 1 by default.
 - For machines 4.0.1 and older that do not support cpu model aliases, a
   special default_cpu_version value of CPU_VERSION_LEGACY is used.
 - It was thought that future machines would use the latest value of cpu
   versions corresponding to default_cpu_version value of
   CPU_VERSION_LATEST [1].

All pc machines still use the default cpu version of 1 for
unversioned cpu models. CPU_VERSION_LATEST is a moving target and
changes with time. Therefore, if machines use CPU_VERSION_LATEST, it would
mean that over a period of time, for the same versioned machine type,
the cpu version would be different depending on what the latest was at that
time. This would break guests even when they use a constant specific
versioned machine type.
Additionally, microvm machines are not versioned anyway and therefore
there is no requirement to use the latest cpu model by default.
Let microvms use the non-versioned cpu model and remove all references
to CPU_VERSION_LATEST as there are no other users (nor we anticipate
future consumers of CPU_VERSION_LATEST).

Those users who need spefific cpu versions can use explicit version in
the QEMU command line to select the specific cpu version desired.

CI pipline does not break with this change.

1) See commit dcafd1ef0af227 ("i386: Register versioned CPU models")

CC: imammedo@redhat.com
CC: zhao1.liu@intel.com
Message-ID: <20250220065326.312596-1-anisinha@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Sergio Lopez <slp@redhat.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/i386/microvm.c |  2 +-
 target/i386/cpu.c | 15 ---------------
 target/i386/cpu.h |  4 ----
 3 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index d0a236c74f..a340a5fd39 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -491,7 +491,7 @@ static void microvm_machine_state_init(MachineState *machine)
 
     microvm_memory_init(mms);
 
-    x86_cpus_init(x86ms, CPU_VERSION_LATEST);
+    x86_cpus_init(x86ms, 1);
 
     microvm_devices_init(mms);
 }
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 0cd9b70938..2da2cf36fd 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5640,18 +5640,6 @@ void x86_cpu_set_default_version(X86CPUVersion version)
     default_cpu_version = version;
 }
 
-static X86CPUVersion x86_cpu_model_last_version(const X86CPUModel *model)
-{
-    int v = 0;
-    const X86CPUVersionDefinition *vdef =
-        x86_cpu_def_get_versions(model->cpudef);
-    while (vdef->version) {
-        v = vdef->version;
-        vdef++;
-    }
-    return v;
-}
-
 /* Return the actual version being used for a specific CPU model */
 static X86CPUVersion x86_cpu_model_resolve_version(const X86CPUModel *model)
 {
@@ -5659,9 +5647,6 @@ static X86CPUVersion x86_cpu_model_resolve_version(const X86CPUModel *model)
     if (v == CPU_VERSION_AUTO) {
         v = default_cpu_version;
     }
-    if (v == CPU_VERSION_LATEST) {
-        return x86_cpu_model_last_version(model);
-    }
     return v;
 }
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 10ce019e3f..113cf10aea 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2740,10 +2740,6 @@ void apic_handle_tpr_access_report(DeviceState *d, target_ulong ip,
                                    TPRAccess access);
 
 /* Special values for X86CPUVersion: */
-
-/* Resolve to latest CPU version */
-#define CPU_VERSION_LATEST -1
-
 /*
  * Resolve to version defined by current machine type.
  * See x86_cpu_set_default_version()
-- 
2.42.0


