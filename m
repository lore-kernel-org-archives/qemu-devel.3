Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5898C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 12:32:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twgxb-0003XH-77; Mon, 24 Mar 2025 08:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1twgxZ-0003Wo-3g
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 08:31:17 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1twgxR-0000G8-Up
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 08:31:16 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C6EC01F44F;
 Mon, 24 Mar 2025 12:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1742819462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wU6eImXGNJQjveIzP4uGnurBhHmfYpWBFHrX7b/QZ4k=;
 b=hbZWkcMV6XNQNsA85O9yG2tcQQGPJmdA1xZpzdNAiSZ9JkqOqwgFn7pyA9Ou3U5xeEsDJQ
 AOnjtzgwGPW0vK/ZubykWesE/HguuSdNglpcqcUXUYEMD5asE9gxPg0jyM2RdGt6rnT/tf
 yTS9t7jNNpcxa4hUBKiduEsGLQlix7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1742819462;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wU6eImXGNJQjveIzP4uGnurBhHmfYpWBFHrX7b/QZ4k=;
 b=o9vodFSD62+YpO4e4WaOD0Tn9frtFCIHWHwkoonLyWPO+wxV2Rse3g9k9voovGFiNiKuER
 JDBFtubinr2ShfCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1742819462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wU6eImXGNJQjveIzP4uGnurBhHmfYpWBFHrX7b/QZ4k=;
 b=hbZWkcMV6XNQNsA85O9yG2tcQQGPJmdA1xZpzdNAiSZ9JkqOqwgFn7pyA9Ou3U5xeEsDJQ
 AOnjtzgwGPW0vK/ZubykWesE/HguuSdNglpcqcUXUYEMD5asE9gxPg0jyM2RdGt6rnT/tf
 yTS9t7jNNpcxa4hUBKiduEsGLQlix7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1742819462;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wU6eImXGNJQjveIzP4uGnurBhHmfYpWBFHrX7b/QZ4k=;
 b=o9vodFSD62+YpO4e4WaOD0Tn9frtFCIHWHwkoonLyWPO+wxV2Rse3g9k9voovGFiNiKuER
 JDBFtubinr2ShfCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 37C5013874;
 Mon, 24 Mar 2025 12:31:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UjvZOoVQ4WfkIQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 24 Mar 2025 12:31:01 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, Huacai Chen <chenhuacai@kernel.org>, Peter
 Xu <peterx@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar
 Rikalo <arikalo@gmail.com>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Aurelien
 Jarno <aurelien@aurel32.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH-for-10.1 3/3] migration/cpu: Remove
 qemu_{get,put}_[s]betl[s] macros
In-Reply-To: <20250323225047.35419-4-philmd@linaro.org>
References: <20250323225047.35419-1-philmd@linaro.org>
 <20250323225047.35419-4-philmd@linaro.org>
Date: Mon, 24 Mar 2025 09:30:59 -0300
Message-ID: <87r02ma9vg.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.09 / 50.00]; BAYES_HAM(-2.79)[99.08%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[12];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[ilande.co.uk,linaro.org,kernel.org,redhat.com,flygoat.com,gmail.com,aurel32.net];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> The following macros:
>
>  - qemu_put_betl()
>  - qemu_get_betl()
>  - qemu_put_betls()
>  - qemu_get_betls()
>  - qemu_put_sbetl()
>  - qemu_get_sbetl()
>  - qemu_put_sbetls()
>  - qemu_get_sbetls()
>
> are not used in the whole code base, remove them.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

