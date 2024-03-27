Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 557A4C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 14:34:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpUKx-0001QI-04; Wed, 27 Mar 2024 10:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1rpUKq-0001Pe-4l; Wed, 27 Mar 2024 10:33:00 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1rpUKo-0003lw-LN; Wed, 27 Mar 2024 10:32:59 -0400
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D739320B7F;
 Wed, 27 Mar 2024 14:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1711549974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eycjIFYZOc7LJ+ADfj3NFLAtK8Q+arFIRRxuwxVlUO8=;
 b=x1g2JYKKMfZEHjZ5KiM9qvIgR/cLQZGaYDYgKY3BF03L8irWDMqJTg5/GhozLMEfPfDiLf
 VvqRtDPnFadrjD+swJWQUqR937c9isE0pqj872sYa67echmaeEUDswpSeu6Ee2CEDz1jrm
 IldwiuyL7chqHakUKw+J9tbaxYUMzKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1711549974;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eycjIFYZOc7LJ+ADfj3NFLAtK8Q+arFIRRxuwxVlUO8=;
 b=YJNXesqyb6CpdAqFJXzSiEvjeVBjZiG/YDaYhVXrJclDgKpwXBETKEpnv6FQc9lTJsatF/
 OXJQb7Rm2+ScruCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1711549973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eycjIFYZOc7LJ+ADfj3NFLAtK8Q+arFIRRxuwxVlUO8=;
 b=YTf/rIQgxuMdNfnqvpfdiXYziZyAzwwVkXA0WcLz2o+W1sSa1X1tE8nblw9QCTZHT22GHm
 jneDI164JAFaSJSH6Cu0M7KTQfDkHcbfl28TbKd1xdFwx4r3JNBHyEvMxXVkJBWmqn8j7Z
 fj0etuwTY2iMtxmzVk2ipoQLPz5AI6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1711549973;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eycjIFYZOc7LJ+ADfj3NFLAtK8Q+arFIRRxuwxVlUO8=;
 b=Vt/VxZb0DyO/4eD0VNr5aHkXvIPvQYESy5TOtta4pBqggZvb3JuNeTIpEFGvZy4t36ZXvk
 kKjGcngN092FdjDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2829613AB3;
 Wed, 27 Mar 2024 14:32:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id cezDCRUuBGZcWQAAn2gu4w
 (envelope-from <farosas@suse.de>); Wed, 27 Mar 2024 14:32:53 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 integration@gluster.org, Peter Xu <peterx@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 devel@lists.libvirt.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Kevin
 Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Song Gao
 <gaosong@loongson.cn>, Eduardo Habkost <eduardo@habkost.net>, Yanan Wang
 <wangyanan55@huawei.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Eric Blake <eblake@redhat.com>, Michael Roth <michael.roth@amd.com>, Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Wainer dos Santos
 Moschetta
 <wainersm@redhat.com>, Beraldo Leal <bleal@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH-for-9.1] rdma: Remove RDMA subsystem and pvrdma device
In-Reply-To: <20240327105549.1824-1-philmd@linaro.org>
References: <20240327105549.1824-1-philmd@linaro.org>
Date: Wed, 27 Mar 2024 11:32:50 -0300
Message-ID: <87jzlnpwx9.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Bar: +++
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="YTf/rIQg";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="Vt/VxZb0"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.36 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 BAYES_SPAM(4.37)[98.10%];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 TO_DN_SOME(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLwsahdo31p3kfqkbhx43amd6o)];
 RCVD_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+];
 MX_GOOD(-0.01)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWELVE(0.00)[29];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,linaro.org:email];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 FREEMAIL_CC(0.00)[redhat.com,gmail.com,nongnu.org,treblig.org,gluster.org,fujitsu.com,lists.libvirt.org,linaro.org,loongson.cn,habkost.net,huawei.com,amd.com];
 RCVD_TLS_ALL(0.00)[]; SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Queue-Id: D739320B7F
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> The whole RDMA subsystem was deprecated in commit e9a54265f5
> ("hw/rdma: Deprecate the pvrdma device and the rdma subsystem")
> released in v8.2. Time to remove it.
>
> Keep the RAM_SAVE_FLAG_HOOK definition since it might appears
> in old migration streams.
>
> Remove the dependencies on libibumad and libibverbs.
>
> Remove the generated vmw_pvrdma/ directory from linux-headers.
>
> Remove RDMA handling from migration.
>
> Remove RDMA handling in GlusterFS block driver.
>
> Remove rdmacm-mux tool from contrib/.
>
> Remove PVRDMA device.
>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Li Zhijian <lizhijian@fujitsu.com>
> Cc: Yuval Shaia <yuval.shaia.ml@gmail.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Acked-by: Fabiano Rosas <farosas@suse.de>

