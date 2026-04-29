Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA04FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 20:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIBzT-0002OC-Ay; Wed, 29 Apr 2026 16:58:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wIBzQ-0002Nx-Af
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 16:58:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wIBzO-0002A5-Ac
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 16:58:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777496312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=umX7UCeSkkaG6aO+7tOzFGLyJ5B5mxsVAIzWXtb8y4k=;
 b=a+iaJdgF3RRIDdxZS7LroOfvgsZn6tZWRe6m7RUNW3miibcUdSoAORY0WFdiz8PdLvfdyk
 pB7A/X8U1D1wZMMCg6yopqDXbnAPiOk0ecgDLGzkEKV9JmtKKlprDLJCA0p+o9fWkuB7lP
 aaaK7tty9WgaSqHthwYrvmIAY6lb0So=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-kp8fTe31P-CWlWCkNGr1zA-1; Wed, 29 Apr 2026 16:58:30 -0400
X-MC-Unique: kp8fTe31P-CWlWCkNGr1zA-1
X-Mimecast-MFC-AGG-ID: kp8fTe31P-CWlWCkNGr1zA_1777496310
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50d826ed6f9so28105051cf.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 13:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777496310; x=1778101110; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=umX7UCeSkkaG6aO+7tOzFGLyJ5B5mxsVAIzWXtb8y4k=;
 b=HK9NpQyflm1dMDlkNdEbwdcqREsDbtX8T0ZS+Yhwtu+MfzSanSmsIHmKpWrEcrkdeR
 h2DLlyh6v2cL2V992xZmzZ9IV15RBKPR9hu7pBDcWKAlN43GyXjTFN0PaGXTqEnysPmD
 svXy9cBcKBNus7Knqe1ySZb7mhk5KXMJb4VVShShScy/mmJOf1IBQgcdUqPbOtdDt4xJ
 JD1ym2qS07ueAqgm/kxSMdjPkMf1lWRvNbA0CdFcExaiR4RL9sDdSjqaZIcPTO7LcQvy
 u/mSB/S4VOgSeljr7+A1EmPwHocXqjp20AmY7md4ELxEFP1NPmLzE+nPNtRxJlYOP8Rh
 wa0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777496310; x=1778101110;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=umX7UCeSkkaG6aO+7tOzFGLyJ5B5mxsVAIzWXtb8y4k=;
 b=C7iYYXpiZMLHOD8daFQf9k2ulgaxvGnKBATAvp7WrQDzGRNoIZPfJhoQxp56C5se/y
 puUdS+bSnIN1fGJnFFbp3bnzRQFfIeNPCEj7aJQk70Ql+xsz9mRy5biT2L0eDRU79IDN
 vpwp9t1mkp7C9I3ZSwSusMKkXt5Mrxa0epLTSVUs4Gi1MNqnZ61/poao+3B8FomSEnYc
 Heg3RA0Pm2FchdPC666TjGiYguxYjQ+QM+rcOvY1tmT5mcK9HhWuynI/RgJ58yYSf2wB
 yOTMrlgmgUmOeelRn7XKFCgtuRAbb32ZNvGdWTxtO/ZTEJzkwq5qbN6PNhsLJgqaGTWs
 aa8g==
X-Gm-Message-State: AOJu0YzQIcerSScNLyg7EiMOMuEnVoq29KIrWckKUltZqxkxf71rwVjx
 eBV7q5d70MFOq0S6YZeTx/U9uI4j9BXzcK5wHQRg8lPsVMet9rBRl3WmqU/9kE7j9dGApNKBQ8/
 +aMXdXNWQaVtSwrwMfjtRkP0Z3DBb1bMzaCtngOF+xHzr9eY/MRB5lfqK
X-Gm-Gg: AeBDiesyV0jLO2aj/t8HtBChcJ3W96czhkv3UZ7ShaHWQB7J7kSnYxk80zjGNqd1pU0
 aSKEWxctQ6/itq4Qknhyuy2nVDcTaOuH6A5iu4z4o9I9gI5P1bHgpk717OsrIIoDkig1GbX+ot2
 Ibe4ZLnyHYSGrcoOVSA+k5qAGdTFPYz+UttoHsP7NPbx8fiS9CAJpIvPWp/G5a4KLHu/oXKDk2S
 P7+cEfy1C0FjDeYbooN8Hdl3YhUx9XE2O1WfIwiIXjljlX2eEMxj1ITj+M4gWZDOPBpEabb4Uls
 BW/AEmyBewCXtlnb4eKMWVhnNQ9XcN0nsGovMie+PIaCVsUrKnL6o28T2/SBMJjLqcIi+UMk0w5
 lvYDayU7puOmP41C25WV08L2YBi3Y5pRkzPQmpxxSz2Nc6f01lNYzc5oC6Q==
