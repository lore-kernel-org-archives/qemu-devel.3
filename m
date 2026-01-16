Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 772DAD4899D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 13:06:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgjWD-0008M6-I9; Fri, 16 Jan 2026 08:05:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1vgjVK-00087J-SA
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:04:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1vgjVH-0001Mf-5k
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:04:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768568676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xCI4g++BBetoODDy0PyGDWZ/SldOs+tTH/fbdPbguSg=;
 b=gyEJsXG13/IpaFevMxMst20mrPEh9Wy1m4RZWiyEGUoGvvR3x4E8xwCBCubQIRupfEvhKd
 i3seg82hiuvXBahUurMDD4jsQZp8rQhvY8y7IQ8O8QQv9NKpKlDcITA+guSzpXrL1LWix2
 p2UMx6aYis0ihpacbh7x8xNWc3HkajE=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-8Nkn79dAPX-kId4MRT354Q-1; Fri, 16 Jan 2026 08:04:34 -0500
X-MC-Unique: 8Nkn79dAPX-kId4MRT354Q-1
X-Mimecast-MFC-AGG-ID: 8Nkn79dAPX-kId4MRT354Q_1768568673
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-6467b002cfeso3235660d50.3
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 05:04:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768568673; cv=none;
 d=google.com; s=arc-20240605;
 b=XuBnNXrYQXysWQqluWSFmxyWzz+h6KpAtM34Guu3tXW9iC1UYBddqccXVielS8HAI7
 BuEEgltpFJyJfZAFk57nsMKIKStQpif3OWIvP6kHuTKTD3284oy/xkFZskf4OYD42O6b
 HLpu7/wBgIiKlRPv2q+zlW0+Q0yc6iOOVbTWaCnCfGXyzlkSemagVfN+fvHouiqTHl2o
 jRzQt0c4/+1dpTTMgQQ8osJmctFNc3ItaF3xdu3LzizkhWd0Z/lZBMQN40PPc3K2uwGf
 thn/99Y2Z8kl0Ob+4S0vL9Jxk6vksFMrCucbiWMIBDAY0HKIpUAUelhj1hx5JAyNEFVY
 Cvlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xCI4g++BBetoODDy0PyGDWZ/SldOs+tTH/fbdPbguSg=;
 fh=SCla5qwtivMsa9WuGACYFmsiD8ZAou9vajHYlsGjyaE=;
 b=F1hUnOC2MfDhXYolMwvQnB4Bpoq5EJ4/y8qPzcMKMOgMIKjh53huY1lLn1HBZ8aErg
 mYIl9UqFYagy5QfKm3wQy5nGzqZjnc81E+9Ezv46lKZVftRnIra2uJjVIWumnsgfiME3
 34x2Djo5eB2zo4qjCMVQ0qLTUzU3gfv26WRJUCNJvJ5gCyYULJBbjRsklB5L9G7g9vjq
 1Q4HSxf6bDXhv85jP+52ILOKOx09vsb2IymQcWG6JH9H/yCrRE+V3a49IOwvJDeBaofT
 5c1GtcGzKhVrybyLo08yvgBPWKhpzwDrI+meEuC8+gvKE4LxJMlZ9nD+q0Wfm6b3Icfn
 wEiw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768568673; x=1769173473; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xCI4g++BBetoODDy0PyGDWZ/SldOs+tTH/fbdPbguSg=;
 b=og2ghUtVcUUDbHqlTkaZlpje+D5O3/qJ2xB3WlVx5XHtmq98dW2cmGsEn3NZqDGANH
 yjbpvgnSyUNUTWwV54uI1Hmkoeb3l0HKGJWM8OVZWCOksk4PRel08PDETLGruPAW19fv
 8xME0GWHDggTX5vxTwC90Ai+HnUHhclGixB/XsZoKoiCd7wrqneZbuMSddC27YWcwkO2
 vmaJkT95o0Bc7tyrLngbb6G+mHv1vqCsgRS5qE36E80i4ytaqE7NER070OpMO8KlUGqm
 fke34qi1xuHzkiwRVo3wqBmOGwERq4p8a7tcEX0Pa2Ofz2qkMKWn0RTmhXV/8krZ21yC
 5Ltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768568673; x=1769173473;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xCI4g++BBetoODDy0PyGDWZ/SldOs+tTH/fbdPbguSg=;
 b=emLjt4hHEmieSXd8CeI5boX9OSdy9TjgDzLkuQg9KnM6Bdf4TfKIeh68mDBRufCNfI
 cAFAqx7RYefW82kwe0gQW3+2cvogMkTHyP3iMm+CvNVt+vCkZaaamTwLTnMsvM4JjPQU
 1ow9jBg8iMbaGdaWAgbAxWv+akVQR/iwcIWkyPbMCttt2AvhwjRLDGXRlIb6CaAh31Zb
 5ud2/tvJdBXJ+1T24jf0/IYHnPtpLZs5MqrzQXQP0PLsZ9ZH4e1Xbj8dqK6SLp/wlCdf
 C7pK8dn5EBRLoXfm4aGyh/Z1nluMEyrL1FmnU4WwyqY+A+D4T6r5RgRCFYbQQKgWk80O
 nJbQ==
