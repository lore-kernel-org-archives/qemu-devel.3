Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74CEFD185F0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 12:57:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdpZX-0003Yx-02; Thu, 08 Jan 2026 07:57:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vdpZP-0003UQ-AK
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 07:56:55 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vdpZN-0005ju-Nc
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 07:56:55 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EF1465C4F0;
 Thu,  8 Jan 2026 12:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767877012; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ltrDkUAWG4KPG7mtQbZcDH7lnlwsr80SG0VBtboHarQ=;
 b=GU2XOC/lGoXrgHGxmVelU3s8I/8T85BcgESdt6hqCzMtJpw0UVGTbWHgzJujHU/kxp+5ZD
 EAhRIwiYrJI4QKwH5y4BiLP33tkUUBl0SpQBc7VdvxqYBE83wAOo6Bj8TfcNtEtK6Y8+Ht
 62ry4ipHXy6epLC/ji/66WEEWGkbVXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767877012;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ltrDkUAWG4KPG7mtQbZcDH7lnlwsr80SG0VBtboHarQ=;
 b=MVdSGMKwvqO2szL5Ow4VgWHQYQVRb4D1HxoOx9/oJPEPF57/EpcmKfw4prKoBIyw9atW0B
 e2XlrJ0hPTUwwDCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767877011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ltrDkUAWG4KPG7mtQbZcDH7lnlwsr80SG0VBtboHarQ=;
 b=NHflQ5TZPK7cT8SITDSsBq5oMM0yJLvyCAuIXhb26qzJphmk5Mfa/mmRElnGgbxHWeCvyJ
 nDb5YNGkAv9qZueenw3WH1lESQhOFd0yD321A90o7LG8kOZl9p8zi46GQWXaj+49ntNCYR
 ar3mzvzSqbGK23Q3+jZh1xxcfQjkKY0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767877011;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ltrDkUAWG4KPG7mtQbZcDH7lnlwsr80SG0VBtboHarQ=;
 b=h1LSN/06jI5i3MgFlBpIu5ShDaZpviY30jpGvsyYjNxUJaQq3VYXeJBxt85/YjYCbSYdP3
 UT05Rq0ZZPMW0uDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 680A43EA63;
 Thu,  8 Jan 2026 12:56:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Oia3CpOpX2lgaAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 08 Jan 2026 12:56:51 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, peterx@redhat.com, Fabian Vogt <fvogt@suse.de>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 gautam@linux.ibm.com
Subject: Re: [PATCH v2 1/2] target/ppc: Fix env->quiesced migration
In-Reply-To: <31a61dff-d30d-4c93-8fc1-391c99d32b42@linux.ibm.com>
References: <20251217164549.4311-1-farosas@suse.de>
 <20251217164549.4311-2-farosas@suse.de>
 <7c64764f-5f38-435f-a68d-a935891da864@linux.ibm.com>
 <31a61dff-d30d-4c93-8fc1-391c99d32b42@linux.ibm.com>
Date: Thu, 08 Jan 2026 09:56:48 -0300
Message-ID: <87bjj41cvj.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_SEVEN(0.00)[8];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,suse.de,gmail.com,linux.ibm.com];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
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

Harsh Prateek Bora <harshpb@linux.ibm.com> writes:

> One minor comment below:
>
> <snip>
>
> On 05/01/26 2:30 pm, Harsh Prateek Bora wrote:
>>> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
>>> index d72e5ecb94..ba63a7debb 100644
>>> --- a/target/ppc/machine.c
>>> +++ b/target/ppc/machine.c
>>> @@ -6,6 +6,7 @@
>>> =C2=A0 #include "mmu-hash64.h"
>>> =C2=A0 #include "migration/cpu.h"
>>> =C2=A0 #include "qapi/error.h"
>>> +#include "qemu/error-report.h"
>
> I do not see any error reporting being added in the patch below.
> Does this header inclusion need to be removed ?
>

Well spotted, that's a leftover from a previous implementation.


