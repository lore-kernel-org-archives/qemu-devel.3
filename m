Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3398D6ED26
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 13:05:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE6rL-0008U1-0j; Thu, 21 Nov 2024 08:04:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tE6rJ-0008TR-RP; Thu, 21 Nov 2024 08:04:33 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tE6rG-0002Pf-5M; Thu, 21 Nov 2024 08:04:33 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1D21921264;
 Thu, 21 Nov 2024 13:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732194264; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5X1IhOjEkOhOt5X+CTLiOtxkSFvZiupCio3Su6F9dfg=;
 b=tAWNgXAFCBCrRiA8F1GYEkznIPW8YpWytSlKcu5h3PC9Y+a3t24FY8k4giiYFDTNcELQt0
 Y0v/bG1R2cq4FnxC3dkZ9qz1ImIU6VxNlSjLqvhIBt1oTHGeFyHDIYKK3Fx3o5ReZ2z7S6
 lwf9sp1mlH7huMJVrrSSCMO++HAT//8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732194264;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5X1IhOjEkOhOt5X+CTLiOtxkSFvZiupCio3Su6F9dfg=;
 b=Rhvk2vOxgljRvBV6eNmbTzPATEzVU91F1E0nT46PyDWCn4X22digr1OKBpcRjrzZTAfZSF
 59LayMRXw9CWHpCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tAWNgXAF;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Rhvk2vOx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732194264; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5X1IhOjEkOhOt5X+CTLiOtxkSFvZiupCio3Su6F9dfg=;
 b=tAWNgXAFCBCrRiA8F1GYEkznIPW8YpWytSlKcu5h3PC9Y+a3t24FY8k4giiYFDTNcELQt0
 Y0v/bG1R2cq4FnxC3dkZ9qz1ImIU6VxNlSjLqvhIBt1oTHGeFyHDIYKK3Fx3o5ReZ2z7S6
 lwf9sp1mlH7huMJVrrSSCMO++HAT//8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732194264;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5X1IhOjEkOhOt5X+CTLiOtxkSFvZiupCio3Su6F9dfg=;
 b=Rhvk2vOxgljRvBV6eNmbTzPATEzVU91F1E0nT46PyDWCn4X22digr1OKBpcRjrzZTAfZSF
 59LayMRXw9CWHpCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 979FB137CF;
 Thu, 21 Nov 2024 13:04:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id h9Y+F9cvP2dXIAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 21 Nov 2024 13:04:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, qemu-stable <qemu-stable@nongnu.org>, Peter Krempa
 <pkrempa@redhat.com>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH] migration: Allow pipes to keep working for fd migrations
In-Reply-To: <20241120160132.3659735-1-peterx@redhat.com>
References: <20241120160132.3659735-1-peterx@redhat.com>
Date: Thu, 21 Nov 2024 10:04:21 -0300
Message-ID: <87ed34sppm.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1D21921264
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_FIVE(0.00)[6]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

> Libvirt may still use pipes for old file migrations in fd: URI form,
> especially when loading old images dumped from Libvirt's compression
> algorithms.
>
> In that case, Libvirt needs to compress / uncompress the images on its own
> over the migration binary stream, and pipes are passed over to QEMU for
> outgoing / incoming migrations in "fd:" URIs.
>
> For future such use case, it should be suggested to use mapped-ram when
> saving such VM image.  However there can still be old images that was
> compressed in such way, so libvirt needs to be able to load those images,
> uncompress them and use the same pipe mechanism to pass that over to QEMU.
>
> It means, even if new file migrations can be gradually moved over to
> mapped-ram (after Libvirt start supporting it), Libvirt still needs the
> uncompressor for the old images to be able to load like before.
>
> Meanwhile since Libvirt currently exposes the compression capability to
> guest images, it may needs its own lifecycle management to move that over
> to mapped-ram, maybe can be done after mapped-ram saved the image, however
> Dan and PeterK raised concern on temporary double disk space consumption.
> I suppose for now the easiest is to enable pipes for both sides of "fd:"
> migrations, until all things figured out from Libvirt side on how to move
> on.
>
> And for "channels" QMP interface support on "migrate" / "migrate-incoming"
> commands, we'll also need to move away from pipe.  But let's leave that f=
or
> later too.
>
> So far, still allow pipes to happen like before on both save/load sides,
> just like we would allow sockets to pass.
>
> Cc: qemu-stable <qemu-stable@nongnu.org>
> Cc: Fabiano Rosas <farosas@suse.de>
> Cc: Peter Krempa <pkrempa@redhat.com>
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Fixes: c55deb860c ("migration: Deprecate fd: for file migration")
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

