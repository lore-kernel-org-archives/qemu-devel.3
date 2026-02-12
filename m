Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D9E7EDF04A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 06:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqQCQ-0008Ju-MR; Thu, 12 Feb 2026 01:29:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vqQCP-0008Dn-GF
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:29:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vqQCN-0005ZB-GU
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:29:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770877750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0LyQLFBXC3NiTdhUBvkxWCe7iko3J9mCNc8ANsHLRxU=;
 b=PXNaqtz31MgsWk6/9GKNEjTGQqHaqcH6n7gBNoFhtarUaOTKQTXUT5ELE0mdjo0GpcdFOp
 u0ceqdYyfdhEfWp0jWQ293hK448A5a5knD+ILCeApunGK1Ke8HC4QG5lcDF7nCQVucn3XM
 9F5xLOk41NOtMZC6i/r8/fBvDjQMrdc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-g8q5Zn49N7CwNP9GrduVfA-1; Thu, 12 Feb 2026 01:29:08 -0500
X-MC-Unique: g8q5Zn49N7CwNP9GrduVfA-1
X-Mimecast-MFC-AGG-ID: g8q5Zn49N7CwNP9GrduVfA_1770877748
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43771113b3bso1939980f8f.0
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 22:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770877747; x=1771482547; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0LyQLFBXC3NiTdhUBvkxWCe7iko3J9mCNc8ANsHLRxU=;
 b=cc865Icbr8IrQO7XhPRvSMA0KcYxHWsHlI1a1v97wL3DRDtSefI7G/uA6dkjBeNLML
 V75PGNvzekezf2ixPai+YusCAIRS4zv+XbvpGedNy8sBHILfSGOh8flqFjxnVRmKYUiX
 9pNMAtHVQLUDEvpPwAcnog5c2FmQLvcvxbvk+Z6LOfkF6EOWoDBDbhFB/nlPrBhaqGmC
 GTUsxiWbORC0edMTOsAwXp6c+lPGZCA3yjrypO+G7uTapfrfd7moeWdK691UQbUzPqmu
 5RnnS6EcKgGz+tNn/zPVodYlpleXHyxXTgxGS5mkYQV+5SiUHFHtVcp9k3FMcd5y3pqp
 x55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770877747; x=1771482547;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0LyQLFBXC3NiTdhUBvkxWCe7iko3J9mCNc8ANsHLRxU=;
 b=JhI9YTLncrgbRcmOXp5ZHG7ii4Ashgbd9I1UfMUVF7LG994grZ2BwDljwBh6WyQz10
 VNOanroj3NZo6RG26JGreJDfH3NW9gVd2n1njfY3oXkFPk8SJRqPfca1NgDLF0iQZ0xn
 gy8n+MJkZk+SPfk2zjTTB+Jjm5x9UGr4YwGAqSONYWWkGe+swXmXtW0iBWtYgVKaIr+x
 6Sr1iBrQ5NQACW6Dg2AbnFcuW6Srih28Ebo8+gCebO1BAvT9DML8uIxEgeQJV+K3lkwf
 LpGvXtYOqoYzMBbewcRWCkDo1oEv6caAb4Bd/7u5Cog5RYXYKDnBSh9seWS9yO1JdsHp
 3uug==
X-Gm-Message-State: AOJu0YzSJX6aGNvmkx4muUUDwtCMSeCA1n3A8labQKqxEXRS6iuZC7qX
 NDPihXV1ntW9BK0L75VRIOAQN5oqk/uj0PtO87LXWEIS3tFPe9BLWoFSYLAO03jzZVnSHzTD18l
 G5rOo8ksVy5WczwS+FqobGY8OtXGMgS1115iaAialvMEHFaz+t2zX8VBD
X-Gm-Gg: AZuq6aKZ7+VY3OQBWFK8ke1OEwcM9RyTFG2af7EXMtqYMkpR2tBLE07QSbiFZiyG+Xu
 wW8m42cuAlcSFC7W8M4jMEUvq/jDXGgzp46dQ88Zq24pQvO8BGzUzBYiD/Mf+s3LGzSh9VYKgc6
 Nioqvi1Y34VeZ20jcFaELinTp1s2ty8WAI/6RDQxk1/fUWFTxVlnR6KmLlqIZByRA4W+jl9+IEA
 mQXRRmbMjrVd6d3HnObPHP/rxsU9NwjTT2P4EUsRO1hWbK92K3bfJE0OcWXfxEPcd7ohoQA7EBv
 eN8xdPVBb/OwPqNwaXjo8lTbsVkgSjQOt5wpY3bwWPP9pcT91qGRVpB2x1Im1/K0DlT71duGgRe
 NL1XpoXSzGK8hqCz3o0rZvhMWL+Nj5GEuc+QYCCI37DDzjA==
X-Received: by 2002:adf:fd90:0:b0:436:8061:7f91 with SMTP id
 ffacd0b85a97d-4378f165dbamr1573101f8f.41.1770877747462; 
 Wed, 11 Feb 2026 22:29:07 -0800 (PST)
X-Received: by 2002:adf:fd90:0:b0:436:8061:7f91 with SMTP id
 ffacd0b85a97d-4378f165dbamr1573069f8f.41.1770877746961; 
 Wed, 11 Feb 2026 22:29:06 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4378e122df9sm2854900f8f.15.2026.02.11.22.29.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 22:29:06 -0800 (PST)
