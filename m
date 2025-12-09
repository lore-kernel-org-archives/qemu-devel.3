Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B2DD3B7F3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 20:08:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT3yM-0000wf-91; Tue, 09 Dec 2025 15:06:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vT3yH-0000uM-Kk
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 15:06:06 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vT3yC-0001IP-Up
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 15:06:05 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-42e2e52cc04so2199374f8f.0
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 12:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765310759; x=1765915559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nV8HsfTtIPwCBLUDWBKBG2A2y3njTaM32r0hbYhDIlk=;
 b=Ti6VwvMXohOaTe8DqlJzMmH5gPy41t1QDeLBsBgSkn5FAaYbG0WZiu8RksKO1qmLIe
 M0LlbQGvaDUd6NxVK44uwGO4BJ0kSU0gjyRaDQ1gSlOpIZP+RXbSyeUJ6Y5uJ6yEbAly
 DKI9z69WqJEzjvFts7Tw3K/FdoghIfIyaS+a1elyFs3rAOFRlGB0zXk7sEzeaFrUFa/Z
 IuOp/dVvQdTar8/y4HIv1rcEG+PS8d1MbzVcp9ub1pddlHtjqtaeDBq33oB0wroanezS
 DONmGQhg7sT66tRIUh+1K6HUGmTc7i7fiy10Id8GSVm2qNt5/Nw3zP8q+zwGHRkJc9vA
 sAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765310759; x=1765915559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nV8HsfTtIPwCBLUDWBKBG2A2y3njTaM32r0hbYhDIlk=;
 b=V6AftGirizoztfiTj0cYLNWM+7mOelBb6dwssugb9shaz8a/y38YruXjgo/PaUdprP
 9dw7gAHn4NECF8w/sMULPMrSL0Y/qpVZOz2KkQyyDhIcpZVb76Y2ZVIeYhwo4IbmzFQG
 JWfQ9MhgautznsmrpMV98RgGPKIFS1Flkqgwb0efG3c5l2QsxeU+0XaCV8PsO7AjLWYj
 dvyRqmoq3MXnMeEp5Yd6dHpC+HHc4JTk2itrNpnFZUG++CUsdmM5sKwS2BP12Wx/hQiD
 1ThMY0UgTHTylkW42esfJ9MuI3fZ9vqL24Biqy1eLc7RX50jLLTkJQnS7OiP68Gkxzt7
 C34A==
X-Gm-Message-State: AOJu0YzsHsFmx1eqw7/9v8LyDc6Sgg/HBREfPo93/ODNTruXu99mPisx
 cfR5GQhJZmL/OL96yuNXSDtj5h4OkGl71d1LDPzsy0hQ5O03SmMVHha/H8Jctu6EUsmpyXflVGM
 WyC9BzeQ=
X-Gm-Gg: AY/fxX6JxRbKgswyPfA9M0BLRmOEmX/nxiaM9Kw2S7LO78d3z0LHGS9X4HxAPGUgSFn
 Dymn3+RDa9lNs1rbqQTmdbTnzkuYI6RC1H+nFemOWGrgjeGHNuFWgGPerTw3qyuYpEO9jtGZQFx
 8gT9uSlhMRaZyRKDYzCizsiP3nbSd/Wu9Xl7ipERLdUSyXAKnKrMuwKpi1shZI+Yo8t2NJ8sWg6
 uYZJl7UclmJqK6Vaphz6uIqbqTtyY19SqU/NeklCAaj5ilEqCO3BU8XruXk52zPlhDSCO2XYp2A
 2vHH82BkuHizAsTtediKqyVL+lcVwaxRG9rfKFqmgBWso3vBuQI/o6T9vSGBiUKMYBcDz+ez5Ad
 3ai2VPbKoyGJo6vWW+95VQlbn15JUD6BNJelFrenNGZIcxmfLCYMWmN4YT5JRWZK0S9sggOROvD
 1uZ+/T5O9QhvTa9PTwYwKkhacdrp42YoWDcrAE097RO2SzxqSNkV5OsxD7Eaod
X-Google-Smtp-Source: AGHT+IH2cw0I7SJ8QFCAtnolhyyiDtxvuDawq/k5wAma/6zi8x9yhItqbLibLU6a+hfr+0eSl4HBbg==
X-Received: by 2002:a05:6000:2508:b0:42b:2ac7:7942 with SMTP id
 ffacd0b85a97d-42f89f0fafcmr13391482f8f.5.1765310758675; 
 Tue, 09 Dec 2025 12:05:58 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbff320sm33805663f8f.18.2025.12.09.12.05.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Dec 2025 12:05:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/10] scripts: fix broken error path in modinfo-collect.py
Date: Tue,  9 Dec 2025 21:05:30 +0100
Message-ID: <20251209200537.84097-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251209200537.84097-1-philmd@linaro.org>
References: <20251209200537.84097-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

From: "Denis V. Lunev" <den@openvz.org>

sys.stderr.print is dropped long ago and should not be used. Official
replacement is sys.stderr.write

The problem has been found debugging building on some fancy platform
derived from Debian.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: John Snow <jsnow@redhat.com>
CC: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251203220138.159656-1-den@openvz.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 scripts/modinfo-collect.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/modinfo-collect.py b/scripts/modinfo-collect.py
index 6ebaea989db..db78b16c1f5 100644
--- a/scripts/modinfo-collect.py
+++ b/scripts/modinfo-collect.py
@@ -41,7 +41,7 @@ def main(args):
     for obj in args:
         entry = compile_commands.get(obj, None)
         if not entry:
-            sys.stderr.print('modinfo: Could not find object file', obj)
+            sys.stderr.write(f'modinfo: Could not find object file {obj}')
             sys.exit(1)
         src = entry['file']
         if not src.endswith('.c'):
-- 
2.51.0


