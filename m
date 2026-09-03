Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75305C624DB
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 13:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x27vP-0004B0-Qy; Thu, 03 Sep 2026 09:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1x27vN-00049u-Lc; Thu, 03 Sep 2026 09:56:17 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1x27vI-0007NK-An; Thu, 03 Sep 2026 09:56:17 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8093E1FE3F;
 Thu,  3 Sep 2026 13:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788443764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=66iEj+ofjqlVSJLSEfwl2DIRGJH5XlqQYxYpO8rjcEo=;
 b=Sudnd4vdetBruQdpnHGNelHFCisOMeYN50y4Z9Eg3aoWhOfL7AT0qhPz+htZ6X2V2U5lZ1
 TMTAweGvmi+zod90XiV9iMUNdoTIc0MeM3Kr140SBXGMTRg/GEMGqsq2LIW/wttxIKCHit
 fYH2bIKgWVtp9lzaw1WLLvLfNadotaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788443764;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=66iEj+ofjqlVSJLSEfwl2DIRGJH5XlqQYxYpO8rjcEo=;
 b=hNMH3q++g1oSTsBcqR+tG78Lxp8PFQxJZXpFK0neO4dJCBIBfxDCdXxM9Kc9vFiKfj9DcR
 yuzboh56zHvFrhAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=a0e77BQY;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4wcXNfjr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788443760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=66iEj+ofjqlVSJLSEfwl2DIRGJH5XlqQYxYpO8rjcEo=;
 b=a0e77BQY/xA3KtE/D16KNVzdgSA+9ewWIBmzCjOS+oV85DeObJgE6P/Cdmt8qEol/DLGi8
 xto/4CfhRLS053AOGGU+eK4EZwXSYd8P27GxYlo3jzkfSyeiBSMgsJxGxmYQ6jhYIE1eWs
 /H95RY0rW8/fN3msx2tURegJlO2Bts4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788443760;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=66iEj+ofjqlVSJLSEfwl2DIRGJH5XlqQYxYpO8rjcEo=;
 b=4wcXNfjrOqUOALU4+DCKF6TaXPplhqvM/q6PuTQoBF6zhjWBnOuZ+FoCiJyqCMYxkf9BYY
 xh0MjFGFQ35awOCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C343136D9;
 Thu,  3 Sep 2026 13:55:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YBrWM298mWpEcwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 03 Sep 2026 13:55:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Christian Quante <christian@quante.one>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, John Snow
 <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/3] tests/qtest/fdc-test: give each test case its own
 instance
In-Reply-To: <20260824112307.223856-1-christian@quante.one>
References: <20260822104329.42121-1-christian@quante.one>
 <CAJ+F1CJNFWBzHHxteGW8nzow7yQz0WEJ9Jq9nnb=nnZkY4hf-A@mail.gmail.com>
 <20260824112307.223856-1-christian@quante.one>
Date: Thu, 03 Sep 2026 10:55:53 -0300
Message-ID: <87mrtyh21i.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8093E1FE3F
X-Spamd-Result: default: False [-4.50 / 50.00]; BAYES_HAM(-2.99)[99.94%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[8]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
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

Christian Quante <christian@quante.one> writes:

> Hi Marc-Andr=C3=A9,
>
> thanks for testing it.
>
>> Series lgtm, however it takes ~10s more now.
>
> I can't reproduce that here: fdc-test goes from 0.8s to 2.6s, so
> +1.8s. With an --enable-asan build it is 3.4s, still nowhere near
> +10s. The series takes the test from 2 QEMU instances to 16, at about
> 128ms each.
>
> What are you measuring, and on what kind of build -- fdc-test on its
> own?
>
> Christian

The timing looks ok on my side as well. I'll queue this series for the
moment. @Marc-Andr=C3=A9, feel free to object.

Thanks!

