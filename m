Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9236C982DA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 14:03:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7ZBS-0002O1-Gr; Fri, 18 Sep 2026 10:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x7ZBF-0002NQ-0L
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 10:03:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x7ZBB-0005Xa-HH
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 10:03:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789740181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BjiyWpsV1lJa7A0XdLDoc5tajw3YRD1n1DxSyAAleLA=;
 b=NzqMlEPWHxRBqv181K/RASGZ3x8scx8Yu+S1diI2fQwOb4JfaqnRmjzH6Zre7o2OzyvUR9
 4bTE+C+iCM/EYVE5J2Xpq0YXF+ld56jvazA1453n4Y6OZAJQmghaS9ol/4Lb+ro2ZUm3AX
 iFXZRuco9hWXEHwHwJ+AKRXXACxA+BI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-Qzp5iIMPMP-Ww3m5LuqXBg-1; Fri, 18 Sep 2026 10:02:59 -0400
X-MC-Unique: Qzp5iIMPMP-Ww3m5LuqXBg-1
X-Mimecast-MFC-AGG-ID: Qzp5iIMPMP-Ww3m5LuqXBg_1789740178
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3965ba1ba3eso1066013a91.2
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 07:02:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789740178; cv=none;
 d=google.com; s=arc-20260327;
 b=WRnOGaD5odUv5jP4WXzoZBF2juLWECKJyqK5bAUthyTDWuWnsnhCGwB4oZV2M0K1N6
 J+ezfnw5WX3+cdXaPRXlrSVj3pG6YMh4xE9E+X7OaOw/tDTlMawztBm9edMDOuF+xEiE
 TpOL69VK+dOMG2RHC8/j9BlD/lZMg/ccwY6noIPHQ36RLY7zqjH7PWG3z2OXfDOy20x1
 gbpCZfTTFF6n0y+GHLWyNAHqcGP29y+h82VNXCeaaFKkPT6XHCL4mFWwSBeJHoW8AGkt
 z6yPm8G26FijmI2x5SCCjwKijo0g04fJFBxZAp/KdnLeW9TZvaRdQdrOyUoRe+CQ9hJS
 Ae3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BjiyWpsV1lJa7A0XdLDoc5tajw3YRD1n1DxSyAAleLA=;
 fh=MSgXJWkfX6drgHhltmY4z9M9KmIuQLD56TEjfqsrTC8=;
 b=optAXffZraPGQJlJeuJY3B4TMIfDxvPm3uHl/BZrXEOsIJ0ZwsseKBdKPPDvydolQw
 HoLc1GLJeHcgt4JngyXx6MNSVuYV2CVmC2GXqOAeEUAsCFj5H99blHVpH2XRCsDuVg5D
 ueZfvKPxh2fkL83YDvtaTUZBhejYjZdjN9DD2qtoAW5CZ2CJP09KKiWA/6HRDzUzQcPO
 7O/1Z1RjFso3ipFJ4+mxcKJzf7rVnL1ILuUK90V01tH7DGb3PY974GQZ929kmZoc+IMS
 oKfcaIPmPdrxQbMIfFHJn4R+KPZoEcWTCQ21yTBAeQ6vi4uekWbKKI/XXIci/NQhyN0M
 MBsw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789740178; x=1790344978; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BjiyWpsV1lJa7A0XdLDoc5tajw3YRD1n1DxSyAAleLA=;
 b=FDcyKhkkO7d5c8onNvIPc1J93q1AoJMYKbSR3Re2HXfiMrzFfVnNWKkFKaiVIZMy6G
 v94iZa7EDuNxM1hhaYeufB5F36Id+7imIxpGNaR0UdXFgnkDLtaAsJzkE/PRVjG6O8QX
 8xue/ZKQordPGfPcVvmhAfIZr2jwTnKZ9cr0a3XRBjyV35pCyGqilFGpjqST1H8dUbf7
 knl0hFGo+UBTQqFzk3K33l1OpsBpbEsDNKNs4U90Kv3tQoW6ApvuLNNr1KWZz9PRlv7Q
 +7jEv0EcIGRjkhMsnT1WJNwbJihs9WO7clJKujbK0LYQvcfM/HxXM1svoAiumH4ivcj9
 JAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789740178; x=1790344978;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BjiyWpsV1lJa7A0XdLDoc5tajw3YRD1n1DxSyAAleLA=;
 b=Il9Q52MkRnv7J2Gh6DZ4/b4VHDMmXP4rKCIeSDS/iAx0c/E3fESDmYgc1VLX0zs2rD
 GsljtUAeNspUqzPF2jOsiULPbefBaP5Bn907ppPnpeSUHkQZPdwk5OGOZ/YGjcRyYcVB
 M7MQcZd2ww2ZjUg/svQalM7TbU/l1PVKHVXPugkBI0xHKO3uQ1UrVBn6hmMghB4ETu8a
 iEQcbhsFVzJsmioG2eNUs17RBe8+Bid9aj0CIC2prPPwv5bb4ACgRVvkDbQeRwDevGYa
 YGWgOsb9ZU5jgJEEIz6YbAOjIaAvx9+mKFsRrfysT9NdokXQyVIt8nmQk+gkiVfHLixU
 jxEA==
