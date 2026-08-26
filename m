Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49EF7C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 19:16:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzJ6C-0006QC-GX; Wed, 26 Aug 2026 15:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wzJ67-0006Pl-14
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 15:15:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wzJ64-0002C2-Uk
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 15:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787771739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SZgyo2bFLWWYn3WOEc6EYrsMkNrup1Y7bN5XQ0RV6WE=;
 b=OLnILZAOzJsnIl9PwA4fws9Hnz/uI0hgPU/MjAGy6ggE1F27LCDXP+EK+enDaTOrmtXoUP
 l/8hA/MyxebCMQh/r6Tr5/Swj8eAD3ngzA30kKlrZPo/lAQMNEk+IM12Y+PLAkLUS1gRbF
 rKacp4d2zsOJBd6mEGJQyGLqn+5jNOs=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-KZjMeYqkPNKjmRMvWz1amQ-1; Wed, 26 Aug 2026 15:15:37 -0400
X-MC-Unique: KZjMeYqkPNKjmRMvWz1amQ-1
X-Mimecast-MFC-AGG-ID: KZjMeYqkPNKjmRMvWz1amQ_1787771737
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-ca6bd8a190cso1774332a12.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 12:15:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787771736; cv=none;
 d=google.com; s=arc-20260327;
 b=WfVRXSixd5e4mJBH1wKvNlt9rJ2UA337TRgFImeD7jnmaEZHhI2Zvh5CHTJIX1rxMg
 0CxGXbaareiD9EdslHViDh5Xm/a/2ciSp2fmIYe85GWC4ubn/Om86LreRo0D7JODkTxK
 VutvNbpTd40rwtgscJCEmne0UZRQqsi9XiaqUGTi1+UeJwqjqi7ZsRndbXZthJDbs0gf
 b5BjbPr2ufRi6ENJEGC0pGbYjsv69DaD6S/ryIUJd81xYXttRYCJ4Z41f056tWbwlAmI
 IlMzIEnXTAnYUBx3atSxJdncQaiElZhBEjKXgCY9EVEP9PVfU5WKhW/QiY5s/h86Efu/
 pqkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SZgyo2bFLWWYn3WOEc6EYrsMkNrup1Y7bN5XQ0RV6WE=;
 fh=PcuXpK2bfC7EoNuuaJPQqLtQ9sEGkoQsnR4/5XYLgv8=;
 b=CZsJzaefdoWnzdZzgnA9OqpSGrAwKjBJgjHEoRrY/gbqzPAfyTkEGgVwNA8emo51c5
 DCpOCodF/QeJeY/0e7bP8jcN7TgmU/9Z4ghfadK5WkWywku9JviBv2xaDWJgq8TFpGz7
 nwilgzF+tX+LpRXqsJrMbA8a+9SWah/3h20rg3FwspI7eA+lcNgXmlvA4nZPhzhVlz3+
 iyGQ7C0lBhtkZYbWXq8FrGkLZUNOsUZenozcSfpNmSB8qViAyNOaKNd7gxa6N18sGzUd
 VV1AbATWl0vDjg8oK2z+IR/evlJ+dbYBOaJktwDPYG8a8NROJ0C86G3zZbPqTFqAQvaZ
 Jdxw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787771736; x=1788376536; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SZgyo2bFLWWYn3WOEc6EYrsMkNrup1Y7bN5XQ0RV6WE=;
 b=abTYXlDo7XA3opWaVBu9xTh1/jq87SqivyOAxM0JHR7KRwNmHJYTjdAXJqB714Y7QZ
 pXkTDZfvjwJ/h4HUul5vS/KISzQfhwqzM5xGcSmC/Bx94PqfODRab2FV9qpXxFrnNkxo
 76EVTSlULU62QoayK/etkz8I4J6RUHxe4lKkNMnPJpuMy4hg/oMqdfkwuROBisMCwzvg
 0EkjONdtk9ud9+ObnmClFzOewB0p7jTpB4tVPYIzoQi+7cYVvItCdXDegOkQNQtMoNOP
 rRNZfAh0Me1B4xup6qcLqB1lNaaMtPIVLNp+0yQJ3kVnN/ajtu65CDRYZP64G30IgNw+
 PvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787771736; x=1788376536;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SZgyo2bFLWWYn3WOEc6EYrsMkNrup1Y7bN5XQ0RV6WE=;
 b=mV3lTgyr5OOoNWLPlNGVL0FVt2z6dl1TkCME0x1UPE0i4jeZlldSToA7oSZ5+ytdKQ
 bz1HPiXK6nHnyzCHQDlc9TqaA/1k9QSpJxykpIoq3tku6tgvGx4c10ZYLiBnCzPKt/yw
 6DGS7aSIvXS0QZl/UaE59BzjkUkQy7JNb3bxToGzGEaYgOVIPLq7cpdcCo6ID5IgQ8Rf
 7kD8oh798RaVzXnK8ljnIZoIYN8Fq3kvlVCzUcz8/Rp0KIpfLtC/MtpAqj/h8WWqg034
 BuyM9IrRml1zNfJvuMeEPy6eIIoE+2fROaEBjilxYO7/SRN5mbAD9gEAs61TSfH6YbSE
 1Vpw==
