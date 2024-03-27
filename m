Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09344C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 14:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpU8f-0004pQ-KA; Wed, 27 Mar 2024 10:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rpU8d-0004mm-9V
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 10:20:23 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rpU8b-000123-Dh
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 10:20:23 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6ea80de0e97so3420037b3a.2
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 07:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1711549217; x=1712154017; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8StAz2pihx+vhGzAzl18uQsb+6havdLYBPTInod4nVE=;
 b=C8kQJM7RZp3wWuRVFXifA4cmxw7syrdpVsgJd7LeAopH/Ir6RzNtbYij8bZGGTHzL1
 mD0U4sHYOepwKNULyKl+1ISRCGykWwNE/A33dxJ90HsWE7yH9kNg+U0DVjT4Gi8HVQ9p
 9c/hlCqbBvqqgHzOLfcKlAxEp4INLyjVTe1IXkiGE+vBVeP6P+/1Z7ygwhPtEyAKNEbl
 WC0QdBC0uvtLCDMaZB0U2CPBlMsjovxZ1o+rt1niIe2evVCrsjDD6/W4yTxFOU1CEMD0
 56g58DM1GIl2ZicRRQ88VCsBb04RJOmJrPRny0E7rOlXjXSB0r4KkD4V/gwEZTrleCl/
 2iZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711549217; x=1712154017;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8StAz2pihx+vhGzAzl18uQsb+6havdLYBPTInod4nVE=;
 b=vJZ356hJKkrfOjH70HXpDh+abMU+ASFjPGzluATMhYWkhFRUDihFY/sdjfNXLaM744
 FsOPwTvpSBqJTBiiOqm9aF+bcs78JvCzr4dZZjc6kHZ5fQhFzGrhaYDvucCQm4OGOgrc
 71GHuqT8FFbxXSLuneHA5EZBUhkUOZjNLuq50OfrvpZCmKFbeIj3smH/JD6bC2AUr2FT
 c2hxOvekHZ7nmjhjDjqRiuOUCbaCrgKIVq0iaL5SExBpmWMfMl741cCKx+Dk3ziMy9rh
 FHKxwxT0bVAdI9gXiiKoG1gR/ymCKvbetTURPhrcUJ0/bxgLadVUv2+Xm9ceD6nccFBh
 +W7g==
X-Gm-Message-State: AOJu0YxS/TfqPYxdjQ3+zk8MaWzpUlJiXVklVx9I2lzWtFDOVKliMstX
 mrbTWnFxMmzr+62Vt9BHcfbv0I6p+TIVNmiP7Da90vb6nSjQ5M2EQpQC0fwSEDKBY+x+hOVZ7cA
 a
X-Google-Smtp-Source: AGHT+IGqgDbN6G1jq29W7gOuC3CKduShIWpZhXerGLlszLpTgQCLq2ZTlriVrSQbgV7/V94BJiqpaQ==
X-Received: by 2002:a05:6a21:6d8e:b0:1a3:dc59:764a with SMTP id
 wl14-20020a056a216d8e00b001a3dc59764amr104721pzb.37.1711549217477; 
 Wed, 27 Mar 2024 07:20:17 -0700 (PDT)
Received: from grind.. ([177.45.186.241]) by smtp.gmail.com with ESMTPSA id
 fa26-20020a056a002d1a00b006ea7b343877sm7891809pfb.9.2024.03.27.07.20.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 07:20:17 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, alistair.francis@wdc.com, groug@kaod.org,
 peter.maydell@linaro.org, qemu_oss@crudebyte.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 v3 0/2] qtest/virtio-9p-test.c: fix slow tests
Date: Wed, 27 Mar 2024 11:20:09 -0300
Message-ID: <20240327142011.805728-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42d.google.com
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

Hi,

In this new version we took a different approach after the discussions
we had in [1]. The tests are now untouched, and we're addressing the root
cause directly: the fact that we have a single temp dir for all the test
execution in qos-test.

We're now creating and cleaning temp dirs for each individual test by
calling virtio_9p_create_local_test_dir() in the .before callback for
the local 9p tests (assign_9p_local_driver()). In this same callback we
queue the cleanup function that will erase the created temp dir. The
cleanup will run after the test ran successfully.

This approach is similar to what other qtests do (in fact this design was
taken from vhost-user-test.c) so it's not like we're doing something
novel.

I kept the revert of the slow test gate because Gitlab seems to approve
it:

https://gitlab.com/danielhb/qemu/-/pipelines/1229836634

Feel free to take just patch 1 if we're not sure about re-enabling these
tests in Gitlab.


Changes from v3:
- patches 1 to 6: dropped
- patch 1 (new):
  - create and remove temporary dirs on each test
- v2 link: https://mail.gnu.org/archive/html/qemu-devel/2024-03/msg06335.html

[1] https://mail.gnu.org/archive/html/qemu-devel/2024-03/msg06400.html

Daniel Henrique Barboza (2):
  qtest/virtio-9p-test.c: create/remove temp dirs after each test
  qtest/virtio-9p-test.c: remove g_test_slow() gate

 tests/qtest/virtio-9p-test.c | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

-- 
2.44.0


