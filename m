Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA2FC41513
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 22:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9u2P-0005sZ-Lr; Wed, 22 May 2024 18:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1s9u2M-0005rm-SU; Wed, 22 May 2024 18:02:18 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1s9u2L-0000fb-9Q; Wed, 22 May 2024 18:02:18 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4A5171F892;
 Wed, 22 May 2024 22:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716415335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o6h1j8bvEtDZL1+mJDGH6ltiLLW4n/dckWdaLXiCLa0=;
 b=jnjuC5yCeHwh4rMnofYXa/32OZDtqsQXeIgUZVfZ02VfW+oykYpwd2/FKgmhl8svMiGwSh
 52nvbMKyoWZXbPQJWS8e9HmVuaIlhZkpx23ug9A0CbEAmi6FYbPQmMnprOrMBBpa8tMhXE
 6S+YlRwr4LaClmwgHZqsP8lywzjrajg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716415335;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o6h1j8bvEtDZL1+mJDGH6ltiLLW4n/dckWdaLXiCLa0=;
 b=ezW8gFYpyB7fcaS3n5h3U/4mTSOKzdMHThN1S/ZRxU+8X3f9ovbCuzrzusKOcjGrdu6qeZ
 092peZjzJPBlxxCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716415335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o6h1j8bvEtDZL1+mJDGH6ltiLLW4n/dckWdaLXiCLa0=;
 b=jnjuC5yCeHwh4rMnofYXa/32OZDtqsQXeIgUZVfZ02VfW+oykYpwd2/FKgmhl8svMiGwSh
 52nvbMKyoWZXbPQJWS8e9HmVuaIlhZkpx23ug9A0CbEAmi6FYbPQmMnprOrMBBpa8tMhXE
 6S+YlRwr4LaClmwgHZqsP8lywzjrajg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716415335;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o6h1j8bvEtDZL1+mJDGH6ltiLLW4n/dckWdaLXiCLa0=;
 b=ezW8gFYpyB7fcaS3n5h3U/4mTSOKzdMHThN1S/ZRxU+8X3f9ovbCuzrzusKOcjGrdu6qeZ
 092peZjzJPBlxxCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0CB8E13A1E;
 Wed, 22 May 2024 22:02:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0r31MGNrTmbwKwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 22 May 2024 22:02:11 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org,
	Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-stable@nongnu.org, wangyanan55@huawei.com, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, jasowang@redhat.com,
 yuri.benditovich@daynix.com, andrew@daynix.com, peterx@redhat.com,
 t.lamprecht@proxmox.com
Subject: Re: [PATCH] hw/core/machine: move compatibility flags for VirtIO-net
 USO to machine 8.1
Date: Wed, 22 May 2024 19:02:06 -0300
Message-Id: <171641446561.2133.4163908798536849552.b4-ty@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240517075336.104091-1-f.ebner@proxmox.com>
References: <20240517075336.104091-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.73 / 50.00]; BAYES_HAM(-2.93)[99.72%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[nongnu.org,huawei.com,linaro.org,gmail.com,habkost.net,redhat.com,daynix.com,proxmox.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[12]; RCVD_COUNT_TWO(0.00)[2];
 TAGGED_RCPT(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 TO_DN_SOME(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

On Fri, 17 May 2024 09:53:36 +0200, Fiona Ebner wrote:
> Migration from an 8.2 or 9.0 binary to an 8.1 binary with machine
> version 8.1 can fail with:
> 
> > kvm: Features 0x1c0010130afffa7 unsupported. Allowed features: 0x10179bfffe7
> > kvm: Failed to load virtio-net:virtio
> > kvm: error while loading state for instance 0x0 of device '0000:00:12.0/virtio-net'
> > kvm: load of migration failed: Operation not permitted
> 
> [...]

Queued, thanks!

