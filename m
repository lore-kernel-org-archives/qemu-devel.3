Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5143FFEDA1B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 19:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2aJk-0007WX-CR; Tue, 17 Mar 2026 15:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2aJd-0007R8-VH
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:42:59 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2aJa-0007LB-5g
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:42:57 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-35a094cc3e9so4046710a91.3
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 12:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773776572; x=1774381372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j1EkWaHvbsvBNf8xjg+jC92XlcL8wcQLQiGSVioaaEM=;
 b=E3tSDMnEbBxj38pUtpYu/Kx+P7m5cyxn2nJMzg4BGDnak6GmxOH3y48Kv/Icn3k23k
 JVCjN+jz9LTblsf0QxcnaHFFAX20VsYkCXKWCyg5/bTdUZj/mRfarrlGFexWk39AKNty
 qNuSthJk82VdqxvsBucsFlUOiKV90if6aaQlM8VeKkwtbil0mmUJRpJ8eoAQ0cn5Loo5
 j0fqpas6RaApaEqw2tyWWgQHMgPZ+sr0RPjk9ig6pPZawq1CHYDxhqkrvtV2zvfeHzx6
 Rl0bZQtlbGQ5psA+sIJ0c5nckNOSgX8RE1Scqz4K4C9QwLguiNi/9BydZugcgCLliy79
 C+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773776572; x=1774381372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j1EkWaHvbsvBNf8xjg+jC92XlcL8wcQLQiGSVioaaEM=;
 b=k7qoBGVn+b82ws8OZMYLXdjzqMyDepTrY6/ZE/lam4/qA8k6ERAsU0sLeEGxRaclRe
 SM20ohofhpmQrfuAbBWN/gmtd7atEe5TK/36InafsytKMhqoEujGt2BfZ0BJZEj6log9
 8j2SiQV9EItLloQ8kMDVKPzZ2tYI/aPyG80Np5Gcq0rYAvMXkx1orPZMALcl+v0KEdca
 hI8TNfBCJ4me66nY0WImOZpWVyZb16hokcDKEknDYM4cKzcY26NTRcawj4G7DJp7zeAO
 NgJ9AhAM8xspYAs3791FS8xOGy0Ar+E4jSLA8AEtpdz7Z8xT9weY21FanccwdMWuvkjU
 7+Jw==
X-Gm-Message-State: AOJu0YxI1ZeySZkK2ZuHH3HUsMARGi19ujwc5J/iNXCf9T0j9W5rEVTU
 3IhrF83jzxBY8gs9Qd44XwFWker+jHVmoNpySR9aJa4GYRNH96ZKFDwc0bOzlJG7vq6wFU0Y/I5
 PsZbSCFw=
X-Gm-Gg: ATEYQzw4UlH1P06XCMz6L9hFk1I7Lr1OjF7nYzFXNhZj83qOVYVwzRQrWJqX1NBOBqU
 mkH/I6Cuq6zAeeI6FCJxJpl9+yI8bo3kKN3ijQJX6u6vAflt2CgGW8hEQnxQnkPPyQOI0jWwBEB
 hPjeZGSM+WcXOvk/mFYPdgpNBRnHZBTEQItnShXVNHXl5bICf/poTGgQSU9e7xU+9/G+GaAsnXn
 TqIKqmRKrr/P0ZpdttYV0HgO3oAVYhVYdyOnYyqHtrpGQ+GJcai1EkAwy6eYoKMkUHEoo638cF4
 Tfm4mC+3Fj8ynAAusN05FCIY4iVKFGgj069vqpERKOr7KkgIgVfMyVzxxig8gn13Jd5UWBUar5h
 MB8U325QmXcqpfoKfQzebtDf+pom5kcMa2UojjzSKwSv2ikqwKk9WpaFcu73hoPS7wE58rByDzX
 CpH6RpiK0A3+dtZd9FvDmlIBdDEps/4pRpPdMExQPuEiU2R4Hh4H4/W4NwInzr9ZAwGDlPN157N
 WJZ
X-Received: by 2002:a17:90b:2fd0:b0:35b:a170:f266 with SMTP id
 98e67ed59e1d1-35bb9e7f6bcmr554608a91.13.1773776571545; 
 Tue, 17 Mar 2026 12:42:51 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35bba5b8606sm239907a91.14.2026.03.17.12.42.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 12:42:51 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org
Subject: [PATCH v4 8/8] hw/vfio: all vfio files can now be common files
Date: Tue, 17 Mar 2026 12:42:41 -0700
Message-ID: <20260317194241.869568-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260317194241.869568-1-pierrick.bouvier@linaro.org>
References: <20260317194241.869568-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/vfio/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index bab5f2b7f15..fa0ea6ecf0e 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -20,7 +20,7 @@ vfio_ss.add(when: 'CONFIG_VFIO_AP', if_true: files('ap.c'))
 vfio_ss.add(when: 'CONFIG_VFIO_IGD', if_true: files('igd.c'))
 stub_ss.add(files('igd-stubs.c'))
 
-specific_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)
+system_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)
 
 system_ss.add(when: 'CONFIG_VFIO', if_true: files(
   'cpr.c',
-- 
2.47.3


