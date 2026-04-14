Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C70C6F9D0DA
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 17:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wChKN-0004CV-83; Tue, 14 Apr 2026 13:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mwilck@suse.com>) id 1wChKA-0004C2-QO
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 13:13:21 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mwilck@suse.com>) id 1wChK8-00044n-UJ
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 13:13:18 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CD7066A7C3;
 Tue, 14 Apr 2026 17:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1776186794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QwrA3UAj9f+hTnysPAZpKWkAifpREUXcbA1pqdPgd30=;
 b=kGi0HNYWoiwPJrpIIrgTWuxiZ9y2t+tcxyT0+dywsa3k4SZ6ToLoTGJFUWHc9s+yyXtIvD
 dfuZA2JkApnack1tpVCHz2f8h1YmV2qvx5/t9/S6KbN1oQT2sLEafij4OAFLKC4cYSWoXh
 4TVN3wH3RbtFtlhdo7XPvy2O34dSPCM=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1776186794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QwrA3UAj9f+hTnysPAZpKWkAifpREUXcbA1pqdPgd30=;
 b=kGi0HNYWoiwPJrpIIrgTWuxiZ9y2t+tcxyT0+dywsa3k4SZ6ToLoTGJFUWHc9s+yyXtIvD
 dfuZA2JkApnack1tpVCHz2f8h1YmV2qvx5/t9/S6KbN1oQT2sLEafij4OAFLKC4cYSWoXh
 4TVN3wH3RbtFtlhdo7XPvy2O34dSPCM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A8F374B55F;
 Tue, 14 Apr 2026 17:13:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IhomKKp13mksIQAAD6G6ig
 (envelope-from <mwilck@suse.com>); Tue, 14 Apr 2026 17:13:14 +0000
Message-ID: <db21d9d4fd3a1489d5a25d7b7f0c49e3787ee9af.camel@suse.com>
Subject: Re: [PATCH RFC] qga: Add selinux-helper for guest-exec subcommand
 (bsc#1237450)
From: Martin Wilck <mwilck@suse.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Cc: Cathy Hu <cathy.hu@suse.com>, qemu-devel@nongnu.org, Cathy Hu
 <cahu@suse.de>,  Fabiano Rosas <fabiano.rosas@suse.com>
Date: Tue, 14 Apr 2026 19:13:14 +0200
In-Reply-To: <ad5ypLQMlHQm6ATh@redhat.com>
References: <20260327102515.502822-5-cathy.hu@suse.com>
 <acaVRtE-NPUa5Ujy@redhat.com>
 <3d54a532eb5b3111d8f8849458a009493d3d8845.camel@suse.com>
 <ad5ypLQMlHQm6ATh@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 
MIME-Version: 1.0
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_SIGNED(0.00)[suse.com:s=susede1];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[libvirt.org:url, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=mwilck@suse.com;
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

On Tue, 2026-04-14 at 18:00 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Apr 14, 2026 at 06:51:12PM +0200, Martin Wilck wrote:
>=20
>=20
> > > If users want to support an ability to have arbitrary command
> > > execution, then that should be done with SSH over VSock, where
> > > the guest owner can choose whether to require authentication
> > > first or not, and use SSH authorized_keys if desired to limit
> > > what commands can be run for a given recorded key.
> > >=20
> > > These days systemd installs magic to allow SSH'ing directly
> > > to a guest using VSOCK addresses, and libvirt further
> > > enhances that to allow SSH'ing to a named VM.
> >=20
> > Thanks, I wasn't aware of this feature so far. I suppose you're
> > referring to https://libvirt.org/ssh-proxy.html. I'll need to
> > experiment with it. IIUC this works for local libvirt connections
> > only?
>=20
> Yes, vsock is exposed to the local host.

And it can't / won't be implemented for remote hosts?

Martin

