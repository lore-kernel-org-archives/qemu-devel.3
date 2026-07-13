Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2CF0C44501
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 13:02:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjGHp-0000Kj-BE; Mon, 13 Jul 2026 09:01:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wjGHM-0000GW-Js
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 09:01:07 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wjGHK-0007Lp-NY
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 09:01:00 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CF8C57781A;
 Mon, 13 Jul 2026 13:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783947650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qv96/5guzHxPYoLinf47l1CjzkjcX3/nWNpsisGpUIo=;
 b=iyP+EEKaY2yKlNq4O4UJ13JnEHHLaJU9Evzv3v/ImMeJdFmJvqYl1OKJA/FRfBRyJcxtKE
 rs/H3rpJZwWPllYn9zE1VL7KkFotjiwplnfYQqiVqtb36fD9J5sSS/Awp36tddUZEoqfTl
 zplsyuHyQZWMkwCMffSVsA1OhcopeFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783947650;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qv96/5guzHxPYoLinf47l1CjzkjcX3/nWNpsisGpUIo=;
 b=9U0Yd/Lw7ojpASCpwhp5fwXho8BoBUxo+PixMKWTlNdBlPUzx96aAfwgcWFbk9QksRAlUO
 u3nIEOvC0vQR1CBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783947645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qv96/5guzHxPYoLinf47l1CjzkjcX3/nWNpsisGpUIo=;
 b=VJZxZaKwD/WzCN1wNcYcO+6pzqJ4DJ0YejsMikDjvpS17GP37neOcsmakD4TwgK73Ln7eg
 jXzuI9dL+yL7BEqZMZ7+bVb5j4mDYhpySri3TnWAu8EdP616tdqU7stSbGbKxDSSXwWBJu
 bL192Ybi9hElszv1YuC5xa7VuuUVcPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783947645;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qv96/5guzHxPYoLinf47l1CjzkjcX3/nWNpsisGpUIo=;
 b=0gFxOXzjCWvk0lbyGdxmAdRndcpwwjbMJIUafot4UDWlsne3Ot+tcp0QaZ38M8lRxQC9Yv
 m6Nc196Rs27vqGCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 676DD779AE;
 Mon, 13 Jul 2026 13:00:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dkh9Dn3hVGp9UQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 13 Jul 2026 13:00:45 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Michael Tokarev <mjt@tls.msk.ru>, Daniel Henrique Barboza
 <daniel.barboza@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 andrew.jones@oss.qualcomm.com, nutty.liu@hotmail.com, Palmer Dabbelt
 <palmer@dabbelt.com>, Tao Tang <tangtao1634@phytium.com.cn>, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PATCH v2 2/3] hw/riscv/riscv-iommu.c: fault when !PTE_U and no
 priv access
In-Reply-To: <731566cb-bbdd-418f-b80e-f68750f24212@tls.msk.ru>
References: <20260701121111.537654-1-daniel.barboza@oss.qualcomm.com>
 <20260701121111.537654-3-daniel.barboza@oss.qualcomm.com>
 <731566cb-bbdd-418f-b80e-f68750f24212@tls.msk.ru>
Date: Mon, 13 Jul 2026 10:00:43 -0300
Message-ID: <87tsq3doxw.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,hotmail.com];
 MISSING_XM_UA(0.00)[]; TAGGED_RCPT(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[15]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; SUBJECT_HAS_EXCLAIM(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[nongnu.org,wdc.com,gmail.com,linux.alibaba.com,oss.qualcomm.com,hotmail.com,dabbelt.com,phytium.com.cn,redhat.com];
 MID_RHS_MATCH_FROM(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, gitlab.com:url,
 qualcomm.com:email, suse.de:mid]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Michael Tokarev <mjt@tls.msk.ru> writes:

> On 7/1/26 15:11, Daniel Henrique Barboza wrote:
>> All IOMMU accesses are assumed to be user mode unless told otherwise,
>> i.e. we have a process_id.  In case we have a non-user mode leaf PTE
>> (PTE_U isn't set) and we are running in user mode, we need to throw a
>> fault.
>> 
>> This also reflects on qos-riscv-iommu tests: the tests always run in
>> user mode so our PTEs must have PTE_U (bit 0x10) set.
>> 
>> Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3553
>> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>> Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
>> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
>
> ...
>> --- a/tests/qtest/libqos/qos-riscv-iommu.h
>> +++ b/tests/qtest/libqos/qos-riscv-iommu.h
>> @@ -54,8 +54,8 @@
>>    * PTE masks for RISC-V IOMMU page tables.
>>    * Values match PTE_V, PTE_R, PTE_W, PTE_A, PTE_D in target/riscv/cpu_bits.h
>>    */
>> -#define QRIOMMU_NON_LEAF_PTE_MASK   0x001  /* PTE_V */
>> -#define QRIOMMU_LEAF_PTE_RW_MASK    0x0c7  /* V|R|W|A|D */
>> +#define QRIOMMU_NON_LEAF_PTE_MASK   0x011  /* PTE_V | PTE_U */
>> +#define QRIOMMU_LEAF_PTE_RW_MASK    0x0d7  /* V | R | W | A | D | PTE_U */
>>   #define QRIOMMU_PTE_PPN_MASK        0x003ffffffffffc00ull
>>   
>>   /* Address-space base offset for test tables */
>
> So, this patch adds a fix for the testing bits.
>
> When trying to pick this one up for 10.0.x (LTS) series, I've another doubt.
> This testing fix fixes v10.2.0-1299-g9d8ffbfc1d3 "tests/qtest/libqos: Add RISC-V
> IOMMU helper library".  Quite some tests were added based on that library.
> It doesn't exist in 10.0.x, and neither is v10.2.0-656-g489812e32df
> "tests/qtest/libqos: Add SMMUv3 helper library".
> Sure I can drop the parts of this change which touches the tests.  But this
> means we don't have tests to cover the issues being fixed, and I don't know
> if the result of these fixes actually works or not.
>
> Should we pick up some testing bits in this area for 10.0.x (especially
> 9d8ffbfc1d3 and some subsequent commits which use this library)?  Or just
> ignore all riscv iommu patches in there?
>

I worry picking tests for stable could become a development task,
requiring new code to make tests suitable for an older codebase/test
codebase.

The test frameworks and their supporting infrastructure (such as the
riscv iommu lib) don't ensure a stable abi so that a test from one
version will run without issues when backported to an earlier
version.

Also, the tests are usually not structured in a way that allow us to
pick just the part that tests the code fixes being backported, so we
risk trying to test in an earlier version features that don't even exist
at that point. There could also exist a complex graph of what's broken
vs. what is being tested (e.g. broken in v10, fixed partially in v11,
then test needs change, then fixed properly in v12, test needs change
again, etc).

> Thanks,
>
> /mjt

