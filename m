Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 352AFE77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 20:16:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVFyf-0002Dn-2P; Tue, 07 Jan 2025 15:15:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tVFyd-0002Cs-FW; Tue, 07 Jan 2025 15:14:59 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tVFyb-0005U0-VI; Tue, 07 Jan 2025 15:14:59 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C235521157;
 Tue,  7 Jan 2025 20:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736280894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bv7BPME/5/gl0L616sWa6w6nSBNzlk/FFrlu2lR6zGY=;
 b=rYI382XVe7ReJN1APaN0T4dFLDdV6If4aiaGLge9fKruGr5uYwWCmNYq662wwVbQyZLgkm
 BwgRhEDQ95kNdHBPJn3ZfanKa19z0Rcqk8Vd3X3mv2DBLns6FxZEl1nSn1/PIyHhOmW+F+
 045HSyCZmwBrgq1L0ivlZ2BQHTbFHZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736280894;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bv7BPME/5/gl0L616sWa6w6nSBNzlk/FFrlu2lR6zGY=;
 b=BsZKxuszPjwlMId2+uEG6c8osMaW9LK9axOsdW/SkRNMU4yJGZLi4JRpdYp27uRXkKfVtl
 lb2HRNNvs/cXDJAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736280893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bv7BPME/5/gl0L616sWa6w6nSBNzlk/FFrlu2lR6zGY=;
 b=o1HXIoStLCLW+E+epHgPpfY1ejPc/MuqCJ96Fvr3TYWK34EZgccwHlHwASpVD5oJ5Q7mRL
 PA1Mlq+SmC/dPG/8V0dIXs7qdN8XC5dME2IjaJkuPOQtK8d/16yUs8cyu5Vl6VhuedS7GQ
 JEVyJAOQpk7QAJdhyhRHLMszUgDEPQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736280893;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bv7BPME/5/gl0L616sWa6w6nSBNzlk/FFrlu2lR6zGY=;
 b=XpMoZNKcxPKut/RlWUBM2xL8/dMfc7lTkFoNWKTF4Ud1rKtPIAPKaY5RVxxQQlB8YvbaYM
 AOas6kXaE76agmBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0BBDD13A6A;
 Tue,  7 Jan 2025 20:14:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kCyNAj2LfWceHwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 07 Jan 2025 20:14:53 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Beraldo Leal
 <bleal@redhat.com>, Ed Maste <emaste@freebsd.org>, Halil Pasic
 <pasic@linux.ibm.com>, qemu-ppc@nongnu.org, John Snow <jsnow@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>, Nicholas Piggin
 <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>, Leif Lindholm
 <quic_llindhol@quicinc.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bin Meng <bmeng.cn@gmail.com>, Daniel
 Henrique Barboza <dbarboza@ventanamicro.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, qemu-riscv@nongnu.org, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Wainer dos Santos Moschetta
 <wainersm@redhat.com>, qemu-s390x@nongnu.org, Alistair Francis
 <alistair.francis@wdc.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Weiwei Li <liwei1518@gmail.com>, Harsh Prateek Bora
 <harshpb@linux.ibm.com>, qemu-arm@nongnu.org, Li-Wen Hsu
 <lwhsu@freebsd.org>, Palmer Dabbelt <palmer@dabbelt.com>, Daniel Henrique
 Barboza <danielhb413@gmail.com>, Richard Henderson
 <richard.henderson@linaro.org>, Cleber Rosa <crosa@redhat.com>, Marcin
 Juszkiewicz <marcin.juszkiewicz@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>, Aurelien
 Jarno <aurelien@aurel32.net>, Eric Farman <farman@linux.ibm.com>, Pavel
 Dovgalyuk <pavel.dovgaluk@ispras.ru>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier
 <laurent@vivier.eu>, Joel Stanley <joel@jms.id.au>, =?utf-8?Q?Daniel_P=2E?=
 =?utf-8?Q?_Berrang=C3=A9?=
 <berrange@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Bernhard
 Beschow <shentey@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 16/29] tests/qtest: remove clock_steps from virtio tests
In-Reply-To: <20250107165208.743958-17-alex.bennee@linaro.org>
References: <20250107165208.743958-1-alex.bennee@linaro.org>
 <20250107165208.743958-17-alex.bennee@linaro.org>
Date: Tue, 07 Jan 2025 17:12:31 -0300
Message-ID: <87ikqq4c40.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.79 / 50.00]; BAYES_HAM(-2.99)[99.95%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCPT_COUNT_TWELVE(0.00)[46]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; TAGGED_RCPT(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RL99m1pto7gi4rdu4g5kom7ddi)];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[ilande.co.uk,redhat.com,freebsd.org,linux.ibm.com,nongnu.org,semihalf.com,gmail.com,quicinc.com,linaro.org,ventanamicro.com,wdc.com,linux.alibaba.com,dabbelt.com,aurel32.net,ispras.ru,flygoat.com,vivier.eu,jms.id.au];
 RCVD_TLS_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
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
> We still do timeout processing to handle the fact the target QEMU may
> not be ready to respond right away. This will usually be due to a slow
> CI system or if QEMU is running under something like rr.
>
> Future qtest patches will assert that time actually changes when a
> step is requested.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

