Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82872D1CDD5
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 10:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3CZ2-0001on-Io; Tue, 22 Oct 2024 06:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3CYw-0001mE-Oh
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:56:30 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3CYu-000237-2k
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:56:30 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c96df52c52so7122067a12.1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 03:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729594586; x=1730199386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dc/d/VIiG49L+/d6qxDj8y/ZsZGo0rIznhJwT5hb3KQ=;
 b=IsYcSQnH04/k5U5ppbVY/Skpb3KOJDJjqmYBnE0oGENHXNon0fldCHHGfqQ7F/sPs6
 eWyQfY+etfDJmXBcCdmPPKKsnlEs9oDS1z2ctQjWu6IfLab7Q3ijslS17Ru3kWCPfeJ3
 JtANSAJUpmtAsSp9cx1Cqq6k9fhJVP+LD0yywzgmrqmFmnF5iUv1IxXkCYG3BP2N2CGM
 K5mDLcWDYkSOUcRxMGHVS8gtfoxZjAZIS06WAKYdTBaZS5r4riOBov3eqzWCyeUtEpF8
 nSUPmGJ051Pa+r16K2bREGuAf05ZbXKtNquh4pkHEIMKGBWzyM4JewzdQ2SDTuQ3MMIr
 ZmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729594586; x=1730199386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dc/d/VIiG49L+/d6qxDj8y/ZsZGo0rIznhJwT5hb3KQ=;
 b=qXP2l6rFbv5M5CJqRYSpK+VUONH0FfdRP+Vo31sJtvRHhj4eIJNqSqTGdlr8g5mmDx
 bpSZvzfQzCPdRfhdy+u89qedKgaKq/I3QldS1ODpL7eD8mE2q4sT0zwGyb5xCP4xFXaB
 z1MM5ZpR8PajuWYWeH7ViwX33rE8Ijd5CRszqIiQSoLDoqnOUwZQgUE4y+YgOCUMNlo0
 SMou4PUEFftjBQ8A0Ti0OfpGpS90dXo2yCbaTczCo5Bq5pWm+1yn/iSYxMpdjbTqm3Bh
 lHfm9jVmY/1hiH3tjgWWM40EwjY+0PKQDqWKPLN5Xym3P2H4TMJOutiqL6awyY7dBOOJ
 A7lg==
X-Gm-Message-State: AOJu0YzrJbeQPxWMQK7CTk7A49Nn2pxXPCAOQd4tne8hCeMmv7yTO2VZ
 UqyRVB04age5uWLW7cxLJ7fmyQcIe4GpUpZxXwv4znPsqiqqAn5znW8AHSFCbIE=
X-Google-Smtp-Source: AGHT+IGl+hAC7xKg+0Mp16pdpeeXIDIYDU6WjhEFWtxxGSyLoudl/zJKvx6zmb4I/Li5Y9q95p5HIQ==
X-Received: by 2002:a05:6402:358a:b0:5c9:85dc:5b9f with SMTP id
 4fb4d7f45d1cf-5ca0ac43593mr11802716a12.2.1729594586471; 
 Tue, 22 Oct 2024 03:56:26 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cb66c737c4sm2963632a12.96.2024.10.22.03.56.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 03:56:19 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 711A35F9DD;
 Tue, 22 Oct 2024 11:56:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, devel@lists.libvirt.org,
 Cleber Rosa <crosa@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 09/20] dockerfiles: fix default targets for
 debian-loongarch-cross
Date: Tue, 22 Oct 2024 11:56:03 +0100
Message-Id: <20241022105614.839199-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241022105614.839199-1-alex.bennee@linaro.org>
References: <20241022105614.839199-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52a.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

fix system target name, and remove --disable-system (which deactivates
system target).

Found using: make docker-test-build@debian-loongarch-cross V=1

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20241020213759.2168248-1-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/debian-loongarch-cross.docker | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-loongarch-cross.docker b/tests/docker/dockerfiles/debian-loongarch-cross.docker
index 79eab5621e..538ab53490 100644
--- a/tests/docker/dockerfiles/debian-loongarch-cross.docker
+++ b/tests/docker/dockerfiles/debian-loongarch-cross.docker
@@ -43,8 +43,8 @@ RUN curl -#SL https://github.com/loongson/build-tools/releases/download/2023.08.
 ENV PATH $PATH:/opt/cross-tools/bin
 ENV LD_LIBRARY_PATH /opt/cross-tools/lib:/opt/cross-tools/loongarch64-unknown-linux-gnu/lib:$LD_LIBRARY_PATH
 
-ENV QEMU_CONFIGURE_OPTS --disable-system --disable-docs --disable-tools
-ENV DEF_TARGET_LIST loongarch64-linux-user,loongarch-softmmu
+ENV QEMU_CONFIGURE_OPTS --disable-docs --disable-tools
+ENV DEF_TARGET_LIST loongarch64-linux-user,loongarch64-softmmu
 ENV MAKE /usr/bin/make
 
 # As a final step configure the user (if env is defined)
-- 
2.39.5