Date: Thu, 12 Feb 2026 01:29:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Joelle van Dyne <j@getutm.app>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PULL 41/51] virtio-gpu-virgl: correct parent for blob memory
 region
Message-ID: <20260212012653-mutt-send-email-mst@kernel.org>
References: <cover.1770231744.git.mst@redhat.com>
 <81cb15cf3774140da7c17341018a3852f920acb5.1770231744.git.mst@redhat.com>
 <4eb93d7a-1fa9-4b3c-8ad7-a2eb64f025a0@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4eb93d7a-1fa9-4b3c-8ad7-a2eb64f025a0@collabora.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Feb 11, 2026 at 11:46:51PM +0300, Dmitry Osipenko wrote:
> On 2/4/26 22:04, Michael S. Tsirkin wrote:
> > From: Joelle van Dyne <j@getutm.app>
> > 
> > When `owner` == `mr`, `object_unparent` will crash:
> > 
> > object_unparent(mr) ->
> > object_property_del_child(mr, mr) ->
> > object_finalize_child_property(mr, name, mr) ->
> > object_unref(mr) ->
> > object_finalize(mr) ->
> > object_property_del_all(mr) ->
> > object_finalize_child_property(mr, name, mr) ->
> > object_unref(mr) ->
> > fail on g_assert(obj->ref > 0)
> > 
> > However, passing a different `owner` to `memory_region_init` does not
> > work. `memory_region_ref` has an optimization where it takes a ref
> > only on the owner. That means when flatviews are created, it does not
> > take a ref on the region and you can get a UAF from `flatview_destroy`
> > called from RCU.
> > 
> > The correct fix therefore is to use `NULL` as the name which will set
> > the `owner` but not the `parent` (which is still NULL). This allows us
> > to use `memory_region_ref` on itself while not having to rely on unparent
> > for cleanup.
> > 
> > Signed-off-by: Joelle van Dyne <j@getutm.app>
> > Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Message-Id: <20260103214400.71694-1-j@getutm.app>
> > ---
> >  hw/display/virtio-gpu-virgl.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> > index 07f6355ad6..6a83fb63c8 100644
> > --- a/hw/display/virtio-gpu-virgl.c
> > +++ b/hw/display/virtio-gpu-virgl.c
> > @@ -120,7 +120,7 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
> >      vmr->g = g;
> >  
> >      mr = &vmr->mr;
> > -    memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
> > +    memory_region_init_ram_ptr(mr, OBJECT(mr), NULL, size, data);
> >      memory_region_add_subregion(&b->hostmem, offset, mr);
> >      memory_region_set_enabled(mr, true);
> >  
> > @@ -186,7 +186,7 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
> >          /* memory region owns self res->mr object and frees it by itself */
> >          memory_region_set_enabled(mr, false);
> >          memory_region_del_subregion(&b->hostmem, mr);
> > -        object_unparent(OBJECT(mr));
> > +        object_unref(OBJECT(mr));
> >      }
> >  
> >      return 0;
> 
> Hello Michael,
> 
> This patch introduces regression. Running any venus application results
> in a crash:
> 
> Thread 2 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
> (gdb) bt
> #0  0x00007ffff56565e2 in __strcmp_evex () at /lib64/libc.so.6
> #1  0x0000555555841bdb in find_fd (head=0x5555572337d0 <cpr_state>,
> name=0x0, id=0) at ../migration/cpr.c:68
> #2  cpr_delete_fd (name=name@entry=0x0, id=id@entry=0) at
> ../migration/cpr.c:77
> #3  0x000055555582290a in qemu_ram_free (block=0x7ff7e93aa7f0) at
> ../system/physmem.c:2615
> #4  0x000055555581ae02 in memory_region_finalize (obj=<optimized out>)
> at ../system/memory.c:1816
> #5  0x0000555555a70ab9 in object_deinit (obj=<optimized out>,
> type=<optimized out>) at ../qom/object.c:715
> #6  object_finalize (data=0x7ff7e936eff0) at ../qom/object.c:729
> #7  object_unref (objptr=0x7ff7e936eff0) at ../qom/object.c:1232
> #8  0x0000555555814fae in memory_region_unref (mr=<optimized out>) at
> ../system/memory.c:1848
> #9  flatview_destroy (view=0x555559ed6c40) at ../system/memory.c:301
> #10 0x0000555555bfc122 in call_rcu_thread (opaque=<optimized out>) at
> ../util/rcu.c:324
> #11 0x0000555555bf17a7 in qemu_thread_start (args=0x555557b99520) at
> ../util/qemu-thread-posix.c:393
> #12 0x00007ffff556f464 in start_thread () at /lib64/libc.so.6
> #13 0x00007ffff55f25ac in __clone3 () at /lib64/libc.so.6
> 
> There is a v2 version of this patch that doesn't crash [1]. Was v1
> applied by mistake instead of v2?
> 
> [1] https://lore.kernel.org/qemu-devel/20251223184023.1913-1-j@getutm.app/
> 
> -- 
> Best regards,
> Dmitry


According to my records, what was applied is v3:
https://lore.kernel.org/qemu-devel/20260103214400.71694-1-j@getutm.app/




-- 
MST


