Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF7A9CDDE70
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 11:38:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3ZdE-0007Lp-BT; Wed, 23 Oct 2024 07:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3ZdA-0007JB-EJ
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 07:34:24 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3Zd5-00039f-OT
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 07:34:24 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-539e13375d3so7403434e87.3
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 04:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729683258; x=1730288058; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1qX1H0ILZzPVxOYwNvN6Q27i9glRVOd//mtyRaXauYw=;
 b=NBdbNKBWtJaKwVrYgDEy5W99fHWwFaSDCveYBvMTIX3ATnkBzfGQjkqQ3QjLxBjSzU
 Zw1W1gi7T0nj7atfn+Cm8Mexl7UzYO+DlEbQ+vLTwpiCUmB/cvPop7bhLYq8m4i+CVGJ
 P0zat9HmLcbSK5yYafuaRRviJ9WPZKKIkf742vsInvuST6zBzvNupEN7exUaxaa+BMZN
 XPF02AsRzb79S4c/0k/cprUUM7IbskVZp1ktLT03d0LbmHKi0b0ZmS2jvnq04URPX7R5
 DfpP9DyjLahgZooZx5gQbBkWAe9JhJvmRShqksAvsHTj2Br/w7qyTayR6EtHmoeFPX2x
 inQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729683258; x=1730288058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1qX1H0ILZzPVxOYwNvN6Q27i9glRVOd//mtyRaXauYw=;
 b=c4G/WdE6kYCNgjvDbJSQBQsOR2EndkmboEmGs8ENj8EALgMfVQ5a7WIEjZeKagnFYv
 suCYW3RcUb8xvF8ztR4F4F8EWMHNtqDQ0F9z+q9jXXiFRECHNtz4hrieuRT3NeM86ZFA
 fQA3LA+HF2H/J1aOfWKcAV2GpJaQ2KQX3TwcP5j/7ngDyuhvV9QQKKiA9OaazTGpDgRK
 vOlPpXkWNbCOiW9wpS7d/odYp2vnUUl8oMd3tQbtfXq4KGreGm3aJiEl/UEaXRgzLSty
 hUtuSGlqnzZ2lYKl3Ul4+iXG5mAd7XlqFGhGYOUU+nQrmLfy9FE/UhgOhZHDh4a6FN/S
 Eb6g==
X-Gm-Message-State: AOJu0Yz8/1VD6mZp7z9lRbdNUmIrP5V1D0lODltow/hN431nqU0b7deS
 aV/cAfywE0UBXUf3ihkz915U9yg2KLHVd4YA7mP89YOfaOtZyfjX2XHjde1E5Zo=
X-Google-Smtp-Source: AGHT+IGCC2NM7/OapfZX3EJCxpHGXNk03pm+wXvxRti6xI5ur+3RRTrTJkYiV0qwoYbB5Klb+BmBsg==
X-Received: by 2002:a05:6512:2243:b0:539:530e:9de5 with SMTP id
 2adb3069b0e04-53b1a3a7ae9mr1018902e87.56.1729683257601; 
 Wed, 23 Oct 2024 04:34:17 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912ee061sm464471066b.63.2024.10.23.04.34.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 04:34:16 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 061BA5F9EC;
 Wed, 23 Oct 2024 12:34:08 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 devel@lists.libvirt.org, Marcelo Tosatti <mtosatti@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, kvm@vger.kernel.org,
 Beraldo Leal <bleal@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 11/18] MAINTAINERS: mention my gdbstub/next tree
Date: Wed, 23 Oct 2024 12:33:59 +0100
Message-Id: <20241023113406.1284676-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241023113406.1284676-1-alex.bennee@linaro.org>
References: <20241023113406.1284676-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x133.google.com
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

Make it easy for people to see what is already queued.

Message-Id: <20241022105614.839199-12-alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ef1678a1a8..7eea7b7954 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2984,6 +2984,7 @@ F: gdb-xml/
 F: tests/tcg/multiarch/gdbstub/*
 F: scripts/feature_to_c.py
 F: scripts/probe-gdb-support.py
+T: git https://gitlab.com/stsquad/qemu gdbstub/next
 
 Memory API
 M: Paolo Bonzini <pbonzini@redhat.com>
-- 
2.39.5


