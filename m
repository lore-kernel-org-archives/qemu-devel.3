Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EDB3FCC9AD
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 03:09:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vznTH-0006bP-86; Mon, 09 Mar 2026 23:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vznTF-0006b0-EV
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 23:09:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vznTD-0008Hq-QV
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 23:09:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773112158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KnoQS7QiZ5Q2Qb3TTW9m8qbLNW/4geYHDPRSbmWLD8I=;
 b=bDzk5mKRf/rtslaDktbCBdv0Xqn21Ux6O+1OXZpDRmQzIZgEcZ2lUwqxjEttgu6cvfewVS
 CseIeOQs4Xq/8Nd4ozjlgDNfxsdInNkTA8VnoIZNTk0xENS7o6/C41f+hrDODXP2CI6FGN
 qJH4JxUxH8Xbs8/uTQqUI0H9T36SOhk=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-HQuu_0UtM-Gu5J0t57CSAw-1; Mon, 09 Mar 2026 23:09:17 -0400
X-MC-Unique: HQuu_0UtM-Gu5J0t57CSAw-1
X-Mimecast-MFC-AGG-ID: HQuu_0UtM-Gu5J0t57CSAw_1773112156
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c709551ec08so45074151a12.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 20:09:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773112156; cv=none;
 d=google.com; s=arc-20240605;
 b=K1O4G/M/GKkMSFRW+AIh6/Wt5Av8Qc0xVDzI8ibVr1LCCx3VJrcmZdmRLgaJyn2szu
 t7HrCB4LoLHfiaUHaS5ZBWyEvybWRuxxNqDeZFWhwbXHHCz/PPlvRdfWEReNWJQrkPaU
 OnKl2n/yBBFbtm3nyF0bAjchZBkNnVuGoBtUXzJJNeb30gWXuYiXYpT3uK3NZCZzeMMD
 SNmBl9Xa6KeYcpV5wg8yxGakMMKHd18nkT+Gs8+qLSuA7/7c7H6JGLGlIm2vC9x++TaF
 2RtSoNGP87SkuD9dSrw/soiLmF4ZfNB5gq5m767S8ALwwTtADpNoljo7osOKovhAkYgd
 gGew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KnoQS7QiZ5Q2Qb3TTW9m8qbLNW/4geYHDPRSbmWLD8I=;
 fh=mF5ebmXOMKiG9ubyV1Ugn4o/IcGptD8duJpSvwI6cYk=;
 b=e5KHSDCQHuNuedsD0O+jxWGtO+as2y1Bpss7xYVbAsc3kObcEaWoCkrOGMuey7H1gB
 +i2D6Ab08Iz0gk+iMQTWYbFgxHMfA86tlRJXUh6TNzcJyIhza5xUFxQfnCtCyHJbTh6D
 qlyGSh1SUiCFSTrSS5FBPIYv/EcwFo2sounrPzIdYg6ceuMHbqE0ulrgWvu24BrK5AT5
 gIW+78LHLG4JhHACeAs7O4oYIANk4WE5zn05Z4SyqDYYt+Vy8KP6DSDLnCqhP9G3k2Aw
 k1ChTuEunH2guVs/YIUVVSs/dS9i9GIVG57fbk5ZkzGuGh/9RONEbGvHT91OABC9q/v4
 VGPw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773112156; x=1773716956; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KnoQS7QiZ5Q2Qb3TTW9m8qbLNW/4geYHDPRSbmWLD8I=;
 b=PAKIbMqXjhcIXEk0g5W1E4/yhc4NU3RTIMszmVDttUp0W7QSwgw+h50xSVppCIiMZj
 dWQvyiUVnbIlKjvlcE0Q5ds+Oa6+y3vb49wOZF192a/IL7NkcdygfPs6ykbknHjLHlEd
 lGMqyvygH/8AkYTL0tncKodIsJnyj64jidxYd3KYH7Adw5ludfu9X3zAFPugQsHjQUiw
 ASwwgtG99Xz22o62d1f94Uk+JQFpDsjzvg8ai4I/V1NxPfzW0wPaH2P0dgpL3vR50rxu
 v65zmvzfYkikLFbyUKrd79HJuZs8FcNMYw4n5G+Za6bX8TsGNCP/AzqM6yqen2t/XqYV
 uUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773112156; x=1773716956;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KnoQS7QiZ5Q2Qb3TTW9m8qbLNW/4geYHDPRSbmWLD8I=;
 b=H65sv3UKcYzZqVmzjM6NQBSqnZfU0RgUM0Gx/irLC0YsXUjAAyHw8gJZqN/krxHJIb
 F/7L1LBtx7p6iEN8DkWVbT3iAUj7CQafWCyGiPHuuQowN5IAb5rtUjek5eZeVHJfkkg3
 I2Agvb5mV6PXCJa//H8mrCqU6HJWV35MtWtDcbTaIF0qof57VMwC3z6BhW0TYngBb8N5
 bXy8NCh3NwxUUgZyntzVr+hhg8JJsTglUR4kkqzbysGtgKH03dl/ST+4HMZAy7WfUO1B
 SD8qmyb8PVKMAdFpSn6PmrZWHsPIeMVjrZg3KqgtqIvjErL+AbpoDXKPn47Agrpaa4VK
 I6NA==
