Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D9BC3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 13:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCf3g-0004aF-4p; Wed, 07 May 2025 09:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uCf3e-0004ZD-BZ
 for qemu-devel@nongnu.org; Wed, 07 May 2025 09:43:34 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uCf3c-0005Fl-Rz
 for qemu-devel@nongnu.org; Wed, 07 May 2025 09:43:34 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 09757211FA;
 Wed,  7 May 2025 13:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1746625409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SGxhsZsnygHWUpcIJzwPkxBDdC+I09bkddUgiws7GJQ=;
 b=y0h+TlHZ0Ez9Y3+c3Nf1ZO1FKfzqu+80zUnW5P4mejN8oIaUPfc1nzgoz0oJJkum4cbvsK
 d1sUWPJeqmLxlYf2VwHx3ndrTRu40n/rBXt/JzOYkHxNuBV0iWv1blmYDihocC/DPXFRbP
 Ne78VIZmezKx9cCy1WCGxjaGaL559KA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1746625409;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SGxhsZsnygHWUpcIJzwPkxBDdC+I09bkddUgiws7GJQ=;
 b=Ds/M0ri+0j1iY2oysvFU0A38IkOTXWdq05q7XUrUSJMRsMdiSBR+DJsJezRJQ/WBAv+VM0
 13aIvUBQJ1pR9zDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=y0h+TlHZ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="Ds/M0ri+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1746625409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SGxhsZsnygHWUpcIJzwPkxBDdC+I09bkddUgiws7GJQ=;
 b=y0h+TlHZ0Ez9Y3+c3Nf1ZO1FKfzqu+80zUnW5P4mejN8oIaUPfc1nzgoz0oJJkum4cbvsK
 d1sUWPJeqmLxlYf2VwHx3ndrTRu40n/rBXt/JzOYkHxNuBV0iWv1blmYDihocC/DPXFRbP
 Ne78VIZmezKx9cCy1WCGxjaGaL559KA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1746625409;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SGxhsZsnygHWUpcIJzwPkxBDdC+I09bkddUgiws7GJQ=;
 b=Ds/M0ri+0j1iY2oysvFU0A38IkOTXWdq05q7XUrUSJMRsMdiSBR+DJsJezRJQ/WBAv+VM0
 13aIvUBQJ1pR9zDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7665113882;
 Wed,  7 May 2025 13:43:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QoXhDIBjG2h9SQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 07 May 2025 13:43:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Thomas Huth <thuth@redhat.com>, bibo mao <maobibo@loongson.cn>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3] tests/qtest/cpu-plug-test: Add cpu hotplug support
 for LoongArch
In-Reply-To: <96a274f6-6efe-4602-a7ab-3488a43365fa@redhat.com>
References: <20250314085130.4184272-1-maobibo@loongson.cn>
 <c66ea257-0449-cccb-ac13-518e42c9081f@loongson.cn>
 <96a274f6-6efe-4602-a7ab-3488a43365fa@redhat.com>
Date: Wed, 07 May 2025 10:43:25 -0300
Message-ID: <87msbofsea.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 09757211FA
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[4];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:dkim,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Thomas Huth <thuth@redhat.com> writes:

> On 07/05/2025 10.55, bibo mao wrote:
>> Hi Thomas,
>> 
>> Can this patch be merged since qemu 10.0 is released already?
>
>   Hi,
>
> Fabiano took over the maintainership of the qtests, so I'm forwarding the 
> question to him.
>

Thank you.

I'll add this to my queue.

