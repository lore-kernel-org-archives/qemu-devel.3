Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB7BE7DEF3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 15:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmvdS-0008Pa-5w; Mon, 02 Feb 2026 10:14:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vmvdP-0008LK-4E
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 10:14:39 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vmvdM-0007nc-2X
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 10:14:38 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6D0545BD8F;
 Mon,  2 Feb 2026 15:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770045274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DYlwy6w2U+BDklmjmtOhnWzEgPbJyux1Obie5pxU/0Y=;
 b=eFcmGM5vwDFXXgQbZaoX/oiM9ma5uu3iWM717ipdGWKH8FyGH1U0VdQCkFPLQ61gO/HwFP
 t2AIPs6A8RuyvZXOvmhhBoArqjuCnbFkXrjnv9UPAMGO6m4N+jwEsHGz2F/HvW+x266AJw
 3ukL36H9C89T2OIpbIkF6AD0snQVGYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770045274;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DYlwy6w2U+BDklmjmtOhnWzEgPbJyux1Obie5pxU/0Y=;
 b=OHIUozAhGPvs42+G1I03O0WrmXjLGiVK47KYnjCTtEtfs1aab+u/qZrUpyVlKHKrnSVsLP
 apv/49vMr3ZzAlDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770045274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DYlwy6w2U+BDklmjmtOhnWzEgPbJyux1Obie5pxU/0Y=;
 b=eFcmGM5vwDFXXgQbZaoX/oiM9ma5uu3iWM717ipdGWKH8FyGH1U0VdQCkFPLQ61gO/HwFP
 t2AIPs6A8RuyvZXOvmhhBoArqjuCnbFkXrjnv9UPAMGO6m4N+jwEsHGz2F/HvW+x266AJw
 3ukL36H9C89T2OIpbIkF6AD0snQVGYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770045274;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DYlwy6w2U+BDklmjmtOhnWzEgPbJyux1Obie5pxU/0Y=;
 b=OHIUozAhGPvs42+G1I03O0WrmXjLGiVK47KYnjCTtEtfs1aab+u/qZrUpyVlKHKrnSVsLP
 apv/49vMr3ZzAlDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D691A3EA62;
 Mon,  2 Feb 2026 15:14:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id DmazJVm/gGn8PwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 02 Feb 2026 15:14:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Lukas Straub <lukasstraub2@web.de>, Prasad Pandit
 <ppandit@redhat.com>, Juraj Marcin <jmarcin@redhat.com>, David Woodhouse
 <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Subject: Re: [PATCH v2 24/24] migration/colo/xen: Use generic helpers in
 qemu_save_device_state()
In-Reply-To: <20260127185254.3954634-25-peterx@redhat.com>
References: <20260127185254.3954634-1-peterx@redhat.com>
 <20260127185254.3954634-25-peterx@redhat.com>
Date: Mon, 02 Feb 2026 12:14:31 -0300
Message-ID: <871pj3rxd4.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.98%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[8]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[]; FREEMAIL_ENVRCPT(0.00)[web.de];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,web.de,infradead.org,xen.org];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_SOME(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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
List-Id: qemu development <qemu-devel.nongnu.org>
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

> Use qemu_savevm_state_non_iterable*() helpers for saving device states,
> rather than walking the vmstate handlers on its own.
>
> Non-iterables can be either early_setup devices, or otherwise.
>
> Note that QEMU only has one early_setup device currently, which is
> virtio-mem, and I highly doubt if it is used in either COLO or Xen users..
> However this step is still better needed to provide full coverage of all
> non-iterable vmstates.
>
> When at it, allow it to report errors.
>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Paul Durrant <paul@xen.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

