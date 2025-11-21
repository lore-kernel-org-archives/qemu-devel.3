Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3BCBCFC518
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 01:54:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMchs-0007kl-BI; Fri, 21 Nov 2025 20:46:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vMbME-00025S-8T
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:20:07 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vMbK9-0000jQ-6d
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:20:00 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 836A65BCC5;
 Fri, 21 Nov 2025 18:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1763749758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kr48nMMmCCJX4zkxm3LT8TVq2N12YC6aVBTL9uQHexA=;
 b=dSgg85D0u9wzD8jZzmRu6vqhi7BBtmhdPdER/SO4xNryHcrWq5SpCcPEZ4AM7f3Zm4StVg
 Igax4cXxIZFL4ofCwn5CDrtYF8GXhTE0RC3LseLsEu1iJlhfaxeuar4WPRBQF0GqsCxSv5
 gmVDjWS/v5AUfuii/5OJ2dtGHtXQ554=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1763749758;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kr48nMMmCCJX4zkxm3LT8TVq2N12YC6aVBTL9uQHexA=;
 b=esXc5VFgk4BLjgHrFIl5zVpWr6c8RDm/a7N1Z5rLF9S+8qdpTnCQbuWGh9qxUp1EOcOx/6
 Tddmuc5civU4JqBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dSgg85D0;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=esXc5VFg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1763749758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kr48nMMmCCJX4zkxm3LT8TVq2N12YC6aVBTL9uQHexA=;
 b=dSgg85D0u9wzD8jZzmRu6vqhi7BBtmhdPdER/SO4xNryHcrWq5SpCcPEZ4AM7f3Zm4StVg
 Igax4cXxIZFL4ofCwn5CDrtYF8GXhTE0RC3LseLsEu1iJlhfaxeuar4WPRBQF0GqsCxSv5
 gmVDjWS/v5AUfuii/5OJ2dtGHtXQ554=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1763749758;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kr48nMMmCCJX4zkxm3LT8TVq2N12YC6aVBTL9uQHexA=;
 b=esXc5VFgk4BLjgHrFIl5zVpWr6c8RDm/a7N1Z5rLF9S+8qdpTnCQbuWGh9qxUp1EOcOx/6
 Tddmuc5civU4JqBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 01FD13EA61;
 Fri, 21 Nov 2025 18:29:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0rRCLX2vIGn6fAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 21 Nov 2025 18:29:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Yanan Wang <wangyanan55@huawei.com>, peterx@redhat.com, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH] machine: Provide a description for aux-ram-share property
In-Reply-To: <20251105191120.3820787-1-peterx@redhat.com>
References: <20251105191120.3820787-1-peterx@redhat.com>
Date: Fri, 21 Nov 2025 15:29:15 -0300
Message-ID: <874iqnfddw.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 836A65BCC5
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.67 / 50.00]; BAYES_HAM(-2.66)[98.48%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[habkost.net,intel.com,huawei.com,redhat.com,linaro.org,gmail.com];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 MISSING_XM_UA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[9]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TAGGED_RCPT(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,suse.de:mid,suse.de:dkim]
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Peter Xu <peterx@redhat.com> writes:

> It was forgotten when being introduced in commit 91792807d1 ("machine:
> aux-ram-share option").
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/core/machine.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 0580550e12..8dd8ce4cac 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -1200,6 +1200,8 @@ static void machine_class_init(ObjectClass *oc, const void *data)
>      object_class_property_add_bool(oc, "aux-ram-share",
>                                     machine_get_aux_ram_share,
>                                     machine_set_aux_ram_share);
> +    object_class_property_set_description(oc, "aux-ram-share",
> +        "Use anonymous shared memory for auxilliary guest RAMs");

s/auxilliary/auxiliary/

>  #endif
>  
>      object_class_property_add_bool(oc, "usb",

