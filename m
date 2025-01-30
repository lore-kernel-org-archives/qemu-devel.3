Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08142C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 17:56:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdYlR-0005Pq-TZ; Thu, 30 Jan 2025 12:55:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tdYlP-0005PV-4n
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 12:55:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tdYlN-0003eY-Fk
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 12:55:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738259734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CElv3nVM0ddXGjklPbgTKDp8AJboZRyKw/jhSk59w4k=;
 b=UZAurA6tmAbN6Vj9apd12KSOmcIikLv2gNQEIhlxKLzUt3h/7T0hpg6bQKHuccAqxwAVtI
 gBFvCuWDRWnWCKDKFcpDtNDtuCqsIkwHO34uglOcZqD9cwFJhssV4Uu9496GYPrcDNwfId
 3FkDUPlWkXBwdNvcPufzIpVc5c9nQKc=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-w3-Wbkd9M8esyT_UY7TyFg-1; Thu, 30 Jan 2025 12:55:33 -0500
X-MC-Unique: w3-Wbkd9M8esyT_UY7TyFg-1
X-Mimecast-MFC-AGG-ID: w3-Wbkd9M8esyT_UY7TyFg
Received: by mail-il1-f199.google.com with SMTP id
 e9e14a558f8ab-3d00ec87dceso698765ab.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 09:55:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738259732; x=1738864532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CElv3nVM0ddXGjklPbgTKDp8AJboZRyKw/jhSk59w4k=;
 b=QeGrBWKmGIluW/rJvNwkmEH/iJ8H3wYQlFnrlBgXGWNGlSjJoDdZ4WmXDUgIW7eRM3
 20CBDNQ23bvuW2zBwTHWfO8jDKueTF6oRUo0ig79q5RXkR5B3Zcx8YjHdSB4OMDLiLc7
 a7+SSt1CHctPLhXmGjnHj37SijqWPSquQpdhqdTXJxduElwkPcYr6tOT05You5ksAe52
 VahSw6aXVOdgflxo7N+g4cxPzpGHrh1EM5m4gy70U2lYGD+HGrkRu4wRs3o8gNS6A8q/
 y+tnNCGtq1mAbnPJ2Rh7RFEiMpaYj6o4NuUQk8v+vTQgMI63Ju28x5ClHoKFj2eoO3gM
 x54Q==
X-Gm-Message-State: AOJu0Yx2aQYWivzKadFTosJ0QDcbKWhte4Eab3QCS6PQ6gP8XLSb+zWX
 05JXP+6+9hu1PvWlbQqDEXh5gtFdzBoJgaUnTPYQHljv+MaCPz3Jswry9SmRekY3Vg00wHC7QDY
 ZMPUa0YkRBJn8iMCkDsGj9KBodgXcUghswL/hWTenEyR3BnfLx4gv
X-Gm-Gg: ASbGncvsJd5tOq8aFHtpt4Cu+h5kp3mSdVdf7jTCyJfpR31BjMe7wtkswtCbGzh2Kzc
 SsAYGJSERhRDqt3c3b3N30192XxHLe8LUhKUsSEr7ZgysCDN8qPgFRCH8cGEU7NGFmOOJrkacOj
 2frshqWl7zjtqi42ypHVVgo66deOsBJ8UrYQG8awxPtYuujKK36y1LO+/E1wGtjLE1MOcqQTNHa
 wSSNo3uL2oSIvjE3ZfnlJ9IGPLp3MacVO/tr1rHowLPnsB0QS3edSRY8E/cliux3/Sw6SsniM9K
 z9VOJDhw
X-Received: by 2002:a92:cd81:0:b0:3ce:78ab:dcc0 with SMTP id
 e9e14a558f8ab-3cffe4732c0mr18508165ab.4.1738259732011; 
 Thu, 30 Jan 2025 09:55:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoEnV3pbKwoCoLjAsDx8I+79pRin9aqALSz39971YPPKR2UbP7mJxhYEzbqoEPPbt3LbV94Q==
X-Received: by 2002:a92:cd81:0:b0:3ce:78ab:dcc0 with SMTP id
 e9e14a558f8ab-3cffe4732c0mr18508095ab.4.1738259731698; 
 Thu, 30 Jan 2025 09:55:31 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ec7458ecf8sm445323173.6.2025.01.30.09.55.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 09:55:31 -0800 (PST)
Date: Thu, 30 Jan 2025 10:55:29 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 1/9] util/error: Introduce warn_report_once_err()
Message-ID: <20250130105529.205cbdb2.alex.williamson@redhat.com>
In-Reply-To: <20250130134346.1754143-2-clg@redhat.com>
References: <20250130134346.1754143-1-clg@redhat.com>
 <20250130134346.1754143-2-clg@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 30 Jan 2025 14:43:38 +0100
C=C3=A9dric Le Goater <clg@redhat.com> wrote:

> Depending on the configuration, a passthrough device may produce
> recurring DMA mapping errors at runtime and produce a lot of
> output. It is useful to report only once.
>=20
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  include/qapi/error.h | 5 +++++
>  util/error.c         | 9 +++++++++
>  2 files changed, 14 insertions(+)
>=20
> diff --git a/include/qapi/error.h b/include/qapi/error.h
> index 71f8fb2c50eee9a544992d0c05263c9793956fe1..b6ea274882b9788b64d4bb213=
c3458d7c674a881 100644
> --- a/include/qapi/error.h
> +++ b/include/qapi/error.h
> @@ -448,6 +448,11 @@ void error_free_or_abort(Error **errp);
>   */
>  void warn_report_err(Error *err);
> =20
> +/*
> + * Convenience function to call warn_report_err() once.
> + */
> +void warn_report_once_err(Error *err);
> +

Turning it into a macro would do what you want:

#define warn_report_once_err(err) ({ \
    static bool print_once_;         \
    if (!print_once_) {              \
        warn_report_err(err);        \
        print_once_ =3D true;          \
    }                                \
})

So long as we only want once per call site and not once per object,
which would pull in something like warn_report_once_cond().  Thanks,

Alex

>  /*
>   * Convenience function to error_report() and free @err.
>   * The report includes hints added with error_append_hint().
> diff --git a/util/error.c b/util/error.c
> index e5e247209a9e0796074a9794f5598325f22f8d35..b8a211cccaa609a93091b8631=
6144a0ad0a02662 100644
> --- a/util/error.c
> +++ b/util/error.c
> @@ -247,6 +247,15 @@ void warn_report_err(Error *err)
>      error_free(err);
>  }
> =20
> +void warn_report_once_err(Error *err)
> +{
> +        static bool print_once_;
> +        if (!print_once_) {
> +            warn_report_err(err);
> +            print_once_ =3D true;
> +        }
> +}
> +
>  void error_reportf_err(Error *err, const char *fmt, ...)
>  {
>      va_list ap;


