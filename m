Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6452EF53D67
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 15:03:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w29Sd-0004KL-TN; Mon, 16 Mar 2026 11:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w29SX-0004JV-TK
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 11:02:23 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w29SV-0005zk-RO
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 11:02:21 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A10E54D2E4;
 Mon, 16 Mar 2026 15:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773673333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lj3yZS9pmiKTb0+kIdrTzc4V9mLttWpVG+uAM8JI9tM=;
 b=QL01AH2+MS4omBDjrksD7abmQw1YjQArrMA66mlMusL623+74PpBA/TS+305OXmfs/RE7n
 cp9H5yFo501xCa4OI+VdDmfkz+0ou+DGyykWMIsHGCgr5nh09bmS11vSUlYk7cd/2W25Ff
 HwnlB0/x5IIwkVFCl5uhc9YT0YAnF1U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773673333;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lj3yZS9pmiKTb0+kIdrTzc4V9mLttWpVG+uAM8JI9tM=;
 b=uQshWJ4NJQ5Cj0Gte9ReT+cW4EhafiAncrASigo10BpHnWr0h/abSXScq9EzBYRJ2+ZKtn
 cZmN1k+q8lY4cHCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773673329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lj3yZS9pmiKTb0+kIdrTzc4V9mLttWpVG+uAM8JI9tM=;
 b=n8B7JC0v/XcjQavFUDVVg1SafwiCYXUOTIf/3ULkFB/KCfmMmaqinRd2D8N/J5hW9dy1ml
 PECsnvmHuJ44ID8w6U8VAj4qLgQO/qrKwYFhGeNR8GgFsrl+xNKx8UBXnLzpFvgjh2Pe2Z
 dgZ3mSN2rQ29KrUWmzqn11ZwJdtuV3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773673329;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lj3yZS9pmiKTb0+kIdrTzc4V9mLttWpVG+uAM8JI9tM=;
 b=2Cq71522DKvnJPdAqQCHEiNCjbe2w9G/NHH5fwCP3cKdt2WaudevBR7K06igazsmUCj9Hx
 aChlWh9nW0Bcb5DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2CB304273B;
 Mon, 16 Mar 2026 15:02:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HgIlOXAbuGklQAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 16 Mar 2026 15:02:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, Alistair
 Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v1 4/4] hw/riscv: Free resources allocated at
 riscv_iommu_instance_init
In-Reply-To: <CAFEAcA8LUzwQLgzAeSswjWZWz0UOn2dmYKcOA7c3PipqLJcnDQ@mail.gmail.com>
References: <20260313182957.28432-1-farosas@suse.de>
 <20260313182957.28432-5-farosas@suse.de>
 <CAFEAcA8LUzwQLgzAeSswjWZWz0UOn2dmYKcOA7c3PipqLJcnDQ@mail.gmail.com>
Date: Mon, 16 Mar 2026 12:02:06 -0300
Message-ID: <87v7evrf69.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[nongnu.org,dabbelt.com,wdc.com,gmail.com,ventanamicro.com,linux.alibaba.com];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email, imap1.dmz-prg2.suse.org:helo,
 suse.de:mid, suse.de:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 13 Mar 2026 at 18:30, Fabiano Rosas <farosas@suse.de> wrote:
>>
>> Add a riscv_iommu_instance_finalize() routine and move there the unref
>> of the iot_cache and ctx_cache hash tables from riscv_iommu_unrealize.
>>
>> Also start freeing the register state masks, also allocated at the
>> _init function.
>>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
> This is the same as
> https://patchew.org/QEMU/20260307125222.3656140-1-peter.maydell@linaro.org/
> which I sent last week.
>

Ah ok, I missed it. Let's drop this one then.

> thanks
> -- PMM

