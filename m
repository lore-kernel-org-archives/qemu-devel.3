Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920E7C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 12:48:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE77F-0000RC-KJ; Mon, 03 Jun 2024 08:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sE77D-0000PZ-NX
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:48:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sE77B-0000Wr-A1
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717418920;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=udiz+maueuZh93QxOQWMVMeYgSaJMk3GLVwFtlDbH30=;
 b=Qjj6dGDiJGQI7pC5QjeH6hxrpGPKqViz5bFBuzQ+PM+XUnhVuyXndDtkEX/B7/RBhn8Qey
 UXNLGYqcLkcEZndjeKj1xK24UKGo3bah2Ewx6jUC9ECNrbCsNW48yZxMPh9I4YzNyURq4L
 vKiSSBBleBEhxweOymfhZ+y9bX2sVFM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-391-P8kGMruyOT2aEMbCtHNgwg-1; Mon,
 03 Jun 2024 08:48:37 -0400
X-MC-Unique: P8kGMruyOT2aEMbCtHNgwg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 83F4F1C05129;
 Mon,  3 Jun 2024 12:48:37 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9DF7B4087040;
 Mon,  3 Jun 2024 12:48:36 +0000 (UTC)
Date: Mon, 3 Jun 2024 13:48:34 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH] io/channel-socket: Fix -fsanitize=undefined problem with
 latest Clang
Message-ID: <Zl27orDnp8hOqgKo@redhat.com>
References: <20240529133106.1224866-1-thuth@redhat.com>
 <CAFEAcA8yOgGS8VdFRmJJKaUZe9Q=jDDh7itK6Q7vUH4TtEbFnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8yOgGS8VdFRmJJKaUZe9Q=jDDh7itK6Q7vUH4TtEbFnw@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

On Wed, May 29, 2024 at 02:53:37PM +0100, Peter Maydell wrote:
> On Wed, 29 May 2024 at 14:32, Thomas Huth <thuth@redhat.com> wrote:
> >
> > Casting function pointers from one type to another causes undefined
> > behavior errors when compiling with -fsanitize=undefined with Clang v18:
> >
> >  $ QTEST_QEMU_BINARY=./qemu-system-mips64 tests/qtest/netdev-socket
> >  TAP version 13
> >  # random seed: R02S4424f4f460de783fdd3d72c5571d3adc
> >  1..10
> >  # Start of mips64 tests
> >  # Start of netdev tests
> >  # Start of stream tests
> >  # starting QEMU: exec ./qemu-system-mips64 -qtest unix:/tmp/qtest-1213196.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-1213196.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -nodefaults -M none -netdev stream,id=st0,addr.type=fd,addr.str=3 -accel qtest
> >  ../io/task.c:78:13: runtime error: call to function qapi_free_SocketAddress through pointer to incorrect function type 'void (*)(void *)'
> >  /tmp/qemu-sanitize/qapi/qapi-types-sockets.c:170: note: qapi_free_SocketAddress defined here
> >  SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../io/task.c:78:13
> 
> It's a pity the sanitizer error doesn't tell you the actual
> function type as well as the incorrect one it got cast to
> (especially since in this case the function and its declaration
> are both in generated code in the build tree not conveniently
> findable with 'git grep'.)
> 
> In this case the function being called is:
>  void qapi_free_SocketAddress(SocketAddress *obj)
> and it's cast to a GDestroyNotify, which is
>  typedef void            (*GDestroyNotify)       (gpointer       data);
> (and gpointer is void*)
> 
> and although you can pass a foo* to a function expecting void*,
> you can't treat a pointer to a function taking foo* as if it was
> a pointer to a function taking void*, just in case the compiler
> needs to do some clever trickery with the pointer value.
>
> So the wrapper function looks like it doesn't do anything,
> but it's doing the permitted implicit-cast of the argument


I guess that's the letter of the law in C, but does that actually
matter in practice, historically ?

