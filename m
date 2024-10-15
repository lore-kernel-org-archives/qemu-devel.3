Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F007D1F9DC
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 22:03:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0pdE-0003Mc-9o; Tue, 15 Oct 2024 18:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t0pdC-0003MO-HN
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 18:03:06 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t0pdA-0005or-Nv
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 18:03:06 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3842B1F841;
 Tue, 15 Oct 2024 22:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729029781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WmEljaesCAXSFWxoaR8mZa0GWiXqX7BqAA+QEOqqOKE=;
 b=mPM4avsl29SU8gKJem7LRoPm5n6CYzOESVj4pYIdPI7aQbbNhFdljO1C40NKG0qv9lBr7L
 5ib8tbeFh0kdkEMxRZ9z8MTNOkJWQLQe1y1vHwy/FucRuTYjhGBc+ARjWtI34LcRBXWqp+
 aqCnXRh1kGXRnxKmHfgkzo54/t/s/8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729029781;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WmEljaesCAXSFWxoaR8mZa0GWiXqX7BqAA+QEOqqOKE=;
 b=xbUpawxTZSudzu1Qwvhnm7RJ/lzNlA4JClxBC/vm2Gpl0DvifzHP+AxrATHOV7KZdS24w5
 ijy/HWEySAudHpDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729029781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WmEljaesCAXSFWxoaR8mZa0GWiXqX7BqAA+QEOqqOKE=;
 b=mPM4avsl29SU8gKJem7LRoPm5n6CYzOESVj4pYIdPI7aQbbNhFdljO1C40NKG0qv9lBr7L
 5ib8tbeFh0kdkEMxRZ9z8MTNOkJWQLQe1y1vHwy/FucRuTYjhGBc+ARjWtI34LcRBXWqp+
 aqCnXRh1kGXRnxKmHfgkzo54/t/s/8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729029781;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WmEljaesCAXSFWxoaR8mZa0GWiXqX7BqAA+QEOqqOKE=;
 b=xbUpawxTZSudzu1Qwvhnm7RJ/lzNlA4JClxBC/vm2Gpl0DvifzHP+AxrATHOV7KZdS24w5
 ijy/HWEySAudHpDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA64713A53;
 Tue, 15 Oct 2024 22:03:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RGpVHJTmDmdOBAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 15 Oct 2024 22:03:00 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Stefan Berger <stefanb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: Re: tpm-tis-device-swtpm-test timeout
In-Reply-To: <d9b18dc6-994b-4fdb-8f6c-5cb9bd11eb64@linux.ibm.com>
References: <87jze9qlrp.fsf@suse.de>
 <077cee03-efd0-4716-865a-b9990afb91a3@linux.ibm.com>
 <87h69dqigg.fsf@suse.de>
 <865424c1-f79c-44ad-b70f-8bf3e455e025@linux.ibm.com>
 <87ed4hqgvl.fsf@suse.de>
 <d9b18dc6-994b-4fdb-8f6c-5cb9bd11eb64@linux.ibm.com>
Date: Tue, 15 Oct 2024 19:02:58 -0300
Message-ID: <87ed4hgh2l.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.993]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Stefan Berger <stefanb@linux.ibm.com> writes:

> On 10/15/24 3:57 PM, Fabiano Rosas wrote:
>> Stefan Berger <stefanb@linux.ibm.com> writes:
>> 
>
>>>
>>> So this here is failing for you every time?
>>>
>>> QTEST_QEMU_BINARY=build/qemu-system-aarch64
>>> ./build/tests/qtest/tpm-tis-device-swtpm-test
>> 
>> Sorry, I was unclear. No, that runs for about 30 iterations before it
>> fails. I just ran each of these in a terminal window:
>> 
>> $ for i in $(seq 1 999); do echo "$i =============";  QTEST_QEMU_BINARY=./qemu-system-aarch64 ./tests/qtest/tpm-tis-device-swtpm-test || break ; done
>
> On my Fedora 40 host this command line here alone has been running for 
> 250 loop iterations now and is still continuing.
>
>> $ make -j$(nproc) check
>
> So this needs to be run in parallel to the above command line to cause 
> the failure?
>

Yes, I've been using that method to reproduce live migration race
conditions as well. It's quite effective.

If you don't think you'll be able to find the root cause due to the
unreproducibility on your side, maybe we could at least add an assert
that bcount is not larger than rsp_size. I think that would at least
give an explicit error instead of a buffer overflow.

I can also try to dig deeper into this when I get some time. At the
moment I know nothing about the tpm device emulation.

