Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E1CCD6E79
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 19:13:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWfPN-0003K3-8N; Mon, 08 Jun 2026 15:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wWfPJ-0003Jd-8I
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:13:09 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wWfPH-0000do-OU
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:13:09 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E80166792C;
 Mon,  8 Jun 2026 19:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780945985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=721fmDZXBpCSOoTqG292xUo5Dd9Ts6jP/XzaQz1Xx6M=;
 b=X9ZDMYXDdS39irJSF7kwipPEOa+ZGU1GHe9pBrfQsRmRdo0i59c2YR/VjuCGevvhFcTP9q
 df3I4/bOesAE8QQRUsZ+h4f3Toa2qV7q5m7fLVIAEHw37aThs4wLLM2xm7CCiYGmuiSh7U
 wsCs/Yj5CsqgRgVIZ7RgJygvRtxG1xA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780945985;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=721fmDZXBpCSOoTqG292xUo5Dd9Ts6jP/XzaQz1Xx6M=;
 b=iEb0M31lTwS7CyR3Be0Qfaj8jhN1a3qIaLjDLMbSA1cVfaQEPnUO5Ow81h2sOWAx6k/Syf
 TMsB+ey7BBKQDVCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="X/nO2UFx";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=G8e436Z4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780945984; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=721fmDZXBpCSOoTqG292xUo5Dd9Ts6jP/XzaQz1Xx6M=;
 b=X/nO2UFxH/O2lzWSMnqG6YLfif+rqkFNSQgmQmBnZBx5LpQwce0hx+6KX46sJLi/Kggg2G
 r4pvDH2FGakidPBU9z4h5GOEld3KXBLVn02kZ9Q15zJLpSuzc3Zlz9PnA0d9laTuUeEmQr
 1zWXgNS+6pHbZ3dDmiLDWPOrB+ntiUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780945984;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=721fmDZXBpCSOoTqG292xUo5Dd9Ts6jP/XzaQz1Xx6M=;
 b=G8e436Z4I9Xun05dIXJb5pGWTmNc5f2TkKxD5OsSeAAyh/pkrbYHEekuvHpchxlLN9wOZ9
 TkruYJyY97ZpdpAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 83B73779A7;
 Mon,  8 Jun 2026 19:13:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AMKUFEAUJ2pcWgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 08 Jun 2026 19:13:04 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Thomas Huth <thuth@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Daniel P. Berrange"
 <berrange@redhat.com>
Subject: Re: artifact download for qtest
In-Reply-To: <f2516211-6fbc-4714-b674-4276464f94ff@redhat.com>
References: <CAK3XEhMNqHbkL2P6Xg3_hJ8WAxhPQgurjvuZg-vXUDZ5=x-RRA@mail.gmail.com>
 <f2516211-6fbc-4714-b674-4276464f94ff@redhat.com>
Date: Mon, 08 Jun 2026 16:13:02 -0300
Message-ID: <87v7bs6e2p.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_ALL(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_HAS_DN(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 MIME_TRACE(0.00)[0:+]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[4];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:mid, suse.de:dkim]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E80166792C
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Thomas Huth <thuth@redhat.com> writes:

> On 30/05/2026 16.56, Ani Sinha wrote:
>> Hi,
>> 
>> I am trying to write a qtest for which I need an IGVM file. I have the
>> file, about 54 MiB in size.
>
> 54 MiB is quite big, I agree that we likely don't want to check that into 
> the main repository, especially if it is for a test only...
> (BTW, what's its compressed size?)
>
>> Instead of committing this IGVM binary
>> file with the test, I wanted to check if I can put it somewhere, say
>> in a gitlab repo and then make the test download it. This would be
>> similar to asset downloads for functional tests. No this test cannot
>> be a python functional test.  I am wondering if anyone has faced this
>> situation before and what the best way to solve this problem is.
>
> I'm not maintaining the qtests anymore, but I assume that there is no 
> interest in duplicating all the asset downloading logic there.
>

It would be nice if we could extract the existing code into a little
asset library that could be invoked from the other test frameworks.

> What's the exact reason why you cannot do it as a functional test instead? 
> You could maybe also start the qemu binary there with "-accel qtest -qtest 
> ..." to fake a qtest environment - a little bit cumbersome, but certainly 
> doable, I think.
>
>   Thomas

