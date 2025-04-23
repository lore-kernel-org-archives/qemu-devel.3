Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A32C5C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 19:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7fWi-0004cV-Pq; Wed, 23 Apr 2025 15:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u7fWg-0004c5-Qp
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 15:12:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u7fWf-0005RR-8E
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 15:12:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745435570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/2+7Asp4/SBmVileS5uzhEy8VuHtQw0wv36dAHna1ZY=;
 b=DlJ0QehsYMsRT3nqiWmL4ibqErzc/WnoaaapZE7g1BXJaY5O5Jx/UuJm2RUK5kCVhORpQM
 PBZYnqXaDAMSW2bqxuiYC06PreGwnxSEVhlwihKASaKN4l3h8u2AUxtHfb34xmAIokMYag
 QfVlhR0czpfl7rQGEFQKkLP75mMmyI8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-241-VXxA0eoxMxG1uMWTh4X9mQ-1; Wed,
 23 Apr 2025 15:12:46 -0400
X-MC-Unique: VXxA0eoxMxG1uMWTh4X9mQ-1
X-Mimecast-MFC-AGG-ID: VXxA0eoxMxG1uMWTh4X9mQ_1745435563
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 03F2F1800876; Wed, 23 Apr 2025 19:12:43 +0000 (UTC)
Received: from redhat.com (dhcp-2-16-59.telco5g.eng.rdu2.redhat.com
 [10.2.16.59])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1ED651800378; Wed, 23 Apr 2025 19:12:38 +0000 (UTC)
Date: Wed, 23 Apr 2025 14:12:36 -0500
From: Eric Blake <eblake@redhat.com>
To: Sunny Zhu <sunnyzhyy@qq.com>
Cc: hreitz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, 
 qemu-block@nongnu.org, qemu-devel@nongnu.org, vsementsov@yandex-team.ru, 
 stefanha@redhat.com
Subject: Re: [PATCH v2 08/11] mirror: Skip writing zeroes when target is
 already zero
Message-ID: <2pmotnqkhinhqulzoemjnlrfpve23pssy33jox4rcbi4742n2f@swiytlqan3pp>
References: <20250417184133.105746-21-eblake@redhat.com>
 <tencent_85E0A24CC61971732FCD04DD85BC3689E205@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_85E0A24CC61971732FCD04DD85BC3689E205@qq.com>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Apr 24, 2025 at 12:42:45AM +0800, Sunny Zhu wrote:
> on Thu, 17 Apr 2025 13:39:13 -0500, Eric Blake wrote:
> > When mirroring, the goal is to ensure that the destination reads the
> > same as the source; this goal is met whether the destination is sparse
> > or fully-allocated.  However, if the destination cannot efficiently
> > write zeroes, then any time the mirror operation wants to copy zeroes
> > from the source to the destination (either during the background over
> > sparse regions when doing a full mirror, or in the foreground when the
> > guest actively writes zeroes), we were causing the destination to
> > fully allocate that portion of the disk, even if it already read as
> > zeroes.
> > 
> > @@ -452,12 +474,21 @@ static unsigned mirror_perform(MirrorBlockJob *s, int64_t offset,
> > 
> >      switch (mirror_method) {
> >      case MIRROR_METHOD_COPY:
> > +        if (s->zero_bitmap) {
> > +            bitmap_clear(s->zero_bitmap, offset / s->granularity,
> > +                         DIV_ROUND_UP(bytes, s->granularity));
> > +        }
> >          co = qemu_coroutine_create(mirror_co_read, op);
> >          break;
> >      case MIRROR_METHOD_ZERO:
> > +        /* s->zero_bitmap handled in mirror_co_zero */
> >          co = qemu_coroutine_create(mirror_co_zero, op);
> >          break;
> >      case MIRROR_METHOD_DISCARD:
> > +        if (s->zero_bitmap) {
> > +            bitmap_clear(s->zero_bitmap, offset / s->granularity,
> > +                         DIV_ROUND_UP(bytes, s->granularity));
> > +        }
> >          co = qemu_coroutine_create(mirror_co_discard, op);
> >          break;
> >      default:
> > 
> 
> If we have performed the skip-zero operation, it should not be constrained
> by mirror job bandwidth limits. Therefore, it is preferable to exclude it
> from rate limiting.

Indeed, that makes sense.  And it may impact the iotests: test 194
should have a smaller amount of bytes transferred, due to skipping
zeroes, so I may need to hoist the filtering that I added in the later
patch for iotest mirror-sparse into common code.

>   
>   bool skip_write_zero = false;
> 
>   io_bytes = mirror_perform(s, offset, io_bytes, mirror_method, &skip_write_zero);
>   if (skip_write_zero || (mirror_method != MIRROR_METHOD_COPY && write_zeroes_ok)) {
>       io_bytes_acct = 0;
>   } ..
>

Thanks; that's helpful.  I'll incorporate it into v3.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


