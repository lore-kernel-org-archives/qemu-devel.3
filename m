Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4D4C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 14:34:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6UEF-0000Js-8g; Tue, 15 Sep 2026 10:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lipovyjakub@tillia.cz>)
 id 1x6UE1-0000HS-Tx; Tue, 15 Sep 2026 10:33:35 -0400
Received: from m1-out-mua-3.websupport.sk ([2a00:4b40:aaaa:2101:45:13:137:12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lipovyjakub@tillia.cz>)
 id 1x6UDx-0001ir-DV; Tue, 15 Sep 2026 10:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tillia.cz; s=mail;
 t=1789482789; bh=fya4m8FZ+73VVwdPEqK1KAU2N7Dhwr6VIDa7qANCCco=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VEJzNSO4qgEOdle++IaYYqDuATMTUr0YbTpk94vewE5fbZVoKDRcrqA9UroNK5/Xg
 LoXs/yRj7lFC+KgW6j17Cg8q4hBIlHu0UGXrlLhXJsHSvfJHOXbY/+p3L0OmOeQG56
 UbBbkhIzLqQMRus4JzQhGxC+R1I0M5MpFTz20VIfNBo06YxGDryqj+hwLxbP6bpRw8
 KNbX7IhHRNfLAbhHNA9aw40xCjaOJxVy1bSgy3xd8xI8ETNk13CzEkyr7FZp1nKTk1
 aYVzbU7ti+4XG/ThhgY/3USGtheuIQ7odPAPWiRf5ZOfwfyRDb1ImODAX3y5TnYCYw
 fB2J/rvSFn54g==
Received: from m1-u5-ing.websupport.sk (unknown [10.30.5.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by m1-out-mua-3.websupport.sk (Postfix) with ESMTPS id 4hkkyY0MVqz167n;
 Tue, 15 Sep 2026 16:33:09 +0200 (CEST)
X-Authenticated-Sender: lipovyjakub@tillia.cz
Authentication-Results: m1-u5-ing.websupport.sk;
 auth=pass smtp.auth=lipovyjakub@tillia.cz smtp.mailfrom=lipovyjakub@tillia.cz
Received: from cachyos-x8664.docsis.vodafone.cz (unknown
 [IPv6:2a02:830a:f04a:1100::fa50])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: lipovyjakub@tillia.cz)
 by m1-u5-ing.websupport.sk (Postfix) with ESMTPSA id 4hkkyX11PQzsqx;
 Tue, 15 Sep 2026 16:33:07 +0200 (CEST)
From: =?UTF-8?q?Jakub=20Lipov=C3=BD?= <lipovyjakub@tillia.cz>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, qemu-stable@nongnu.org
Subject: Re: [PATCH] target/i386/tcg: raise #GP(0) on null SS load with RPL !=
 CPL
Date: Tue, 15 Sep 2026 16:33:02 +0200
Message-ID: <20260915143302.371691-1-lipovyjakub@tillia.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260818164414.245189-1-lipovyjakub@tillia.cz>
References: <20260818164414.245189-1-lipovyjakub@tillia.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Out-Rspamd-Queue-Id: 4hkkyX11PQzsqx
X-Out-Spamd-Result: default: False [1.40 / 1000.00]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_ZERO(0.00)[0]; BAYES_HAM(0.00)[13.01%];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:16019, ipnet:2a02:8308::/29, country:CZ];
 HAS_X_AS(0.00)[]; SUBJECT_HAS_EXCLAIM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; LOCAL_OUTBOUND(0.00)[];
 TO_DN_NONE(0.00)[]; FROM_HAS_DN(0.00)[]
X-Out-Rspamd-Server: m1-rspamd-out-4
X-Rspamd-Action: no action
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for
 further information)
X-purgate: clean
X-purgate-size: 283
X-purgate-ID: 155908::1789482789-BB39C1FA-BEB61C1D/0/0
Received-SPF: none client-ip=2a00:4b40:aaaa:2101:45:13:137:12;
 envelope-from=lipovyjakub@tillia.cz; helo=m1-out-mua-3.websupport.sk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Ping.

https://lore.kernel.org/qemu-devel/20260818164414.245189-1-lipovyjakub@tillia.cz/

Still applies cleanly to current master (5f664cd3). Re-tested and
all three SS checks in kvm-unit-tests test_sreg() pass under TCG,
while two fail without the patch.

Thanks,
Jakub


