Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9622C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 20:00:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjlni-00084O-V7; Mon, 11 Mar 2024 15:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rjlnY-00083R-Lc
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:59:00 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rjlnW-0000aA-Q5
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:59:00 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8ADB45CB01;
 Mon, 11 Mar 2024 19:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710187136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EQIlNFBGMW7HttgnFGFtrjuF9dM6bEl+Ha/P5CTFBx0=;
 b=LcSYedUOkeCY/vAsWNSzdK/wagPntD4HIH2JcE8ARI4I2OBWngIIsoKxUkW21ZhFL7jFxO
 UksrftLIfNM6aOyG+kz18E7Z/0eRxEm1ZbQTc2PXrhn0Nunrw+KVOAQkpt3IvW1hvhvoDi
 fBEyAPVJp51ma0QJkiQxrg3oTWLugLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710187136;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EQIlNFBGMW7HttgnFGFtrjuF9dM6bEl+Ha/P5CTFBx0=;
 b=IBhE3wWIQcXDZ/8wsqGtjodnkyX9URV0d8gKMt9cqeaHgfXOWtXG5ikNqpAzWQjA6C/Q/k
 B9/+YKzknUXzqGDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710187135; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EQIlNFBGMW7HttgnFGFtrjuF9dM6bEl+Ha/P5CTFBx0=;
 b=xyFhTdG/Rvbw7tE+9/CZNHt8ZE7SiHaX+UocZ/ajwcTDhPbhSVPL6c119IRseUVLqRfDvB
 GVKQJMDzn141ZT7tbhXo65eu7iON6mjVX/CMVRwJXL/y4u7Svkz2ZzYUnfbpAQnlL81MNt
 eD9/GYEzSP83nqc66wrknQvI/uSQVN4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710187135;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EQIlNFBGMW7HttgnFGFtrjuF9dM6bEl+Ha/P5CTFBx0=;
 b=C/frjiR/+c/Y0ODjdyeBCiiWNkRQfEUdCGj6NmL5+5idDvtlX88SSkFitj0zdND7whF88O
 mjyzwFQRlnq+T4CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 18089136BA;
 Mon, 11 Mar 2024 19:58:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id B2MdM35i72VqVgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 11 Mar 2024 19:58:54 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, Het Gala <het.gala@nutanix.com>
Subject: Re: [PATCH v4 7/8] Add multifd_tcp_plain test using list of
 channels instead of uri
In-Reply-To: <20240308205951.111747-8-het.gala@nutanix.com>
References: <20240308205951.111747-1-het.gala@nutanix.com>
 <20240308205951.111747-8-het.gala@nutanix.com>
Date: Mon, 11 Mar 2024 16:58:52 -0300
Message-ID: <87il1smtfn.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.07 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-1.77)[93.61%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.994]; RCPT_COUNT_SEVEN(0.00)[7];
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

> Add a positive test to check multifd live migration but this time
> using list of channels (restricted to 1) as the starting point
> instead of simple uri string.
>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> Suggested-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

