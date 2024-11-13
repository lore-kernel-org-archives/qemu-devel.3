Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0933CD637C4
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 22:15:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBLdV-0001L9-Ru; Wed, 13 Nov 2024 17:14:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tBLdT-0001Kw-Qj
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 17:14:51 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tBLdS-0002qP-40
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 17:14:51 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5E38F211F4;
 Wed, 13 Nov 2024 22:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731536087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cwAMhOTFEeTM5+YBA4yZe4Jd7gznDZkpJGoRNd3Q1Y8=;
 b=XY4NkyNbY7l5nDJw51yx9kceu7RpqYPTIMstCKwiIdkuu8yaGSeKZ0PUYOn8Knu5/eCFnM
 FBqEIz7zdfukkVrLJbOF1UXfy11IXB3q3ah7+UkBFG1HqS1DWw2837VXA6qVTN3gmzRF+v
 M9OsKyJzOHWOFHQoAXFdW1jrtR0Eaks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731536087;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cwAMhOTFEeTM5+YBA4yZe4Jd7gznDZkpJGoRNd3Q1Y8=;
 b=AAorzACe8i7Ny7Eyq++RbR0V8c0/zbswryQIIebXtUuG4qZTBLgCydx22E+QTwrY6aW/Ra
 Qv8v4vr+HEetEMDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731536087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cwAMhOTFEeTM5+YBA4yZe4Jd7gznDZkpJGoRNd3Q1Y8=;
 b=XY4NkyNbY7l5nDJw51yx9kceu7RpqYPTIMstCKwiIdkuu8yaGSeKZ0PUYOn8Knu5/eCFnM
 FBqEIz7zdfukkVrLJbOF1UXfy11IXB3q3ah7+UkBFG1HqS1DWw2837VXA6qVTN3gmzRF+v
 M9OsKyJzOHWOFHQoAXFdW1jrtR0Eaks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731536087;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cwAMhOTFEeTM5+YBA4yZe4Jd7gznDZkpJGoRNd3Q1Y8=;
 b=AAorzACe8i7Ny7Eyq++RbR0V8c0/zbswryQIIebXtUuG4qZTBLgCydx22E+QTwrY6aW/Ra
 Qv8v4vr+HEetEMDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D194C13A6E;
 Wed, 13 Nov 2024 22:14:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4VsFJdYkNWfnHAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 13 Nov 2024 22:14:46 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd
 Hoffmann <kraxel@redhat.com>
Subject: Re: [RFC PATCH 2/5] qtest/libqos/pci: Fix msix_enable sharing bar0
In-Reply-To: <20241108154229.263097-3-npiggin@gmail.com>
References: <20241108154229.263097-1-npiggin@gmail.com>
 <20241108154229.263097-3-npiggin@gmail.com>
Date: Wed, 13 Nov 2024 19:14:44 -0300
Message-ID: <871pzeixwr.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-2.67 / 50.00]; BAYES_HAM(-2.87)[99.44%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[suse.de:email,suse.de:mid];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_CC(0.00)[gmail.com,redhat.com]; ARC_NA(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com,nongnu.org]; RCVD_TLS_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; MISSING_XM_UA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; TAGGED_RCPT(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[8]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Nicholas Piggin <npiggin@gmail.com> writes:

> Devices where the MSI-X addresses are shared with other MMIO on BAR0
> can not use msi_enable because it unmaps and remaps BAR0, which
> interferes with device MMIO mappings. xhci-nec is one such device we
> would like to test msix with.
>
> Keep track of each the BAR iomaps for each device and add code in msix
> to use existing iomap if the msix bars are already mapped.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

