Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C7ACD58E7E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwytu-0003Si-C2; Mon, 02 Mar 2026 03:45:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwytX-000219-SD
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:44:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwytU-0001cF-Ns
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:44:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IY2hcMqKKT16aeB8avf2viKArpoc9pPECGzH6yhOCo4=;
 b=LV31LGJKQ2GZtT9SSaIbJ+E0snDi/feSf5zCOeQm2LL47ir6r2Q2zMlbWvlS3jUsYbuqKc
 i5Vu4fUvVwcWcDo8hBRD1CpU5VW7JE9ieCjqQoK0CUdhATai4UfnKqvkgWdUnqZ14aTjkX
 rsjFdfenaGZhVjrIcp3ZWb7GKF5hfFE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-jcz5oSl1O1SoMWWaYCs5WA-1; Mon, 02 Mar 2026 03:44:46 -0500
X-MC-Unique: jcz5oSl1O1SoMWWaYCs5WA-1
X-Mimecast-MFC-AGG-ID: jcz5oSl1O1SoMWWaYCs5WA_1772441086
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-439bcec86dfso98129f8f.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441085; x=1773045885; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IY2hcMqKKT16aeB8avf2viKArpoc9pPECGzH6yhOCo4=;
 b=jLm/tWd4aX57f5elYQSWpD7iwrI9PwfyC7CMyJ8GLcELWO8WwWCKLDVNAI3EPC3oZO
 QSgzHkJ2Tp8ljBtLin5NH27JBSJ2AfLRtljvdCsPzZIJ5EPyzThLhrcQLCNKb49TxRzk
 nZ/takTgm4QiFmpl2k4h8a6Vkp44jZW+XT2rvG9Y/grmOKXrRYP8xO7HlImq3+q/aFXi
 wgO4rWYnsaRWZ1UzJBL98Gq/01lkCHo3iH8/u07ELbKuwY5oYMZA03OH7KJX1hy4H2RF
 g9UR4txJb2skpW4aCrUe3hc2obhin7xD+ps6oQlDqQwGMaPhtU7FOKPoNJoDxI1lzRVh
 otsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441085; x=1773045885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IY2hcMqKKT16aeB8avf2viKArpoc9pPECGzH6yhOCo4=;
 b=XjsVsiNjYv65Db9pMuIpSonxbPdAdniq7vfDlUWfx/TdoeOMB84zBMiSrZb5Rj3hB0
 DP5qs+MMtvt/iCSjCW+dqqYNXfk1FWRBls4XJPJr3QzSIqOJZfdvgIZAtymZX5uIxpPT
 5pI9EZ068lIkPFfa7Bor9ea57F5c9eMMW+FzbpnUDtZ8rx3CY4X2sPZhmaV/FVqo9Quo
 60ahC5JknvswjMTF+PR3kl5FXldSvrzwgg6jcvB87g8sP1pV/rB4QwWai6HfDQGxNy+O
 gAYNNkqkoFaJHN8us/Gpx3bVZQ4GnBspKtvKEJOj0uX0x+d9lTrO1G+V2qR1ywav2r/a
 /x3A==
X-Gm-Message-State: AOJu0YzFPxZKXbFoOeTYFSBaX5iraB8Uvaw2/DPcuYN8bNMyOtBLv3/y
 O5f3GHC+BbCNPtK8yZfkwMceFewlqBfHOFbZubVd35KwdXx//UvIccdJ4NKWhRzIPfC+fYXJZuK
 8WXhUb+6AOp6tWUgLXnIKkr++VuLzXLJ/APFlfb8cmvqREq8zdvykbnDlUN50xONqpJI4x+6Zaw
 slLJXFDQqmzcLip9nmVpRIEZpMIeUYolVTio4F7ctw
X-Gm-Gg: ATEYQzxvmI3E5MNLE+uNmIM2LKVAcfdCcxsYianx2bjLHTsbXMnKX/xvVoaWXxNoja/
 2hXbyu6XUks+I11/GpB7W//DjsI+B4vtdI9nbBeEhuZnPcRKrkpiNiKBQF/GLyOMOGOU4w+PrGH
 Rb3JQ3j5kEFf/aIwkgqc7z9uCG31KGJhinTl7xgLt2eu/9v2sctWR1EKGAPya+AzQ1Zopgl80uJ
 OKlxrPVB6vWRRW7c2D+9R8AwTHznWbgYTc2VaHT2E5GDAI6RC3BEh/wI2g4DwEzBHdbP0Lg4Fco
 ewoGnIFAyx2q4QTULTL1c8ul5OTPLvqNLXPJ1V5c580yJTn3oXv7b+TM1ENSLD4pYnOFcmyUXce
 LvUdIxvFyf8wQwrUmY0INiEF1iAPO0NAkd3gZ/PS5CtYTO+VTymU0g+w0NCPJqNfS2vRnJp4VT7
 NGEwYcvfEmI6MRq/iIhz6QNrZn+sQ=
X-Received: by 2002:a05:6000:24ca:b0:439:b564:7a6c with SMTP id
 ffacd0b85a97d-439b5647fa6mr6055815f8f.4.1772441084605; 
 Mon, 02 Mar 2026 00:44:44 -0800 (PST)
X-Received: by 2002:a05:6000:24ca:b0:439:b564:7a6c with SMTP id
 ffacd0b85a97d-439b5647fa6mr6055753f8f.4.1772441083947; 
 Mon, 02 Mar 2026 00:44:43 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c60e40fsm26049820f8f.7.2026.03.02.00.44.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:44:42 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 024/102] target/i386: emulate: remove fetch_instruction helper
 too
Date: Mon,  2 Mar 2026 09:42:19 +0100
Message-ID: <20260302084338.473368-25-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Not used anymore.
Link: https://lore.kernel.org/r/20260223233950.96076-24-mohamed@unpredictable.fr

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/emulate/x86_emu.h    | 2 --
 target/i386/emulate/x86_decode.c | 6 +-----
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/target/i386/emulate/x86_emu.h b/target/i386/emulate/x86_emu.h
index 3e485b8ca36..6b691118221 100644
--- a/target/i386/emulate/x86_emu.h
+++ b/target/i386/emulate/x86_emu.h
@@ -25,8 +25,6 @@
 #include "cpu.h"
 
 struct x86_emul_ops {
-    void (*fetch_instruction)(CPUState *cpu, void *data, target_ulong addr,
-                              int bytes);
     MMUTranslateResult (*mmu_gva_to_gpa) (CPUState *cpu, target_ulong gva, uint64_t *gpa, MMUTranslateFlags flags);
     void (*read_segment_descriptor)(CPUState *cpu, struct x86_segment_descriptor *desc,
                                     enum X86Seg seg);
diff --git a/target/i386/emulate/x86_decode.c b/target/i386/emulate/x86_decode.c
index 9faa65a5797..bae1dd4d6f8 100644
--- a/target/i386/emulate/x86_decode.c
+++ b/target/i386/emulate/x86_decode.c
@@ -77,11 +77,7 @@ static inline uint64_t decode_bytes(CPUX86State *env, struct x86_decode *decode,
         memcpy(&val, decode->stream->bytes + decode->len, size);
     } else {
         target_ulong va = linear_rip(env_cpu(env), env->eip) + decode->len;
-        if (emul_ops->fetch_instruction) {
-            emul_ops->fetch_instruction(env_cpu(env), &val, va, size);
-        } else {
-            x86_read_mem(env_cpu(env), &val, va, size);
-        }
+        x86_read_mem(env_cpu(env), &val, va, size);
     }
     decode->len += size;
 
-- 
2.53.0


