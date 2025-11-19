Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E56CF31AE
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 11:41:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLgXh-0002xu-Ny; Wed, 19 Nov 2025 06:40:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vLgXa-0002sF-HF
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 06:40:04 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vLgXX-0001tc-Hc
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 06:40:02 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-42b2a0c18caso3521465f8f.1
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 03:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763552398; x=1764157198; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1YqmMzMRunBDIcp1b4LhICk32sLrDKc1hQFUNrPZjR4=;
 b=SvIuQDxWQfq0M297zi1B/bUkZBdrScMbqvVaJaxhTNtqyefPwcOqUUwVgwwzLA+MvI
 YYfl/si4HLjdJavv4KfGFyY0qnDy6VcHanSf5i5HkpexrFsel1we3XTl9Nybtei38wsh
 KIMyW/Qra5e5FCIKFPxC5ztIvv6E20HwOThWCpqR4RTEplMhjB6DvWiSBofRgiEBZi0O
 7Kr+aTB2kqOYi0+d/QztSLH4TRh4N6OJGydx8euaZDxo5EXYpUEqfLsRcasMeJtO7m/I
 MX3jtlilj7FCroUOcFvpGHXNDD/4U8IYIn7WsQ/aBP4x5ex9edJFFKBaQ9tbAJfUZ8xc
 l5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763552398; x=1764157198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1YqmMzMRunBDIcp1b4LhICk32sLrDKc1hQFUNrPZjR4=;
 b=ktqVJVgb+Rkcy213FWUCMXns1Nt3UTJ1QAT4z9m13dgLrSy1GPur8Qrr2uV4Uk+uRQ
 b69C8Tx9LyTjXffjgNWjD7L1/wn2Zng7S8pxt4pXfmDZstGS3r9KS/v40MD/xc63cxTc
 7p7LnZC5mMpqZQ+g8eE+XAukOMwLsmAdyby2WX1u+I42ia/jtCKG/okQl8X3zRPMj37L
 b8utTPsbsclEPGxpcdmK5G5crd+OWI689mJ5iqtfO7aHmTw6/cFGVT3GAOi3ZV0Xzm03
 JPuVtbHHkOhauxlDwHoFQwdTROV9F2ZZAnuIrG1/Bubf9368sVcxBtSS1egrQLJcFHoR
 KY2w==
X-Gm-Message-State: AOJu0YxKIQruR3wTbAOtAL2MfOkO6YMxeg9YZUlHDjzQDnKRCQqTWjm+
 kQ0WnF/IT786BqSS7s5KwS+PDNDut/xLIkKTcObwM1AhLJXUWC6ciP7PfrPlJ6hc9SLa0Gq3Oco
 hievv
X-Gm-Gg: ASbGncu/VaGpFUytyr81rqwefJ0nmTmSi3VTwGIe8VT4poZ9Q/LwEl4kASjgd42Pgk2
 4ODLsi3EMkbOtTrfuCguU18FEsclYO0ApcaUWP3KJfmGtdvBnuJRClkOF+WSR+8aytLWJPMO3l9
 DwR6pEmVpG9nqWKWsei7t2K1rIZlI9HU35u/PiA4Rr0ESzg2UL21T3B3+6W2kXDIqHkV33sU2+V
 iKJJA/mtHjHf0OERSIauOpMSJ6ycZcCwy2rE+t5tfm+hHqUmAnCam9mkZCsOuBy3IoJQglHCUEm
 rizF+4p+0nQiurndvCy0P7pb/xUkKJ7IP2iuutFXHfwgp80UQ9JVXtkrByf09qrrK+fxATjjlhQ
 aYPJc/0Q3zyOE0aOPUSn4oMP7i+Xba5eXV71GRFmkC09yLjiK1UuVnEyvo5apxa1gsIf2ND2BII
 YX4qDffn2WOEFlPODdA61onpD8Fws2Cbfb
X-Google-Smtp-Source: AGHT+IH/buA6yuSj26LxPXMaqcAmdFc4WpnRjEeTfI9B0bFkApD8d4p+laCaIbZpgpBXeB8NumtuSw==
X-Received: by 2002:a5d:5d06:0:b0:42b:3dfb:645c with SMTP id
 ffacd0b85a97d-42b5935df34mr19034342f8f.12.1763552397701; 
 Wed, 19 Nov 2025 03:39:57 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e85627sm39492254f8f.16.2025.11.19.03.39.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 03:39:56 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C2B395F915;
 Wed, 19 Nov 2025 11:39:53 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH 5/9] contrib/gitdm: add University of Tokyo to academic group
Date: Wed, 19 Nov 2025 11:39:48 +0000
Message-ID: <20251119113953.1432303-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251119113953.1432303-1-alex.bennee@linaro.org>
References: <20251119113953.1432303-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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

At least one of Akihiko's KVM forums presentations had University of
Tokyo on it. Let me know if you would rather be added to the
individual contributors.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 contrib/gitdm/group-map-academics | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/gitdm/group-map-academics b/contrib/gitdm/group-map-academics
index 082458e1bde..40865b01cd7 100644
--- a/contrib/gitdm/group-map-academics
+++ b/contrib/gitdm/group-map-academics
@@ -25,3 +25,6 @@ iscas.ac.cn
 
 # Université Grenoble Alpes
 univ-grenoble-alpes.fr
+
+# University of Tokyo
+u-tokyo.ac.jp
-- 
2.47.3


