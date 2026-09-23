Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B34A3C9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 17:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9QcP-0006sW-OU; Wed, 23 Sep 2026 13:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x9QcK-0006GQ-HI
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:18:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x9QcI-0002DN-S7
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:18:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790183926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BQTYGQ8XMx/wG661iZtKKtWEJuVr1FPtmdfh9ejEAJw=;
 b=TF2QWp0fOSvukhdZ1kboFXo2ZOcNpUADWK5VHsjOmwpSK6HyJL6/vr331868lbm/EPQX33
 +dybJbOG75Yj1Smj7OsxOLoI3cUcU0CkySH1ksb3OFE4/HvHNUdgKEZIXElLdtQ4EaI4Jc
 kkoqyBTKKuNmonzTmTvw2b2vQ/AnzEc=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-IBbcBGj9M6WVFNprtuRipw-1; Wed, 23 Sep 2026 13:18:44 -0400
X-MC-Unique: IBbcBGj9M6WVFNprtuRipw-1
X-Mimecast-MFC-AGG-ID: IBbcBGj9M6WVFNprtuRipw_1790183924
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-66f8a19cf9cso1081462d50.3
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 10:18:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790183924; cv=none;
 d=google.com; s=arc-20260327;
 b=gk4Y6tGA2gl34ij0v/IFa7UB2ezZSqh4i+te5FP2NcDy78A6fsvIc0iFj7XZySAXG+
 /E118klvJNxh2e8Qn7vawVe665Z24/+m93JPT34n+TwHnJggUTArS5xIaGEoMJB2gLCz
 V/5hYeCgv2R4HcI3/cx+P6fBN0KtAkybDWK/tXCFvMXqUcQIZHOe1J7u5RzHnoj4NUZC
 GoRhv9gi/1FqaedkAPyz/mw5QPx8X4Vh4Z/gAs7M9JDtN1+ym+1X/oi6PqsYifdt1Iew
 d5SxAIJK8qcyct79tK10olFECWiI7pZOV5qvYKn733VMsLbhN4sFeJQKaVrWdexEf6+e
 yLYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BQTYGQ8XMx/wG661iZtKKtWEJuVr1FPtmdfh9ejEAJw=;
 fh=nv4lR2rH1aVW77dMNATQm0dxGI+JibghZG8DLCFB2GM=;
 b=c5lT+qajN0PdhH/moBuoCu2dH0ztRxSkxxuL5EiYTSbuDWDQUqiODRIgDl0Qhnqj8G
 +60eeQ8nUCUGMvcOAhE+6FVIQiAWMJSe7gDJ2bmm3Cv83zltTcN6grycDI9BoQ9F/7Te
 l4sTs4fRGbjAdiQ8/SBdFpDZhlsbZETeNJzt8NynRxrx4bZMYhbwDmTUoxDfxyGwFIQh
 kKK9b0TRTqkIIYG/pWtGpUdPQ/U/uxz2vI1nKYQAzpcYRCdw2hjWrIUxs3OWFACHuVV7
 OZMQfzmH5WRO3xQKED3XK6SDNjfFuVIRxt6BULuI5bthN6ZhhQWB7jGfnRoDv07y6cAw
 Sd5g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790183924; x=1790788724; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BQTYGQ8XMx/wG661iZtKKtWEJuVr1FPtmdfh9ejEAJw=;
 b=X3pxS2+wggrpCiU1g9mMwsRgOERhYThFLZpCLqilTek6E0LaANuXZQsXrvMmt9gowu
 MHYUwRWWTEegvKgW8/Yci3YBtJ0CBSBKURpvgmwnp2sDh6l/v9HSrHZEnZlp6yWSnJkX
 6tpC18nlJrsHKqSBUpK8csDTXKCW1I+FiWSWMFRaRxxZ6J1JXtcm1pjb+8NcSpXGrmUs
 koknX70E3sHB12ovTDm9cl12HGThUf4azsY3SHF9Pbmaf2OjEd21gJJyRn0fbuiEHD03
 tXDM/F6aQxaGfsWNcGDQY1jMeRzGVGk8yANBAYg7SgWFz0rapBFLvJqWz1JRA5sNvmtq
 Bfuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790183924; x=1790788724;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BQTYGQ8XMx/wG661iZtKKtWEJuVr1FPtmdfh9ejEAJw=;
 b=E0oP4yVBoMyUB3CQOuwhBlOFEtSFRLca/oxw9m9mL3Ur/UPg24qDNw2+Le4mI7K1Qn
 jxerfVVat6Gm2cDa/fHKaK98ExsF9MFPVqQSEM/YzmoE2pjURp+2koHj0a5VDdRZAQER
 vs7MlukwC92btFGaBee3mByx1TJQrmDyCKskZUyAO5QUbtWO65oUIWqCLDC6jzVvoHiz
 7Rikin/UIi/ChPwdn0hgxVcpgXLHIJFBFsiCodi3HjKLtjK3hw10hjA36I3CfWqDHNmK
 DoauS4L0j+VaC49f8gGmB9ofp2lskGTSam1bB6RWSYN8wnipw1UMX91i0vsOYQjFjFly
 pIhw==
