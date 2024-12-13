Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8EECE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 21:09:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMCtw-0007hD-Tr; Fri, 13 Dec 2024 16:08:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tMCtn-0007eO-MQ; Fri, 13 Dec 2024 16:08:36 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tMCtg-00053O-L2; Fri, 13 Dec 2024 16:08:35 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9F9D41F445;
 Fri, 13 Dec 2024 21:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734124105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SHyzxtarHkYo/Ub+P5GaBCJTpvJ9TvsN7wsgMK/v8v4=;
 b=GITEMozL5u2j3Gkr7yjiZYwU67B5ElfqrrsNjtob5PHE1ROnDnylVm4vJAt9XhyxPLq1hR
 guzPHDVXVgneDUMPrjE7uEYilLEuZioTVU9vEpa7vjLpU04vQmQqSYOFj8aRxbwuC1RP2t
 ov9syaatU8d7JTo0yfy3EYETTZJwIdY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734124105;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SHyzxtarHkYo/Ub+P5GaBCJTpvJ9TvsN7wsgMK/v8v4=;
 b=+ij6mMCthBs8ENLuV/OuirOVRUagUiVuWg2Y8JSyVCsXI6qLe9SFmuVFUkY3nHUPSWLnX5
 608hEd4D8gn/hfBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cA9j7oAL;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=co41yfLP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734124104; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SHyzxtarHkYo/Ub+P5GaBCJTpvJ9TvsN7wsgMK/v8v4=;
 b=cA9j7oALCEgMG9PtKuhk5zcGNlLx8CuCEKGGyN/L9PmI5Iw24r63S9cH9IhcGKraKbfurJ
 mIdlvU43Bpt7Ku8401mcUubuPjKFqaNFIcDLqcRWidhdE3P0eiV8k8kgHSA42l0Z4/luxs
 3onMmTeC6aciupR21u0hQ456xoUFfTg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734124104;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SHyzxtarHkYo/Ub+P5GaBCJTpvJ9TvsN7wsgMK/v8v4=;
 b=co41yfLPVnEUG4SSubyI/lbGhEthzbqk67PFXITecln2gbqAA22w4vk+WA9kj3FRJwlOV2
 W7AqipbK5unwTBBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11A6213927;
 Fri, 13 Dec 2024 21:08:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Ur3+MUeiXGchKgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 13 Dec 2024 21:08:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Nabih Estefan <nabihestefan@google.com>
Cc: Thomas Huth <thuth@redhat.com>, peter.maydell@linaro.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com,
 pbonzini@redhat.com, roqueh@google.com, venture@google.com, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] tests/qtest/sse-timer-test: Add watchdog reset to
 sse-timer test
In-Reply-To: <CA+QoejUUQK5L2LOgDPdK=kBgWgQQcvSMzXJ1zAiuwmoNwroPxg@mail.gmail.com>
References: <20241213002602.4181289-1-nabihestefan@google.com>
 <f03adc63-5167-4982-90e6-70b65f0c90cc@redhat.com> <87y10jctbd.fsf@suse.de>
 <CA+QoejUUQK5L2LOgDPdK=kBgWgQQcvSMzXJ1zAiuwmoNwroPxg@mail.gmail.com>
Date: Fri, 13 Dec 2024 18:08:21 -0300
Message-ID: <87frmrxpdm.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 9F9D41F445
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_SEVEN(0.00)[10];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Nabih Estefan <nabihestefan@google.com> writes:

> From what I can tell this is the same issue Thomas was looking at yes.
>
> I saw the failure on the master branch at the v9.2.0 tag (ae35f033) and just
> re-tested it against (83aaec1d) and still see it. I haven't seen it be an
> intermittent failure, it has failed 100% of the time that I have tested it when
> targeting arm-softmmu.

Could you please post the output of:

QTEST_LOG=1 QTEST_TRACE="sse_*" QTEST_QEMU_BINARY=./qemu-system-arm ./tests/qtest/sse-timer-test

Also your compiler version.

>
> However, you are right that with Phillippe's series on top of my change the
> bug is somehow re-introduced. Not sure what the protocol is here since
> neither patch has landed

I would like to figure out why this reproduces 100% for you (and some CI
job) and 0% for me and others. Once this is clear we can merge this
patch.

As for the other series let's leave the issues there to be discussed in
its own thread.