X-Gm-Message-State: AFuF++mwBTpFlwYBGxy2pPIwUcT+PLAPkkx3l6apn9WU3gdjsHFRqsoL
 iJpANNm3Sy+DdXSXgpTKEwiWMdkXuKgh55AUpuTrk3LufWJA2ao7ofCL+U6cK550m4eSD/ednUw
 0HE9YtMRFkoIZH6ajfHDUdDFu9GrrVnNUnsWuUtfQQEYwMP+lnYb7Mo6UmeDnG7vX4/4dj1eE/z
 Mx/pkIKz39kA1vpvlhEUZki8tNpFxMD/4=
X-Gm-Gg: AYBFou1s3ko5zDHYffn/imeeA73JwtI14eadQWO2+e3tY0ViJp4oquwaBQiJV0M3yA1
 Qzi+usRJ6Ah2rbl3Y2mFwbWncjMM2bYGlM8b2nxwh8nZcTXnYchhrSN6S+qk1qoTKxnGL0/6WQY
 ac1E1XhdJq8pX+HDGhsts7JeYaWIY0courgQe1Rb+ZVSB3ScqSXIZT5WthL6/utlKi3LPI+6Yeu
 pW3er1etzI/dgqIp2asN8WUJ8SG2yZruzAWLhLbzcfwZsCbucS4XedLkzZx/1VGmMvbEUUlmjMh
 Jg==
X-Received: by 2002:a17:90b:2b8e:b0:39d:efa9:cd25 with SMTP id
 98e67ed59e1d1-39e54c59c74mr11196575a91.2.1789740177698; 
 Fri, 18 Sep 2026 07:02:57 -0700 (PDT)
X-Received: by 2002:a17:90b:2b8e:b0:39d:efa9:cd25 with SMTP id
 98e67ed59e1d1-39e54c59c74mr11196445a91.2.1789740177194; Fri, 18 Sep 2026
 07:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
 <20260911-qom-qapi-v5-4-7732a55b7760@redhat.com> <877bkin0kg.fsf@pond.sub.org>
In-Reply-To: <877bkin0kg.fsf@pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 18 Sep 2026 18:02:45 +0400
X-Gm-Features: AcwNN1U0jbETQMlTFyoBRl6c0F9Ot2IrWNOcX9_LyQzZy9hHd_AM80UGz4DaGCk
Message-ID: <CAMxuvaxgeaAvFoXXuCn98ZNQugK1GMrhW3a7Q1ztp5KkWk=zMw@mail.gmail.com>
Subject: Re: [PATCH v5 04/62] qapi: register all introspectable types, not
 just QMP-reachable ones
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
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

Hi

On Fri, Sep 18, 2026 at 5:36=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Rename QAPISchemaUsedTypes to QAPISchemaTypeAnalysis and broaden type
> > collection: instead of discovering types transitively from commands and
> > events, register every non-implicit type upfront in visit_needed() and
> > let visit_end() resolve their dependencies.
> >
> > This is needed so that QOM property types that are defined in the QAPI
> > schema but not referenced by any command or event still appear in
> > query-qmp-schema output, making them introspectable by management tools=
.
> >
> > Commands and events still register their (often implicit) argument and
> > return types, which visit_needed() intentionally skips.
>
> Either I'm confused, or this paragraph is misleading.
>
> Before the patch, we emit the types used directly or indirectly by
> commands and events.  This ensures that you can start introspection at a
> command or and event, then follow type references.  We emit exactly the
> types reachable that way.
>
> Afterwards, we emit the types used directly or indirectly by commands,
> events, and user-defined types.  Now you can also start introspection at
> a QOM property, then follow type references.  Since we don't know which
> types are referenced from QOM properties, we emit all the types that
> could be.  The only types that can't are implicit base types and the
> builtin integer types we don't expose externally.
>
> We could instead simply emit all types and call it a day.

Indeed :), in v5: - added "qapi: select introspectable types
directly", simplifying type discovery

> > This makes the x86-64 query-qmp-schema grow from 244K to 265K.
>
> Based on current master I see it grow by 9% from 246KiB to 267KiB.
>
> If I make it emit *all* types, it instead grows by 11% to 274KiB.
>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> If we simply emit all types, we can drop the previous patch, and dumb
> down introspect.py to visit the types without ado: drop .visit_needed(),
> ._use_type() and all that.
>
> Thoughts?

Yes, I would rather do it in the later patch, rather than make all the
changes in one go. That reflects the actual progress. But I am fine if
you want to squash them.


