Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2913C02197
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 14:58:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfKNi-0003Wv-6L; Tue, 04 Feb 2025 09:58:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tfKNd-0003UE-TU
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 09:58:26 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tfKNc-0002mb-6v
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 09:58:25 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 651F31F387;
 Tue,  4 Feb 2025 14:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738681102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MbDOBoNaEfUtMsTiD6Y3lyn4lABLpGWonNFb3iIqgNQ=;
 b=n2BJVpI2boKO8nrAkZqn7u/+lcLXdR3jI1TYcX3BqF8u9oHAYLJItuK7Q2TkAXXgVr9I+P
 Djyzvcb0lnpG1gxcZnwAxe1JuZCvQQZlAb376Vx7RpNnhryUspjaYdmWDXlUWHt7mprPda
 CCWmhqFpEgB7wPaAx/Um1oaTtG///Dk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738681102;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MbDOBoNaEfUtMsTiD6Y3lyn4lABLpGWonNFb3iIqgNQ=;
 b=OFUBtAmbFkQIpKUs0rtWDXGd0Dl853J1aZm285DmQpxyys+jS4T0d6HzHi8NobG/NBTiK3
 2KHeBccG/4KhK+BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738681102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MbDOBoNaEfUtMsTiD6Y3lyn4lABLpGWonNFb3iIqgNQ=;
 b=n2BJVpI2boKO8nrAkZqn7u/+lcLXdR3jI1TYcX3BqF8u9oHAYLJItuK7Q2TkAXXgVr9I+P
 Djyzvcb0lnpG1gxcZnwAxe1JuZCvQQZlAb376Vx7RpNnhryUspjaYdmWDXlUWHt7mprPda
 CCWmhqFpEgB7wPaAx/Um1oaTtG///Dk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738681102;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MbDOBoNaEfUtMsTiD6Y3lyn4lABLpGWonNFb3iIqgNQ=;
 b=OFUBtAmbFkQIpKUs0rtWDXGd0Dl853J1aZm285DmQpxyys+jS4T0d6HzHi8NobG/NBTiK3
 2KHeBccG/4KhK+BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE25413795;
 Tue,  4 Feb 2025 14:58:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7eCgKA0romf6cgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 04 Feb 2025 14:58:21 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steven Sistare <steven.sistare@oracle.com>, =?utf-8?Q?C=C3=A9dric?= Le
 Goater <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] MAINTAINER: Add a maintainer for CPR
In-Reply-To: <9295d5cc-775d-408f-8554-1ef5db823748@oracle.com>
References: <20250204082859.846886-1-clg@redhat.com>
 <8599e016-4ea4-4c1d-b4d2-c583c57a9558@oracle.com>
 <8638674e-5a79-4405-9063-89ba78112c8f@redhat.com>
 <9295d5cc-775d-408f-8554-1ef5db823748@oracle.com>
Date: Tue, 04 Feb 2025 11:58:19 -0300
Message-ID: <874j19ah9w.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, imap1.dmz-prg2.suse.org:helo,
 oracle.com:email]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Steven Sistare <steven.sistare@oracle.com> writes:

> On 2/4/2025 8:42 AM, C=C3=A9dric Le Goater wrote:
>> On 2/4/25 14:31, Steven Sistare wrote:
>>> Hi Cedric, CPR is a mode of live migration, integrated so closely that
>>> it makes more sense for the migration maintainers to maintain it, and
>>> consult me if/when necessary.=C2=A0 "migration" appears in 4 of the 5 p=
aths
>>> you list below.
>>=20
>> CPR is growing with the recent proposal and it is a large enough
>> feature to have its own maintainer IMHO.
>>=20
>> Should we add cpr* files under the migration subsystem then ?
>
> Sure, I'll do that in V2 for the vfio series.
>
> - Steve
>
>>> On 2/4/2025 3:28 AM, C=C3=A9dric Le Goater wrote:
>>>> The CPR feature was added in QEMU 9.0 and it lacks a maintainer.
>>>> Propose the main contributor to become one.
>>>>
>>>> Cc: Steve Sistare <steven.sistare@oracle.com>
>>>> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
>>>> ---
>>>> =C2=A0 MAINTAINERS | 9 +++++++++
>>>> =C2=A0 1 file changed, 9 insertions(+)
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index db8c41fbe0f9..efb9da02f142 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -2943,6 +2943,15 @@ F: include/qemu/co-shared-resource.h
>>>> =C2=A0 T: git https://gitlab.com/jsnow/qemu.git jobs
>>>> =C2=A0 T: git https://gitlab.com/vsementsov/qemu.git block
>>>> +CheckPoint and Restart (CPR)
>>>> +M: Steve Sistare <steven.sistare@oracle.com>
>>>> +S: Supported
>>>> +F: hw/vfio/cpr*
>>>> +F: include/migration/cpr.h
>>>> +F: migration/cpr*
>>>> +F: tests/qtest/migration/cpr*
>>>> +F: docs/devel/migration/CPR.rst
>>>> +
>>>> =C2=A0 Compute Express Link
>>>> =C2=A0 M: Jonathan Cameron <jonathan.cameron@huawei.com>
>>>> =C2=A0 R: Fan Ni <fan.ni@samsung.com>
>>>
>>=20

We've made our bed years ago when it was decided that cpr should use
migration facilities. I wasn't even around at the time, but I tend to
honor decisions made by previous maintainers. So I'm ok with leaving CPR
under the migration tree.

However I agree with the general sentiment of C=C3=A9dric's email. CPR is
becoming a big thing and we might run into resource issues for its
maintenance. As always, we do this on a best-effort basis and if the
workload starts to become an issue we'll have to ask for help or
reconsider the feature's status in the codebase.

