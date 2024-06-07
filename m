Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F1FC27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 23:52:17 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFeY0-00029s-6N; Fri, 07 Jun 2024 14:42:44 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sFeXz-00029k-AI
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 14:42:43 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sFeXx-00057h-EX
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 14:42:43 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 41AF821B76;
 Fri,  7 Jun 2024 18:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717785758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GNGL8oXbCdvQb4CAy/sr0Kof49gEzXDTRRSTE53rrhQ=;
 b=DWMGgh63Jd2yvkXx+EOs0z3lnGKQaJFK8s1xPb2Kwrh93mj8EwbwBTVUHoKyemrqiILOYS
 Auqs6+8GIc1+7esUp/aVmpTt53/mp6q3QfNBgRaiBT0EyWSj+0KLGzyBwZ7tMv3Hlv8y0W
 /T5tqYpw3TfVEhiLfcPK5R2Qt7Eg/OM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717785758;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GNGL8oXbCdvQb4CAy/sr0Kof49gEzXDTRRSTE53rrhQ=;
 b=nQ39poMSfhXdDArHbUI7CCURkljD9vijs1/GKDvmX+o0VEGZcQN3pA0JRDHO4JWDzzel0f
 29K6atqFG2kxlCCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DWMGgh63;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nQ39poMS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717785758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GNGL8oXbCdvQb4CAy/sr0Kof49gEzXDTRRSTE53rrhQ=;
 b=DWMGgh63Jd2yvkXx+EOs0z3lnGKQaJFK8s1xPb2Kwrh93mj8EwbwBTVUHoKyemrqiILOYS
 Auqs6+8GIc1+7esUp/aVmpTt53/mp6q3QfNBgRaiBT0EyWSj+0KLGzyBwZ7tMv3Hlv8y0W
 /T5tqYpw3TfVEhiLfcPK5R2Qt7Eg/OM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717785758;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GNGL8oXbCdvQb4CAy/sr0Kof49gEzXDTRRSTE53rrhQ=;
 b=nQ39poMSfhXdDArHbUI7CCURkljD9vijs1/GKDvmX+o0VEGZcQN3pA0JRDHO4JWDzzel0f
 29K6atqFG2kxlCCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BACA2133F3;
 Fri,  7 Jun 2024 18:42:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gNQdIJ1UY2ZkWQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 07 Jun 2024 18:42:37 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, Claudio
 Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH v2 18/18] migration/ram: Add direct-io support to
 precopy file migration
In-Reply-To: <Zl9_ZiC6-743ZosG@x1n>
References: <20240523190548.23977-1-farosas@suse.de>
 <20240523190548.23977-19-farosas@suse.de> <Zl9_ZiC6-743ZosG@x1n>
Date: Fri, 07 Jun 2024 15:42:35 -0300
Message-ID: <87y17gwq5g.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[9]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 41AF821B76
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

> On Thu, May 23, 2024 at 04:05:48PM -0300, Fabiano Rosas wrote:
>> We've recently added support for direct-io with multifd, which brings
>> performance benefits, but creates a non-uniform user interface by
>> coupling direct-io with the multifd capability. This means that users
>> cannot keep the direct-io flag enabled while disabling multifd.
>> 
>> Libvirt in particular already has support for direct-io and parallel
>> migration separately from each other, so it would be a regression to
>> now require both options together. It's relatively simple for QEMU to
>> add support for direct-io migration without multifd, so let's do this
>> in order to keep both options decoupled.
>> 
>> We cannot simply enable the O_DIRECT flag, however, because not all IO
>> performed by the migration thread satisfies the alignment requirements
>> of O_DIRECT. There are many small read & writes that add headers and
>> synchronization flags to the stream, which at the moment are required
>> to always be present.
>> 
>> Fortunately, due to fixed-ram migration there is a discernible moment
>> where only RAM pages are written to the migration file. Enable
>> direct-io during that moment.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
> Is anyone going to consume this?  How's the performance?

I don't think we have a pre-determined consumer for this. This came up
in an internal discussion about making the interface simpler for libvirt
and in a thread on the libvirt mailing list[1] about using O_DIRECT to
keep the snapshot data out of the caches to avoid impacting the rest of
the system. (I could have described this better in the commit message,
sorry).

Quoting Daniel:

  "Note the reason for using O_DIRECT is *not* to make saving / restoring
   the guest VM faster. Rather it is to ensure that saving/restoring a VM
   does not trash the host I/O / buffer cache, which will negatively impact
   performance of all the *other* concurrently running VMs."

1- https://lore.kernel.org/r/87sez86ztq.fsf@suse.de

About performance, a quick test on a stopped 30G guest, shows
mapped-ram=on direct-io=on it's 12% slower than mapped-ram=on
direct-io=off.

>
> It doesn't look super fast to me if we need to enable/disable dio in each
> loop.. then it's a matter of whether we should bother, or would it be
> easier that we simply require multifd when direct-io=on.

AIUI, the issue here that users are already allowed to specify in
libvirt the equivalent to direct-io and multifd independent of each
other (bypass-cache, parallel). To start requiring both together now in
some situations would be a regression. I confess I don't know libvirt
code to know whether this can be worked around somehow, but as I said,
it's a relatively simple change from the QEMU side.

Another option which would be for libvirt to keep using multifd, but
make it 1 channel only if --parallel is not specified. That might be
enough to solve the interface issues. Of course, it's a different code
altogether than the usual precopy code that gets executed when
multifd=off, I don't know whether that could be an issue somehow.

