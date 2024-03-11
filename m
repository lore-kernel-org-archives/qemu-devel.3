Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF0D4C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 20:45:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjmVa-0008Av-JV; Mon, 11 Mar 2024 16:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rjmVZ-0008AZ-4E
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 16:44:29 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rjmVW-0007jd-TG
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 16:44:28 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 594B75CB79;
 Mon, 11 Mar 2024 20:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710189864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+pMLFcTdsO0sKKkNHURi2gy3tHimYBph96Bw8QaThHc=;
 b=kA+a7Ha93v3XL18Asj99TkOGKPOBw6xT6bLy3jIMCo7CbgixRpTx8IttJPHVk4xNhGao5s
 llcpbrt/oEjlGEWfQ/bK2gzejtGOrBhZKASgFqQXyM/D/NqLEwo2DS3BZ656vYCUa9XXFz
 1zG0wZKKoibL7NSy8IdpDAoXFg3LC6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710189864;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+pMLFcTdsO0sKKkNHURi2gy3tHimYBph96Bw8QaThHc=;
 b=lsaVYxm+0iY7jOm8H2Asyh0uQ+uysgZy8I9JDTkght014busPGUKXxs6/0Ma7X3vsY9p8d
 DGErbWTIPjF+maCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710189864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+pMLFcTdsO0sKKkNHURi2gy3tHimYBph96Bw8QaThHc=;
 b=kA+a7Ha93v3XL18Asj99TkOGKPOBw6xT6bLy3jIMCo7CbgixRpTx8IttJPHVk4xNhGao5s
 llcpbrt/oEjlGEWfQ/bK2gzejtGOrBhZKASgFqQXyM/D/NqLEwo2DS3BZ656vYCUa9XXFz
 1zG0wZKKoibL7NSy8IdpDAoXFg3LC6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710189864;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+pMLFcTdsO0sKKkNHURi2gy3tHimYBph96Bw8QaThHc=;
 b=lsaVYxm+0iY7jOm8H2Asyh0uQ+uysgZy8I9JDTkght014busPGUKXxs6/0Ma7X3vsY9p8d
 DGErbWTIPjF+maCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C7EA9136BA;
 Mon, 11 Mar 2024 20:44:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ztt8Iydt72WLYgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 11 Mar 2024 20:44:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Hao Xiang <hao.xiang@linux.dev>, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, peterx@redhat.com,
 eblake@redhat.com, armbru@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, jdenemar@redhat.com, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: Re: [PATCH v6 6/7] migration/multifd: Enable multifd zero page
 checking by default.
In-Reply-To: <20240311180015.3359271-7-hao.xiang@linux.dev>
References: <20240311180015.3359271-1-hao.xiang@linux.dev>
 <20240311180015.3359271-7-hao.xiang@linux.dev>
Date: Mon, 11 Mar 2024 17:44:21 -0300
Message-ID: <87bk7kmrbu.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kA+a7Ha9;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lsaVYxm+
X-Spamd-Result: default: False [-0.07 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MID_RHS_MATCH_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BAYES_HAM(-1.26)[89.71%];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_TWELVE(0.00)[15];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,bytedance.com:email];
 FREEMAIL_TO(0.00)[linux.dev,redhat.com,habkost.net,gmail.com,linaro.org,huawei.com,nongnu.org];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 SUSPICIOUS_RECIPS(1.50)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Queue-Id: 594B75CB79
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Hao Xiang <hao.xiang@linux.dev> writes:

> From: Hao Xiang <hao.xiang@bytedance.com>
>
> 1. Set default "zero-page-detection" option to "multifd". Now
> zero page checking can be done in the multifd threads and this
> becomes the default configuration.
> 2. Handle migration QEMU9.0 -> QEMU8.2 compatibility. We provide
> backward compatibility where zero page checking is done from the
> migration main thread.
>
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

