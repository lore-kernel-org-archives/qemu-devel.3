Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2011CA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 18:03:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBFhI-0005Ka-3f; Mon, 28 Sep 2026 14:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBFhG-0005Ji-5g
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 14:03:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBFhD-0003Eh-Sb
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 14:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790618601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9TzD4m1GIGiouclgWcKPaYiHi2p8wNNNIrF3GoB1awo=;
 b=TXI6XiZh+EC0qnDRgQYaS+x0qVsRUo2HOTmjgSjA5alO6Vq+oOCk/1TNlgc6EABRuCjKiy
 HjbQaaNW2f852M8U2FH0Fi/35jUfiz8opi0D4UIH4w73dL03b1/k+9MfTu42vCPVvXYM42
 VN8wB13X6NhphasUICBPH6/X/guLUcs=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-JrAifxZPNziu4iVAi0W0uA-1; Mon, 28 Sep 2026 14:03:20 -0400
X-MC-Unique: JrAifxZPNziu4iVAi0W0uA-1
X-Mimecast-MFC-AGG-ID: JrAifxZPNziu4iVAi0W0uA_1790618600
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-895241d7405so50718527b3.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 11:03:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790618600; cv=none;
 d=google.com; s=arc-20260327;
 b=JcTQcDCr/tIAHD5ILOed1Ag2mb7uEfz+yPqPX4VrfttxVUDXcmTZNJtivHD+7EZcty
 cZ8vZgs9SKG84lsQS83G/H0OCvoyY+F86d/jaXYTgJCocysqHt8NbTHMI3xbS5BYQQTL
 6jCQz7Nbumt0hz6pc0BQYiYyxwaGcERuIrg8sIY7qoBK5Q7DHBTjYISPue7cJcjI5FgS
 heAFHAoFLWJZBOo0TpmJOa38kuxoNnCTu6bdxZFrJvj4nmdZkmXSPz07Ln0sshWyxEcL
 B3xD6gcYsl/vEKWgOgFg0yLzRjay0wJ194DbQq+AmmYgscwsoOUtcc7Lid1gM8ZvaTJj
 vAtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9TzD4m1GIGiouclgWcKPaYiHi2p8wNNNIrF3GoB1awo=;
 fh=VX+jQhbKE203JT7GlTHPkMrp32AwbTQQc3wjLY5/O1w=;
 b=pmrxzVxg/XUwxNgYLjRA/8ft9znzVohREQL/AmeJMOHWoXdWjmMpUWF9qvx3sQ+RDG
 IovlAtDsq0oG9uyX4qQe5OvvU9Fcyiaw8lEG0vICABPZd9fv4PW7pQhlK8eJ4mcJXRe9
 5RA6eOYkAQSknhUJsWDAKNX7om33PkavIVP7jrfcKeVHeXHdHtmkv00S/D6uGCNPuWi9
 DkVZcWRYbCw0jdBgPl4MZlV4TPg5NsqmGpncvBo/VVNTMGMmOXS2upNN2BgOyPGmzL7T
 KVVDjx54J1aevswlG8giJwIV/Y/xFABueNAdf4Ut6KWVMHpTj662/3JJEyHzwSR3FDEJ
 0LDw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790618600; x=1791223400; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9TzD4m1GIGiouclgWcKPaYiHi2p8wNNNIrF3GoB1awo=;
 b=nGpH/dqud794p5E2rCeO7yvZQ8FkznU4KU8PtWikparzSobdfTBZ/xPa+u/FF4rWjx
 XN9NHjxYhFC9t9reMRX1pzotwaoO4mxUNr8uHJ3v3oCdMHjKQVqYNQAy3oFygNOcqMgz
 C0HFU7OSHIFRrjbDJFMnP8YwRxaAiP9zdic/pmW/e4bjb3hNi2iqiBVA10ZV8MRuuOf8
 T8KPOv2rP+4m0XvlmeEcgv7ZEQo5bEUymYJa5dqw9w4q4PSSAVatM/LidxjPCT0s2PtY
 uDsHKFwo6Wp7O/X5OQ5+7HVLVMKyzhakGaDA96BiRhdatIhpekrUvqlYC4tOIF1X9X9x
 oU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790618600; x=1791223400;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9TzD4m1GIGiouclgWcKPaYiHi2p8wNNNIrF3GoB1awo=;
 b=iDXcM182Ibr+lLxFLu9fr+Ve769Q8/MaGYjXLrPsjeJPuVwL+K659NK0BHOXDp6Bgz
 yN+IVFQmYQeSzSZXHlJ3K0sB32CeCWbIPHTTfD85IhTGbXpHiRdH2hrcENWLxtw1Ea4o
 JHMq8mYxm+eWYQzXJryLe+OSTkiRF1aNIDaKE88jZ/C7iSWwcADUgKcMS6XUH9BPjn1P
 25hZQlXQ0Xb9aYODKyEOUj7kkuP8Uw71KtQ3sXyydJqvuN7CGJczvdN9LKlcmBMVy6c4
 HQqGMBzb3wC3qimkzfNpqznAsRKdBP5UHOkmQOh+zyLvN4BJ4dpM9E1Fy2rAnsiA3jQK
 CtpA==
