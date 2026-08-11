Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 701CDC5CFCF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 08:45:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wti6W-0004LP-Al; Tue, 11 Aug 2026 04:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wti6U-0004JP-KX
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 04:44:58 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wti6T-00019n-4e
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 04:44:58 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c15cf78d1a2so289074866b.1
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 01:44:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786437895; cv=none;
 d=google.com; s=arc-20260327;
 b=Un1Nr6q9pRu2mBnw1JZp9dwHgh4mGVOZEszb5q62SHwCqhYYft224L4aJldGvT1yx8
 sU2V3iRWmzQZptlje0aSiuCpU03TA8gIxGgA1Fp+cybYo1T6wWFPQDtOqDAuqAHq02zX
 FCni1hftCZkcISQMjcXnSZ2a0xFCaiJgOC34J61oOgAWqHeoCGRqzYfqSd3UghOsaN7q
 ujuAKuIzb+ZR+1JAYW1IgBuZAcyNN84odr3rbZIu7Hb8Wxp1aIwxvk35LNgOBZ1rfYIi
 AZtk6DUmRw4y2YT1rDU5eINh8VDs5q3WA8sDj1rXDV9zb5vnPgOpes4IGZnVxm3kUzn2
 40LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bbgYf9/S6HIdddMi11WvmQuF0DLsImC3fjiQN9PmJHg=;
 fh=RNR0fx3lVXtwzBb+Z+kUg6SLYrgtIDSvnMyWvrMTeRk=;
 b=U2cLedfC7/a/7cIB7I2uMbUkAuDq1gKkvbHZ2r5lbFVcRIGyJ9hYZ/8Z4Jj/ZYKAdw
 tuvFesGVSVwmYA0wOArlvWCmcQGISTVMGTHOP44W6lNV8NcvNOli9E0/7WI3oHIoELls
 0Lz+Kbpasu0sDOogqBpkOG6sDi33WUyXrSRTj6NIMmQrS6prPjWrYo/yCSRvJXpZikBy
 mwioPhTfWVuOUBr39ZagihgR9IBQ0HyenVG2LoidkQ/FOEOVddHXRJPQmFI5kUkRjQLU
 bdHePlfK8ptuvNMr676EXQykJZb2byVQdr+o6h+pc0oeTrwlaJ4iFDK+xEb+mxyPbiFj
 gZ5A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786437895; x=1787042695; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bbgYf9/S6HIdddMi11WvmQuF0DLsImC3fjiQN9PmJHg=;
 b=H+mksKOLx6pXa7lRZZO2KmBaYjRM2W0KxorPJu4REYXQ+Exc31xFGqzK1G2uArA7fD
 vJ2xnR+bsGX/YjFQqVdGWuND6z06lWmtksUigi0KApuBo/bgvTl7SiHpvgA3y64S826K
 TkXyWQspDb2DguokO6TEtZuTHqDYUpeiniriT43f8m6+oxWOJQ3awuZukB/dHfSIjNGb
 JhMmFX3Vwz0XRVm1Blwd6jTIyRRtkASRcB0YGO91WdxUqWd+WLmRvFMGfUDLPpzPlM1G
 jQQUEc8G3E4toeeJb0hHFllbJUCuJ8J6vDVgdUQAgUQt2HsUr05mRJly3Ys7ukCS3DiR
 TwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786437895; x=1787042695;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bbgYf9/S6HIdddMi11WvmQuF0DLsImC3fjiQN9PmJHg=;
 b=bZ6rcdwgkMYmmSxEBzzfoMvhCNOhFtRWtrAEL6z3WFZTkp0lhxgS2HmGjA3lJ5d1Xb
 9h94A39ekMP/IjX6oRlVXYTQRGhJeRWOjOO+nAQ5M61TrDYrOmCi67eEYMffA4jdXkHH
 vyByqBLMBOvx6mfknEdThXi8v1ixMZipsDwZpmsNZjayKK/Of1jKChAEPB1vwUo1GXLj
 VcIcl/qGLrdt3FGY/+SuF+3lCITaztwOZuvu6TlsSRUwDYAd0RSFQP+Md7MghWL7dJvH
 AbAFORoBAXmgAJHnljRf1MP6uH+FIn8ZUXjNcIzQyNRQVsJFxfbDoxVeM6v9oa0HdVt0
 qrfg==
X-Gm-Message-State: AOJu0Yxg8TPbtzjtqCMExKO+7IjF5KadLyzmVNonyMrv/2JHgnpOg76f
 pii5bherUV8kHn9B9+wXrv9asqX/6Gxp8eQBsI7HBzQEva2o1iXf8wps/3eGHBezVmG7MNQY5dl
 UM83lp24IUoiFRdHQTR7NG2/B8+9IsfU=
