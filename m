Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0312C531CC
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 08:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnuAb-0001mN-6G; Sun, 26 Jul 2026 04:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wnuAZ-0001lo-U1
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 04:25:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wnuAX-0000Dh-MI
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 04:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785054307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=59Uybs0g6O/CDfAjukMQvmYRMAOMU/3wHIKQ8fqpR7U=;
 b=S0C7D8h84Vlyq+10ZEhze9pMJvEuYqU31gN2eoItpnt6SWtco9BvtASS7+oDJnDgPskdTD
 +tRkRfVfSZC3vxNu+FU4DrfSPFObHub7DjbbNDZS+jc7fYa4uvwiLymColqHFPRzUHwYeP
 Bm4mMt9Q4wkIZ5mFsijvajxp+CKV5FQ=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-r7gL70pWP4iZIBhCSsK_Gw-1; Sun, 26 Jul 2026 04:25:05 -0400
X-MC-Unique: r7gL70pWP4iZIBhCSsK_Gw-1
X-Mimecast-MFC-AGG-ID: r7gL70pWP4iZIBhCSsK_Gw_1785054304
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cca3673560so32112265ad.1
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 01:25:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785054304; cv=none;
 d=google.com; s=arc-20260327;
 b=jvvO1AMA4iejtKUllT0WRNlxNiZTP8Je1VpCCJuem6DQmkgZNDrYYPkeUfRLBVpVoV
 20m79Q7ov3HrBHhTdAtqdedmOzIqZxhwAQ3+5x5HnEeJvbsBx0uwVTAySPzfX2Kl1ATE
 J8kF2gyN1hEuQJa86lFB3CocTne4MCIMNIDn+w+u/80VpmnjjBGHw09IzT+OpGPbAr2I
 CFNeS1QydwQaK1ITQ+GlrsSSEhRjdhZHIU9bR01zkteX0/zNK9F8NmiALdwF5JD7Xdfj
 DtGPt/utnZ3yoJlpm1tnaAm3rksj6ZAQl6MV4UB+nNa/op8KVcMuqwebF8YTHQ64KooM
 XWbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=59Uybs0g6O/CDfAjukMQvmYRMAOMU/3wHIKQ8fqpR7U=;
 fh=odcGUGGhxK45HNuOmghblDVi8aACbtIGjUKVKZXP2tw=;
 b=Youa77WsdtCVVWrePfIp5fNb0I00nptyucntHpGVeLbu3tMRbcQwdkcPMpcfCc6OZ6
 wvJSYJtpH/RgVILudGSpK0YLFaPR8GzylT6LdUYGCdCh8c3kmQFYsIeoFSAfGB6nNt/y
 jgzMOoDjgqm+wLAdzkDGdss7CDL/Q5q0mP/LG4XlHRq/3pAJwiWgwjLlxzpBdakvMKEQ
 6g6vfWQ8hCXBdPrJ6Rgb1juqM+fzJhpwCd/vDxsdzDxccgb1OteJ198vz2Z5zoh964NJ
 y3Jm4Z5VT3ZA13UQtfwZO9Z/k9AYvopZPbaslunlNrGJJAeRYMwWncZU7qGf16bswStS
 +tww==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785054304; x=1785659104; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=59Uybs0g6O/CDfAjukMQvmYRMAOMU/3wHIKQ8fqpR7U=;
 b=NBSaowMZhoqxiJkGFv1FlnAC6j3CR+Rg6baTy+7/aTaA65obRhj191RbeV/9WV54ae
 TwLUiae859UbxaOebTiJyrVa833oBLaGoBfeTSS08TkKYN1w+GlvMo9v1QH4Dj1Qaowg
 Ou5aOQUR8C54lgzZFbohHgUmZ9UXbGQhAsB5orDEkpUaeW/PHGwUkUA2/5q5S7I8UScj
 aK1Q+Zv7em+numBMI8C5nKo+0QI157DHmqvHnoU9o3qYEcae75cQFrbdIu8NujbLNP1A
 xpkOdq96Wb+ILd+kDL6VK6yHqiDQIaMC1J1mmbeVifyaq/QTSqZSaFL4YzUNZYbbA0Xl
 z9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785054304; x=1785659104;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=59Uybs0g6O/CDfAjukMQvmYRMAOMU/3wHIKQ8fqpR7U=;
 b=qQoP+6qfCm9Yqb21j5UUtJ9yV9skiZFObWmAEAQ4sYGihH2JacMa4jFVUlzVwdAiPc
 4yq7mAxidCCBh6lUO7kiecUeslATbwRk4h0KJmNGgU/Z1WPzLXlWMizcnjVo4D23suWg
 Hd7oacYWOAX3PdNisNfzSOwLUBpH91N7lES+wKf9yoOJJ7kA4E0rmu/vZcB6rhYglLoO
 ESKBusX6letCVFl/1Ix9+WnxKhadTpe3Sq2Pmh1ngbPdewjWumBhW5MJUoZ/q7q9vDWd
 SHBIyA6wWmlM7gko45GXxZhKBbMjB66VG9EhXPgZzw0Pv9F7SYnezd68V/rD6tXHjJCd
 GKkg==
