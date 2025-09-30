Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7578CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 17:53:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3eWT-00056j-AI; Tue, 30 Sep 2025 13:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v3eWP-00056V-MF
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 13:52:17 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v3eWE-00075p-Tt
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 13:52:13 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EFD261F78E;
 Tue, 30 Sep 2025 17:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759254722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VTkOyJoL65MW4hTpbY2QLe/x4Lo7EL3WyU3ceDT4IUw=;
 b=ZzGbQJ2tGXCf3l3VBz8tp7+fJOK7hSyFRDxfjknscP7VpgMuic9OuThSksrGuvo/elnha8
 CqIh7J0Z3qAegRB5iAgDwVHJMf15uSfq+cMseVvV+O555ja9Xp+ccFre8PVBKx4WGFvPLs
 F5jSSYrfk9uxIYk+kl2wx7vh3WMrAkM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759254722;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VTkOyJoL65MW4hTpbY2QLe/x4Lo7EL3WyU3ceDT4IUw=;
 b=BOhMPyWJ27KEnwcVIwPFWuygcw8DRIzi07lSGdNP/J7yo6Lk4ulezvjmjeAnuxuD4c6IR1
 SDdmFecHq6gGvQCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759254721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VTkOyJoL65MW4hTpbY2QLe/x4Lo7EL3WyU3ceDT4IUw=;
 b=vO9BCo57LQPr0KDZ9cOFIYyv29d5DkkdiYSlsHHo+Fq2XG50p7+5JarELvm42a9w5Kx+Ii
 pWXcv2sHsR1GFL/DFJAqf0fUidfJ+Uo/f/Cgr+R0RO+UeNXeGuhGI0lGU+g9+7uaxO2lqY
 7rSduPY6ZTKq+hfuhuT+oVuBWSfez80=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759254721;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VTkOyJoL65MW4hTpbY2QLe/x4Lo7EL3WyU3ceDT4IUw=;
 b=xIdZJedXU0NIYxa4OUfIN2fmJRBgA1lzXuai8IfWk0EFReXCXjtL9fA5ba054K97JUV/kt
 WPY1KGKk8TCqZ/AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 748F91342D;
 Tue, 30 Sep 2025 17:52:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qqo5DsEY3GgcFwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 30 Sep 2025 17:52:01 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] tests/qtest: Add missing checks for the availability of
 machines
In-Reply-To: <20250930090444.234431-1-thuth@redhat.com>
References: <20250930090444.234431-1-thuth@redhat.com>
Date: Tue, 30 Sep 2025 14:51:58 -0300
Message-ID: <87cy77vnep.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.29 / 50.00]; BAYES_HAM(-2.99)[99.94%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Thomas Huth <thuth@redhat.com> writes:

> From: Thomas Huth <thuth@redhat.com>
>
> When QEMU has been compiled with "--without-default-devices", the
> machines might not be available in the binary. Let's properly check
> for the machines before running the tests to avoid that they are
> failing in this case.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>


