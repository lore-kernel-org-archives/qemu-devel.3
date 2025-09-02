Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E88A5CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:15:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utQph-0007dC-SN; Tue, 02 Sep 2025 09:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQp4-0006qi-5W
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:13:18 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQp0-0004lA-Lb
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:13:17 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3d48b45f9deso1588398f8f.1
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 06:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756818789; x=1757423589; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xaWoWdLQrpe0mniNwXuP/Tmf92jerlSeexVJq+GCDFA=;
 b=Ol4FU8LNdixk0MyEr3Dmm/Tmr1DSFugVN93Sm4mS2Ap3cZUNcHnV91qs5wog0jbap/
 SA3ple5a+r0t9zNyeZ5alRYCDIZOsrr+q2OLZhoJ2JNApeiTEM2UWZnK1xGId+I3YhqP
 0Ov5hgOykEANXxNHAqQjkEA19OcbwmhHJNo19OR07yepgNQ1NWtFTnaPzvQAOT1LRqdG
 REtssLNkRkjs0D4GXrfKjo5rlSF9roYeXn/SNQYu5w9wYnQ4EdRsEKBpkeAqWKSFDSlV
 GN4tsy0BPe3Ayz4kTg/E3kp7A1KxZe3doLsyNcJ3/8hU3w99W+u2BEIP2hefGmYZ7T99
 z9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756818789; x=1757423589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xaWoWdLQrpe0mniNwXuP/Tmf92jerlSeexVJq+GCDFA=;
 b=k5NPKAgKIMBKA/Ug5gCLO+AdPqtt7ENyvo49jMg/pzcoFx1qPc9R4CZ87rP6wCx0pf
 /UEnTBjRJgSUktQJDl1JlmE9EnxhMNtQIc7lB89EdmLH/8TPukbcgiBUtq3xdlIWH5IS
 xRr8VG6rT84jJSH7tdCL+4GutgPw0ZnRT9xtDhqhAQJX37DuDxdyeisFvoFyslHEDkEO
 XxBl5x/Oy/6Xjk8KMcRP1I1A1AfJ6sO5SEr+FKTknofPv44qd4yw03rCSqG+954Tznx5
 NPSyl4QiFnizdfmRuFxvwQo9OhhvoeoD6thDS9OPRHjyMnbNL7Z7mLBQEolDq69jAi2/
 Rv6A==
X-Gm-Message-State: AOJu0YyvsDOncEDRRin2y5rxIj23rXoWYii/ynLiGjBi3VOJDqL7tGQE
 5IIjJPirAamKAh+m1+ojm2DUBkxGba+kSIRJWs9D2oHLb4zbQ94QBzrpNeAzk28tlWs+3k7lolP
 l1tEk
X-Gm-Gg: ASbGncuW6mIL5WU+czw1hLX1MVlaUdPzDeeF3CrtARscgT1rKsWhS3f8Cwqw41WPgWR
 tmaLYfN4nY8v9EXH8su22cV5x0ti4B7tBg2w1l4yYzorGNDC9CuHi/4guZoomHt/hLePOV73Z9k
 IUZfsXPnWK1pAUVLZztlOOvQqP7B70Z69ppsUamOgVA7EgfSnGSo+5ScLcMl7Jm78WrgwCMVp/B
 powlkVRaU/32bWZu/jXSwtt1qImzGYLLsiANfwyWl8oiPeowQMDRKTfILJR5sVZUY+EK9nKG6Et
 JiA4tce4Y3dWO9vCQjP29QG4GRoDxQ7CpU2stfaYcOBrC7qT+CNAs+fwy9wun2nmAB5YF/Pat3e
 6rSlh22PEb0XgtVtYBfWlbKKRjhpD2pC3tRoSqjVgaBWaSApjOxylC8oAMcUaFMpEELDkcbf68G
 tm3I5+lPg=
X-Google-Smtp-Source: AGHT+IHI1EHQZcEe0Ms+4p+t4sstp7z4I1YT7wqq2a70iGy1ex83HqNaubJrzfoldATNh7zkuojQ4Q==
X-Received: by 2002:a5d:588d:0:b0:3c6:97ae:a574 with SMTP id
 ffacd0b85a97d-3d1dcf57b65mr10208453f8f.24.1756818788955; 
 Tue, 02 Sep 2025 06:13:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b98e77231sm26125375e9.12.2025.09.02.06.13.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Sep 2025 06:13:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/39] docs/about/removed-features: Clarify 'device_add' is
 removed
Date: Tue,  2 Sep 2025 15:10:14 +0200
Message-ID: <20250902131016.84968-38-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131016.84968-1-philmd@linaro.org>
References: <20250902131016.84968-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

All other titles in removed-features.rst mention when
the feature was removed using "removed in". Use that
instead of "since" which we use for when a feature is
deprecated.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20250901113957.17113-1-philmd@linaro.org>
---
 docs/about/removed-features.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index dc3d4eaa2d1..fff781d6b7c 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -730,8 +730,8 @@ Use ``multifd-channels`` instead.
 
 Use ``multifd-compression`` instead.
 
-Incorrectly typed ``device_add`` arguments (since 9.2)
-''''''''''''''''''''''''''''''''''''''''''''''''''''''
+Incorrectly typed ``device_add`` arguments (removed in 9.2)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
 Due to shortcomings in the internal implementation of ``device_add``,
 QEMU used to incorrectly accept certain invalid arguments. Any object
-- 
2.51.0


