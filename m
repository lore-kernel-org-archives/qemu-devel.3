Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54FC9D58D5A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 15:22:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFatr-0003zW-6D; Mon, 25 Nov 2024 10:21:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFatn-0003wf-A6
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:21:15 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFatl-0001l0-KU
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:21:15 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-434a044dce2so11246025e9.2
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 07:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732548072; x=1733152872; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bvsNr4Df8dgQwXoKfq/mRwCgqjZY1WDoGHrJ+i24+B8=;
 b=CpN5VYVpMAkNkOJeSnv+92281rCzOrJhmZ04sT8jhb5JReIhrdz/2Y1iB2tqc+qn2P
 PQV+W1p/vYJieLtdz34W/f5NX8RCPNHcG6iEoOZwTAh0MJlhAtGFameoW5tTDpV4f+1c
 8NfemN52NV0WHCiGcagwJ9X3pAuIQTQgG+y1Khqe+lujiysvWuv6G1dNWFwW2hzmH8Kc
 yE9ReGmeeA1mHSUzJZg1JpB/G5klRRNpeycXsiYNlC9vTMy9ntjO3WXcoawrZvTMjd/S
 BEbWPBkG2xtd3WHQGhqG0GnNs6ypMK8yqePFXDYNL0jKOYblDq1JSd1/MN8Hik6L0b33
 WJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732548072; x=1733152872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bvsNr4Df8dgQwXoKfq/mRwCgqjZY1WDoGHrJ+i24+B8=;
 b=ImbJ0CDMkuH9YWfq7ZLAE/8deOqx+EAIzPwTFCOAnPjRZR6rnSAWGAjAZX7NgnLJf6
 mnlV8xWOnai7MHUWAABYgf+9B5pPtVoQRaVLwd0yAavDjfX5Q0USEpTLP+oh9TvHv/9W
 xshAaRVzw8Az7XuZ2ynDtyAr1BAbloPnX5eGkp4d7v5B5o4X2csaHrWTIU1W8PteZwTK
 A3rrncEjhAYV2Knct4VAqkp+DqwEv1z5Vpjo8LQy9UQDo3+FIoC5mkmPhVglT7MnUy9A
 7pLc45gr9+p7fshI20EbOUFIhigd+KUYyrC+yXUM4y1A0Hqx2lToRdPmr5/+XVXeBgc1
 LxNw==
X-Gm-Message-State: AOJu0YwZInhmU6TLfuqOGHLHz+27lCpoguOV1hogVEByH2KoddN33+aN
 MDM8a/mpTQhuwzJJ3KkG4sE9Y42G9vTK81/qK9aTpPtnoWs59knDM6dzR/2OeCE=
X-Gm-Gg: ASbGnctmhouS0Z8bxfvR3jKByS1c/OmwVFUNzvkmELU+P+ZJGQGhn1S3Ld90LQslYPu
 SN7vS3d35763Ul6q/MQtpaZgb6TUBGSkTq2IijLL0auiBI0nhaN2k1im4wOBNiXlWGjG/fPqPd2
 fh3KPebordCBcFDE+MDRtltBGnADapDEYahHoH9n7iYp6Sxfn/ciZJmJuLU6KPpXW/p/CTk29ee
 +KH7UZOJQTcaJnNjkCdq5qcf/v7M1yJsoKzpSUC6DM9R2zk
X-Google-Smtp-Source: AGHT+IGKvs9ll3CoQ/vZrykuDJxyKcih2CGOIVVcEAjwijNtGNnjfcp1Dn7NIbeNIbH4JEQJA7aV3Q==
X-Received: by 2002:a05:600c:28c:b0:434:9f88:a751 with SMTP id
 5b1f17b1804b1-4349f88a8f1mr37445915e9.20.1732548071883; 
 Mon, 25 Nov 2024 07:21:11 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbee043sm10672772f8f.104.2024.11.25.07.21.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 07:21:09 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A1D505F9F7;
 Mon, 25 Nov 2024 15:21:06 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/28] tests/functional: put QEMUMachine logs in testcase log
 directory
Date: Mon, 25 Nov 2024 15:20:46 +0000
Message-Id: <20241125152105.2100395-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241125152105.2100395-1-alex.bennee@linaro.org>
References: <20241125152105.2100395-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

We are not passing the 'log_dir' parameter to QEMUMachine, so the
QEMU stdout/err logs are being placed in a temp directory and thus
deleted after execution. This makes them inaccessible as gitlab
CI artifacts.

Pass the testcase log directory path into QEMUMachine to make the
logs persistent.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20241121154218.1423005-10-berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241121165806.476008-10-alex.bennee@linaro.org>

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index b9418e2ac0..ca13af244b 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -163,10 +163,11 @@ def require_device(self, devicename):
             self.skipTest('no support for device ' + devicename)
 
     def _new_vm(self, name, *args):
-        vm = QEMUMachine(self.qemu_bin, base_temp_dir=self.workdir)
+        vm = QEMUMachine(self.qemu_bin,
+                         base_temp_dir=self.workdir,
+                         log_dir=self.logdir)
         self.log.debug('QEMUMachine "%s" created', name)
         self.log.debug('QEMUMachine "%s" temp_dir: %s', name, vm.temp_dir)
-        self.log.debug('QEMUMachine "%s" log_dir: %s', name, vm.log_dir)
         if args:
             vm.add_args(*args)
         return vm
-- 
2.39.5


