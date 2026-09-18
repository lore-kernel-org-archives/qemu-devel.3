Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95866C982D2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 00:47:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Mh1-00073L-GQ; Thu, 17 Sep 2026 20:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x7Mgz-0006wk-1C
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:43:05 -0400
Received: from mail-pj2-x0e.google.com ([2607:f8b0:4864:39::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x7Mgx-0001Ri-Ei
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:43:04 -0400
Received: by mail-pj2-x0e.google.com with SMTP id
 98e67ed59e1d1-396ccd5cf02so137078a91.3
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 17:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789692182; x=1790296982; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p8jipkRCiZErY6Unp0DQyf/hv142izPNPRXYzqEKx5g=;
 b=J9KriP6XzhnRPGlXNKVkBZitQ+l1zeyX2gUg4QtPjRaCPFNytT8LyOP3iIsv0ITRK0
 DzUx2K9ZSDts6VFRdd5Kv2zwLVVnzCq0NAgOsMHtTTDcJvq5xhN/YxGGQqM2XsjbjpG1
 DhmOtUDIUuvZnw2tY7b18B9/AHxDF56P1cjkvXBqO2/cey0qQE6NAQzyXXtUXy27f9+M
 R/0ImO8Np8pzTI+iAcZ13uR43vSymEF/FncXzjjdF1BftNXv5Gv1ntU0xyxQAc+1RJRU
 1VYh8tbpvxsuIH5C4tpTAcavweFJYNPqZEmu6L9AtlytkD6HXQLPpmSKARpJZ3YX/8Ld
 UcoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789692182; x=1790296982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=p8jipkRCiZErY6Unp0DQyf/hv142izPNPRXYzqEKx5g=;
 b=w3x9EPhAitMijGB+YakHAFsZXvA42X1uucFNohe+Q0/gng7wVE5MeIRsb5l833KoOb
 LzY50qifyb4aIp8rcmxvLJi0dO0jF92wwgGsuAElvMcvSayjz/OX42SaHI1mDxxa2hMW
 5GoYXoIdpll4zsanGElmiZ1CyOnqIvAzbRjdXstRY7UEo3mmLRVdGR3warV3wCb6x/xe
 CFgvFTPWme99UA+qOH0sD+8X1dXXBw56+wo4rHbwGoVUMDNMCWw+9QO3MxoqIgMkRXSR
 REm0eaHxGllOqU1KH9RKSZQFfSUnHzxJA8GBuQyKkPmpYaNIlMy5qGxPlDyH4V7O52HZ
 L0YA==
X-Gm-Message-State: AFuF++kzEJy2yi/9NXE8NRb/zWxZqCKBxjm2VrhogiNi4lHOiWdsbLS9
 lThx/1cWd09DoCFZxnDMh7FGpFRiugbVwUQa3YvOEoJS7eX+RJHSFM4v6Z9iFH8uxg8=
X-Gm-Gg: AYBFou28eZ3gdJsk0loLnV3Svakjm1rUszh7GjbPcn80JuQ+rn2sGf9jeB3dVVvnUZm
 vem6x8nqyU2m1qOZtndeA8O0EZQnfDb8g4n0BUen6m+cnC0RU5t5cFUiNIYwcXfk/15nRXiorth
 BITsqY0lXQW/AGdA67hMIZUsUwidA55D5/9WrofOxSrEEWqRfMCLhKAX4kn9jvmpZ/ofn2V7knk
 Y/pwKgtXENxNMnEMwXQlfCrkHLImlckn9yv7itrUgoWgpIwGAs8a8DV4KPDEMeWIlhqeg1FRRWr
 ldjIwsuWQpwr5lVMC8IkFnxPTtfD49L5+2ZtQvuJO6LOoqZ45Xojfzec0E9Uf3iFHp6RsuAgHzO
 VkWQySVTxHsRG719TXVO8ULN4ue4e3F8BDWZqi+DD1HtC5EV/mKka2KH0EFN9g0uZZ4ZIetJvwB
 3QFUvPX8hlQn0Vd6qSIpu3CEm+7HzHvxmg9mueftQWqZENgy1lLjK7O7FopqbNDUPgTe5EQUr10
 IFNWiNtOLlhVb7W2xEROzs5S3V243br
X-Received: by 2002:a17:90b:48c6:b0:39e:131d:4510 with SMTP id
 98e67ed59e1d1-39e54ce5062mr1882200a91.13.1789692182105; 
 Thu, 17 Sep 2026 17:43:02 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-144cdfc3df2sm600286c88.5.2026.09.17.17.42.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 17:43:01 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Nicholas Piggin <npiggin@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Stafford Horne <shorne@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Eric Farman <farman@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Michael Rolnik <mrolnik@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-arm@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Chao Liu <chao.liu@processmission.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>,
 Glenn Miles <milesg@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Song Gao <17746591750@163.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH 03/21] accel/tcg: add helper raise_excp
Date: Fri, 18 Sep 2026 08:42:05 +0800
Message-ID: <20260918004225.827-4-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260918004225.827-1-luoyonggang@gmail.com>
References: <20260918004225.827-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::e;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add TCG raise_excp (env, exception, restore) that exits with GETPC()
or 0 via cpu_loop_exit_excp.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 accel/tcg/tcg-runtime.c |  6 ++++++
 accel/tcg/tcg-runtime.h | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
index 7c0aab98a80..ae93765b09e 100644
--- a/accel/tcg/tcg-runtime.c
+++ b/accel/tcg/tcg-runtime.c
@@ -130,6 +130,12 @@ uint64_t HELPER(ctpop_i64)(uint64_t arg)
     return ctpop64(arg);
 }
 
+void HELPER(raise_excp)(CPUArchState *env, uint32_t exception,
+                        uint32_t restore)
+{
+    cpu_loop_exit_excp(env_cpu(env), exception, restore ? GETPC() : 0);
+}
+
 void HELPER(exit_atomic)(CPUArchState *env)
 {
     cpu_loop_exit_atomic(env_cpu(env), GETPC());
diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index 0b832176b33..036a33d566b 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -22,6 +22,17 @@ DEF_HELPER_FLAGS_1(ctpop_i64, TCG_CALL_NO_RWG_SE, i64, i64)
 
 DEF_HELPER_FLAGS_1(lookup_tb_ptr, TCG_CALL_NO_WG_SE, cptr, env)
 
+/**
+ * raise_excp:
+ * @arg1: env -- CPU env
+ * @arg2: exception -- EXCP_* or target trap number
+ * @arg3: restore -- 0 skip unwind, 1 use GETPC()
+ *
+ * Shared TCG exception raise. Translate calls gen_helper_raise_excp.
+ * Exits via cpu_loop_exit_excp.
+ */
+DEF_HELPER_FLAGS_3(raise_excp, TCG_CALL_NO_WG, noreturn, env, i32, i32)
+
 DEF_HELPER_FLAGS_1(exit_atomic, TCG_CALL_NO_WG, noreturn, env)
 
 #ifndef IN_HELPER_PROTO
-- 
2.52.0.windows.1


