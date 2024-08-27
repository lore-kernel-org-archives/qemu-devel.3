Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5DADC54731
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 15:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siyWY-00053h-O0; Tue, 27 Aug 2024 11:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1siyWX-0004y9-7w; Tue, 27 Aug 2024 11:54:25 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1siyWV-0005R2-EF; Tue, 27 Aug 2024 11:54:24 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 928BA1F396;
 Tue, 27 Aug 2024 15:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724774059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JGORP7BlR6yIF8ZJXGP10BXTbEiHNjU+Nut5MLGYa34=;
 b=GOhbkWqYvMo+gLyfUrbLRoHdok9z6WL/jv1g4WaQEyEeA8752Ch9MjbKGaSky5/BKmbLnY
 NGTOvcDDswzIJ/Dhn9uZDQ1zVSdC+4uRSqc6LuHeWR+Cb0uBxUfZjFFw0eQ3LYbBFeCWQ8
 W8cn0GD0Bs1L6r6W7u33wUxGWtKNk5c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724774059;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JGORP7BlR6yIF8ZJXGP10BXTbEiHNjU+Nut5MLGYa34=;
 b=/UBujZoJUZj2E09Dq1S18nFHT62RSH2ktxopdxHkPSB6chFGgQSzDMgW6iZUlhkUzHBHVd
 XpJ2rek2NKLoUlDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724774059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JGORP7BlR6yIF8ZJXGP10BXTbEiHNjU+Nut5MLGYa34=;
 b=GOhbkWqYvMo+gLyfUrbLRoHdok9z6WL/jv1g4WaQEyEeA8752Ch9MjbKGaSky5/BKmbLnY
 NGTOvcDDswzIJ/Dhn9uZDQ1zVSdC+4uRSqc6LuHeWR+Cb0uBxUfZjFFw0eQ3LYbBFeCWQ8
 W8cn0GD0Bs1L6r6W7u33wUxGWtKNk5c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724774059;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JGORP7BlR6yIF8ZJXGP10BXTbEiHNjU+Nut5MLGYa34=;
 b=/UBujZoJUZj2E09Dq1S18nFHT62RSH2ktxopdxHkPSB6chFGgQSzDMgW6iZUlhkUzHBHVd
 XpJ2rek2NKLoUlDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 137B813A44;
 Tue, 27 Aug 2024 15:54:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rDHFMqr2zWaxLQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 27 Aug 2024 15:54:18 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>, Akihiko
 Odaki <akihiko.odaki@daynix.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Philippe =?utf-8?Q?Mathieu?=
 =?utf-8?Q?-Daud=C3=A9?=
 <philmd@linaro.org>, Yanan Wang <wangyanan55@huawei.com>, John Snow
 <jsnow@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>, Daniel
 Henrique Barboza <danielhb413@gmail.com>, David Gibson
 <david@gibson.dropbear.id.au>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin"
 <mst@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini
 <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, Laurent
 Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 qemu-ppc@nongnu.org
Subject: Re: [PATCH v4 7/7] tests/qtest: Delete previous boot file
In-Reply-To: <CAFEAcA-8peUP-TJW8X3JJQg1p7MKvo2vTZ4HcgrTh+d9T1smRA@mail.gmail.com>
References: <20240823-san-v4-0-a24c6dfa4ceb@daynix.com>
 <20240823-san-v4-7-a24c6dfa4ceb@daynix.com> <Zsyesfaf02ktFU1A@x1n>
 <86d9b2b7-505d-4223-bcd0-4e4a7847ec56@redhat.com> <87zfoyvzaa.fsf@suse.de>
 <CAFEAcA-8peUP-TJW8X3JJQg1p7MKvo2vTZ4HcgrTh+d9T1smRA@mail.gmail.com>
Date: Tue, 27 Aug 2024 12:54:16 -0300
Message-ID: <87wmk2vu53.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TAGGED_RCPT(0.00)[]; RCPT_COUNT_TWELVE(0.00)[24];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,daynix.com,habkost.net,gmail.com,linaro.org,huawei.com,eik.bme.hu,flygoat.com,gibson.dropbear.id.au,linux.ibm.com,ozlabs.ru,nongnu.org];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,linaro.org:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 27 Aug 2024 at 15:03, Fabiano Rosas <farosas@suse.de> wrote:
>>
>> Thomas Huth <thuth@redhat.com> writes:
>>
>> > On 26/08/2024 17.26, Peter Xu wrote:
>> >> On Fri, Aug 23, 2024 at 03:13:12PM +0900, Akihiko Odaki wrote:
>> >>> A test run may create boot files several times. Delete the previous boot
>> >>> file before creating a new one.
>> >>>
>> >>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> >>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>> >>> Acked-by: Thomas Huth <thuth@redhat.com>
>> >>
>> >> I didn't track which came early, but I think Fabiano has queued the other
>> >> one here:
>> >>
>> >> https://lore.kernel.org/r/20240820144912.320744-2-peter.maydell@linaro.org
>> >> https://gitlab.com/farosas/qemu/-/commits/migration-staging/
>> >>
>> >> So we should be good.
>> >
>> > Ooops, sorry, I think I might have jumped the gun and put this patch here in
>> > my final PR for 9.1 ... I hope it's ok to do modifications on top of that
>> > later if it is still necessary.
>>
>> It's fine, don't worry. I'll just drop the other one, they're basically
>> the same.
>
> They're not quite the same -- my one also fixes the bug
> where if we run no tests we call bootfile_delete()
> without ever having called bootfile_create() and as
> a result try to unlink(NULL). So if we take Akihiko's
> patch I'll respin my patch to be just that fix.

Ah right, there's the other call at the end of main(). I can touch that
up in migration-staging if it comes to it.

>
> thanks
> -- PMM

