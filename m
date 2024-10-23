Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A85CDDE6E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 11:45:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Zmb-0001vI-Ky; Wed, 23 Oct 2024 07:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3ZmZ-0001us-PB
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 07:44:07 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3ZmY-0004YO-2K
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 07:44:07 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c97c7852e8so7837177a12.1
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 04:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729683844; x=1730288644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7/D/QQxPvGmndZaJy0kEIveJUD+81sSd1CLz3T6BVVI=;
 b=aY4+Z8C7PPtRC9k8VGAb+2YSWyW4ctjbZ8m+pTRzsBYYZJW8L5O/3ZP+NKRFjxbaPz
 DIUJew/v9P7enGWMT2WJu2S4/MFU4PFswfllbKq3R7nCMYVtP5g0TS6Yql40QjndXFvg
 gI1UTqKD0MRjC6Sm8MfRimOfs843YADeTy3/GmrbiMATGRC3Qyr8M/6UGXs3rigdJiKb
 Tmbaijqb+ttE8X380ki5LwmOBtC1kh7gazkOt1tUuFR27b+HcDst8QtjzZfnCaD2undo
 vKnVDFZNNfoZnoHTdiNu14DY2/bkVsso3G4Fyofl5JT7ufugtSiWT2RO+aKxN5z4Gt14
 980g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729683844; x=1730288644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7/D/QQxPvGmndZaJy0kEIveJUD+81sSd1CLz3T6BVVI=;
 b=B7VNKZ/3EF3S1b25un0yZXgCXCCJr1qs3d0RBLCVqjJbiHiAq8DQAjJ4cmhat6aBJY
 Jh5T3tAM3WUOz//U0nfOAleKDeUTKd/5BgVBuUVl2JMzFm5g9Nec+U2M6VLkGdW28dGS
 F5jELDtVACPUsrF08IfWg0Csj/HfztUYFkvyQS8dDqEo2VtfxhA+Dcze3JgGX85By+Fy
 pRQbDmdMJfewlS7M0LdghvO9hqonukevxpI/qsqKT6Bk9P+Y4WOxWtrLgNo9ei19OJCi
 rnhjHzBvhJblkJIimB5QSAByKqVYq6+EUbt1PPcETwrc5mhY30kBEhS8BQXRPUlQr+h6
 pxBw==
X-Gm-Message-State: AOJu0YzwGgAV4oa9LK7Fg8AlgRlEAyvfOCl/8ZqiJ9/ryGjRJFAdTdpT
 rDvMLn4EY/fRBCacgK7qcpFqQucUdbKqWYNYZDenCcxu2gNO4dzDoLA/IOsOH10=
X-Google-Smtp-Source: AGHT+IH3zSM2BlEpP3N6KkqeMBnwOhxkf5fGgndxyFj6xPVN+t2t4+UZ5S+M/nxkFu4HGabpb7TqCA==
X-Received: by 2002:a17:907:9405:b0:a99:ee42:1f38 with SMTP id
 a640c23a62f3a-a9abf8aefbdmr202024366b.31.1729683844062; 
 Wed, 23 Oct 2024 04:44:04 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912edc33sm463333266b.58.2024.10.23.04.44.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 04:44:03 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7FB525FC11;
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
Subject: [PATCH v3 16/18] MAINTAINERS: mention my plugins/next tree
Date: Wed, 23 Oct 2024 12:34:04 +0100
Message-Id: <20241023113406.1284676-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241023113406.1284676-1-alex.bennee@linaro.org>
References: <20241023113406.1284676-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
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

Make it easier to find where plugin patches are being staged.

Message-Id: <20241022105614.839199-17-alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7eea7b7954..5b6c722a20 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3708,6 +3708,7 @@ F: include/tcg/
 
 TCG Plugins
 M: Alex Bennée <alex.bennee@linaro.org>
+T: git https://gitlab.com/stsquad/qemu plugins/next
 R: Alexandre Iooss <erdnaxe@crans.org>
 R: Mahmoud Mandour <ma.mandourr@gmail.com>
 R: Pierrick Bouvier <pierrick.bouvier@linaro.org>
-- 
2.39.5