X-Gm-Message-State: AFuF++n+wnGSU/f/sTFSW10H50PXoayK1xoOg5vaGuXHQy01gvzZfCQP
 ezdsqHf+fAAv8NsiUkS+Du2l/V+Xqzi8bv4MSZKEnxkoDsyKEqJI6XEVcT3VgIfVp37ccdXGHXc
 ld1IjKAzTwGfaw5kUwKsB0NpNPXodf6jMgqa6vjSbOtFmONnTErzf89+lQhXOy37IhfCuvb8G0R
 OClz4xedTyEJs1JxleNQcu9EeUX3A8f14=
X-Gm-Gg: AYBFou196IRKn4t6vved1Ails7y9It285SIg+KJ8VBDja7mfaphgb+TMiB1aB8qXbbX
 y6OLENcgmeAgpiTy8GCiLEMGvy4K3xPpslBXrzT1dCgQyM05GkVVyM7URKNp5Sy2/73nPJXKIqy
 52TiMBJ7DCm1dXX4o31weeuG/Z/PFrbY7yMeVJcx4LDuID1Y0zpp79rBv+TjJwXd6zk+L4l98rw
 bdSGhARjMtc/EWS
X-Received: by 2002:a05:690e:80a:10b0:668:e1:6292 with SMTP id
 956f58d0204a3-672d57406acmr1041938d50.28.1790183924148; 
 Wed, 23 Sep 2026 10:18:44 -0700 (PDT)
X-Received: by 2002:a05:690e:80a:10b0:668:e1:6292 with SMTP id
 956f58d0204a3-672d57406acmr1041914d50.28.1790183923677; Wed, 23 Sep 2026
 10:18:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260922205605.501602-1-jsnow@redhat.com>
 <20260922205605.501602-6-jsnow@redhat.com>
 <87h5jgzdp7.fsf@pond.sub.org>
In-Reply-To: <87h5jgzdp7.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 23 Sep 2026 13:18:32 -0400
X-Gm-Features: AcwNN1UXK4JYOPTaV-NlMRX3eEOaqZ8WzpzO5cMKi-VAHFPoc6W6iyB7ZwsTNl4
Message-ID: <CAFn=p-a9jon7HuAj819CqmVBS+M5dznpCKMDeo8pS8cW_KbCWA@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] qapi: split intros at natural cutoff points for
 qga/qapi-schema.json
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, qemu-trivial@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 qemu-block@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Sep 23, 2026 at 2:25=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > Note that these intro conversions introduce a new intro/details split
> > point. This new split point may or may not change the rendered output
> > depending on if any documentation is auto-generated and inserted for
> > this definition.
> >
> > This has tangible effects on how @guest-fsfreeze-status documentation
> > is rendered, while the other two appear unchanged.
>
> Doesn't say how it changes, and it's not visible in the patch.  Suggest
>
>   How @guest-fsfreeze-status documentation is rendered improves
>   slightly: "Note:" moves from above "Return" to below.  The other
>   conversions don't change rendered documentation.
>

Thank you, this is good.

> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>


