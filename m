Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F8FC0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 21:01:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcshu-00071g-Uk; Tue, 28 Jan 2025 16:01:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tcshs-00070L-MT
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 16:01:12 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tcshp-0002Ag-3i
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 16:01:11 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8EAC41F365;
 Tue, 28 Jan 2025 21:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738098063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TrDduViFI/tiGmKfgFfiqOsqgJOgOICwoCOZMeS4AWU=;
 b=TcE7ADDJ05afSAw7Gch7BmJ2HBimzkNmP1WiEk1O/xm5ZJniP1OpX/1ef9qmlE69KtXzN9
 2BPYXuUjJMhf3HRhlh4FHkKu6lyTtjbJIhDMOOQUT9qC+U5JBqXnZ9/FNPM59+d1fTqlYa
 Uqar7Hvu6X3pSk+LbrgeO+wmhVAObCI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738098063;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TrDduViFI/tiGmKfgFfiqOsqgJOgOICwoCOZMeS4AWU=;
 b=vwBInEDT3dXgaEDALUInzVR1T7B40PjCMGGR1Q1sXBJQwWSOn4rkzeyZpuRc0cBPEvaLf4
 J+gaNHK0UVcuTdBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738098062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TrDduViFI/tiGmKfgFfiqOsqgJOgOICwoCOZMeS4AWU=;
 b=dkg8qB4h0fBzBlmScrG6KcNP5wFGXyIaot2oSOBx4GG5dZbrGQsWehkX2K7PRYhYZPCW5/
 +FrpWXv+3PP3p1UYJ6yEEE8aYSorFakq6Xe4a4eeRY0MlfMSqRB5O47kf/13TT0Gcmk/zp
 Sajb4GNG11UWQ12uX4vFZqMyJH+AfDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738098062;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TrDduViFI/tiGmKfgFfiqOsqgJOgOICwoCOZMeS4AWU=;
 b=w0Pjdp/jzza1t4EOdazm3++tv6gNfY/WxKJ19bBhr29l0PMCqOc6wxdneS9hSLD55CsWK3
 6ciYexFPCNDfdFDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE04813625;
 Tue, 28 Jan 2025 21:01:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2/3QKY1FmWezWQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 28 Jan 2025 21:01:01 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Thomas Huth <thuth@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-devel@nongnu.org, "Daniel P . Berrange"
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH] tests/qtest/qom-test: Test retrieval of machine class
 properties
In-Reply-To: <20250123204956.1561463-1-thuth@redhat.com>
References: <20250123204956.1561463-1-thuth@redhat.com>
Date: Tue, 28 Jan 2025 18:00:59 -0300
Message-ID: <87bjvq1wms.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-3.96 / 50.00]; BAYES_HAM(-2.66)[98.51%];
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 suse.de:email]
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

Thomas Huth <thuth@redhat.com> writes:

> There were recently some crashes that occurred when trying to
> retrieve the properties of machines. Let's add a test to avoid
> regression here.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