The use of "(GDestroyNotify)blah"  casts is standard practice
across any application using GLib, and even in QEMU this is
far from the only place that does such a cast:

$ git grep '(GDestroyNotify)'
chardev/char-socket.c:                                   (GDestroyNotify)object_unref);
hw/i386/kvm/xen_xenstore.c:    g_list_free_full(w->events, (GDestroyNotify)free_watch_event);
hw/i386/kvm/xenstore_impl.c:                                            (GDestroyNotify)xs_node_unref);
hw/i386/kvm/xenstore_impl.c:                                            (GDestroyNotify)xs_node_unref);
hw/i386/kvm/xenstore_impl.c:                                            (GDestroyNotify)xs_node_unref);
hw/mem/sparse-mem.c:                                      (GDestroyNotify)g_free);
hw/misc/xlnx-versal-cframe-reg.c:                                  NULL, (GDestroyNotify)g_free);
hw/virtio/virtio-iommu.c:                                   NULL, (GDestroyNotify)g_free,
hw/virtio/virtio-iommu.c:                                   (GDestroyNotify)g_free);
io/channel-socket.c:                           (GDestroyNotify)qapi_free_SocketAddress,
io/net-listener.c:            listener, (GDestroyNotify)object_unref, NULL);
io/net-listener.c:                listener, (GDestroyNotify)object_unref, context);
io/net-listener.c:                listener, (GDestroyNotify)object_unref, NULL);
migration/block-dirty-bitmap.c:        gdn = (GDestroyNotify) qapi_free_BitmapMigrationBitmapAlias;
subprojects/libvhost-user/libvhost-user-glib.c:                                       (GDestroyNotify) vug_source_destroy);
system/memory.c:                                       (GDestroyNotify) flatview_unref);
tests/qtest/libqos/qgraph.c:    g_test_queue_destroy((GDestroyNotify) qos_object_destroy, obj);
tests/unit/test-vmstate.c:                                        (GDestroyNotify)g_free,
tests/unit/test-vmstate.c:                                        (GDestroyNotify)g_free);
tests/unit/test-vmstate.c:                                              (GDestroyNotify)g_free,
tests/unit/test-vmstate.c:                                              (GDestroyNotify)g_free);
ui/dbus-clipboard.c:        (GDestroyNotify)qemu_clipboard_info_unref,
ui/dbus-listener.c:        (GDestroyNotify)qemu_free_displaysurface,
ui/dbus-listener.c:        (GDestroyNotify)pixman_image_unref,
ui/dbus-listener.c:        (GDestroyNotify)pixman_image_unref, pixman_image_ref(ddl->ds->image));
ui/dbus-listener.c:        (GDestroyNotify)cursor_unref,
ui/dbus.c:        (GDestroyNotify)g_array_unref, consoles);

I presume this means the rest of the code merely isn't exercised by the
CI job test case this is fixing, but if we're saying this needs fixing,
then we should be fixing all usage.

Then there are many other function casts beyond GDestroyNotify that
we use, which feel like they should have similar conceptual problems:

