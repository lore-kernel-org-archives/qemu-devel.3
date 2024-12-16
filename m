Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37917E77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 15:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNCqV-0001OK-IL; Mon, 16 Dec 2024 10:17:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tNCqT-0001NA-EN; Mon, 16 Dec 2024 10:17:17 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tNCqR-0008P0-Tj; Mon, 16 Dec 2024 10:17:17 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E61B22111F;
 Mon, 16 Dec 2024 15:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734362234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XmKfLXzv81KKp2gGD+8S42PfuY3sq0pgK5uwggMYRw8=;
 b=jcklV2E5yNyUeBTyrnJNE409xJ6cwF991HMvCpAEaIeHaZED0ac4iCLW8gdtuXjKD95zYc
 pDtn+LOC1YAkM9EVpazXQdeyIdHoXhVcRIPEindCKvOnigDTNVyGnghL868F6N308V5nZn
 igd+b1h9EeGYcHBVUGuLf95FDF0yl9k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734362234;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XmKfLXzv81KKp2gGD+8S42PfuY3sq0pgK5uwggMYRw8=;
 b=id5Nb4Vi6tzT6/fG6Nh8vYAeTIPdD3QgnFapLiY95Cri3LIHDi9Va3lMBWGXPiG/pZ4zw+
 GZcp7YfndvKLnDAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734362233; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XmKfLXzv81KKp2gGD+8S42PfuY3sq0pgK5uwggMYRw8=;
 b=wZU8sG3BQ6wWWB8ednKMdxTCoNxRRgoBjAVp4yIE+gn1VUZaFKqeBjTmSC29zYOlhN+Bj2
 UU6vds5H+4MqYshiAH6JZ3xPK0TtMYDvaJFEUJZAaNVBdu0kuDsEsEG/dbe4YAUkdVr/3d
 lai6Mh5Pn/Eq6ha/gb4wrupIb0uazTY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734362233;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XmKfLXzv81KKp2gGD+8S42PfuY3sq0pgK5uwggMYRw8=;
 b=wzGweN1NadnjV9ccjMt6qgZjKxeh+7L0QtSuHjM7NoqV1YEIKoqt5Aorf7jBZWCf0KIXah
 seYYm1wgfKIpKnCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6DBE413418;
 Mon, 16 Dec 2024 15:17:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id b+sVDXlEYGezEgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 16 Dec 2024 15:17:13 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>, Stefan Hajnoczi <stefanha@redhat.com>, Andrey
 Drobyshev <andrey.drobyshev@virtuozzo.com>, Eric Blake
 <eblake@redhat.com>, "Dr . David Alan Gilbert" <dave@treblig.org>, Kevin
 Wolf <kwolf@redhat.com>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH v2 4/6] migration/block: Apply late-block-active
 behavior to postcopy
In-Reply-To: <20241206230838.1111496-5-peterx@redhat.com>
References: <20241206230838.1111496-1-peterx@redhat.com>
 <20241206230838.1111496-5-peterx@redhat.com>
Date: Mon, 16 Dec 2024 12:17:10 -0300
Message-ID: <871py7y7wp.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_SEVEN(0.00)[11];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:email,
 suse.de:mid]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> Postcopy never cared about late-block-active.  However there's no mention
> in the capability that it doesn't apply to postcopy.
>
> Considering that we _assumed_ late activation is always good, do that too
> for postcopy unconditionally, just like precopy.  After this patch, we
> should have unified the behavior across all.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

