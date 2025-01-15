Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A989C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 14:53:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY4lV-0007Ff-0U; Wed, 15 Jan 2025 09:53:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tY4ky-00071C-Sd
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 09:52:34 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tY4kv-0000nP-Kg
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 09:52:32 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9A6032126D;
 Wed, 15 Jan 2025 14:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736952744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yI2/duX2tL1lkz9Vq8RqVv6H6h6bVl8PSdRleJ1NJIY=;
 b=Ihv1Vjh6sk0MKl2ensrz41paEK20XNvnd+nSrH2tY8omTFxr9ApCYfndQcN76AXdbLiNN+
 HsM1wTXznSd2F2fk74YIp41oeEtd8W7qivOV0unh/tK4g+OQxCqYcQ678vMRWn2nLMAlvD
 fbdFr5wsWrjx7iY2pdGTg5KKPRgOMjg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736952744;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yI2/duX2tL1lkz9Vq8RqVv6H6h6bVl8PSdRleJ1NJIY=;
 b=c1ogkiVHLcc5b3oIUggNlFpMlXC29ca7TIN9+3b5AKpLzNf2/72vz9t2AOXLcrmImMAnlu
 uJ3aBOL2GExVtHCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736952744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yI2/duX2tL1lkz9Vq8RqVv6H6h6bVl8PSdRleJ1NJIY=;
 b=Ihv1Vjh6sk0MKl2ensrz41paEK20XNvnd+nSrH2tY8omTFxr9ApCYfndQcN76AXdbLiNN+
 HsM1wTXznSd2F2fk74YIp41oeEtd8W7qivOV0unh/tK4g+OQxCqYcQ678vMRWn2nLMAlvD
 fbdFr5wsWrjx7iY2pdGTg5KKPRgOMjg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736952744;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yI2/duX2tL1lkz9Vq8RqVv6H6h6bVl8PSdRleJ1NJIY=;
 b=c1ogkiVHLcc5b3oIUggNlFpMlXC29ca7TIN9+3b5AKpLzNf2/72vz9t2AOXLcrmImMAnlu
 uJ3aBOL2GExVtHCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1FB2413A6F;
 Wed, 15 Jan 2025 14:52:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CSFfNafLh2c+fAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 15 Jan 2025 14:52:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost
 <eduardo@habkost.net>, Philippe Mathieu-Daude <philmd@linaro.org>, Paolo
 Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Steve Sistare
 <steven.sistare@oracle.com>
Subject: Re: [PATCH V6 00/24] Live update: cpr-transfer
In-Reply-To: <87plkpf8bn.fsf@suse.de>
References: <1736875434-106563-1-git-send-email-steven.sistare@oracle.com>
 <87plkpf8bn.fsf@suse.de>
Date: Wed, 15 Jan 2025 11:52:21 -0300
Message-ID: <87bjw8f7tm.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-2.78 / 50.00]; BAYES_HAM(-2.98)[99.93%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; TAGGED_RCPT(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_SEVEN(0.00)[11];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,gmail.com,habkost.net,linaro.org,oracle.com];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url,suse.de:mid,suse.de:email]
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

Fabiano Rosas <farosas@suse.de> writes:

> Hi Steve,
>
> The CI shows some issues, please take a look:
>
> https://gitlab.com/farosas/qemu/-/pipelines/1624984802

The asan build is also upset:

../configure --target-list=x86_64-softmmu --disable-docs \
--python=/usr/bin/python3.11 --disable-plugins --enable-debug \
--enable-asan --cc=clang

QTEST_QEMU_BINARY=../build/qemu-system-x86_64 \
./tests/qtest/migration-test -p /x86_64/migration/mode/transfer


Direct leak of 392 byte(s) in 1 object(s) allocated from:                                                                                                                                      
    ...
    #2 0x5607648c3fd0 in object_new ../qom/object.c:789:12
    #3 0x5607649a3da3 in qio_channel_socket_new ../io/channel-socket.c:64:31            
    #4 0x560763f59845 in cpr_transfer_output ../migration/cpr-transfer.c:28:34

Direct leak of 392 byte(s) in 1 object(s) allocated from:
    ...
    #2 0x55dfe6727fd0 in object_new ../qom/object.c:789:12
    #3 0x55dfe6807da3 in qio_channel_socket_new ../io/channel-socket.c:64:31

Direct leak of 120 byte(s) in 5 object(s) allocated from:
    ...
    #2 0x55dfe67fc671 in qemu_peek_byte ../migration/qemu-file.c:777:9

Direct leak of 104 byte(s) in 1 object(s) allocated from:
    ...
    #2 0x55dfe6727fd0 in object_new ../qom/object.c:789:12
    #3 0x55dfe6825e0f in qio_net_listener_new ../io/net-listener.c:29:29
    #4 0x55dfe5dbdad4 in cpr_transfer_input ../migration/cpr-transfer.c:57:36

Direct leak of 24 byte(s) in 1 object(s) allocated from:
    ...
    #2 0x55dfe67fc671 in qemu_peek_byte ../migration/qemu-file.c:777:9
    #3 0x55dfe67fc7ad in qemu_get_byte ../migration/qemu-file.c:790:14
    #4 0x55dfe67ffc1b in qemu_get_be32 ../migration/qemu-file.c:840:23
    #5 0x55dfe5dbc584 in cpr_state_load ../migration/cpr.c:189:9

