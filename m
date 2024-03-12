Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6114AC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 18:48:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk7AH-0007kj-Up; Tue, 12 Mar 2024 14:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rk7A2-0007dP-Nu
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:47:40 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rk79z-0002Ko-B9
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:47:37 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B6C021F441;
 Tue, 12 Mar 2024 18:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710269252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6R8b3rgCcYEQR6OarCukzYGu3NkiKLChTOrqdOhAk+8=;
 b=PE+6dzoMTuUhRb0tD9vL4FWZjFyd4rvKrFuDLWc2fXFBAAoPtaqp3rWJtc7Jx+W3lC/kr/
 4OCrHMLuofK59UE1HCGn8b5C/yT80JqPozxww2oiGs06GJbUQpruXhNrzPdA0RhCv5ATIJ
 S2t9ycdPW1fLMWzDzyyiSaL46hT+l84=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710269252;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6R8b3rgCcYEQR6OarCukzYGu3NkiKLChTOrqdOhAk+8=;
 b=jDeg8kyuGdfazYcEnnMvPafpYQ8t2djsyzXip9hBDFgWiSwxCpqKornGa1XOwXnt5P7mjA
 7VT8cCOmkxUZy5Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710269252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6R8b3rgCcYEQR6OarCukzYGu3NkiKLChTOrqdOhAk+8=;
 b=PE+6dzoMTuUhRb0tD9vL4FWZjFyd4rvKrFuDLWc2fXFBAAoPtaqp3rWJtc7Jx+W3lC/kr/
 4OCrHMLuofK59UE1HCGn8b5C/yT80JqPozxww2oiGs06GJbUQpruXhNrzPdA0RhCv5ATIJ
 S2t9ycdPW1fLMWzDzyyiSaL46hT+l84=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710269252;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6R8b3rgCcYEQR6OarCukzYGu3NkiKLChTOrqdOhAk+8=;
 b=jDeg8kyuGdfazYcEnnMvPafpYQ8t2djsyzXip9hBDFgWiSwxCpqKornGa1XOwXnt5P7mjA
 7VT8cCOmkxUZy5Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C87313795;
 Tue, 12 Mar 2024 18:47:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qxM7AUSj8GXbdwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 12 Mar 2024 18:47:32 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, Het Gala <het.gala@nutanix.com>
Subject: Re: [PATCH v6 3/8] Replace migrate_get_connect_uri inplace of
 migrate_get_socket_address
In-Reply-To: <20240312162025.44212-4-het.gala@nutanix.com>
References: <20240312162025.44212-1-het.gala@nutanix.com>
 <20240312162025.44212-4-het.gala@nutanix.com>
Date: Tue, 12 Mar 2024 15:47:29 -0300
Message-ID: <87o7bjl22m.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.78 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-2.68)[98.57%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[8];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,nutanix.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

> Refactor migrate_get_socket_address to internally utilize 'socket-address'
> parameter, reducing redundancy in the function definition.
>
> migrate_get_socket_address implicitly converts SocketAddress into str.
> Move migrate_get_socket_address inside migrate_get_connect_uri which
> should return the uri string instead.
>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> Suggested-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

