Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDECBC25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 14:13:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5Qz3-0002k9-Gj; Fri, 10 May 2024 10:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s5Qz2-0002jv-AK
 for qemu-devel@nongnu.org; Fri, 10 May 2024 10:12:24 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s5Qz0-00085q-Jv
 for qemu-devel@nongnu.org; Fri, 10 May 2024 10:12:24 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 74EB537417;
 Fri, 10 May 2024 14:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715350339; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r9oKCei+BQywsVDl+ktzmRiECkievRfGSLj+qEUHABE=;
 b=MWoUaRmaM+9i9hPo4xHTxHQNHhTN72VtpTvB/5BY40zvijVEgeNHWYx9zLU6+zAHbtGjBw
 DLaRRYy8eOpUI8BEtpFNFj9Hw14IuNR2fkmw77aoKo0wqRFJJUmdCje7BXszi+VZuM87Yo
 Q/pyN+Y6rAzGuL2UgJJ+WDstTy3kxRc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715350339;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r9oKCei+BQywsVDl+ktzmRiECkievRfGSLj+qEUHABE=;
 b=n6y3DfeTH74bdWi9zOVRNAvJSl2gyHC4EJRr1NFaLw6Hg3MzEkcQivwgzhEYUPbSkB4YKp
 fB1GSBX9JU/XDxBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715350338; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r9oKCei+BQywsVDl+ktzmRiECkievRfGSLj+qEUHABE=;
 b=tNDYE4UoZUX2ewW7Mr9iGN3gclVwXy0HiMNuKhTLKxELY9C3hmCR32L00Trd+PVazQw+kA
 RDaJbkUZLgInV00dajFkepXhZuYi6SOUe15/KiamQvnIHt4TUmTkCnb+C04lB5NcpgQTEH
 nndohldznZFFOPDLCl4MwAje9H4ILbI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715350338;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r9oKCei+BQywsVDl+ktzmRiECkievRfGSLj+qEUHABE=;
 b=Ma0r0qQGo+NHhzW4E9E4jHKPHqS9FchV+VzN+AJKKTmKm/ZkRdZG4r6+YMw1Uc1HCHxkme
 Hf2aqkjoBTHWShBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F1CE41386E;
 Fri, 10 May 2024 14:12:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id l7gdLUErPmbZEwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 10 May 2024 14:12:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Yuan Liu <yuan1.liu@intel.com>, peterx@redhat.com
Cc: qemu-devel@nongnu.org, yuan1.liu@intel.com, nanhai.zou@intel.com
Subject: Re: [PATCH v6 4/7] migration/multifd: add qpl compression method
In-Reply-To: <20240505165751.2392198-5-yuan1.liu@intel.com>
References: <20240505165751.2392198-1-yuan1.liu@intel.com>
 <20240505165751.2392198-5-yuan1.liu@intel.com>
Date: Fri, 10 May 2024 11:12:15 -0300
Message-ID: <87frupkb7k.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.85 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 BAYES_HAM(-0.55)[80.87%]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, intel.com:email]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Yuan Liu <yuan1.liu@intel.com> writes:

> add the Query Processing Library (QPL) compression method
>
> Introduce the qpl as a new multifd migration compression method, it can
> use In-Memory Analytics Accelerator(IAA) to accelerate compression and
> decompression, which can not only reduce network bandwidth requirement
> but also reduce host compression and decompression CPU overhead.
>
> How to enable qpl compression during migration:
> migrate_set_parameter multifd-compression qpl
>
> The qpl method only supports one compression level, there is no qpl
> compression level parameter added, users do not need to specify the
> qpl compression level.
>
> Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>

There's an r-b from Peter that you forgot to bring along in this version
of the series.


