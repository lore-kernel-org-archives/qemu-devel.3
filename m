Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1498DCCA471
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 03:30:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v49zs-0004Tt-AZ; Wed, 01 Oct 2025 23:28:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v49zo-0004TV-8G
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 23:28:44 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v49zc-0004Yk-7u
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 23:28:42 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3fa528f127fso331230f8f.1
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 20:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759375701; x=1759980501; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mRS6aeO4S0WFLqM+NL6GeJq2x0UMCG4AbesJD75r0bU=;
 b=CT9LzVPhzXXoaurc41mQC3ZHgmym3/L5s9d9hc8cua9uWu022927Hpwg7CsN9PdBOX
 o+buDfrAlOHVkb11M9OsrxocLD6agGpb9NKUisc5JzxEd5ktZ1fZ6eJyYDD0y/1qLI5u
 NsSS7JuhEOcTKOmKubDXGccIf47L2GlajDDSWQ0oSm4bY+aT1i3J/9lReUhoFzNXSdSk
 9fGKSsBJFnScn0aJUOESLVzuLjobiuTB2z8LADnDdohJ8gIsOJCZL2ZdbxLaPzkb5cdw
 iIXkY96yxRHLKite5ACqMjRviJ9LlGr/g5AqF0//gM6Bcakd0Su0cWk5CrS21Qp8QzxX
 D7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759375701; x=1759980501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mRS6aeO4S0WFLqM+NL6GeJq2x0UMCG4AbesJD75r0bU=;
 b=eJdd75zA8/QatBl92DjLqZZS93Qsk+rH45LlCxFHb1kQyIzflMfNTSnfpjvXwGmkPC
 HttW7l4eMSd5h7uxyQRG1MN3ARvYFfwIztv7FWHvUfMOOjqH65P/o7gy7rkX8tM8S5dd
 7CnXtmHW4qjwMjW8COnzq8xJABVFX6FNDObMTv1R9nQZ4ldH0XW/u9iXu89trbr7s5Q4
 IjBKeUWoWYz19KOyT0j7998RJyBP7UhGyv4VyNYgXcsEfnUGIY6J1S3ELxRODYS8+7GK
 VRqbopvtddMUjX65CBabLtnpf0ODlzw68KN+6v7VjfUj90w0ZuOe3qnZGwJTOk9Y03Uv
 +Hgg==
X-Gm-Message-State: AOJu0Ywn750gj8RYAUifI5d1qVa/6MrSL4EOoLqBIbUbNfHzdbBgwUpq
 c+AfZ1aoJv5tS4EB8/S/wwE3hcDIAPEI5uFwjaqon2k+Nn2G7xITD6LjR2bfy4Ffg8Wgy16wEYi
 zUv2y4tiEtg==
X-Gm-Gg: ASbGncvXuAtN5r8u6G+64ff3xq8L16qKXLuIiV1KNt/Ac0aal0nXeA8GtLl4cAAIZbe
 GTaVXKWlmqHHl4wCYUJhFixf54iB3vxPOiC54VfofP8liAWv/F41rLa5HgkYZjjDY2ETsoDfxJY
 mxS/m9EggNykmHRWLfZeMDMr0CTNeBkje100t393/Sdv7Bcl7EatNvZHf+j1/iJVF7qJv0ESuSn
 vj5qN9bQ1SrfLCIpwp4CjQG+QNVC5qVxyAy7VzR4ZwsIfLMqgR85/uQSIozcTLzjeBSQ8h1FFL+
 U8MzfnwoPSJETYB4mpg2Jkby1zRePmB1kLkYtdBKa9gbAb4x/19duhVXkSUCUlwKfhhrMEIOMBs
 EOn8Rl2Lq8B+wdwzcKhAXrCXBXKmVN52mfT7sAXZC0eOm97rrncli0MuM1EfjO2S6sBQ9YOA+EV
 IhJv7HS6OlFgxSxLOy1BofoXQdasfvIg==
X-Google-Smtp-Source: AGHT+IH0OMPCx7J9hwHsXn61KTtqc/GiwpLPC8HsNzniJ9ciFldSBJGv3pbAqBv9Q1Sc3FuO6RziTQ==
X-Received: by 2002:a05:6000:250e:b0:410:9b07:483b with SMTP id
 ffacd0b85a97d-4255d2bb017mr971102f8f.15.1759375701355; 
 Wed, 01 Oct 2025 20:28:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e9762sm1623186f8f.38.2025.10.01.20.28.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 20:28:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v3 1/5] system/ramblock: Remove obsolete comment
Date: Thu,  2 Oct 2025 05:28:08 +0200
Message-ID: <20251002032812.26069-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002032812.26069-1-philmd@linaro.org>
References: <20251002032812.26069-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This comment was added almost 5 years ago in commit 41aa4e9fd84
("ram_addr: Split RAMBlock definition"). Clearly it got ignored:

  $ git grep -l system/ramblock.h
  hw/display/virtio-gpu-udmabuf.c
  hw/hyperv/hv-balloon.c
  hw/virtio/vhost-user.c
  migration/dirtyrate.c
  migration/file.c
  migration/multifd-nocomp.c
  migration/multifd-qatzip.c
  migration/multifd-qpl.c
  migration/multifd-uadk.c
  migration/multifd-zero-page.c
  migration/multifd-zlib.c
  migration/multifd-zstd.c
  migration/multifd.c
  migration/postcopy-ram.c
  system/ram-block-attributes.c
  target/i386/kvm/tdx.c
  tests/qtest/fuzz/generic_fuzz.c

At this point it seems saner to just remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/ramblock.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/system/ramblock.h b/include/system/ramblock.h
index 87e847e184a..8999206592d 100644
--- a/include/system/ramblock.h
+++ b/include/system/ramblock.h
@@ -11,11 +11,6 @@
  *
  */
 
-/*
- * This header is for use by exec.c and memory.c ONLY.  Do not include it.
- * The functions declared here will be removed soon.
- */
-
 #ifndef SYSTEM_RAMBLOCK_H
 #define SYSTEM_RAMBLOCK_H
 
-- 
2.51.0


