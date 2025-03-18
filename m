Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8947EC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 10:20:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuU2M-0005ok-EF; Tue, 18 Mar 2025 06:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1tuU1h-0005eq-IK
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 06:18:33 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1tuU1c-0007wt-IA
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 06:18:23 -0400
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
 by smtp-out1.suse.de (Postfix) with ESMTP id 8BF9121A1F
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 10:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1742293093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=SxUJkUqRknIe0+svXO5oIru+3Vn7Y3Sds4rDQzm6iuE=;
 b=BHnA5wrmtl0UY6YWsvNjPR7dJwHADVrE2f/Rk3MYBBuCV/wkoaXo5MGctXkinhvsUCfJLb
 lz99qg0iZx14MavI8+3CLNbQCbielaOojlhVvbzkrjyrcV7F2CgAMxPm/Zbb9g6EM6pinC
 p2gqP5kKendu+mK9e7kShMSMmn5P7bc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1742293093;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=SxUJkUqRknIe0+svXO5oIru+3Vn7Y3Sds4rDQzm6iuE=;
 b=+Fe/Ey9g6upAq7Nba6jn7Tjavge+a1NoVdZIL3ZlNDG+luZ8tNoprUd77xtQaIlyNWIi3l
 dpy1dCu3EyrZWGCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1742293093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=SxUJkUqRknIe0+svXO5oIru+3Vn7Y3Sds4rDQzm6iuE=;
 b=BHnA5wrmtl0UY6YWsvNjPR7dJwHADVrE2f/Rk3MYBBuCV/wkoaXo5MGctXkinhvsUCfJLb
 lz99qg0iZx14MavI8+3CLNbQCbielaOojlhVvbzkrjyrcV7F2CgAMxPm/Zbb9g6EM6pinC
 p2gqP5kKendu+mK9e7kShMSMmn5P7bc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1742293093;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=SxUJkUqRknIe0+svXO5oIru+3Vn7Y3Sds4rDQzm6iuE=;
 b=+Fe/Ey9g6upAq7Nba6jn7Tjavge+a1NoVdZIL3ZlNDG+luZ8tNoprUd77xtQaIlyNWIi3l
 dpy1dCu3EyrZWGCg==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id 7BC6C4A0561; Tue, 18 Mar 2025 11:18:13 +0100 (CET)
From: Andreas Schwab <schwab@suse.de>
To: qemu-devel@nongnu.org
Subject: Generic way to detect qemu linux-user emulation
Date: Tue, 18 Mar 2025 11:18:13 +0100
Message-ID: <mvm1puuiqvu.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.20 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_NO_TLS_LAST(0.10)[]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_ONE(0.00)[1]; MID_RHS_MATCH_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_NONE(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=schwab@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Is there a generic way for a program to detect that is it being run
inside the linux-user emulation?

The purpose for that would be to work around limitations of the
emulation, like CLONE_VFORK being unsupported.  For example, python >=
3.13 needs to avoid using posix_spawn in that case, because the
emulation of CLONE_VFORK as a true fork makes it impossible for it to
report errors back to the parent process.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

