Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52AB6CAC5A8
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 13:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0gOm-0002jP-Ga; Mon, 22 Sep 2025 09:16:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v0gOg-0002h0-Qw
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:16:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v0gOb-0003tt-UU
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:16:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758546955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ow/NcTj/7TrFv8RjYcYgHLT6qQmHn63eGCevpdk/GbU=;
 b=D2ZyYt1S2KZxcWuCJX22Pc7oCzeyf0bZWxu+3MHzHAmSZAClS6kJlb2pkxYJv5ia1pLHF5
 EvgBkx7dQxSbECUl2FcB1tAkxBSi4e47hd2uQU9HksoQeRWfPo5c0FsWlYAWlzdKmViNiG
 o5XB63ckuCBEMleQ+y6PS34JaYPGfaI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-I2dz3pq9MC66cU58vlObXw-1; Mon, 22 Sep 2025 09:15:53 -0400
X-MC-Unique: I2dz3pq9MC66cU58vlObXw-1
X-Mimecast-MFC-AGG-ID: I2dz3pq9MC66cU58vlObXw_1758546952
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3ece0fd841cso3112456f8f.0
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 06:15:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758546952; x=1759151752;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ow/NcTj/7TrFv8RjYcYgHLT6qQmHn63eGCevpdk/GbU=;
 b=mwDNGgVycPDWaIfAgF5PdWlTXnaFwpBXxmdD5FnM3b8/nr4nZlnYEVlIgVQn/5t0X5
 1w2Yt5sBxzu2n7TEN3aCkDp/DEbtOLGj8JRZsjNR7yA4fffEV8D+a78XDlufgfTQ//in
 oXR0KAPRhuuJOR9R/xRxxoPmD8E3JJpn7P440tulQ10PfQJibYdneti6Fkh4K9q63TQC
 3pHJ4AF7LcjRg+XVphx4QlYMPDQZioHFaGwFyPtf2vcFSAmmvznvAAsriGBKWA0/H5S7
 1L8fJhG3P+86o5hVcG7DCPkZGDNlEiZgQWPAh8GLPOcJ3HdkBshlJz9wF90Oi2FyMA64
 DyyQ==
X-Gm-Message-State: AOJu0YznQX4VfoqX9nuAVaTTLGHNwHvXNJ+GSMnYhay9FTHcoD12lpSs
 zbqKgeqDetQCQwYZb07/pJy/CS6ZBD6WQmr6dK2ZnRgIqGapxDKzxc49W6j1KTsjZLLLvi54n4R
 ZvLjyGla/QnDpLV6cKSSO9zPKzewAZ1MTchKLsQRWPSzfBpN1LC139lVO
X-Gm-Gg: ASbGncsg40TLfVXCYhz6cuAisLQIXvD+TlI7m7VyA8I+qSES7jlD7UBaQaqbf9Qcd7F
 txFgJkrQiEdrPzu64a0Fmq+RCmBKsvQIwEVbPys9eZwAKjIHYaLsOtmM3ak/Np+A8YmGATIIhvL
 I2IRByWiBwdF1/7QYJnO/Ec0+K6eXs+Z64S3bt/OQfyOHjMbobrGZoOqQ1q75B8OwX52PjnOTkr
 uJVMNnqEsYn1kLpUsGYxXEd4IkWQdeiii7g13tDNyCiTGLVQELbE8CGcV05iSyUg3Ybn3SXuLMf
 Vo6v6DpAKFyqRT3f5q8WVEkH9keLA7GjwRs=
X-Received: by 2002:a05:6000:2dc9:b0:3ea:5f76:3f72 with SMTP id
 ffacd0b85a97d-3ee852a4a96mr8601991f8f.49.1758546951940; 
 Mon, 22 Sep 2025 06:15:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBDwle1Upj8OPe/5tSD4qugq987hugG9cfh1GhDux96DnWgTGvfkDpQWx3jfB/o1HLzu3vBQ==
X-Received: by 2002:a05:6000:2dc9:b0:3ea:5f76:3f72 with SMTP id
 ffacd0b85a97d-3ee852a4a96mr8601971f8f.49.1758546951507; 
 Mon, 22 Sep 2025 06:15:51 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee07407aebsm20564441f8f.14.2025.09.22.06.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 06:15:51 -0700 (PDT)
