Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7FDDC4450A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 19:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjikA-0008E6-Bs; Tue, 14 Jul 2026 15:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wjik8-0008Ai-SN
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 15:24:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wjik6-0002rL-VN
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 15:24:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784057073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/iTyI0hOgE2maTr+e5Z2IOGHvfUjIm91W8OQBeGo1OA=;
 b=AjPwgI44Co16wq4cK7ndmgl+1e5LCg0a3PmkwjRErbkYDzT3gMLvvfyVJ1V/r1UAe8rRGK
 gknCiG1lplgkSDNy56qy0nEV62TO1myQg5frMxfJP+16Pz0sXzClBs+x/MnUwQOPZ7a3NB
 +7m5UZzRiSj9vgECjjE/LS6UI/iC9YM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-Ey1A4xlTNzSC5g1oCmpgKQ-1; Tue, 14 Jul 2026 15:24:31 -0400
X-MC-Unique: Ey1A4xlTNzSC5g1oCmpgKQ-1
X-Mimecast-MFC-AGG-ID: Ey1A4xlTNzSC5g1oCmpgKQ_1784057070
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-472a798fc7cso849325f8f.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 12:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784057070; x=1784661870; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/iTyI0hOgE2maTr+e5Z2IOGHvfUjIm91W8OQBeGo1OA=;
 b=PCKxm5JllVQf7HZxQTRwY601ZyvUs2q8fiSGHOqV3Tt6AJy8LsqcOi6j8TRuCyU/Mx
 r2nbRoBsAm6Zy58fXilfDfDae6dVnon9bDzT1nolGtTWFPyL3yacChJCSduw8ejNgNKB
 K4Fy1lFmSIN5CuHKN25qT7AvJuOJXhiK7Y2H4TzwkxHel7ubOPO8goZHg5PBsOUcpwUy
 eZU0bKr9H0PV2M8QesShYt8Qd5LSaisTsNMuLfSRtZMXRgF9jjTRrEu5Ihnn5Mh4q3BT
 X8YeUi4T7onyqT2hv5s2LBqzrJFQ0JnLX37pKt2eBrv4jbM4s8h3VXqwprRd+3Oe/U6J
 o+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784057070; x=1784661870;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/iTyI0hOgE2maTr+e5Z2IOGHvfUjIm91W8OQBeGo1OA=;
 b=ertzkpsqCMK9isBX6PrSlc8Zfokz8cX5eBI/4+0HFWVwYdbOdq3FdaQWSfYUj7ODOD
 3Wk/QNniTU59VuakxCxSjxfBOqJzDj1UGBIm3JkWmU7gtrjSlbwWxlzzHLjbBCOQRt6T
 UAGPh1aRE0yki8SQ/wsAJI1s4ZDgUPrHLl/jAZ3slkhOkLl0IP/GZZ3QwQT7brxKEVIK
 PUilJeJx8fXj3Di/Z9QVZK53v5oExuaWMglRXMmfinTvIv8KNwB0ukKkDNtT0B0s7I7T
 +wSyca2nS9e387HFQlo/E/YrmlnMYBoBfvHCo3InJz88s4TytYwFj1K9AYrPesEbdbYt
 LAww==
X-Forwarded-Encrypted: i=1;
 AHgh+RrbnzYlkOIXnX3bNAZglpV81cSSB1Rev0O+e8xn1DjOI+3PseOwUTicuc7oCRosymhsQvL6su0f7VVg@nongnu.org
X-Gm-Message-State: AOJu0Yw9HOK6Lr84S7J8Gg5RGWOT2rlaOT0CrLs51SL60fGphFjAnVlE
 azfEMXJZ3JpzQ45g5Xos9lxXqYgR+CGcEWYwIhPFHTDnnu/G4t/WESw6PjamGX9kVP2HzO5Dyue
 /7kebg+wgMxuE7J8Rng9TXHem/0hclhWsABuK49tkESIcXCTf16Fzjz1F
X-Gm-Gg: AfdE7cnIUPi9Lgi9gYv2P0I0OcAGQ/DIuOvfNaFRiseAQDT5LAhf9wQB4iPp3RdKwLs
 9hXre7Dr8P7sMgAZa2uCYhAuZVIOlk9FoO5A+8HYFR9R1xwuz1crBCPht3ZusNqcNKGRYtIyJat
 zchec2FtMjf9aKnHERIC/4AR8CGW7eQEZFCE21ymSXic0l5kj/pBgoLKcdLNiNF0aj8xvFJQ2Rt
 kr5kx32BsipA9VEore2EL7U5V7+HvnIWsLCJ58vrFxqjlINmCWYWKiayJRxIpJm7nB04OOncxPf
 3j/0yoskXsGtV8+EEqr/gASr5CB5vHIqImHdxQ7DejJiSbHgNzakwTxERPUM+UoInnlZN/UYk8e
 onlg+MRXo39X0l27V6/RoEAxhxGpb2+6X5BI=
X-Received: by 2002:a05:6000:2c05:b0:475:e7f7:ef7b with SMTP id
 ffacd0b85a97d-47f2dc8d7aamr18570781f8f.1.1784057070350; 
 Tue, 14 Jul 2026 12:24:30 -0700 (PDT)