X-Gm-Message-State: AOJu0YyrIrReaGO53Ybsg9Wmrzfvx37lry2tIsvEtlpLBp58HcFLaG/F
 2Izl3avmhTCEe+bmHjwSrUlhdvIKC58je9+QZ+1j0cinlXx9syIoF7qM06JSgtEcQm6cYBOh6rB
 UQCQw4UiHJyCX+teBWeJprwa9yX+YUo6A/VCel4Vmaj4rgKKqzlvuybvPsZqYCvBJVa52f4jT2t
 u47JWD/U48cJYIU1G5o9G3nNHRoaBdh9s=
X-Gm-Gg: ATEYQzx4T+uZh20kG/mN6irfBTQj4Q5T5kRRGkA+S/5YqgVHI+Fa33VyF7m7zjJmihV
 GPmKF5y9svdUXwLZCFxbc8LnQmhKg9lT1aeOahRB9DcWsZjGNMpcG9GZ2G2AHGQ3exl8RHhQNkG
 +NKj9fIQgo2pRhFWVYrUjnGQKI8P/BRhaX0deEe/9RW498SYiMRry4GzIo6KQXW3ApOcE/iKmxy
 3NDfrhK
X-Received: by 2002:a05:6a00:7495:b0:824:a4c4:3b3a with SMTP id
 d2e1a72fcca58-829a2dd2214mr9288177b3a.7.1773112156187; 
 Mon, 09 Mar 2026 20:09:16 -0700 (PDT)
X-Received: by 2002:a05:6a00:7495:b0:824:a4c4:3b3a with SMTP id
 d2e1a72fcca58-829a2dd2214mr9288163b3a.7.1773112155793; Mon, 09 Mar 2026
 20:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260304173857.2705296-1-eperezma@redhat.com>
 <CACGkMEuykEy3Rt_oEw1kGLbvh5ZRv-fW-GFU3SN7qNWcc8mi5Q@mail.gmail.com>
 <CAJaqyWfQEi6-snKd688V0CU9E=DNPXLk7z6Nzq53d45=KphFmQ@mail.gmail.com>
In-Reply-To: <CAJaqyWfQEi6-snKd688V0CU9E=DNPXLk7z6Nzq53d45=KphFmQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 10 Mar 2026 11:09:04 +0800
X-Gm-Features: AaiRm50kN6BqIVfZQI9UKb8mdqSVX5B5d11vT-guCH0pXqD05YJxauB4neyKDPY
Message-ID: <CACGkMEsZ6tK-SEZFpvAF9GZwJO54h4iJ+RO0u-wPFqfMpC0UvA@mail.gmail.com>
Subject: Re: [PATCH] net/vhost-vdpa: enable vqs before DRIVER_OK if no cvq
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>, 
 Maxime Coquelin <mcoqueli@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

On Mon, Mar 9, 2026 at 4:33=E2=80=AFPM Eugenio Perez Martin <eperezma@redha=
t.com> wrote:
>
> On Mon, Mar 9, 2026 at 9:21=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > On Thu, Mar 5, 2026 at 1:39=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@red=
hat.com> wrote:
> > >
> > > VDUSE do not forward the enable message to the userland device at the
> > > moment, leaving the dataplane disabled.  As there is no functional
> > > difference if the device have no CVQ, enable them before DRIVER_OK in
> > > that case.
> > >
> > > For devices with a control vq, keep the enabling of the dataplane aft=
er
> > > CVQ so QEMU can restore the device configuration.
> > >
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > Fixes: 6c4825476a43 ("vdpa: move vhost_vdpa_set_vring_ready to the ca=
ller")
> >
> > Once we add cvq in the future, it looks like we need to bring this back=
?
> >
>
> Do you mean when we add CVQ in VDUSE? I'd prefer to handle this as a
> patch independent from the vdpa backend, as I'm not sure if any other
> device in the wild supports the current behavior.

Yes.

>
> Considering the conversations about adding this ioctl in vhost_vdpa,
> and the patch vdpa_blk needed to restore ENABLE before DRIVER_OK, I
> prefer to view this as "Restore the original QEMU behavior from before
> introducing CVQ shadowing." This way, no device sees a breaking change
> from previous QEMU versions or even standard VirtIO. In other words,
> the behavior after merging this patch is guaranteed to be supported by
> all the devices, but we have seen that some devices do not support the
> initialization that happens in QEMU master.
>
> But yes, the main use case I'm testing is VDUSE+DPDK.

Ok.

So,

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks
>


