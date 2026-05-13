Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F80FCD4851
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 15:27:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNBTx-0005qp-2u; Wed, 13 May 2026 11:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <j.neuschaefer@9elements.com>)
 id 1wNBAs-0007Lg-Qh
 for qemu-devel@nongnu.org; Wed, 13 May 2026 11:07:02 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <j.neuschaefer@9elements.com>)
 id 1wNBAp-0004o4-71
 for qemu-devel@nongnu.org; Wed, 13 May 2026 11:07:01 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so82805455e9.0
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 08:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1778684816; x=1779289616; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=My9t1yQ3RBTsiolupNmLSZbb/0fb6M5VMt5LGJLo5m8=;
 b=HRyuJ86Ka6SLHWveB7sRVyTpfiv7fKqb4SuSwaC7d940V2MIhBLXPIwL/5CQQ2HU9J
 4QR1H3BgMzPLsagj6W/sGDf7nv+ukri49XYRNw+0gXUXuwcAUxamh7uhZ3n0pP1ic4cS
 n80WddMV5hqMGPd1eXTvAbNzW1+GH15waR5zs/SN6GGUdl5Bd1XjDnmtNlcgnM3oDtRH
 mcK/eMDTYk9o5KfYeiuqUU26haH8Ld6fKlLniJPWEtcFTvWN4NgqhEojq0eIEDDucY/E
 OBW4f0s5udijnXolYkmWTl1J+48uE1vTjYe5xyt5ayESxktwG+QdiTEEk8E+unzAdp5G
 6kkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778684816; x=1779289616;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=My9t1yQ3RBTsiolupNmLSZbb/0fb6M5VMt5LGJLo5m8=;
 b=pVduuY0RM0fzF7BhUAdz4lmg9Wxl7rBUp2XTFyd1ZqPKY1bRmTLY6P9PPPICJgH8f2
 Fx3MI6n5I1bAz1S3oGGAPW6jme+qvvzKsCKYRjaLKOrqFKBykzmw3YH6D1I2k5xx9Umo
 BYmjNfo//VTOyGOBrcAi35JlHRyMQA4p9OAqQRaC5m5OYvwLg3eT3qAj9NM/J9YwabvH
 ecVtotIftiMerjI59IZU+0AvbmvVOBLuJPHf2eGswoZEuMkXxZTtKOcxMtrMN2rYa3a9
 1TkNPgLPoG17S7EXJZo45FACCCIIceKPcaO5gSwLc4rOqqxQWr7eabyGXyEVBgsjO3Jq
 O/hg==
X-Gm-Message-State: AOJu0YzkgYmTYJNvmxGl9jnVTou04oiZX/xew1IwE4wQuupAdk2PHh9k
 nnOewykHotP6UyW6mRU//dvzIA/cPJCiIQhV0Ye3ITlT7Y53BFmBIfxn1wwOnsiIgBM=
X-Gm-Gg: Acq92OGAZZSNiKrQsCXoa9M4wYBMZYRf9IxpAvxOakbx1XafhVfeRY4Vp9hdBNPd/H+
 uEFtE6pADyDGYZW/x8nLU0mWAJreaXtfQtsstepHnTHa1hcFc9UMEULJwsOwh97Zo06s+OeahVe
 h2NUnTouAGjkNmCdPXY+JPaDTw8ZZUL9JWJYqW83FarriuqU5nhbxCKZ5tUP4B/DZwYe87eY3NG
 P+qwpDbxst2JofnivwgD4oKDt1XWMAh/fWfeV5j6U0AfqjIgTBX/I/F0oG9YxiQxGIMkIZgIpDP
 xW5kBuZFWMPeXrrwDIWTdG0tHdyp2ygXJWOs6xNHYD+Y8kSS0eXOdUEquoL9i2VUkbLvR0Py7WI
 ZINDLsNSyhQtUbLMsH5cjrhssJ3Tv65fRky4RiRA7LRmpXZ2dMDihjw+ktvBjNep7YNB+j9nULT
 gXpyrU53CIZOdgF8nfofbBdbmySebyd8ACSrigfl5MKF1rr37SzIKXuA/tUQEQVV+w73WrfW3cJ
 Q6r8BtFAzaW77HGEVoBuE/vRuE=
