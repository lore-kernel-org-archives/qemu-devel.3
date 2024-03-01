Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AACBC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 13:34:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg31X-0006tX-IK; Fri, 01 Mar 2024 08:34:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rg31I-0006qj-Rq
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 08:33:53 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rg31G-0002qi-F7
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 08:33:48 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5D2F033A1F;
 Fri,  1 Mar 2024 13:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709300024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AfgIQZjsIfzz4q9OvXplBpCPvzo/38NCSh3z7Cel8tQ=;
 b=hJoXHRrDKFULR9tTwsnAKDEg8SGQ+mlvre/Xl09ra7gJ0jPAMWmcky7FsKaKdROaF32+Kq
 KU9L7wtVLLnk7ybHNpA4v+pb0ZZojEZKEdeMFHwMS36fxhIJmOAJJScTqrzibYQHu+Xm3K
 KNhu4FlZwIiwCExXi/EEaE63N6ndhnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709300024;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AfgIQZjsIfzz4q9OvXplBpCPvzo/38NCSh3z7Cel8tQ=;
 b=CE1gC2kr5WOlbgZR06fy3SKGUwJ/SsYWAWWpwwa1pbCHlqXH5uUKz4CmWh11RC6d5DS059
 ELPP6/L6zGepOPAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709300024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AfgIQZjsIfzz4q9OvXplBpCPvzo/38NCSh3z7Cel8tQ=;
 b=hJoXHRrDKFULR9tTwsnAKDEg8SGQ+mlvre/Xl09ra7gJ0jPAMWmcky7FsKaKdROaF32+Kq
 KU9L7wtVLLnk7ybHNpA4v+pb0ZZojEZKEdeMFHwMS36fxhIJmOAJJScTqrzibYQHu+Xm3K
 KNhu4FlZwIiwCExXi/EEaE63N6ndhnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709300024;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AfgIQZjsIfzz4q9OvXplBpCPvzo/38NCSh3z7Cel8tQ=;
 b=CE1gC2kr5WOlbgZR06fy3SKGUwJ/SsYWAWWpwwa1pbCHlqXH5uUKz4CmWh11RC6d5DS059
 ELPP6/L6zGepOPAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D9FFC13A80;
 Fri,  1 Mar 2024 13:33:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 15FmJzfZ4WXRXQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 01 Mar 2024 13:33:43 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com
Subject: Re: [PATCH v2 1/3] qtest: migration: Enhance qtest migration
 functions to support 'channels' argument
In-Reply-To: <584cc08c-7847-401c-aa4a-516427ae1c4d@nutanix.com>
References: <20240223152517.7834-1-het.gala@nutanix.com>
 <20240223152517.7834-2-het.gala@nutanix.com> <87zfvr7xdn.fsf@suse.de>
 <1988bb0f-6ebe-4335-b761-d11313c772fd@nutanix.com>
 <87bk83bcqj.fsf@suse.de>
 <32687fa3-78dc-457b-ae50-854d2c72c922@nutanix.com>
 <894b5da4-0af1-4ca0-b8a7-da288bb20774@nutanix.com>
 <87o7c0rruo.fsf@suse.de>
 <0bf519e8-3bd2-4074-bc77-29d30a7af110@nutanix.com>
 <584cc08c-7847-401c-aa4a-516427ae1c4d@nutanix.com>
Date: Fri, 01 Mar 2024 10:33:41 -0300
Message-ID: <878r32vzyi.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-1.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-0.00)[29.77%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.994]; RCPT_COUNT_SEVEN(0.00)[7];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Het Gala <het.gala@nutanix.com> writes:

> On 01/03/24 2:19 pm, Het Gala wrote:
>>
>> On 29/02/24 6:47 am, Fabiano Rosas wrote:
>>> Het Gala <het.gala@nutanix.com> writes:
>>>
>>>> On 27/02/24 1:04 am, Het Gala wrote:
>>>>>
>>>>> On 26/02/24 6:31 pm, Fabiano Rosas wrote:
>>>>>> Het Gala<het.gala@nutanix.com>=C2=A0 writes:
>>>>>>
>>>>>>> On 24/02/24 1:42 am, Fabiano Rosas wrote:
>>>>>>> this was the same first approach that I attempted. It won't work=20
>>>>>>> because
>>>>>>>
>>>>>>> The final 'migrate' QAPI with channels string would look like
>>>>>>>
> [...]
>>> I'm not sure what you tried. This works:
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 g_assert(!qdict_haskey(args, "channels"));
>>> =C2=A0=C2=A0=C2=A0=C2=A0 if (channels) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 channels_obj =3D qobje=
ct_from_json(channels, errp);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qdict_put_obj(args, "c=
hannels", channels_obj);
>>> =C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> Are you sure the above works ?
>
> Sorry, please ignore the below doubt. I understood what silly mistakes I=
=20
> was doing. you were right, qobject_from_json() works fine and converts=20
> string to json object.
>
> Will follow your latest reply and send out the patch really soon. Thank=20
> you for unblocking me here quickly :)

Just please don't make it all one patch. Each of those steps could be a
separate patch.