X-Received: by 2002:a05:6000:2c05:b0:475:e7f7:ef7b with SMTP id
 ffacd0b85a97d-47f2dc8d7aamr18570748f8f.1.1784057069836; 
 Tue, 14 Jul 2026 12:24:29 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f476e9d02sm10449847f8f.19.2026.07.14.12.24.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 12:24:29 -0700 (PDT)
Date: Tue, 14 Jul 2026 15:24:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com, armbru@redhat.com, peterx@redhat.com,
 farosas@suse.de, raphael.s.norwitz@gmail.com, bchaney@akamai.com,
 qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 yc-core@yandex-team.ru, mark.caveayland@nutanix.com,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Jason Wang <jasowangio@gmail.com>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v18 12/14] net/tap: support local migration with virtio-net
Message-ID: <20260714035132-mutt-send-email-mst@kernel.org>
References: <20260710191809.721154-1-vsementsov@yandex-team.ru>
 <20260710191809.721154-13-vsementsov@yandex-team.ru>
 <20260713153340-mutt-send-email-mst@kernel.org>
 <449911ff-33cb-4fef-8dd2-33d8f3dc9620@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <449911ff-33cb-4fef-8dd2-33d8f3dc9620@yandex-team.ru>
Received-SPF: permerror client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Jul 14, 2026 at 09:43:52AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 13.07.26 22:36, Michael S. Tsirkin wrote:
> > On Fri, Jul 10, 2026 at 10:18:01PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > Support transferring of TAP state (including open fd).
> > > 
> > > Add new property "local-migration-supported", which defines
> > > whether local-migration is actually supported for this TAP device.
> > > Starting from 11.2 QEMU Machine Types it's enabled by default.
> > > 
> > > Note, that local-migration (including migrating opened FDs
> > > through migration channel, which must be UNIX socket), is
> > > enabled by global "local" migration parameters. But individual
> > > devices may have additional options to enable/disable it
> > > per device.
> > > 
> > > The tricky thing, is that we need to know, should we do
> > > call open/connect in TAP initialization code. That means,
> > > that on incoming migration we want to know status of
> > > "local" migration parameter at time of creating TAP device.
> > > So, currently, for incoming local migration only TAP device
> > > created through QMP is supported, as you need to set migration
> > > parameter first (through QMP as well).
> > > 
> > > So the full picture is:
> > > 
> > > On source, to start outgoing "local" migration you need:
> > > 
> > >   - migration parameter "local" set to true
> > >   - "local-migration-supported" TAP option set to true (the
> > >     default, starting from 11.2 QEMU Machine Types)
> > > 
> > > If at least one of these options is not set, TAP backend
> > > doesn't participate in migration.
> > > 
> > > On target, things are more difficult:
> > > 
> > > Same, you need both "local" and "local-migration-supported"
> > > be set. And same, if one of them is not set, TAP backend
> > > is initialized as usual, and doesn't accept any incoming
> > > state.
> > > 
> > > Additionally, if you are going to set "local", it must be
> > > set before creating the TAP device. If TAP device created
> > > with "local" unset, it initializes as usual. If you enable
> > > "local" after it and start incoming migration, it will fail
> > > in .pre_load handler of TAP backend.
> > > 
> > > Moreover, there are interface restrictions: if you create TAP
> > > device when QEMU is in INCOMING state, and both "local"
> > > and "local-migration-supported" set, most of TAP options are
> > > not allowed, and script/downscript are required to be explicitly
> > > unset (set to "" or "no").
> > > 
> > > Signed-off-by: Vladimir Sementsov-Ogievskiy<vsementsov@yandex-team.ru>
> > 
> > I am still confused why is this per device. I just do not
> > see where is it useful to set it for some devices
> > but not others. So it looks like a machine property
> > "incoming local migration" to me?
> > 
> > Sorry if I am being dense.
> 
> 1. We need at least "per device class": when local-migration-support is
> implemented for some new device, we still need to migrate from/to older
> version without this support.
> 
> Assume we have "local" migration parameter and support for TAP in 11.2.
> Then, in 12.0 support for vhost-user-blk is implemented. If we have only
> global "local" parameter, the migration will be broken between 11.2 and
> 12.0,
> with local=true, as in 11.2 it means only TAP local migration, but
> in 12.0 it means both TAP and vhost-user-blk local migration.
> 
> Of course, now it's a bit redundant, as we have only TAP, and may define,
> that TAP is always supported (as support is introduced together with
> "local"). But there are another considerations:

If this is your way to version the behaviour, that is fine, but it should
be an internal property without ABI guarantees, starting with "x-".

> 
> 2. Symmetry: if have a possiblity to disable feature only for vhost-user-blk,
> seems good to have same possibility for TAP.
> 
> 3. Disabling fd-migration per device may be useful to switch this specific
> device to another backend.

Unclear what good is it, and the drawback is that it blows up the size
of our testing/support matrix.

> -- 
> Best regards,
> Vladimir


