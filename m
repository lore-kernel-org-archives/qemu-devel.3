Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B857AC0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 12:20:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdq06-00028y-A1; Fri, 31 Jan 2025 07:19:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tdq04-00028d-Aq; Fri, 31 Jan 2025 07:19:56 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tdq02-0003sR-Ea; Fri, 31 Jan 2025 07:19:55 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 711441F38F;
 Fri, 31 Jan 2025 12:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738325990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NNAbRgWNC0eO8xqPR27cbKytqzUbp9Ny3FUu3rnfBqU=;
 b=rdAJip01CBM2xhM0ZQS8qyVK5DmaB2LDxp6QJgRToClGrKplcCXTQg0FoW0V3e/YUYkBvN
 cqNc7TmmcCgc2EuPsfe1T82ASFXSlM2D9y4DaDEHy2sHZEU7seVv79uRYvTdlY/TuL8NJD
 7lT4oJTDz4ngSyQGc2vM8OJSmiVhDdk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738325990;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NNAbRgWNC0eO8xqPR27cbKytqzUbp9Ny3FUu3rnfBqU=;
 b=iv3ST8IdTn3+U486Dk1jT3tqHwKBi74nWkdDnp3X9fuoSULwUonb1i8PZrjGyljmH39PCl
 sDyFYHhG3/HSncCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738325990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NNAbRgWNC0eO8xqPR27cbKytqzUbp9Ny3FUu3rnfBqU=;
 b=rdAJip01CBM2xhM0ZQS8qyVK5DmaB2LDxp6QJgRToClGrKplcCXTQg0FoW0V3e/YUYkBvN
 cqNc7TmmcCgc2EuPsfe1T82ASFXSlM2D9y4DaDEHy2sHZEU7seVv79uRYvTdlY/TuL8NJD
 7lT4oJTDz4ngSyQGc2vM8OJSmiVhDdk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738325990;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NNAbRgWNC0eO8xqPR27cbKytqzUbp9Ny3FUu3rnfBqU=;
 b=iv3ST8IdTn3+U486Dk1jT3tqHwKBi74nWkdDnp3X9fuoSULwUonb1i8PZrjGyljmH39PCl
 sDyFYHhG3/HSncCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D445D133A6;
 Fri, 31 Jan 2025 12:19:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id boRVI+W/nGdcUQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 31 Jan 2025 12:19:49 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Alistair Francis <alistair23@gmail.com>, Ivan Klokov
 <ivan.klokov@syntacore.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 lvivier@redhat.com, pbonzini@redhat.com
Subject: Re: [PATCH v9 0/2] Support RISC-V CSR read/write in Qtest environment
In-Reply-To: <CAKmqyKNgPj+o3X6rN5-ru2jMfH3VHPLP094CAhbDA8_JJEE+gA@mail.gmail.com>
References: <20250109091044.32723-1-ivan.klokov@syntacore.com>
 <CAKmqyKNgPj+o3X6rN5-ru2jMfH3VHPLP094CAhbDA8_JJEE+gA@mail.gmail.com>
Date: Fri, 31 Jan 2025 09:19:47 -0300
Message-ID: <87o6znkwf0.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.98%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[12]; TAGGED_RCPT(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[nongnu.org,dabbelt.com,wdc.com,gmail.com,ventanamicro.com,linux.alibaba.com,redhat.com];
 FREEMAIL_TO(0.00)[gmail.com,syntacore.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Alistair Francis <alistair23@gmail.com> writes:

> On Thu, Jan 9, 2025 at 7:13=E2=80=AFPM Ivan Klokov <ivan.klokov@syntacore=
.com> wrote:
>>
>> These patches add functionality for unit testing RISC-V-specific registe=
rs.
>> The first patch adds a Qtest backend, and the second implements a simple=
 test.
>>
>> ---
>> v9:
>>    - Fix build errors.
>> v8:
>>    - Delete RFC label.
>> v7:
>>    - Fix build errors, add Reviewed-by, Acked-by.
>> ---
>>
>> Ivan Klokov (2):
>>   target/riscv: Add RISC-V CSR qtest support
>>   tests/qtest: QTest example for RISC-V CSR register
>
> Do you mind rebasing on
> https://github.com/alistair23/qemu/tree/riscv-to-apply.next ?
>

This was already merged via the qtest tree. I forgot to post a message
to this thread, sorry.

