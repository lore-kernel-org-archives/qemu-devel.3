Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 196CFC88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:55:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x52eF-00065P-Sw; Fri, 11 Sep 2026 10:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x52dO-0005vI-9J
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:53:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x52dK-0003We-CL
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:53:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789138417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bvcgeQsIUPQbhbZeMI2nmnOhp8KkVvnuFwoNwU5A/Bo=;
 b=hDbAaAn+4Yww9e8k8VP8nBcWCNeQkIWwq95obMdXqSpe1/QqS7B4O7ShoY2Wij9WWjo4f8
 EOqS5YyYWQ8OHYM7YOmXsbJrX3MXmTilBYbnqMkWtBKcylcCQoavGanuSy8ZZ/gb3aLUS1
 LdSVqTi4fJaFtsZfD+efaaRssQQRggo=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-k7zcgqI7PY-DOwLZg5b7VQ-1; Fri, 11 Sep 2026 10:53:36 -0400
X-MC-Unique: k7zcgqI7PY-DOwLZg5b7VQ-1
X-Mimecast-MFC-AGG-ID: k7zcgqI7PY-DOwLZg5b7VQ_1789138415
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2d6f75c1219so18088385ad.3
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 07:53:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789138415; cv=none;
 d=google.com; s=arc-20260327;
 b=fEAFp1FrWKN6ZzP3Q3tnnXI3mO4qt16Uq2W2i56Ffja9eaqrvHSjmxPmmBBUwCI4CP
 A9lq0rz/Q956IZKzVft18kWB0jVlXw+mt8kIkz2NPAUXxeA+iV/XzdTDUuIU4iUHmbvt
 zG7DUZB0Yb2JE3LBsRtyOeBcTvEoInLlHg9UIUfSWfGgS8IOWF9XCG12mTalX4QcHAYM
 Md9/4EGTzjj9e7rGy1rJysWmkzKgyp7PWvUVusWbMHFVs2nVx9lXoDJKXlg3iwXHhc0y
 k/ROZOD6JnVP+j2L5ajJ0ifcekwx1IZznUbIbVcVUuwSoAgLMywTx3rJqPCnUn54yTU5
 Le6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bvcgeQsIUPQbhbZeMI2nmnOhp8KkVvnuFwoNwU5A/Bo=;
 fh=BwQb1cMI4qNmHq9I+5g48bMm8xV3x5YrMI8xkywWiOs=;
 b=fcIazBvP3GHoMe9+tw6JG//Sn1sBY5BHA9NvOBChzOkk+dkNn6Kl0e3KqZE1B8JHNn
 I9x4rmxc9dthtKFUP7+/JyO4xX1oP1RTfJCJH5zvkD37ghq92cnTbS5SET8XSMapqSep
 9w471DjxghWx3HUOii+9+w/o58aeMmtV9LKVkEf6erlhAxhzRtYTcX+5X4958UgBcvYB
 Yjr8jCah0S67Ak571HbK+yBf581mKrBmPSACaAOoNcW3GstD7Yu9Z34xszrcRiI4dLA8
 sTib8UMV8GLnLlCkKTsgkQyJH0L/pYLscFETKQ0Yz3ICfMF7NHmD07Vq1Ccg7x1or9Ag
 vgdQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789138415; x=1789743215; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bvcgeQsIUPQbhbZeMI2nmnOhp8KkVvnuFwoNwU5A/Bo=;
 b=qFJV3FYx6VJMhwDsnZEpuX7Vk7RCaaetYd+8IfF+hOpTR4807OUOiLJfQkPwqZB014
 r5q2MI2K6Tzlb+i05ADL06ehIR0jxowV9tCm14as7QCfCKNCK+6mfMYEZplpCGdms2bm
 CeQ5h6ZjTJpHWrkmnh72DGLmuQ87lqD873zJLvUAjK+XFfXtjQQWzVEf9QJPyHgbqbGc
 y7aXyKvuJFLZBemBu7NSDY19v8v7L7ALP2ixXxCuvmxqJEWDkKDU329hIrgvplm8rqKH
 UOISKwZyLn7jqvoqPsKKmJkljqehgmro1Chy3uoNvzecxDxV74XVuPwHYrtXmGRA7rIC
 1J6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789138415; x=1789743215;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bvcgeQsIUPQbhbZeMI2nmnOhp8KkVvnuFwoNwU5A/Bo=;
 b=pBnJvu0b9ePluNZENhTAPwo9heyuXlUvk709NUzqNOnvrEviSiWimsoewq/KmxjEVx
 BoctepNHRmY3VHTvP3H0csEJkcQJrTpD6gi975/cKPcIf970eGc/wonHj7rC0uLRkOoz
 /jHrJW9+QUTYUpMjhX8ZJ3euRbR0P29AB8UeO56zrCR0ya6yUwABRYLzXo0HIK9osuqg
 RcYKpSEFCNNcnUcugcwZ7h0xjl0YaLVxcdAzTCNbVoAB4e8mmchP0C64E2gRz7PyyPwH
 354pra31J0P8BYMlQrpOO3M8+AFMgVyZvGK69Vxce0iidhjJ5rYbEKqGHjKzRJ91R8tx
 73TA==
