Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED55CAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 13:10:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v12kW-0007ZH-Jl; Tue, 23 Sep 2025 09:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v12kS-0007Yc-QS
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 09:08:02 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v12kM-00057e-6W
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 09:08:00 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8C1F921EE5;
 Tue, 23 Sep 2025 13:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758632866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MR7BNvsR95iZz3KTAo/fq5mPt4IXJJqy8ebd/FOHoU4=;
 b=PAm9mVMRnxTFNvi/7CcGCz5IDA1l9hNl7TiZ0CA1iopeXiaAZGuTszo5hxExwtlF+2COSw
 9w8POQQnfPlI1znSftJq/StcXGqa6n5Hl0X5qXqyOpqauwgPCySu/5JmhhrPOam8YwFdII
 i6RVWNy3eTFO/NVVkv4dO3KObks7YwI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758632866;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MR7BNvsR95iZz3KTAo/fq5mPt4IXJJqy8ebd/FOHoU4=;
 b=BIysUCdmB+OXOCnYRWF5w5kzBIyZutIUjqFYbf3MVmD6tksf0lv9Ew9PJJYh1Bs9H8h52S
 kHwhl5U9LHOSSxDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758632866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MR7BNvsR95iZz3KTAo/fq5mPt4IXJJqy8ebd/FOHoU4=;
 b=PAm9mVMRnxTFNvi/7CcGCz5IDA1l9hNl7TiZ0CA1iopeXiaAZGuTszo5hxExwtlF+2COSw
 9w8POQQnfPlI1znSftJq/StcXGqa6n5Hl0X5qXqyOpqauwgPCySu/5JmhhrPOam8YwFdII
 i6RVWNy3eTFO/NVVkv4dO3KObks7YwI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758632866;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MR7BNvsR95iZz3KTAo/fq5mPt4IXJJqy8ebd/FOHoU4=;
 b=BIysUCdmB+OXOCnYRWF5w5kzBIyZutIUjqFYbf3MVmD6tksf0lv9Ew9PJJYh1Bs9H8h52S
 kHwhl5U9LHOSSxDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 05AB71388C;
 Tue, 23 Sep 2025 13:07:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hNgqLaGb0mhOJgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 23 Sep 2025 13:07:45 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Fam Zheng <fam@euphon.net>, Paolo Bonzini
 <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefano
 Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH 4/5] tests/libqos: extract qvirtqueue_set_avail_idx()
In-Reply-To: <20250922220149.498967-5-stefanha@redhat.com>
References: <20250922220149.498967-1-stefanha@redhat.com>
 <20250922220149.498967-5-stefanha@redhat.com>
Date: Tue, 23 Sep 2025 10:07:43 -0300
Message-ID: <871pnxmi5c.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.26 / 50.00]; BAYES_HAM(-2.96)[99.84%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[11]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 suse.de:email]
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

Stefan Hajnoczi <stefanha@redhat.com> writes:

> Setting the vring's avail.idx can be useful for low-level VIRTIO tests,
> especially for testing error scenarios with invalid vrings. Extract it
> into a new function so that the next commit can add a test that uses
> this new test API.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Acked-by: Fabiano Rosas <farosas@suse.de>