$ git grep -E '\(\w+Func\)\w+' '*.c' | grep -v -E '(void|int|double|float|HANDLE)'
chardev/char-fd.c:    FEWatchFunc func = (FEWatchFunc)callback;
chardev/char-fd.c:        g_source_set_callback(child, (GSourceFunc)child_func, source, NULL);
chardev/char-fd.c:        g_source_set_callback(child, (GSourceFunc)child_func, source, NULL);
chardev/char-fe.c:    g_source_set_callback(src, (GSourceFunc)func, user_data, NULL);
chardev/char-socket.c:    g_source_set_callback(s->hup_source, (GSourceFunc)tcp_chr_hup,
chardev/spice.c:    GIOFunc func = (GIOFunc)callback;
hw/i386/kvm/xenstore_impl.c:    *items = g_list_insert_sorted(*items, g_strdup(key), (GCompareFunc)strcmp);
io/channel-buffer.c:    QIOChannelFunc func = (QIOChannelFunc)callback;
io/channel-null.c:    QIOChannelFunc func = (QIOChannelFunc)callback;
io/channel-watch.c:    QIOChannelFunc func = (QIOChannelFunc)callback;
io/channel-watch.c:    QIOChannelFunc func = (QIOChannelFunc)callback;
io/channel-watch.c:    QIOChannelFunc func = (QIOChannelFunc)callback;
io/channel-websock.c:    QIOChannelFunc func = (QIOChannelFunc)callback;
io/channel.c:    g_source_set_callback(source, (GSourceFunc)func, user_data, notify);
io/channel.c:                          (GSourceFunc)qio_channel_wait_complete,
io/net-listener.c:                              (GSourceFunc)qio_net_listener_wait_client_func,
migration/migration.c:    notify->notify = (NotifierWithReturnFunc)func;
migration/rdma.c:    QIOChannelFunc func = (QIOChannelFunc)callback;
net/colo-compare.c:                                  (GCompareDataFunc)seq_sorter,
net/colo-compare.c:                                (GCompareFunc)colo_old_packet_check_one))
net/colo-compare.c:                                (GCompareFunc)colo_old_packet_check_one))
net/colo-compare.c:                        (GCompareFunc)colo_old_packet_check_one_conn);
net/colo-compare.c:                 pkt, (GCompareFunc)HandlePacket);
net/net.c:    g_ptr_array_sort(results, (GCompareFunc)model_cmp);
qga/commands-win32.c:        getifentry2_ex = (GetIfEntry2Func)func;
qga/vss-win32.c:    func = (QGAVSSRequesterFunc)GetProcAddress(provider_lib, func_name);
subprojects/libvhost-user/libvhost-user-glib.c:    g_source_set_callback(gsrc, (GSourceFunc)vu_cb, data, NULL);
system/qdev-monitor.c:    g_ptr_array_sort(array, (GCompareFunc)qemu_pstrcmp0);
target/i386/cpu.c:    names = g_list_sort(names, (GCompareFunc)strcmp);
tests/unit/test-qtree.c:    tree = q_tree_new_full((GCompareDataFunc)my_compare, NULL,
tests/unit/test-util-filemonitor.c:                   (GFunc)qemu_file_monitor_test_record_free, NULL);
util/filemonitor-inotify.c:    g_idle_add((GSourceFunc)qemu_file_monitor_free_idle, mon);
util/qemu-option.c:    g_ptr_array_sort(array, (GCompareFunc)qemu_pstrcmp0);


So overall, I'm not in favour of this patch unless there's a compelling
functional reason why just this 1 case is special and all the others
can be safely ignored.

> 
> > Add a wrapper function to avoid the problem.
> >
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >  io/channel-socket.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/io/channel-socket.c b/io/channel-socket.c
> > index 3a899b0608..aa2a1c8586 100644
> > --- a/io/channel-socket.c
> > +++ b/io/channel-socket.c
> > @@ -193,6 +193,10 @@ static void qio_channel_socket_connect_worker(QIOTask *task,
> >      qio_task_set_error(task, err);
> >  }
> >
> > +static void qio_qapi_free_SocketAddress(gpointer sa)
> > +{
> > +    qapi_free_SocketAddress(sa);
> > +}
> >
> >  void qio_channel_socket_connect_async(QIOChannelSocket *ioc,
> >                                        SocketAddress *addr,
> > @@ -213,7 +217,7 @@ void qio_channel_socket_connect_async(QIOChannelSocket *ioc,
> >      qio_task_run_in_thread(task,
> >                             qio_channel_socket_connect_worker,
> >                             addrCopy,
> > -                           (GDestroyNotify)qapi_free_SocketAddress,
> > +                           qio_qapi_free_SocketAddress,
> >                             context);
> >  }
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> thanks
> -- PMM
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


