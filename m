Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B22C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 15:29:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sg4J2-00089v-Ae; Mon, 19 Aug 2024 11:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sg4J0-00089Q-VC
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 11:28:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sg4Iz-0001xf-1m
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 11:28:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724081301;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2D2w78FByXS8B/v0lLhdTugGDesGul+7rkonKK8Q5GM=;
 b=NOJ92RzFiMIGt/2fayMTZFdB0JoBiUaehFQq4CofmM26d/TMa7AVjSRSL+yta9OfsnMi2o
 O9k8vXT49FcytllTBi7PQGg97tkny3PevQ54c9bZqXRGSOd8Uuy8y4l8t+PEm7UiNJm4F1
 1wZxCZEqZInHatPv/PbSEY6gZUnVczM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-F2DXHeyzOPuIxfDNbidBJQ-1; Mon,
 19 Aug 2024 11:28:19 -0400
X-MC-Unique: F2DXHeyzOPuIxfDNbidBJQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 71E1D1955D44; Mon, 19 Aug 2024 15:28:18 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.145])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1525519773DB; Mon, 19 Aug 2024 15:28:16 +0000 (UTC)
Date: Mon, 19 Aug 2024 16:28:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] crypto/tlscredspsk: Free username on finalize
Message-ID: <ZsNkjRQRBx8nhbw8@redhat.com>
References: <20240819145021.38524-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240819145021.38524-1-peter.maydell@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.134,
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

On Mon, Aug 19, 2024 at 03:50:21PM +0100, Peter Maydell wrote:
> When the creds->username property is set we allocate memory
> for it in qcrypto_tls_creds_psk_prop_set_username(), but
> we never free this when the QCryptoTLSCredsPSK is destroyed.
> Free the memory in finalize.
> 
> This fixes a LeakSanitizer complaint in migration-test:
> 
> $ (cd build/asan; ASAN_OPTIONS="fast_unwind_on_malloc=0" QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/migration-test --tap -k -p /x86_64/migration/precopy/unix/tls/psk)
> 
> =================================================================
> ==3867512==ERROR: LeakSanitizer: detected memory leaks
> 
> Direct leak of 5 byte(s) in 1 object(s) allocated from:
>     #0 0x5624e5c99dee in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/qemu-system-x86_64+0x218edee) (BuildId: a9e623fa1009a9435c0142c037cd7b8c1ad04ce3)
>     #1 0x7fb199ae9738 in g_malloc debian/build/deb/../../../glib/gmem.c:128:13
>     #2 0x7fb199afe583 in g_strdup debian/build/deb/../../../glib/gstrfuncs.c:361:17
>     #3 0x5624e82ea919 in qcrypto_tls_creds_psk_prop_set_username /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/../../crypto/tlscredspsk.c:255:23
>     #4 0x5624e812c6b5 in property_set_str /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/../../qom/object.c:2277:5
>     #5 0x5624e8125ce5 in object_property_set /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/../../qom/object.c:1463:5
>     #6 0x5624e8136e7c in object_set_properties_from_qdict /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/../../qom/object_interfaces.c:55:14
>     #7 0x5624e81372d2 in user_creatable_add_type /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/../../qom/object_interfaces.c:112:5
>     #8 0x5624e8137964 in user_creatable_add_qapi /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/../../qom/object_interfaces.c:157:11
>     #9 0x5624e891ba3c in qmp_object_add /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/../../qom/qom-qmp-cmds.c:227:5
>     #10 0x5624e8af9118 in qmp_marshal_object_add /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/qapi/qapi-commands-qom.c:337:5
>     #11 0x5624e8bd1d49 in do_qmp_dispatch_bh /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/../../qapi/qmp-dispatch.c:128:5
>     #12 0x5624e8cb2531 in aio_bh_call /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/../../util/async.c:171:5
>     #13 0x5624e8cb340c in aio_bh_poll /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/../../util/async.c:218:13
>     #14 0x5624e8c0be98 in aio_dispatch /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/../../util/aio-posix.c:423:5
>     #15 0x5624e8cba3ce in aio_ctx_dispatch /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/../../util/async.c:360:5
>     #16 0x7fb199ae0d3a in g_main_dispatch debian/build/deb/../../../glib/gmain.c:3419:28
>     #17 0x7fb199ae0d3a in g_main_context_dispatch debian/build/deb/../../../glib/gmain.c:4137:7
>     #18 0x5624e8cbe1d9 in glib_pollfds_poll /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/../../util/main-loop.c:287:9
>     #19 0x5624e8cbcb13 in os_host_main_loop_wait /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/../../util/main-loop.c:310:5
>     #20 0x5624e8cbc6dc in main_loop_wait /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/../../util/main-loop.c:589:11
>     #21 0x5624e6f3f917 in qemu_main_loop /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/../../system/runstate.c:801:9
>     #22 0x5624e893379c in qemu_default_main /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/../../system/main.c:37:14
>     #23 0x5624e89337e7 in main /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/../../system/main.c:48:12
>     #24 0x7fb197972d8f in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16
>     #25 0x7fb197972e3f in __libc_start_main csu/../csu/libc-start.c:392:3
>     #26 0x5624e5c16fa4 in _start (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/qemu-system-x86_64+0x210bfa4) (BuildId: a9e623fa1009a9435c0142c037cd7b8c1ad04ce3)
> 
> SUMMARY: AddressSanitizer: 5 byte(s) leaked in 1 allocation(s).
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Found this playing around with the address-sanitizer and running
> "make check".  I guess this is stable material but maybe not
> important enough to go into 9.1 at this point in the cycle, since the
> bug has been present since the code was first written in 2018.

The memory leak is low impact since credentials either live for the
entire of the QEMU lifetime, or sometimes are created & deleted on
the fly for infrequent operations like live migrate.

> 
>  crypto/tlscredspsk.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