X-Gm-Message-State: AFuF++lmORiLFn6/2kp8eFHRSHp2yH0CVEoEhObuTRkAmu7LMKz2KEWw
 xHW+e9NC0Ndf+Vbce6fv6ArShi3GIcKeQW/WokqSqzkY975WqRmPnVv3ORPqUShAQ0uSyagxGrF
 uyLD8GgEBO3Y+LAz9/FTmnErnmAF0q4Kjrn8aGbn3UEoHpYqPfeKdyWdIHqgcIyEGnjeKNlVzRS
 ZGa9XYIiIRwRXx6l2TCp6TCoY7Z4tCnZc=
X-Gm-Gg: AR+sD12YToD0+Z8/eImoBBe6GUsAu82vnBFmqg9WY8aRu17OpSzegU/70RwbyDKXRsE
 +bJjZh5o1PjuQunyAa9vdLGUj50AdWZW8IU5IuPVmQm7bmtRBpGrvzE6GP7pJQsYI7RBxHi9Yak
 kXtuUOfvL6lxqj+vv/Nf7VCXnb/N/L8f5hAbdnkmvCl1LmqLVL84AKYGAbc0KIKMBbRjiL+UzZx
 Q94Rh1g+3+qFgJN11sEjlpqAzi3bllGximt66KX6cpztjpuJzAibRi6qoGV//j13PIY19AMOPWt
 QA==
X-Received: by 2002:a05:6a21:2212:b0:3d0:ba81:79b1 with SMTP id
 adf61e73a8af0-3d0ba817b48mr6828756637.0.1787771736564; 
 Wed, 26 Aug 2026 12:15:36 -0700 (PDT)
X-Received: by 2002:a05:6a21:2212:b0:3d0:ba81:79b1 with SMTP id
 adf61e73a8af0-3d0ba817b48mr6828638637.0.1787771736111; Wed, 26 Aug 2026
 12:15:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
 <20260825-qemu-no-hmp-v4-8-af60857c2fbe@redhat.com>
 <a415e322-f75e-43bf-9f0b-beacdc04c33f@oss.qualcomm.com>
 <CAMxuvaxwjtQa+4N1_rTLK0PuefNCE3oTkkTFbGTaGi4AUcz4Jw@mail.gmail.com>
 <741a5e23-c221-438f-8876-f31cb8d580e7@oss.qualcomm.com>
In-Reply-To: <741a5e23-c221-438f-8876-f31cb8d580e7@oss.qualcomm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 26 Aug 2026 23:15:24 +0400
X-Gm-Features: AcwNN1Xcd79c7EEJuOWITZcRBsHdQHMEC0EZP-WNPkTJ-aNNKfkWQIox8ImrQrU
Message-ID: <CAMxuvayh4wT9xfSpAxYZ7ToY=G8goOOPV=Gprn2OhgTZzWBusw@mail.gmail.com>
Subject: Re: [PATCH v4 08/49] monitor: move HMP-only fields from Monitor to
 MonitorHMP
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, dave@treblig.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Aug 26, 2026 at 9:48=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 26/8/26 15:06, Marc-Andr=C3=83=C2=A9 Lureau wrote:
> > Hi
> >
> > On Wed, Aug 26, 2026 at 4:39=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
> > <philmd@oss.qualcomm.com> wrote:
> >>
> >> On 25/8/26 21:09, Marc-Andr=C3=83=C2=A9 Lureau wrote:
> >>> mon_cpu_path and reset_seen are only used by HMP monitors; move them
> >>> from the base Monitor struct into MonitorHMP to properly encapsulate
> >>> HMP-specific state.
> >>>
> >>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >>> ---
> >>>    monitor/hmp-cmds.c         | 16 +++++++++-------
> >>>    monitor/hmp.c              |  9 +++++----
> >>>    monitor/monitor-internal.h |  4 ++--
> >>>    monitor/monitor.c          |  1 -
> >>>    4 files changed, 16 insertions(+), 14 deletions(-)
> >>>
> >>> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> >>> index 6b1114fdaf13..6718fec97047 100644
> >>> --- a/monitor/hmp-cmds.c
> >>> +++ b/monitor/hmp-cmds.c
> >>> @@ -499,31 +499,33 @@ void hmp_dumpdtb(Monitor *mon, const QDict *qdi=
ct)
> >>>    /* Set the current CPU defined by the user. Callers must hold BQL.=
 */
> >>>    int monitor_set_cpu(Monitor *mon, int cpu_index)
> >>>    {
> >>> +    MonitorHMP *hmp_mon =3D MONITOR_HMP(mon);
> >>
> >> s/_mon// please
> >
> > It is gone by the end of the series, I'd not bother here.
> > thanks
> If you are sending the PR this is simple enough to do locally
> without needing to respin, besides that makes patch #35 simpler
> to review ("monitor: tighten monitor_set_cpu()/get_cpu()").

ok, fair enough. done


