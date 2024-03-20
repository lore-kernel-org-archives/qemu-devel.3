Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40AF6C6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 15:05:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmxVO-0006wH-Ee; Wed, 20 Mar 2024 11:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rmxVM-0006vl-Kd
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 11:05:24 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rmxVH-0006Zt-40
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 11:05:20 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1E4AA34684;
 Wed, 20 Mar 2024 15:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710947117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DDcLYm72HQhutcU6yTV8kxBqGCt+voCwdXLg5XBQnQM=;
 b=GhyxpIpcAvzcfXfAdOH6/0jE4+H/m33Nt8ZA3jhq08YnnzdungIf+84GfusAUkI91fe55r
 yBncfsYxSBvIohbS0LR+p5hK1v8t4C1d6dmxtz0ybdzvxKwIh3NixCur1G7+GudV8MTQUr
 hH7d159NvV9isEoqUFj3YAPPcINsPvs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710947117;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DDcLYm72HQhutcU6yTV8kxBqGCt+voCwdXLg5XBQnQM=;
 b=vO2GSwUZ5xjYmSw3v7KIX4kA+xhPaK63s6GS4MKInTH+4miXVkSo7aaxoRzxhZK07jNeef
 y1vZo5l8Io/u4HBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710947117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DDcLYm72HQhutcU6yTV8kxBqGCt+voCwdXLg5XBQnQM=;
 b=GhyxpIpcAvzcfXfAdOH6/0jE4+H/m33Nt8ZA3jhq08YnnzdungIf+84GfusAUkI91fe55r
 yBncfsYxSBvIohbS0LR+p5hK1v8t4C1d6dmxtz0ybdzvxKwIh3NixCur1G7+GudV8MTQUr
 hH7d159NvV9isEoqUFj3YAPPcINsPvs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710947117;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DDcLYm72HQhutcU6yTV8kxBqGCt+voCwdXLg5XBQnQM=;
 b=vO2GSwUZ5xjYmSw3v7KIX4kA+xhPaK63s6GS4MKInTH+4miXVkSo7aaxoRzxhZK07jNeef
 y1vZo5l8Io/u4HBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C58F136CD;
 Wed, 20 Mar 2024 15:05:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0NiZGCz7+mXzSwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 20 Mar 2024 15:05:16 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Avihai Horon
 <avihaih@nvidia.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus
 Armbruster <armbru@redhat.com>, Prasad Pandit <pjp@fedoraproject.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH for-9.1 v5 14/14] migration: Modify ram_init_bitmaps()
 to report dirty tracking errors
In-Reply-To: <20240320064911.545001-15-clg@redhat.com>
References: <20240320064911.545001-1-clg@redhat.com>
 <20240320064911.545001-15-clg@redhat.com>
Date: Wed, 20 Mar 2024 12:05:14 -0300
Message-ID: <87edc5lz9x.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.29 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-2.99)[99.96%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[9];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Authentication-Results: smtp-out1.suse.de;
	none
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

C=C3=A9dric Le Goater <clg@redhat.com> writes:

> The .save_setup() handler has now an Error** argument that we can use
> to propagate errors reported by the .log_global_start() handler. Do
> that for the RAM. The caller qemu_savevm_state_setup() will store the
> error under the migration stream for later detection in the migration
> sequence.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

