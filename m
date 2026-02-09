Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE86E78D44
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 08:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpMs9-0005pE-4a; Mon, 09 Feb 2026 03:43:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1vpMs7-0005ov-Fc
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 03:43:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1vpMs5-0000f2-N3
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 03:43:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770626632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tNvlGrYkcDQNw8R8WHuCoiNh3JnnK07gi88zskafBYs=;
 b=E5CWdj3OTfjgwFVb/Ax8xH4nGWkiKN5/aR1MGI6sAKHnDdDr/10SAJaVbrQR8WoqKKtKeS
 Z9Agq8tHOJva99aCBbjDm09sZE3pHQHoE3+UKmMR7h3gqy/OlCqwtA7Gy3G0Wg9Ok04Lx6
 Z40Lln/CuTZpHL2S8YX68yax+XDaJ90=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-Kq3JvFswNMi5lvhSftN_Kg-1; Mon, 09 Feb 2026 03:43:50 -0500
X-MC-Unique: Kq3JvFswNMi5lvhSftN_Kg-1
X-Mimecast-MFC-AGG-ID: Kq3JvFswNMi5lvhSftN_Kg_1770626630
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-64adee81de7so1298324d50.3
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 00:43:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770626630; cv=none;
 d=google.com; s=arc-20240605;
 b=f5oUcn7JRZgEAOhyhfoicwqQdPgEEE3Rau2cIXd7i2oi/h+UkLpO2o3lRrIQEbVPTM
 PDU7VOQSHavsLjGxeZUcI33aoeWFb1KGMUoAHFEFPhNOebVcmeyj15MnM32mC7Og3VQ1
 YBhnfSxEPVAj8b81LueBFT+6FR9S7VMT7OtyoKIljzCsZi+LTlVHkFrUdiXzctzD1woY
 H/omGe/5/IFeakDxfjpKz8jkyZudEjxtDr80MLvxiuOHIFM60fufpz0PRYreOdw/LkMS
 E/poWRAg1Hsa8fIXhedpCPYHBtHv8isD4nhRf0nvFAiv/2eVqOtQ9iXDG8RiXkDLZ5xM
 Rt3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tNvlGrYkcDQNw8R8WHuCoiNh3JnnK07gi88zskafBYs=;
 fh=iyEw+kLM9yg7G7ESba8bxVN13lJsr3yO06Lt+SyW2NY=;
 b=ZLE2nYSMHT+ahEOc6M1TPp99jszenPM2VmGbfarBXPUZYm95FrX1OF5Q00FGxIw6Hz
 o2LV0U1KQ3psvIVnr4fkJZCXc2of3yEMShxumTLQsjtRy6cdLlxlZhjtAwWnaWZ+CYhu
 SFT0RlLkJkLBfR1JJj3AGhV08WQzqnViFAWyWvBqTnz18qosLZ3hGDjjWbEXo2KJuSn1
 BrW/B+PLWJ9Mj3WAo8/cqMPVb5IDurxzObmNXVOpXR2KLihyaf50L9mRpJcYf9eU2QgS
 XkF1FzzTbZvT98EVlyW6+txGSXngcufYfyRM4ObhiYSGq6N6HBxPXMwDo+3QvdG0sarl
 Ynvg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770626630; x=1771231430; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tNvlGrYkcDQNw8R8WHuCoiNh3JnnK07gi88zskafBYs=;
 b=ctBykEtsgt2lUxaeTSZpVIEIV7WXe4bG1bgdv3Dt3L52mpm1FJf1Oj4RYrvqTG4jaV
 ftIBeaW7PKXQoFTP7nnWy7CQUbVbOP+yTFuqpTf3z07N4JfauwvIxsS/bXcx0Q34JuyW
 hp5jhzmZjH1v28GCHsEFNxwK5yLZ6fuQj121EhKrb94SkFmKQSSkNGVq1E4EHbm6g0RV
 3xHf2gyOvO6x14ZOb6iPMGX27aWFFFACOPr2fkMeayWEGJOIi+y45xoeMWUxloBlu9gP
 eA1bbPP4snWXJu7h8ekYf/Rkj+3HObPTid0QNMAqasVve+jEf00oo6C0ZBuXN9JGeHY/
 tIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770626630; x=1771231430;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tNvlGrYkcDQNw8R8WHuCoiNh3JnnK07gi88zskafBYs=;
 b=DGNYXKtC5xJAHUpRxZ+5vUx9nwOeYYPINy63SepssnkOkt4JpPs8aqMeLMqRdRTAKO
 OKg4mMasrsmscY40qUGIkmjD5Veo7PQ4HYTy2PzNLLzq8MVV72s+VOfizG7N8g3aSLhb
 K3wMPviNCl7SG6O3hh/OsCFZBn1/b/H2yUE0or1ic9KPXq+s/DaCLGVtryBvKXuoYmB9
 WbxcawvS/99DAOp3dfdcWzv+IEYsv6eTSrLd8S4L8VyEz59Bty03eY8ojyJITo2unRyr
 h8myzrTe8rkFm1d6xkeUsK0Nkjo4xJLUduN7ps8h3K4tE/WoInsN6VTZjnsoE5v+dK++
 teow==
X-Gm-Message-State: AOJu0YyKB2cvcxIvY4+ZPEaifLX8M0sWUZU7mlvQV4uvfl0TWdmVhtyE
 kSs0oPCSQV0y5XwMwIdJHjKjWiYlLSPpn4y3K5Nk6HmRyMm3rOYHpIOH13agDvtMLYOqZXwAx6V
 Y42c+eiQCQZHLnsppkVREPhqPEi8NibxXVJM25uXYmZY4mARjN+FsByq5XwGMwCm1MeeWNMOPA/
 Bm3Zn7vtsjfGLIYggTnybxTqhm/vfe8Bw=
