Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5554BC5AD7B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 17:41:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtTzB-0002Fb-9F; Mon, 10 Aug 2026 13:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wtTz7-0002Ci-QB
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 13:40:25 -0400
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wtTz6-0004Bp-1w
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 13:40:25 -0400
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-51c15bf5000so10109011cf.3
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 10:40:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786383623; cv=none;
 d=google.com; s=arc-20260327;
 b=YLT22ZFmB/2hyLAXc1Qw5gfq1GQcriGZBPw68+RG5Ro9OExFer/F+nqKCrouguTFvo
 8+/DPO38HFeXjmGhvejWjrzOXT1XjR4FzqUBXsl1amWTi5u6Vha9TdCy7ttO+TuJSID0
 ediaWEVgMx0E0Zx4v3Yh0GfWX5VSPU8VhO39E+9Re8YfLPh335hQNAbzwMI5z7lCiEi1
 Ei99aKtbuQDCCvwv+XdQONE2w+03t0RMIX+6U2Nigr4vynPxzgBu3TgF9W1f+URXag++
 DsRFicjQYkx2XwwDjhizOF48lmANktPedlXz7ABiCRES0+k2lxg1cs0nDh21GF/U3hDo
 ajVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4VRVcnSjXVFXdVAazlE8sSb9dzgpF3MwZeuxJIwQG7E=;
 fh=zAf9Wul48xkTrIs6bAeEfpaQhknOU2iSq1CvwgfZtyM=;
 b=j6gYbopNvw+OftrPOS2GijA8WLKm2LlDa8s+Xcpkhe1BkC37mHjT34dmWA0UI6ZsKz
 +9DEV9V0z0y9MpIu/PsmDxvfrLuGeUdwysQz5bGewWBJc5D9Gd+wfS3es8grWZOzJmPt
 rbqZMDTK2ZSRx8ggUa0Aw655fsE3oN1ivuYcigHUH9SoWd3FYWJaQG69UpLr1FX0L9wN
 K6iUIXQrUiwytjTX5bsTDod8aBfxwkSuX523QCx0oWZ3Wa9x02663RhcNvd/M+/2vNWe
 1351CstjouRuJ4KhmoFvjP4vIWSptJDNATcGv8nWYXA4M1tw5nUfq3/Bacm/iI+N3mQg
 HEOw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786383623; x=1786988423; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4VRVcnSjXVFXdVAazlE8sSb9dzgpF3MwZeuxJIwQG7E=;
 b=MZM24oeRqyfC2ILytprATfa4iwTjSDF55xlzv50qyQWIoga/tLxf4bd26QtXAjqpj+
 hkTT4ggdTeYxmysF7LIP+6ZdDZ4Vt6Q5n8jna3xxJruNI4DqeJvCDYUlvGAHfVqruaB+
 emONOj0KE4QgnFlx+edt2Z5ejgRVJJZ80zPmjvUqVj94zGYRDPHU/SAAObiexUTT8456
 70kwT1ORIUqrWS96ps8IOSolyKjZKjVShkl3mCjuIJ9EiaB9oe//lmYUwJnMf1cA6tcD
 zmDNjZHJZQVIropDt9585DvY8vzfRR+ZzYGYsjh4sLo5gVqw7m3pLo9GMW1ZspZIYwrH
 EXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786383623; x=1786988423;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4VRVcnSjXVFXdVAazlE8sSb9dzgpF3MwZeuxJIwQG7E=;
 b=bRDmgWRCrfbBQIK0ggnHZtCoreSn88tSOVkEc4rXw0PRB9w2YpkoFKU0IaXoGiNppT
 aHYBxhLh33kzNZ8wY4WMNmt5kLmvdQX0W6c3VQVc+HJNY1EmFUjlK8bWAXAJwMs7uV1m
 tSGxAAzDuUjPbe1i0NfMu1lAMUrfyE7hnulu9mO705bAWSQ42MdcutCdfh2776ln1/7R
 tOid8LI2ie2J1J3RI7SaAA8ghcNU9aCOgK3h4Whl3IWUqQp8Rc/FTZXhwxzb8usdmqw3
 5gzaxAzJzKeKHxnZO65SyyL0j25wHUijAzKSB/bYVzRFzmXhNgDIw+zEmLkyYvZaJu0N
 VIBg==
X-Gm-Message-State: AOJu0YwtAeGQ1Hjh8A22bvWM0/k4TTg9CfjdKSSqYi7bmcnA4HpuG7n3
 zHIi+v9HUYAuSI8MfnH8DP97t4lTIkZc9xPWI/DF1NBs+iuTqTRyilO51uYjngH8961LT+DsT25
 wYCSxVZQFRE97DP8rqLZ02g61r5aD9fc=
