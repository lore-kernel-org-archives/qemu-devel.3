Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9160ACDD556
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 21:11:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr1tV-0005CG-W9; Wed, 18 Sep 2024 17:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sr1tU-00054P-1q
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 17:07:24 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sr1tS-0001da-Cg
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 17:07:23 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5c255e3c327so183596a12.1
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 14:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726693641; x=1727298441; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UmSUHnclueWy8Ml22HesraUXC/kTCDRkeEOTmo3FB50=;
 b=U0a7lhO+52zXIJIdSaS74PFsbu2v/3DDiloB666ehZ9zvlAsvjPOle/oLcWh/cJfDe
 uz8Ta4Yv1yYUfoSwuES/lcevGsYAz08nZ8d1spoVZooKCY93xi0ApPriaqoCx3JqR0uw
 mc8WfPJJH1AuGC1XvSYaj7FS1DVQ31mge8LxkUH8N+WOrPpZKK6g+Geng2DKCupJ83E1
 fGjgTTwI0qNc+4FKYkDqUwSaGhiM2UNlwiGpBkwle8UoACqZHVe1bCdhTJyAzbk8fJwn
 q7zu0cuNt6kTJzAZd8604Fl7kH0UgwSXk8rAG6o1u+YaMmt7+kUkGt4LsIuU94UhTUCw
 QJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726693641; x=1727298441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UmSUHnclueWy8Ml22HesraUXC/kTCDRkeEOTmo3FB50=;
 b=wzLQQdP4GiB6JpJ6J4KJl5H8scNB6mDPixKzBmyJwyw4ytQyqG/EjNSbaJ+RDlRBDX
 AQ/J9/kIR9bu4S5YxiKCXlc9AZGUL+SyLJlq0bBgI91gnLOMaopSluCHgk/oDnEo7bN1
 N+buOwukBTO3EY/Dv0wiE1EqezcFRl252pewBUVFd+kytbt/qKUpKo2BO0NsxUbARBeK
 Fr9B9mAMc+aJ/nNqpWPuUrIzm2WmUyX/O3bKY6+bV/xN9ltUrLdRhvNAVIEQUsakV11X
 ia3suCpGNXOOxamkvGGZkusUjQ4gtYtOW6rYk/P6J+qSq4vzwZcwk91gBdgHt4n9xzLy
 z+ow==
X-Gm-Message-State: AOJu0Yw0dMKDArfOr69huLaqZk0nsXVcVvqRuXulgaI2rFpElCxHHjNT
 gbLwiIaI2souZ13X5WCx84P0hldxgt+PzBx4kTpxOzaWd1kbTDXWXCFSnIzHWkJ+I0Am8FwdOmj
 okmY=
X-Google-Smtp-Source: AGHT+IHKglD4VZubdtombQ7TWRD5KD2sMQek+AkV3m+AYfVCtOIdqGgNUKBO0LaJJn1jGSDbBXRPMg==
X-Received: by 2002:a17:907:1c11:b0:a7a:acae:3415 with SMTP id
 a640c23a62f3a-a90293dbffbmr2470346866b.10.1726693640783; 
 Wed, 18 Sep 2024 14:07:20 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90c39cbceesm19101966b.132.2024.09.18.14.07.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 14:07:16 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 66C115F952;
 Wed, 18 Sep 2024 22:07:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs)
Subject: [PULL 12/18] tests/tcg: ensure s390x-softmmu output redirected
Date: Wed, 18 Sep 2024 22:07:06 +0100
Message-Id: <20240918210712.2336854-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240918210712.2336854-1-alex.bennee@linaro.org>
References: <20240918210712.2336854-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52d.google.com
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

The multiarch system tests output serial data which should be
redirected to the "output" chardev rather than echoed to the console.

Comment the use of EXTFLAGS variable while we are at it.

Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240916085400.1046925-13-alex.bennee@linaro.org>

diff --git a/tests/tcg/s390x/Makefile.softmmu-target b/tests/tcg/s390x/Makefile.softmmu-target
index f60f94b090..be242ba8f1 100644
--- a/tests/tcg/s390x/Makefile.softmmu-target
+++ b/tests/tcg/s390x/Makefile.softmmu-target
@@ -1,6 +1,7 @@
 S390X_SRC=$(SRC_PATH)/tests/tcg/s390x
 VPATH+=$(S390X_SRC)
-QEMU_OPTS+=-action panic=exit-failure -nographic $(EXTFLAGS) -kernel
+# EXTFLAGS can be passed by the user, e.g. to override the --accel
+QEMU_OPTS+=-action panic=exit-failure -nographic -serial chardev:output $(EXTFLAGS) -kernel
 LINK_SCRIPT=$(S390X_SRC)/softmmu.ld
 CFLAGS+=-ggdb -O0
 LDFLAGS=-nostdlib -static
-- 
2.39.5


