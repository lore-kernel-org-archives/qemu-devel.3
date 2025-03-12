Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB269C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 13:00:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsLhB-0002gB-J2; Wed, 12 Mar 2025 09:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tsLh5-0002dl-5v
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 09:00:19 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tsLh3-0006SG-4z
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 09:00:18 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22409077c06so38149455ad.1
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 06:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741784415; x=1742389215; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=thLRqmyNL2q9jj0Ig8syz9TBvwKckGPj2ReL/4uzyj8=;
 b=WlRu1tkOEf39D8xs4KubAdsWeSg5V5H9G/b3E0gcXKLomIKOwAzK4L0l5Umaxm/Nhr
 phd2dAZdfPSl5OArX5V+V3kPW54ywcOFtQJgKufw3YEidg6cq6nAGxQx8KcM0KMOVGhh
 QZXPaC0bUI0d+5Y/drPHwKrjW3jZwK9ZXtQQ7C5IOUrKv2pCDc8E0713jzu2qKVLuAc1
 RITM2MoVhTsEj5TCzXFsm6lSlWj7Jv94+QuV/6mPp5GCPueIwHk3Vbje+FVkSxq6dVOO
 cuLeCqXWhITp3mOIsnJwpKoxHpnwCKhzbB2lf0Ru0a0Wc8X/1sEI2X2SvCipltY/PDe8
 f6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741784415; x=1742389215;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=thLRqmyNL2q9jj0Ig8syz9TBvwKckGPj2ReL/4uzyj8=;
 b=Bw6CGjm7SRx7cuaHc8cslWT9s6K20OwGVBGtv2uCxjFSGSBnfcspi/ueYHbijd6ynl
 O+kJdlrgG5cSwFQQZkRf+xDZhw6pTo9Lkwjtym1bJvTculc6K6+23w8q1tt3b/cRGuBh
 AHko7EcBB6HFSmjQeLIbiB1+7xvpJK0osq1DrdoQ0D3Hz33jHXmd2+Yq/ZmxYmDsjjIR
 ABCx1BGrOZLkNzYVB2R4uqGJGyajhNqcGlxDN1Wp7Mm9K2uQoRvpL7Q+0rSPTYQ5eJ/W
 gHM/umLKx8l5izFvUtEZGDKb2E9V+MbxraUyFbsYH4Xn/YjXcUweMKgYm+Lg9bdzOq2N
 P3Ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2UMOi9PR37ftFUC1xnYXWOP2BtKXVPLS18/uc6ntBIHZNLT49L+gOoRiLxHyQayUCjclkwW7RShIh@nongnu.org
X-Gm-Message-State: AOJu0YywddwbdQSBKiNVAfT51HweGqas4+Rc2dxsU1GALYs11sZ9sENM
 71gkr/dmrCN/NWqQBeSL+9EJDVyJBzLI0zX22USL8A0k5INl9/S5
X-Gm-Gg: ASbGncvEPDaXBPqZGlW/iGyimsJ4GZCsMKxPcWbx8hC073pIId9sc72RXu8uT4TAIJb
 R6ZdChdgdkoJ0Ds9DqJViXpEzkg2aX2z0Xcot6i4x/itwFYJo3UI8WwtEKwl89lhOTrlnZRDlnu
 P+6RTQLueQx35LmW6bRK1RW8HVHJSeVMWbBbgQ/Wu3pFYl3NOv16fKssaZ6ko7x/Z/zhALWcjqm
 DuXgUgNOatw42ToFbaJmhlc8zc7W/ENK4Z7CRqKV58HKeMZxFQs9uNPK1ABkiwKmfLn3+gyGEfa
 0sMdmWbOkBY+D8/kfDtsgvVz3uVb7pHv+Of4x3u2S4tkvFnZIso=
X-Google-Smtp-Source: AGHT+IEX4B6k8dLBTIK/Fsb29jbt8L3kq5YibRNvS6TPtbzDXLHSijb6m4BYrhdi9NpEP/BuSfXwtg==
X-Received: by 2002:a62:fb06:0:b0:736:baa0:2acd with SMTP id
 d2e1a72fcca58-736baa02af4mr23736133b3a.20.1741784414686; 
 Wed, 12 Mar 2025 06:00:14 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736bee078fasm8868407b3a.139.2025.03.12.06.00.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 06:00:13 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v3 0/3] tests/functional/asset: improve partial-download
 handling
Date: Wed, 12 Mar 2025 22:59:59 +1000
Message-ID: <20250312130002.945508-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

v2 discussion:

https://lore.kernel.org/qemu-devel/20250312122559.944533-1-npiggin@gmail.com/T/#m9e610343e190d6e65148eb6c9d2e8f4eb8b857b8

Changes since v2:
- Fixed junk in patch 3.
- Add R-B.

Test results for functional-system-debian and -fedora can be seen here:
https://gitlab.com/npiggin/qemu/-/jobs/9387494994
https://gitlab.com/npiggin/qemu/-/jobs/9387495000

Including the short download and retry exceeded failures and skipping
the subtests without failing the entire job.

Thanks,
Nick

Nicholas Piggin (3):
  tests/functional/asset: Fail assert fetch when retries are exceeded
  tests/functional/asset: Verify downloaded size
  tests/functional/asset: Add AssetError exception class

 tests/functional/qemu_test/asset.py | 58 ++++++++++++++++++++++-------
 1 file changed, 44 insertions(+), 14 deletions(-)

-- 
2.47.1


