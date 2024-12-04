Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93352E7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 20:41:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIwA0-0001Am-VP; Wed, 04 Dec 2024 15:39:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIw9y-00019e-LL
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:39:46 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIw9w-0008Gi-CV
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:39:46 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2ee86a1a92dso176258a91.1
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 12:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733344783; x=1733949583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bWdFX19LP1eO2d2hfCa/1XQLyxsvMQu6F75MlNcMwzA=;
 b=ge/e///+wxq+SFLO3GPInmVKFOYHKFPMzi2VigQVzaXHG6yvn7MDjjJsoVdv+HCqQB
 iRWQZfkqHD63xQHOFYJPkuDnAyu9soBIzSAy7S35MA1qLL772SQtiqAm4zkTmyz+b7eL
 hOiW4j+E8eX3F+NPcioHzTGJxNhnYM1K8U0WOAYK/Hb2hHfrh3Dtx0AqJGDBnh2n2MK5
 iql4pP/R/Ay6oIOFWEVBnhqD5HhSKnaybD2frL0fFXq22NtHoqaRF+ONFbyJw2ePFZyl
 CdDuMvLYsXsKHDRg/VDNKwm3PYtqi9HL8sk2zgYsZhNnpdMu0bojUVDMcxE2XnfATDSf
 QEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733344783; x=1733949583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bWdFX19LP1eO2d2hfCa/1XQLyxsvMQu6F75MlNcMwzA=;
 b=frmByc8xXgUXGTO932J5QBkw2NC8XP74WWmsnTKqQn46jv0XXd5suv+tITImO6RX30
 80EXb4mPUsfe7auPea0Sg7OiefDLPmwWkLvFJoPwC2TVUWDiZN+pA5WtzP4Lgd835C4h
 uJkyD6jJWuMZ1xx2saf9vh9+1OxScPJiXIl3cZtP/Cvcz3ef4JztA8OdYDuwX3Az2KKh
 QySKqegvyB8HUVtuM6a2jXt4RfAnbOO1FMPP7LWFpXMJueprIXHI4F5ZVOxWEy+c1HDq
 dADUtLYVq6kq4EPZ1EOOS1MBryi/DmAXrA+KmnmyGDbA104vZa4d6V1jLnwboUQkzmkA
 Ja5Q==
X-Gm-Message-State: AOJu0Yz/J1zVh1QdfqljmsDxiTcuESRimWvc5udKwB9cjPS87fRuxwdO
 LnrIQ5zXzA3ztbyaoqiLV0RjkTDpp5Xd0HT5WmMukyJdgOqlGr4yIHNOI3I3VP+dusBzwRktAXd
 SdDE=
X-Gm-Gg: ASbGnctn2nnSpP4NbCiWcd/TCf/JuxGIlMVKBo6RKhz7LI8YtaH/xnDCr94eQX8WqP2
 YOK1yQsc1Jh+f8wje7BflNit2pvuv8qnicyv0huyG1wTP2rVpmgR3Rmo3k5etkogZcz3q08cvY3
 rhUuYw28rglB3EZ+IXHgY3Wlt7PIkvE+vMATTeR0KveYckXYVYKdv/n8kP5c1aO6dOtPQRJDj7c
 rqhqKk3PMBxh0z9zcfi+xAuGqS4gFZHN4DFjViNlRqeyepO8IiRJsriHcQVMAiVraK6lsHVyVcq
 I5WVkCWq
X-Google-Smtp-Source: AGHT+IFWf0SzDIBLAJnfH7YZv2TaEwYSHxZ2UYlOLQts8I0jREv8crOjC6RP/BVMYZBr7OE79tl4KA==
X-Received: by 2002:a17:90b:3949:b0:2ee:5bc9:75c7 with SMTP id
 98e67ed59e1d1-2ef011e6a98mr10309744a91.5.1733344782750; 
 Wed, 04 Dec 2024 12:39:42 -0800 (PST)
Received: from pc.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ef2700cc6esm1873117a91.21.2024.12.04.12.39.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 12:39:42 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-arm@nongnu.org,
 Troy Lee <leetroy@gmail.com>, Peter Maydell <peter.maydell@linaro.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Steven Lee <steven_lee@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 alex.bennee@linaro.org, Alistair Francis <alistair@alistair23.me>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 2/4] docs/system/arm/fby35: document execute-in-place
 property
Date: Wed,  4 Dec 2024 12:39:10 -0800
Message-Id: <20241204203912.3037515-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241204203912.3037515-1-pierrick.bouvier@linaro.org>
References: <20241204203912.3037515-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1033.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/system/arm/fby35.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/docs/system/arm/fby35.rst b/docs/system/arm/fby35.rst
index bf6da6baa2a..ed9faef363c 100644
--- a/docs/system/arm/fby35.rst
+++ b/docs/system/arm/fby35.rst
@@ -45,3 +45,6 @@ process starts.
     $ screen /dev/tty0 # In a separate TMUX pane, terminal window, etc.
     $ screen /dev/tty1
     $ (qemu) c		   # Start the boot process once screen is setup.
+
+This machine model supports emulation of the boot from the CEO flash device by
+setting option ``execute-in-place``.
-- 
2.39.5


