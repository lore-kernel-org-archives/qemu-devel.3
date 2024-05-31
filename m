Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6755C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 20:07:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD8W3-0008Ad-3e; Fri, 31 May 2024 16:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1sD8W1-0008AQ-U4; Fri, 31 May 2024 16:06:17 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1sD8W0-0005mj-9u; Fri, 31 May 2024 16:06:17 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B13CE1F391;
 Fri, 31 May 2024 20:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717185973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5sjS3IVvSxFYjQZ11N3PaMlIWt1+Y+61luCK1lSoVKs=;
 b=0XpDeWV7cR/IfrwpqNMun4qvNgTwBGKzNA/F1vFmhR7eGbbBfM4a2Lb7XQ0vYHBI3QvS4E
 Di+jvNZJYhjV020nOObs4Mm9nW/I5MTLNTWQVPwJZ71ETJFh0/Q21Vu6sQhAukhL4IO+VP
 Bc3RXxoUbgI5LphZZg7EKl2Br2NmxNM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717185973;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5sjS3IVvSxFYjQZ11N3PaMlIWt1+Y+61luCK1lSoVKs=;
 b=NAcp34kZ/fw6V2xGsElngNPHRzbeGfwpJjlekX+5YSX6zOscNw9PuC7hd6C4nnFUfvyZml
 m1CLOLrHbOvifPCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0XpDeWV7;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NAcp34kZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717185973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5sjS3IVvSxFYjQZ11N3PaMlIWt1+Y+61luCK1lSoVKs=;
 b=0XpDeWV7cR/IfrwpqNMun4qvNgTwBGKzNA/F1vFmhR7eGbbBfM4a2Lb7XQ0vYHBI3QvS4E
 Di+jvNZJYhjV020nOObs4Mm9nW/I5MTLNTWQVPwJZ71ETJFh0/Q21Vu6sQhAukhL4IO+VP
 Bc3RXxoUbgI5LphZZg7EKl2Br2NmxNM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717185973;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5sjS3IVvSxFYjQZ11N3PaMlIWt1+Y+61luCK1lSoVKs=;
 b=NAcp34kZ/fw6V2xGsElngNPHRzbeGfwpJjlekX+5YSX6zOscNw9PuC7hd6C4nnFUfvyZml
 m1CLOLrHbOvifPCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B3BE132C2;
 Fri, 31 May 2024 20:06:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id w734ALUtWmb0WAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 31 May 2024 20:06:13 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org, Glenn Miles
 <milesg@linux.vnet.ibm.com>
Subject: Re: [PULL 25/72] Adds migration support for Branch History Rolling
 Buffer (BHRB) internal state.
In-Reply-To: <20240523230747.45703-26-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
 <20240523230747.45703-26-npiggin@gmail.com>
Date: Fri, 31 May 2024 17:06:07 -0300
Message-ID: <87le3phhlc.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B13CE1F391
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[gmail.com,nongnu.org]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FREEMAIL_CC(0.00)[gmail.com,nongnu.org,linux.vnet.ibm.com];
 RCVD_COUNT_TWO(0.00)[2]; MID_RHS_MATCH_FROM(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
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

Nicholas Piggin <npiggin@gmail.com> writes:

> From: Glenn Miles <milesg@linux.vnet.ibm.com>
>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  target/ppc/machine.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> index 6b6c31d903..731dd8df35 100644
> --- a/target/ppc/machine.c
> +++ b/target/ppc/machine.c
> @@ -711,6 +711,26 @@ static const VMStateDescription vmstate_reservation = {
>      }
>  };
>  
> +#ifdef TARGET_PPC64
> +static bool bhrb_needed(void *opaque)
> +{
> +    PowerPCCPU *cpu = opaque;
> +    return (cpu->env.flags & POWERPC_FLAG_BHRB) != 0;
> +}
> +
> +static const VMStateDescription vmstate_bhrb = {
> +    .name = "cpu/bhrb",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = bhrb_needed,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINTTL(env.bhrb_offset, PowerPCCPU),
> +        VMSTATE_UINT64_ARRAY(env.bhrb, PowerPCCPU, BHRB_MAX_NUM_ENTRIES),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +#endif
> +
>  const VMStateDescription vmstate_ppc_cpu = {
>      .name = "cpu",
>      .version_id = 5,
> @@ -756,6 +776,7 @@ const VMStateDescription vmstate_ppc_cpu = {
>  #ifdef TARGET_PPC64
>          &vmstate_tm,
>          &vmstate_slb,
> +        &vmstate_bhrb,

Running some tests now that Nick re-enabled ppc for migration tests, I
see that this new state breaks backward migrations:

$ QTEST_TRACE="vmstate_*" \
  QTEST_QEMU_BINARY_DST=../build-previous/qemu-system-ppc64 \
  QTEST_QEMU_BINARY=./qemu-system-ppc64 \
  ./tests/qtest/migration-test -p /ppc64/migration/precopy/tcp/plain
...
vmstate_load_state_field cpu/slb:env.slb
vmstate_n_elems env.slb: 64
vmstate_subsection_load cpu/slb
vmstate_subsection_load_bad cpu/slb: cpu/bhrb/(prefix)
vmstate_load_state_end cpu/slb end/0
vmstate_subsection_load_bad cpu: cpu/bhrb/(lookup)
qemu-system-ppc64: error while loading state for instance 0x0 of device 'cpu'
vmstate_downtime_checkpoint dst-precopy-loadvm-completed
qemu-system-ppc64: load of migration failed: No such file or directory

If you want to support backwards migration, then this needs to be
fixed. Otherwise we can ignore it.

