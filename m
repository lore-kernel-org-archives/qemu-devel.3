Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA24CD3427
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 18:34:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJy7T-0005Ep-BF; Mon, 04 May 2026 14:34:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wJy7P-0005EI-32
 for qemu-devel@nongnu.org; Mon, 04 May 2026 14:34:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wJy7M-0004np-Cw
 for qemu-devel@nongnu.org; Mon, 04 May 2026 14:34:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777919647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q8U4gt7XdTBjrvU/gchWbWvufUPaR1LcbzUBj2xnTDk=;
 b=Whb66sLgaqk1TDRS+anW+FgdHYvvKjfOkJ60UTPLizW6R343pTYbE37+s+xE+In1eRcNmu
 tFpb94wOavikHQA9XakuaG32kfgs9ZEYk3VXsA6Zo6DfO4aljPL2ZczM8P/3vPFCTYdP5Y
 Ds/zkKibbgzewtsKCNY5ZG8u9mxZaG4=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-LUdQSsUAPYGaba7KipdwNw-1; Mon, 04 May 2026 14:34:05 -0400
X-MC-Unique: LUdQSsUAPYGaba7KipdwNw-1
X-Mimecast-MFC-AGG-ID: LUdQSsUAPYGaba7KipdwNw_1777919645
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-7bcd5d5cd00so86649877b3.3
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 11:34:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777919645; cv=none;
 d=google.com; s=arc-20240605;
 b=XYlvSIaKjf0I+GD4hWCRT154q4JjpluAjGTSxzisydSDsbOH3176DNVgfa/3pqTECG
 v4H+seDU1VHWGCfa0WyAP0nzmG2dvwPoSuVqAk7OIJWpx7OQJVl9VL//cYPUN8eYhe8s
 wbZtIJJ7o5fhqxqF8b82g9aomrRM1jy7M4f8Vfu0s393DPvmUcTR2Ni32eE8PcXzOctV
 Dzx9EH2UQurcQl9/bZhmE/ZJnNB9I8ayObqP/vawlrzFTnGtoRvfiEV/ylVn5/yMK08d
 UYC8WWu1hIaJFEWbyeV+8wuqM0jORyDNtVq0zwlnuT2/G+UJc6fik5ToGPawVlW1SgCJ
 yyuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=q8U4gt7XdTBjrvU/gchWbWvufUPaR1LcbzUBj2xnTDk=;
 fh=+z5tikevQ4wHwwKyvgskl+NaTdhidt2oZwpxvMuW+6Y=;
 b=G/OHg+laL0++rYApEvnPOxfFDfNyYBF4ahQO460UKr1JM2eGWBZ0iEgZsfbLmkopcP
 nuCcBQ6NDKNuz6YTnSyJbThliZ/247JkVC+z61OI1IsZC2dkW86tTDEqz4xmeK8UxoGF
 RfYEdPfGdSc1fI30Ucy4WDSvnkznC4FoZajo04UlqZM4lI7UE1FxijSb8k6QFbZScvzm
 Wjoh0ggxCQFPPUVnWQiTg8e1Hx5Tz/DxoZmWYeVkqVi6wLqdaG9O80YH7qWfTM+VZMWM
 5lKVgZz4jNoCem2gXsqQJxC8ouNIOOnof9ZXUS6TWLUyX6NqTXeQYs4o9oIu3vkbzsc/
 5g/A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777919645; x=1778524445; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q8U4gt7XdTBjrvU/gchWbWvufUPaR1LcbzUBj2xnTDk=;
 b=H/foEcien/VMy6WlqYW4Ov/Dg2TWgnpzyVgfubkiCEcliH+kmrepL9GL9Zb7x/O4gq
 +hRaPpCaYex/UG+8jeMKV+Kuxiisri+gtYtzlcYQq1ZVDhL5g0RhqRLle0JQU3ORcrdb
 exABzYaDSSfY0RAW+wre8bIlvtClvH0+wMXT7h4l0xrp5t6rJ9KrWS8N24JO3LofddA3
 CoPCNZPuKMOC6GIvG4jOG2BtGGxlb5u/ImChI1Bo+s6naGlZgXtT4b17KK4hzR4o5vRi
 /oKSgPsmBn80E5ZnfgtC5Delz48/slNJDuX2PHEO0ks4aYlMrFgYXIUvDRIZz07vYZH8
 LjFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777919645; x=1778524445;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q8U4gt7XdTBjrvU/gchWbWvufUPaR1LcbzUBj2xnTDk=;
 b=nYWyyc9aR6ItkteqTrHbn9EEqebaScAr6vGkmwUy0oVY0w/8q+mz9a1GGYIYfUJAbc
 Nrlu+2gkf6238Li718nXiOuxnZEUUp+OFOqr0C0GWJ0YvzXl79mU0O4bgU34RDvK4M3h
 FQKyrtoU6rP7sDj1D4CKdBhQJXYkbsir/Bnq3It5iDCh87fEcADwK2HcPfQxV/RdWLV3
 A89s8Lyi/4HBJi66jilye1F9ivqw0XNVccIDPMJIte+ykB8OlfvIXysarEJYSIneXC2I
 TOji5Ib4JLsqFodrm/NIcdCU0V4rj/kMlWgLYNFSxppOjdDQJ410K11hjAegNuMz+QLr
 IFAQ==
