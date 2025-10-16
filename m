Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9065BCCD195
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 14:15:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Ojq-0000v2-Rn; Thu, 16 Oct 2025 10:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1v9Ojl-0000uh-TD
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 10:13:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1v9Oje-0000SF-Ez
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 10:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760624017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dxHBpd3tPa2Knt5n/XAxxHyelwb6A4weSBZHNgWRLxw=;
 b=H9ubBEta/HpcrVrQ3+aTgo4ZrziAYOiSg2hRlS03T1llFq6f6K3ZVylHk23ouVrZJMHfNl
 Fy1Pt7EBQ+1/BF45IPOT9vfL1PUf2SRT9cAsilSQnGCnD24oRzSBykTy6jPLsisPBxauXp
 cJAVjgC0tqBNjiyYT+Jy5lzo0UnOu14=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-dlQU6xfkMVe4WxDvzAIhYA-1; Thu,
 16 Oct 2025 10:13:35 -0400
X-MC-Unique: dlQU6xfkMVe4WxDvzAIhYA-1
X-Mimecast-MFC-AGG-ID: dlQU6xfkMVe4WxDvzAIhYA_1760624014
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A53D1801226; Thu, 16 Oct 2025 14:13:34 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.155])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 057A31956056; Thu, 16 Oct 2025 14:13:32 +0000 (UTC)
Date: Thu, 16 Oct 2025 09:13:30 -0500
From: Eric Blake <eblake@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Grant Millar | Cylo <rid@cylo.io>, 
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH v2 1/3] io: release active GSource in TLS channel finalizer
Message-ID: <djh65y3crcxrxtaeldymyoywnwcg7xvyohwrq3eq2duwsc4xpo@5n6flkrzcpds>
References: <20251003150245.3510069-1-berrange@redhat.com>
 <20251003150245.3510069-2-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251003150245.3510069-2-berrange@redhat.com>
User-Agent: NeoMutt/20250905
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, Oct 03, 2025 at 04:02:43PM +0100, Daniel P. Berrangé wrote:
> While code is supposed to call qio_channel_close() before releasing the
> last reference on an QIOChannel, this is not guaranteed. QIOChannelFile
> and QIOChannelSocket both cleanup resources in their finalizer if the
> close operation was missed.
> 
> This ensures the TLS channel will do the same failsafe cleanup.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  io/channel-tls.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/io/channel-tls.c b/io/channel-tls.c
> index 7135896f79..bb460ca7e9 100644
> --- a/io/channel-tls.c
> +++ b/io/channel-tls.c
> @@ -342,6 +342,16 @@ static void qio_channel_tls_finalize(Object *obj)
>  {
>      QIOChannelTLS *ioc = QIO_CHANNEL_TLS(obj);
>  
> +    if (ioc->hs_ioc_tag) {
> +        trace_qio_channel_tls_handshake_cancel(ioc);
> +        g_clear_handle_id(&ioc->hs_ioc_tag, g_source_remove);
> +    }
> +
> +    if (ioc->bye_ioc_tag) {
> +        trace_qio_channel_tls_bye_cancel(ioc);
> +        g_clear_handle_id(&ioc->bye_ioc_tag, g_source_remove);
> +    }
> +
>      object_unref(OBJECT(ioc->master));
>      qcrypto_tls_session_free(ioc->session);
>  }
> -- 
> 2.50.1
> 
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


