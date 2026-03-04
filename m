Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9693DEDEBFD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 01:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxbTV-000065-Pl; Tue, 03 Mar 2026 20:56:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vxbTS-00005o-He
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 20:56:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vxbTQ-00054p-90
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 20:56:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772589386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MN/bomGPlk9Q5lmN+XTENVK9Nh1WH4SI2LFnUSUvshU=;
 b=a1Aj/56DWr4QGLcp7ynVwe0+gfD7GtANk5pSwxeK+Qf3uGz7NCIx+1i7BdzmpTgpSiTUI3
 bQH9EywlGz5Vb2OYzHhTx1nup1xlbe5NeHp1kiqmss3sbhZi6avSnd49lTIEjDulxPWkIM
 PP5EnZcweg7UDJQ3+hUTMA0zOCWJ5qo=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-NE6i_KadN5Wy38IPjZpK5Q-1; Tue, 03 Mar 2026 20:56:25 -0500
X-MC-Unique: NE6i_KadN5Wy38IPjZpK5Q-1
X-Mimecast-MFC-AGG-ID: NE6i_KadN5Wy38IPjZpK5Q_1772589384
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3568090851aso35760182a91.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 17:56:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772589384; cv=none;
 d=google.com; s=arc-20240605;
 b=bDCjaNE0m08M5/7vLxXWFFKv89LvtBQcgJ1gbIj6xsD84ULYhgT5PBSd0/zIUI+iYP
 0ehV6zhwMCM7SXWekEw5Jn4LLhQuAVV2u89kcA8NFK9QorpDy2zVekCXZTIyCIZgZSsJ
 oMW28yObBZt71y3fAz4VngNKmQr/vEuiNOIdleZ/IcNjEp8iO3bacIJjesXZarriIl1R
 YBJDLKuzeA21e36L9iy43j89mn4JEqbDs98UnrtGU8vngxltYlxgUsa/k7c6H9Bo7amM
 Icdt5gJat4JdPuLL4E8HhJwmPLz4nVRHJtFdPt5jeD2ojLc8qyng3IJPZXOplbIC8FCa
 eeQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MN/bomGPlk9Q5lmN+XTENVK9Nh1WH4SI2LFnUSUvshU=;
 fh=w9YMujDhlAMQIAxRfJWJnDR/KieJsaLoUKvnI0KImxE=;
 b=JmtWsDM+pqd7us+R6vLWny5S3H1pehMvDgESISMY0WfoKLlfZuwA1RO11dVA3L61NN
 gena1HOO8Jl6AT1RkyCzF+ETRGkHVSbxmGeQuptBsUB6sQb23Nlav7u/MTz4XrpG1W/a
 WCT/FFiHKLID5uwegwaZ4VPbKFwqSIAyPG/B/EEctocEoJoI7Vd6+6dsHg9THmZKXkRP
 w0ngKk0SjQMZw0jmb0Gj8L0Rv/ranSBLHhdqv82aralH1/n3pMBnO7qliTmmbYsd4bil
 GsO1KISFrfOOjfoAtbUxUaFkfG42B4uZW7dRBiTSUji28hvjAVD2GBEmfne2JpYP3lXw
 E+OQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772589384; x=1773194184; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MN/bomGPlk9Q5lmN+XTENVK9Nh1WH4SI2LFnUSUvshU=;
 b=Hc5d0cvKzgKUCX2w3AeYYqmqnZfjt5g6qMyq4Tih9E6bz7M5fEcOZkSd1/ZU1BbLZK
 Q0+t9YFKXeZDaDIjqzT+KrL2WJ5zE80Wei3en1wRRAg2NJgJlIbxw5NlYAVNDenrnsiJ
 ozJIElFmc4+rPo0rWzh+2H1DUZ2r8rDvuebBlpagUmY+5g2ext/92IYeknagGG4rZha8
 7DgtsnqaDdvTe/nbTIduMdTlz8gNP1F2cX8shGnVUHG8JzIl+7QdgC6gZYkAa4m3bVQK
 WkmfSIDhNIarsckuwhZY61jVWUjZVLufE2OL5v0n2/BbEz5zKbeYXKSB8iXYVNY9ZaQ9
 WDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772589384; x=1773194184;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MN/bomGPlk9Q5lmN+XTENVK9Nh1WH4SI2LFnUSUvshU=;
 b=DGUF/YbE3VKj3q+EHg1ZETDn1qXoi0R/GuLZPd9hWxtESVynmxhOhetuXmP6p+4bkB
 KAlaTwDb2nDIN3QPytxe4qznBPIkVGRrByfL6IKwG3g08ergWuuTyr6yVd9YlLcxorH3
 t5hjZ88qiamBHKyQtIroXFrtTCkaEBoGFCVHp1/WNcaDik1FZ+CDHqxQHyvZbCL/sIBS
 o0pwfVlx9K7E08pMR2ODOmH9I28+PHlLJgfWsteR8DWcQvlMkg399EJenk4WIfMQ40Fx
 yO4KLeYJVNFW59wE/42EmN1Ty8SBQWjcZKhWBMMbUmhmrRpSeLRh3d5xJGpdE3N8lmdm
 0M+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxM/6aQuBi/4TXgUsuVpkvprB25CtGCZlS7MUR2BjdPkmZjhXMer7ethjPzTyEx7DhIbCID6F/jL5O@nongnu.org
