Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 931DED12D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 07:20:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAOiQ-0000zt-MI; Mon, 11 Nov 2024 02:20:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tAOiD-0000yX-Nx
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 02:19:49 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tAOiB-0004Hk-Mq
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 02:19:49 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-720b2d8bb8dso2965705b3a.1
 for <qemu-devel@nongnu.org>; Sun, 10 Nov 2024 23:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1731309585; x=1731914385;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=V3GVrxnTGGuxLlgaOfzGzVZrbWp6nGr0J5zpj5vNgcw=;
 b=2dgVD09OFNp8PcZwRUIL4S1Vgpd3l5QbpJeiUCsMu9GElG3/+AjhQVQhMIPRmrYxfQ
 bSTr6ij2rorC3K/utgA9IH6WDUjrZuT0369u89z/ib2dfQdZBn/3cGjh9aSTym9iKLfS
 JN84fUvbud2kej47/wzUbxhJPpyodarYTvxi+xT+KyD3NGJ+vi13t/TDnqIK2DFXK1xV
 QcDyFZN43TrYaGqt+ipfJh8XFPs+2kEqvBPywBtaN2O/lTydgGi4yifrsE6d3ZxZK3BL
 QXUJxtfvfT2GDc5Gr7SDgg/xX0MJmrfg2xXZqQlZt+SyOiv0vw8sLZsNZP2YSBTeDxmb
 znow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731309585; x=1731914385;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V3GVrxnTGGuxLlgaOfzGzVZrbWp6nGr0J5zpj5vNgcw=;
 b=F72rkc4AW74eawkpdDD5TMQRajREDIZszm4vMGIQrlwFKqc75kgXvkiZwF/WDlZAS3
 ccewSS0mUtKHTWYSGCPd69NtH0HtquV2/pEnVK7/fXcdox4mrvIVFfbzxmpIcfw0fciD
 X4jPNW55xYfevULTuPCwOMAMIRTZzTKnir+N6HbhVumbXptzzUDeO93+lfj/g0fvpE4l
 lMvOO9H5g7/SfwW3qNScossjKHs24yATO87nDZ6K94q1YB2Z+wqhdF+cEDQOxCAoqyer
 NlPF0dDRZC4bVncMA0O3VKiiV8exYGIn5KE1BgncwIG+FBEtDSEIeIPfbPiu2eobAWBw
 9D9w==
X-Gm-Message-State: AOJu0YzyfB99EmCqsUza+HH6nifPq0dQZMEUb8oxEgdjYGeyTpKX8GSt
 Hmam8+BVC5Ex96zxOnlCX0+wx9HC84CDMnFLOl75g5r9voOMpCU9JdsG6lSCX+Q=
X-Google-Smtp-Source: AGHT+IHXyxsqllKJCiHas8bk8JPMADVoKwIc0xoDBcASC1ICJwrkw8fbxS+sV99bkL8LIfoVH2vxkA==
X-Received: by 2002:a05:6a21:7886:b0:1dc:5e5:ea65 with SMTP id
 adf61e73a8af0-1dc22b60950mr17709436637.34.1731309585459; 
 Sun, 10 Nov 2024 23:19:45 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-72407863dd8sm8603082b3a.26.2024.11.10.23.19.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 Nov 2024 23:19:45 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 11 Nov 2024 16:19:41 +0900
Subject: [PATCH] configure: Use -ef to compare paths
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-p-v1-1-001006c68b7e@daynix.com>
X-B4-Tracking: v=1; b=H4sIAAywMWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDINAt0E22SDRIMU41T0u2MFICqisoSk3LrACbER1bWwsAakzjylMAAAA
 =
To: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

configure checks if it is executed in the source directory by comparing
the literal paths, but there may be multiple representations of a
directory due to symbolic links. Use the -ef operator to tell if they
point to the same directory.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index aa7aae70fa1b..853fa0b81f70 100755
--- a/configure
+++ b/configure
@@ -13,7 +13,7 @@ export CCACHE_RECACHE=yes
 # make source path absolute
 source_path=$(cd "$(dirname -- "$0")"; pwd)
 
-if test "$PWD" = "$source_path"
+if test "$PWD" -ef "$source_path"
 then
     echo "Using './build' as the directory for build output"
 

---
base-commit: 7e3b6d8063f245d27eecce5aabe624b5785f2a77
change-id: 20241111-p-c8a0d3e7fc82

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


