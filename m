Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FFA4F55449
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv62s-00063g-37; Tue, 24 Feb 2026 22:58:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv62r-0005y9-4Q
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:58:41 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv62p-0001kU-KJ
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:58:40 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43638a33157so5771984f8f.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771991917; x=1772596717; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G++ekt1tyxiyUhg7le24RmM1GrxLPzT5JlqPAGDaPjQ=;
 b=BEbZKpUxnkQ+SszyjPC1IPCys7QJrPjSBsE2qh9jllA8konZg+HFteDyWDn9G9I4LD
 Q2cFVjV0qBVTyjtP/IauqaukvBXSs8VU54RUXwTIdj6KafIV8RWVy+50aCt73NsYY2dL
 hpdIOQNe268Tcnmk3xR104oayA6sw0jLnrYqBuQVEuQsX4UMn6imygtGgS/71KpnAk6C
 ERjKkkKOnu828+a0wUHlxkWPv74M4qb99GwQ293eWakv1ODVrRwthjLHYQaUwRmt6FGS
 9+1QTkc2xnL1ZEpLXYy/vMyw89emwWT2oMk9FNnZCY2u5VorQj37QuoPphyKoleHK6W3
 2OjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771991917; x=1772596717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G++ekt1tyxiyUhg7le24RmM1GrxLPzT5JlqPAGDaPjQ=;
 b=cqAmW2K+oS5fp0aMFSfdwqY79J473w8erXSaGUltNTeQlLdVmgAQsEvUglfaQipTdf
 If9etK1MyHY8kBCL/WYpcwHC0iMb7BBlwTlwMP5xasOxz/HGmnh51XCLwOLeznMUxwGB
 EJtzsEyuTMi9qe6KLlxpQiErTfHZ5acGlzw8MbMqUx6I2IG1KGfOPtNJ3emEBE3IIz+W
 I18eE66o9ETAA2PchvzdvlxQDOA69XomAgLolMWFHpqawQSqlaGybeiIOKn8pcK7pJiJ
 t0cqGEhDlmYcOkcxVud8T2NXk51fF3FvqEX+olcbN6sbf7LtKE3nQutjO0f9cqkNJCQ1
 ui/w==
X-Gm-Message-State: AOJu0YwEUlb0KBzCmGWmWCd2h+eqyy8EzMYDVZcx4ogoW/E2on194vyp
 l7KsfVwCuVsYWLsFlBkRkqJ6x/4/ELENBMktA+9NpjxMlJmW5xo3At3WN1OS1ezMWhDGE2QXM0b
 urOjoAd8=
X-Gm-Gg: ATEYQzxKLPEAF+xA3rSrXVWvM5O55CVyKDS0T/TSMr7hdUTifvkYjLdWeNwx4/kjfpg
 5Jxz690kN0VgPK4WkM/T9fUNXunNnbyj710jdKPnjQDIgOmGnRNPmCpKYajO16KHfTLSpDM1SEW
 QKkpWN3jqOph6QFOau63fwyClLDbXplt6kdaAMUXEQPiJ4Ex5dg3V/37DQhGimEdwJVqEHbVz2s
 UcheDvBO99AK3n6wWgcEtfWGEV4hfmR2eGSYkke7eSZ5ronf7kiHElW4E23wHPL7TJBc19SeUo5
 BOJCeIbIGo7aMRf6Ptaz+f8v5iwICFpc0ffWQ7VOaTUdEcOd/H4iULlAiTbHeqXYUFHVQ/vcpRG
 Znag3CIVIsdHPDG//h47T309ouXz+nnXOFYwUJCwr3ZBbd5w9BT8RvurQvtrF+2JSjUNfLJGK9s
 atP88ZqLIhkhMH4tkVttmQXlBW37Fw/WMVq7MnWU0rzxCZSQyxiFW9Ui3r70GgrmxQEyjpxoct
X-Received: by 2002:a05:6000:4283:b0:435:e451:39d4 with SMTP id
 ffacd0b85a97d-4396f17b99emr26735307f8f.44.1771991917426; 
 Tue, 24 Feb 2026 19:58:37 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d3fc12sm28923172f8f.24.2026.02.24.19.58.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Feb 2026 19:58:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 08/11] hw/net: Build stubs once
Date: Wed, 25 Feb 2026 04:57:36 +0100
Message-ID: <20260225035739.42848-9-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225035739.42848-1-philmd@linaro.org>
References: <20260225035739.42848-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Move stubs to the global stub_ss[] source set. These files
are now built once for all binaries, instead of one time
per system binary.

qmp-norocker.c only contains stubs, rename it accordingly.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/net/rocker/{qmp-norocker.c => rocker-stubs.c} | 0
 hw/net/meson.build                               | 3 ++-
 2 files changed, 2 insertions(+), 1 deletion(-)
 rename hw/net/rocker/{qmp-norocker.c => rocker-stubs.c} (100%)

diff --git a/hw/net/rocker/qmp-norocker.c b/hw/net/rocker/rocker-stubs.c
similarity index 100%
rename from hw/net/rocker/qmp-norocker.c
rename to hw/net/rocker/rocker-stubs.c
diff --git a/hw/net/meson.build b/hw/net/meson.build
index 913eaedbc52..4ee09143165 100644
--- a/hw/net/meson.build
+++ b/hw/net/meson.build
@@ -67,7 +67,8 @@ system_ss.add(when: 'CONFIG_ROCKER', if_true: files(
   'rocker/rocker_fp.c',
   'rocker/rocker_of_dpa.c',
   'rocker/rocker_world.c',
-), if_false: files('rocker/qmp-norocker.c'))
+))
+stub_ss.add(files('rocker/rocker-stubs.c'))
 system_ss.add(files('rocker/rocker-hmp-cmds.c'))
 
 subdir('can')
-- 
2.52.0


