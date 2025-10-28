Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03760CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 12:59:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDjIB-0005HV-7W; Tue, 28 Oct 2025 08:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDjI9-0005HM-CR
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 08:59:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDjI5-000823-A4
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 08:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761656345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D3d+zpKdqGoIvBJyEPFNCgv2/F7htFbtupbv1EB8cpo=;
 b=DW/DLtIwuO4XSZ8BuC2xECekRyjB0WE4MoESPTsFx1QmPlKKPuz8EEpsgzAv8Fg7ABPRHE
 F7ueJc1ky9Raypy2rCc5L3F9f82rHcMP9TnTIgNuUoBNcCo1TlMQLZX48HmgCb3rIYhc9X
 kMFjOjoj2yEJvW9si2HsCpyGuhDTunc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-CEC5r9r_Peeon6xexZFmGw-1; Tue, 28 Oct 2025 08:59:03 -0400
X-MC-Unique: CEC5r9r_Peeon6xexZFmGw-1
X-Mimecast-MFC-AGG-ID: CEC5r9r_Peeon6xexZFmGw_1761656343
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-42700099ff5so6200156f8f.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 05:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761656343; x=1762261143;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D3d+zpKdqGoIvBJyEPFNCgv2/F7htFbtupbv1EB8cpo=;
 b=Y4FhNtUp1x/+r1peN5EcvLuJ/Z048X4/Nt7D4r+LZR6U6+iv29mCjxXhIDUQ3b1obm
 UO+zItfSSrq8RwKydfXFCDwYaYWS6tkA9mI0TiIOV73PtQnca8QqdyrOOvtnlycuI+Tu
 aGvkYAbnV5cZRaOHxm8d6d2i++nYETG47hD+j0W+G5q/DH6jivtajhajp/29ECDo+4pS
 a7Ugku3Z22T3kq6eb9IjV0trXUGdzL5MPUE1Q69neVacqZreeGLhZQjLBQUxIOq6/4Dg
 JoWhEMkIKnVEE/mZF40IUmTjfm9Y4RosHOBjrOOcJTvvi7S7NarFPAw+ztmqH4WoKRNv
 wP8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7inWrceg4AfJY2b/7fJsl43vzvaCuE345tfp3De6KBF93GWjngZAA8+/Qir8hv6hFXzoPXrkloMF7@nongnu.org
X-Gm-Message-State: AOJu0YyjXTrbLECgoihE62Af+WmckjlPJOSoAGBpnxkW+44mdgXWNe2+
 aIqZPyVlklOU5UpH0nMyhuLcRYvy9rheqIWIxIvv3GP+xI4+z51NDyMi6OmPGpers/qs4yYVI5n
 DQVPrQ7uT2o5nO1S1Ja85lsFGjxRTnoomgf/yRwrdW+WWpzQWG+S9NNIp1FiE4L89O1zmv92a75
 im14ogG+axo4PMx51osYasychU7UnAPVc=
X-Gm-Gg: ASbGncv57C2tKA8kEyY7TI1Q7PDJkurDUoL7uByLZnNkX2jUbsn0J5uOOF/md1WtJP2
 4+sf9Yr3LY+ieL+0ujHkUBiLlW1+iQS+xa4YuTOot9XqjGk9lli0mapiOSnG25CtFLKkc6qlUi4
 MJYS6IEBmW5toa57gRKhb80mjWpNkncd0A4JzJHyaHWUdOd2DA7agJ05JvLFDGXJhpSnIXNdGH8
 CtWiF/vtOU2vj/Ha6yLA1+3fuI0WwqNA7VmPG4p13PPIwz40irBHez69/2e
X-Received: by 2002:a05:6000:400b:b0:429:9561:910 with SMTP id
 ffacd0b85a97d-429a7e35ca0mr2696378f8f.10.1761656342717; 
 Tue, 28 Oct 2025 05:59:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHq1ZwtORnUD2Ond629AqWd8dHl2xUJuYKtuODBa8ycE6MXkW508oXVB3TnjTHkyNtvU2UfdjfFJG8zvsb6TB0=
X-Received: by 2002:a05:6000:400b:b0:429:9561:910 with SMTP id
 ffacd0b85a97d-429a7e35ca0mr2696358f8f.10.1761656342290; Tue, 28 Oct 2025
 05:59:02 -0700 (PDT)
MIME-Version: 1.0
References: <20251022101420.36059-1-armbru@redhat.com>
 <20251022101420.36059-3-armbru@redhat.com>
 <58177628-7349-4450-a4c0-58bd44b39586@redhat.com>
 <87qzuniadg.fsf@pond.sub.org>
 <CAFEAcA9bpZAKgRpU=38-eMiSY=4dKdT8uQNFW0Uuk9y_Dya_0A@mail.gmail.com>
In-Reply-To: <CAFEAcA9bpZAKgRpU=38-eMiSY=4dKdT8uQNFW0Uuk9y_Dya_0A@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 28 Oct 2025 13:58:42 +0100
X-Gm-Features: AWmQ_blVMZTCgEuFLsUTdM-wSw-8-jLyLDx-y7_iLClXDtBxfDFgybOqCl-xuAA
Message-ID: <CABgObfb37Ept1DoTbeziOOpR+FpuW3KiwDKr4iSOYvg0_rM5gA@mail.gmail.com>
Subject: Re: [PATCH 2/3] qdev: Fix "info qtree" to show links
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 marcandre.lureau@redhat.com, 
 berrange@redhat.com, eduardo@habkost.net, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Oct 28, 2025 at 12:04=E2=80=AFPM Peter Maydell <peter.maydell@linar=
o.org> wrote:
>
> On Tue, 28 Oct 2025 at 10:34, Markus Armbruster <armbru@redhat.com> wrote=
:
> > The problem: PCI addresses are integers in C and in QOM.  Makes sense.
> > But "info qtree" has always displayed PCI addresses in the form DEV.FN,
> > which also makes sense.
> >
> > The pre-QOM solution: qdev property method .get() returns the integer,
> > .print() formats it for humans.  "info qtree" used the latter.
> >
> > Aside: "format for humans" may well be more widely applicable, if we
> > care.
>
> Relatedly, there are various places where we define a "string" QOM
> property and then format that into an underlying enum

That is intended, a QOM property type can be any QAPI type (in
addition to link<class> and child<class>) and therefore it can be the
name of an enum.

The PCI address case was done like this (I imagine) to avoid exposing
it as a string.

Paolo


