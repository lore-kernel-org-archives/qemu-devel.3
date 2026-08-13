Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE94AC5CFDB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 11:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuTSu-0006n0-2j; Thu, 13 Aug 2026 07:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wuTSs-0006mh-Is
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 07:19:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wuTSr-0002Ly-0k
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 07:19:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786619949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=anC920VBtSox/VWRcyZYJdnAX65MxVa1aozcnU65zuw=;
 b=ezM+xeuvhnOoTlFSsj/ys6cki6r9/zJ+CxJFIwcPvvrv8daC4yrepYqD3B/KH0d/wC/Yxg
 VOrtOn9IKb/J1MqY2oV0b+INZrNBT+LvrJ/cazoIuF2sMi+CE8B6AwZ9wO4YV1TtyBznzd
 IuRn9sVG79qDH2FSqDKR8gDNYUnNY2Q=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-rhtdCtjrMf6CFzQmYoMHqw-1; Thu, 13 Aug 2026 07:19:03 -0400
X-MC-Unique: rhtdCtjrMf6CFzQmYoMHqw-1
X-Mimecast-MFC-AGG-ID: rhtdCtjrMf6CFzQmYoMHqw_1786619942
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cbee5bab340so2318499a12.2
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 04:19:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786619942; cv=none;
 d=google.com; s=arc-20260327;
 b=i9qPKy9StrIvmQUR4nzZz2GgTujaXl9n8mgkQgT0W+piof+FgFTO+zEgo41yWm9N+V
 eYNdrgyTCVVEE7db+70cXSEBtQ8l/Q12hGlf9Kic2GPYv6a1AGUExLAOa0ufHMNoQZAy
 HOPEnFMySBhf8jOnEeKees7sv7Pu7lveyMlnezV3gS4dkF8MFf6+QoPp18nGmXumloNK
 iPH3udHKxYNyFiaXmwoiVqBYjH/UHaY0f3Phj9heG8/HnqNDLx6dN6F2esnSOkgZ/e2c
 OpPnB88A4vx9n6Uq0m6KxcwG8arzmu9zbNKOActKbaRr/N0W+hUuM8K087VYPkYmJUPZ
 ucog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=anC920VBtSox/VWRcyZYJdnAX65MxVa1aozcnU65zuw=;
 fh=/dMNiWP/UJp0ib95kJpEXmCAYazcCM53J8+UCiPYHqE=;
 b=OyXlVl9DchGbQptQk2gdXjgJpHlrQejkRiBU1RKw5JQa6jmRICGK1/OMVewpI+4olR
 a8kSfzJ75Lve7Sc5WBsrS2eMXVaZrLy8E5TPygiWFSvGUfFqPtrprKSH0rzphz6Vt/r6
 o4Zj22AoBgSADsBTp+xXEMfqH2qon3AhQDDqJ5qKwnjQDaNvtHPTFB0XbfoDjKNQXIus
 RkZuld8SvUde/V6j7iGpLxVi0z0UUXrvE1f7Takp4hAxRuIezO517wl/1s14UA/YH2BD
 8LKtEuR4EWi787wByQulwhgkVgfH0r9ilLELXcTkb981jZFTSRUPgQwwzlkWlccrYJgq
 SqTg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786619942; x=1787224742; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=anC920VBtSox/VWRcyZYJdnAX65MxVa1aozcnU65zuw=;
 b=eyKyPl+GTtuI0cT19BGNnf141L9EsFbx0mlILEjkzMoFLjorOOlvKpJsXNmzXS9nCL
 4FB730HS9B3szt/DLKLWAAN1huGBzMYT42JGYno31J9zXXDnZgMuxle7qDyvzX0NycJi
 kjm2tT6V9SbCSI99uMNDFmgSwyv4pewt+z2ZV+WW1AQhnuwiBiy92eqP1JtqGAM7TOql
 32Kp9Xz7JXV+pZYak5lkpIkej4Hf6nQ/u2VfVo2mdfmdqwo/CiuqaZ8gKdzBwiNxOUsh
 XGDRZVBLq1IbayMupT+h6R7EN/CSsq1lr1g5BRwtFoNUQUEl+sl/glywgtdFiqvUh6ty
 7QsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786619942; x=1787224742;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=anC920VBtSox/VWRcyZYJdnAX65MxVa1aozcnU65zuw=;
 b=MFvfTdVf4WP05ie0vKj2rWQY+/xAyhC+J9f0d8EMSzL+Jpy2RsVDLS8DAVapPDynMW
 Mc7aQU4oHQrGA2YKdyL1FGTzHM//3F27D5OHAGnyTCzIqBu0XyCJfSNvFx2gOwY04XiU
 tkhQXT7Sn0Xdv8w3xylie6rjBZ/FfDCoR9SV5mgV1khDSrziRfpqpbx51rURiIycQxSu
 69T5/ZOabxan7zll5JUcdNQsWNLmbXwsWyL9XnJkB2H831Ajh9S0kziFHZAMO4q/FbAz
 SHkggWqqpDkyBxthjCJz7fcy1f1EKPCkvOl6wUXNaZSANxc2Q+ZOql6inD7edVu5ilof
 uWhA==
