Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 940CCC52D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 12:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shTRt-0007JD-Ny; Fri, 23 Aug 2024 08:31:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1shTRh-0007G1-F5; Fri, 23 Aug 2024 08:31:13 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1shTRR-0000wi-OY; Fri, 23 Aug 2024 08:31:13 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4B8CA22685;
 Fri, 23 Aug 2024 12:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724416249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bt5vl3XxRBc6thlp4aouHyY6SZmjBleT1xsd5Fb0IyU=;
 b=TZrTPLYfDeM2ptaszGnfmiJxv9bDzLI8xNYQA46dihw+iEh7HTuP2h7U4phlZ7Mviz4uah
 FeWheRoC00nPUByhTR7YvmBdhkVS/AXU7g/KkTsYzWClo3AJ4xqSwmk0vEqdF4px+tQvhe
 Xay/kA/lFQ0VReVjxGk1n3G68e6F5Zs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724416249;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bt5vl3XxRBc6thlp4aouHyY6SZmjBleT1xsd5Fb0IyU=;
 b=suwM6rny254q9BAIdirDZCfsmCynyO6JexZ9b33fXbkkeEgC2v5iAmdU1jOaGsG6t4tmsJ
 U/Rr6aLyY36FOQBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TZrTPLYf;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=suwM6rny
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724416249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bt5vl3XxRBc6thlp4aouHyY6SZmjBleT1xsd5Fb0IyU=;
 b=TZrTPLYfDeM2ptaszGnfmiJxv9bDzLI8xNYQA46dihw+iEh7HTuP2h7U4phlZ7Mviz4uah
 FeWheRoC00nPUByhTR7YvmBdhkVS/AXU7g/KkTsYzWClo3AJ4xqSwmk0vEqdF4px+tQvhe
 Xay/kA/lFQ0VReVjxGk1n3G68e6F5Zs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724416249;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bt5vl3XxRBc6thlp4aouHyY6SZmjBleT1xsd5Fb0IyU=;
 b=suwM6rny254q9BAIdirDZCfsmCynyO6JexZ9b33fXbkkeEgC2v5iAmdU1jOaGsG6t4tmsJ
 U/Rr6aLyY36FOQBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B70E11333E;
 Fri, 23 Aug 2024 12:30:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WRooH/iAyGa5UwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Aug 2024 12:30:48 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Yanan Wang
 <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, BALATON Zoltan
 <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas
 Piggin <npiggin@gmail.com>, Daniel Henrique Barboza
 <danielhb413@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Harsh
 Prateek Bora <harshpb@linux.ibm.com>, Alexey Kardashevskiy
 <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>, Alex =?utf-8?Q?Be?=
 =?utf-8?Q?nn=C3=A9e?=
 <alex.bennee@linaro.org>, Peter Xu <peterx@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH v4 1/7] migration: Free removed SaveStateEntry
In-Reply-To: <20240823-san-v4-1-a24c6dfa4ceb@daynix.com>
References: <20240823-san-v4-0-a24c6dfa4ceb@daynix.com>
 <20240823-san-v4-1-a24c6dfa4ceb@daynix.com>
Date: Fri, 23 Aug 2024 09:30:46 -0300
Message-ID: <87ikvrxvyh.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 4B8CA22685
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.63 / 50.00]; BAYES_HAM(-2.62)[98.30%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim]; SUSPICIOUS_RECIPS(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[25];
 FREEMAIL_TO(0.00)[daynix.com,habkost.net,gmail.com,linaro.org,huawei.com,redhat.com,eik.bme.hu,flygoat.com,gibson.dropbear.id.au,linux.ibm.com,ozlabs.ru];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MID_RHS_MATCH_FROM(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:dkim,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> This fixes LeakSanitizer warnings.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  migration/savevm.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/migration/savevm.c b/migration/savevm.c
> index deb57833f8a8..85958d7b09cd 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -874,6 +874,8 @@ int vmstate_replace_hack_for_ppc(VMStateIf *obj, int instance_id,
>  
>      if (se) {
>          savevm_state_handler_remove(se);
> +        g_free(se->compat);
> +        g_free(se);
>      }
>      return vmstate_register(obj, instance_id, vmsd, opaque);
>  }

This one was merged already.

