Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D17FC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 07:51:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZQal-0008Lf-9N; Thu, 01 Aug 2024 03:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZQak-0008Km-6v
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 03:51:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZQai-0004oL-Q7
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 03:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722498675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RVxKEV7WEUF0sZr08adUCUjTLfsu0TRQRTMdwWPMhTc=;
 b=b4E9tUrjhKk30A9FWpGsOEITQsXLDhB6IlMNzji0nAsqiLHv7frkqVEppo38qWHKOBrh2g
 kJkqcleUI7e4qKN4UlHhs94IaN9SbayrTp4kneyRvdRo+SyntuLrnHOgAhHsl+9RBkSItT
 rpiDCaDzgIcD4Ef0o27ER9L3depGn3w=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-urKYO1p3P86ILOvYFeLksA-1; Thu, 01 Aug 2024 03:51:13 -0400
X-MC-Unique: urKYO1p3P86ILOvYFeLksA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a7aa020cef5so594528266b.0
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 00:51:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722498672; x=1723103472;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RVxKEV7WEUF0sZr08adUCUjTLfsu0TRQRTMdwWPMhTc=;
 b=YifBROQFMKScf7cWWm80SRJ9jkl2ja8yJojeaXL8Dj/jZN4+UA8eP2gQveCoXPwDLS
 oCBrj5yyTPmOSEXYNHz/gfZ4G1PXp1qqbnE9aoFV+OZdQ0DW3MCxHdTUMOumOGyMnSC0
 Rn3jpI9Lt22AbY/33VX3g/dkVuHcphzduiGPo6h5o47+bCC1LNHmSHAwQVR0CLhtuEcf
 EvzhlBZUE5iSnxDPIQhlQA18dMlGuQxXHZoWi9pevKtQ/byVwwgfG92+dMQ+i/z1Z//l
 Nq2T5Xom+c/VaPqpkcnDAJHM/eUPd6fx07ZK33Fwm8cFYL+Gu643P5W2jlOtf8w/QUYS
 1q/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqhucAmMQgIJN/I8rKmn0kDi2iMKNxoau/iYQjktMGxuA2wlqYsx4ECg3EeZctLD7ZMjBQntY2pa0d@nongnu.org
X-Gm-Message-State: AOJu0YwUAFLKbCICAh+mtUX69ErCeF8fgGjolnat+cIvAab5E+e8YJzV
 WPpXsW0IwWgEjLZwl+o4qovPUGX8N4H7RWCPZhZUtw+pvhmly1KOiD2fcsz/yDItPoJ9tD+XttZ
 d4PeS5pfuRMPjEWBEqLxER0mrX4+lrKiq+GEb3zqN5vCeSCSpQR/K
X-Received: by 2002:a17:907:c78a:b0:a7a:a7b8:adb1 with SMTP id
 a640c23a62f3a-a7daf56765dmr109066766b.36.1722498671979; 
 Thu, 01 Aug 2024 00:51:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBeroLqSSobgN/AMcIAUa8q/EETKO9WC3iIGVv4G/yigto7Vs+hebqBy9wcJYKwh5B4tJJ1g==
X-Received: by 2002:a17:907:c78a:b0:a7a:a7b8:adb1 with SMTP id
 a640c23a62f3a-a7daf56765dmr109062766b.36.1722498671073; 
 Thu, 01 Aug 2024 00:51:11 -0700 (PDT)
Received: from redhat.com ([2.55.14.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab236a2sm860707866b.29.2024.08.01.00.51.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 00:51:10 -0700 (PDT)
Date: Thu, 1 Aug 2024 03:51:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Yui Washizu <yui.washidu@gmail.com>
Subject: Re: [PATCH v5 0/8] virtio-net: add support for SR-IOV emulation
Message-ID: <20240801035005-mutt-send-email-mst@kernel.org>
References: <20240715-sriov-v5-0-3f5539093ffc@daynix.com>
 <20240730073712-mutt-send-email-mst@kernel.org>
 <125b333d-36a3-49d2-84e5-76a5f9d23a48@daynix.com>
 <20240730135602-mutt-send-email-mst@kernel.org>
 <1dd86a97-f81b-41aa-b7f7-8a31fe7849b5@redhat.com>
 <4c37d308-a666-4c43-91d3-99368e643c1c@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c37d308-a666-4c43-91d3-99368e643c1c@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
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

On Thu, Aug 01, 2024 at 04:13:14PM +0900, Akihiko Odaki wrote:
> I think it is a good idea to revert these patches for now

OK I reverted the 2 patchsets. there were some bugfixes there
but I had to revert them too due to the dependency.
If appropriate, feel free to resubmit just the fixes.

-- 
MST