X-Gm-Message-State: AOJu0YxhAZdOdxMQtCzHnXIsn/Xloa1lYxK+poPHdXhMVQkQlRA7czfq
 moyMyljcQcsaXqaEPhRvclte/iB/uuR/VX7uSok7RdRUeBiyRXyi8YRyvEIoDEdScrmr/HlrzE4
 w9dr0IxctesYExXZm1VuuDNkJTJntJtKvviwVS3ao0CLHnePzqd9DwBsPA/oFmHDvhhd8dZLIDk
 jnFuUcwSWq5hV4r6UxTY0wlKldMsxYbIM=
X-Gm-Gg: AR+sD13ILtcuAImUZ0tfNdqQQR0JaB9PnbuILNh4AnKF0BV/AnddJLUuoyS5nwGo+qo
 XmYg9DuOhP3wJ7/Qm7G0sLk6lqB+3k8HHRCo8mOYtsJUFEq8tAtgPBrfqykw1WV1a3lxGyM/CAb
 wAWbOOUMpEdaN/zgWCMSCI8KiXRyO3+lfzkXNq1X0ahlWxvoVZ4sDCYmLKrnnqCpps6eE+12LcU
 FaKNWdIAtl0SN+xw3mdTRjHrnPsZY8OGTDKGmvwfU/ygcbD+UYhDaTBSKyZS/tt2xTfrKPbol2Q
 Cw==
X-Received: by 2002:a05:6a20:6f9c:b0:3c3:8d86:9855 with SMTP id
 adf61e73a8af0-3cc5506297fmr6607084637.7.1786619942350; 
 Thu, 13 Aug 2026 04:19:02 -0700 (PDT)
X-Received: by 2002:a05:6a20:6f9c:b0:3c3:8d86:9855 with SMTP id
 adf61e73a8af0-3cc5506297fmr6607019637.7.1786619941829; Thu, 13 Aug 2026
 04:19:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
 <20260616-qom-qapi-v2-15-cc9396b9c18c@redhat.com>
 <87h5l6p2x6.fsf@pond.sub.org>
In-Reply-To: <87h5l6p2x6.fsf@pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Aug 2026 15:18:49 +0400
X-Gm-Features: AUfX_my72HzIVXHIwNsKdVLlhAXsuFOZ_yNGEhBySqE3oAR_u83f4E8lpR5OAzo
Message-ID: <CAMxuvaxKby2zZmJ=G9XSJNSaSQsyY+6ouk6xO9GoPuYQhPk1bA@mail.gmail.com>
Subject: Re: [PATCH v2 15/53] qom: convert struct properties to QAPI-aware
 registration
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.759,
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

On Fri, Aug 7, 2026 at 3:48=E2=80=AFPM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Convert all callers of object_property_add() and
> > object_class_property_add() that register struct-typed properties with
> > QAPI visitor-based getters/setters to use object_property_add_qapi() an=
d
> > object_class_property_add_qapi() instead.
> >
> > This replaces the manual string type name with a reference to the
> > generated QAPITypeInfo constant, enabling QMP introspection to report
> > accurate QAPI type information for struct properties. Existing
> > getters/setters are preserved unchanged.
> >
> > The cxl-fmw property type is corrected from "CXLFixedMemoryWindow"
> > (not a real QAPI type) to "CXLFixedMemoryWindowOptions".
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Same commit message as the previous patch.  Accident?

indeed, squashed with earlier commit
thanks


