Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC1C0D16268
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 14:22:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0Lxu-00054M-TU; Mon, 14 Oct 2024 10:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t0Lxt-000548-PS
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 10:22:29 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t0Lxr-0001j8-RU
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 10:22:29 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 53BD81F793;
 Mon, 14 Oct 2024 14:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728915744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cmg2T+8k1aOtstScK/14QYgYScJ+fxfkhHAEcsQ2/A4=;
 b=xfl2BOPWqaaPmFOkEQN5yojOtXUIR4joLccjBnGLF0qxs13h5TIcPW+kTmsBm0/bDsboxq
 NtPiWYDBmp9RYLKLyqtqb448UU2sevNacej5s15srIwvZpbGQ2qF/rfHR7i1ThJghI+tMv
 ZpuBvGAVseR3TSFkxDT8zViDdZdvvAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728915744;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cmg2T+8k1aOtstScK/14QYgYScJ+fxfkhHAEcsQ2/A4=;
 b=vqlD1axGv4zQCW/sV0OM/HCJnpTz42tRo6HXWrz2L/+r+RamiZ2Sf+ULl0stEqUH3rS7IO
 VyAEJZI6Y6XzJ3Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728915744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cmg2T+8k1aOtstScK/14QYgYScJ+fxfkhHAEcsQ2/A4=;
 b=xfl2BOPWqaaPmFOkEQN5yojOtXUIR4joLccjBnGLF0qxs13h5TIcPW+kTmsBm0/bDsboxq
 NtPiWYDBmp9RYLKLyqtqb448UU2sevNacej5s15srIwvZpbGQ2qF/rfHR7i1ThJghI+tMv
 ZpuBvGAVseR3TSFkxDT8zViDdZdvvAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728915744;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cmg2T+8k1aOtstScK/14QYgYScJ+fxfkhHAEcsQ2/A4=;
 b=vqlD1axGv4zQCW/sV0OM/HCJnpTz42tRo6HXWrz2L/+r+RamiZ2Sf+ULl0stEqUH3rS7IO
 VyAEJZI6Y6XzJ3Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CEE3213A51;
 Mon, 14 Oct 2024 14:22:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OVkZJR8pDWeGZgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 14 Oct 2024 14:22:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Peter Xu
 <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>, Markus
 Armbruster <armbru@redhat.com>, Prasad Pandit <ppandit@redhat.com>, "Dr .
 David Alan Gilbert" <dave@treblig.org>, Julia Suvorova
 <jusual@redhat.com>, Jiang Jiacheng <jiangjiacheng@huawei.com>
Subject: Re: [PATCH] migration: Remove interface query-migrationthreads
In-Reply-To: <Zwzv3gKV3UibdzTs@redhat.com>
References: <20241011153417.516715-1-peterx@redhat.com>
 <Zwzv3gKV3UibdzTs@redhat.com>
Date: Mon, 14 Oct 2024 11:22:21 -0300
Message-ID: <87msj6rcgy.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[9];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

> On Fri, Oct 11, 2024 at 11:34:17AM -0400, Peter Xu wrote:
>> This reverts two commits:
>>=20
>> 671326201dac8fe91222ba0045709f04a8ec3af4
>> 1b1f4ab69c41279a45ccd0d3178e83471e6e4ec1
>>=20
>> Meanwhile it adds an entry to removed-features.rst for the
>> query-migrationthreads QMP command.
>>=20
>> This patch originates from another patchset [1] that wanted to cleanup t=
he
>> interface and add corresponding HMP command, as lots of things are missi=
ng
>> in the query report; so far it only reports the main thread and multifd
>> sender threads; all the rest migration threads are not reported, includi=
ng
>> multifd recv threads.
>>=20
>> As pointed out by Dan in the follow up discussions [1], the API is desig=
ned
>> in an awkward way where CPU pinning may not cover the whole lifecycle of
>> even the thread being reported.  When asked, we also didn't get chance to
>> hear from the developer who introduced this feature to explain how this =
API
>> can be properly used.
>>=20
>> OTOH, this feature from debugging POV isn't very helpful either, as all
>> these information can be easily obtained by GDB.  Esepcially, if with
>> "-name $VM,debug-threads=3Don" we do already have names for each migrati=
on
>> threads (which covers more than multifd sender threads).
>>=20
>> So it looks like the API isn't helpful in any form as of now, besides it
>> only adds maintenance burden to migration code, even if not much.
>>=20
>> Considering that so far there's totally no justification on how to use t=
his
>> interface correctly, let's remove this interface instead of cleaning it =
up.
>>=20
>> In this special case, we even go beyond normal deprecation procedure,
>> because a deprecation process would only make sense when there are exist=
ing
>> users. In this specific case, we expect zero serious users with this API.
>
> We have no way of knowing whether there are existing users of this, or
> any other feature in QEMU. This is why we have a formal deprecation
> period, rather than immediately deleting existing features.
>
> Yes, there are plenty of reasons why this feature is sub-optimal, but
> it is not broken to the extent that it is *impossible* for people to
> be using it.
>
> IOW, I don't see that there's anything special here to justify bypassing
> our deprecation process here.

I have no dog in this race, but as a data point, I see that this was
submitted to libvirt as a new migrationpin command:

https://lists.libvirt.org/archives/list/devel@lists.libvirt.org/thread/FVNA=
UEVIMLG6F2VCRKHZDUEOLBJCXQHO/#BVEGJVZMMLQMXE263GO5BSIWUDIYIFZU

>
>
> With regards,
> Daniel