X-Received: by 2002:a05:600c:45cd:b0:489:1ff1:74d3 with SMTP id
 5b1f17b1804b1-48fc9a3abcdmr57148545e9.20.1778684816149; 
 Wed, 13 May 2026 08:06:56 -0700 (PDT)
Received: from [127.0.1.1]
 (2a0a-a54a-ed40-0-9db4-bb9-3f9b-5d0a.ipv6dyn.netcologne.de.
 [2a0a:a54a:ed40:0:9db4:bb9:3f9b:5d0a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fc8d74536sm84562975e9.15.2026.05.13.08.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 08:06:55 -0700 (PDT)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@9elements.com>
Date: Wed, 13 May 2026 17:06:40 +0200
Subject: [PATCH] docs/devel: Fix formatting of `Error **`
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260513-error-v1-1-49fa04bc5c22@9elements.com>
X-B4-Tracking: v=1; b=H4sIAH+TBGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDU0Nj3dSiovwiXTNzkzQL8zSDFGMLQyWg2oKi1LTMCrA50bG1tQC9TLF
 fVwAAAA==
X-Change-ID: 20260513-error-674f87f0d381
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@9elements.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778684815; l=1641;
 i=j.neuschaefer@9elements.com; s=20260513; h=from:subject:message-id;
 bh=j9+BX6VljcD6t2FOsgbZCaYWSkniTu2UUrB14j+SD0U=;
 b=2p7GtFEuTY4y7EcvUq1okqv2+bJx7zYGyFV5iucqNR78NensT//vCdFXjtT50y3dLSeTrdL7B
 cw+Gz5cH8ddAwx5brhXkNgoPD5xjRTtcXXuAMTiqQtOUM6M34IVhKBY
X-Developer-Key: i=j.neuschaefer@9elements.com; a=ed25519;
 pk=mytxDu9ALv0FsWdexvpDMisghxetVpsZ8NdmY/FGsgY=
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=j.neuschaefer@9elements.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 13 May 2026 11:26:43 -0400
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

Since the ReST conversion, Error ** is expressed as Error ``*````*``, which is
rendered in HTML as Error *````*. Fix it so the HTML output resembles the
intended C syntax.

Fixes: 336a7451e8 ("docs: convert README, CODING_STYLE and HACKING to RST syntax")
Signed-off-by: J. Neuschäfer <j.neuschaefer@9elements.com>
---
 docs/devel/style.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/devel/style.rst b/docs/devel/style.rst
index 12e509d10de0b8c044c8429aaaee8855bde1deb5..b8edcf9316f059fe15415543098118b28fcaf99c 100644
--- a/docs/devel/style.rst
+++ b/docs/devel/style.rst
@@ -784,10 +784,10 @@ error, non-negative / -errno, non-null / null, or Error objects.
 Example: when a function returns a non-null pointer on success, and it
 can fail only in one way (as far as the caller is concerned), returning
 null on failure is just fine, and certainly simpler and a lot easier on
-the eyes than propagating an Error object through an Error ``*````*`` parameter.
+the eyes than propagating an Error object through an ``Error **`` parameter.
 
 Example: when a function's callers need to report details on failure
-only the function really knows, use Error ``*````*``, and set suitable errors.
+only the function really knows, use ``Error **``, and set suitable errors.
 
 Do not report an error to the user when you're also returning an error
 for somebody else to handle.  Leave the reporting to the place that

---
base-commit: 45cad8beca3ad75ebe63a36fdc60c98395fd2df1
change-id: 20260513-error-674f87f0d381

Best regards,
-- 
J. Neuschäfer <j.neuschaefer@9elements.com>


