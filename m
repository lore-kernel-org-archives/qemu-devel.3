Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1263C3DA41
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 19:49:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRdIq-0001Pc-Af; Wed, 10 Jul 2024 15:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1sRdIl-0001IV-V4; Wed, 10 Jul 2024 15:48:31 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1sRdIk-0004xD-DF; Wed, 10 Jul 2024 15:48:31 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 268F81F83C;
 Wed, 10 Jul 2024 19:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720640906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X3hUx5gy/a4IttBRNLTIbwFbBzecYrG1Ue2sjgXjNU4=;
 b=Kt8HEgVYFTC/XdCzunKPrXBuH8H3I4ldX6jnx/DBz9eltWFxmw4/bvZ+iWYIQkm98A+oay
 9bKuXnDgyE9HiJxJmpVnht6DGk/Nn0KnJauidYYQ/uWqI9tHXg579kio4EvNCWwnRDuSt1
 U3HQcflC20zx5j48loxzDn58LcaDtZg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720640906;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X3hUx5gy/a4IttBRNLTIbwFbBzecYrG1Ue2sjgXjNU4=;
 b=GlFz6EnejyauwOAidRGm+SplyNEvaUb933uqIZXmdmQ7Pqs3lOfTDMKIg0Q624VGrVNzMj
 d889LnNIuUHcY3Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720640906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X3hUx5gy/a4IttBRNLTIbwFbBzecYrG1Ue2sjgXjNU4=;
 b=Kt8HEgVYFTC/XdCzunKPrXBuH8H3I4ldX6jnx/DBz9eltWFxmw4/bvZ+iWYIQkm98A+oay
 9bKuXnDgyE9HiJxJmpVnht6DGk/Nn0KnJauidYYQ/uWqI9tHXg579kio4EvNCWwnRDuSt1
 U3HQcflC20zx5j48loxzDn58LcaDtZg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720640906;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X3hUx5gy/a4IttBRNLTIbwFbBzecYrG1Ue2sjgXjNU4=;
 b=GlFz6EnejyauwOAidRGm+SplyNEvaUb933uqIZXmdmQ7Pqs3lOfTDMKIg0Q624VGrVNzMj
 d889LnNIuUHcY3Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 92997137D2;
 Wed, 10 Jul 2024 19:48:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CucsFYnljmZAGQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 10 Jul 2024 19:48:25 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Tyrone Ting
 <kfting@nuvoton.com>, Bin Meng <bmeng.cn@gmail.com>, Hao Wu
 <wuhaotsh@google.com>, Francisco Iglesias <francisco.iglesias@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, qemu-arm@nongnu.org, Joel
 Stanley <joel@jms.id.au>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 devel@lists.libvirt.org, Luc Michel <luc.michel@amd.com>, =?utf-8?Q?C?=
 =?utf-8?Q?=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH v3 06/17] hw/sd/sdcard: Do not store vendor data on
 block drive (CMD56)
In-Reply-To: <Zo7dcF8OKfH92RlR@x1n>
References: <20240627162232.80428-1-philmd@linaro.org>
 <20240627162232.80428-7-philmd@linaro.org> <87cynmfggx.fsf@suse.de>
 <Zo2lLLAwcZ8bBvO2@x1n> <87a5ipfigb.fsf@suse.de> <Zo6iZjc8YpI1_9dW@x1n>
 <874j8xfc9s.fsf@suse.de> <Zo7dcF8OKfH92RlR@x1n>
Date: Wed, 10 Jul 2024 16:48:23 -0300
Message-ID: <871q41f2pk.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TAGGED_RCPT(0.00)[]; RCPT_COUNT_TWELVE(0.00)[18];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[linaro.org,nongnu.org,redhat.com,nuvoton.com,gmail.com,google.com,amd.com,kaod.org,jms.id.au,lists.libvirt.org];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

> On Wed, Jul 10, 2024 at 01:21:51PM -0300, Fabiano Rosas wrote:
>> It's not about trust, we simply don't support migrations other than
>> n->n+1 and (maybe) n->n-1. So QEMU from 2016 is certainly not included.
>
> Where does it come from?  I thought we suppport that..

I'm taking that from:

docs/devel/migration/main.rst:
  "In general QEMU tries to maintain forward migration compatibility
  (i.e. migrating from QEMU n->n+1) and there are users who benefit from
  backward compatibility as well."

But of course it doesn't say whether that comes with a transitive rule
allowing n->n+2 migrations.

>
> The same question would be: are we requesting an OpenStack cluster to
> always upgrade QEMU with +1 versions, otherwise migration will fail?

Will an OpenStack cluster be using upstream QEMU? If not, then that's a
question for the distro. In a very practical sense, we're not requesting
anything. We barely test n->n+1/n->n-1, even if we had a strong support
statement I wouldn't be confident saying migration from QEMU 2.7 -> QEMU
9.1 should succeed.

