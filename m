Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A297FCA179
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 18:59:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzfny-0003tl-B0; Mon, 09 Mar 2026 14:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzfnx-0003tL-Ap
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:58:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzfnw-0007p4-1x
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:58:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773082691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y0eMpYMCvhFSbjZnQVatmA08KRwb8Q1v1D8tShGnW+0=;
 b=EiG0HoTtgUvdNgMpqZpKUlo476o0rlF7I0NK6seSfTcy4yVzF7pWnJHtAsFmydE8E3jCqu
 85iu03U402bqbDZo+GwYsxNx8LeuYgU88cMkSZUk8ICqFmxdm1wDwLf8ylkHCX/6/uPv2R
 CyRI2M/lWuGm6sRnbISpA3hyXGgWgsg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-94Npf8jjPyelXov-udQEeg-1; Mon, 09 Mar 2026 14:58:10 -0400
X-MC-Unique: 94Npf8jjPyelXov-udQEeg-1
X-Mimecast-MFC-AGG-ID: 94Npf8jjPyelXov-udQEeg_1773082689
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4853ab1cae0so14500785e9.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 11:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773082687; x=1773687487; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y0eMpYMCvhFSbjZnQVatmA08KRwb8Q1v1D8tShGnW+0=;
 b=qfJ+uE6PMDriTtSl/1cNllAc4EouK0jlPo9dwmf5y55eRh4pPUxk2+6cicytg2jQKw
 WENDIhs40pL4eJ8Zx4zshFqFhU3t6CUqszAenJBGIzpnVyV4JxDNInzTKMnmxGdIpudD
 IGQVEvmiccIqY8e/CebrGarnCKgvlcEd0aaxqR7yS3Yvm9SMcJ/gA3DHBw73iXEBUPcs
 g0lNTiTLD7eyHvIrpY4XjhiW2ZPKpvziglRCf9OColI4U6O7VJSBYeRUySpXCmaEjw1S
 Up1gXmsT/45tsrxCTrvdn3Mpuxe6iUvwNxdwdzdus0+mBKQ4LirpKww/1Dsq8HrqvoEU
 qwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773082687; x=1773687487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y0eMpYMCvhFSbjZnQVatmA08KRwb8Q1v1D8tShGnW+0=;
 b=js/EkOh1E3gws9O4lgb+FU5OJ2euCcomF7w5UqScxBJc4acEOWZMcQU3fpTI+KhaSD
 5Eoiccx7BOuthihn1irlgNoWhINZY9CNuVGnIRSNlYN+BH3lTNdWjbP3aeUMPXqmA542
 hap4cH+AwUQlB4iqyRO0cPPfO9nzkQtDd1QQCmZVm7SiJhAup3ye87ZilM6vpBOpd2oT
 giz14FL7mhn5lOlC5NVOPOmDtA/318gaNaorNwlf06LlxsJ8XoI9IocwczxjYGIC+4wD
 dSg1NuuK/mFF7c3vF3dUG1Y9SRk9lhj1Eeo5mRz51k85huRWOwRLMb8lF+gdhPn5mdcN
 mIog==
X-Gm-Message-State: AOJu0Ywuf5jwVj1DwII4YfC7L+p0J9mMggA8Hrh+lQIGjFNmd7zzP4VL
 acTR7cYze/0zKoqkh9Q6NcjAgjtAdaZL/DyKOaHD7mDTqgNqmW9HBSeWgIhFxlPupqO7FckfK1L
 CaW1WbAFxWkcZUjdizAburky4OPsOzASvKxlFZX2cyfQfgqD9JVzDT0V9KQZmgTnzOshN/N6yNd
 4fbom+SfODvUa0ujrk/udJ/Rx0oJ9LcwPSB5Jhoodr
X-Gm-Gg: ATEYQzygKP7WHgmhx1BPKHWO/iOqT01OmT0pknmftK2JNkJHR3IkqRc5hTcqdqj+U1M
 eT4vGr7SCnrMVL1JVw8wJHLKfc0xV75ABpK/BcNr9C4H4s4gmhDR7fzLluLL3Rh38LrRgzpmLb5
 bvkj7YlTqxpvOlqDcoUGIsfxFmeykIB4Uzey1Oa8WVbKLwwWBgWdxd0uYhJHKuZ3pKCXvOdSeWM
 He9EYVmvB7BCxoNhcRpqTxf477BQQJNDLQ+0MhNaweOc3/3fQJA/XaEIFGG2TD2A+RNddJU9GS7
 e27zVLEYkoB59zP957uQvJKzS9q8hAwbpUESrFUHPK/P8bpJPNHJcIBwqoE/7Aq33kz02lU+Gzs
 5KWbnMvU/3HcOEZ2JQnIfEPZJZqiFwcK8n/xLEcrkPaOzDfWTE6XGroF2Rf0OwSnNhDwPc/M8qT
 sdVRlM4myVnawcQMFbRNhIFrrRCIE=
X-Received: by 2002:a05:600c:6384:b0:485:3026:2b8b with SMTP id
 5b1f17b1804b1-48530262d83mr122865425e9.29.1773082687483; 
 Mon, 09 Mar 2026 11:58:07 -0700 (PDT)
X-Received: by 2002:a05:600c:6384:b0:485:3026:2b8b with SMTP id
 5b1f17b1804b1-48530262d83mr122865125e9.29.1773082687008; 
 Mon, 09 Mar 2026 11:58:07 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246fd127sm142997255e9.6.2026.03.09.11.58.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 11:58:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 06/10] target/i386: emulate: LA57 fix
Date: Mon,  9 Mar 2026 19:57:48 +0100
Message-ID: <20260309185752.76865-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309185752.76865-1-pbonzini@redhat.com>
References: <20260309185752.76865-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Seen on a Sapphire Rapids box with LA57.

The top level of the pte array is taken for CR3, so there was
one entry too little for 5-level paging.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260307181856.2209-6-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/emulate/x86_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/emulate/x86_mmu.c b/target/i386/emulate/x86_mmu.c
index 8261ca16351..4e39bae025e 100644
--- a/target/i386/emulate/x86_mmu.c
+++ b/target/i386/emulate/x86_mmu.c
@@ -56,7 +56,7 @@ static bool is_user(CPUState *cpu)
 struct gpt_translation {
     target_ulong  gva;
     uint64_t gpa;
-    uint64_t pte[5];
+    uint64_t pte[6];
 };
 
 static int gpt_top_level(CPUState *cpu, bool pae)
-- 
2.53.0


