Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67238C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 21:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4RxY-0000aJ-H3; Tue, 07 May 2024 17:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s4RxR-0000Wv-AM
 for qemu-devel@nongnu.org; Tue, 07 May 2024 17:02:42 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s4RxH-0002wL-29
 for qemu-devel@nongnu.org; Tue, 07 May 2024 17:02:41 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EA43C3458F;
 Tue,  7 May 2024 21:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715115746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DVGwp26d8c5nDhqNSry6j3c5+vUugd1/I1KcCn5vyWs=;
 b=l3DBKVNDGUHYyJ1xUcU8Z8U4ZKVdFdFLEMKtMai9Hw70ZwbLGp6c1xY4PqBXVUj8LwiDUo
 hwFy8xXL3N5ehg1DG2PhZd4lOKvYkJWHzNjrWxIT0o3zb9VBVmnq8k6hUkpviAROBs8pHR
 ELjBnIwC8bCyDrxxQy9swDg0qgRDlck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715115746;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DVGwp26d8c5nDhqNSry6j3c5+vUugd1/I1KcCn5vyWs=;
 b=CwlagoUj18QFkJ+dW/6bJDi8/CgL62K9IxYHfiE8IGU3TMhg9JYbNm14+4r+S3F7pNBijG
 fnruFxLedmeVrWAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715115745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DVGwp26d8c5nDhqNSry6j3c5+vUugd1/I1KcCn5vyWs=;
 b=nHxL6/gYO60+68IV+17tc3h3CxtWVXzNp2gBWnX51CN8HWhoe2yBbI8lYdKXYu7/2/OcxS
 0rAz8q2f2SJTwlkVrKIs9t7vp+rXMvRVXx18KFuevgQr8YrWZeiAIIck9GlgqjkjCuqLCR
 hhmnuNILiQXPUxF5RlETLEG0lkVcDvs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715115745;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DVGwp26d8c5nDhqNSry6j3c5+vUugd1/I1KcCn5vyWs=;
 b=tEKTShf5yGn3Nklxaqmh6MHWoWYAaC7/X7gZDIH5TFtAUkiL2reBByxhw+keip2pHdeQLx
 wPi0PdgOXVdxSVDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6CBBE139CB;
 Tue,  7 May 2024 21:02:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2DHwDOGWOmbvPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 07 May 2024 21:02:25 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, Igor
 Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Philippe Mathieu-Daude
 <philmd@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P.
 Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH V1 05/26] migration: precreate vmstate
In-Reply-To: <1714406135-451286-6-git-send-email-steven.sistare@oracle.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-6-git-send-email-steven.sistare@oracle.com>
Date: Tue, 07 May 2024 18:02:22 -0300
Message-ID: <87r0edl4ip.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [0.02 / 50.00]; SUSPICIOUS_RECIPS(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; BAYES_HAM(-0.18)[70.40%];
 MIME_GOOD(-0.10)[text/plain]; RCVD_TLS_ALL(0.00)[];
 TAGGED_RCPT(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,habkost.net,gmail.com,linaro.org,oracle.com];
 RCPT_COUNT_TWELVE(0.00)[12]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[]
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

Steve Sistare <steven.sistare@oracle.com> writes:

> Provide the VMStateDescription precreate field to mark objects that must
> be loaded on the incoming side before devices have been created, because
> they provide properties that will be needed at creation time.  They will
> be saved to and loaded from their own QEMUFile, via

It's not obvious to me what the reason is to have a separate
QEMUFile. Could you expand on this?

> qemu_savevm_precreate_save and qemu_savevm_precreate_load, but these
> functions are not yet called in this patch.  Allow them to be called
> before or after normal migration is active, when current_migration and
> current_incoming are not valid.
>

