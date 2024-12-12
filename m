Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3C9E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 12:34:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLiP4-0006Ba-TP; Thu, 12 Dec 2024 07:34:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tLiP1-0006A2-T7; Thu, 12 Dec 2024 07:34:47 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tLiOz-00068c-Nu; Thu, 12 Dec 2024 07:34:47 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 31DC12118C;
 Thu, 12 Dec 2024 12:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734006882; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PTAymOVEaL8bvIneGRCaEdJ+Wyy38EPkvob6i+Vnpwg=;
 b=bhNzNAkqn0MgJhARMTYdtNFXnqsXQyg29pN4f49cCn1ZNxN/fEXjiQu4rpVf2KdS2eVjVU
 VZDZaHNKK2qMVHi390sAsAXzLBwKaCHrMgYgyiQFLrsk/avY3M8taoG/0E/rVoiTLUnB4v
 ImGBrT+oIAhBqzJCQufZzCvb1knHM6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734006882;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PTAymOVEaL8bvIneGRCaEdJ+Wyy38EPkvob6i+Vnpwg=;
 b=UI1bjYww+U3FA2WDBMfhujcRdM6OaOPAInL6o73bbE/6taUpA5cFGF8NvVzGrBNF/lNlkj
 4z8vSGFAQpt7pXDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734006882; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PTAymOVEaL8bvIneGRCaEdJ+Wyy38EPkvob6i+Vnpwg=;
 b=bhNzNAkqn0MgJhARMTYdtNFXnqsXQyg29pN4f49cCn1ZNxN/fEXjiQu4rpVf2KdS2eVjVU
 VZDZaHNKK2qMVHi390sAsAXzLBwKaCHrMgYgyiQFLrsk/avY3M8taoG/0E/rVoiTLUnB4v
 ImGBrT+oIAhBqzJCQufZzCvb1knHM6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734006882;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PTAymOVEaL8bvIneGRCaEdJ+Wyy38EPkvob6i+Vnpwg=;
 b=UI1bjYww+U3FA2WDBMfhujcRdM6OaOPAInL6o73bbE/6taUpA5cFGF8NvVzGrBNF/lNlkj
 4z8vSGFAQpt7pXDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70DF013939;
 Thu, 12 Dec 2024 12:34:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wSaAG2HYWmfMSgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 12 Dec 2024 12:34:41 +0000
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
Subject: Re: [PATCH 17/20] tests/qtest: move clock_steps to after checks
In-Reply-To: <20241210204349.723590-18-alex.bennee@linaro.org>
References: <20241210204349.723590-1-alex.bennee@linaro.org>
 <20241210204349.723590-18-alex.bennee@linaro.org>
Date: Thu, 12 Dec 2024 09:34:39 -0300
Message-ID: <87msh1f5b4.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCPT_COUNT_TWELVE(0.00)[43]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; TAGGED_RCPT(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RL99m1pto7gi4rdu4g5kom7ddi)];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[ventanamicro.com,nongnu.org,linux.ibm.com,flygoat.com,gmail.com,linux.alibaba.com,redhat.com,dabbelt.com,quicinc.com,linaro.org,aurel32.net,jms.id.au,ispras.ru,semihalf.com,ilande.co.uk,wdc.com];
 RCVD_TLS_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:email,
 suse.de:mid, linaro.org:email]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> In the qtest environment time will not step forward if the system is
> paused (timers disabled) or we have no timer events to fire. As a
> result VirtIO events are responded to directly and we don't need to
> step time forward.
>
> Potentially the clock_step calls could be removed all together but as
> we may implement async behaviour later lets just move them to after
> the principle check for now.
>
> Future qtest patches will assert that time actually changes with a
> step is requested.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