X-Gm-Message-State: AOJu0YzQ37fHt/wu2PNKw0g0+Egxz6a/mDKUy0tb4vVqH5ey8A0bC7rh
 xYU4fORGJjt5Nzpga1KccwjP49d6yUH2gxy4VsvrzwBfMPzwu8cmsEBOWqkY10bOnVJ+4+QA6TQ
 fpe6CwWPk6imhslJmiNHpSUKdpN97nSvLxNVxJFI5sjecVw1iaB6xtR0NwCUnJpaAMK4ScTgLFR
 4DwWpfiNjkI+1i9SywIL1YD2t5UFWyRIw=
X-Gm-Gg: AY/fxX7qtzWz1u3ql+Or849i2qfhv7hsCip3ZL/U2fFCKGPdWLK3wknZV8Y0uLH0WMw
 wbIgEVDRx9SR2Gz015w+gOjZ4LtW1DFNyhjZsxAw0kJsqKM9z9Zx0dp9Iq68pW5z/hVMoIabOMl
 5BJXrBOH2rs9XcWfsVotMp3tKsS9+SOdipNxJMM3zGOrRTiMKtzxRGYpwpxUPyvg==
X-Received: by 2002:a05:690e:15d7:b0:644:2e0f:4158 with SMTP id
 956f58d0204a3-6491649035emr2178684d50.25.1768568672742; 
 Fri, 16 Jan 2026 05:04:32 -0800 (PST)
X-Received: by 2002:a05:690e:15d7:b0:644:2e0f:4158 with SMTP id
 956f58d0204a3-6491649035emr2178660d50.25.1768568672236; Fri, 16 Jan 2026
 05:04:32 -0800 (PST)
MIME-Version: 1.0
References: <20251111091058.879669-1-aesteve@redhat.com>
 <20251111091058.879669-6-aesteve@redhat.com>
 <CADSE00+24EjXdRMDXXf7tgWLaH2gqeDhL_OeRbmZQ2e8JULPXA@mail.gmail.com>
 <20260116055716-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260116055716-mutt-send-email-mst@kernel.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 16 Jan 2026 14:04:20 +0100
X-Gm-Features: AZwV_Qg1JhwtgXqwbxkzcv52SsP-DhP_JiSa2P-vO2opvHwWYU3Xdqeq7XzTdeQ
Message-ID: <CADSE00+AOpy2JNPvZ_DFGR8pJ=-4iiYdb-5Mh_LAnLusjBDyQA@mail.gmail.com>
Subject: Re: [PATCH v11 5/7] vhost_user.rst: Add GET_SHMEM_CONFIG message
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, dbassey@redhat.com, manos.pitsidianakis@linaro.org, 
 slp@redhat.com, stefanha@redhat.com, Fabiano Rosas <farosas@suse.de>,
 jasowang@redhat.com, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, david@redhat.com, hi@alyssa.is,
 stevensd@chromium.org, 
 Stefano Garzarella <sgarzare@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Jan 16, 2026 at 12:15=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Fri, Jan 16, 2026 at 11:20:25AM +0100, Albert Esteve wrote:
