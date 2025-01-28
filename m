Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0399DC0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 19:51:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcrbW-000304-T6; Tue, 28 Jan 2025 14:50:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tcrbU-0002zV-TQ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 14:50:32 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tcrbT-0007MH-85
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 14:50:32 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D95231F37C;
 Tue, 28 Jan 2025 19:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738093825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kSGl1v2tatOHOuwtGMfMlZTe+AFaOys+lGQ87QoRwPs=;
 b=NpQtghzxUh3B8QTZ9hMKa7ZdjbiJgnMkVzU0CSXV1MLhiNW+X+T114T1JLMO39t+3t5YsW
 efatK4AOUvvlSClwS662dvyyB2Vh+ZmyygNDquAbE7R4s6qDclXBbYKakkH8t0/q+sVhhG
 YKWCOR2tEegiLJZdnoUCUxaUycOvO9g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738093825;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kSGl1v2tatOHOuwtGMfMlZTe+AFaOys+lGQ87QoRwPs=;
 b=cp5MraNyZ3+WIIh8PkwQUFcLSLMREYoNsjXkdYQ7E+euAQmkLBDqg35elCGa43kiiM6UNy
 obsTo8sJNSdvSSDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=D328qDSP;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=KEKHgbgM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738093824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kSGl1v2tatOHOuwtGMfMlZTe+AFaOys+lGQ87QoRwPs=;
 b=D328qDSPFQ5kSudU6TmwpVBJFInU2tzsf945dbeQRvotw9y7bI/ButqKBUrX/Z1UWsMLfm
 Xn3t0R+3J38r6FraAV8qB22vkJ+afwak4crdVdorj+EfquuwkKj4bqxb0OZOEB5FfAUVNE
 19Qfj+xLE6xG+TyuUZwd03EUXklf/E8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738093824;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kSGl1v2tatOHOuwtGMfMlZTe+AFaOys+lGQ87QoRwPs=;
 b=KEKHgbgMwkjrXojYiaBXj825SEqq1H1gkGa966yc0JYTJIVcaOwvhBrqKrtH5oD4AuNNyq
 IHXMcKi95I1nCkAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4DFDC13625;
 Tue, 28 Jan 2025 19:50:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /kmVAwA1mWdtMgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 28 Jan 2025 19:50:24 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH 7/7] tests/qtest/migration: Allow using accelerators
 different of TCG / KVM
In-Reply-To: <aa745382-40e4-40f6-bec0-4012626f1fbc@linaro.org>
References: <20250128135429.8500-1-philmd@linaro.org>
 <20250128135429.8500-8-philmd@linaro.org> <87ikpzt1xw.fsf@suse.de>
 <aa745382-40e4-40f6-bec0-4012626f1fbc@linaro.org>
Date: Tue, 28 Jan 2025 16:50:21 -0300
Message-ID: <87frl2u39e.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D95231F37C
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_MATCH_FROM(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 1/28/25 07:04, Fabiano Rosas wrote:
>> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>>=20
>>> There is no particular reason to restrict all the framework
>>> to TCG or KVM, since we can check on a per-test basis which
>>> accelerator is available (via MigrationTestEnv::has_$ACCEL).
>>=20
>> The reason is:
>>=20
>> CONFIG_KVM=3Dn
>> CONFIG_TCG=3Dn
>>=20
>> The check is about "there is no accelerator at all".
>
> We perform the no accelerator check in meson.build on a per-target basis.
> So you'll never have a qemu-system-foo binary with zero accelerators.
>

Ok, the issue was not zero accelerators, but Xen. On aarch64, this
produces a binary with no TCG nor KVM:

--target-list=3Dx86_64-softmmu --disable-tcg --enable-xen=20

