Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3BEAC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 20:54:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjmeJ-0001Y7-2D; Mon, 11 Mar 2024 16:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rjmeH-0001Xd-26
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 16:53:29 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rjmeF-0001Ah-GK
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 16:53:28 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9200135093;
 Mon, 11 Mar 2024 20:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710190405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5fo3nSfedo/M3ybokTvEalTxASYJUHsS9vYjbN1WcOU=;
 b=pyoJpAMKcXSwqlog102BrU1NYDLeWqmaeLveja5UtdiblwRC2dYldGLIA8AAscXjs3iS2N
 amKWGIIMdPzdLD+hl7UciNL0Ny0ZjQYVS70EMj0xzlQ8jiz8faWiOJAcvlDuQSgOMWheiU
 3ZfNJ9w78sSPCg2ugseKTNohVRhp3zo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710190405;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5fo3nSfedo/M3ybokTvEalTxASYJUHsS9vYjbN1WcOU=;
 b=dixVylBpuDiEk3JV5kOjKcAYszSq4Y6LUKcrTplqjY/TXAyeLp91vf4S9qHv0TqxJcPBNP
 Dybbb6SMsJ8NiGDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710190405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5fo3nSfedo/M3ybokTvEalTxASYJUHsS9vYjbN1WcOU=;
 b=pyoJpAMKcXSwqlog102BrU1NYDLeWqmaeLveja5UtdiblwRC2dYldGLIA8AAscXjs3iS2N
 amKWGIIMdPzdLD+hl7UciNL0Ny0ZjQYVS70EMj0xzlQ8jiz8faWiOJAcvlDuQSgOMWheiU
 3ZfNJ9w78sSPCg2ugseKTNohVRhp3zo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710190405;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5fo3nSfedo/M3ybokTvEalTxASYJUHsS9vYjbN1WcOU=;
 b=dixVylBpuDiEk3JV5kOjKcAYszSq4Y6LUKcrTplqjY/TXAyeLp91vf4S9qHv0TqxJcPBNP
 Dybbb6SMsJ8NiGDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 151B313695;
 Mon, 11 Mar 2024 20:53:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Jj19MkRv72UDZQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 11 Mar 2024 20:53:24 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com
Subject: Re: [PATCH v4 3/8] Replace migrate_get_connect_uri inplace of
 migrate_get_socket_address
In-Reply-To: <2e9121cd-cbc9-4ac8-a058-815dbbff25dc@nutanix.com>
References: <20240308205951.111747-1-het.gala@nutanix.com>
 <20240308205951.111747-4-het.gala@nutanix.com> <87wmq8my0s.fsf@suse.de>
 <2e9121cd-cbc9-4ac8-a058-815dbbff25dc@nutanix.com>
Date: Mon, 11 Mar 2024 17:51:12 -0300
Message-ID: <878r2omr0f.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pyoJpAMK;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=dixVylBp
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.83 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 BAYES_HAM(-0.32)[75.58%]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-0.978];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: 9200135093
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

> On 11/03/24 11:49 pm, Fabiano Rosas wrote:
>> Het Gala<het.gala@nutanix.com>  writes:
>>
>>>
>>>   bool migrate_watch_for_events(QTestState *who, const char *name,
>>> @@ -130,7 +140,7 @@ void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
>>>   
>>>       g_assert(!qdict_haskey(args, "uri"));
>>>       if (!uri) {
>>> -        connect_uri = migrate_get_socket_address(to, "socket-address");
>>> +        connect_uri = migrate_get_connect_uri(to, "socket-address");
>> What's the point of the "socket-address" argument here? Seems a bit
>> nonsensical to me to call: migrate_get_socket_address(..., "socket-address").
>>
>> What about we just suppress this throughout the stack and directly call:
>>
>>      object = qdict_get(rsp, "socket-address");
>
> Fabiano, I didn't get clearly understand your point here. From what I 
> understand,
> you want to call just
> 1. migrate_get_connect_uri(to) and migrate_get_connect_qdict(to)

Yes.

> 2. delete migrate_get_socket_address(..., "socket-address") altogether 

No, just the string argument, not the whole function:

static char *migrate_get_socket_address(QTestState *who) <----
{
    QDict *rsp;
    char *result;
    SocketAddressList *addrs;
    Visitor *iv = NULL;
    QObject *object;

    rsp = migrate_query(who);
    object = qdict_get(rsp, "socket-address"); <-----
    ...
}

If the thing is called migrate_get_SOCKET_ADDRESS(), it's obvious that
the "socket-address" is the parameter we want. We even call
SocketAddress_to_str, so there's no point in having that argument
there. We will never call the function with something else in
'parameter'.