> > On Tue, Nov 11, 2025 at 10:11=E2=80=AFAM Albert Esteve <aesteve@redhat.=
com> wrote:
> > >
> > > Add GET_SHMEM_CONFIG vhost-user frontend
> > > message to the spec documentation.
> > >
> > > Reviewed-by: Alyssa Ross <hi@alyssa.is>
> > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > > ---
> > >  docs/interop/vhost-user.rst | 39 +++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 39 insertions(+)
> > >
> > > diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rs=
t
> > > index 6c1d66d7d3..6a1ecd7f48 100644
> > > --- a/docs/interop/vhost-user.rst
> > > +++ b/docs/interop/vhost-user.rst
> > > @@ -371,6 +371,20 @@ MMAP request
> > >    - 0: Pages are mapped read-only
> > >    - 1: Pages are mapped read-write
> > >
> > > +VIRTIO Shared Memory Region configuration
> > > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > +
> > > ++-------------+---------+------------+----+--------------+
> > > +| num regions | padding | mem size 0 | .. | mem size 255 |
> > > ++-------------+---------+------------+----+--------------+
> > > +
> > > +:num regions: a 32-bit number of regions
> > > +
> > > +:padding: 32-bit
> > > +
> > > +:mem size: contains ``num regions`` 64-bit fields representing the s=
ize of each
> > > +           VIRTIO Shared Memory Region
> > > +
> >
> > When implementing this for rust-vmm, the mem size came up a bit
> > confusing. In the last patch (7/7) of this series, the implementation
> > uses `num regions` as a count for the number of valid regions (thus
> > accounting for gaps in the shmem region mapping). Thus, `mem size` has
> > this confusing statement saying that it containers `num regions`
> > fields. It should say it contains 256 fields (it is only sent once
> > during initialization, so no need to save bytes here), with only `num
> > regions` that are valid (i.e., greater than 0). Maybe it could even
> > discard the `num regions` field, and send only the full array.
> > Thoughts?
>
> Let's discuss the exact wording here.
> I'm not sure why would we need this padding sending unused fields
> though. Waste no, need not?

What about something like this:

+:mem size: an array of 256 64-bit fields representing the size of each
+          VIRTIO Shared Memory Region. ``num regions`` specifies the
+          number of valid regions (non-zero size). The array index
+          corresponds to the shared memory ID (shmid).

If you are suggesting removing the num regions+padding field, then the
description could be further simplified to:

+:mem size: an array of 256 64-bit fields representing the size of each
+          VIRTIO Shared Memory Region. The array index corresponds
+          to the shared memory ID (shmid).




>
> > As much as I wanted this series merged, this deserves a clarification.
> > So I can either send a new version of the series or split the last
> > three patches into a different series. Hopefully it only requires one
> > more version though.
> >
> >
> > >  C structure
> > >  -----------
> > >
> > > @@ -397,6 +411,7 @@ In QEMU the vhost-user message is implemented wit=
h the following struct:
> > >            VhostUserShared object;
> > >            VhostUserTransferDeviceState transfer_state;
> > >            VhostUserMMap mmap;
> > > +          VhostUserShMemConfig shmem;
> > >        };
> > >    } QEMU_PACKED VhostUserMsg;
> > >
> > > @@ -1761,6 +1776,30 @@ Front-end message types
> > >    Using this function requires prior negotiation of the
> > >    ``VHOST_USER_PROTOCOL_F_DEVICE_STATE`` feature.
> > >
> > > +``VHOST_USER_GET_SHMEM_CONFIG``
> > > +  :id: 44
> > > +  :equivalent ioctl: N/A
> > > +  :request payload: N/A
> > > +  :reply payload: ``struct VhostUserShMemConfig``
> > > +
> > > +  When the ``VHOST_USER_PROTOCOL_F_SHMEM`` protocol feature has been
> > > +  successfully negotiated, this message can be submitted by the fron=
t-end
> > > +  to gather the VIRTIO Shared Memory Region configuration. The back-=
end will
> > > +  respond with the number of VIRTIO Shared Memory Regions it require=
s, and
> > > +  each shared memory region size in an array. The shared memory IDs =
are
> > > +  represented by the array index. The information returned shall com=
ply
> > > +  with the following rules:
> > > +
> > > +  * The shared information will remain valid and unchanged for the e=
ntire
> > > +    lifetime of the connection.
> > > +
> > > +  * The Shared Memory Region size must be a multiple of the page siz=
e
> > > +    supported by mmap(2).
> > > +
> > > +  * The size may be 0 if the region is unused. This can happen when =
the
> > > +    device does not support an optional feature but does support a f=
eature
> > > +    that uses a higher shmid.
> > > +
> > >  Back-end message types
> > >  ----------------------
> > >
> > > --
> > > 2.49.0
> > >
>


