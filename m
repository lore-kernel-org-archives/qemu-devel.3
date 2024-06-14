Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F8AC27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 13:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI6Yn-0002Gp-FP; Fri, 14 Jun 2024 09:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sI6Yl-0002Fr-9u
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 09:01:39 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sI6Yj-0004qv-Fy
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 09:01:39 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D2745204FA;
 Fri, 14 Jun 2024 13:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718370094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D8RTbbyVFlt6Bcrg5Dq7GwFuB0tFCWskTFGfDYLtBMA=;
 b=AteQB24B+NLJa4SLdLVtdoGWzKoxEjDWgLaQlP/pEU9bfm+tjx/z1l9pdwSvvwg4afyIQe
 Qn62Jx7yXyieTYC1sYmKYCHjJiwTCoBoPpXcuNwr+NXBDjeCSCSGiVATxWNO2ygNRZr576
 n3Zy77vpRChEsQEZqTopwOYW9IF/+O0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718370094;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D8RTbbyVFlt6Bcrg5Dq7GwFuB0tFCWskTFGfDYLtBMA=;
 b=Yt1i8aeSzUa7aja1Zt9iGeFseo5JqP5iQScccpZ2zyjNCnvTjGwQMSsjoWZAcrlpYBiayr
 GewbxvlMVmmpKDBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AteQB24B;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Yt1i8aeS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718370094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D8RTbbyVFlt6Bcrg5Dq7GwFuB0tFCWskTFGfDYLtBMA=;
 b=AteQB24B+NLJa4SLdLVtdoGWzKoxEjDWgLaQlP/pEU9bfm+tjx/z1l9pdwSvvwg4afyIQe
 Qn62Jx7yXyieTYC1sYmKYCHjJiwTCoBoPpXcuNwr+NXBDjeCSCSGiVATxWNO2ygNRZr576
 n3Zy77vpRChEsQEZqTopwOYW9IF/+O0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718370094;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D8RTbbyVFlt6Bcrg5Dq7GwFuB0tFCWskTFGfDYLtBMA=;
 b=Yt1i8aeSzUa7aja1Zt9iGeFseo5JqP5iQScccpZ2zyjNCnvTjGwQMSsjoWZAcrlpYBiayr
 GewbxvlMVmmpKDBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1329313AB5;
 Fri, 14 Jun 2024 13:01:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AOm2Mis/bGbCNAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 14 Jun 2024 13:01:31 +0000
From: Fabiano Rosas <farosas@suse.de>
To: peterx@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 berrange@redhat.com, thuth@redhat.com, philmd@linaro.org,
 Yuan Liu <yuan1.liu@intel.com>
Cc: qemu-devel@nongnu.org, nanhai.zou@intel.com,
 shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH v8 0/7] Live Migration With IAA
Date: Fri, 14 Jun 2024 10:01:25 -0300
Message-Id: <171836984519.3095.4699095490413367.b4-ty@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240610102110.900410-1-yuan1.liu@intel.com>
References: <20240610102110.900410-1-yuan1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D2745204FA
X-Spamd-Result: default: False [-4.41 / 50.00]; BAYES_HAM(-2.90)[99.59%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_SEVEN(0.00)[10];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

On Mon, 10 Jun 2024 18:21:03 +0800, Yuan Liu wrote:
> I am writing to submit a code change aimed at enhancing live migration
> acceleration by leveraging the compression capability of the Intel
> In-Memory Analytics Accelerator (IAA).
> 
> The implementation of the IAA (de)compression code is based on Intel Query
> Processing Library (QPL), an open-source software project designed for
> high-performance query processing operations on Intel CPUs.
> https://github.com/intel/qpl
> 
> [...]

Queued, thanks!

