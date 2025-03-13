Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5101C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 03:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsZWX-0004oC-2L; Wed, 12 Mar 2025 23:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZWF-0004hX-KR
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:46:07 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZW1-0007ow-9f
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:46:03 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22349bb8605so10299505ad.0
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 20:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741837548; x=1742442348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xQJ1NmcFNqmUL7WPpAiQ9a6VrBOzjQErSNRAx4ZQM9A=;
 b=QCtYKGWczThnrVO6Jz2Fjz5HqfLHBwTuDUKuPzm/tZgtHx8aeSkFy8XpH9DS3dGjuU
 VyUSrV939lOErNV1IhyWmUyH5GxbMyC8oEJ6EOB7Z/LeaClKyk8A8J8WdyYF2AMBgn9B
 YxTUU0kJpv8/enNHqyB9aArIaxXa7rGtGTt3rjc0mivLMrX2iD42EB1HFfIJ44gn/jtg
 xkqaVWYKxKcc0/spQjETceG1xdTfdAQIfIY5lIOpfKWnFbqaT3ymJLosxHpeq0FPlfd3
 3Grto63RJCoLwSZ7Q8Mdcg13cUsa7sbeYBqBQbvHO9EPDjT02hJv7UyrKzDYdu7Nyc47
 2HRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741837548; x=1742442348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xQJ1NmcFNqmUL7WPpAiQ9a6VrBOzjQErSNRAx4ZQM9A=;
 b=FDriu+K5LvQPOO/3Qmq4yTYI+cOjRY9DsKGx7fHjmyEkW+w6tkQPZw1BvclAZvU79P
 Mlibhe9C9nC/FYAAo5E47YSI8dd1mj7tkxbQWjYnLN4GHXctTPwiLPNtSx+tvP25kH2J
 dI5kBt+QBgByFbDp2xSf2HKc5jlbXKGmVV9chKfZAkdfRHMAqtz2RS8epoN/lVmThFB9
 GdGsxXwk/cQv2kz/QIpvsiOyPD9KrQyyHcdg8Qz+OUTN/otsJjT9jB2koEhXVuQtMn88
 wEiWyK245E39ThdX4TPaNbYdhMnG7lMo6KcSml40JCaSHbiRB/f2sXjrbwUF7Qm0irln
 gYpA==
X-Gm-Message-State: AOJu0YwVr6eAaOZXI7aa/COZyNA7C6iAcDHSF+gqCBbeFiXnq5p9oN3W
 KsNLz+FveDTSSYi/GQNdOEGVte9LfgPSm3fq+Ytj9JZRJuoR82kQRxu61Hx95FNdCRuhTpAdfqX
 b
X-Gm-Gg: ASbGncuhDeJhtXS/VOf4keeDxe7qfeYucr399Y49U8IDBYaWk8+5QdUSG4OtfJ48gZH
 B6Ifigb5qjexJakiIBomEGgWUJ8ZAYa1Pt2Vf1ep+UtMOpZUYgjB6Bu34HQpf+wRHWCbCIcxbGy
 /vx1pESM0JbuTvPCS8Ks9g6gkifJqJkvv7B9DTVq32p4qGirSyca7rVFtTA4hPA14DYnz//+oqZ
 /vdtooIfNIjoe+045t5JgyicT6NaUPXeVdS2FhfYi+iATAQH/Z11zLfw0Qk5wZVSTyi+ff5S6W8
 lKLTE0oJnfKCntUYZAag5Ak8FgVszveTuHvjAaCVJY3Z+AfICNdldOeWCyiGt3xk84wTKpQIZB6
 TdUQiiF4DZKA=
X-Google-Smtp-Source: AGHT+IFBTo9LdUOvx8q3TirVVDC7lCv/1sL0FL0peEQV2cGLkNmIjS7ER51dep0rNIwMSreSkJoRJA==
X-Received: by 2002:a05:6a00:b84:b0:736:3c2f:acdd with SMTP id
 d2e1a72fcca58-736aaa1d9fbmr26021206b3a.14.1741837547927; 
 Wed, 12 Mar 2025 20:45:47 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167def8sm316781b3a.90.2025.03.12.20.45.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 20:45:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	pbonzini@redhat.com,
	philmd@linaro.org
Subject: [PATCH 27/37] system: Move watchpoint.c to libsystem_ss
Date: Wed, 12 Mar 2025 20:45:07 -0700
Message-ID: <20250313034524.3069690-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313034524.3069690-1-richard.henderson@linaro.org>
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Some of the headers used require CONFIG_USER_ONLY.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 system/meson.build | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/system/meson.build b/system/meson.build
index c83d80fa24..2aab3e97f4 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -23,9 +23,12 @@ system_ss.add(files(
   'runstate.c',
   'tpm-hmp-cmds.c',
   'vl.c',
-  'watchpoint.c',
 ), sdl, libpmem, libdaxctl)
 
+libsystem_ss.add(files(
+  'watchpoint.c',
+))
+
 if have_tpm
   system_ss.add(files('tpm.c'))
 endif
-- 
2.43.0


