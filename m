Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A4ECD8C85
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2026 02:19:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wW360-0000G6-Di; Sat, 06 Jun 2026 22:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wW35y-0000Fv-EN
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 22:18:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wW35w-0008EY-ND
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 22:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780798714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lqcIHWZxvDW7NgjywI4aoXGnI0CBhVPXCo7wb5wJilA=;
 b=SrlPhqXd+zVZ4lFXYOsjqv9Gwq4Jx67ZhwTTYS0oJle+Mjok/ssysNXFEARquNha+lii/1
 9XcBeY6ELCZi/0AR9RGwP71RPg1yRsNXESejJw2QAgiCHTRDktbz4EoOwN+HvnIAYVZVf6
 6IvR+aGLRKVTVOh9f3fOqyVW/7iQtg8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-g0QhhhSNO2eUB6M6jJHvfw-1; Sat, 06 Jun 2026 22:18:32 -0400
X-MC-Unique: g0QhhhSNO2eUB6M6jJHvfw-1
X-Mimecast-MFC-AGG-ID: g0QhhhSNO2eUB6M6jJHvfw_1780798711
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490ae461f8dso23892935e9.1
 for <qemu-devel@nongnu.org>; Sat, 06 Jun 2026 19:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780798711; x=1781403511; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lqcIHWZxvDW7NgjywI4aoXGnI0CBhVPXCo7wb5wJilA=;
 b=XTpph+rIVv2jZrJp2m02VAk1c5CZGDFtCty+D5T/i/gCW92Eoy/tvS3CYib+yDJ31y
 UheOFro4xxSln1IWIQILLhB5Wh66bukDlvAtsXutL9KoV6Um0pVIQpXJJYf9lZp67F8N
 dH0X5lhThg1/skwVzBKrLhAJJAM9D+LvTB5121ZwDODYaEtYYe2W/rhJM4NYozAbXnbZ
 HtxLvEU+IaRv9sLXfkbwzVhmAI5w2RmoFrrYjLeYauTL+SSErtLnhYm/nWqyzu7EVk3x
 oJg/aJhAYiiFLfSIoTbPY1ncgUigeSh0kmOpyLK4bRx2xQKvYIX6oKMVYmFGj9vRbygP
 HuOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780798711; x=1781403511;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lqcIHWZxvDW7NgjywI4aoXGnI0CBhVPXCo7wb5wJilA=;
 b=FMhh6Iip2Gccv/VcNscPPT83nBNOHfRyOUmLPbenuF2xuZWUjX6eq158NtgMeXoj9f
 rMv5bVz++zRcJAdOn6Fb3wSmkTX86g2tGokHb62oikINalhlylNt+DOUKKG732BSnqKx
 S9vxQlE4e4IZFIgo8K0rJ3+E0iMBRUh5QlbEPW0VwstRMWIfKzx1OEiSET10fQ9xoUlq
 VbgRq3wTVwy6bBLlDAufnSxWC2RiqAq0Qfdl3sZBD12f/NPEd4bpIULvCKBFUU/gksaq
 Ou5GyHEafqkZfNCj/WmUCdBuqnPFTQ7SKNXoybo1WEuON5J+tZa/uXrLEVJ+kx8YVynx
 3trg==
X-Gm-Message-State: AOJu0YxCLGdaZinOos5L4DdH60DT/HT8apDUpOt8QhHDmWSDJKizw0dc
 dRBDSv1maupuGt7gyFUu8FJbqbD900qfOlX0+2bYZ2NyO7tmOG3EwT0YEupgh3QgE+laKrjDz79
 gV8xPPPyxyaTzoxthFEsH5ML6uWNDQds9xavYarjC+G66kWN32ZSv2hTn
