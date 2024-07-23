Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD65C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 17:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWJlz-0003JO-4c; Tue, 23 Jul 2024 13:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sWJlx-0003Il-AA
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 13:58:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sWJll-0007XZ-2f
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 13:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721757465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ac2783x/eg0zfc9rf6gO49Lir82wvpPftV7kyDe/2Tw=;
 b=FGna8N/zmOFJXAcsPcHRvbySG/gw7sC6WEap3spIAK2VFsR//AMt88nSgfFHL/koSFzSoD
 0D9+Pl5/KaXbKvBLBVx9h18lb+DDagJyfItO6d172qeX9MZI5AE5jLVTyvzWSQjhKWLcpE
 9rL/N6vl/f56woEAuUK0RHdxqNXaKy8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-sEmX2-ThMIW9okj4S-kwtw-1; Tue, 23 Jul 2024 13:57:43 -0400
X-MC-Unique: sEmX2-ThMIW9okj4S-kwtw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-426703ac88dso39552495e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 10:57:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721757459; x=1722362259;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ac2783x/eg0zfc9rf6gO49Lir82wvpPftV7kyDe/2Tw=;
 b=OkDH84wYxJgsaz/zJ7ral41HuDaJ64rBXpkheVfL+nMBCYo2tvVkkSp1HNSBm15xUs
 LE3eeNw2Egby9yhTTetZAJyED46PqZKbcE/luwv3+kif6aKqwXFwCLmQIcWaFdDYdzCI
 H++PAhwwp11bh/4tpZhL/PDJ9KzLiEAJ1wE2IrvFWT59cfZ1dVUr6Y63IF/HHF9Sbc4j
 iaczsKJKRFt1kTtmM3PS9DwkrKQn2RJ2TMg4AKeRHNDTsVxcQ3NoySRYemLzB4fUgtJT
 cucANaM9B3EAvEmHhEoNGZMi7jGcaKEQedUX+oBtIXXWctQ2I1a6J94akW4R37rR71Zk
 nKsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8dHssJxT46Do8Rj6WzbmuetLWwRGOomkA0rXoxvzrqemYp9W/GObYcQFx4eZzaXNSuL5wyjG5mitCWgVFjbteHQo4T6s=
X-Gm-Message-State: AOJu0Yytt+vG7uqSWlbOTBmmX2MzU4aWohphIcUPMJD/tjDE2Lurdd1R
 x0auGR7IcW+mqhVcdViWYaXOG6h44HuBtca0cS3VjNrnFkz828iwuLLltTNuoVYGY1S4+703bmH
 vtEhxInEEN42kCdl2Q6wlUX95LjxrJKs549RLqH+bCRW9ZeJny9Tc+HzJQVKPLacgQaEDUT2xhg
 LsvUQV9KvsNAS0ZxDx5O9aJFX/osgO9+Kwe07RrA==
X-Received: by 2002:a05:600c:3502:b0:426:654e:16da with SMTP id
 5b1f17b1804b1-427f7a1ec21mr2459875e9.0.1721757459427; 
 Tue, 23 Jul 2024 10:57:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEz8NQriQ2WPxsM7L6f2KIwUOHljySj4S1zutt4y8ccWEZoS4j6bu3sgvpxMiwOqwC7c6E9G+/aQcaovjpAOQM=
X-Received: by 2002:a05:600c:3502:b0:426:654e:16da with SMTP id
 5b1f17b1804b1-427f7a1ec21mr2459745e9.0.1721757459050; Tue, 23 Jul 2024
 10:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240711131424.181615-1-ppandit@redhat.com> <Zo_8fpKH8oBA8WV1@x1n>
 <CAE8KmOzsGaPtTFsjcRkyd8n_fPzXeFd+c38Eb=aLG0_MdO+yKw@mail.gmail.com>
 <ZpUmrTrEnx0RcO2y@x1n>
 <CAE8KmOxY_LQ9vNjvmPyRgk_dcnEZFG6_M1q14473NQoBUSM4ow@mail.gmail.com>
 <ZpbuChi9QMIogmuS@x1n> <20240717045335-mutt-send-email-mst@kernel.org>
 <ZpfIDUwS9vawpzT5@x1n> <20240717093911-mutt-send-email-mst@kernel.org>
 <ZpfLZbiJ3cn6fEba@x1n> <20240720154116-mutt-send-email-mst@kernel.org>
 <CAE8KmOwv-NiXwmeCAjFNu=R67D2GcNLffV8NedfMBXhY9ODh8w@mail.gmail.com>
In-Reply-To: <CAE8KmOwv-NiXwmeCAjFNu=R67D2GcNLffV8NedfMBXhY9ODh8w@mail.gmail.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 23 Jul 2024 23:27:21 +0530
Message-ID: <CAE8KmOx3VeyX-_xYNuD5rFak1jjKPPm4TsuuOMV=yx_gW=XgOw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Postcopy migration and vhost-user errors
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Jason Wang <jasowang@redhat.com>,
 mcoqueli@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi,

On Tue, 23 Jul 2024 at 10:33, Prasad Pandit <ppandit@redhat.com> wrote:
> On Sun, 21 Jul 2024 at 01:11, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > On Wed, Jul 17, 2024 at 04:55:52AM -0400, Michael S. Tsirkin wrote:
> > > > > > I just want to understand how we managed to have two threads
> > > > > > talking in parallel. BQL is normally enough, which path
> > > > > > manages to invoke vhost-user with BQL not taken?
> > > > > > Just check BQL taken on each vhost user invocation and
> > > > > > you will figure it out.
> > > > >
> > > > OK, so postcopy_ram_ things run without the BQL?
>
> I'll check the postcopy_ram_* functions to see what's happening there.
===
2024-07-23T17:11:25.934756Z qemu-kvm: vhost_user_postcopy_end:
161184:161213: BQL not taken
2024-07-23T17:11:25.934994Z qemu-kvm: vhost_user_postcopy_end:
161184:161213: BQL not taken
2024-07-23T17:11:25.935095Z qemu-kvm: vhost_user_postcopy_end:
161184:161213: BQL not taken
===
* postcopy_ram_listen_thread() does not take the BQL. Trying to see
where to take it.

Thank you.
---
  - Prasad


