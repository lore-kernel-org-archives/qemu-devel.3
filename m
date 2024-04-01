Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65935CD128D
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 15:47:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrJrw-0006lD-4y; Mon, 01 Apr 2024 11:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rrJrv-0006l4-6F
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 11:46:43 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rrJrt-0006yv-RD
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 11:46:42 -0400
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CD51E33BAF;
 Mon,  1 Apr 2024 15:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1711986398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tdmd3juRu4HaFOKbd63wiNEd3xrwn3Nj9fbixvt0tAI=;
 b=to9CTbpqxIeJY0+rsY8o+FLsHUYJPOB/7IPYxvvYyFHQ5rSJ02JQD/ceMdhjCHAI67SnMF
 cCODHEhkhk8iXqRzFCmA0119KQLnZvGr456iPihUXG5dCqPSan05/WlNHCnUH7Auhgnny0
 c1IpB5K5zJN8XyT2zmHNeQ8lyRK3qEI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1711986398;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tdmd3juRu4HaFOKbd63wiNEd3xrwn3Nj9fbixvt0tAI=;
 b=pJfJ1C2mKxcPg2PLLyLUlF3+Jfr5pB35X5xEOgyIveFfWEKhE282qKNoOfWh+7hf0Mitqw
 VdTjm5BUOsUYLeBw==
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 56666139BE;
 Mon,  1 Apr 2024 15:46:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id aiMiB97WCmb8TwAAn2gu4w
 (envelope-from <farosas@suse.de>); Mon, 01 Apr 2024 15:46:38 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Bryan Zhang <bryan.zhang@bytedance.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, yuan1.liu@intel.com, berrange@redhat.com,
 nanhai.zou@intel.com, hao.xiang@linux.dev, Bryan Zhang
 <bryan.zhang@bytedance.com>
Subject: Re: [PATCH v2 4/5] migration: Implement 'qatzip' methods using QAT
In-Reply-To: <20240326224221.3623014-5-bryan.zhang@bytedance.com>
References: <20240326224221.3623014-1-bryan.zhang@bytedance.com>
 <20240326224221.3623014-5-bryan.zhang@bytedance.com>
Date: Mon, 01 Apr 2024 12:46:35 -0300
Message-ID: <87il11rspw.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-0.41 / 50.00];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; BAYES_HAM(-0.11)[65.96%];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[8]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

Bryan Zhang <bryan.zhang@bytedance.com> writes:

> Uses QAT to offload deflate compression and decompression in the
> 'qatzip' compression method for multifd migration.

Please merge this patch with the previous. It makes no sense to have a
commit that adds nocomp code to qatzip only to have the next commit
replace it all.

