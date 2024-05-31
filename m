Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB14C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 15:43:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD4OU-00030Q-AA; Fri, 31 May 2024 11:42:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sD4OR-0002yn-Bc
 for qemu-devel@nongnu.org; Fri, 31 May 2024 11:42:12 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sD4OP-00028W-Oh
 for qemu-devel@nongnu.org; Fri, 31 May 2024 11:42:11 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 64E8621C64;
 Fri, 31 May 2024 15:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717170128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AJYtXTYt24/mn4dJgd9wxWWfoogQ3bQQcRsnUVx/RMM=;
 b=CxYdhXsc7gos7nxqHf8IT90DwK1RE/IUc2JfiaJMQLovsabd+L4pLIn6x7DpyD3Y+qttHM
 4bLFzwD9Pe8C6q2m2cA0Oh+Of8aYWvr4l/RA/z07dyjtpYd2zANYJxqSVamd2BueqOCHRf
 L4qDuPgPMmiDQrJwzcTG/EWEfkpzqw8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717170128;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AJYtXTYt24/mn4dJgd9wxWWfoogQ3bQQcRsnUVx/RMM=;
 b=mPaj3HvxXXYtnfNfzaxBuV/8zuKEPybdjwi49c2ARzCAjytceMM8ZVDYh4wAW1+nE+ofLp
 AM1evJoD0LiNqNDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717170128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AJYtXTYt24/mn4dJgd9wxWWfoogQ3bQQcRsnUVx/RMM=;
 b=CxYdhXsc7gos7nxqHf8IT90DwK1RE/IUc2JfiaJMQLovsabd+L4pLIn6x7DpyD3Y+qttHM
 4bLFzwD9Pe8C6q2m2cA0Oh+Of8aYWvr4l/RA/z07dyjtpYd2zANYJxqSVamd2BueqOCHRf
 L4qDuPgPMmiDQrJwzcTG/EWEfkpzqw8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717170128;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AJYtXTYt24/mn4dJgd9wxWWfoogQ3bQQcRsnUVx/RMM=;
 b=mPaj3HvxXXYtnfNfzaxBuV/8zuKEPybdjwi49c2ARzCAjytceMM8ZVDYh4wAW1+nE+ofLp
 AM1evJoD0LiNqNDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E34E6132C2;
 Fri, 31 May 2024 15:42:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jo0lKs/vWWYBDwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 31 May 2024 15:42:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, Claudio
 Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: Re: [PATCH v2 13/18] monitor: fdset: Match against O_DIRECT
In-Reply-To: <Zljyf28LG1YCw9Al@x1n>
References: <20240523190548.23977-1-farosas@suse.de>
 <20240523190548.23977-14-farosas@suse.de> <Zljyf28LG1YCw9Al@x1n>
Date: Fri, 31 May 2024 12:42:05 -0300
Message-ID: <87ikyukmya.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
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

Peter Xu <peterx@redhat.com> writes:

> On Thu, May 23, 2024 at 04:05:43PM -0300, Fabiano Rosas wrote:
>> We're about to enable the use of O_DIRECT in the migration code and
>> due to the alignment restrictions imposed by filesystems we need to
>> make sure the flag is only used when doing aligned IO.
>> 
>> The migration will do parallel IO to different regions of a file, so
>> we need to use more than one file descriptor. Those cannot be obtained
>> by duplicating (dup()) since duplicated file descriptors share the
>> file status flags, including O_DIRECT. If one migration channel does
>> unaligned IO while another sets O_DIRECT to do aligned IO, the
>> filesystem would fail the unaligned operation.
>> 
>> The add-fd QMP command along with the fdset code are specifically
>> designed to allow the user to pass a set of file descriptors with
>> different access flags into QEMU to be later fetched by code that
>> needs to alternate between those flags when doing IO.
>> 
>> Extend the fdset matching to behave the same with the O_DIRECT flag.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
>
> One thing I am confused but totally irrelevant to this specific change.
>
> I wonder why do we need dupfds at all, and why client needs to remove-fd at
> all.

This answer was lost to time.

>
> It's about what would go wrong if qmp client only add-fd, then if it's
> consumed by anything, it gets moved from "fds" list to "dupfds" list.  The
> thing is I don't expect the client should pass over any fd that will not be
> consumed.  Then if it's always consumed, why bother dup() at all, and why
> bother an explicit remove-fd.

With the lack of documentation, I can only imagine the code was
initially written to be more flexible, but we ended up never needing the
extra flexibility. Maybe we could change that transparently in the
future and deprecate qmp_remove_fd(). I'm thinking, even for the
mapped-ram work, we might not need libvirt to call that function ever.

