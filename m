Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3170BE66884
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 19:09:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWfqR-0000Yn-VJ; Fri, 19 Dec 2025 14:08:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vWfqQ-0000YP-OE
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 14:08:54 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vWfqP-0006n5-3o
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 14:08:54 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47d182a8c6cso6304955e9.1
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 11:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766171331; x=1766776131; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7InpFQ7BTqeavUK3Pc8BqtwXriQXDgmpyYwzlrclqtQ=;
 b=bFov7Yst/kv7x55AGFTTQYiCsPgRXM+cHtldE1A62sN/zyLKY223/3Sp6tq495gzbE
 8cDjIZPx2aFvTn+zQy48c0uaRd1Je3F36W1gSEWuyKG9hPLCvbu630vX66WGTVqPrQsW
 BrB0sDCyer+ys3wJFRJ8tNNZ18lhHPCCOzcoMYImzQ415JaixcLbcZyWtJydAbw3m2PZ
 g+cZJqUw7NtE1b+XqzDIQIPHAcu0oVytIrrm+EVPTCkRlrwNPyox5h5ShQQQtuBxtxR9
 MEbn3ENwKrn0FiE4CF48U1b2D9lDO3ga+KMvaesebilK92r0r7WDV4B7kqvxN+G58xRB
 WLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766171331; x=1766776131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7InpFQ7BTqeavUK3Pc8BqtwXriQXDgmpyYwzlrclqtQ=;
 b=opo27awkO+SKfQpuLfxLgyA4/G2lTu0JGNWCuhjfc8RtrVCWQXe/1WPPxUlBtxkcU2
 ZcSgoviw7Mnqg9fwtsPmkEVwHS5GJ+6A5fUYvPdbeVyVAUfT/ax8RQA86zY2DRV99PSP
 RU/WuOplFlfluKgab/EqpP6miVUIlCribiapprxN7zMqR22AgyRkyIRZ5hdCWsgbp5WG
 f+mofIBHTI9hptHXXLK798K3EmsZdNIISuIVNVJyOwPPzhl/ujmtWRxPvHWtDfmSiIxa
 CwMQ+feI4jw1PbSaO2KBR8V/oGices6z2mfQnObUeyXe8kGrahKUAtILRNM2dlA3TE1i
 5vEg==
X-Gm-Message-State: AOJu0Yy1Izif1v3dniT+CIJ+54786ftTiFmfm//5W074qCDRYPB3aCR7
 XPj0ULonRSAD86HdwPD9XnpKYdq6qAZ/WEEfbjqkI9hle29wEWSrsbbRePhWSM3ssW0=
X-Gm-Gg: AY/fxX6UtQ7gttmfFMVFgAPTzxU8b1Mq4lzj7NF4AUDufKorSSU7FgfJ+N1zRnWufnk
 DrMJvBARGKwJzTut+QAbkTj1Q3p2kum/KmqvYOO+3bV/hpQfcsAmNMK5LSEHrzVDAfo5UjrutDD
 DrP2g+OPTXWF2Bq/sjjNYZm3o5gpTMSBSyucXcDO9lAWhOhsTPk1zR3jnT9FoKtmbe1Cwtu5DfO
 53W/lY6t57W+/Y301Kqfx0mBVyUPyfsDfUBJ4B0u+V1gmrtTGB7mHXof6twq8V+Ydi6csf/npUp
 FV7+AxI/BTAJ8i4XDUcgb2W+b7Z+DqzC7S6LzszsKr1YF7YY9lPKpMZhziSrhpx+WDXcH/UvfUQ
 qkQjYyqSBUP43USOeNJkeKno8tG07lXp9mnmv8HzsFGZQIxbWSLAttwcPgf3XwuX4ttxTJC6frz
 V4PatNxb6BaNU=
X-Google-Smtp-Source: AGHT+IGjJ4d/5pjemsnQ0AshvMwPrp7duwimLFoMgWxw1v60VDF7w1sETbryDdVo+y/CrlNQVCnXZA==
X-Received: by 2002:a05:600c:6211:b0:45d:e28c:875a with SMTP id
 5b1f17b1804b1-47d19598fdemr35889845e9.31.1766171331276; 
 Fri, 19 Dec 2025 11:08:51 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be273e4d5sm112790995e9.6.2025.12.19.11.08.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Dec 2025 11:08:50 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0CB2E5FC1E;
 Fri, 19 Dec 2025 19:08:50 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alwalid Salama <asalama@qti.qualcomm.com>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Mark Burton <mburton@qti.qualcomm.com>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alex Bradbury <asb@igalia.com>, qemu-stable@nongnu.org
Subject: [RFC PATCH 02/12] contrib/plugins/hotblocks: Fix off by one error in
 iteration of sorted blocks
Date: Fri, 19 Dec 2025 19:08:39 +0000
Message-ID: <20251219190849.238323-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251219190849.238323-1-alex.bennee@linaro.org>
References: <20251219190849.238323-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alex Bradbury <asb@igalia.com>

The logic to iterate over the hottest blocks will never reach the last
item in the list, as it checks `it->next != NULL` before entering the
loop. It's hard to trigger this off-by-one error with the default
limit=20, but it is a bug and is problematic if that default is changed
to something larger.

Signed-off-by: Alex Bradbury <asb@igalia.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <2e1c404fd21d064610391ebb2ffe24d0c536f8dd.1764716538.git.asb@igalia.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: qemu-stable@nongnu.org
---
 contrib/plugins/hotblocks.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
index d3dd23ed9fa..cf4d6b8c363 100644
--- a/contrib/plugins/hotblocks.c
+++ b/contrib/plugins/hotblocks.c
@@ -82,10 +82,9 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
     sorted_counts = g_list_sort_with_data(counts, cmp_exec_count, NULL);
 
     if (sorted_counts) {
-        it = sorted_counts;
         g_string_append_printf(report, "pc, tcount, icount, ecount\n");
 
-        for (i = 0; i < limit && it->next; i++, it = it->next) {
+        for (i = 0, it = sorted_counts; i < limit && it; i++, it = it->next) {
             ExecCount *rec = (ExecCount *) it->data;
             g_string_append_printf(
                 report, "0x%016"PRIx64", %d, %ld, %"PRId64"\n",
-- 
2.47.3


