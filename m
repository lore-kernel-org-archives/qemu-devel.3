Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78BF4CA0EE4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 18:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umzLE-0005s5-La; Fri, 15 Aug 2025 14:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1umzLA-0005qk-Po
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 14:39:48 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1umzL9-0002FL-86
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 14:39:48 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 81EE5218EE;
 Fri, 15 Aug 2025 18:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755283185; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Ej2Ok+biXVHTfNjORu91Oo9gze8O7b0RhsmkqgK1D0=;
 b=Mf/JYfSkVeZcRF4lXOJ/ALZfLrHMHMwVJutjg5du49pQyEtgKJugcodoj6dC5/s3QzxpZB
 0iEuH5maFYTURXOaTuvGGsSAz2XyEP7+It8zBFyiYrD56NdeKgmGVOUZ1FeUijPkN7mJj4
 nl3LFO3xbAQfcun0fekALCpC+rCGi+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755283185;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Ej2Ok+biXVHTfNjORu91Oo9gze8O7b0RhsmkqgK1D0=;
 b=kDZxrRBhbd3sUv/ui2J4qOQgY4oSSPU09zZK7PdtJAcz294mHSIbUZQvyDZO1dfRtpvNGw
 fkjtJs2DNmSnGdBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Mf/JYfSk";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kDZxrRBh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755283185; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Ej2Ok+biXVHTfNjORu91Oo9gze8O7b0RhsmkqgK1D0=;
 b=Mf/JYfSkVeZcRF4lXOJ/ALZfLrHMHMwVJutjg5du49pQyEtgKJugcodoj6dC5/s3QzxpZB
 0iEuH5maFYTURXOaTuvGGsSAz2XyEP7+It8zBFyiYrD56NdeKgmGVOUZ1FeUijPkN7mJj4
 nl3LFO3xbAQfcun0fekALCpC+rCGi+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755283185;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Ej2Ok+biXVHTfNjORu91Oo9gze8O7b0RhsmkqgK1D0=;
 b=kDZxrRBhbd3sUv/ui2J4qOQgY4oSSPU09zZK7PdtJAcz294mHSIbUZQvyDZO1dfRtpvNGw
 fkjtJs2DNmSnGdBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE90C13876;
 Fri, 15 Aug 2025 18:39:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nM9CKvB+n2h7SAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 15 Aug 2025 18:39:44 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Arun Menon <armenon@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Cornelia Huck
 <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Eric Farman
 <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Richard Henderson
 <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>, Ilya
 Leoshkevich <iii@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, Alex Williamson
 <alex.williamson@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>, Steve
 Sistare <steven.sistare@oracle.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Hailiang Zhang <zhanghailiang@xfusion.com>, Stefan Berger
 <stefanb@linux.vnet.ibm.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Arun Menon <armenon@redhat.com>, =?utf-8?Q?Daniel_P?=
 =?utf-8?Q?=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v11 06/27] migration: push Error **errp into
 loadvm_handle_cmd_packaged()
In-Reply-To: <20250813-propagate_tpm_error-v11-6-b470a374b42d@redhat.com>
References: <20250813-propagate_tpm_error-v11-0-b470a374b42d@redhat.com>
 <20250813-propagate_tpm_error-v11-6-b470a374b42d@redhat.com>
Date: Fri, 15 Aug 2025 15:39:42 -0300
Message-ID: <87cy8wzaxd.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWELVE(0.00)[33]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[redhat.com,linaro.org,rsg.ci.i.u-tokyo.ac.jp,collabora.com,gmail.com,linux.ibm.com,euphon.net,oracle.com,nongnu.org,xfusion.com,linux.vnet.ibm.com];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TAGGED_RCPT(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLzasi9boc9ahn35s1z6tc8qwy)];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email]
X-Rspamd-Queue-Id: 81EE5218EE
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

Arun Menon <armenon@redhat.com> writes:

> This is an incremental step in converting vmstate loading
> code to report error via Error objects instead of directly
> printing it to console/monitor.
> It is ensured that loadvm_handle_cmd_packaged() must report an error
> in errp, in case of failure.
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Arun Menon <armenon@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

