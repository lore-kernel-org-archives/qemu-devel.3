Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DDC7C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 14:31:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVuZ7-0005FV-Qx; Fri, 02 Feb 2024 09:30:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rVuZ6-0005F5-72
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 09:30:48 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rVuZ4-0003C2-JQ
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 09:30:47 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 410ED1FD18;
 Fri,  2 Feb 2024 14:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706884243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dZMtKunbUFUNXoGPlwcPcxApPex5XGerDRgpsBlbkco=;
 b=I9VcnRjtHzd2aQx0gUGQFBcH3DQ6xfImDUENnmVvocMljvdVrEVp3KIQiTeUfgbnyQ6Ck9
 hjf+rCAgLYV+PBMSV7aUw9DbqFR6Rw5axDEUVgxuu34smFuuvPI6DRovAVGZ/cM3E15r9h
 Latj8X3SiWJ90qrFgYbSA8WXUD9DtjQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706884243;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dZMtKunbUFUNXoGPlwcPcxApPex5XGerDRgpsBlbkco=;
 b=DQWswR4LbeRcajNbohuT1/biyIUNaFTFQQ1WSnYJs3voBA4uNdmxIBtcId4LDyLco2awwo
 pxFdmJGZXhfTVACg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706884243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dZMtKunbUFUNXoGPlwcPcxApPex5XGerDRgpsBlbkco=;
 b=I9VcnRjtHzd2aQx0gUGQFBcH3DQ6xfImDUENnmVvocMljvdVrEVp3KIQiTeUfgbnyQ6Ck9
 hjf+rCAgLYV+PBMSV7aUw9DbqFR6Rw5axDEUVgxuu34smFuuvPI6DRovAVGZ/cM3E15r9h
 Latj8X3SiWJ90qrFgYbSA8WXUD9DtjQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706884243;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dZMtKunbUFUNXoGPlwcPcxApPex5XGerDRgpsBlbkco=;
 b=DQWswR4LbeRcajNbohuT1/biyIUNaFTFQQ1WSnYJs3voBA4uNdmxIBtcId4LDyLco2awwo
 pxFdmJGZXhfTVACg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B532A13A58;
 Fri,  2 Feb 2024 14:30:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VxQIHpL8vGW0IQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 02 Feb 2024 14:30:42 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>
Subject: Re: [PATCH 1/2] migration: Add a file_error argument to
 close_return_path_on_source()
In-Reply-To: <20240201184853.890471-2-clg@redhat.com>
References: <20240201184853.890471-1-clg@redhat.com>
 <20240201184853.890471-2-clg@redhat.com>
Date: Fri, 02 Feb 2024 11:30:40 -0300
Message-ID: <875xz7hran.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=I9VcnRjt;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=DQWswR4L
X-Spamd-Result: default: False [-3.39 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 BAYES_HAM(-1.08)[88.00%]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 410ED1FD18
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

C=C3=A9dric Le Goater <clg@redhat.com> writes:

> close_return_path_on_source() retrieves the migration error from the
> the QEMUFile '->to_dst_file' to know if a shutdown is required to exit
> the return-path thread. However, in migrate_fd_cleanup(), '->to_dst_file'
> is cleaned up before calling close_return_path_on_source() and the
> shutdown is never performed, leaving the source and destination
> waiting for an event to occur.

Isn't this just missing qemu_file_shutdown() at migrate_fd_cleanup?

    if (s->to_dst_file) {
        ...
        migration_ioc_unregister_yank_from_file(tmp);
+       qemu_file_shutdown(tmp);=20=20=20=20=20=20=20=20
        qemu_fclose(tmp);
    }