Date: Mon, 22 Sep 2025 09:15:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Luigi Rizzo <lrizzo@google.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v6 09/14] qmp: update virtio features map to support
 extended features
Message-ID: <20250922091422-mutt-send-email-mst@kernel.org>
References: <cover.1757676218.git.pabeni@redhat.com>
 <bef09bed78378da9c32d9913eefb83bd42ba8808.1757676218.git.pabeni@redhat.com>
 <20250922085341-mutt-send-email-mst@kernel.org>
 <ae5d139a-d6c7-477a-8083-26e64bdeda8b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae5d139a-d6c7-477a-8083-26e64bdeda8b@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Sep 22, 2025 at 03:10:36PM +0200, Paolo Abeni wrote:
> On 9/22/25 2:55 PM, Michael S. Tsirkin wrote:
> > On Fri, Sep 12, 2025 at 03:07:00PM +0200, Paolo Abeni wrote:
> >> Extend the VirtioDeviceFeatures struct with an additional u64
> >> to track unknown features in the 64-127 bit range and decode
> >> the full virtio features spaces for vhost and virtio devices.
> >>
> >> Also add entries for the soon-to-be-supported virtio net GSO over
> >> UDP features.
> >>
> >> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >> Acked-by: Jason Wang <jasowang@redhat.com>
> >> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> >> ---
> >> v3 -> v4:
> >>   - cleanup unknown features init
> >>   - update QMP example and doc accordingly
> >>   - use new virtio_features macro names
> >>
> >> v2 -> v3:
> >>   - unknown-dev-features-dword2 -> unknown-dev-features2
> >>   - _array -> _ex
> >>   - fixed typos in entries description
> >>
> >> v1 -> v2:
> >>   - uint128_t -> uint64_t[]
> >> ---
> >>  hw/virtio/virtio-hmp-cmds.c |  3 +-
> >>  hw/virtio/virtio-qmp.c      | 91 +++++++++++++++++++++++++------------
> >>  hw/virtio/virtio-qmp.h      |  3 +-
> >>  qapi/virtio.json            |  9 +++-
> >>  4 files changed, 74 insertions(+), 32 deletions(-)
> >>
> >> diff --git a/hw/virtio/virtio-hmp-cmds.c b/hw/virtio/virtio-hmp-cmds.c
> >> index 7d8677bcf0..1daae482d3 100644
> >> --- a/hw/virtio/virtio-hmp-cmds.c
> >> +++ b/hw/virtio/virtio-hmp-cmds.c
> >> @@ -74,7 +74,8 @@ static void hmp_virtio_dump_features(Monitor *mon,
> >>      }
> >>  
> >>      if (features->has_unknown_dev_features) {
> >> -        monitor_printf(mon, "  unknown-features(0x%016"PRIx64")\n",
> >> +        monitor_printf(mon, "  unknown-features(0x%016"PRIx64"%016"PRIx64")\n",
> >> +                       features->unknown_dev_features2,
> >>                         features->unknown_dev_features);
> >>      }
> >>  }
> >> diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
> >> index 3b6377cf0d..502c9ae930 100644
> >> --- a/hw/virtio/virtio-qmp.c
> >> +++ b/hw/virtio/virtio-qmp.c
> >> @@ -325,6 +325,20 @@ static const qmp_virtio_feature_map_t virtio_net_feature_map[] = {
> >>      FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
> >>              "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
> >>              "negotiation supported"),
> >> +    FEATURE_ENTRY(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO, \
> >> +            "VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO: Driver can receive GSO over "
> >> +            "UDP tunnel packets"),
> >> +    FEATURE_ENTRY(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM, \
> >> +            "VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO: Driver can receive GSO over "
> > 
> > This really should be VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM.
> > 
> > Given they all seem to start with repeating the feature name,
> > why not just add it to the string automatically by the macro?
> 
> UHmm... let me keep the things simple and just fix the string; macro
> refactoring could be a follow-up, I hope?
> 
> Thanks,
> 
> Paolo

the fix can be a follow-up too, but I'd like it done now pls,
there could be more I missed.

-- 
MST


