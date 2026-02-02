Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32CF6D172B0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 07:40:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmoXg-0008A8-0j; Mon, 02 Feb 2026 02:40:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vmoXa-00081Z-H7
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 02:40:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vmoXY-0003eh-IV
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 02:40:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770018007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JzDc6jh3CoGWV12TRUU2+sdi3Xol4q4u3nh9cUPyRQw=;
 b=HpceOeuYTcI4aUE2JC1Ee+9zg0T1vJ23TjlTjU81j/2iEb6zhiEKXawcEWUKI97KOjorX8
 FU+RTSBtBrS2NdQ5rieMF6GN8LNhjBt3e123jLxbsrJc7hepxIFF7W0sG4gk2mAMbllJ4C
 vCPyi4S6wgruwQGB2Zk4lMuMW0IF27M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-Upkb2hvAMFSLgVMHGeqZNw-1; Mon, 02 Feb 2026 02:40:05 -0500
X-MC-Unique: Upkb2hvAMFSLgVMHGeqZNw-1
X-Mimecast-MFC-AGG-ID: Upkb2hvAMFSLgVMHGeqZNw_1770018004
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47ee432070aso31975845e9.1
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 23:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770018004; x=1770622804; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JzDc6jh3CoGWV12TRUU2+sdi3Xol4q4u3nh9cUPyRQw=;
 b=Aaw3oQlPdLmD6PFx7MGTgaki7kbrJAtt/I7ItgEbrUWL4O91HV0SRaTY6Ei9C3CjO1
 /tzhN/wDxEJlVjUqzU6SbrmMD2qOXpNb5L6h586tT8pwt/Py0FFocT1SX+0ddJftEhwv
 /xHqd4AKq19KEAdyGvQrFiGpy1Fi99tS1bmZmZxd0PccWllrT84tWlwNQeaTZi9D+uBS
 uasLeHhUGKYrsFBVnbyNXQD+ljt8oNJianF0qmZ7duWS84nV1xLO5vPX+LSTYq/45qPv
 wgnZIHSbKlzuPbCUfHc8vuMZmbjoFovuobXP1W2pdefnEZMTSqMBnG9DyCGCxG7qSZ8X
 x2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770018004; x=1770622804;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JzDc6jh3CoGWV12TRUU2+sdi3Xol4q4u3nh9cUPyRQw=;
 b=vRsNUYplz3n7OFNq+yTebXantI31AN+tK9StdXr2OxJ2XVyCFXAES8QMuMzOHYtMp/
 K2ofZHY/11wYyXvKpHZw1Gvr3cOvYyNGuhw4PRHOj7C53A+XZpB7yg3U04CC+cGRoEVm
 2dM1jHlBkS4Iiqw+bwpLdEw7dhwzyaUJPbsffKBFrlivcC1XAG/S0u2l6+CAZBFawNC7
 qBEdJi72cCVnotkvtSR9D/VbB6MMOntzGOEKUpyFCAsYHhDMHGhryUg9GPrz2Bkb03Sa
 AVuEnGo6ApsefZqxGglWVde6kEDzfdWrOGf3cFmtczFLiC1iw3gx1tPLhcx/l2nTtwRw
 68+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWd4qHCmrUjac3v9hb38iTNFhcj2ObplAdKXaCnvlri1L8RTp3NDiIs0fzwb8KHznkgMWlbir0mjSNf@nongnu.org
X-Gm-Message-State: AOJu0Yz14flMNgpMH8ek2hTCVmJ9CKz6uui3FoGPp6luRG8/p50D+/K3
 k22hxr5ByzwRYMKNXH5cX7RiipE+KiDZJyH7sjxBMwYRwI4NihM3saVVh2+RytkIT1e8m0nEPmi
 XRxtNNarwoJ34VMEAyR50IvSjXoRifEhnDZC2kWyTav+rg+dftLFDPvCa
X-Gm-Gg: AZuq6aKMcCDM6rh+1azC+BsYfTY47gh3TrsvfGXwSLy6DLs3Posrx2uwUL6/nSfv9Cv
 p+ZzrTActywNGqK/v4rlw8Lla0mqGq7bfy1aPebk24Ni+IkIZhg6kH6B4e5SQDXYRDsxqcz06G3
 gtOdc/devpTOWXXbs8S+9ScOZp6flbQoupdMV+xS//Qt/LP/SijsHOxLXW+L/8BzqIJqKwMNcLt
 OTkHNvPOP0EKV75X4VkgxQBFAfeOzTw3Ldodnw8jzumxk3T+Gq19CK2niwNq5/t8jVv6nPfdy+1
 jJqTYh+KEaHzit0J+EzRcpDHTU8q6HN63KRfBL4nnsQOPOe5DNsLgwDNAnPr4PwCURf9BV9C0MP
 yDP/ZntHXHjGuV1oKcobMCGTpxh3oBUA8pQ==
X-Received: by 2002:a05:600c:470c:b0:47e:e952:86c9 with SMTP id
 5b1f17b1804b1-482db1ffb81mr148553625e9.0.1770018004498; 
 Sun, 01 Feb 2026 23:40:04 -0800 (PST)
X-Received: by 2002:a05:600c:470c:b0:47e:e952:86c9 with SMTP id
 5b1f17b1804b1-482db1ffb81mr148553245e9.0.1770018003997; 
 Sun, 01 Feb 2026 23:40:03 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482e04ed4d2sm85449055e9.7.2026.02.01.23.40.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Feb 2026 23:40:03 -0800 (PST)
Date: Mon, 2 Feb 2026 02:40:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/6] include/hw/virtio/virtio-access.h: remove target
 specifics define
Message-ID: <20260202023914-mutt-send-email-mst@kernel.org>
References: <20260131020100.1115203-1-pierrick.bouvier@linaro.org>
 <20260131020100.1115203-3-pierrick.bouvier@linaro.org>
 <20260131124842-mutt-send-email-mst@kernel.org>
 <299f59f7-62c3-42f4-99c4-b7c7cfb111c2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <299f59f7-62c3-42f4-99c4-b7c7cfb111c2@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sun, Feb 01, 2026 at 11:36:04PM +0100, Philippe Mathieu-Daudé wrote:
> On 31/1/26 18:48, Michael S. Tsirkin wrote:
> > On Fri, Jan 30, 2026 at 06:00:56PM -0800, Pierrick Bouvier wrote:
> > > Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> > 
> > Performance impact?
> > 
> > the reason we have these is for performance ...
> 
> If this is a worry, we can declare the virtio LD/ST helpers in
> VirtIODevice and set them in virtio_reset(); the call chain will
> be even simpler than doing that check on every calls.

Would make them indirect calls though, no?

So I suspect the performance of this needs to be tested, anyway.

-- 
MST


