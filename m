Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9B9C531DC
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 14:51:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgQAn-0005CQ-Bv; Tue, 20 Aug 2024 10:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sgQAk-00051c-36
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 10:49:22 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sgQAh-0006LF-JD
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 10:49:21 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42ab99fb45dso7511415e9.1
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 07:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724165357; x=1724770157; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O5i4Lh15VMGVUspG/5ti46lsCaIByKJK9Dj5Y6QJ2cU=;
 b=gJ/SqTD/QMST3egftsV1OdXgaU75BnsWXNupZqAAt/WzgIWeyYIf8siEhguy84bIGQ
 umdkgtBM0iBO1707OfECIK+0yVIMWS5mOvx4YFdcGiLCUfxOxr2voSqJKujPdSanGqxy
 /Zqst5B/TM5zK0avzxrTKHWif9I9UQvVMO46lFgL6O8FVKjhNIHYAZSkt56nLqdlOTFr
 xSVOPN+OfGHDbg/joQktnOXc9XLsKive1ihqD5e+lwlGwcR9DxIRW2D9pxtMQ8Fn8f4Z
 Eh45Kqpnq49kwGCU/xJy7pluAtGm8h+Rr4IraSqoSmYRCwVTqOTrXb46TQcTVtJgusg0
 2Nsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724165357; x=1724770157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O5i4Lh15VMGVUspG/5ti46lsCaIByKJK9Dj5Y6QJ2cU=;
 b=aczExRZkrX1CZCaNj3eFox7hEOOE683MrY1sp4MYqHXAeV/cUCl1krUsoQpl3c1ZTI
 3mQ2bD6pdDHaRPNLeRwQoEdRzHBiq3ek5QD3vn/i+4SyUwuNNHmerKONJb/yqHNOITos
 hDzGPfirtJYn612vRK09Oi5ZPdgvBpF16tA8L7afGt9A+NLqCvk//2GyyOhw4yDqhlnH
 lFCOjSPZ8AH32utS7nQL9YHrMOUh8TBT8OVXa7mI/YxwKY4RzQVE1qCI79s/nk8/OpS9
 /uPcctLHSY5BAfeBz+GlPdP9KBXs0EaS6YSxPRwaJkKR/tTczFDz1DyjeQeLlvu4noDe
 Pqig==
X-Gm-Message-State: AOJu0Ywb8H3uIPENUAZIUNRvFlC9lEXuuzgdi9v8tSsmkq8PfDVjZwS1
 tfrp91gmeQ0v3E/OUJjvKgqXtCsCLHNey7PRag64GFvtH1LyMo3s4SKgCVJAz5U7rtHdwiwU3UG
 G
X-Google-Smtp-Source: AGHT+IEFiGJzLbHmY3enIPgbXkb2E3zZx3pqW3wM0BgJ71z2cXb5dFWeEPoAq6hapB+x5/c8oRQZlQ==
X-Received: by 2002:adf:e907:0:b0:371:8e24:1191 with SMTP id
 ffacd0b85a97d-371946a4455mr11251605f8f.53.1724165356986; 
 Tue, 20 Aug 2024 07:49:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3718983a306sm13334672f8f.15.2024.08.20.07.49.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 07:49:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH for-9.2 6/9] tests/unit/crypto-tls-x509-helpers: deinit
 privkey in test_tls_cleanup
Date: Tue, 20 Aug 2024 15:49:09 +0100
Message-Id: <20240820144912.320744-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240820144912.320744-1-peter.maydell@linaro.org>
References: <20240820144912.320744-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We create a gnutls_x509_privkey_t in test_tls_init(), but forget
to deinit it in test_tls_cleanup(), resulting in leaks
reported in hte migration test such as:

Indirect leak of 8 byte(s) in 1 object(s) allocated from:
    #0 0x55fa6d11c12e in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/tests/qtest/migration-test+0x22f12e) (BuildId: 852a267993587f557f50e5715f352f43720077ba)
    #1 0x7f073982685d in __gmp_default_allocate (/lib/x86_64-linux-gnu/libgmp.so.10+0xa85d) (BuildId: f110719303ddbea25a5e89ff730fec520eed67b0)
    #2 0x7f0739836193 in __gmpz_realloc (/lib/x86_64-linux-gnu/libgmp.so.10+0x1a193) (BuildId: f110719303ddbea25a5e89ff730fec520eed67b0)
    #3 0x7f0739836594 in __gmpz_import (/lib/x86_64-linux-gnu/libgmp.so.10+0x1a594) (BuildId: f110719303ddbea25a5e89ff730fec520eed67b0)
    #4 0x7f07398a91ed in nettle_mpz_set_str_256_u (/lib/x86_64-linux-gnu/libhogweed.so.6+0xb1ed) (BuildId: 3cc4a3474de72db89e9dcc93bfb95fe377f48c37)
    #5 0x7f073a146a5a  (/lib/x86_64-linux-gnu/libgnutls.so.30+0x131a5a) (BuildId: 97b8f99f392f1fd37b969a7164bcea884e23649b)
    #6 0x7f073a07192c  (/lib/x86_64-linux-gnu/libgnutls.so.30+0x5c92c) (BuildId: 97b8f99f392f1fd37b969a7164bcea884e23649b)
    #7 0x7f073a078333  (/lib/x86_64-linux-gnu/libgnutls.so.30+0x63333) (BuildId: 97b8f99f392f1fd37b969a7164bcea884e23649b)
    #8 0x7f073a0e8353  (/lib/x86_64-linux-gnu/libgnutls.so.30+0xd3353) (BuildId: 97b8f99f392f1fd37b969a7164bcea884e23649b)
    #9 0x7f073a0ef0ac in gnutls_x509_privkey_import (/lib/x86_64-linux-gnu/libgnutls.so.30+0xda0ac) (BuildId: 97b8f99f392f1fd37b969a7164bcea884e23649b)
    #10 0x55fa6d2547e3 in test_tls_load_key tests/unit/crypto-tls-x509-helpers.c:99:11
    #11 0x55fa6d25460c in test_tls_init tests/unit/crypto-tls-x509-helpers.c:128:15
    #12 0x55fa6d2495c4 in test_migrate_tls_x509_start_common tests/qtest/migration-test.c:1044:5
    #13 0x55fa6d24c23a in test_migrate_tls_x509_start_reject_anon_client tests/qtest/migration-test.c:1216:12
    #14 0x55fa6d23fb40 in test_precopy_common tests/qtest/migration-test.c:1789:21
    #15 0x55fa6d236b7c in test_precopy_tcp_tls_x509_reject_anon_client tests/qtest/migration-test.c:2614:5

(Oddly, there is no reported leak in the x509 unit tests, even though
those also use test_tls_init() and test_tls_cleanup().)

Deinit the privkey in test_tls_cleanup().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/unit/crypto-tls-x509-helpers.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/unit/crypto-tls-x509-helpers.c b/tests/unit/crypto-tls-x509-helpers.c
index b316155d6a6..2daecc416c6 100644
--- a/tests/unit/crypto-tls-x509-helpers.c
+++ b/tests/unit/crypto-tls-x509-helpers.c
@@ -135,6 +135,7 @@ void test_tls_init(const char *keyfile)
 void test_tls_cleanup(const char *keyfile)
 {
     asn1_delete_structure(&pkix_asn1);
+    gnutls_x509_privkey_deinit(privkey);
     unlink(keyfile);
 }
 
-- 
2.34.1


