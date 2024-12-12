Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A73A4E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 12:37:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLiQr-0007av-Bh; Thu, 12 Dec 2024 07:36:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tLiQp-0007Z2-3G; Thu, 12 Dec 2024 07:36:39 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tLiQn-0006TU-HE; Thu, 12 Dec 2024 07:36:38 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 811A51F74A;
 Thu, 12 Dec 2024 12:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734006992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G5rb0zuzG1zX+tx5ZdfNxy+q2cVTEdQUFsA/RUY4S08=;
 b=FFDJgShwC/teAFpyazR41IxgRH6RNEj0X965BkFbWJeWJKGiXNFMtE/lmo1TgO07dOdFZI
 +AKuWudhDtWS+YWDA53910xB6Oow0EmptboxE2Dt72GbkKDOzTbYpzst+gih6p14HB0TKu
 H0xes4dt61sTmeOr2QkXqqHOePJ39NY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734006992;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G5rb0zuzG1zX+tx5ZdfNxy+q2cVTEdQUFsA/RUY4S08=;
 b=p2zFaBT/8vxj9gaEKRqQMgq6I7PV6st3vprsZvoTNEESrJ5mu/F9C9tMDl/bdtEgWGRkk4
 E6YR6wauK3MgY2DQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=k8XEafpC;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=129bsKRN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734006991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G5rb0zuzG1zX+tx5ZdfNxy+q2cVTEdQUFsA/RUY4S08=;
 b=k8XEafpC51n86f9MW2wJdxt1zTAxzfnfI1ivSkPwCJgDFRGMpxY5tVWNleKXMvWlkFUwbX
 Bj+QIiHsO5l+PYLm7IdSwETvs7oov9XpK7bRHaCXxY+hFqTq5Fzbux0S6ofICAfAKK2SF3
 9EbYEqMn2DhktTli+7I6kkcHW5F7GAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734006991;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G5rb0zuzG1zX+tx5ZdfNxy+q2cVTEdQUFsA/RUY4S08=;
 b=129bsKRNjg8Dka6AO1SHLHzj29duiv1/Jv22WcEogeFcVYU8YasalFTYNG8hlgXA8UA2Dw
 DnuJkRukLBp5KnAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA21C13939;
 Thu, 12 Dec 2024 12:36:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VYdSLc7YWmdYSwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 12 Dec 2024 12:36:30 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Cleber Rosa <crosa@redhat.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Leif Lindholm <quic_llindhol@quicinc.com>,
 Eric Farman <farman@linux.ibm.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, John Snow <jsnow@redhat.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Harsh Prateek Bora
 <harshpb@linux.ibm.com>, Aurelien Jarno <aurelien@aurel32.net>, Paolo
 Bonzini <pbonzini@redhat.com>, Joel Stanley <joel@jms.id.au>, Bernhard
 Beschow <shentey@gmail.com>, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-arm@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Richard Henderson
 <richard.henderson@linaro.org>, Marcin Juszkiewicz
 <marcin.juszkiewicz@linaro.org>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Beraldo Leal <bleal@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, Radoslaw Biernacki <rad@semihalf.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Alex
 =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Nicholas Piggin <npiggin@gmail.com>, Mark
 Cave-Ayland <mark.cave-ayland@ilande.co.uk>, "Michael S. Tsirkin"
 <mst@redhat.com>, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH 18/20] system/qtest: properly feedback results of
 clock_[step|set]
In-Reply-To: <20241210204349.723590-19-alex.bennee@linaro.org>
References: <20241210204349.723590-1-alex.bennee@linaro.org>
 <20241210204349.723590-19-alex.bennee@linaro.org>
Date: Thu, 12 Dec 2024 09:36:28 -0300
Message-ID: <87jzc5f583.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 811A51F74A
X-Spamd-Result: default: False [-2.81 / 50.00]; BAYES_HAM(-2.80)[99.15%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[43];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MID_RHS_MATCH_FROM(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[ventanamicro.com,nongnu.org,linux.ibm.com,flygoat.com,gmail.com,linux.alibaba.com,redhat.com,dabbelt.com,quicinc.com,linaro.org,aurel32.net,jms.id.au,ispras.ru,semihalf.com,ilande.co.uk,wdc.com];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 TAGGED_RCPT(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RL4imt8pjjaa6sqn3s4gq691sb)];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, gitlab.com:url, suse.de:email, suse.de:dkim,
 suse.de:mid, linaro.org:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Time will not advance if the system is paused or there are no timer
> events set for the future. In absence of pending timer events
> advancing time would make no difference the system state. Attempting
> to do so would be a bug and the test or device under test would need
> fixing.
>
> Tighten up the result reporting to `FAIL` if time was not advanced.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2687

Acked-by: Fabiano Rosas <farosas@suse.de>

