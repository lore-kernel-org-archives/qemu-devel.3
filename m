Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE29BD2AB3C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 13:21:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5m9F-00005V-5C; Tue, 29 Oct 2024 09:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t5m9D-00004u-0e
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 09:20:35 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t5m98-0007LE-WE
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 09:20:32 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B945721CBA;
 Tue, 29 Oct 2024 13:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730208027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=46drK5DwYJCW7cr8JBAIHXMtqACQZtCUO2rGL6Z1LgU=;
 b=yczjUWRqF4dmLwWSeFBi31PP5bNti1NToaankiYF9R+FiKtY4dAryQgR7ospUOkHWm9dj5
 aqFvKB5SI/LNTJeZ1qctSh3bX2XYOiq/ufRaivhs3r5X9t48eG3+349YTpRMU47VzXjwDg
 Q6hyYiCVfWGcKnvKgCOocTv3Xte3C50=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730208027;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=46drK5DwYJCW7cr8JBAIHXMtqACQZtCUO2rGL6Z1LgU=;
 b=eF5yuncuNQ0o4IiKB6L5WT9hCrHApljeHkNBlY3dHqEpo/uT1BsB+utPoDfWuG/lnIPkd9
 gZ15SspZSWsCTIBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yczjUWRq;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=eF5yuncu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730208027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=46drK5DwYJCW7cr8JBAIHXMtqACQZtCUO2rGL6Z1LgU=;
 b=yczjUWRqF4dmLwWSeFBi31PP5bNti1NToaankiYF9R+FiKtY4dAryQgR7ospUOkHWm9dj5
 aqFvKB5SI/LNTJeZ1qctSh3bX2XYOiq/ufRaivhs3r5X9t48eG3+349YTpRMU47VzXjwDg
 Q6hyYiCVfWGcKnvKgCOocTv3Xte3C50=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730208027;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=46drK5DwYJCW7cr8JBAIHXMtqACQZtCUO2rGL6Z1LgU=;
 b=eF5yuncuNQ0o4IiKB6L5WT9hCrHApljeHkNBlY3dHqEpo/uT1BsB+utPoDfWuG/lnIPkd9
 gZ15SspZSWsCTIBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 38DD1139A2;
 Tue, 29 Oct 2024 13:20:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dMRAABvhIGfYaAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 29 Oct 2024 13:20:27 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Steven Sistare
 <steven.sistare@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, David Hildenbrand
 <david@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo
 Habkost <eduardo@habkost.net>, Philippe Mathieu-Daude <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [RFC V1 00/14] precreate phase
In-Reply-To: <ZyDDcmDoCE_qHgfT@redhat.com>
References: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
 <b36283ff-2e14-4ee0-a64e-a5c4f9e86534@redhat.com>
 <fd8977f7-2787-4387-81fa-240665d0bf1d@oracle.com>
 <Zxta2w6iu2n_5YBa@redhat.com>
 <922177b7-216f-4176-a57a-a86f32252664@oracle.com>
 <ZxugavgmHrawXPNQ@redhat.com> <ZyDDcmDoCE_qHgfT@redhat.com>
Date: Tue, 29 Oct 2024 10:20:24 -0300
Message-ID: <878qu7cag7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B945721CBA
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[redhat.com,oracle.com,nongnu.org,gmail.com,habkost.net,linaro.org];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; MID_RHS_MATCH_FROM(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_SEVEN(0.00)[10];
 TAGGED_RCPT(0.00)[]; MISSING_XM_UA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> On Fri, Oct 25, 2024 at 02:43:06PM +0100, Daniel P. Berrang=C3=A9 wrote:
>>=20
>> The migration QAPI design has always felt rather odd to me, in that we
>> have perfectly good commands "migrate" & "migrate-incoming" that are able
>> to accept an arbitrary list of parameters when invoked. Instead of passi=
ng
>> parameters to them though, we instead require apps use the separate
>> migreate-set-parameters/capabiltiies commands many times over to set
>> global variables which the later 'migrate' command then uses.
>>=20
>> The reason for this is essentially a historical mistake - we copied the
>> way we did it from HMP, which was this way because HMP was bad at suppor=
ting
>> arbitrary customizable paramters to commands. I wish we hadn't copied th=
is
>> design over to QMP.
>>=20
>> To bring it back on topic, we need QMP on the dest to set parameters,
>> because -incoming  was limited to only take the URI.
>>=20
>> If the "migrate-incoming" command accepted all parameters directly,
>> then we could use QAPI visitor to usupport a "-incoming ..." command
>> that took an arbitrary JSON document and turned it into a call to
>> "migrate-incoming".
>>=20
>> With that we would never need QMP on the target for cpr-exec, avoiding
>> this ordering poblem you're facing....assuming we put processing of
>> -incoming at the right point in the code flow
>>=20
>> Can we fix this design and expose the full configurability on the
>> CLI using QAPI schema & inline JSON, like we do for other QAPI-ified
>> CLI args.
>>=20
>> It seems entirely practical to me to add parameters to 'migrate-incoming'
>> in a backwards compatible manner and deprecate set-parameters/capabiliti=
es
>
> Incidentally, if we were going to evolve the migration API at all, then
> it probably ought to start making use of the async job infrastructure
> we have available. This is use by block jobs, and by the internal snapshot

I'm all for standardization on core infrastructure, but unfortunately
putting migration in a coroutine would open a can of worms. In fact,
we've been discussing about moving the incoming side out of coroutines
for a while.

> commands, and was intended to be used for any case where we had a long
> running operation triggered by a command. Migration was a poster-child
> example of what its intended for, but was left alone when we first
> introduced the job APIs.
>
> The 'job-cancel' API would obsolete 'migrate-cancel'.
>
> The other interestnig thing is that the job framework creates a well
> defined lifecycle for a job, that allows querying information about
> the job after completeion, but without QEMU having to keep that info
> around forever. ie once a job has finished, an app can query info
> about completion, and when it no longer needs that info, it can
> call 'job-dismiss' to tell QEMU to discard it.
>
> If "MigrationState" were associated a job, then it would thus have a
> clear 'creation' and 'deletion' time.
>
> With regards,
> Daniel