X-Gm-Message-State: AFq9FYKNcUMF+i/2ZEFU8euTu784PCAKvHQiW8VFNoD02aIR+XCtMiLe
 6NCCwlcxa3zgt1CrmSJNtY402CEs6P12q08WhOFiskNe8HEEnRZpf5hTR5AJMk2QM4PAypitjir
 JOEQZdkD8bgKAVRs9VytW/op4qlFqGgvH+VU4pNU7I7S/YC0FiJkyeWWNZOKGs2HZuZ8q5tIv3b
 g3htD2d3P0cLkg4QQLBPaVvvpN+kGdSUY=
X-Gm-Gg: AYBFou0IPr7+McRlPbJU4HVMoUZEERXAPWogD6/eDhtP3Oc6nj5B8Rldt1CqWq7zKp3
 WuDCVRtQZ6VSfQ7U69P2D7MCiRj2HIRRfKbw/UcmJCE83SlxtYC7nGlbycU+czLi8PhtT5wZcQk
 TlQ3mNfGFM3vLGPOVtPyXnwr1cKeJwewI4i0Nf2yFhlC9FS9jPszomv6Rrysaax0U7HYdIupbdr
 PobW4Zsu8U6ynOi
X-Received: by 2002:a05:690e:1094:10b0:671:7e90:70f7 with SMTP id
 956f58d0204a3-672ed343c1amr4251819d50.53.1790618599850; 
 Mon, 28 Sep 2026 11:03:19 -0700 (PDT)
X-Received: by 2002:a05:690e:1094:10b0:671:7e90:70f7 with SMTP id
 956f58d0204a3-672ed343c1amr4251787d50.53.1790618599297; Mon, 28 Sep 2026
 11:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260928063231.2158073-1-armbru@redhat.com>
In-Reply-To: <20260928063231.2158073-1-armbru@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Mon, 28 Sep 2026 14:03:07 -0400
X-Gm-Features: AclHuK-pz8ZYSsjg6k06PpRVe1LZW8hcqmufwd7Lni2MsPxN7ncB3NzrndsnG20
Message-ID: <CAFn=p-bv4rF_VzVPQBLvcNxrnbvJDNpsAHQR9_iH1q0coc7rig@mail.gmail.com>
Subject: Re: [PATCH] qapi/control: Turn the reference to qmp-spec.rst into a
 link
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, michael.roth@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
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

On Mon, Sep 28, 2026 at 2:32=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi/control.json | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/qapi/control.json b/qapi/control.json
> index 9898552814..c56aabacff 100644
> --- a/qapi/control.json
> +++ b/qapi/control.json
> @@ -46,7 +46,7 @@
>  # connection, used for agreeing on particular QMP extension behaviors.
>  #
>  # @oob: QMP ability to support out-of-band requests.  (Please refer to
> -#     qmp-spec.rst for more information on OOB)
> +#     :doc:`/interop/qmp-spec` for more information on OOB)
>  #
>  # Since: 2.12
>  ##
> --
> 2.55.0
>

I have a similar patch coming up in my rework of the @oob feature that:

(1) Adds an anchor to the OOB section of the qmp spec explicitly,
(2) Uses a standard form text with the above reference when generating
docs for commands with the @oob property.

The second doesn't apply to this command as it's an arg and not a
feature/property; but we can do better and link directly to the OOB
section of the spec doc.

--js


