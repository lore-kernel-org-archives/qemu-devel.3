Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF4CAD59F56
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 17:50:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8kAN-0001CI-JU; Wed, 06 Nov 2024 12:50:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8kAI-00013U-BX
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:49:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8kAG-0000Hx-Q0
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:49:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730915395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BCIqZBWhpO7ziTjD//cwUGzrhanbYQ60UGS7g9CwV0c=;
 b=hXmeUJ+fqZEtapqnRzFR5xJc5MvXgljoQj0piniAqD8y2cvMcQSwmOEvfJVkBmvoowcH2W
 wrqDZGftDfLlOM9mtHhY+gcrrYHXWBF2OEvT2acczOj5iFDlQS/8brZbSYQmvIaCr/4h1P
 Wb8i2Ds+qc5QVwHsuBIuqiXy6eLvIUc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-6rtBwO3eO9uWONdTn6kUpA-1; Wed, 06 Nov 2024 12:49:54 -0500
X-MC-Unique: 6rtBwO3eO9uWONdTn6kUpA-1
X-Mimecast-MFC-AGG-ID: 6rtBwO3eO9uWONdTn6kUpA
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4315af466d9so415555e9.3
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 09:49:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730915392; x=1731520192;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BCIqZBWhpO7ziTjD//cwUGzrhanbYQ60UGS7g9CwV0c=;
 b=s+50ov9RsR9VDas5kFvM4/hiVRD3UCPgbrdOCZdGTydvOhxCV9rjSoq8nwozgxgHgL
 8mHcvXe2Rii36tdesnILw0UgkhcVGnU4xRoyGu15UwDB2gOavgGmAo75w1pR8s3im22E
 vqhITF00wS57rTiGxwi/eRc3Q1YUk4VY+ESrE+3zQ69CNcTKVRFAa8zVEtYL2hiYbsmi
 aN1XddcIGXwlH/JI2n/pRbiMISWcdQq1/GuGdtSAyLKpRyx+P+clGyJKlE8ZTAivGkTL
 wLj9E8Ec3WoI1mCXBIRY7+JgNQlIBAdLZQEEAtVEm9w2sp/LhFk8VtQL26M/s63uzRAU
 rWBA==
X-Gm-Message-State: AOJu0Yzq5ljxnDf8ORQkHQ4bzqTwqWTF8XWRJeP2oDMlR9dlC24WxswQ
 Qlrvdq2bSPEF4+42zsWRULy/6orPw/w2XOiRLB2Yo6g5xniXVlf5KGyrrO1aBp+yrHYrj18BOG0
 x2/X2WFpGHu0rBv5l7kkKYll+2C1uiWmoZvzPtmPdfrnBCzBgOdIfEQ9fhyEEiPNWLrvZ34ZUS8
 suyvLvEvcb+Uvqc18iObLBdnSKrqZK6bZ3L6xa1Q==
X-Received: by 2002:a05:600c:35cc:b0:426:6f27:379a with SMTP id
 5b1f17b1804b1-4328324b58fmr165691815e9.13.1730915392625; 
 Wed, 06 Nov 2024 09:49:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRELP7SjY0Zl/AzG7c3jBHK2ewNs7+NPCVFEsMZxlgEz2FEfkgNjHMlmMmzwrcg443BKCIsdaK908JI3Q+yG4=
X-Received: by 2002:a05:600c:35cc:b0:426:6f27:379a with SMTP id
 5b1f17b1804b1-4328324b58fmr165691695e9.13.1730915392354; Wed, 06 Nov 2024
 09:49:52 -0800 (PST)
MIME-Version: 1.0
References: <20241106174241.556373-1-pbonzini@redhat.com>
 <04fd0b86-4371-494e-a331-3d5d735f0d77@linaro.org>
In-Reply-To: <04fd0b86-4371-494e-a331-3d5d735f0d77@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 6 Nov 2024 18:49:38 +0100
Message-ID: <CABgObfajkp+5vFnQuV+V6Mp+LuP_Yo-=JtZtGUcYB_GDDbWoJQ@mail.gmail.com>
Subject: Re: [PATCH] eif: cope with huge section offsets
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, dorjoychy111@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Nov 6, 2024 at 6:47=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:

> >       for (int i =3D 0; i < MAX_SECTIONS; ++i) {
> >           header->section_offsets[i] =3D be64_to_cpu(header->section_of=
fsets[i]);
> > +        if (header->section_offsets[i] > OFF_MAX) {
>
> Maybe we could add a comment that sections_offsets is unsigned, as it
> can be confusing to read value > INT_MAX without more context.

It does sound like OFF_MAX is related to section_offsets[], but it's
actually related to off_t.  So the comparison is with the maximum
value of off_t, which is signed.

The problem would happen even if section_offsets[] was signed (for
example off_t could be 32-bit).

Paolo

> > +            error_setg(errp, "Invalid EIF image. Section offset out of=
 bounds");
> > +            return false;
> > +        }
> >       }
> >
> >       for (int i =3D 0; i < MAX_SECTIONS; ++i) {
>
> Else,
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>


