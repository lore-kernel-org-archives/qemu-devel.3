Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE225D5E36C
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 13:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVVVR-0005T8-ED; Tue, 16 Dec 2025 08:54:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVVVO-0005SS-L5
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 08:54:22 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVVVN-0001qS-A6
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 08:54:22 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E9201336A3;
 Tue, 16 Dec 2025 13:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765893259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ko68RwUFo7xUZg9tioMNo+XXCWkqgth7IszBpkCDBvI=;
 b=x4zD5Nozf1t18XlO3i7MYh6UupoXOlhLt6utxJ6lpOH7L0jteZTaeeRevKD4jcu0ct1AG9
 jUppDWaI6hlTVfmo6p+0G2uQnL7F9L5kzBug2p4rREU1zVcd5hwzd1x7uF21mqnKSNtsxg
 yzUCTW9YI1PXyhHEib2nrRzeUyklsmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765893259;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ko68RwUFo7xUZg9tioMNo+XXCWkqgth7IszBpkCDBvI=;
 b=6MUY4l1eva0nIzL/1/aNizZ6yIpVWrs+q7Va9ySVVFoO3DkMGsPiC40+DPgghmrIur+OR2
 t+/1+Rw/2zmAsuBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765893258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ko68RwUFo7xUZg9tioMNo+XXCWkqgth7IszBpkCDBvI=;
 b=NNd73nGt4N+Z2fCq1hYSA+lQktT8XxYHD4g/+xNL/EMNISsqU+ICinxnSlzZgfwl/SoY9Z
 ahkWC55akBy5Q6hopacHNtGcMBAeiGp4TyvnNMq0C8fNiLZRJssiQRNLinT9EoRQSsbXZN
 TBqXmrMORT6xlLLAzmytzP2mo+YHlJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765893258;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ko68RwUFo7xUZg9tioMNo+XXCWkqgth7IszBpkCDBvI=;
 b=KE7yZj5KCQlsLweYVV4ZTfW+jiIBlDq3l1wumLBR0/wEs5edrUoEuJEIT6jur4mBFFXUgq
 qGbyK0mNDLaqKUCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 645963EA63;
 Tue, 16 Dec 2025 13:54:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wPy9CYpkQWmoKgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 16 Dec 2025 13:54:18 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, David Hildenbrand <david@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Chenyi Qiang
 <chenyi.qiang@intel.com>, peterx@redhat.com, Alexey Kardashevskiy
 <aik@amd.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: Re: [PATCH v3 02/12] kvm: Detect guest-memfd flags supported
In-Reply-To: <20251215205203.1185099-3-peterx@redhat.com>
References: <20251215205203.1185099-1-peterx@redhat.com>
 <20251215205203.1185099-3-peterx@redhat.com>
Date: Tue, 16 Dec 2025 10:54:15 -0300
Message-ID: <87zf7i1qig.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.98%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.992]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[9]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, intel.com:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

> Detect supported guest-memfd flags by the current kernel, and reject
> creations of guest-memfd using invalid flags.  When the cap isn't
> available, then no flag is supported.
>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

