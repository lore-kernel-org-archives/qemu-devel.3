Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB44AC3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 05:53:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZOkA-0008WM-D0; Thu, 01 Aug 2024 01:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZOk5-0008V8-Gc
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 01:52:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZOjt-0006KT-Pu
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 01:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722491557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5Nm31RPSK+Bjd6HLJSpA7+S2nH8/hROTP9M4MPPzbfs=;
 b=FAVieZ/cqP+ugmW/byS29bWSqBzUxDkmyKTkGCskV5u9bR9P88i9Pvm2SvtVDtTCMg1lAO
 g/aQk1TJ1ZQyHbyDAN+vFXI3kn1RcpAoA3FueDBnGgrHeQ6rpQjMUWCRW4zjLNdP6p4uBq
 f97KMzkAyCrtXMm9I9qvCuGjicxlM7M=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-s9x8uYliOwK97RBojUkl5Q-1; Thu, 01 Aug 2024 01:52:35 -0400
X-MC-Unique: s9x8uYliOwK97RBojUkl5Q-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-52ebdbf8a7cso5132373e87.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 22:52:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722491553; x=1723096353;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Nm31RPSK+Bjd6HLJSpA7+S2nH8/hROTP9M4MPPzbfs=;
 b=LKqKpAhcxe6Ul4e2lCiH76mrk2UsKjZ80fm/fpsiuzKj82kfBD+4TKgYqa2Uj4zL2b
 IKoI0VdkoI5xqZLspQizsZDYWutjoxgHyGw52D6H2hFFOxQtENTrUyryPDLlIIYqdK4A
 uzXtAxojjJnXiDuca7H5jPJaVMvRF2HglMKRH0klOO0oio/EE8Y5MWrBnl4LwYEkAfpY
 iAOKJhpKLiDKRzaRidmzPu+KMRWWouOrHNYTiwAd0h+p0Y+GR/DeMi8iSOsZ2wJfnqCO
 wqslCTR1qUpOW7/lsQyAcV63jHlxRtYVxs/DZjdP3jzeAMbYlatgtSNo76lDON/ssynx
 MI0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8V0zxFb381kAYB4PKqL2aGROvPFBMDNnXZg37kKrLhu113JoaTxU2ZlQBelu5pQsdgAZ5FZuRzsNl4gqRMVsNYfiFV6k=
X-Gm-Message-State: AOJu0Yxxq3Z0j86P0RUn/V2Zk4BNViCnHpRbG1w6vRX01qF30cPwj+ET
 rT6FSqtk1SBOYelZubvD/AEK157sR9HU7+7J7PjQOQehKTEgRzSkMZapyDGp3IA3XxqFx6taAln
 l5lJLrAVb/exbcvxToBy3TYZ4vm6GAgO16Ka6oyHWZr2JhKFPTv1g
X-Received: by 2002:ac2:5ece:0:b0:52e:9ecd:3465 with SMTP id
 2adb3069b0e04-530b61fec40mr577436e87.57.1722491553434; 
 Wed, 31 Jul 2024 22:52:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFx5ishaKK9P9uoRqmmlquo0UWePzPqBkLb99ylu2LQeD4HBb2myM05YxKoiRmroZfLKbgyGg==
X-Received: by 2002:ac2:5ece:0:b0:52e:9ecd:3465 with SMTP id
 2adb3069b0e04-530b61fec40mr577411e87.57.1722491552610; 
 Wed, 31 Jul 2024 22:52:32 -0700 (PDT)
Received: from redhat.com ([2.55.44.248]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac65389085sm9470156a12.80.2024.07.31.22.52.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 22:52:31 -0700 (PDT)
Date: Thu, 1 Aug 2024 01:52:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Yui Washizu <yui.washidu@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH RFC v4 0/7] virtio-net: add support for SR-IOV emulation
Message-ID: <20240801015130-mutt-send-email-mst@kernel.org>
References: <20240428-sriov-v4-0-ac8ac6212982@daynix.com>
 <966b756c-f4b9-40da-ad35-ddb7c6e7da50@gmail.com>
 <88ffcfa0-f3c4-406c-ac79-456b0f8b38bd@daynix.com>
 <90cef42c-dbb5-44fd-9b20-fe0996c9974b@gmail.com>
 <36c4c10b-0b5c-44ad-978f-29ba5162ef2b@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36c4c10b-0b5c-44ad-978f-29ba5162ef2b@daynix.com>
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

On Thu, Aug 01, 2024 at 02:37:55PM +0900, Akihiko Odaki wrote:
> I don't know much about vDPA-capable device, but as a reference, igb only
> has 8 VFs.

modern vdpa capable devices have much more than 8 VFs, 8 is a very low
number.

-- 
MST


