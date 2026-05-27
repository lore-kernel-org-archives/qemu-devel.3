Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8854CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 12:20:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSDFP-0000HL-Nh; Wed, 27 May 2026 08:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wSDFO-0000GH-V4
 for qemu-devel@nongnu.org; Wed, 27 May 2026 08:20:30 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wSDFE-0005FC-1C
 for qemu-devel@nongnu.org; Wed, 27 May 2026 08:20:30 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5771566D8C;
 Wed, 27 May 2026 12:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1779884413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SMh2ZbfWuMrYqMLc50GjJSV3MmJVgG0EOPNs56bHIgg=;
 b=aqc7VH3hXxv9cFhGFC4AxxF1NoAkZa/hvVw1YMJVzbSiTMLdVH3Y60nLO65l8HA7YLHMFT
 bD0ju4jPwuS0o+jjA7NtcnuaV/EgB2xEVzSw3J21TkGIK2v5Revqeu/tAizofsfVyect0F
 tXH28/8q08rT4mcVBkUthZhzMWZyOQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1779884413;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SMh2ZbfWuMrYqMLc50GjJSV3MmJVgG0EOPNs56bHIgg=;
 b=GWIcmqWIPwzSm+ThoKSenn6kGrbwmHGjTn0bGIyAmzlRFuJDPMWKmjOxCkIjm7gJkYoa7o
 39nqMcA99g1UfHBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=aqc7VH3h;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GWIcmqWI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1779884413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SMh2ZbfWuMrYqMLc50GjJSV3MmJVgG0EOPNs56bHIgg=;
 b=aqc7VH3hXxv9cFhGFC4AxxF1NoAkZa/hvVw1YMJVzbSiTMLdVH3Y60nLO65l8HA7YLHMFT
 bD0ju4jPwuS0o+jjA7NtcnuaV/EgB2xEVzSw3J21TkGIK2v5Revqeu/tAizofsfVyect0F
 tXH28/8q08rT4mcVBkUthZhzMWZyOQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1779884413;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SMh2ZbfWuMrYqMLc50GjJSV3MmJVgG0EOPNs56bHIgg=;
 b=GWIcmqWIPwzSm+ThoKSenn6kGrbwmHGjTn0bGIyAmzlRFuJDPMWKmjOxCkIjm7gJkYoa7o
 39nqMcA99g1UfHBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E12E95A817;
 Wed, 27 May 2026 12:20:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id x/EILHzhFmqDXwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 27 May 2026 12:20:12 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Michael Tokarev <mjt@tls.msk.ru>, Alistair Francis
 <Alistair.Francis@wdc.com>, "vulab@iscas.ac.cn" <vulab@iscas.ac.cn>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>
Cc: "chao.liu.zevorn@gmail.com" <chao.liu.zevorn@gmail.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>, Peter Xu
 <peterx@redhat.com>
Subject: Re: [PATCH v1] target/riscv: Add mseccfg to VMStateDescription
In-Reply-To: <bf46f39c-6173-4cfd-b374-63529892a1fb@tls.msk.ru>
References: <20260511124828.3210477-1-vulab@iscas.ac.cn>
 <bcc0aaa1-8d1c-4f52-a681-85bc903c8d66@tls.msk.ru>
 <6e42ecc1026a057e07e73386463bd57e1467a46f.camel@wdc.com>
 <bf46f39c-6173-4cfd-b374-63529892a1fb@tls.msk.ru>
Date: Wed, 27 May 2026 09:20:10 -0300
Message-ID: <87ecix59j9.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 5771566D8C
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; ARC_NA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[12];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 TO_DN_EQ_ADDR_SOME(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,nongnu.org,oss.qualcomm.com,linux.alibaba.com,redhat.com];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 TAGGED_RCPT(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:dkim,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Michael Tokarev <mjt@tls.msk.ru> writes:

> On 27.05.2026 02:57, Alistair Francis wrote:
>> On Tue, 2026-05-26 at 10:26 +0300, Michael Tokarev wrote:
>
>>> This change has been nominated for inclusion into previous stable
>>> releases by Alistar.=C2=A0 However I've a concern here: can we add new
>>> fields to older machine descriptions this way, and stay migratable?
>>=20
>> I was under the impression that we could, but as I write this I start
>> to think that no we can't.
>>=20
>> We don't have to backport this then
>
> hmm.
>
>>> I understand riscv machine is not versioned.=C2=A0 How does migration w=
ork
>>> in the first place?
>>=20
>> As in the virt machine isn't versioned? or `vmstate_riscv_cpu` isn't
>> versioned?
>
> For i386, we've pc-q35-10.0, pc-8.2, etc - versioned after qemu.
> Each version has strictly defined set of properties, and there's
> conversion between different versions when doing cross-version=20
> migration.  So it's possible to migrate a VM when the set of
> properties changes.
>
> I don't see similar construct for riscv.  And since we do change
> things in there, modifying set of properties in various areas in
> the migration stream, - I dunno how migration works in riscv qemu
> land.  So I'm asking.. :)
>

There are no migration compatibility guarantees for an unversioned
machine type. Only migration and snapshots from same-version QEMUs are
expected to work in this case. Other scenarios may or may not work.

>  From what I understand, migration should fail when the target qemu
> has different set of properties compared to the current one, - no?
>

The addition from this patch is in a subsection, so .needed will
determine whether it will be put on the stream. If we backport the
change, then the stable QEMU build will (likely) start sending this
subsection, which the old, non-stable QEMU will not recognize and
migration will fail. Migration from stable-stable would likely work.

So any stable versions that (would) contain this patch are likely to
block migration from that version into an unpatched QEMU.

Note that since the machine is unversioned, migration from QEMU x to
QEMU x+1 is already prone to being broken.

> But if it works, we should apply this patch to older/stable releases,
> there should be no issues in there.
>
> But again, I don't understand the mechanism here.
>
> I'm adding Peter and Fabiano to Cc (maintainers of the migration code),
> -- can you clarify please?
>

@Peter, I hope I got it right, feel free to correct me.

> Thanks,
>
> /mjt

