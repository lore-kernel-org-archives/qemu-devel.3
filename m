Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD0DAD0C854
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 11:15:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfcLW-0003AD-NB; Tue, 13 Jan 2026 06:13:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfcLQ-000351-D7
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 06:13:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfcLP-0008RE-0E
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 06:13:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768302830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vmMNXghpYjqYvVVn4RIngVHI8PwCV+JhYK/3vY9LTWA=;
 b=WuZZgZhW3qLeHITJYZyBCjAPZXU6z+XViEqeiFPXMDqq2BRmX0eafvzylPQzK9bGEgmUrL
 aszS/4v7qMTbW148ZgLAvXo54t2uNfdZ9LdaoZLtyW+KBSJzThWbvOj2kDr6Jn2F+OHLLU
 7FlnI/KfXgShEatvhDNyRfiZqDUNvUU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-N2GuKGwsOJ2-AW0mNoDpdQ-1; Tue, 13 Jan 2026 06:13:49 -0500
X-MC-Unique: N2GuKGwsOJ2-AW0mNoDpdQ-1
X-Mimecast-MFC-AGG-ID: N2GuKGwsOJ2-AW0mNoDpdQ_1768302828
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4779edba8f3so58389375e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 03:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768302827; x=1768907627; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vmMNXghpYjqYvVVn4RIngVHI8PwCV+JhYK/3vY9LTWA=;
 b=JaDY5g4XCNr7ct3dZVrmZu9l5H3WMxy782XpU8cKVl8h/ITR95z28NQoaYt7Ekj4Br
 CppFTgrZheXl83T65KAE0eut8u3+tMFzbxZBYRamEuaL9RkIjS3jp/FTFftzuv3dvlDQ
 VNoxW7VMcbtkDYX8W0wNJfZvz+yMCk+FQrZRuj3hwKHTxGw7meZx4oYI6JK2TwUURzhg
 6qVXLcPN4h777R5LRKY08rFhRp1CrP8PleYOrTMQCE3ca+X1lv0vRSOUANFWd7v3LWZa
 Dn5PUV9zzZdaaeH7PlOMKqPTvU1JXfj0Uyf5rs1pw4MZsMjV4+vgUcigVmznt+7VmZpv
 8/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768302827; x=1768907627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vmMNXghpYjqYvVVn4RIngVHI8PwCV+JhYK/3vY9LTWA=;
 b=MWuOqpex1We5/Y0NZuMq9gAvX/W8TYsk+nJCFD5SF8c8TQO3MZxoi+PHS6WSuHy0q7
 m3D8rzz1IRmvNOLQZtRx+04AmQMWjXpKE/FgHLuuZovynW1Fy8u0Knduq5WIC7rC8idD
 22yvMdkB5aM7DbP3hFyVkqS64CuryXwyckUM7wgzN59AszG5npd8hpbM8i73ZMHUIHFV
 1nqKxT9KYMlmPWPxxCdFdRcuWaUoTXAavrmU+WN64IH4ZqGlfVO25T1W1zCH1hxtKrYd
 cVlv6uW+l52kbB3MzRZ7+ChmKexatC/xkYwcfZ6qF9j+JqhBCHZH1jOObCgGSFKtzWvU
 Gvpw==
X-Gm-Message-State: AOJu0Yy3gCCUi6VUqmMB44zI2KZVJ9WqWdUQ5cUYY9k02ZFAD/Pnpxby
 IFS4Iqa1TnpVIzpWhc39IpLVibNhf/uaB830TT7GKXhsHDa3La9WhFCxXvAJqjHCHQfYaATbtjW
 51qot8FAP4CckNZoTm2oWc/E/OVWFs1bxqAoYuP1eHuQaa4sUzAv0YkkC4Voq+9fqXhhK2XqM6m
 ON5T8soQAAshpiiSEf+WLuyIu4ehSO/isGeXf1T37y
X-Gm-Gg: AY/fxX5gY0xNuozxDF3VVPuHUJooks7i/QYfDqrhg4JRRhXIGJ7ne2QDW3ShxzEbdqm
 T7F4sybgMDsR8QnmhoF0rg2YWsIXCqkbE6dfGVPVrpOGnSq+7t1ISMkE/vtUFY4qx6gcaj7AWgX
 wOH+IcewpUf5ejyyGKb/iFLbsz8aoVEx00/fPdPS9aeQ9AZEosOPQnclXjzfbh3ykreZgKkOVzb
 DdnPxhRzRaBQcSEZsgbAK6TNWWfqcO/ZxiY6ur0EwdqDrQbGvxqnamwqVZQpdXPy/8JY9ybsojg
 C9cU6LZCrGhtxp5mETq2zR3HD0lirXH+XM9KXaXZ4ynZkjNiNPebRBvfMjO2VI9esdmlnD7EV8o
 y64w9WJep+gZAZRAs//JmcWqfwygYOevhO5z0DiIc3VM8EK6A4r3+w9Orw0TK9KqJvdvA86HP/I
 i1XEEz/4emtNwl1g==
X-Received: by 2002:a05:600c:4ed3:b0:477:afc5:fb02 with SMTP id
 5b1f17b1804b1-47d84b34785mr268164855e9.21.1768302827596; 
 Tue, 13 Jan 2026 03:13:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE98/Vf9L73LmoijCXaRYMp8bvFyGDCDWE+ZddB4q6YYSA+8+ym98si70TLUzt49V+93fMjHg==
X-Received: by 2002:a05:600c:4ed3:b0:477:afc5:fb02 with SMTP id
 5b1f17b1804b1-47d84b34785mr268164525e9.21.1768302827188; 
 Tue, 13 Jan 2026 03:13:47 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e6784sm44653855f8f.19.2026.01.13.03.13.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 03:13:45 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 5/7] target/i386/tcg: allow VEX in 16-bit protected mode
Date: Tue, 13 Jan 2026 12:13:31 +0100
Message-ID: <20260113111333.1138160-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113111333.1138160-1-pbonzini@redhat.com>
References: <20260113111333.1138160-1-pbonzini@redhat.com>
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

VEX is only forbidden in real and vm86 mode; 16-bit protected mode supports
it for some unfathomable reason.

Cc: qemu-stable@nongnu.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index f662364c600..09e3d8884cf 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2872,20 +2872,16 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
     case 0xc5: /* 2-byte VEX */
     case 0xc4: /* 3-byte VEX */
         /*
-         * VEX prefixes cannot be used except in 32-bit mode.
-         * Otherwise the instruction is LES or LDS.
+         * Bits 6-7 of the first byte must be set except in 64-bit mode.
+         * Otherwise the instruction is LES or LDS.  Not allowed in real mode.
          */
-        if (CODE32(s) && !VM86(s)) {
+        if (PE(s) && !VM86(s)) {
             static const int pp_prefix[4] = {
                 0, PREFIX_DATA, PREFIX_REPZ, PREFIX_REPNZ
             };
             int vex3, vex2 = x86_ldub_code(env, s);
 
             if (!CODE64(s) && (vex2 & 0xc0) != 0xc0) {
-                /*
-                 * 4.1.4.6: In 32-bit mode, bits [7:6] must be 11b,
-                 * otherwise the instruction is LES or LDS.
-                 */
                 s->pc--; /* rewind the advance_pc() x86_ldub_code() did */
                 break;
             }
-- 
2.52.0


