Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED76EDE99D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 15:28:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so2mv-00070Z-MH; Tue, 10 Sep 2024 11:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1so2mq-0006y0-6u
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 11:28:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1so2mn-00076y-Dd
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 11:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725982087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vvgdt0fB207eo3ZYcL0jmJr61BCKKD6jsD9HMLzjKPw=;
 b=bW9odvIusoKnWW006tIre5fxLKzKxpa48Vn+JprNFGeBYnGAiZuu2MYborLcrxY5+KBMD0
 2hyQaX9OutNI2WAU++KBxHX+pTjI5tSdwoFgqTJ4tWh26AdUTfdFsDns+D+VXMrVvwubP1
 +1rr3E3EYkkTESo4ax+u54BYvZeRIvY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-KLUey77JOumV35TDy8VzMg-1; Tue, 10 Sep 2024 11:28:03 -0400
X-MC-Unique: KLUey77JOumV35TDy8VzMg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-374cd315c68so3388981f8f.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 08:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725982082; x=1726586882;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vvgdt0fB207eo3ZYcL0jmJr61BCKKD6jsD9HMLzjKPw=;
 b=hbmvmew+dT8gXGCIWz6t9v2oXUs72xldr6kGxZYNCUzo3PzTdH90tQ8hiJ/4Nomrk1
 p4rtEXDy0z9MjF4hDYHe2sFxdfX0eVCG87ebi0N2qMnSsRIT/BLPFqj2N69w1K7ZCi6n
 qQgYR03S4LkCGk6nyQ320mJQNgVtEp8ZEjSFzDfbjT7fTB3VYFEe3EqvDhX8vD1uY1tj
 QY4tx3uMtpPRZ2VLd8FKJ/Xi8UKQxmGfmi0QkWyhpi3EbycwGRwIQiuS4gwKeZjmuMzP
 w8qM9EMFP03ZkLIlPijHGfoecEIbUleHeiNb8EuKteaUjoxxNkGz15p6E3oCQk8s0NQx
 chDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOlRKaeOE3kG0XreN5MKAmBc/k1PGZN+4HXNgIURpByxH6SOjcEAooA1jfh5QBN79Md8tCdOeP78Sw@nongnu.org
X-Gm-Message-State: AOJu0YydWeSlSRSqzIErggfN2VaR33Tt+W/fERkosIVuS/avXh7YT2ls
 NYji4hLvjjl4whiZqvJYD2EHpqSb7Pff3A2rsIbu6A4DN/9eOJzWTLvJhcabgvFmDaKm8KvCYJE
 olHvuvsOL6/sfY2pPxmDiw4n8BzEGrkZmS7ygePg983/uW2IbAEq5
X-Received: by 2002:a5d:4983:0:b0:374:ca16:e09b with SMTP id
 ffacd0b85a97d-378949ef74bmr7246432f8f.9.1725982082405; 
 Tue, 10 Sep 2024 08:28:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrySL3VenIjBd8pktR/7UnoOp6vzvJ4MD8jcmW1SMvv5d5BYhJmr3epbPM3brXPaf8q4xOxw==
X-Received: by 2002:a5d:4983:0:b0:374:ca16:e09b with SMTP id
 ffacd0b85a97d-378949ef74bmr7246401f8f.9.1725982081742; 
 Tue, 10 Sep 2024 08:28:01 -0700 (PDT)
Received: from redhat.com ([31.187.78.63]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42cac8543dbsm125556015e9.42.2024.09.10.08.27.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 08:28:01 -0700 (PDT)
Date: Tue, 10 Sep 2024 11:27:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Subject: Re: [PATCH for-9.2 v15 00/11] hw/pci: SR-IOV related fixes and
 improvements
Message-ID: <20240910112723-mutt-send-email-mst@kernel.org>
References: <20240823-reuse-v15-0-eddcb960e289@daynix.com>
 <20240910052046-mutt-send-email-mst@kernel.org>
 <08975798-2484-4aac-a032-5ab8a6475bde@daynix.com>
 <4adc32d0-02c1-4375-8618-2692a9b1da76@redhat.com>
 <20240910093440-mutt-send-email-mst@kernel.org>
 <6aeaa38c-22b9-4598-b07e-7adaee187562@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6aeaa38c-22b9-4598-b07e-7adaee187562@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Sep 10, 2024 at 04:13:14PM +0200, Cédric Le Goater wrote:
> On 9/10/24 15:34, Michael S. Tsirkin wrote:
> > On Tue, Sep 10, 2024 at 03:21:54PM +0200, Cédric Le Goater wrote:
> > > On 9/10/24 11:33, Akihiko Odaki wrote:
> > > > On 2024/09/10 18:21, Michael S. Tsirkin wrote:
> > > > > On Fri, Aug 23, 2024 at 02:00:37PM +0900, Akihiko Odaki wrote:
> > > > > > Supersedes: <20240714-rombar-v2-0-af1504ef55de@daynix.com>
> > > > > > ("[PATCH v2 0/4] hw/pci: Convert rom_bar into OnOffAuto")
> > > > > > 
> > > > > > I submitted a RFC series[1] to add support for SR-IOV emulation to
> > > > > > virtio-net-pci. During the development of the series, I fixed some
> > > > > > trivial bugs and made improvements that I think are independently
> > > > > > useful. This series extracts those fixes and improvements from the RFC
> > > > > > series.
> > > > > > 
> > > > > > [1]: https://patchew.org/QEMU/20231210-sriov-v2-0-b959e8a6dfaf@daynix.com/
> > > > > > 
> > > > > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > > > 
> > > > > I don't think Cédric's issues have been addressed, am I wrong?
> > > > > Cédric, what is your take?
> > > > 
> > > > I put the URI to Cédric's report here:
> > > > https://lore.kernel.org/r/75cbc7d9-b48e-4235-85cf-49dacf3c7483@redhat.com
> > > > 
> > > > This issue was dealt with patch "s390x/pci: Check for multifunction after device realization". I found that s390x on QEMU does not support multifunction and SR-IOV devices accidentally circumvent this restriction, which means igb was never supposed to work with s390x. The patch prevents adding SR-IOV devices to s390x to ensure the restriction is properly enforced.
> > > 
> > > yes, indeed and it seems to fix :
> > > 
> > >    6069bcdeacee ("s390x/pci: Move some hotplug checks to the pre_plug handler")
> > > 
> > > I will update patch 4.
> > > 
> > > 
> > > Thanks,
> > > 
> > > C.
> > > 
> > > 
> > > That said, the igb device worked perfectly fine under the s390x machine.
> > 
> > And it works for you after this patchset, yes?
> 
> ah no, IGB is not an available device for the s390x machine anymore :
> 
>   qemu-system-s390x: -device igb,netdev=net1,mac=C0:FF:EE:00:00:13: multifunction not supported in s390


So patch 4 didn't relly help.


> This is what commit 57da367b9ec4 ("s390x/pci: forbid multifunction
> pci device") initially required (and later broken by 6069bcdeacee).
> So I guess we are fine with the expected behavior.
> 
> Thanks,
> 
> C.

Better to fix than to guess if there are users, I think.

-- 
MST


