Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF92E7719A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 14:59:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVu0F-0008IF-DF; Thu, 09 Jan 2025 09:59:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tVu07-0008HS-Ez; Thu, 09 Jan 2025 09:59:11 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tVu05-0001GU-Th; Thu, 09 Jan 2025 09:59:11 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A91B11F393;
 Thu,  9 Jan 2025 14:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736434745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tvgQjewSGVHEptAeZtpI1ZSzQ/3pdVsZdvcD4awYC14=;
 b=hPW1/bikt6MEKmwXvmg9SyWz38aK6SHyTzZ9qR0CCblITcNqnVss2ri/edp5b11FpQ99QP
 Bh4oN8LelJ1pnjSppvRpQEXLXWiMzDTMRjCLYTWll/UI5ujQYoqHkeODoHzHbmPMiCATOF
 Tz5ZZ63FAYl9dC8F8VvRsLuNCLudNbU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736434745;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tvgQjewSGVHEptAeZtpI1ZSzQ/3pdVsZdvcD4awYC14=;
 b=lFETaE1WYo7kImiQWVDCMypCpd3nd8jVrRKAwVK+p+UM7z+J+G6LFWWSV84+Hrqm0eLB0c
 knSU8rQ0PK5E14Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736434745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tvgQjewSGVHEptAeZtpI1ZSzQ/3pdVsZdvcD4awYC14=;
 b=hPW1/bikt6MEKmwXvmg9SyWz38aK6SHyTzZ9qR0CCblITcNqnVss2ri/edp5b11FpQ99QP
 Bh4oN8LelJ1pnjSppvRpQEXLXWiMzDTMRjCLYTWll/UI5ujQYoqHkeODoHzHbmPMiCATOF
 Tz5ZZ63FAYl9dC8F8VvRsLuNCLudNbU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736434745;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tvgQjewSGVHEptAeZtpI1ZSzQ/3pdVsZdvcD4awYC14=;
 b=lFETaE1WYo7kImiQWVDCMypCpd3nd8jVrRKAwVK+p+UM7z+J+G6LFWWSV84+Hrqm0eLB0c
 knSU8rQ0PK5E14Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2643D13A8B;
 Thu,  9 Jan 2025 14:59:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4AtBNzjkf2fPaQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 09 Jan 2025 14:59:04 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Guenter Roeck <linux@roeck-us.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Jean-Christophe Dubois
 <jcd@tribudubois.net>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 qemu-arm@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>, Bernhard Beschow <shentey@gmail.com>
Subject: Re: [PATCH 11/14] tests/qtest/libqos: Reuse TYPE_IMX_I2C define
In-Reply-To: <20250108092538.11474-12-shentey@gmail.com>
References: <20250108092538.11474-1-shentey@gmail.com>
 <20250108092538.11474-12-shentey@gmail.com>
Date: Thu, 09 Jan 2025 11:59:01 -0300
Message-ID: <87zfk02fuy.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.99 / 50.00]; BAYES_HAM(-2.19)[96.12%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[14]; TAGGED_RCPT(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,roeck-us.net,tribudubois.net,linaro.org,nongnu.org,redhat.com];
 FREEMAIL_TO(0.00)[gmail.com,nongnu.org];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Bernhard Beschow <shentey@gmail.com> writes:

> Signed-off-by: Bernhard Beschow <shentey@gmail.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

