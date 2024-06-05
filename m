Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6215C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 10:42:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEo5p-0007Jh-Sn; Wed, 05 Jun 2024 06:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEo5o-0007JZ-FZ
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 06:42:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEo5l-0006hr-RF
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 06:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717584124;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EuT5sHB+EkvlF19dHfHUxL/wW+znb+8HkOq3aor9qeg=;
 b=Bn7Z/Idc0X3Fy1+F13XTG3UArJnbNTcPwGH6tvKuond2WhCZ2u93mgxSdrqWnTdev8AuOD
 yvhX9csVsrkEbgukmagJrkBuVRpl4dJzKf8CmHthgGjzJse71bQOdJh1EnUg70If5D7WEU
 YVMx8w7Xz8Gg0AJcpbl68CSljK9i5L0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-mZL_SnkPOYaHAPfvFeOBcA-1; Wed, 05 Jun 2024 06:42:01 -0400
X-MC-Unique: mZL_SnkPOYaHAPfvFeOBcA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E824811E8E;
 Wed,  5 Jun 2024 10:42:00 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.183])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C04B940D1B66;
 Wed,  5 Jun 2024 10:41:58 +0000 (UTC)
Date: Wed, 5 Jun 2024 11:41:56 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 20/20] qga: centralize logic for disabling/enabling
 commands
Message-ID: <ZmBA9JfW8rTMu-OD@redhat.com>
References: <20240604134933.220112-1-berrange@redhat.com>
 <20240604134933.220112-21-berrange@redhat.com>
 <CAJ+F1CKE412ZvLJQRSfvO_gV1irUyQxP0xZ+Ejfuqf=QxeS+Tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CKE412ZvLJQRSfvO_gV1irUyQxP0xZ+Ejfuqf=QxeS+Tg@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jun 05, 2024 at 02:37:24PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Jun 4, 2024 at 5:51 PM Daniel P. Berrangé <berrange@redhat.com>
> wrote:
> 
> > It is confusing having many different pieces of code enabling and
> > disabling commands, and it is not clear that they all have the same
> > semantics, especially wrt prioritization of the block/allow lists.
> >
> > Centralizing the code in a single method "ga_apply_command_filters"
> > will provide a strong guarantee of consistency and clarify the
> > intended behaviour.
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> >
> 
> The clean up is very much welcome and looks correct, but it crashes:
> 
> Thread 1 "qemu-ga" received signal SIGSEGV, Segmentation fault.
> 0x000055555557db4f in ga_command_is_allowed (cmd=0x555555632800,
> state=0x555555633710) at ../qga/main.c:430
> 430    if (config->allowedrpcs) {
> (gdb) bt
> #0  0x000055555557db4f in ga_command_is_allowed (cmd=0x555555632800,
> state=0x555555633710) at ../qga/main.c:430
> #1  ga_apply_command_filters_iter (cmd=0x555555632800,
> opaque=0x555555633710) at ../qga/main.c:473
> #2  0x000055555559ef81 in qmp_for_each_command (cmds=cmds@entry=0x55555562c2b0
> <ga_commands>, fn=fn@entry=0x55555557db30 <ga_apply_command_filters_iter>,
> opaque=opaque@entry=0x555555633710)
>     at ../qapi/qmp-registry.c:93
> #3  0x0000555555571436 in ga_apply_command_filters (state=0x555555633710)
> at ../qga/main.c:492
> #4  initialize_agent (config=0x555555632760, socket_activation=0) at
> ../qga/main.c:1452
> #5  main (argc=<optimized out>, argv=<optimized out>) at ../qga/main.c:1646
> (gdb) p state.config
> $1 = (GAConfig *) 0x0
> 
> (meson test fails too)
> 
> I wonder why s->config is set so late in initialize_agent(). Moving it
> earlier seems to solve the issue, but reviewing all code paths is tedious..

The ga_apply_command_filters() call can just be moved later,
since the only constraint is that is called /before/ we call
g_main_loop_run() to start processing I/O


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