X-Gm-Gg: AR+sD12zi/1px1fHSjHsc3ba1KdBmPNWQRJG1U+bi0YE/yQESbsMHDMDfDjF9WS2C1d
 9QIuRMpRdDUf0/yXzQit/cpDjsFQdINcmU4FgyfGJ40bMUxCaUZA4t6KN416QCfmuJUna69EUW7
 Oa/ims8VPxxQk/s/MKo0UA2dfjBWLyki91m83t82T9YyckNl3aZ6GQdGJ+D5kp3XCmP7x+q+l+d
 cE3ODs9qkBgjLv2Xdc/QW086tZ1hxonFjheirIzDm1cOttldIWjrYchu3X8kWpJ4UnxKvR4Bkhd
 Kf/waZA9cLS70oHYoHMu6RETIkPVDYshfz2DmOo8EU3dNRXrE66HYo1QpNhYWqICGhzZS9Jiy1s
 PWZI=
X-Received: by 2002:a05:622a:1f0e:b0:52d:3352:f7bc with SMTP id
 d75a77b69052e-52d4c10b1e8mr49431031cf.31.1786383622642; Mon, 10 Aug 2026
 10:40:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-12-6b97c439eb28@gmail.com>
 <a0580312-28d3-4cac-82d3-20b211b7038a@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <a0580312-28d3-4cac-82d3-20b211b7038a@rsg.ci.i.u-tokyo.ac.jp>
From: Connor Kite <connorkite@gmail.com>
Date: Mon, 10 Aug 2026 10:40:11 -0700
X-Gm-Features: AUfX_mxQEGdT82tzfpSVrvBIL_n_fDSDSbqK1kIfamClOik3sgzrKM5i0N_LQ0g
Message-ID: <CA+spn3q7z8aPzLPMr1RtSzni4mM_16G=zGKytqC741iHE=dQkA@mail.gmail.com>
Subject: Re: [PATCH RFC 12/15] hw/virtio/vhost-user: send isolation regions to
 device
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Raphael Norwitz <rnorwitz@nvidia.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org, 
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Alyssa Ross <hi@alyssa.is>, Demi Marie Obenour <demiobenour@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::831;
 envelope-from=connorkite@gmail.com; helo=mail-qt1-x831.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jul 24, 2026 at 6:33=E2=80=AFAM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> > +static gboolean vhost_user_iova_tree_traverse_funct(gpointer key,
> > +                                                    gpointer value,
> > +                                                    gpointer data)
>
> It is a bit odd naming. Functions usually do not have "funct" or similar
> suffixes.
>

I was mostly trying to convey that this was getting registered as a callbac=
k
to be called on each node of the iova_tree.  For more clarity, I am renamin=
g it
vhost_user_iova_tree_fill_msg_reg.

> > +{
> > +    struct iova_tree_traversal_args *args =3D data;
> > +    struct vhost_memory_region msg_region;
> > +    VhostUserMemoryRegion region_buffer;
> > +    DMAMap *map =3D key;
> > +    args->fds[*args->fd_num] =3D args->u->iso_memory.iso_fd;
>
> This may overrun the buffer because *args->fd_num is not checked as done
> in vhost_user_fill_set_mem_table_msg() for the non-isolation case.

Got it!  I have added a check here.

...

> >       int fds[VHOST_MEMORY_BASELINE_NREGIONS];
>
> This needs one more element for vring.
>

Good catch.  Fixed!

> >       size_t fd_num =3D 0;
> >       bool do_postcopy =3D u->postcopy_listen && u->postcopy_fd.handler=
;
> > @@ -1268,6 +1328,24 @@ static int vhost_user_set_mem_table(struct vhost=
_dev *dev,
> >           msg.hdr.flags |=3D VHOST_USER_NEED_REPLY_MASK;
> >       }
> >
> > +    if (memory_isolation) {
> > +        ret =3D init_isolation_regions(dev, &msg, fds, &fd_num);
> > +        if (ret < 0) {
> > +            return ret;
> > +        }
> > +
> > +        ret =3D vhost_user_write(dev, &msg, fds, fd_num);
> > +        if (ret < 0) {
> > +            return ret;
> > +        }
> > +
> > +        if (reply_supported) {
> > +            return process_message_reply(dev, &msg);
> > +        }
> > +
> > +        return 0;
> > +    }
> > +
>
> This does not cover the postcopy path.
>
> It also allocates memory that is never sent for vq_index !=3D 0. The
> isolation regions need to be shared by all vqs. Please see
> vhost_user_write() for the context.
>
> Regards,
> Akihiko Odaki
>
> >       if (config_mem_slots) {
> >           ret =3D vhost_user_add_remove_regions(dev, &msg, reply_suppor=
ted, false);
> >           if (ret < 0) {
> >
>

I am less familiar with postcopy, but I think it might make sense to
break out support
for that into a separate patch. For now, I will return -1 in the
postcopy path if isolation
is active.

I'll need to think about how to handle devices like virtio-net and
make some changes to
this and the previous patch so that:
1. I am not allocating a new shared region for each vhost_dev
2. The shared region has enough space for the svq vrings of all devices.