X-Gm-Message-State: AOJu0YwDzbV+YoYd9qhYCyMXNPuF2whhPdaUG/RXteKk8AdPvOyHlRbP
 T0JGsZvONXGbeFV9UsBgYFp2C4LnySXMrQp5VWPnO6qFQBye86rglshFmW3OzD8XFG8xyIrbaOr
 6SefYeeFlUFWV3KPo/1m2sHqWw/qoBpPkenU39fbyJfa1dlCnjJNmaCeTphwPL871sf6sU1uc2R
 mSiPaD/9zTC5sFFBDtN4894TGZ8dgdqyQ=
X-Gm-Gg: AeBDieuNqqA87aAr/1iZgdAHSbRzGkOb/JE055P/esLGzo1lIOVWHdCuTbxJzfOKsEd
 xpu9R1TvhipH1xgDPU6IxHF+Hp+zpHIsXq1e1RD8hokVPf5rbwj5B1zjskYF8XeboJK+dsOV6pK
 J/Ajtm7cUx5+2A/F63jhOmYGOVXSfmEKhZeItZ4l3FmacI/tvJByp9AYhrLf5gcY8sHc8q8xxLN
 wkvh06Nt358ergjHWqfzvW7m1NZ9LXsb4vxRqte0rXn1/sB
X-Received: by 2002:a05:690c:84:b0:7ba:ef98:9714 with SMTP id
 00721157ae682-7bd76fd9588mr118350077b3.14.1777919645218; 
 Mon, 04 May 2026 11:34:05 -0700 (PDT)
X-Received: by 2002:a05:690c:84:b0:7ba:ef98:9714 with SMTP id
 00721157ae682-7bd76fd9588mr118349797b3.14.1777919644848; Mon, 04 May 2026
 11:34:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260429192611.1581223-1-jsnow@redhat.com>
 <20260429192611.1581223-6-jsnow@redhat.com>
 <87o6iva0a7.fsf@pond.sub.org>
In-Reply-To: <87o6iva0a7.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 4 May 2026 14:33:53 -0400
X-Gm-Features: AVHnY4LGeRprdR1qtk6isyo2cKeJJg8KjrdYtPthjhE_Pco_09gaUejv29SXTKo
Message-ID: <CAFn=p-ay-MYA3Y8L9mRbKiW7zq8R5PPe8-0=2XQ7yCi9+o78OA@mail.gmail.com>
Subject: Re: [PATCH v2 05/13] qapi/docs: adjust stub member insertion algorithm
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Igor Mammedov <imammedo@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, May 4, 2026 at 7:20=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> I'm feeling dense again.  Please be patient with me.
>
> John Snow <jsnow@redhat.com> writes:
>
> > A forthcoming patch removes the implicit PLAIN section that always
> > starts a QAPIDoc section list. Further future changes begin converting
> > "PLAIN" sections to "INTRO" sections. To accommodate this, the insertio=
n
> > algorithm that places stub and dummy members must be adjusted to cope.
>
> What are the stub and dummy members?
>
> > This algorithm can handle zero-or-more PLAIN *or* INTRO sections at the
> > beginning of a QAPIDoc object.
>
> The revised algorithm, I presume.
>
> What's the structure of its valid input before and after this patch?

Addendum thought: this algorithm is more complex/flexible than it
needs to be with regards to what possible inputs may be, but this is
to allow it to cope with a changing parser during the gradual
conversion.

Take heart: the .ir outputs do not change at all with this algorithm
change, so you can feel assured that it Does The Right Thing, even if
it looks hideous.

--js


