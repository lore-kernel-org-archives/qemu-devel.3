Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD52C5516F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 16:02:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wppgV-0000u1-M6; Fri, 31 Jul 2026 12:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wppgJ-0000lu-P0
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 12:01:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wppgH-0006Ri-V3
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 12:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785513712;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FGkWlbTWtZ0Hn8esKAJiEJXn6oLQnKSNG8oYeQHENOY=;
 b=hUZZz/+Rg8ahIICeOq8LjCBwWV9kKswOOXi0rBtbpErRXvuOuZx2sqouVVDzEPcKJ48j8+
 Hy/GTjgG3ril1zhSo0/SBrLO6aATE4Ad+jdtdS7GwOdsS571l0ACovmg00U5Bmava2ZuBr
 Q1nQBLsmnLyLoten3s2+F2RhuFYwRyE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-438-tUU6RB2-MKuAPQO6ONFVpQ-1; Fri,
 31 Jul 2026 12:01:49 -0400
X-MC-Unique: tUU6RB2-MKuAPQO6ONFVpQ-1
X-Mimecast-MFC-AGG-ID: tUU6RB2-MKuAPQO6ONFVpQ_1785513709
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CDC0619560AE; Fri, 31 Jul 2026 16:01:48 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 12753414; Fri, 31 Jul 2026 16:01:46 +0000 (UTC)
Date: Fri, 31 Jul 2026 17:01:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 1/1] qapi/dump: add allowed-by-guest feature to win-dmp
Message-ID: <amzG3o0CDurT3a2E@redhat.com>
References: <20260731155001.1204103-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260731155001.1204103-1-den@openvz.org>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jul 31, 2026 at 05:50:01PM +0200, Denis V. Lunev wrote:
> Commit 1c0e259c5a35 ("dump: make win_dump_available() check vmcoreinfo
> for a Windows dump header") changed two things in a way that is visible
> to QMP clients but not to introspection:
> query-dump-guest-memory-capability now lists win-dmp only for a guest
> that has published a Windows dump header through the vmcoreinfo device,
> and dump-guest-memory, which shares win_dump_available(), rejects the
> format otherwise. Before that, both accepted win-dmp on any x86
> machine.

IIUC, the old behaviour of 'dump-guest-memory' would always return
an error if invoked with win-dmp on Linux guests, as the first
lines of create_win_dump used to be:

    if (s->guest_note_size != VMCOREINFO_WIN_DUMP_NOTE_SIZE32 &&
            s->guest_note_size != VMCOREINFO_WIN_DUMP_NOTE_SIZE64) {
        error_setg(errp, "win-dump: invalid vmcoreinfo note size");
        return;
    }

At most we've change the error message that is seen by the client
AFAICT.

IOW from a client facing view, what changed in 11.1.0 is simply that
'query-dump-guest-memory-capability' now accurately reflects what can
be used by 'dump-guest-memory'.


> A client that wants to select win-dmp automatically therefore cannot
> trust the capability query on its own: on an older QEMU it reports
> win-dmp for every x86 guest, Linux ones included, where the resulting
> dump is useless. libvirt ran into exactly this while picking a format
> for on_crash and watchdog triggered dumps, and has no way to tell the
> two behaviours apart.
> 
> Add an 'allowed-by-guest' feature to the win-dmp member of
> DumpGuestMemoryFormat so the fixed behaviour becomes discoverable.
> DumpGuestMemoryFormat is reachable from both
> query-dump-guest-memory-capability's return type and
> dump-guest-memory's arguments, so a single flag covers both halves of
> the change. Where the feature is absent, a reported win-dmp says
> nothing about the guest, and a client that needs the dump to be
> loadable afterwards should fall back to elf.
> 
> CC: Eric Blake <eblake@redhat.com>
> CC: Markus Armbruster <armbru@redhat.com>
> CC: "Marc-André Lureau" <marcandre.lureau@redhat.com>
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
> libvirt discussion:
> https://lists.libvirt.org/archives/list/devel@lists.libvirt.org/thread/7QBRM2GOC7M5E7EAIE44JNWBSKNN62BC/
> 
>  qapi/dump.json | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/qapi/dump.json b/qapi/dump.json
> index 726b520870..690f3963fe 100644
> --- a/qapi/dump.json
> +++ b/qapi/dump.json
> @@ -38,6 +38,13 @@
>  # @win-dmp: Windows full crashdump format, can be used instead of ELF
>  #     converting (since 2.13)
>  #
> +# Features:
> +#
> +# @allowed-by-guest: If present, @win-dmp is listed by
> +#     `query-dump-guest-memory-capability`, and accepted by
> +#     `dump-guest-memory`, only when the guest has published a Windows
> +#     dump header through the vmcoreinfo device (since 11.1)
> +#
>  # Since: 2.0
>  ##
>  { 'enum': 'DumpGuestMemoryFormat',
> @@ -45,7 +52,7 @@
>        'elf',
>        'kdump-zlib', 'kdump-lzo', 'kdump-snappy',
>        'kdump-raw-zlib', 'kdump-raw-lzo', 'kdump-raw-snappy',
> -      'win-dmp' ] }
> +      { 'name': 'win-dmp', 'features': ['allowed-by-guest'] } ] }
>  
>  ##
>  # @dump-guest-memory:

Regardless of quibble over the commit message

  Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


