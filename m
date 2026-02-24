Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0749EEC2B8
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 01:34:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuhJJ-0007yQ-CV; Mon, 23 Feb 2026 20:34:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vuhJC-0007xm-3X
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 20:33:56 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vuhJA-0001Rr-3k
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 20:33:53 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2a7a9b8ed69so42676265ad.2
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 17:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771896829; x=1772501629; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CAE3tQRLgLwLCGzTo6f0WNVfJR+Ki3L/v9nwz24ihw8=;
 b=mKHwmJ8AHjKuLD7k6umoXeFeoH2I9pYz8zTppJO/G+BDCqnmpd7jmLvJyZ/XwwwB8j
 T49mTm8+z1Cq6IZ7nTsQbH0pnXNvmx/Karqa0xozaekahdLrTZyl+jiSe2HqlkFX4NIW
 eV0n/Z/94JcJxzPcHzmsfi61dIp3LO3Mrbjtn4hPekQ63TAs8XkiSdUI5t824iR++RIz
 wTtQR7/ZMX4aUe2X+17UhfMOYCb69U38bJB2uUcTgOVzddYrQNSUPFI8HZ7UVlHjOU4l
 YJeEJtQdE5DZvLY3FhWhlMbUCsTfmbzNl+o1/KMDFu6ukPkKYPUhBrGnqV0O4jTaVopJ
 VodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771896829; x=1772501629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CAE3tQRLgLwLCGzTo6f0WNVfJR+Ki3L/v9nwz24ihw8=;
 b=aEHZB1R/8JLP3gegQEO27IJQ2fcI5zDGwmUpwKSYU5bQEB2yszgaV7CSVZvmezAy3E
 D84FbByNpY+PjfBY+IDoq71i6nUDOnN3fkAYRHZfkGq9uEPRQLHWHsEuoc8HkTfN7xpq
 6+4QruzkzXuOd+fGGhzZEyd9NYhRjGcMCGs5Sfc/gv50WsXChKSUn9av3w8UGkwEZzDw
 6yv8PBrWLnwKs6RX5Z3ZHfVfNdvvVMcJf3/ppv4kSrgyJg7vzIyNdHSJd0+G1gPXvNMu
 yxiTBH4RpqbNbhrf7iSOkXNUg1IiOxS54IfTgXHxczmBQo9fgAKTFmYmpt5Jw9icTMIC
 pbuQ==
X-Gm-Message-State: AOJu0YzEXq8f3WN65XGP72Y88YWCOcx/oxmkvyeDQSZdR1Y9s4XnC82b
 KftbqL09HodDB7rfErk1Hyvk+JjXrM+oLopJaigpI9QTsPjSwDJ1VKTqXsIo2StoRCaSN4uaq/q
 c/Kw8
X-Gm-Gg: ATEYQzzTty27Vaj96tO0QhBZaCyCZMlSLZWVK2wwHdVmfz5fx9vvn1JEj5PgVuhLZz9
 2OFFwB1VNHqzC2i4cTvmKLk5R54cBaNqYVky9Ea1g6M8mg24FIKOs/ToX0owxsKMNt4lt5qUUfN
 JpuF4+Q5IZNNilKixQIusX28r9ZHuI9I7MVEUceN8cVN1bRsnTwHC2qDg6TCIfy9gmi1zqYaqcg
 ipzNACz1zI7yVC3k8yWFUR4rZcTUx6xdMX+TFBI6ZgeuDfSPuam+U9Apb3IwtYdnEYGhQwvkuSG
 AfWOzerK83ejXgxtPQoOhNYBsKrfMO3gRBuNJU34Qk7042TKAmAinBCLauFpZfLZatMFB6qBb02
 8G/LRHHyfkcekzaHLiZGOTR2uLjT12d9zvGJovKjCKNV+hPOBIPcpduoDaeoZDtVVtDxXT968Ud
 bDI6UNTrzQmIDikBPeUR3TmTKq+ZVyDDTUwtk5mDkABCQqnulqoN+y7btnQA/0l2rZu9kip6KAf
 IBh
X-Received: by 2002:a17:902:f68a:b0:2a9:db7:446d with SMTP id
 d9443c01a7336-2ad74449c13mr113856565ad.22.1771896829267; 
 Mon, 23 Feb 2026 17:33:49 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad7503fcc5sm87006115ad.76.2026.02.23.17.33.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 17:33:48 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 1/1] contrib/plugins/uftrace_symbols.py: filter out some
 addr2line error messages
Date: Mon, 23 Feb 2026 17:33:42 -0800
Message-ID: <20260224013342.2470297-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260224013342.2470297-1-pierrick.bouvier@linaro.org>
References: <20260224013342.2470297-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

This was found when tracing Hafnium and SLOF binaries, and it's probably
related to a bug in toolchain used. It's safe to ignore those entries,
and related symbols will still be present in output, whether they can be
found or not.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260218172356.938236-1-pierrick.bouvier@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/uftrace_symbols.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/plugins/uftrace_symbols.py b/contrib/plugins/uftrace_symbols.py
index 21704541a6c..7d79b81cdec 100755
--- a/contrib/plugins/uftrace_symbols.py
+++ b/contrib/plugins/uftrace_symbols.py
@@ -59,6 +59,9 @@ def find_symbols_locations(elf_file, symbols):
         print(e.output)
         raise
     out = out.strip().split('\n')
+    # filter out some addr2line error messages
+    skip_err='addr2line: DWARF error: mangled line number section (bad file number)'
+    out = [src for src in out if src != skip_err]
     assert len(out) == len(symbols)
     for i in range(len(symbols)):
         s = symbols[i]
-- 
2.47.3


