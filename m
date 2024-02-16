Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0725DC48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 17:36:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb27f-0000l7-6n; Fri, 16 Feb 2024 12:35:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rb27d-0000kw-6Z
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 12:35:37 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rb27b-0006if-3C
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 12:35:36 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 132AF1FB70;
 Fri, 16 Feb 2024 17:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708104930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ignkvs54nSwAtXD7JzqnyuVKLabSuo46kJe2fIG64QI=;
 b=Af6l2AFeSQdDNbR6tf2UwoXAqEeQAub0DU1GWIH4w0hhccCTffXTySjuab2y/4+UCoJ0F2
 5gFFWX1LnnkMlum/XMiTKq5e5bMsZ9Ik8kBz63KKaCRa/7WQs3V81N0bI9DOFN76D2+75O
 DWNcO7ewawtezmC6/V8UZc9Nw13kRcc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708104930;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ignkvs54nSwAtXD7JzqnyuVKLabSuo46kJe2fIG64QI=;
 b=r1gYm2udOsb/YCBbR0Jn6whtZsWvhMaoiGwrMtXVzI1YDLVYNiQfTATumfu6NnHZv4/XwK
 sisWEYI0DTsmdxDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708104930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ignkvs54nSwAtXD7JzqnyuVKLabSuo46kJe2fIG64QI=;
 b=Af6l2AFeSQdDNbR6tf2UwoXAqEeQAub0DU1GWIH4w0hhccCTffXTySjuab2y/4+UCoJ0F2
 5gFFWX1LnnkMlum/XMiTKq5e5bMsZ9Ik8kBz63KKaCRa/7WQs3V81N0bI9DOFN76D2+75O
 DWNcO7ewawtezmC6/V8UZc9Nw13kRcc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708104930;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ignkvs54nSwAtXD7JzqnyuVKLabSuo46kJe2fIG64QI=;
 b=r1gYm2udOsb/YCBbR0Jn6whtZsWvhMaoiGwrMtXVzI1YDLVYNiQfTATumfu6NnHZv4/XwK
 sisWEYI0DTsmdxDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 92AAC13A39;
 Fri, 16 Feb 2024 17:35:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HiZGFuGcz2ViXgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 16 Feb 2024 17:35:29 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [RFC PATCH 14/14] migration: Fix return-path thread exit
In-Reply-To: <2b7d3773-3cc0-41b1-8dc8-0aff90107771@redhat.com>
References: <20240207133347.1115903-1-clg@redhat.com>
 <20240207133347.1115903-15-clg@redhat.com> <87v86zaxtv.fsf@suse.de>
 <50ca9637-bc18-4002-abc3-52c1bb834038@redhat.com> <87mss2pywv.fsf@suse.de>
 <2b7d3773-3cc0-41b1-8dc8-0aff90107771@redhat.com>
Date: Fri, 16 Feb 2024 14:35:26 -0300
Message-ID: <87sf1s8g81.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Af6l2AFe;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=r1gYm2ud
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 BAYES_HAM(-3.00)[100.00%]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: 132AF1FB70
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

> Hello Fabiano
>
> On 2/14/24 21:35, Fabiano Rosas wrote:
>> C=C3=A9dric Le Goater <clg@redhat.com> writes:
>>=20
>>> Hello Fabiano
>>>
>>> On 2/8/24 14:29, Fabiano Rosas wrote:
>>>> C=C3=A9dric Le Goater <clg@redhat.com> writes:
>>>>
>>>>> In case of error, close_return_path_on_source() can perform a shutdown
>>>>> to exit the return-path thread.  However, in migrate_fd_cleanup(),
>>>>> 'to_dst_file' is closed before calling close_return_path_on_source()
>>>>> and the shutdown fails, leaving the source and destination waiting for
>>>>> an event to occur.
>>>>
>>>> Hi, C=C3=A9dric
>>>>
>>>> Are you sure this is not caused by patch 13?
>>>
>>> It happens with upstream QEMU without any patch.
>>=20
>> I might have taken that "shutdown fails" in the commit message too
>> literaly. Anyway, I have a proposed solution:
>>=20
>> -->8--
>>  From 729aa7b5b7f130f756d41649fdd0862bd2e90430 Mon Sep 17 00:00:00 2001
>> From: Fabiano Rosas <farosas@suse.de>
>> Date: Wed, 14 Feb 2024 16:45:43 -0300
>> Subject: [PATCH] migration: Join the return path thread before releasing
>>   to_dst_file
>> MIME-Version: 1.0
>> Content-Type: text/plain; charset=3DUTF-8
>> Content-Transfer-Encoding: 8bit
>>=20
>> The return path thread might hang at a blocking system call. Before
>> joining the thread we might need to issue a shutdown() on the socket
>> file descriptor to release it. To determine whether the shutdown() is
>> necessary we look at the QEMUFile error.
>>=20
>> Make sure we only clean up the QEMUFile after the return path has been
>> waited for.
>
> Yes. That's the important part.
>
>> This fixes a hang when qemu_savevm_state_setup() produced an error
>> that was detected by migration_detect_error(). That skips
>> migration_completion() so close_return_path_on_source() would get
>> stuck waiting for the RP thread to terminate.
>>=20
>> At migrate_fd_cleanup() I'm keeping the relative order of joining the
>> migration thread and the return path just in case.
>
> That doesn't look necessary.

Indeed. But I don't trust the migration code, it's full of undocumented
dependencies like that.

> What was the reason to join the migration thread only when
> s->to_dst_file is valid ?

I didn't find any explicit reason looking through the history. It seems
we used to rely on to_dst_file before migration_thread_running was
introduced.

I wouldn't mind keeping that 'if' there.

Let's see what Peter thinks about it.