X-Gm-Message-State: AOJu0YwnPsS3NtiP8qOyl2T7Te0u8V1j4nO1lczistPrGXryEhjyUECd
 WfgXe0Jd5Uvzd8rYX7wBikh0K/ijob2ORLQv4Cm4nFYHqKJweTDZUF/Fz4iz06oDy3tWWWTAkg9
 JeKkmhA8aZiqUfRpX6Giay+/tdjc4bnjIyXRZAiOaL1k4hfX3iCK11wYrV01AtIQD8czMR7zpuo
 YnslvrGW2y+Qs+vj067H5CWpMH3HlvYJ8=
X-Gm-Gg: ATEYQzxGNp9sbCVPiq82trVhEa9WTPBfz2Za6BSf5ITGOfqKoBhOSFHDkF25fIPSc2L
 pwXMx1PnWP5zTyIQyJ0fH9TBZnpC1Iggc2kiXpH7S41tivffJ4jR3daUuhl5YE4q4tAt59wm8FE
 GWbb4sI1whRh+F3jezAiFKdlTWDD+yJYXg5WtBboe6pSv9ABWyagZtVsG0qYF0Di9jJE7tHI+uK
 E1zHa92
X-Received: by 2002:a17:90b:1dc9:b0:359:8c21:ef51 with SMTP id
 98e67ed59e1d1-359a69a8693mr428651a91.4.1772589383989; 
 Tue, 03 Mar 2026 17:56:23 -0800 (PST)
X-Received: by 2002:a17:90b:1dc9:b0:359:8c21:ef51 with SMTP id
 98e67ed59e1d1-359a69a8693mr428636a91.4.1772589383554; Tue, 03 Mar 2026
 17:56:23 -0800 (PST)
MIME-Version: 1.0
References: <20250616133647.1662767-1-kshk@linux.ibm.com>
 <22de010f-8fa3-4630-bc6c-e3ce8704ec04@rsg.ci.i.u-tokyo.ac.jp>
 <c133bb17-ac2c-4568-92ed-f24188a1f3ca@linux.ibm.com>
In-Reply-To: <c133bb17-ac2c-4568-92ed-f24188a1f3ca@linux.ibm.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 4 Mar 2026 09:56:12 +0800
X-Gm-Features: AaiRm52SIf41fHM-HvysO6AOSnD0WxA4BRq2Hb4WMHUES5j0g3FSQ78nNvAmy9A
Message-ID: <CACGkMEviXv95ppCB50gq7eYi7GHitg2u7JAXm3W4DqSb=bQAbg@mail.gmail.com>
Subject: Re: [PATCH v2] vdpa: Allow VDPA to work on big-endian machine
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: yin31149@gmail.com, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 qemu-devel@nongnu.org, mjrosato@linux.ibm.com, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, mst <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sat, Feb 28, 2026 at 2:10=E2=80=AFAM Konstantin Shkolnyy <kshk@linux.ibm=
.com> wrote:
>
> On 21-Jun-25 00:52, Akihiko Odaki wrote:
> > On 2025/06/16 22:36, Konstantin Shkolnyy wrote:
> >> After commit 0caed25cd171 vhost_vdpa_net_load_vlan() started seeing
> >> VIRTIO_NET_F_CTRL_VLAN flag and making 4096 calls to the kernel with
> >> VIRTIO_NET_CTRL_VLAN_ADD command. However, it forgot to convert the
> >> 16-bit VLAN IDs to LE format. On BE machine, the kernel calls failed
> >> when they saw "VLAN IDs" greater than 4095, and QEMU then said:
> >> "unable to start vhost net: 5: falling back on userspace virtio", and
> >> VDPA became disabled.
> >>
> >> Convert the VLAN ID to LE before putting it into virtio queue.
> >>
> >> Fixes: 8f7e9967484d ("vdpa: Restore vlan filtering state")
> >> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
> >> Acked-by: Jason Wang <jasowang@redhat.com>
> >> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> >
> > Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>
> Was this patch missed or there was another reason it wasn't applied?

Adding Michael.

Thanks

>


