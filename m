Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82489C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 13:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHMSX-0000iv-9a; Tue, 20 May 2025 08:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMSV-0000iF-28; Tue, 20 May 2025 08:52:39 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMSS-0000hH-LN; Tue, 20 May 2025 08:52:38 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-30e7bfef27dso3610205a91.0; 
 Tue, 20 May 2025 05:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747745553; x=1748350353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NZx+To6+GeRUeSP4cgenq374zNADHJo0hk3kjG6JK1E=;
 b=iAv5IEFflmrPbvwGwVAqgT8ABtdeJv0LbiTZLHto7MNQxBpG9Ohc89JwEN+8txV6Qv
 SQ7Hihg5Johd51J6smQpvatvle6Qn9q1oX/pkqQZ4pthHDL1m/x7DK/TzBA3UanDLCkF
 yevbcd3gKH6VYISnK5fxdUnKjQnzl/gfkwbb3BvARNbF4rwABuEEhh104MtN45eyNn2I
 sYZXX4rW6REPF0Doe3EMCTwsz6c61U5R886tF5atoYBJRGtNxFyNqRZ+K4FgMgd2+Ay9
 +BYc10h3uvamJTZ0buaMY7yMjuIuio7YtmXZ6VM4ics049E4FkGhVOdGfwVeUvgydHfY
 KoKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747745553; x=1748350353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NZx+To6+GeRUeSP4cgenq374zNADHJo0hk3kjG6JK1E=;
 b=MUhbZg4ubdrw7ve3tXGRkNc4qIXPTVfboORUCFmDMYuLIA7q+64o2jKP1awfePb+An
 fEx3s2wm02XIyaD0782RLKvgSIVSKjkYAnMn0MblYcAWHk9o548EboqCSlN9V4unJ6WD
 wGs8P3CCElFSNPLetwAReZupgsMF9Gp90uw6p1QX0T67Tc/JZTQFNxregaiowmfiYegF
 KweP3wZ5HtwrV1QzYf955zfe9erur9UYJ/Gz10hpBovqI4Z8txrdCjlucCdqPRmqAXb5
 pYF0n6VKtwqGB5+i3z4XyXOjsBq3ozD0aUajvzYCLDNvFd6oR+Ytt+4nvUtDTzP2TmJ9
 adWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1KtyVjyauGZ1S6RUi5LUZ7w4BMFV8tWDDYp88cT8Uyrf93VeJ9Vfr0j8mxuGCU9qQLYJ23knJiVEmVA==@nongnu.org,
 AJvYcCWfIwqEXwbxk8ff+8Uu6gzSklC+v7CaKsgSKNyDaPdRbVlGNjM0RbPKpBaX3ZcC5qHoNTrPsbB81A==@nongnu.org
X-Gm-Message-State: AOJu0YxSNAYMlcDXGxhszIwtZ1/23rY/bCa2E93F5jK3F5gnuFjc9BY/
 YerKyo8Iny2Y6P+15eO6DQn+Xcsz9pIhpkJWJojYZ5m/WhhI0jVILE55rs8gdVAJ
X-Gm-Gg: ASbGncvFPa1x8hLy57Y4o/fTiG79dCWK59mboPLb/w4ITlVYnCIkjbxWIB+HFgOeidL
 vl+JD2mEtTLDKyuviGrEPyvoFgScKxro/a9qk5vel0IHxCG7DsXUx+w5B2NQQJCFwrRFWlnc993
 p+lAlfaJUECmRPVq5G6RFGHYv52jGb4HlHLhKNyFZqXu6RYFiF0w46XRKamvnMIrTa1RUfyRGCe
 0r/3uxCjPpk1OdHHQsKn8cl6ToG6/W3PbtmrRrsIfeMzukwefVwD59Td9Bz4JzQFvQDmtJSJLaC
 kd7Nfbpccr/oUA0dKcYIPXbO2zZ7BtXeb23tNw6ThHvJj6XdZLKonUXSD3EeHw==
X-Google-Smtp-Source: AGHT+IHBlXaJvgNi8ZmIupZbQwe/gK71oK9VqvVg9wYGIpSs4wakRV4DDk3Cz065hGwWCWDovzWzVA==
X-Received: by 2002:a17:90b:574b:b0:30a:5a9a:9fec with SMTP id
 98e67ed59e1d1-30e830c4f3emr25133773a91.7.1747745553046; 
 Tue, 20 May 2025 05:52:33 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:1bde:8310:e993:5dcc])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f36364f9asm1625916a91.4.2025.05.20.05.52.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 05:52:32 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 03/33] meson: Enable to build wasm backend
Date: Tue, 20 May 2025 21:51:05 +0900
Message-ID: <cb60bb4543170eaf2f22ff7cdf206e84f1c80bc5.1747744132.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747744132.git.ktokunaga.mail@gmail.com>
References: <cover.1747744132.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Now that there is a backend for WebAssembly build (/tcg/wasm32/), the
requirement of --enable-tcg-interpreter in meson.build can be removed.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 meson.build | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/meson.build b/meson.build
index ad2053f968..c533243157 100644
--- a/meson.build
+++ b/meson.build
@@ -911,10 +911,6 @@ if have_tcg
     if not get_option('tcg_interpreter')
       error('Unsupported CPU @0@, try --enable-tcg-interpreter'.format(cpu))
     endif
-  elif host_arch == 'wasm32'
-    if not get_option('tcg_interpreter')
-      error('WebAssembly host requires --enable-tcg-interpreter')
-    endif
   elif get_option('tcg_interpreter')
     warning('Use of the TCG interpreter is not recommended on this host')
     warning('architecture. There is a native TCG execution backend available')
-- 
2.43.0


