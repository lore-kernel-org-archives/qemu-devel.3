Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DBD5C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 18:11:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk6b5-00075L-Ll; Tue, 12 Mar 2024 14:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rk6b4-00075A-Tn
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:11:30 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rk6b3-0004oP-Ep
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:11:30 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EAF6F1F443;
 Tue, 12 Mar 2024 18:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710267086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J31DYOnucmyvgvxm/yjY5U0I0pZEcYwOmHYDYwr2oOk=;
 b=LEGW4OQg0E3eY22rFdZZKKQg0STIJOQyBFDVsJgrfG8PG+58TCjI3gTFEkPVoBxjUt7aRQ
 HS7gHiXCxZScU+X5cNeuIE1ZO4GseZ3smL7qq/0mftN6evEWjP9dUo1l9m0i18KdsWoaur
 GiXFrDXd4YIfAg18yVKZb6d01cY1Qhw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710267086;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J31DYOnucmyvgvxm/yjY5U0I0pZEcYwOmHYDYwr2oOk=;
 b=PgOAG0nZwLTvR09s4lvAe0HQwI6oD0Jwm819g8Txk1CK3wTx3KytvQx8eoSG23rdMwt1aT
 7GdFQ/kR1Ewi+UAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710267085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J31DYOnucmyvgvxm/yjY5U0I0pZEcYwOmHYDYwr2oOk=;
 b=D8PyClBDWSXqz4jYawLAzElCzPsmGJT+oRh9UUAoCLh6Zl28niXDApREy3sF7il0MkGuIF
 eHEb84H25GAZLwVyOIRgcUfiGtdw+W6nWvBoTelqQzd/hwE3wLAfWKSITll6TGfwPu/YNk
 dUyzCoQiX1l8i8GxaOPgzGtAnESk2Ck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710267085;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J31DYOnucmyvgvxm/yjY5U0I0pZEcYwOmHYDYwr2oOk=;
 b=fMGvuA9WAY4GWGZKmbRtfNTtt6v+6+3ZpmHti76bggJmruCdPL/5/+OtA9gUtPjTVF5bRu
 rVtUJQGw8UJesVCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7305F1364F;
 Tue, 12 Mar 2024 18:11:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +vmkDs2a8GUEbQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 12 Mar 2024 18:11:25 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, Het Gala <het.gala@nutanix.com>
Subject: Re: [PATCH v6 2/8] Replace connect_uri and move
 migrate_get_socket_address inside migrate_qmp
In-Reply-To: <20240312162025.44212-3-het.gala@nutanix.com>
References: <20240312162025.44212-1-het.gala@nutanix.com>
 <20240312162025.44212-3-het.gala@nutanix.com>
Date: Tue, 12 Mar 2024 15:11:22 -0300
Message-ID: <87zfv3l3qt.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=D8PyClBD;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fMGvuA9W
X-Spamd-Result: default: False [-3.30 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCVD_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+];
 MX_GOOD(-0.01)[]; RCPT_COUNT_SEVEN(0.00)[8];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; BAYES_HAM(-2.99)[99.97%];
 ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.de:email,suse.de:dkim,nutanix.com:email];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: EAF6F1F443
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

Het Gala <het.gala@nutanix.com> writes:

> Move the calls to migrate_get_socket_address() into migrate_qmp().
> Get rid of connect_uri and replace it with args->connect_uri only
> because 'to' object will help to generate connect_uri with the
> correct port number.
>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> Suggested-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

