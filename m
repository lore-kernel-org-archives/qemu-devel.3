Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD99C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 16:11:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjJFP-0006Gq-MH; Mon, 13 Jul 2026 12:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wjJFL-0006Gf-JQ
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 12:11:07 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wjJFJ-0006sh-H6
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 12:11:06 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7F9463E23;
 Mon, 13 Jul 2026 16:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783959063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PE1FIFqpKedOutoXWNsdJADdVfEbXTvdgRoVk9Ljj2s=;
 b=CFUK7VS3zlMfdzY80vfYKFt+0haWRRuQwuY67ABqSm5XojLAZJ6d0DjQ2cKUrSyCIbtFax
 citBxRFE37e3MlGOB2TqrNEI9vI11xgN3XEwzlRw8gH6DM+6mwDFr+swIUY5sAHQvnNMDa
 nB28AYlTQ+uPn/n7+UWbsdtPTld6TVE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783959063;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PE1FIFqpKedOutoXWNsdJADdVfEbXTvdgRoVk9Ljj2s=;
 b=xqTtXTekDkdiQrTGI+gM3wLVt2l10AcKX89HmCh5BvlXHK7CF53XUUIVu+iSLBK/9DhZeA
 Lk/J7w1Pqorn2rCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783959063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PE1FIFqpKedOutoXWNsdJADdVfEbXTvdgRoVk9Ljj2s=;
 b=CFUK7VS3zlMfdzY80vfYKFt+0haWRRuQwuY67ABqSm5XojLAZJ6d0DjQ2cKUrSyCIbtFax
 citBxRFE37e3MlGOB2TqrNEI9vI11xgN3XEwzlRw8gH6DM+6mwDFr+swIUY5sAHQvnNMDa
 nB28AYlTQ+uPn/n7+UWbsdtPTld6TVE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783959063;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PE1FIFqpKedOutoXWNsdJADdVfEbXTvdgRoVk9Ljj2s=;
 b=xqTtXTekDkdiQrTGI+gM3wLVt2l10AcKX89HmCh5BvlXHK7CF53XUUIVu+iSLBK/9DhZeA
 Lk/J7w1Pqorn2rCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20E1A779AE;
 Mon, 13 Jul 2026 16:11:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GMTeOBYOVWrxFQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 13 Jul 2026 16:11:02 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Pedro Barbuda <pbarbuda@microsoft.com>, Mohamed
 Mediouni <mohamed@unpredictable.fr>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Cornelia Huck
 <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: what is qemu_system_guest_panicked() for?
In-Reply-To: <CAFEAcA9Bkq+L-YmNP2bSqxw-09ZgD=mCUQdGQ=-wF5ySzCJhOA@mail.gmail.com>
References: <CAFEAcA_zmc=Vvs38Qos_gecCmGAbRgDQF-0+x85Ja66nsqrHxA@mail.gmail.com>
 <877bmz54i1.fsf@suse.de>
 <CAFEAcA9Bkq+L-YmNP2bSqxw-09ZgD=mCUQdGQ=-wF5ySzCJhOA@mail.gmail.com>
Date: Mon, 13 Jul 2026 13:11:00 -0300
Message-ID: <8733xm6faj.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUBJECT_ENDS_QUESTION(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[11];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[nongnu.org,redhat.com,microsoft.com,unpredictable.fr,gmail.com,linux.ibm.com];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 13 Jul 2026 at 15:49, Fabiano Rosas <farosas@suse.de> wrote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>> >  - ppc TCG, in powerpc_checkstop(), for a machine check exception I think
>>
>> 1) The Checkstop state is the state the (modern) architecture prescribes
>> the machine transitions to when: a) machine check happens but machine
>> check exceptions are disabled or b) hard-to-recover storage errors. On
>> older user manuals I also see occurrences of checkstop when (a) above
>> happens and a "debug bit" is also set.
>>
>>   603 UM:
>>   "[cpu] must terminate operation by internally gating off all clocks, and
>>   release all outputs to the high impedance state"
>>
>>   750cx UM:
>>   "When a processor is in checkstop state, instruction processing is
>>   suspended and generally cannot resume without the processor being
>>   reset."
>
> Thanks. So since this is in TCG, is this for the case "we emulated
> the CPU ending up in a checkstop situation", rather than "the real
> host hardware is broken" ? Can the guest deliberately provoke real
> hardware into this state, or is it only something you can get into
> when the h/w is broken ?
>

The former, checkstop emulation. The guest cannot cause real hardware to
be in this state, this is the cosmic rays kind of problem.