X-Gm-Message-State: AFuF++niZj6oh7PWlsylVcrUGN7ioLRlwGnTCJR6lQidf8/PVSNsOH9v
 Sk/pj/ug0M1VBLA5hZua0EV6uRNkazZAvEW0WIl2yb0teFWhDfaRYfnzW5bgRpfiR74pMOEHck/
 sZjLE9oGrR3e8FESSDPd7pco853M8GOkrKLOaeOIQ05MFh02z8pt9kfzm5rbbEJ6bRNfgSvvAV9
 +6YUwKfJqhOyMTUyfgxDkxARdG9Oaee/oBAtG3Rhk=
X-Gm-Gg: AYBFou23yLE6pzVrz3CvXsFLuQg+OjvWNm9aUlS/qMAC7PFT0YJl5NFLHup7nTLd1um
 G+ZiVTHSaLx1IbHf4odq84KO135TkXLF6HGc54g+DVME3g0Wlrkp+UZ8UDZakIfCOmCUxwzhRDR
 dD+Cxla9BCWMOxdRIV1VRf47/nXN/wkN5caojlwKd/eK6JdzQFZznuOrkyxV7Ml0OI4MGXTlnaT
 W3jqoQ5RsRMrINuCsW2HbNFLuGAxFUONpjLMbfgxT+P4cvPJ7MtrpJJAobRb0u57IfcBZJdg1S8
 4A==
X-Received: by 2002:a17:90b:270c:b0:39b:a8d8:985 with SMTP id
 98e67ed59e1d1-39d9c0ad3edmr7967778a91.12.1789138414584; 
 Fri, 11 Sep 2026 07:53:34 -0700 (PDT)
X-Received: by 2002:a17:90b:270c:b0:39b:a8d8:985 with SMTP id
 98e67ed59e1d1-39d9c0ad3edmr7967727a91.12.1789138414093; Fri, 11 Sep 2026
 07:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260911140645.56094-1-marcandre.lureau@redhat.com>
 <67241f9a-395a-453d-a08e-881d7f6644dc@tls.msk.ru>
In-Reply-To: <67241f9a-395a-453d-a08e-881d7f6644dc@tls.msk.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 11 Sep 2026 18:53:22 +0400
X-Gm-Features: AcwNN1UOPjQjYQwY4hDsWqgwxXl5gHDB3Q4M-SuSGFkRW7nLfbCu5d6lhz1GUlw
Message-ID: <CAMxuvaxCdJt27XcEBO3TJEs2uuc=GcyNQXLHahCoHhbi+WWuHA@mail.gmail.com>
Subject: Re: [PATCH] virtio-gpu-virgl: guard new_blob with
 VIRGL_VERSION_MAJORS>=1
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi

On Fri, Sep 11, 2026 at 6:43=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> On 9/11/26 17:06, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > virtio_gpu_virgl_resource_new_blob() is only called from
> > virgl_cmd_resource_create_blob(), which is guarded by
> > VIRGL_VERSION_MAJOR >=3D 1.
> >
> > Fixes: d814b44636d0 ("hw/display/virtio-gpu: introduce virtio_gpu_{simp=
le,virgl}_resource_new()")
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   hw/display/virtio-gpu-virgl.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virg=
l.c
> > index 1c9380e2a6d2..f45571060fea 100644
> > --- a/hw/display/virtio-gpu-virgl.c
> > +++ b/hw/display/virtio-gpu-virgl.c
> > @@ -324,6 +324,7 @@ virtio_gpu_virgl_resource_new(uint32_t resource_id,=
 uint32_t width,
> >       return res;
> >   }
> >
> > +#if VIRGL_VERSION_MAJOR >=3D 1
> >   static struct virtio_gpu_virgl_resource *
> >   virtio_gpu_virgl_resource_new_blob(uint32_t resource_id, uint64_t blo=
b_size)
> >   {
> > @@ -335,6 +336,7 @@ virtio_gpu_virgl_resource_new_blob(uint32_t resourc=
e_id, uint64_t blob_size)
> >
> >       return res;
> >   }
> > +#endif
> >
> >   static void virgl_cmd_create_resource_2d(VirtIOGPU *g,
> >                                            struct virtio_gpu_ctrl_comma=
nd *cmd)
>
> Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
>
> What's the reason to move it into a separate function, when
> there's just one user of this code?
>

For consistency and readability, but indeed it could be folded.


