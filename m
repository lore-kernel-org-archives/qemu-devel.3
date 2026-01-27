Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F9AFD2F002
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 11:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkhTE-0000oI-Nc; Tue, 27 Jan 2026 06:42:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vkhTD-0000mc-4Y
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 06:42:55 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vkhTA-0003wY-QC
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 06:42:54 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-42fbc305552so4957835f8f.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 03:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769514166; x=1770118966; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S7FtbIpw9fv4HO8VS2xynKFZQVXFUAHvDqSLfFu7v14=;
 b=DT2sdXbUW6KHRFicV9snSgsQJ1/xmWpf7tqQIMmaggHastYD5A12sxS+X7b6tkDIq2
 qjs6UNJjYtKoCsA6A/VoKMAXOKXQcC/hJVfn8yqiuDTwhoudXZ7ZPZADRqQWzPYJGpLo
 YDtrBjEosh+ixHUZhmwWMdWRvvsnPg8aEw5Nw0XaP5z+AZ05lyJ0KTAUs2rwhLU7dpcG
 tfqPqABZDlx3QFzxAS9zaVSlPIan4tBS2atTU+ZZXZPbXQogafgly0JN5zmQQ3Vn85aR
 17S2NIw6hcM3JWRY6ilMIEG7nQ+j8juAgomH7p4SDfw/Yyw7iaDBsEMzoqtvqBgyC/N9
 iuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769514166; x=1770118966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S7FtbIpw9fv4HO8VS2xynKFZQVXFUAHvDqSLfFu7v14=;
 b=i2HIqLEvOaWBS1AflbtvQiqgZdTlzLl360cvcJ1hhxoxq+uhaEWmhK8e5+KddCPvP4
 lHvMj3GMwBvYQM8bKDEzZQTnRN+JOy441HxAjdXql/WlkpDuXVLgNL4S9Gczm9SGnGb3
 HvpHcl2xU4L3HVHSr/nqqq+9yVw6R6b2SLD+8onmL8krJ+6ClYFb2Ob9WsZDpiSp21eB
 o/iyPtOZzbK9KyGA0xpBsVPwPq/W+ymDDZFRDFvY7kT2MZdYttfHEg9usV9+dPDriHKk
 rFYQR7HgD+a1ZVoYAZXOFFS8dkUzEb5l4QnR9m2zcIm16elemq0FNCOigfzPFTxM9A2H
 aMTQ==
X-Gm-Message-State: AOJu0Yw7WTQkRiaML5SQ/tf1gc2w4zcJHgdCU7yUFbYriIEi/gKYLcNl
 CVGfCq4jgfqEEPFXwiFZ1Myfcm7UoyYdY+xtYny2K6f0K20V+qxUQKr73dotKKgRmk8=
X-Gm-Gg: AZuq6aK/CEI5GrXcVT8b5cpJ+TdNO5qC1Ujna2NvazgOrFPLs7iGRiSSoprfDR77ZG6
 gcPpHVrrckQyynzdlZ1dmxeuxsJpYFhCFaviiN1Mqc9AVCRTWBiZ5oBsqAn0oYW4hpa5cHPBBcq
 bIg7WjP4MUWrKFiryseuUeewn6mP2u7XHVki2EJ8MEMMK1YWVrdeV2D+iDY3G5WegvQ2JTpLtqg
 l7KQGz7yOOFUpKQHxYYa8FrrSUfK2jkfRbggcIQkYNuLhn0cMILtKdCZ6rSvbiZEI/YUwvpvYXK
 7LrXfE+vkywHzOs4ZDkX56hje0ru7hSPEluN6bCZumRDS21lUmvqulEVgOU0vjgCEKifR075yec
 x8kHldBqN421QNc4niBGGaYmvkSAijRODc49ss/1ioWPOew6fcx7klv7LTTCSft1opVYitfjVHB
 QkfSge3kuquWZd8c6cEcqreA==
X-Received: by 2002:a05:6000:401e:b0:432:aa5a:3916 with SMTP id
 ffacd0b85a97d-435dd0bded3mr2240152f8f.40.1769514166129; 
 Tue, 27 Jan 2026 03:42:46 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24a8asm37245829f8f.12.2026.01.27.03.42.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 03:42:45 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D72BE5F90A;
 Tue, 27 Jan 2026 11:42:40 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 5/9] MAINTAINERS: add maintainer for docs/
Date: Tue, 27 Jan 2026 11:42:35 +0000
Message-ID: <20260127114240.3009791-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260127114240.3009791-1-alex.bennee@linaro.org>
References: <20260127114240.3009791-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

I would like to help maintaining qemu documentation and I've been
invited by Alex to apply as maintainer.

Files in docs/ that are already maintained will continue to be under
their respective maintainer. The goal here is to have someone that can
help on all other files that don't have an official maintainer.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20260115203529.2713193-1-pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260123145750.1200879-6-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index 0c7a3bf5d51..8c1da08a34e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4512,6 +4512,11 @@ Incompatible changes
 L: devel@lists.libvirt.org
 F: docs/about/deprecated.rst
 
+General Documentation
+M: Pierrick Bouvier <pierrick.bouvier@linaro.org>
+S: Maintained
+F: docs/
+
 Build System
 ------------
 Meson
-- 
2.47.3


