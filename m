Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB9FC02194
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 13:51:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tclyn-0002YU-Jc; Tue, 28 Jan 2025 08:50:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tclyk-0002YD-W5
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 08:50:11 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tclyj-0005Yi-7P
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 08:50:10 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F104A1F383;
 Tue, 28 Jan 2025 13:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738072207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FWtFwb/hOttVAQp9GPwu7Lm/EIjoO/oBnxTG9AhL7cc=;
 b=VFReX82vrSTfpLKVc8F6JtsdjCbpCjg+SBI+qAuau9F8K3QojtEQGcn20Sjn5VeyJcoLuz
 HZKdzV/mm9GMc6673K8QkKHCs94snNTw+u+nu6jY4LDGOSznCilQru5CI6PYWpcTu4MRI5
 P4wzLVqlzTU8JwO92KRckE6v6HfsQ1U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738072207;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FWtFwb/hOttVAQp9GPwu7Lm/EIjoO/oBnxTG9AhL7cc=;
 b=GCZi70URUA/gufTQP1gYoE4qV0TCx1veU4Q89H6c6Fhe7NTr380fN8goQQq08vmCqI2OpY
 x3KdgUl5Y1vlIGCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738072206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FWtFwb/hOttVAQp9GPwu7Lm/EIjoO/oBnxTG9AhL7cc=;
 b=wTQ2+EeuQlltgO25bx/pggqqJsZ8mKdqyeW44LHo3ZImx+UibJ1dBnjfMDDTga8DaQFs43
 3/mxMRE1erLPtdXY6OSS+C24x5Pk2OzpFbQPqesTmMPWSiHhh2JxQNKjEV5u95XfAk8XQ4
 +SgGABNWM1V5YhYeMRU/aqyGMXOfL08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738072206;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FWtFwb/hOttVAQp9GPwu7Lm/EIjoO/oBnxTG9AhL7cc=;
 b=Vwn0I6VYbRHY8dnlq6qSg4TSPOIoIxlX1wmBgGo5nldNf1vyKra6nB+9cJBAXuetbpSSC9
 M7dBoyuFXyoNHcDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67CB613A60;
 Tue, 28 Jan 2025 13:50:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8syZCY7gmGelRwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 28 Jan 2025 13:50:06 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com, Prasad
 Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v4 4/4] tests/qtest/migration: add postcopy tests with
 multifd
In-Reply-To: <CAE8KmOzCwr_vMYEGXR9RgAHb_hFp+wRznOhp+xxtDMGxaa7eGQ@mail.gmail.com>
References: <20250127120823.144949-1-ppandit@redhat.com>
 <20250127120823.144949-5-ppandit@redhat.com> <874j1kufin.fsf@suse.de>
 <CAE8KmOyj0DvODhRVoyaqGaTSe+YDV8ymieFwCgnFZM0rWRuK-w@mail.gmail.com>
 <CAE8KmOzCwr_vMYEGXR9RgAHb_hFp+wRznOhp+xxtDMGxaa7eGQ@mail.gmail.com>
Date: Tue, 28 Jan 2025 10:50:03 -0300
Message-ID: <871pwnujxw.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Prasad Pandit <ppandit@redhat.com> writes:

> On Tue, 28 Jan 2025 at 11:00, Prasad Pandit <ppandit@redhat.com> wrote:
>> >     for (int i = 0; i < MIGRATION_CAPABILITY__MAX; i++) {
>> >         if (args->caps[i]) {
>> >             migrate_set_capability(from, MigrationCapability_str(args->caps[i]), true);
>> >             migrate_set_capability(to, MigrationCapability_str(args->caps[i]), true);
>> >         }
>> >     }
>> >
>> > We could also set the number of channels as a default value. The tests
>> > could overwrite it from the hook if needed.
>>
>> * Yes, this seems like a better option, I'll give it a try.
>
> Please see -> https://notebin.de/?317b9fc90a9a910d#dGKqq4r5pyMYU5SXYLFhd8wrzKRCxCcokTkTRBCUK7w
>
> @Fabiano: does this look okay? If it is, I'll further remove
> corresponding boolean fields from MigrateCommon struct etc.

You could include qapi-types-migration.h and use the actual enum, that
avoids the burden of having to keep the tests in sync with the code.

(I don't think keeping the caps in sync with the current-version tests
would break the compat tests, but please consider that as well)

And a generic helper that calls migrate_set_capability() for any
capabilites set. That solves the capabilities issue for all tests. We
can then move some default parameters setting into that function and
that should already reduce the number of hooks needed.

You can include it in this series or send a separate one, whatever is
easier for you. But we need to base this one on top of it eventually, I
would just send everything at once.

>
> Thank you.
> ---
>   - Prasad

