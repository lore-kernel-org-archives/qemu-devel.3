Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F467C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 13:58:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY4u8-00024S-KY; Thu, 08 Feb 2024 08:57:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rY4u2-000249-Ax
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 08:57:22 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rY4u0-0001I9-Hq
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 08:57:22 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3F46922050;
 Thu,  8 Feb 2024 13:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707400637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3okzcNd2pbTzVrJCDw1TuwzJrfbMEn484edIC7mIoB4=;
 b=pNS4nk9WLIZEVqHnCHawXp9vcmqmtl5QNkZboP8r+MQh81eEaKRQIdGLBzV0hk9Zme0R55
 qLvuDq0R6QZgY7rQNudH5P58WXaa8b3/wNhKFdkZz3YDjYqCwlHEkV6Dg8DI3ejdkLke5B
 MPrgR802RqcBp9A0kVxjWzEm5hRjNlo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707400637;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3okzcNd2pbTzVrJCDw1TuwzJrfbMEn484edIC7mIoB4=;
 b=Dd4PwNLJc9OzQXDNecUxAk9zQGshLiFUEXSmxRyiZym58d1jenjNFhzlvWouUOYzSGsKIK
 P9TzeqJLrVTdOhBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707400637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3okzcNd2pbTzVrJCDw1TuwzJrfbMEn484edIC7mIoB4=;
 b=pNS4nk9WLIZEVqHnCHawXp9vcmqmtl5QNkZboP8r+MQh81eEaKRQIdGLBzV0hk9Zme0R55
 qLvuDq0R6QZgY7rQNudH5P58WXaa8b3/wNhKFdkZz3YDjYqCwlHEkV6Dg8DI3ejdkLke5B
 MPrgR802RqcBp9A0kVxjWzEm5hRjNlo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707400637;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3okzcNd2pbTzVrJCDw1TuwzJrfbMEn484edIC7mIoB4=;
 b=Dd4PwNLJc9OzQXDNecUxAk9zQGshLiFUEXSmxRyiZym58d1jenjNFhzlvWouUOYzSGsKIK
 P9TzeqJLrVTdOhBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BEC6313984;
 Thu,  8 Feb 2024 13:57:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id R089IbzdxGVVXgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 08 Feb 2024 13:57:16 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 13/14] migration: Use migrate_has_error() in
 close_return_path_on_source()
In-Reply-To: <fbdb9fbc-c3de-4b0a-be1f-2bed405dfd86@redhat.com>
References: <20240207133347.1115903-1-clg@redhat.com>
 <20240207133347.1115903-14-clg@redhat.com> <87y1bvayu7.fsf@suse.de>
 <fbdb9fbc-c3de-4b0a-be1f-2bed405dfd86@redhat.com>
Date: Thu, 08 Feb 2024 10:57:14 -0300
Message-ID: <87sf23awjp.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.61 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-2.31)[96.76%];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
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

> On 2/8/24 14:07, Fabiano Rosas wrote:
>> C=C3=A9dric Le Goater <clg@redhat.com> writes:
>>=20
>>> close_return_path_on_source() retrieves the migration error from the
>>> the QEMUFile '->to_dst_file' to know if a shutdown is required. This
>>> shutdown is required to exit the return-path thread. However, in
>>> migrate_fd_cleanup(), '->to_dst_file' is cleaned up before calling
>>> close_return_path_on_source() and the shutdown is never performed,
>>> leaving the source and destination waiting for an event to occur.
>>>
>>> Avoid relying on '->to_dst_file' and use migrate_has_error() instead.
>>>
>>> Suggested-by: Peter Xu <peterx@redhat.com>
>>> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
>>> ---
>>>   migration/migration.c | 3 +--
>>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/migration/migration.c b/migration/migration.c
>>> index d5f705ceef4c925589aa49335969672c0d761fa2..5f55af3d7624750ca416c41=
77781241b3e291e5d 100644
>>> --- a/migration/migration.c
>>> +++ b/migration/migration.c
>>> @@ -2372,8 +2372,7 @@ static bool close_return_path_on_source(Migration=
State *ms)
>>>        * cause it to unblock if it's stuck waiting for the destination.
>>>        */
>>>       WITH_QEMU_LOCK_GUARD(&ms->qemu_file_lock) {
>>> -        if (ms->to_dst_file && ms->rp_state.from_dst_file &&
>>> -            qemu_file_get_error(ms->to_dst_file)) {
>>> +        if (migrate_has_error(ms) && ms->rp_state.from_dst_file) {
>>>               qemu_file_shutdown(ms->rp_state.from_dst_file);
>>>           }
>>>       }
>>=20
>> Hm, maybe Peter can help defend this, but this assumes that every
>> function that takes an 'f' and sets the file error also sets
>> migrate_set_error(). I'm not sure we have determined that, have we?
>
> How could we check all the code path ? I agree it is difficult when
> looking at the code :/

It would help if the thing wasn't called 'f' for the most part of the
code to begin with.

Whenever there's a file error at to_dst_file there's the chance that the
rp_state.from_dst_file got stuck. So we cannot ignore the file error.

Would it work if we checked it earlier during cleanup as you did
previously and then set the migration error?

