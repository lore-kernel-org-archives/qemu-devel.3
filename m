Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C316FFF885A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 08:24:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKB54-0001nA-5I; Tue, 05 May 2026 04:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wKB52-0001mi-OL
 for qemu-devel@nongnu.org; Tue, 05 May 2026 04:24:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wKB51-0002br-BH
 for qemu-devel@nongnu.org; Tue, 05 May 2026 04:24:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777969474;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q9a0IgIqfyrl5TqjQKXNV2x3EcuQV/eY3d1Uz0VfdbY=;
 b=TZZGrBu+l/txv87y095edT0c/ajeHtKLoL11/uTThl1B/hlYvDU9szM7lZJ955VdIRyNyP
 JJCkBuDmFM+ehIJ1fg/IMsJbhQ4AWSXZ064+G0kvmk+EIA9SNb6hwzaQoTB44J1oaoKII2
 pW4TUS6hWosc5QDfAJUuybCR0hoAquY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-108-QJn5PLU1NiqePyW8bxe_eg-1; Tue,
 05 May 2026 04:24:33 -0400
X-MC-Unique: QJn5PLU1NiqePyW8bxe_eg-1
X-Mimecast-MFC-AGG-ID: QJn5PLU1NiqePyW8bxe_eg_1777969472
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5674719560B4
 for <qemu-devel@nongnu.org>; Tue,  5 May 2026 08:24:32 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.201])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 174FA1944CED; Tue,  5 May 2026 08:24:30 +0000 (UTC)
Date: Tue, 5 May 2026 09:24:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] ui/input: do not assert() when tracing invalid input
Message-ID: <afmpOzTnTWwoDSqC@redhat.com>
References: <20260503070939.2730826-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260503070939.2730826-1-marcandre.lureau@redhat.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sun, May 03, 2026 at 11:09:39AM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> It's possible to reach an assert() in the input tracing code by sending
> some out of range input values via D-Bus for ex:
> 
>   #0  0x00007fec8652186c in __pthread_kill_implementation () at /lib64/libc.so.6
>   #1  0x00007fec864c648e in raise () at /lib64/libc.so.6
>   #2  0x00007fec864ad7b3 in abort () at /lib64/libc.so.6
>   #3  0x00007fec864ae804 in __libc_message_impl.cold () at /lib64/libc.so.6
>   #4  0x00007fec864be345 in __assert_fail () at /lib64/libc.so.6
>   #5  0x00005597964c551e in qapi_enum_lookup[cold] ()
>   #6  0x000055979650514a in qemu_input_event_send_impl ()
>   #7  0x0000559796505a4d in qemu_input_queue_btn ()
>   #8  0x00007fec85780c19 in dbus_mouse_press () at /usr/bin/../lib64/qemu/ui-dbus.so
>   #9  0x00007fec857912fc in _g_dbus_codegen_marshal_BOOLEAN__OBJECT_UINT.part.0 () at /usr/bin/../lib64/qemu/ui-dbus.so
>   #10 0x00007fec874cce7c in g_closure_invoke () at /lib64/libgobject-2.0.so.0
>   #11 0x00007fec874eb849 in signal_emit_unlocked_R.isra.0 () at /lib64/libgobject-2.0.so.0
>   #12 0x00007fec874ec66f in g_signal_emitv () at /lib64/libgobject-2.0.so.0
>   #13 0x00007fec85797e0a in _qemu_dbus_display1_mouse_skeleton_handle_method_call () at /usr/bin/../lib64/qemu/ui-dbus.so
> 
> Other paths in input code accept out-of-range values
> (qemu_input_key_value_to_number etc). Let it pass tracing.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  ui/input.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

Daniel


