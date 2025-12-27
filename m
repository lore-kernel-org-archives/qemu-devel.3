Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B48EE8FDD9
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:53:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQxL-0003zc-EK; Sat, 27 Dec 2025 04:51:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQxJ-0003wf-UH
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:51:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQxI-0007U3-Az
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:51:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766829083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FcJUvHmJ46TsExg3IDNJH3LUWy0R3ZpUqKzgmh9etUA=;
 b=WPDLPhMhtF/Nsao/SBKKGzxp2TSxWHvnCp0rfJTiDzfH+sB4tnHZhlhTTYEXoQx5eY58S3
 kbxI7MGQ+7P1PBfRalia07lctQBbjheyPuG6vwdnf6lokD3YWv3T3CUTzpzcGWc1lY7M6N
 sERLDUvMFkiG9LbKSjqr/KwOmAjltR4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-V8D80GWmNF-jda9TqvLWRA-1; Sat, 27 Dec 2025 04:51:22 -0500
X-MC-Unique: V8D80GWmNF-jda9TqvLWRA-1
X-Mimecast-MFC-AGG-ID: V8D80GWmNF-jda9TqvLWRA_1766829081
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4325ddc5babso2697060f8f.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766829080; x=1767433880; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FcJUvHmJ46TsExg3IDNJH3LUWy0R3ZpUqKzgmh9etUA=;
 b=NnEyg7Mv943j+JsDuFM+VDg2SC9T11eO8JmhVU8qvnGRZ265V3Sv5EcffSzEBfP8g1
 AjXXJhbxxBmG7ddQUto+Cq9lut0cwUjFkI8n3Mow/nTWKDING9PTaPp7UGOc5p/pyDms
 M6DEKCS4DxV0ILECoCVkh2Fj6ebbdIzbD31Qt7dTMkD5lnW3S3oQNzD2TmnF4NzL7UY+
 RLCTCbrfdS8Pd9XV8mzze+jVpjAuZWwCbKI/NByWk8eUz0z20FvKQPX5inQrfgZA/Bqx
 yT8wc5JAmxDkgOeKYmqqH2H+PC+KKEir9CEEZWPNLXCrynqPSjEoWv/tgt+9JwhYA1Lh
 Bz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766829080; x=1767433880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FcJUvHmJ46TsExg3IDNJH3LUWy0R3ZpUqKzgmh9etUA=;
 b=hWAZlpPdfWZvmnLgdN5z1Qd+Ep65WReEXANI0dLX0iiDV9NSq2rTYk8BwoyrsRV/H2
 mzL6TNynCXJQUjhkQpLZfdQWEKx5UlAaoEMNAKojZKf1B2buQh8V6QksdquRXH8fkG5L
 owS6xmjN5oIHe9xByJdmyc/uNZnIuNLbjyEUy1UAdbkjw80NZOLh57JfjhD+DXcQlVJk
 6sXvEBGXVhsww2wLoVv9ztHpz+tF8onCHbQ/A8C+4vcKZ6geVvtn8wBV9KNCwE2ZVWJ5
 LRlcMUlBVXSmyT3sMqns8Hqabir5VbMo0JAZgMMTDvsyt96Srr11r9SgxWFFu565DyPt
 Y1ow==
X-Gm-Message-State: AOJu0Yw58z5sO8+974MhTrETmjCcptlPTTn3II4katAunhL/a4rDchL7
 VfJhODXeqBwa6LJ4SVvIiT9NGjElTQzA2mBnQaG7EGaWAsN3TfAZfNsGwEs0E6MZ5y5phKoSMrk
 QACFh0nMCQy2f7g/5QI2lbck8nYg00E5Gf39QiV9faiIecbMuDlgNE2p+D5aQD2CfJ/ctinszDy
 hm1VZclyxRw7TDpd22x1NOeIYE63st2KtpAxCU/26O
X-Gm-Gg: AY/fxX4yg8ZStfSLsBO+pu86hUOKj29EN83clIjjkljRUEuzqBdoUe7HDLelh+vBAVU
 ghHFe3WOrabA0zFQkhRQHMDF9jbSqod3kFYvop9J154OI80V3vg3tUuKR4n+lCyPmhTxOzGx4oS
 Wf8a+wWjHcMwwUQHJPJmQ51sNtqBWj1In6uncxj/CI7mJ8u4I3K9RXy43vgZ++nHhBxNaG8RerB
 ynAM4O5XXVSbMe4IIkf4UeXNAFp0izBet9MdtIg/R32AHucOknJJxVHCNo6wog6lNCNI5GpcmKk
 Oql11KCeC9Y2CD8NS54xZxyapkUhTH25HvMwP90ct8MR/j53NOPsEtpd9ErECkn9Jg1LG0MJ1qS
 6ZVwYDQe3h/t5tJCMtP1FBui+CJjPDYjBTCQowdWpKvuoJAkrkJx7s6twJSc8u/ReNjbZSWrWtV
 gLjZvYFQSDUyrZVMk=
X-Received: by 2002:a05:600c:4fd3:b0:477:a9e:859a with SMTP id
 5b1f17b1804b1-47d1958443emr284469735e9.22.1766829080305; 
 Sat, 27 Dec 2025 01:51:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHH09QZu0KVvsdGTIx1iaGVQarb5V2wVlqvaPCn6AKzK13VObPh3WkEdnkeMGOW6fU0pTkgKQ==
X-Received: by 2002:a05:600c:4fd3:b0:477:a9e:859a with SMTP id
 5b1f17b1804b1-47d1958443emr284469555e9.22.1766829079913; 
 Sat, 27 Dec 2025 01:51:19 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be2723d19sm522660055e9.2.2025.12.27.01.51.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:51:17 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
Subject: [PULL 140/153] i386/cpu: Add a helper to get host avx10 version
Date: Sat, 27 Dec 2025 10:47:45 +0100
Message-ID: <20251227094759.35658-66-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Factor out a helper to get host avx10 version, to reduce duplicate
codes.

Tested-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251215073743.4055227-6-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 9c81e4e1f5a..c460e3bec7c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7757,6 +7757,13 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
 
 #endif /* !CONFIG_USER_ONLY */
 
+static uint8_t x86_cpu_get_host_avx10_version(void)
+{
+    uint32_t eax, ebx, ecx, edx;
+    x86_cpu_get_supported_cpuid(0x24, 0, &eax, &ebx, &ecx, &edx);
+    return ebx & 0xff;
+}
+
 uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w)
 {
     FeatureWordInfo *wi = &feature_word_info[w];
@@ -9255,11 +9262,10 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         }
 
         if ((env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) && !env->avx10_version) {
-            uint32_t eax, ebx, ecx, edx;
-            x86_cpu_get_supported_cpuid(0x24, 0, &eax, &ebx, &ecx, &edx);
+            uint8_t version = x86_cpu_get_host_avx10_version();
 
             if (!object_property_set_uint(OBJECT(cpu), "avx10-version",
-                                          ebx & 0xff, errp)) {
+                                          version, errp)) {
                 return;
             }
         }
@@ -9481,9 +9487,7 @@ static bool x86_cpu_filter_features(X86CPU *cpu, bool verbose)
     have_filtered_features = x86_cpu_have_filtered_features(cpu);
 
     if (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) {
-        x86_cpu_get_supported_cpuid(0x24, 0,
-                                    &eax_0, &ebx_0, &ecx_0, &edx_0);
-        uint8_t version = ebx_0 & 0xff;
+        uint8_t version = x86_cpu_get_host_avx10_version();
 
         if (version < env->avx10_version) {
             if (prefix) {
-- 
2.52.0