X-Received: by 2002:a05:622a:88:b0:50d:af03:c9ca with SMTP id
 d75a77b69052e-51019b8a956mr60815271cf.38.1777496310186; 
 Wed, 29 Apr 2026 13:58:30 -0700 (PDT)
X-Received: by 2002:a05:622a:88:b0:50d:af03:c9ca with SMTP id
 d75a77b69052e-51019b8a956mr60814941cf.38.1777496309619; 
 Wed, 29 Apr 2026 13:58:29 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5101accd24asm30793801cf.9.2026.04.29.13.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 13:58:29 -0700 (PDT)
Date: Wed, 29 Apr 2026 16:58:28 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Zhang Chen <zhangckid@gmail.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 12/41] RFC net/colo-compare: guard finalize against
 uninitialized state
Message-ID: <afJw9Pz0alpWvRdd@x1.local>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
 <20260427-qom-tests-v1-12-c413f3605311@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260427-qom-tests-v1-12-c413f3605311@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Apr 27, 2026 at 11:42:11PM +0400, Marc-André Lureau wrote:
> colo_compare_finalize() assumes the object was fully set up by
> colo_compare_complete(), but a bare object_new() followed by
> object_unref() skips the complete callback entirely.
> 
> This causes two crashes:
> - qemu_mutex_destroy on the static event_mtx which was never
>   initialized (colo_compare_active is false)
> - qemu_bh_delete(NULL) and iothread dereference when s->iothread
>   is NULL
> 
> Guard the event_mtx teardown with colo_compare_active, and the
> iothread-dependent cleanup with an s->iothread NULL check.
> 
> This is an alternative to patch "colo-compare: Fix QMP
> qom-list-properties crashing", sent earlier, hence the RFC.
> 
> Fixes: 45942b79b9f8 ("net/colo-compare.c: Check that colo-compare is active")
> Cc: peterx@redhat.com
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

For this one, wouldn't the early version be better?

https://lore.kernel.org/all/20260423183212.468047-2-peterx@redhat.com/

It's simpler and skip everything when complete() isn't properly invoked.
E.g. if there'll be new things added to complete() in the future, we also
don't need to worry on whether there will be one more null-deref we may
overlook.

> ---
>  net/colo-compare.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
> 
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index c356419d6a8..be819db06c9 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -1416,7 +1416,7 @@ static void colo_compare_finalize(Object *obj)
>              break;
>          }
>      }
> -    if (QTAILQ_EMPTY(&net_compares)) {
> +    if (colo_compare_active && QTAILQ_EMPTY(&net_compares)) {
>          colo_compare_active = false;
>          qemu_mutex_destroy(&event_mtx);
>          qemu_cond_destroy(&event_complete_cond);
> @@ -1431,30 +1431,29 @@ static void colo_compare_finalize(Object *obj)
>      }
>  
>      colo_compare_timer_del(s);
> +    g_clear_pointer(&s->event_bh, qemu_bh_delete);
>  
> -    qemu_bh_delete(s->event_bh);
> +    if (s->iothread) {
> +        AioContext *ctx = iothread_get_aio_context(s->iothread);
>  
> -    AioContext *ctx = iothread_get_aio_context(s->iothread);
> -    AIO_WAIT_WHILE(ctx, !s->out_sendco.done);
> -    if (s->notify_dev) {
> -        AIO_WAIT_WHILE(ctx, !s->notify_sendco.done);
> -    }
> +        AIO_WAIT_WHILE(ctx, !s->out_sendco.done);
> +        if (s->notify_dev) {
> +            AIO_WAIT_WHILE(ctx, !s->notify_sendco.done);
> +        }
> +
> +        /* Release all unhandled packets after compare thread exited */
> +        g_queue_foreach(&s->conn_list, colo_flush_packets, s);
> +        AIO_WAIT_WHILE(NULL, !s->out_sendco.done);
>  
> -    /* Release all unhandled packets after compare thead exited */
> -    g_queue_foreach(&s->conn_list, colo_flush_packets, s);
> -    AIO_WAIT_WHILE(NULL, !s->out_sendco.done);
> +        object_unref(OBJECT(s->iothread));
> +    }
>  
>      g_queue_clear(&s->conn_list);
>      g_queue_clear(&s->out_sendco.send_list);
>      if (s->notify_dev) {
>          g_queue_clear(&s->notify_sendco.send_list);
>      }
> -
> -    if (s->connection_track_table) {
> -        g_hash_table_destroy(s->connection_track_table);
> -    }
> -
> -    object_unref(OBJECT(s->iothread));
> +    g_clear_pointer(&s->connection_track_table, g_hash_table_destroy);
>  
>      g_free(s->pri_indev);
>      g_free(s->sec_indev);
> 
> -- 
> 2.53.0
> 

-- 
Peter Xu


