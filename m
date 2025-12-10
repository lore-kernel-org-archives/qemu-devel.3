Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C21D3C545
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 12:55:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTJig-0008J2-NY; Wed, 10 Dec 2025 07:55:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vTJid-0008HL-Bd
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 07:55:00 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vTJib-00058A-DH
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 07:54:59 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D71503388C;
 Wed, 10 Dec 2025 12:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765371293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YdwGBGKRFumizZ3uky+kc58kmRmRKl75RoGZVEuKV7Q=;
 b=kvFeFMH0eSuMT3mPuMxHVHpbsZrVdoNNd8lEGJmOKvYeSmS/2lsZyvH8ZAQls+73ISEhHG
 c78iXduudyfVQNzRgxA8h1pzR6RkTar4SZq4Fx9zFrQ/R47clltzhVVO6Lee605dZ3X3O6
 sX7HunfbedT+yWUInemo3CAvRxp/G4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765371293;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YdwGBGKRFumizZ3uky+kc58kmRmRKl75RoGZVEuKV7Q=;
 b=csyAQsnZ0UYhsVnhHqNhcNRbUTtOWJxfRUx2VJY36sPa21R5Z1HEj+fPyNzLaGwdZGzkyT
 f97P38cHZVAireCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765371292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YdwGBGKRFumizZ3uky+kc58kmRmRKl75RoGZVEuKV7Q=;
 b=JsEXGj++8G+HLqFTTsgwZBVAtKUaPbT1PjAuOXjzGOTWheHBsiuVKx5zWgOHORArvc9l0u
 6iLOu0ruR3Y6dwTtg8Tb/7ybHnbKSRLi9KbAmNRRi18ldX3uaFVnIjUF2j/z0LL0AhJftm
 upqx8y3bxqR+Vv4H5KlI87Z5cFI1WZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765371292;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YdwGBGKRFumizZ3uky+kc58kmRmRKl75RoGZVEuKV7Q=;
 b=Beci3Dqaam048VFNkFswJV8n6YaYk9Im2chuwQUGqMILRpfrtFTKdQCoH97wgA+vUa31VD
 24H21S/fxEVfr7CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5250B3EA63;
 Wed, 10 Dec 2025 12:54:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id P1NmBJxtOWl7EAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 10 Dec 2025 12:54:52 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, Mark Kanda
 <mark.kanda@oracle.com>,
 Ben Chaney <bchaney@akamai.com>, qemu-devel@nongnu.org
Cc: 'Peter Xu' <peterx@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: Update reviewers for CPR
In-Reply-To: <0fc6d169-918e-4065-a112-9a07d9af1365@redhat.com>
References: <20251209183412.3903519-1-bchaney@akamai.com>
 <b6caf9a7-f0b4-41ef-8841-d8aca5c97607@oracle.com>
 <0fc6d169-918e-4065-a112-9a07d9af1365@redhat.com>
Date: Wed, 10 Dec 2025 09:54:49 -0300
Message-ID: <87jyyujy3q.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.990]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
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

C=C3=A9dric Le Goater <clg@redhat.com> writes:

> +Peter, + Fabiano,
>
> On 12/9/25 20:02, Mark Kanda wrote:
>> On 12/9/25 12:34 PM, Ben Chaney wrote:
>>> Signed-off-by: Ben Chaney<bchaney@akamai.com>
>>> ---
>>>   MAINTAINERS | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 63e9ba521b..812c86fab3 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -3116,8 +3116,8 @@ T: githttps://gitlab.com/jsnow/qemu.git jobs
>>>   T: githttps://gitlab.com/vsementsov/qemu.git block
>>>=20=20=20
>>>   CheckPoint and Restart (CPR)
>>> -R: Peter Xu<peterx@redhat.com>
>>> -R: Fabiano Rosas<farosas@suse.de>
>>=20
>> IMO, Peter and Fabiano should continue to be Reviewers.
>>=20

Yes, please.

