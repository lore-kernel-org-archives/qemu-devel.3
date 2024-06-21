Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DCB4C41513
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 17:56:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKiU0-000445-07; Fri, 21 Jun 2024 13:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKiTx-00042Y-Tw
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:55:29 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKiTw-0003gb-9P
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:55:29 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F067C21B40;
 Fri, 21 Jun 2024 17:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718992527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3h9OV1SdhGCz8ynGA79uWbpu/f484+imUaupxHcoFAI=;
 b=o4K74RssZZUn0+/RVxUDzwAZeCA23GhPwgWNzKA/KE+fkGie4PUBeG/8DPt7/+G2dHEZxm
 6lESO1+hywNhmB8v1Bw1T/NpJfRAi9EbZI05jguCNd5fegQzKZQQ0wx3R+PGaUGDIGs7hV
 XX266/KbuZE46dk7HDTuhHroGWo74JE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718992527;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3h9OV1SdhGCz8ynGA79uWbpu/f484+imUaupxHcoFAI=;
 b=7ijQBXW0Q8WWKwKbLu5UliOwDt0WklFNL3web2qBqHhVfruFQJXZZvsq6bd8UM9vEJj8UI
 sl9Escxstdkql5DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718992526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3h9OV1SdhGCz8ynGA79uWbpu/f484+imUaupxHcoFAI=;
 b=qapceGvL1/WDP2oIcazhBHUrYZETI3vJE/83B5JtvJ7q3nZzDwt743NqgGrsE0UnkK6A/9
 S+BOlwd1mBQC3q8Fv8TndxF6j78ZkvJPszHVDcGbDtxMavc6EF5A2k7jnHDSCm/ZQ0wQYU
 7FANij17BzUImG0k2bpOOuFvKUf+zno=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718992526;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3h9OV1SdhGCz8ynGA79uWbpu/f484+imUaupxHcoFAI=;
 b=LvE+syifUHm/yK0z94+FOBLhvnQ55jlocB15k3VHfZzTGClfqTnDxQdGsylxM0UGL68F48
 wEXTE+VejMgJpWCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5304E13AAA;
 Fri, 21 Jun 2024 17:55:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iEaPBo2+dWZNawAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 21 Jun 2024 17:55:25 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PULL 28/28] migration: Remove unused VMSTATE_ARRAY_TEST() macro
Date: Fri, 21 Jun 2024 14:54:34 -0300
Message-Id: <20240621175434.31180-29-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240621175434.31180-1-farosas@suse.de>
References: <20240621175434.31180-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,fujitsu.com:email]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Last use of VMSTATE_ARRAY_TEST() was removed in commit 46baa9007f
("migration/i386: Remove old non-softfloat 64bit FP support"), we
can safely get rid of it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/migration/vmstate.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 294d2d8486..f313f2f408 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -388,16 +388,6 @@ extern const VMStateInfo vmstate_info_qlist;
     .offset     = vmstate_offset_varray(_state, _field, _type),      \
 }
 
-#define VMSTATE_ARRAY_TEST(_field, _state, _num, _test, _info, _type) {\
-    .name         = (stringify(_field)),                              \
-    .field_exists = (_test),                                          \
-    .num          = (_num),                                           \
-    .info         = &(_info),                                         \
-    .size         = sizeof(_type),                                    \
-    .flags        = VMS_ARRAY,                                        \
-    .offset       = vmstate_offset_array(_state, _field, _type, _num),\
-}
-
 #define VMSTATE_SUB_ARRAY(_field, _state, _start, _num, _version, _info, _type) { \
     .name       = (stringify(_field)),                               \
     .version_id = (_version),                                        \
-- 
2.35.3


