Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A1C2C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 13:55:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4LHI-0006YM-Pn; Tue, 07 May 2024 09:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s4LHH-0006Y2-0Q
 for qemu-devel@nongnu.org; Tue, 07 May 2024 09:54:43 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s4LHF-0008Dn-4H
 for qemu-devel@nongnu.org; Tue, 07 May 2024 09:54:42 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B6F8033FB6;
 Tue,  7 May 2024 13:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715090078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HLWyODbSL6iIOX9FN8vCtbw97LXlRYr7dEbyIHyD6/g=;
 b=KBwd6QdZkivgnISfCGE22MYUd2S73nK+26cpzK1DND93aty4GLzN7qZq7XQBA+PxSdcsRz
 NZx5g7MeKVMAHcnNFkQokK5g3TDchfn9av/KDAmGXwWrzWIblKK9U8ZAc01cTUWSqTUV3t
 YOlIt6U4tuN5N8BTNDhIuvdBnSAfGRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715090078;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HLWyODbSL6iIOX9FN8vCtbw97LXlRYr7dEbyIHyD6/g=;
 b=BnHogsTlFxcI6EDgtGpHYB6ujGVL80JtzGSXq1naPbzjVD6KAG7zhEffFncrWOggkpeoi0
 bWPNpR5qsgxS59DQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KBwd6QdZ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BnHogsTl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715090078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HLWyODbSL6iIOX9FN8vCtbw97LXlRYr7dEbyIHyD6/g=;
 b=KBwd6QdZkivgnISfCGE22MYUd2S73nK+26cpzK1DND93aty4GLzN7qZq7XQBA+PxSdcsRz
 NZx5g7MeKVMAHcnNFkQokK5g3TDchfn9av/KDAmGXwWrzWIblKK9U8ZAc01cTUWSqTUV3t
 YOlIt6U4tuN5N8BTNDhIuvdBnSAfGRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715090078;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HLWyODbSL6iIOX9FN8vCtbw97LXlRYr7dEbyIHyD6/g=;
 b=BnHogsTlFxcI6EDgtGpHYB6ujGVL80JtzGSXq1naPbzjVD6KAG7zhEffFncrWOggkpeoi0
 bWPNpR5qsgxS59DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 38FFD13A2D;
 Tue,  7 May 2024 13:54:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0xaXAJ4yOmZyMgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 07 May 2024 13:54:38 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org, Peter
 Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, Igor
 Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Philippe Mathieu-Daude
 <philmd@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Markus
 Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert"
 <dgilbert@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>
Subject: Re: [PATCH V1 01/26] oslib: qemu_clear_cloexec
In-Reply-To: <Zjns1qd57E86lAGy@redhat.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-2-git-send-email-steven.sistare@oracle.com>
 <875xvqmsh8.fsf@suse.de> <Zjns1qd57E86lAGy@redhat.com>
Date: Tue, 07 May 2024 10:54:35 -0300
Message-ID: <87zft1lobo.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_TWELVE(0.00)[13]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[oracle.com,nongnu.org,redhat.com,habkost.net,gmail.com,linaro.org];
 DKIM_TRACE(0.00)[suse.de:+]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MID_RHS_MATCH_FROM(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 TAGGED_RCPT(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B6F8033FB6
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, May 06, 2024 at 08:27:15PM -0300, Fabiano Rosas wrote:
>> Steve Sistare <steven.sistare@oracle.com> writes:
>>=20
>> +cc dgilbert, marcandre
>>=20
>> > Define qemu_clear_cloexec, analogous to qemu_set_cloexec.
>> >
>> > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>=20
>> A v1 patch with two reviews already, from people from another company
>> and they're not in CC. Looks suspicious. =3D)
>
> It is ok in this case - the cpr work has been going on a long
> time and the original series that got partial reviews has been
> split up somewhat. So its "v1" of this series of patches, but
> not "v1" of what we've seen posted on qemu-devel in the past

I know =3D) I searched the archives to make sure those r-bs were actually
provided by them and I also remember the series from back then.

On that topic, but not related to this patch at all, I would prefer if
we had a no-preexisting r-bs rule. I don't see any value in an r-b that
already comes present in v1 and has not been provided through the
list. There's the obvious concern about bad faith, but also that we
might lose track of a series and maintainers/tools might take those r-bs
as a sign of the code actually being reviewed properly (which may or may
not be true).

In the case people develop a series inside the company and then post to
the list, an sob seems to be adequate enough.

>
>>=20
>> Here's a fresh one, hopefully it won't spend another 4 years in the
>> drawer:
>>=20
>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>>=20
>> > ---
>> >  include/qemu/osdep.h | 9 +++++++++
>> >  util/oslib-posix.c   | 9 +++++++++
>> >  util/oslib-win32.c   | 4 ++++
>> >  3 files changed, 22 insertions(+)
>> >
>> > diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
>> > index c7053cd..b58f312 100644
>> > --- a/include/qemu/osdep.h
>> > +++ b/include/qemu/osdep.h
>> > @@ -660,6 +660,15 @@ ssize_t qemu_write_full(int fd, const void *buf, =
size_t count)
>> >=20=20
>> >  void qemu_set_cloexec(int fd);
>> >=20=20
>> > +/*
>> > + * Clear FD_CLOEXEC for a descriptor.
>> > + *
>> > + * The caller must guarantee that no other fork+exec's occur before t=
he
>> > + * exec that is intended to inherit this descriptor, eg by suspending=
 CPUs
>> > + * and blocking monitor commands.
>> > + */
>> > +void qemu_clear_cloexec(int fd);
>> > +
>> >  /* Return a dynamically allocated directory path that is appropriate =
for storing
>> >   * local state.
>> >   *
>> > diff --git a/util/oslib-posix.c b/util/oslib-posix.c
>> > index e764416..614c3e5 100644
>> > --- a/util/oslib-posix.c
>> > +++ b/util/oslib-posix.c
>> > @@ -272,6 +272,15 @@ int qemu_socketpair(int domain, int type, int pro=
tocol, int sv[2])
>> >      return ret;
>> >  }
>> >=20=20
>> > +void qemu_clear_cloexec(int fd)
>> > +{
>> > +    int f;
>> > +    f =3D fcntl(fd, F_GETFD);
>> > +    assert(f !=3D -1);
>> > +    f =3D fcntl(fd, F_SETFD, f & ~FD_CLOEXEC);
>> > +    assert(f !=3D -1);
>> > +}
>> > +
>> >  char *
>> >  qemu_get_local_state_dir(void)
>> >  {
>> > diff --git a/util/oslib-win32.c b/util/oslib-win32.c
>> > index b623830..c3e969a 100644
>> > --- a/util/oslib-win32.c
>> > +++ b/util/oslib-win32.c
>> > @@ -222,6 +222,10 @@ void qemu_set_cloexec(int fd)
>> >  {
>> >  }
>> >=20=20
>> > +void qemu_clear_cloexec(int fd)
>> > +{
>> > +}
>> > +
>> >  int qemu_get_thread_id(void)
>> >  {
>> >      return GetCurrentThreadId();
>>=20
>
> With regards,
> Daniel

