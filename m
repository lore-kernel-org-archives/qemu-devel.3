Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A815CCD1AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:58:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJQN-0008SQ-TN; Tue, 21 Oct 2025 16:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vBJQH-0008Ri-NG
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:57:38 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vBJQE-0002Dt-GK
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:57:37 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F064D21187;
 Tue, 21 Oct 2025 20:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1761080248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C8NgEsvKHw4S/0o9XZLFVi0wqJV4aLQ5QpnfJp2smIw=;
 b=zl08H+V2b9H/odq9By+hsSd0SyjiAxMLGUMbgdWFgIAO4ivPMDY3Q6cO9AwSrkD6bOnH6B
 p3WTBBYNbDaS8SowUl2lyVn/9fvgaWOc5hj9tyUjEc8DbQxqptqh6WRBQyESuLHc5ZzeJ4
 MLX/Yf5CQFloWgsAhmVu8PpPyEpIJuE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1761080248;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C8NgEsvKHw4S/0o9XZLFVi0wqJV4aLQ5QpnfJp2smIw=;
 b=Lxmwkk15+oyCtIe5tuK+g+bNdbZGbDTQAo8oCM74YQqO2P64ym3Z20FMm9KVpu8c7rzov+
 PObXePgy6BuySoBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pfsvATfO;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sU2ngF7A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1761080243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C8NgEsvKHw4S/0o9XZLFVi0wqJV4aLQ5QpnfJp2smIw=;
 b=pfsvATfOr9yXC6KGsBRsRphA7jv7d2FkHeTgsKyWjSssuJ4I5g4OPB2MyhoCBGQY6C+ce1
 KDXj0TxAEYtkDVDPzU7FLiw/o24PCtSuvclM/InZYDd5zmhMlJ7+kJKWjjHjTCiA8d8d5x
 VTO4R3RxSV7IvxozCVGqv9mXu+dMTIs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1761080243;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C8NgEsvKHw4S/0o9XZLFVi0wqJV4aLQ5QpnfJp2smIw=;
 b=sU2ngF7AGrXZ23O04cXcj96A2vxU/7Gcry2UpvfN+MtV7Fklk+cgQlMKLG8EXrPv+nr8fK
 K9hFHqgobgMvAnDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 688E9139D2;
 Tue, 21 Oct 2025 20:57:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SYMMC7Pz92hUXAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 21 Oct 2025 20:57:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, John Snow <jsnow@redhat.com>, Laurent Vivier
 <laurent@vivier.eu>, kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>,
 qemu-trivial@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Sunil Muthuswamy
 <sunilmut@microsoft.com>, Marcelo Tosatti <mtosatti@redhat.com>, Michael
 Tokarev <mjt@tls.msk.ru>, Richard Henderson
 <richard.henderson@linaro.org>, qemu-block@nongnu.org, Paolo Bonzini
 <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Bernhard Beschow
 <shentey@gmail.com>
Subject: Re: [PATCH 8/8] tests/qtest/ds1338-test: Reuse from_bcd()
In-Reply-To: <20251017113338.7953-9-shentey@gmail.com>
References: <20251017113338.7953-1-shentey@gmail.com>
 <20251017113338.7953-9-shentey@gmail.com>
Date: Tue, 21 Oct 2025 17:57:20 -0300
Message-ID: <87ikg8t1lb.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: F064D21187
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-2.79)[99.09%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[19];
 FREEMAIL_TO(0.00)[gmail.com,nongnu.org]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,habkost.net,vivier.eu,vger.kernel.org,intel.com,nongnu.org,gmail.com,microsoft.com,tls.msk.ru,linaro.org];
 MID_RHS_MATCH_FROM(0.00)[]; TAGGED_RCPT(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
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

Bernhard Beschow <shentey@gmail.com> writes:

> from_bcd() is a public API function which can be unit-tested. Reuse it to avoid
> code duplication.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

