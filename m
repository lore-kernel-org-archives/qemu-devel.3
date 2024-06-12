Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867FBC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 18:45:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHSy3-0004iO-D1; Wed, 12 Jun 2024 14:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sHSy1-0004i6-GX
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 14:45:05 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sHSxz-0006OK-QO
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 14:45:05 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2B84D5C5B8;
 Wed, 12 Jun 2024 18:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718217902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eEdQ9x6uBpt9Fq8H52Vwyis5Eo3iPMCxO+vE2pFdrdE=;
 b=vhO/GzzbxOyz+RLWFO2eiiNAOOGhU8ghLo3eSdIJ+Tq4pLXv0gvMaPskNbHfo60UZwAk5D
 qkAjI5hnd9pSp1lx42L5yobvtNCifUtZPHcC4qaOl286Jw8SOo5L8yx0/NMTnNo+zZvntz
 f4nOAe1ux2AJX8An2S93WGQPxYLvCQA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718217902;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eEdQ9x6uBpt9Fq8H52Vwyis5Eo3iPMCxO+vE2pFdrdE=;
 b=py9ZXpRkXvd21w+n+G6uHAyVDPpGBUJpIK06dTIGLw7HDPZT7Y94hc8KEKM2u4vxGEJNTL
 mqzkpS9vFN1BbaDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718217902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eEdQ9x6uBpt9Fq8H52Vwyis5Eo3iPMCxO+vE2pFdrdE=;
 b=vhO/GzzbxOyz+RLWFO2eiiNAOOGhU8ghLo3eSdIJ+Tq4pLXv0gvMaPskNbHfo60UZwAk5D
 qkAjI5hnd9pSp1lx42L5yobvtNCifUtZPHcC4qaOl286Jw8SOo5L8yx0/NMTnNo+zZvntz
 f4nOAe1ux2AJX8An2S93WGQPxYLvCQA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718217902;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eEdQ9x6uBpt9Fq8H52Vwyis5Eo3iPMCxO+vE2pFdrdE=;
 b=py9ZXpRkXvd21w+n+G6uHAyVDPpGBUJpIK06dTIGLw7HDPZT7Y94hc8KEKM2u4vxGEJNTL
 mqzkpS9vFN1BbaDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A9C821372E;
 Wed, 12 Jun 2024 18:45:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id g2z7G63saWYBEgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 12 Jun 2024 18:45:01 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Claudio Fontana
 <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH v2 18/18] migration/ram: Add direct-io support to
 precopy file migration
In-Reply-To: <ZmnoeEKhvxx8rxu5@x1n>
References: <20240523190548.23977-1-farosas@suse.de>
 <20240523190548.23977-19-farosas@suse.de> <Zl9_ZiC6-743ZosG@x1n>
 <87y17gwq5g.fsf@suse.de> <ZmclVQw0x7KKLxmF@x1n> <87r0d4wv1q.fsf@suse.de>
 <ZmdNstq2bONG-7M7@x1n> <87le3cwo9e.fsf@suse.de> <87ed92c9vh.fsf@suse.de>
 <Zmnlt0jUx2o1MEgy@redhat.com> <ZmnoeEKhvxx8rxu5@x1n>
Date: Wed, 12 Jun 2024 15:44:59 -0300
Message-ID: <87bk46c85w.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_HAS_DN(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_SEVEN(0.00)[9]; MID_RHS_MATCH_FROM(0.00)[];
 TO_DN_SOME(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

> On Wed, Jun 12, 2024 at 07:15:19PM +0100, Daniel P. Berrang=C3=A9 wrote:
>> IIUC, with the "fixed-ram" feature, the on-disk format of a saved VM
>> should end up the same whether we're using traditional migration, or
>> multifd migration. Use of multifd is simply an optimization that lets
>> us write RAM in parallel to the file, with direct-io further optimizing.
>>=20
>> There's also a clear break with libvirt between the existing on-disk
>> format libvirt uses, and the new fixed-ram format. So we have no backwar=
ds
>> compatibilty concerns added from multifd, beyond what we already have to
>> figure out when deciding on use of 'fixed-ram'.=20
>>=20
>> Thus I believe there is no downside to always using multifd for save
>> images with fixed-ram, even if we only want nchannels=3D1.
>
> That sounds good.
>
> Just to double check with all of us: so we allow mapped-ram to be used in
> whatever case when !dio, however we restrict dio only when with multifd=
=3Don,
> am I right?

Yes. The restricting part is not yet in place. I'll add a multifd check
to migrate_direct_io():

bool migrate_direct_io(void)
{
    MigrationState *s =3D migrate_get_current();

    return s->parameters.direct_io &&
        s->capabilities[MIGRATION_CAPABILITY_MAPPED_RAM] &&
        s->capabilities[MIGRATION_CAPABILITY_MULTIFD];
}

