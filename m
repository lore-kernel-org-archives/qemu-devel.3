Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A90C5B555
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 13:42:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNXKR-0007bh-Ab; Fri, 06 Jun 2025 09:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uNXKO-0007b9-Lb
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 09:41:49 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uNXKL-000516-Mp
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 09:41:48 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7B0D51F445;
 Fri,  6 Jun 2025 13:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1749217210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nlQ+yadNwv1XSC329hMwu8yg08l5Ux358+VWygcHvHM=;
 b=tePVeH1AmzSQXbvIMJFRJ7/rqc65yLBTsqD0Q5ZxuLLvFCcQATzBqnhF7rt4Vdj4MJdNfF
 wYKFsc5NyZOEWKnnJmOQTbc/C6cPJqn3qR4JPPVq3uznBKPCFSBti3sib9zwoIfdztiLUx
 5FSg2zJ5hCr6dQ6jchkUR5UYNuWYZiM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1749217210;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nlQ+yadNwv1XSC329hMwu8yg08l5Ux358+VWygcHvHM=;
 b=yIF1Nk2Z9MIbSs/n6nicqwlllsfKXlZoGzkhAgR08rN/b0jGDznT/uP2Pamp4PWseuh/wc
 OrQT7MTXxDvHItBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1749217210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nlQ+yadNwv1XSC329hMwu8yg08l5Ux358+VWygcHvHM=;
 b=tePVeH1AmzSQXbvIMJFRJ7/rqc65yLBTsqD0Q5ZxuLLvFCcQATzBqnhF7rt4Vdj4MJdNfF
 wYKFsc5NyZOEWKnnJmOQTbc/C6cPJqn3qR4JPPVq3uznBKPCFSBti3sib9zwoIfdztiLUx
 5FSg2zJ5hCr6dQ6jchkUR5UYNuWYZiM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1749217210;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nlQ+yadNwv1XSC329hMwu8yg08l5Ux358+VWygcHvHM=;
 b=yIF1Nk2Z9MIbSs/n6nicqwlllsfKXlZoGzkhAgR08rN/b0jGDznT/uP2Pamp4PWseuh/wc
 OrQT7MTXxDvHItBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF9171336F;
 Fri,  6 Jun 2025 13:40:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id x4uGK7nvQmhkAgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 06 Jun 2025 13:40:09 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Jaehoon Kim <jhkim@linux.ibm.com>, qemu-devel@nongnu.org
Cc: jjherne@linux.ibm.com, steven.sistare@oracle.com, peterx@redhat.com,
 Jaehoon Kim <jhkim@linux.ibm.com>
Subject: Re: [PATCH v1] migration: Wait for cpr.sock file to appear before
 connecting
In-Reply-To: <20250605230808.1278840-1-jhkim@linux.ibm.com>
References: <20250605230808.1278840-1-jhkim@linux.ibm.com>
Date: Fri, 06 Jun 2025 10:40:07 -0300
Message-ID: <87plfhvvig.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-3.15 / 50.00]; BAYES_HAM(-1.85)[94.13%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Jaehoon Kim <jhkim@linux.ibm.com> writes:

> When the source VM attempts to connect to the destination VM's Unix
> domain socket(cpr.sock) during CPR transfer, the socket file might not
> yet be exist if the destination side hasn't completed the bind
> operation. This can lead to connection failures when running tests with
> the qtest framework.
>

Could you provide us the output of qtest in this case? Are you simply running
make check or something else?


