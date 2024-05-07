Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E17C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 20:48:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4RiR-0002HZ-28; Tue, 07 May 2024 16:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s4Ri2-00027L-3f
 for qemu-devel@nongnu.org; Tue, 07 May 2024 16:46:59 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s4Rhy-0002Ns-PV
 for qemu-devel@nongnu.org; Tue, 07 May 2024 16:46:44 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B953134556;
 Tue,  7 May 2024 20:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715114799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7u6Z88u+LEtTCHvAw3XwbSINJZpfMjAsfiNeZtWI/NQ=;
 b=qZNV+kT5GUGC2RJk++vf+i7JDLO2zxS244I/hBz8k4nr0jPkplNRWn0ZYp3imkGY/1Whu6
 q53XNXKV7jyFEB+ZCjOc6cyDBfy6qjsxXubOJ/xBbO37DeMQl/+P4Fo95qPJL5B6RJQ0u6
 whWBEs+v2zv85YPYPqK0byj4YM7k1Ho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715114799;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7u6Z88u+LEtTCHvAw3XwbSINJZpfMjAsfiNeZtWI/NQ=;
 b=3ZPBn2nPIhiIrujlGLkWoGmMAu/Xo5PRNAMdbbUX3m9ePhlGZFDZ2SVYpB3FE1CF1Smgr/
 l3qeZUyu8QPf5DAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qZNV+kT5;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3ZPBn2nP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715114799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7u6Z88u+LEtTCHvAw3XwbSINJZpfMjAsfiNeZtWI/NQ=;
 b=qZNV+kT5GUGC2RJk++vf+i7JDLO2zxS244I/hBz8k4nr0jPkplNRWn0ZYp3imkGY/1Whu6
 q53XNXKV7jyFEB+ZCjOc6cyDBfy6qjsxXubOJ/xBbO37DeMQl/+P4Fo95qPJL5B6RJQ0u6
 whWBEs+v2zv85YPYPqK0byj4YM7k1Ho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715114799;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7u6Z88u+LEtTCHvAw3XwbSINJZpfMjAsfiNeZtWI/NQ=;
 b=3ZPBn2nPIhiIrujlGLkWoGmMAu/Xo5PRNAMdbbUX3m9ePhlGZFDZ2SVYpB3FE1CF1Smgr/
 l3qeZUyu8QPf5DAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32C6613A2D;
 Tue,  7 May 2024 20:46:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hO2mOi6TOmYoOAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 07 May 2024 20:46:38 +0000
From: Fabiano Rosas <farosas@suse.de>
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Sebastian Ott
 <sebott@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, Fiona Ebner
 <f.ebner@proxmox.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Xu
 <peterx@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, peter.maydell@linaro.org, "Michael
 S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 0/4] Fix "virtio-gpu: fix scanout migration post-load"
In-Reply-To: <20240507111920.1594897-1-marcandre.lureau@redhat.com>
References: <20240507111920.1594897-1-marcandre.lureau@redhat.com>
Date: Tue, 07 May 2024 17:46:36 -0300
Message-ID: <87wmo5l58z.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B953134556
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_TWELVE(0.00)[14]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[linaro.org,redhat.com,habkost.net,proxmox.com,gmail.com,huawei.com];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; TAGGED_RCPT(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

marcandre.lureau@redhat.com writes:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Hi,
>
> The aforementioned patch breaks virtio-gpu device migrations for versions
> pre-9.0/9.0, both forwards and backwards. Versioning of `VMS_STRUCT` is m=
ore
> complex than it may initially appear, as evidenced in the problematic com=
mit
> dfcf74fa68c ("virtio-gpu: fix scanout migration post-load").
>
> To resolve this, we need to propagate the `vmstate` `version_id` through =
the
> nested structures. Additionally, we should tie specific machine version t=
o a
> corresponding `version_id` to maintain migration compatibility.
>
> `VMS_VSTRUCT` allows specifying the appropriate version of the nested str=
ucture
> to use.

This would have been caught by the migration-compat-x86_64 CI job had we
added the virtio-gpu device to it.

$ cd build-8.2
$ QTEST_TRACE=3D'vmstate_*' QTEST_DEVICE_OPTS=3D'-device virtio-gpu' \
QTEST_QEMU_BINARY=3D./qemu-system-x86_64 \
QTEST_QEMU_BINARY_DST=3D../build-9.0/qemu-system-x86_64 ./tests/qtest/migra=
tion-test
...
vmstate_n_elems fb.offset: 1
vmstate_subsection_load virtio-gpu-one-scanout
vmstate_subsection_load_good virtio-gpu-one-scanout
vmstate_load_state_end virtio-gpu-one-scanout end/0
vmstate_subsection_load virtio-gpu-scanouts
vmstate_subsection_load_good virtio-gpu-scanouts
vmstate_load_state_end virtio-gpu-scanouts end/0
vmstate_subsection_load virtio-gpu
vmstate_subsection_load_good virtio-gpu
vmstate_load_state_end virtio-gpu end/0
vmstate_downtime_load type=3Dnon-iterable idstr=3D0000:00:03.0/virtio-gpu i=
nstance_id=3D0 downtime=3D32118
qemu-system-x86_64: Missing section footer for 0000:00:03.0/virtio-gpu
vmstate_downtime_checkpoint dst-precopy-loadvm-completed
qemu-system-x86_64: load of migration failed: Invalid argument

Some considerations:

1) Here QTEST_DEVICE_OPTS is a hack I added on top, it doesn't currently
   exist.

2) This only uncovers relatively simple bugs where we don't need the
   guest to access the device, it just needs to be there.

We could take the steps to enable this kind of testing if we think it's
worthwhile. Some downsides are:

a) the item (2) above - situations that depend on guest behavior are out
   of the picture because migration-test runs only a custom program that
   dirties memory;

b) this test only works in CI or in a pre setup environment because it
   needs the previous QEMU version to be built beforehand;

c) the full set of migration tests already runs a few times in CI via
   make check, plus the compat job. We'll probably need to do some
   simplification to avoid taking too much additional time;

d) there's also the obvious maintenance burden of choosing devices and
   doing the eventual upkeep of the QEMU command line for the
   migration-test.