X-Gm-Gg: Acq92OHTCfrG7lfc+5sqls4mX/1pvqaTmDxzHGsBFeWUsz1s1fmDHLJ9MTn8c3UNER9
 AIQ62By9/HKOnhecn908SyMA3wgwt9oA37GYof1BUcLiDU1Up/MkO3fWxxxKOpuzhPgX2fIb4Ff
 zkSy6C9j3IXSb7eX9Dv0Fd7GjueQzRY3EyQ7wR8/oZgc0+nQRQtqFIemu0jgEj23DYbodTg9HAD
 NiGDfLYrcXYsyg6fpCcu8Y6iyPAwdefxnFe0Vc9PYQ3jrdkbDPBplVZYMj/1ZorlwKjhMPB570T
 2DmbE7oevnijWXGyDzw+/Zpp3DVsO9WTEEO4WC8FczI7Bs2HWV3MNbIhWmvQJk96i0+AFGZo7T7
 dbUZfCK7R65mlLGTr9jxASNA=
X-Received: by 2002:a05:600c:4e55:b0:490:601f:d775 with SMTP id
 5b1f17b1804b1-490c259a232mr170767225e9.5.1780798711206; 
 Sat, 06 Jun 2026 19:18:31 -0700 (PDT)
X-Received: by 2002:a05:600c:4e55:b0:490:601f:d775 with SMTP id
 5b1f17b1804b1-490c259a232mr170766975e9.5.1780798710751; 
 Sat, 06 Jun 2026 19:18:30 -0700 (PDT)
Received: from redhat.com ([31.152.37.159]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f351d69sm69200281f8f.29.2026.06.06.19.18.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2026 19:18:29 -0700 (PDT)
Date: Sat, 6 Jun 2026 22:18:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: helei <lhestz@163.com>
Cc: qemu-devel@nongnu.org, arei.gonglei@huawei.com, zhenwei.pi@linux.dev
Subject: Re: [PATCH 0/1] hw/virtio-crypto: add akcipher keylen validation
Message-ID: <20260606102015-mutt-send-email-mst@kernel.org>
References: <20260606074756.43804-1-lhestz@163.com>
 <20260606043251-mutt-send-email-mst@kernel.org>
 <392e03eb-63e4-4db0-89d2-b7ddc32b91e8@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <392e03eb-63e4-4db0-89d2-b7ddc32b91e8@163.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sun, Jun 07, 2026 at 08:15:19AM +0800, helei wrote:
> 
> On 6/6/26 16:37, Michael S. Tsirkin wrote:
> > On Sat, Jun 06, 2026 at 03:47:55PM +0800, helei wrote:
> > > The virtio-crypto spec does not dictate a maximum length limit for
> > > asymmetric cipher (akcipher) keys. We added a hard limit which mirrors
> > > the linux kernels's internal limit for akcipher keys (see
> > > keyctl framework and the add_key syscall).
> > We have max_size - doesn't that apply?
> > backends/cryptodev-builtin.c actually sets it:
> > backends/cryptodev-builtin.c:#define CRYPTODEV_BUITLIN_MAX_REQUEST_SIZE  (1024 * 1024)
> > backends/cryptodev-builtin.c:    backend->conf.max_size = CRYPTODEV_BUITLIN_MAX_REQUEST_SIZE;
> 
> Thanks for your review!  I have verified via testing that all processing
> requests in the dataq are strictly
> 
> bounded by max_size, but session creation requests in the ctrlq are not.



well if we read the spec it's vague

  max_size is defined as "the maximum size of the variable-length parameters of data operation of
  each crypto request's content." and
  The driver SHOULD read max_size to discover the maximum size of the variable-length parameters of
  data operation of the crypto request's content


  so data operation.

  however:

  "The device MUST set max_size to show the
  maximum size of crypto request the device supports".

  seems to cover all requests?



btw vhost user sets max_size to max u64 - is that sane?

  

> > 
> > > Maybe we should update the virtio-spec and add a max_akcipher_key_len
> > > field for virtio crypto devices.
> > maybe
> > 
> > > helei (1):
> > >    hw/virtio-crypto: enforce max akcipher key length
> > > 
> > >   hw/virtio/virtio-crypto.c | 13 +++++++++++++
> > >   1 file changed, 13 insertions(+)
> > > 
> > > -- 
> > > 2.43.0


