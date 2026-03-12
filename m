Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC181105A584
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 11:06:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0drM-0003yQ-Iy; Thu, 12 Mar 2026 07:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w0dqp-0003gu-7j
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 07:05:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w0dqn-0000Pu-Iv
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 07:05:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773313508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FkYAYywfDZZ6ND+0N5KY8clqrYgScZxhpvMlLcsPGWU=;
 b=FVwHaVYzWWOavPyXBJImZPHrdJ8Pubac+myB0vJo3otkLqAxC8uiS6EmJksxaR/xqX3jgF
 05//I4AS/R1AhoRNULjszXOXrtZlLJeB6ZGxqQtkFMg9eBVJYPQpDxTMTozsZr9jZ5q1hm
 J+EqYD0oFsmoT4zkbWRzYEPd1pmcfgE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-uML5KVbOPqivhuhfIE5uDQ-1; Thu, 12 Mar 2026 07:05:07 -0400
X-MC-Unique: uML5KVbOPqivhuhfIE5uDQ-1
X-Mimecast-MFC-AGG-ID: uML5KVbOPqivhuhfIE5uDQ_1773313506
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4853ac455b2so8691065e9.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 04:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773313505; x=1773918305; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FkYAYywfDZZ6ND+0N5KY8clqrYgScZxhpvMlLcsPGWU=;
 b=AlnQOFPtnrPkQXlxSSG3Icb+IAMNAbLzrJz37Yk4fkzhICJYSDqcPFf+eUyZDaRHT2
 jkv/kMIwJ9tLX64RcO60GJTD7kRQ4xlsPSH5WAoJzqO3l6bQeiuGyy40bypFZkRfq0IL
 /ojQbWRA72suG7KdAkU/lHhVKUuuu5bwE/HwVe0SeEpnJK+I/CDCeBgx3Eebxy5R/2Df
 TLNRHO2dccWFSiEr5BhTxVoEGXGO/nVw9uWzCjgJjZZQoeORt8xBrAWEY35rl9jlUdkd
 N+HWt9n858UsKrSenB/u2j5c7Ju+FSMkqENUw6H8eO09K6QKx1fqtadY13dznrMxr+BY
 vhBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773313505; x=1773918305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FkYAYywfDZZ6ND+0N5KY8clqrYgScZxhpvMlLcsPGWU=;
 b=ia/kvfjY5Nvh8jgqg7H82aMfa8liv9qIAGtJgco2VtBcXNTpxJQSoE1r7MKwD9F2CW
 tN55ej+oR0wtHE6+84kSRShFA+Bc4d2jb5wHg2rTwuqB1yu6CYqdC1JdPU0r2suO0Ica
 yV5YsC1PmeynMUVNbJKqqevhxWOZbrx2RZ6fPkGHgRqSQ3rzZ5wiw+Kzu66upwlTZdzu
 /zEXaAM5B1TiuRDsOHIHzfd+G7McHcwM3U8I84ZGafpgC2+hX5zeV8CLozgUqf5eZUTc
 WT1maPvGpJPYc7DrE2FDgMWKP+ReZugPn+jWao/JCQn4s/99W39HM5hoALAvKggrPuz2
 m5ug==
X-Gm-Message-State: AOJu0YyLPb0Us5L5EUWUeQo36c2qNpz4q5keMpAYPNYqCCI2rsELnnub
 EQalMXlfvPaxB07vFCBYCzQgILgxHU5ZPAqhE4tS0QBzllRXHYx0UK8aBuuoHIyH4I4vN8llm9x
 iKdzp3Iy8wEmKe28NkjAA2EcK6d9LaWd5rUzmSddLNwQFqMSeX0PL8ZCgXUcyZ3AK04cI2n5aJP
 1b67+/cNDhiIuJHLM1utZY8tiTV2ndw34iWnkLGc1G
X-Gm-Gg: ATEYQzxiJ+FHix94AuhpN18fjXu0o5Nq2duoNUGbAjgJf9IAJ1aPJBx42LnNSO0vh+v
 BSBtrqUdSChcmYY3ihGzLVsuSWoEKtInIaeCMsyDssSpaf7FJTmKWkHLjEnEyNuSj1ZyJXbSWTj
 IBdsvbrrysf0ZX8MZVyCFgrphZAIN5PxcCQ6GwPCV3wMqG0zstDYoynS/S8Usk8fFYa/Ib3Nl+Y
 caosy3Xr7E6k103F7NxtHcv40WmYzI95c4DqKZMvM2Tstltm7Toc4ZbzbGp/CosQ/JaNLRnfvFZ
 XbSimWALjXmI+sfv3CRpXIsY5HEwDdbYLO0UuqZzS1bLY2F5NpD46zcvZoosfO8wmxW6PBu8ZOw
 mX7ucm0PZSm0Zj7LL6RcR/riO+8TOuIKoWYOWLrD9crJop70GeDTGnsF6P405PzCXQgKZKC2f3L
 LjvPJZ6xzZoNHqw+HShVJJ6QzCPek=
X-Received: by 2002:a05:600c:8b72:b0:46e:4e6d:79f4 with SMTP id
 5b1f17b1804b1-4854b0d2f28mr92634105e9.15.1773313505479; 
 Thu, 12 Mar 2026 04:05:05 -0700 (PDT)
X-Received: by 2002:a05:600c:8b72:b0:46e:4e6d:79f4 with SMTP id
 5b1f17b1804b1-4854b0d2f28mr92633415e9.15.1773313504950; 
 Thu, 12 Mar 2026 04:05:04 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854a2fa75dsm45042515e9.7.2026.03.12.04.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 04:05:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 04/14] i386/cpu: Remove unnecessary cache_info fields from
 builtin CPU model
Date: Thu, 12 Mar 2026 12:04:36 +0100
Message-ID: <20260312110451.685161-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312110451.685161-1-pbonzini@redhat.com>
References: <20260312110451.685161-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

From: Zhao Liu <zhao1.liu@intel.com>

In x86_cpu_get_versioned_cache_info(), higher version CPU models will
inherit cache_info from lower versions if the cache_info field is not
specified, so there is no need to repeatedly set the same cache_info.

Therefore, remove the repeated cache models from SapphireRapids-v6
(SapphireRapids-v4 has set the cache model), GraniteRapids-v5
(GraniteRapids-v3 has set) and SierraForest-v5 (SierraForest-v3 has
set).

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20260310140819.1563084-4-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 08450a9142e..05121c5b324 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5264,7 +5264,6 @@ static const X86CPUDefinition builtin_x86_defs[] = {
             {
                 .version = 6,
                 .note = "with cet-ss, cet-ibt, its-no",
-                .cache_info = &xeon_spr_cache_info,
                 .props = (PropValue[]) {
                     { "its-no", "on" },
                     { /* end of list */ },
@@ -5446,7 +5445,6 @@ static const X86CPUDefinition builtin_x86_defs[] = {
             {
                 .version = 5,
                 .note = "with cet-ss, cet-ibt, its-no",
-                .cache_info = &xeon_gnr_cache_info,
                 .props = (PropValue[]) {
                     { "its-no", "on" },
                     { /* end of list */ },
@@ -5812,7 +5810,6 @@ static const X86CPUDefinition builtin_x86_defs[] = {
             {
                 .version = 5,
                 .note = "with ITS_NO",
-                .cache_info = &xeon_srf_cache_info,
                 .props = (PropValue[]) {
                     { "its-no", "on" },
                     { /* end of list */ },
-- 
2.53.0


