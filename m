Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF08C83F34
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 19:25:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucOQq-0001zF-Lo; Thu, 17 Jul 2025 09:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ucNkb-0004o4-1I
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 08:30:24 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ucNkV-0005iy-Ey
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 08:30:11 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 16F8721174;
 Thu, 17 Jul 2025 12:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752755405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jHjkwnoyHHRxtNVbBXbIibEl2KN6KXy88mNdY1hsScc=;
 b=NY8oLew3TfOknmB52OqNvIzkqXL+Lxkjd1dUsNRU5srondbHSRcTLbMESAFi1Nt7q3bxkn
 HEUeQ0Qj8JG5RUq2mfsXAv4HUR1K5o9pvxsEm6x1E3qeHZ7QzPzPSxw4qMVcvIyor9tfn1
 aDHEIQczQmZZip5wnQZAMlRzVqEcVd4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752755405;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jHjkwnoyHHRxtNVbBXbIibEl2KN6KXy88mNdY1hsScc=;
 b=HnwHfjNeHZaUlE0vySmfhXR3Xj0TwWUPiS03wITrQy2G9fMNiVTg/0MM+hc282qaaUY6FI
 Sqgkw6KMvjdWKBCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NY8oLew3;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HnwHfjNe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752755405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jHjkwnoyHHRxtNVbBXbIibEl2KN6KXy88mNdY1hsScc=;
 b=NY8oLew3TfOknmB52OqNvIzkqXL+Lxkjd1dUsNRU5srondbHSRcTLbMESAFi1Nt7q3bxkn
 HEUeQ0Qj8JG5RUq2mfsXAv4HUR1K5o9pvxsEm6x1E3qeHZ7QzPzPSxw4qMVcvIyor9tfn1
 aDHEIQczQmZZip5wnQZAMlRzVqEcVd4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752755405;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jHjkwnoyHHRxtNVbBXbIibEl2KN6KXy88mNdY1hsScc=;
 b=HnwHfjNeHZaUlE0vySmfhXR3Xj0TwWUPiS03wITrQy2G9fMNiVTg/0MM+hc282qaaUY6FI
 Sqgkw6KMvjdWKBCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 461581392A;
 Thu, 17 Jul 2025 12:30:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZxgMEczseGisDgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 17 Jul 2025 12:30:04 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, David Hildenbrand
 <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth
 <thuth@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, Nicholas
 Piggin <npiggin@gmail.com>, Daniel Henrique Barboza
 <danielhb413@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, Alex
 Williamson <alex.williamson@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>, Peter Xu <peterx@redhat.com>, Hailiang Zhang
 <zhanghailiang@xfusion.com>, Steve Sistare <steven.sistare@oracle.com>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Stefan Berger
 <stefanb@linux.vnet.ibm.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v4 00/23] migration: propagate vTPM errors using Error
 objects
In-Reply-To: <aHgp_eBPq6v1FRLi@armenon-kvm.bengluru.csb>
References: <20250716-propagate_tpm_error-v4-0-7141902077c0@redhat.com>
 <87zfd3lxfn.fsf@suse.de> <aHgp_eBPq6v1FRLi@armenon-kvm.bengluru.csb>
Date: Thu, 17 Jul 2025 09:30:01 -0300
Message-ID: <87wm87knjq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 16F8721174
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWELVE(0.00)[30];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_CC(0.00)[nongnu.org,redhat.com,gmail.com,linux.ibm.com,linaro.org,euphon.net,xfusion.com,oracle.com,linux.vnet.ibm.com,rsg.ci.i.u-tokyo.ac.jp,collabora.com];
 DKIM_TRACE(0.00)[suse.de:+]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 TAGGED_RCPT(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLzasi9boc9ahn35s1z6tc8qwy)];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
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

Arun Menon <armenon@redhat.com> writes:

> Hi Fabiano, 
>
> Thanks for the quick review and for catching the make check failure. 
> My apologies for that oversight, it's definitely an embarrassing miss on my part.

That's ok, you don't do this every day. =)

> I see what happened there. I ran make check without sudo, therefore the postcopy tests
> were missed ; because it requires userfaultfd(). Only 62 out of the total 79 migration
> tests were run.
>

You can avoid running the tests under sudo by setting unprivileged
access for userfaultfd:

sudo sysctl vm.unprivileged_userfaultfd=1 -w


