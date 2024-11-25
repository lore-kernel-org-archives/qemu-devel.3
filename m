Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8963BD58D7A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 18:28:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFdp6-0000r9-S4; Mon, 25 Nov 2024 13:28:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tFdp5-0000qZ-BY
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 13:28:35 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tFdp3-0007j9-UV
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 13:28:35 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C21981F453;
 Mon, 25 Nov 2024 18:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732559312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gb4H6xyTReEsQRTF/EIoNsTKqq05yVybKdaGIyvt1dU=;
 b=2InsYfe67eAbw/Wj9vuOVQH4bFyHPv/glGGXRHt8tf1LbnGTsjcl1FsjUf79V3HzbWmiJM
 dHORyIGXbWZxkZI8IqxeRIBVmE60kwmWf1Bxc89KgblpPNnu91JjHuEjsQbVDCJuZ0UGTb
 OQCFuLko597nITPMllaIORczOPqIbhM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732559312;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gb4H6xyTReEsQRTF/EIoNsTKqq05yVybKdaGIyvt1dU=;
 b=7tbwLvGwZ3vvmKWjIS0611Bs6zTMuriJ0DozatT1itjg34qlJSQny09rbSe7J7HIQ1Pl3Q
 IpuTdC/PHQOAgcBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732559310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gb4H6xyTReEsQRTF/EIoNsTKqq05yVybKdaGIyvt1dU=;
 b=YqMMdXi8ppmw+ncYqXjHGeBDmeyZULuSWucXlqWFKjQtx0iClwYOeXweFHh3Pww6G3xa3t
 tz9MoD0AlcfUgFbWLIOmhaIBfi+12ObijSkZ9RpHq7JGD1UQwtn43hzAcnHrxMIwXrRMq/
 BP00BkSInxZrAjWbTlZWFyl9L/r5+eo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732559310;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gb4H6xyTReEsQRTF/EIoNsTKqq05yVybKdaGIyvt1dU=;
 b=svHHujK0kYES8oySq+XpnuikqipOlXviPPiytgqVdhc5ifSL47ZfWeehmk6gF9mUFz4X75
 ZnAdohloqYeo8kDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4068E137D4;
 Mon, 25 Nov 2024 18:28:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 36P6Ac7BRGexGAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 25 Nov 2024 18:28:30 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Yichen Wang <yichen.wang@bytedance.com>, Peter Xu <peterx@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 Shivam Kumar <shivam.kumar1@nutanix.com>, "Ho-Ren (Jack) Chuang"
 <horenchuang@bytedance.com>, Yichen Wang <yichen.wang@bytedance.com>
Subject: Re: [PATCH v7 12/12] migration/doc: Add DSA zero page detection doc
In-Reply-To: <20241114220132.27399-13-yichen.wang@bytedance.com>
References: <20241114220132.27399-1-yichen.wang@bytedance.com>
 <20241114220132.27399-13-yichen.wang@bytedance.com>
Date: Mon, 25 Nov 2024 15:28:27 -0300
Message-ID: <87wmgrnp6c.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-3.64 / 50.00]; BAYES_HAM(-2.34)[96.95%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[17]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,
 imap1.dmz-prg2.suse.org:helo, intel.com:email, suse.de:mid, suse.de:email]
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

Yichen Wang <yichen.wang@bytedance.com> writes:

> From: Yuan Liu <yuan1.liu@intel.com>
>
> Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

