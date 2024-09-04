Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8070FCD484A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 12:47:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slpNK-0003vR-0u; Wed, 04 Sep 2024 08:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1slpNG-0003nc-Im
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:44:39 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1slpNE-0005UF-Ri
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:44:38 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 975242191F;
 Wed,  4 Sep 2024 12:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725453875; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BhCq7dKgVbsaeLH4ffCexHZniHpgK/O1LsShezIDRYo=;
 b=DiPaBbtUTqNfnjGuqq1myGEMZalXX1XMwhX5yTI+tb2EZ+S6sud4MAPwXCwO7cMo2c9EWA
 maZWfLgP1m6cwhfpIRFKfHZrlv109yZ2W3QPgMYTifY7ajbDMXjGjFTvsY7Ixoq+rkzuVU
 7LFdrKcsxiXVuSH1cM+sXGeNnkE7iS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725453875;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BhCq7dKgVbsaeLH4ffCexHZniHpgK/O1LsShezIDRYo=;
 b=equoGoffzwq8gsW3/U3JVT6gbQ6alTCoq4qCUKAFT0kPDLe4w4DHa+q27O9G1ISLJ1NT0b
 CEqZEiLY2/Gl0tDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725453875; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BhCq7dKgVbsaeLH4ffCexHZniHpgK/O1LsShezIDRYo=;
 b=DiPaBbtUTqNfnjGuqq1myGEMZalXX1XMwhX5yTI+tb2EZ+S6sud4MAPwXCwO7cMo2c9EWA
 maZWfLgP1m6cwhfpIRFKfHZrlv109yZ2W3QPgMYTifY7ajbDMXjGjFTvsY7Ixoq+rkzuVU
 7LFdrKcsxiXVuSH1cM+sXGeNnkE7iS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725453875;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BhCq7dKgVbsaeLH4ffCexHZniHpgK/O1LsShezIDRYo=;
 b=equoGoffzwq8gsW3/U3JVT6gbQ6alTCoq4qCUKAFT0kPDLe4w4DHa+q27O9G1ISLJ1NT0b
 CEqZEiLY2/Gl0tDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 38BB0139D2;
 Wed,  4 Sep 2024 12:44:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6E4yADJW2GZuVQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 04 Sep 2024 12:44:34 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 08/34] tests/unit/crypto-tls-x509-helpers: deinit privkey in
 test_tls_cleanup
Date: Wed,  4 Sep 2024 09:43:51 -0300
Message-Id: <20240904124417.14565-9-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240904124417.14565-1-farosas@suse.de>
References: <20240904124417.14565-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.79 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.19)[-0.927];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,linaro.org:email];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

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
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/unit/crypto-tls-x509-helpers.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/unit/crypto-tls-x509-helpers.c b/tests/unit/crypto-tls-x509-helpers.c
index b316155d6a..2daecc416c 100644
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
2.35.3


