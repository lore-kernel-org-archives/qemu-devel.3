Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21805CD98CF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 18:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXjyO-0004OD-Hx; Thu, 11 Jun 2026 14:17:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wXjyL-0004NT-Ln
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 14:17:45 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wXjyK-0000ws-2f
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 14:17:45 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DA59575DF7;
 Thu, 11 Jun 2026 18:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781201862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q1CM8RHAuUwatfrruRX231YqTjGCrstFt5MOamaRdDg=;
 b=nKuLgsCeZi14krjdC7iQsCLyqueSkuKfhJtZTlvhezHZX2V7wWy54q9tYrAUO6+yv2Mak5
 gLE8UNS/W6vAOBzlDbWngZOsiAHZJQ0vZZaiiiUkapcSyMd2BD3+Qqa/VdYKb2ai437weK
 PhxKTtdseNKyUAdqj+NsTPZEdTymcRo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781201862;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q1CM8RHAuUwatfrruRX231YqTjGCrstFt5MOamaRdDg=;
 b=dW0umUtlMi0d3Ye3AtXS07xoshwJPXkYssQYhZCLD07W8CLj6/rHhQnEmhju9aaT1WE3xM
 tJ3qbQ1Vq42HfZBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781201860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q1CM8RHAuUwatfrruRX231YqTjGCrstFt5MOamaRdDg=;
 b=suUKUUBXLWS8zRKH0GYeK2Ey+txuhfhBhQTKUAH8wzikprSf08bWoL6wh/H49v3e5k/03U
 l6I1vpjARg+blFD6T0zG4SJRrhBSyfV3h5m7y8WRsuv1BnMVkpC7UfNiAjyfo4iJSUdQm4
 1Q1gXzJi1ed2fh6rzTc7kI74CtTnAhE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781201860;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q1CM8RHAuUwatfrruRX231YqTjGCrstFt5MOamaRdDg=;
 b=9Ji/7hEVpTDXDI2KiPSnQfEuZFU5dSDDAxCI4aOzwiVQxKK8BTe7Pbi5V+6Z5WtTTVNpH1
 PHIFuOnstapE3IBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B8FA779A7;
 Thu, 11 Jun 2026 18:17:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NAonD8T7KmqBLgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 11 Jun 2026 18:17:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>, qemu-devel@nongnu.org
Cc: Klaus Jensen <its@irrelevant.dk>, Peter Xu <peterx@redhat.com>, Kevin
 Wolf <kwolf@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Keith
 Busch <kbusch@kernel.org>, =?utf-8?Q?St=C3=A9phane?= Graber
 <stgraber@stgraber.org>, Zhao
 Liu <zhao1.liu@intel.com>, Alexander Mikhalitsyn
 <alexander@mihalicyn.com>, qemu-block@nongnu.org, Laurent Vivier
 <lvivier@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Jesper Devantier
 <foss@defmacro.it>, Fam Zheng <fam@euphon.net>, Alexander Mikhalitsyn
 <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH v10 6/8] hw/nvme: add basic live migration support
In-Reply-To: <20260611180842.6390-7-alexander@mihalicyn.com>
References: <20260611180842.6390-1-alexander@mihalicyn.com>
 <20260611180842.6390-7-alexander@mihalicyn.com>
Date: Thu, 11 Jun 2026 15:17:33 -0300
Message-ID: <87fr2tj60y.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[18];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[futurfusion.io:email,
 imap1.dmz-prg2.suse.org:helo, mihalicyn.com:email, suse.de:email, suse.de:mid]
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

Alexander Mikhalitsyn <alexander@mihalicyn.com> writes:

> From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
>
> It has some limitations:
> - only one NVMe namespace is supported
> - SMART counters are not preserved
> - CMB is not supported
> - PMR is not supported
> - SPDM is not supported
> - SR-IOV is not supported
>
> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