X-Gm-Gg: AZuq6aJqjSKxGCFwB1Qmj1wfac3KzBE6jTgt6f+JVFsnG3bDBK/cajNmOWcNmVyNn2l
 DUSsTTsB5ETbpbbf4u38kJo+h1DvPchO+KwwPlYChHN8JKQ6qIgN5iWqx7/Uuie/a5UCGzsdF19
 ths+ulAh2gNdl7ISTdfdFyAkH7n5hdCCJpIhTfEzkS/s88akgNhzlXZ35S45AN1A==
X-Received: by 2002:a05:690e:4192:b0:64a:d1bd:8c66 with SMTP id
 956f58d0204a3-64ad1bd9117mr6103957d50.29.1770626630065; 
 Mon, 09 Feb 2026 00:43:50 -0800 (PST)
X-Received: by 2002:a05:690e:4192:b0:64a:d1bd:8c66 with SMTP id
 956f58d0204a3-64ad1bd9117mr6103949d50.29.1770626629768; Mon, 09 Feb 2026
 00:43:49 -0800 (PST)
MIME-Version: 1.0
References: <20260204093758.1250167-1-aesteve@redhat.com>
 <20260204093758.1250167-4-aesteve@redhat.com>
 <87a4xnl2gr.fsf@alyssa.is>
In-Reply-To: <87a4xnl2gr.fsf@alyssa.is>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 9 Feb 2026 09:43:38 +0100
X-Gm-Features: AZwV_QgBchQl4hTWFfstigThRlLgoHh1Ng5NVQ0mo2NHTz3zp6gt8pVPL0yfNB8
Message-ID: <CADSE00+gUyRdKpkx910Um0KtS=LkzRhrq2h4hA2irPmrZvUs=w@mail.gmail.com>
Subject: Re: [PATCH v12 5/7] vhost_user.rst: Add GET_SHMEM_CONFIG message
To: Alyssa Ross <hi@alyssa.is>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, slp@redhat.com, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, 
 manos.pitsidianakis@linaro.org, stevensd@chromium.org, dbassey@redhat.com, 
 Stefano Garzarella <sgarzare@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Xu <peterx@redhat.com>, stefanha@redhat.com, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, mst@redhat.com, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Sat, Feb 7, 2026 at 8:05=E2=80=AFPM Alyssa Ross <hi@alyssa.is> wrote:
>
> Albert Esteve <aesteve@redhat.com> writes:
>
> > Add GET_SHMEM_CONFIG vhost-user frontend
> > message to the spec documentation.
> >
> > Reviewed-by: Alyssa Ross <hi@alyssa.is>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >  docs/interop/vhost-user.rst | 41 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >
> > diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> > index 6c1d66d7d3..e314313806 100644
> > --- a/docs/interop/vhost-user.rst
> > +++ b/docs/interop/vhost-user.rst
> > @@ -371,6 +371,22 @@ MMAP request
> >    - 0: Pages are mapped read-only
> >    - 1: Pages are mapped read-write
> >
> > +VIRTIO Shared Memory Region configuration
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > ++-------------+---------+------------+----+--------------+
> > +| num regions | padding | mem size 0 | .. | mem size 255 |
> > ++-------------+---------+------------+----+--------------+
> > +
> > +:num regions: a 32-bit number of regions
> > +
> > +:padding: 32-bit
> > +
> > +:mem size: an array of 256 64-bit fields representing the size of each
> > +           VIRTIO Shared Memory Region. ``num regions`` specifies the
> > +           number of valid regions (non-zero size). The array index
> > +           corresponds to the shared memory ID (shmid).
> > +
> >  C structure
> >  -----------
> >
> > @@ -397,6 +413,7 @@ In QEMU the vhost-user message is implemented with =
the following struct:
> >            VhostUserShared object;
> >            VhostUserTransferDeviceState transfer_state;
> >            VhostUserMMap mmap;
> > +          VhostUserShMemConfig shmem;
> >        };
> >    } QEMU_PACKED VhostUserMsg;
> >
> > @@ -1761,6 +1778,30 @@ Front-end message types
> >    Using this function requires prior negotiation of the
> >    ``VHOST_USER_PROTOCOL_F_DEVICE_STATE`` feature.
> >
> > +``VHOST_USER_GET_SHMEM_CONFIG``
> > +  :id: 44
> > +  :equivalent ioctl: N/A
> > +  :request payload: N/A
> > +  :reply payload: ``struct VhostUserShMemConfig``
> > +
> > +  When the ``VHOST_USER_PROTOCOL_F_SHMEM`` protocol feature has been
> > +  successfully negotiated, this message can be submitted by the front-=
end
> > +  to gather the VIRTIO Shared Memory Region configuration. The back-en=
d will
> > +  respond with the number of VIRTIO Shared Memory Regions it requires,=
 and
> > +  each shared memory region size in an array. The shared memory IDs ar=
e
> > +  represented by the array index. The information returned shall compl=
y
> > +  with the following rules:
> > +
> > +  * The shared information will remain valid and unchanged for the ent=
ire
> > +    lifetime of the connection.
> > +
> > +  * The Shared Memory Region size must be a multiple of the page size
> > +    supported by mmap(2).
> > +
> > +  * The size may be 0 if the region is unused. This can happen when th=
e
> > +    device does not support an optional feature but does support a fea=
ture
> > +    that uses a higher shmid.
>
> This is still phrased as if unused regions after the last used one can
> be ommitted.  If 256 sizes are always sent, then size must be 0 for all
> unused regions.

Had to read it a couple of times to see what you meant. But yeah, it
implies that a zero is always followed by some valid region and is not
always the case. I guess I can keep only the first sentence and delete
the rest.


