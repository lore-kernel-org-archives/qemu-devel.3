Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B85C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 21:05:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgsVR-0000lz-IY; Wed, 21 Aug 2024 17:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sgsVP-0000lW-SE
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 17:04:35 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sgsVO-00026T-B5
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 17:04:35 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B75AA200DA;
 Wed, 21 Aug 2024 21:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724274269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ywm2yb315CLCUqqlwFrDAVwPXP0KbIuUpLsbK7lWudM=;
 b=dEN8VZClciAq4HR3uaLBoL0CFtRpZ7znZJmwe5hyx25QFModBLm6r82l3wOVi0UsZj7iOu
 QFPxVYNrC7reelRk2INUYYmn4gX0awDM6DxcebkYpX52bmBy1tB3LsE+tEFNjZ+I6iMOZU
 pjy8MM3CMwZIx+9RoJGgm/VzjhzI2GY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724274269;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ywm2yb315CLCUqqlwFrDAVwPXP0KbIuUpLsbK7lWudM=;
 b=3yVofMxIlbV1gUKJystWzobXWwgBN94lDODkQNaT26OM96ttUlgCVRzZdoeASI+HEdnUtU
 1xOHzDikOG4/UCAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724274269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ywm2yb315CLCUqqlwFrDAVwPXP0KbIuUpLsbK7lWudM=;
 b=dEN8VZClciAq4HR3uaLBoL0CFtRpZ7znZJmwe5hyx25QFModBLm6r82l3wOVi0UsZj7iOu
 QFPxVYNrC7reelRk2INUYYmn4gX0awDM6DxcebkYpX52bmBy1tB3LsE+tEFNjZ+I6iMOZU
 pjy8MM3CMwZIx+9RoJGgm/VzjhzI2GY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724274269;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ywm2yb315CLCUqqlwFrDAVwPXP0KbIuUpLsbK7lWudM=;
 b=3yVofMxIlbV1gUKJystWzobXWwgBN94lDODkQNaT26OM96ttUlgCVRzZdoeASI+HEdnUtU
 1xOHzDikOG4/UCAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E9D213770;
 Wed, 21 Aug 2024 21:04:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 827CAV1WxmZJLAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 21 Aug 2024 21:04:29 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH for-9.2 3/9] tests/qtest/migration-test: Fix leaks in
 calc_dirtyrate_ready()
In-Reply-To: <20240820144912.320744-4-peter.maydell@linaro.org>
References: <20240820144912.320744-1-peter.maydell@linaro.org>
 <20240820144912.320744-4-peter.maydell@linaro.org>
Date: Wed, 21 Aug 2024 18:04:26 -0300
Message-ID: <87ttfdzixx.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.992]; MIME_GOOD(-0.10)[text/plain];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; MISSING_XM_UA(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, linaro.org:email,
 suse.de:mid, suse.de:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> In calc_dirtyrate_ready() we g_strdup() a string but then never free it:
>
> Direct leak of 19 byte(s) in 2 object(s) allocated from:
>     #0 0x55ead613413e in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/tests/qtest/migration-test+0x22f13e) (BuildId: e7cd5c37b2987a1af682b43ee5240b98bb316737)
>     #1 0x7f7a13d39738 in g_malloc debian/build/deb/../../../glib/gmem.c:128:13
>     #2 0x7f7a13d4e583 in g_strdup debian/build/deb/../../../glib/gstrfuncs.c:361:17
>     #3 0x55ead6266f48 in calc_dirtyrate_ready tests/qtest/migration-test.c:3409:14
>     #4 0x55ead62669fe in wait_for_calc_dirtyrate_complete tests/qtest/migration-test.c:3422:13
>     #5 0x55ead6253df7 in test_vcpu_dirty_limit tests/qtest/migration-test.c:3562:9
>     #6 0x55ead626a407 in migration_test_wrapper tests/qtest/migration-helpers.c:456:5
>
> We also fail to unref the QMP rsp_return, so we leak that also.
>
> Rather than duplicating the string, use the in-place value from
> the qdict, and then unref the qdict.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