X-Gm-Gg: AR+sD10ziHglDX3Y/1LXNiNRwwpVvXeT2ZRQoDh7q+djke/RpjtCnNflJ6Z4/KcWzAb
 4BcPZbHQN1P9ucSCqb0Ms5tyXS5vFSolAHQgvvhPIKCPYt15Hnv3GXvjiDP/gnJ4ywR87pPmU/L
 nIl2aHPYBwdJHsWhNb6TaWaseYLgeOpWJtX54koe9zYA2ozJV2tOudlHBqyU/mzZuM0UMBsWzAv
 QX87re/G8g7FCdNdEvnwwRSkYZQxhS2kzdlPxD+F4Ut+aAfAghVbYd5tkRaHYdy9j9Q/zUutH/Y
 jVcGBiFjs8FBMgAnTN7RVCtKExoJDxI/nnKEWI/KHIvq+Pnr4dCGHPeU
X-Received: by 2002:a17:907:3f8f:b0:c20:2eee:97be with SMTP id
 a640c23a62f3a-c20e6001279mr80799266b.7.1786437894399; Tue, 11 Aug 2026
 01:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260806202531.243806-1-zhangckid@gmail.com>
 <20260806202531.243806-14-zhangckid@gmail.com>
 <87se4qniy7.fsf@pond.sub.org>
In-Reply-To: <87se4qniy7.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Tue, 11 Aug 2026 16:44:17 +0800
X-Gm-Features: AUfX_mx9Qs7hzUTAanPHaZ7pihiyijVh6ubn_DVBqee569PgmZdnhv92h00KcpY
Message-ID: <CAK3tnvLK-wREwzoJP8jYEWRWU78vzSdjW87G=bpU8h6WKGqaug@mail.gmail.com>
Subject: Re: [PATCH V11 13/15] monitor/hmp: display IOThread holders
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x62b.google.com
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

On Fri, Aug 7, 2026 at 9:44=E2=80=AFPM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> Zhang Chen <zhangckid@gmail.com> writes:
>
> > Display holder information in info iothreads to aid manual debugging.
> > Omit the holders line when an IOThread has no holders.
> >
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > ---
> >  monitor/hmp-cmds.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> > index e9fb8d827a..de37f83a72 100644
> > --- a/monitor/hmp-cmds.c
> > +++ b/monitor/hmp-cmds.c
> > @@ -240,11 +240,33 @@ void hmp_info_iothreads(Monitor *mon, const QDict=
 *qdict)
> >      IOThreadInfoList *info_list =3D qmp_query_iothreads(NULL);
> >      IOThreadInfoList *info;
> >      IOThreadInfo *value;
> > +    IOThreadHolderList *h;
> >
> >      for (info =3D info_list; info; info =3D info->next) {
> >          value =3D info->value;
> >          monitor_printf(mon, "%s:\n", value->id);
> >          monitor_printf(mon, "  thread_id=3D%" PRId64 "\n", value->thre=
ad_id);
> > +        if (value->holders) {
> > +            monitor_printf(mon, "  holders=3D");
> > +            for (h =3D value->holders; h; h =3D h->next) {
> > +                IOThreadHolder *holder =3D h->value;
> > +
> > +                switch (holder->type) {
> > +                case IO_THREAD_HOLDER_KIND_BLOCK_EXPORT:
> > +                    monitor_printf(mon, "[block-export: %s]",
> > +                                   holder->u.block_export.export_id);
> > +                    break;
> > +                case IO_THREAD_HOLDER_KIND_QOM_OBJECT:
> > +                    monitor_printf(mon, "[qom-path: %s]",
> > +                                   holder->u.qom_object.qom_path);
> > +                    break;
> > +                default:
> > +                    monitor_printf(mon, "[unknown]");
> > +                    break;
> > +                }
> > +            }
> > +            monitor_printf(mon, "\n");
> > +        }
>
> This prints nothing when we have no holders.
>
> If you delete the if (value->holders) guard, it prints a line
>
>     holders=3D
>
> Matter of taste.  Anyone got a preference?

OK, I will update it as the comments.

Thanks
Chen

>
> >          monitor_printf(mon, "  poll-max-ns=3D%" PRId64 "\n", value->po=
ll_max_ns);
> >          monitor_printf(mon, "  poll-grow=3D%" PRId64 "\n", value->poll=
_grow);
> >          monitor_printf(mon, "  poll-shrink=3D%" PRId64 "\n", value->po=
ll_shrink);
>