X-Gm-Message-State: AOJu0Yzhs/BOc1I4TRRaid67Nwbs+CgStb43RUYw3nDigvYeEJTlYvYC
 NvO17nC3U6nLS4R4Z/BBgFWlpwcjl/QzyFmkh9EnXLt8ebZHpkPwOlPL7HLWcI/yb0NFg5mySS6
 0sfvnELH8KeVPm8XppNr+l20hOWp6Z/HWPmeklHcy378pbNpqAY6Wbl/6s1nmoZxSJG6Ovx44WK
 hHLHtLlrLK/1Ms6IBtlsO5dafBb2j6Jsw=
X-Gm-Gg: AR+sD10uaIqpuRfh134sDVlT3MVOYdS/egVSUkkQPLvL1RRo5PXiBr0s+fccfv+3Jom
 mcUbLaHenBqky8So5UVqKRJ46d1bFIBnVcUfDM51+RODej9NWUbQ1kFDIJKI3iydYCIl9JKz/Y1
 uuZpDWhcicVflza4tbI+prbGG3nOguViVsEycuzm4OQL33ENnYqNTDhtzri1kCpb9tVDScf09lf
 t6kMY34nf36eULjT/QhL9tQFooLyefVI/FF5ql/Gg2hDokg0W6GxmAaPhroGhgXbemslxtHRQx1
 fQ==
X-Received: by 2002:a17:903:2f4d:b0:2cb:3f5b:6663 with SMTP id
 d9443c01a7336-2cfde78b5ecmr43282335ad.11.1785054304159; 
 Sun, 26 Jul 2026 01:25:04 -0700 (PDT)
X-Received: by 2002:a17:903:2f4d:b0:2cb:3f5b:6663 with SMTP id
 d9443c01a7336-2cfde78b5ecmr43282045ad.11.1785054303714; Sun, 26 Jul 2026
 01:25:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260725-fix2-v1-0-5c9a6ce7b96a@redhat.com>
 <20260725-fix2-v1-1-5c9a6ce7b96a@redhat.com>
 <d6876e8f-1414-4e7d-b6e2-1b59a18e8288@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <d6876e8f-1414-4e7d-b6e2-1b59a18e8288@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sun, 26 Jul 2026 12:24:52 +0400
X-Gm-Features: AUfX_mxsuLpmI5MChTjzmAUkWas6IA0ZKyKEPoJZBwiBSb22LoL6dZfqqD3Ui-U
Message-ID: <CAMxuvawR=TiF4r+wdVCDF3Hyu-ND9neFHjUEZn5_YnSbxweXhg@mail.gmail.com>
Subject: Re: [PATCH 1/7] hw/display/virtio-gpu-rutabaga: zero-init capset info
 response
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 "P. Berrange, Daniel" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, 
 Jonathan Cameron <jic23@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, 
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>,
 linux-cxl@vger.kernel.org, Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Haotian Jiang <jianghaotian.sunday@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Hi

On Sun, Jul 26, 2026 at 11:33=E2=80=AFAM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2026/07/25 23:00, Marc-Andr=C3=A9 Lureau wrote:
> > rutabaga_cmd_get_capset_info() only fills in capset_id,
> > capset_max_version and capset_max_size before sending the response to
> > the guest. The remaining fields of struct virtio_gpu_resp_capset_info,
> > including hdr.fence_id, hdr.ctx_id and hdr.ring_idx, are left with
> > stack garbage and leaked to the guest, including host pointers useful
> > for an ASLR bypass.
> >
> > Zero the response first, matching virgl_cmd_get_capset_info().
> >
> > Not a real risk thanks to -ftrivial-auto-var-init=3Dzero.
>
> GCC only added -ftrivial-auto-var-init=3Dzero in GCC 12, while QEMU still
> supports GCC 10.4/11.
>

Good point, may be we should update:
https://patchew.org/QEMU/20260723094622.1515831-1-berrange@redhat.com/

ack otherwise?

> Regards,
> Akihiko Odaki
>
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3609
> > Fixes: 1dcc6adbc168 ("gfxstream + rutabaga: add initial support for gfx=
stream")
> > Reported-by: Haotian Jiang <jianghaotian.sunday@gmail.com>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   hw/display/virtio-gpu-rutabaga.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-r=
utabaga.c
> > index 4d7d7b245929..95a19eed7eda 100644
> > --- a/hw/display/virtio-gpu-rutabaga.c
> > +++ b/hw/display/virtio-gpu-rutabaga.c
> > @@ -555,6 +555,8 @@ rutabaga_cmd_get_capset_info(VirtIOGPU *g, struct v=
irtio_gpu_ctrl_command *cmd)
> >
> >       VIRTIO_GPU_FILL_CMD(info);
> >
> > +    memset(&resp, 0, sizeof(resp));
> > +
> >       result =3D rutabaga_get_capset_info(vr->rutabaga, info.capset_ind=
ex,
> >                                         &resp.capset_id, &resp.capset_m=
ax_version,
> >                                         &resp.capset_max_size);
> >
>


