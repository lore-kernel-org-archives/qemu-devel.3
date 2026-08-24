Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82311C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 08:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyQOL-0006BI-K6; Mon, 24 Aug 2026 04:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wyQOJ-0006Ai-Du
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 04:50:51 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wyQOH-00006P-Re
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 04:50:51 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c1600d040e4so476808966b.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 01:50:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787561448; cv=none;
 d=google.com; s=arc-20260327;
 b=QNd16xpdZ2eGi+sry4B8LGECM692gPvt4XObTaax+v17AH0aA0vRMYokM+UbV2XkVN
 B+Rpwf+4Ap8bfxrpc/KD8Fv5jCA9MrfcctWSAL37PS9Z9JqkLr7tK7RurkcuPWln7Wt9
 2iGqOkTHNL/S4bBUQcwnO5279YRQaM2eIzaKuw/LlbRuBy6yVpxS44l8I4B0OiW8LKTi
 CNveDjMMhXTSOZdNkc4jSsEwr1Kfl17zv5W1AnEPZ8Nc+C9wdTiIYRWqc21ag53fGQWv
 ehWPevzkLyH9t/Bbs5LJ78CJRHmjqlKiyMoT0fp2fui1A4RfwarkUVJbNY+fm+VK9NmE
 TVSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zwhcyUW1Sp6BMgEVJLmc15bHBVj20vYqBmUjwHa8H80=;
 fh=wGZeUYt39FdrjiyDvngBMA/6KW8toEkLMWKs7FzaIuY=;
 b=NH9KDugeJEYxFP1V/D2xtND4RavyyJFRrF5Ve8PpH6l74pij674rTR4Ve8sGwaBZaA
 ZVUBt3ha2EvqxhxPFhGocYW19FXjEV3biL7SiHaLDCK3LYDMf5xOx1cp6DVRLaagjvL7
 8kiuR7M+SnuZk4Ks9VAMDlgr5q/ekLU5uDh4m7vBbg3BtAx8VoXbU8JL47udVeuVCy5L
 Vq+lNVrtKbjcXcHnkYvuxOLYaFgLS88LZVI4Ujf4TG64UCRXJGmxzuwxASJIp+YWALeR
 3ncgCRnRNqp6eKjgJwkO/Xe9lItOnUmeyYJufMIcbkUPhufxmkKYLYer4eoPGq8+iN/B
 TvsQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787561448; x=1788166248; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zwhcyUW1Sp6BMgEVJLmc15bHBVj20vYqBmUjwHa8H80=;
 b=eA5CDzJTFEQyUdxK7KF4mi1HZboAkKd9dDr8hwyoEgGwPZYy77FoapHgTZKrITQwgR
 SdpanAoPTiPhBoqGyWRSGSuCOwqLoGOGYgH9GFKRHtV6gJJPdhHaoIsp3K/gD9OWaPVq
 01RCQrWyNlIL19NKkNWOIHV1oC71dJuaxleoRj6etYIeeSfXF+3YrZXwAkx6t1p3BwPV
 LNlGjzxkLyNBKgHeRw+o0Vtye+SuoId+GF3fcbkzaKQOs6Azezq7VvIkUu0Qz/DnJc3L
 WmqfHJW+rjgBsbEnRahmjCTV3Mn1y1/r5xf16iD9tgaC+y0tLB4zldw+I+0NAZKcBhnC
 XrSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787561448; x=1788166248;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zwhcyUW1Sp6BMgEVJLmc15bHBVj20vYqBmUjwHa8H80=;
 b=srICpIogo0sL0JvyQ+1x31Qg0XzIMjyy4NMlmkxwmXgUtmnRO6dP7sxsuZbH/V9g9N
 Pz9S5xXVtqZ7fmASpeVbBhkJ9rDdDMpbOCt75qacXG7Cei7U5n2VaZDBNt1EnJeXbXsx
 1DLLuDqzKJOVPJbkwKeyA4MfIi2qCpg8+2njMW1cP3ZGfe7oQpDSDKASWzi9o2KeVoGP
 Fb5Sh/9O120kzpwtX/D5KB51cgUmBo7CVJQ1W5Xnk3Y0uxZAyziGV7QK1yu59qvlDViC
 tfQkDQYdqGHhEi92eg7qKXJTtHAtAWiXBG2D+SHyGwpsPIOSlcXkarLUwQ79pbZGTkjI
 R8kQ==
X-Gm-Message-State: AFuF++nCByF3k1iPufXy39kakeCMnJQbkLbQnV+uG1cBF+FU0w44Y9NN
 Boo1G2/E/cxmHIwjA/6/gR6B4FlYyQWE8qfpUuE+uEsDqJ/md0GmJDqIRfOMHzZikYF7kNBm4nw
 vgPyNyMNdoUNhv2bmfDR61WYEPQpAQXs=
X-Gm-Gg: AR+sD1269gQRi3AAlSVGYbkMmeouy9aQoHmDpR6BLSIg76JQnhsi9kmVAcfjXk97jzn
 Uai6b7bVzo3KhYlMQNdsptMZMVsBgFMNoqWEYGV4Rft33GJbHPbJfVkhUY9idnCHEalp28989LA
 3jigELGhRc/UFk2/3NMkcgbpNbFAu+4qgc05FzRAaAmfhb5diIjIJtBZC51WlJ1dW/7cYAz5fgR
 5EzW53Pfc4Zvx4HjElnmmmlr8ymOfJIULPqQrDOETr0mZDa65DlHya+9ob0bZ9/EtDVw4+T2JXF
 RV1vAxDTGwCMCYYTBDMeSKFPA0bS3Q+RNS/EJL7zT/lfzg==
X-Received: by 2002:a17:907:a01:b0:c20:7cb0:f33c with SMTP id
 a640c23a62f3a-c244d86d229mr2688152566b.16.1787561447712; Mon, 24 Aug 2026
 01:50:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260814174830.1691540-1-zhangckid@gmail.com>
 <20260814174830.1691540-4-zhangckid@gmail.com>
 <87a4qcvx3w.fsf@pond.sub.org>
In-Reply-To: <87a4qcvx3w.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Mon, 24 Aug 2026 16:50:10 +0800
X-Gm-Features: AcwNN1XvcviFFhecgYweD_a7l5gDhG6awqPvocWGyhrp4wglGXIt6OixwuUTx2o
Message-ID: <CAK3tnvJSbGyZ0ryU-3AdoNpgkrE1-D=JyTiCbb98Ngjn-q-8rw@mail.gmail.com>
Subject: Re: [PATCH V12 03/15] iothread: track users with holder name
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x630.google.com
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

On Mon, Aug 24, 2026 at 3:24=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Zhang Chen <zhangckid@gmail.com> writes:
>
> > Introduce iothread_ref_and_get_aio_context() with a holder argument
> > and its counterpart iothread_unref_and_put_aio_context().
> >
> > Previously, users of an IOThread AioContext did not explicitly record
> > their identity, making it difficult to debug which devices or
> > subsystems were pinning an IOThread.
> >
> > Registering a holder takes an IOThread object reference so that the
> > IOThread and its AioContext stay alive until the matching put
> > operation. Document the ownership and BQL requirements.
> >
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
>
> Does this add tracking, or just the tracking infrastructure?
>
> If the latter, the subject is misleading.

You're right. I'll change the subject to:
=E2=80=9Ciothread: add holder-aware AioContext accessors=E2=80=9D

and clarify this in the commit message.

By the way, the V13 series has been sent, please comments it here:
https://lists.gnu.org/archive/html/qemu-devel/2026-08/msg05327.html

Thanks
Chen

>

