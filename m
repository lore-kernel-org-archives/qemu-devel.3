Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E16D216A7
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 13:51:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0hwb-00022i-My; Tue, 15 Oct 2024 09:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t0hwa-00022E-7x
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 09:50:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t0hwY-000639-NA
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 09:50:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729000233;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xOY+mtHXBJIIE4IBR6A7SRcbT8cmvIZl56oCsknEpmo=;
 b=I2KEYn6uZVahPJdpoVy2/zHxvO6pCB0TWdV6SMDUMRhdjyJPMXAIUnNLG0wSJp6vMeLxFZ
 XxGMKtZcGvvCbpVTNIVltd9z2Vjdpht0xn3PKjn6fqFMgfsQc4QEiBKIx8hazNLKeaZ6WY
 0JU5ZpuK2tTvU4OVwuQU2qFxthGQ5kU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-OpuzB3P6NjefsZqSZSdVKQ-1; Tue,
 15 Oct 2024 09:50:29 -0400
X-MC-Unique: OpuzB3P6NjefsZqSZSdVKQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D6E121956080; Tue, 15 Oct 2024 13:50:28 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.118])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D54F1955E8F; Tue, 15 Oct 2024 13:50:24 +0000 (UTC)
Date: Tue, 15 Oct 2024 14:50:20 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>
Subject: Re: [PATCH v2 0/7] Report fatal errors from failure with pre-opened
 eBPF RSS FDs
Message-ID: <Zw5zHHzsLknlxOXp@redhat.com>
References: <20240905181330.3657590-1-berrange@redhat.com>
 <20240906055711-mutt-send-email-mst@kernel.org>
 <CACGkMEvxkVt7iFkTJT3u1fa9cAycoXyFq62Bq_f8Ebm6NLgpmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEvxkVt7iFkTJT3u1fa9cAycoXyFq62Bq_f8Ebm6NLgpmQ@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Sep 09, 2024 at 10:34:32AM +0800, Jason Wang wrote:
> On Fri, Sep 6, 2024 at 5:57 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Sep 05, 2024 at 07:13:23PM +0100, Daniel P. Berrangé wrote:
> > > The virtio-net code for eBPF RSS is still ignoring errors when
> > > failing to load the eBPF RSS program passed in by the mgmt app
> > > via pre-opened FDs.
> > >
> > > This series re-factors the eBPF common code so that it actually
> > > reports using "Error" objects. Then it makes virtio-net treat
> > > a failure to load pre-opened FDs as a fatal problem. When doing
> > > speculative opening of eBPF FDs, QEMU merely prints a warning,
> > > and allows the software fallback to continue.
> > >
> > > Trace event coverage is significantly expanded to make this all
> > > much more debuggable too.
> >
> >
> > looks good
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > Jason's tree.
> >
> 
> Queued.

I'm still not seeing this in master - is any PR planned in near future ?

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


