Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B87DCD11DD
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 13:26:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp6oj-0006la-U8; Tue, 26 Mar 2024 09:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rp6oi-0006lF-Ef
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:26:16 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rp6og-0002Wj-K6
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:26:16 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6e6ca2ac094so4672242b3a.0
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 06:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1711459572; x=1712064372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XE+lMv11aB5kq2zctqQrthBLckRa56OLg3cLn93mmWY=;
 b=gOCgj15hCrIIsnOB8HQ9LKfIgdfHzYUofR1FBDzTQKKUnLk2P7tzX4YPJDIBs1e2Yd
 1c5OCW+02/Gq8xfr5vn00qXWpJEA2/2kAA7v3S2exaajTL3dvwBHGTVYIZg/Yi5Ju+Fq
 z6aEvlT1vFX3loYEk0M8iYGotWhZTDTctbPXBe0ZNvI8vIqTVIrjSDTwWLnzvvf9WmKe
 YgtiPw4jywu+U6/frnMWmCS86JxUXyvSjnQS8jjgFa6NGv0jo1dAW91Lg6BzhoOTgiC2
 FlDSQerbaurQ9cic8er5QFjYTaHRdkI4+pIsMQGCYPUbuoSUF4sJX9fqa4ziKjZn8ZyM
 jYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711459572; x=1712064372;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XE+lMv11aB5kq2zctqQrthBLckRa56OLg3cLn93mmWY=;
 b=ehbvZUtkwW73vBTrqUDE9PX19tr7xrUx5xnLnRnWGu68MMJAEuIufSh2PqC01UCHkw
 qxBOUbc65mDUWKLWqr3XxpuG1SgO2OTloCJa7IP/OkKwdwSd9MQdWh0zMSUiYLVgNmEc
 eamxJFfSkSZMice8dIFzytK+kc0w2nAlKMcJ41asDiU7EPHs2O7Qwph4Ro3TrpUDukc1
 hFtuvBSkES19iPtyT8RPkTbbR2ov+PvE0ZquR3AIaqjslh8Nqalwe747OIMDLk4ZuVhM
 x6DAUELsy3sTwxTw4jRBdMf+niwadmDQ3XR8iJliA7GkpqFBTIruUyfy6Jx8BTWExxhF
 RaLQ==
X-Gm-Message-State: AOJu0Yx8JQIqTs48IKwGwa0v4ZuhemiaxHpZm6yZBDDEGG+z5zrCApST
 YeVXu+G6BiH+G3wMx1sgXmF4N2sko3fuYIiQV6q1NKiIDKVBdDB8ncBh49/+Pxxo+86jVnDK7OA
 i
X-Google-Smtp-Source: AGHT+IEl2w8WccSBg/3zaKqtN+OCAZPNhSCsD0f80RgFb5fh1m+o3oMrSP2Bx+tYZry7ZalJV9PY9A==
X-Received: by 2002:a05:6a20:3d05:b0:1a3:ae03:1d12 with SMTP id
 y5-20020a056a203d0500b001a3ae031d12mr10928004pzi.53.1711459571794; 
 Tue, 26 Mar 2024 06:26:11 -0700 (PDT)
Received: from grind.. ([177.45.186.241]) by smtp.gmail.com with ESMTPSA id
 v10-20020aa799ca000000b006e9afb31e4bsm6080236pfi.12.2024.03.26.06.26.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 06:26:11 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, alistair.francis@wdc.com, groug@kaod.org,
 peter.maydell@linaro.org, qemu_oss@crudebyte.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 0/3] qtest/virtio-9p-test.c: fix slow tests
Date: Tue, 26 Mar 2024 10:26:03 -0300
Message-ID: <20240326132606.686025-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x431.google.com
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

Thomas reported in [1] a problem that happened with the RISC-V machine
where some tests from virtio-9p-test.c were failing with '-m slow', i.e.
enabling slow tests.

In the end it wasn't a RISC-V specific problem. It just so happens that
the recently added riscv machine nodes runs the tests from
virtio-9p-test two times for each qos-test run: one with the
virtio-9p-device device and another with the virtio-9p-pci. The temp dir
for these tests is being created at the start of qos-test and removed
only at the end of qos-test, and the tests are leaving dirs and files
behind. virtio-9-device tests run first, creates stuff in the temp dir,
then when virtio-9p-pci tests runs again it'll fail because the previous
run left created dirs and files in the same temp dir. Here's a run that
exemplifies the problem:

$ MALLOC_PERTURB_=21 V=2 QTEST_QEMU_BINARY=./qemu-system-riscv64 ./tests/qtest/qos-test -m slow
(...)
# starting QEMU: exec ./qemu-system-riscv64 -qtest unix:/tmp/qtest-621710.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-621710.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -M virt,aclint=on,aia=aplic-imsic -fsdev local,id=fsdev0,path='/home/danielhb/work/qemu/build/qtest-9p-local-7E16K2',security_model=mapped-xattr -device virtio-9p-device,fsdev=fsdev0,mount_tag=qtest -accel qtest
( goes ok ...)
# starting QEMU: exec ./qemu-system-riscv64 -qtest unix:/tmp/qtest-621710.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-621710.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -M virt,aclint=on,aia=aplic-imsic -fsdev local,id=fsdev0,path='/home/danielhb/work/qemu/build/qtest-9p-local-7E16K2',security_model=mapped-xattr -device virtio-9p-pci,fsdev=fsdev0,addr=04.0,mount_tag=qtest -accel qtest
ok 168 /riscv64/virt/generic-pcihost/pci-bus-generic/pci-bus/virtio-9p-pci/virtio-9p/virtio-9p-tests/local/config
Received response 7 (RLERROR) instead of 73 (RMKDIR)
Rlerror has errno 17 (File exists)
**
ERROR:../tests/qtest/libqos/virtio-9p-client.c:275:v9fs_req_recv: assertion failed (hdr.id == id): (7 == 73)

As we can see we're running both 'virtio-9p-device' tests and 'virtio-9p-pci'
tests using the same '/home/danielhb/work/qemu/build/qtest-9p-local-7E16K2'
temp dir. 

The quick fix I came up with was to make each test clean themselves up
after each run. The tests were also consolidated, i.e. fewer tests with the
same coverage, because the 'unlikat' tests were doing the same thing the
'create' tests were doing but removing stuff after. Might as well keep just
the 'unlikat' tests.

I also went ahead and reverted 558f5c42efd ("tests/9pfs: Mark "local"
tests as "slow"") after realizing that the problem I was fixing is also
the same problem that this patch was trying to working around with the
skip [2]. I validated this change in this Gitlab pipeline:

https://gitlab.com/danielhb/qemu/-/pipelines/1227953967

[1] https://mail.gnu.org/archive/html/qemu-devel/2024-03/msg05807.html
[2] https://lists.nongnu.org/archive/html/qemu-devel/2020-11/msg05510.html

Daniel Henrique Barboza (3):
  qtest/virtio-9p-test.c: consolidate create dir, file and symlink tests
  qtest/virtio-9p-test.c: consolidate hardlink tests
  qtest/virtio-9p-test.c: remove g_test_slow() gate

 tests/qtest/virtio-9p-test.c | 155 +++++++++++------------------------
 1 file changed, 48 insertions(+), 107 deletions(-)

-- 
2.44.0


