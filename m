Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A2CFDEE45
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 19:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFzbS-0001sM-Fp; Thu, 23 Apr 2026 15:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzbJ-0001rp-VY
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:20:38 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzbH-0001ol-OL
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:20:37 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7CCB45BD62;
 Thu, 23 Apr 2026 19:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yxq0LxrbCY14GhKOCjKifdrJXwZdHE2lOdV7GNZfWs4=;
 b=BN71xsWwAQ8pN3eHB7sY+LKBlJ+F55ln1ldFXop2XMh9PB8KKwHROdkqv5zmc8WF+bNsxr
 bn/NJPwjcYN5I+j6rmO9q8DrAWksmBdP/dfAq8jYmGiIBsAN2fggqJpBDddJaJkIW8E/WX
 srUjdmTtfqVEzI8KT5ufJ96NyCpATeE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972027;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yxq0LxrbCY14GhKOCjKifdrJXwZdHE2lOdV7GNZfWs4=;
 b=bjcJ9gfGxKkT9LddZlItAnGUSTEnB04IqfJUgKkTe2VLi+uMHB5hJtIAVuGCAaazz/3oZ1
 rGSOvr5RSJdVYwAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yxq0LxrbCY14GhKOCjKifdrJXwZdHE2lOdV7GNZfWs4=;
 b=BN71xsWwAQ8pN3eHB7sY+LKBlJ+F55ln1ldFXop2XMh9PB8KKwHROdkqv5zmc8WF+bNsxr
 bn/NJPwjcYN5I+j6rmO9q8DrAWksmBdP/dfAq8jYmGiIBsAN2fggqJpBDddJaJkIW8E/WX
 srUjdmTtfqVEzI8KT5ufJ96NyCpATeE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972027;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yxq0LxrbCY14GhKOCjKifdrJXwZdHE2lOdV7GNZfWs4=;
 b=bjcJ9gfGxKkT9LddZlItAnGUSTEnB04IqfJUgKkTe2VLi+uMHB5hJtIAVuGCAaazz/3oZ1
 rGSOvr5RSJdVYwAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4666A593A3;
 Thu, 23 Apr 2026 19:20:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sElHBfpw6mlJCwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 Apr 2026 19:20:26 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 18/43] hw/s390x/css: drop use of .err_hint for vmstate
Date: Thu, 23 Apr 2026 16:19:32 -0300
Message-ID: <20260423191958.1440-19-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260423191958.1440-1-farosas@suse.de>
References: <20260423191958.1440-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

That's the only usage through the whole base. Doesn't
worth keeping the whole complexity. And 2.7 machines were
long ago.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260304212303.667141-17-vsementsov@yandex-team.ru
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 hw/s390x/css.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 04ce3178a0..df5f0bc27f 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -192,10 +192,6 @@ static const VMStateDescription vmstate_schdev_orb = {
 static int subch_dev_post_load(void *opaque, int version_id);
 static int subch_dev_pre_save(void *opaque);
 
-const char err_hint_devno[] = "Devno mismatch, tried to load wrong section!"
-    " Likely reason: some sequences of plug and unplug  can break"
-    " migration for machine versions prior to  2.7 (known design flaw).";
-
 const VMStateDescription vmstate_subch_dev = {
     .name = "s390_subch_dev",
     .version_id = 1,
@@ -203,10 +199,15 @@ const VMStateDescription vmstate_subch_dev = {
     .post_load = subch_dev_post_load,
     .pre_save = subch_dev_pre_save,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT8_EQUAL(cssid, SubchDev, "Bug!"),
-        VMSTATE_UINT8_EQUAL(ssid, SubchDev, "Bug!"),
+        VMSTATE_UINT8_EQUAL(cssid, SubchDev, NULL),
+        VMSTATE_UINT8_EQUAL(ssid, SubchDev, NULL),
         VMSTATE_UINT16(migrated_schid, SubchDev),
-        VMSTATE_UINT16_EQUAL(devno, SubchDev, err_hint_devno),
+        /*
+         * If devno mismatch on target, it may be due to some
+         * sequences of plug and unplug breaks migration for
+         * machine versions prior to 2.7 (known design flaw).
+         */
+        VMSTATE_UINT16_EQUAL(devno, SubchDev, NULL),
         VMSTATE_BOOL(thinint_active, SubchDev),
         VMSTATE_STRUCT(curr_status, SubchDev, 0, vmstate_schib, SCHIB),
         VMSTATE_UINT8_ARRAY(sense_data, SubchDev, 32),
-- 
2.51.0


