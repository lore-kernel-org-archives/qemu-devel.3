Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E3F2C87FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 21:27:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uk88K-0003SK-Oz; Thu, 07 Aug 2025 17:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uk88I-0003QF-EL
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 17:26:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uk88G-0004at-78
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 17:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754601996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GTeEBL8nyFeJHK5A/X+RrstT0zJ5c4lPgmQhPFVvg7g=;
 b=iVn5fCghhm0+yrHO9jLtbGy76++j7+3wTKv04kVsZ9f/7nN7OU2R9yqm4wF1wDmf7egYah
 P1jrfx3SiJx/+y39SmVpLEGA9sPLVEZtK7jYc7KLUdqQEiWnca0nm+g9BGEhy5S+K1FDAU
 VTM7jZCRoEq9srXQn2fqcyQBuuu6Tl0=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-ZxBMjEGGMQGXDWNKxmFB9w-1; Thu, 07 Aug 2025 17:26:35 -0400
X-MC-Unique: ZxBMjEGGMQGXDWNKxmFB9w-1
X-Mimecast-MFC-AGG-ID: ZxBMjEGGMQGXDWNKxmFB9w_1754601994
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b26e33ae9d5so2594715a12.1
 for <qemu-devel@nongnu.org>; Thu, 07 Aug 2025 14:26:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754601994; x=1755206794;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GTeEBL8nyFeJHK5A/X+RrstT0zJ5c4lPgmQhPFVvg7g=;
 b=m3OM9xV0cS1b58J7GGbqDRgDBLEULeL7ZX4drbNw3hjWQkqDTBkfdyKp9owt5jR3U9
 KwDKujqM8XzlKrr/Xk3S1XL0/+GyLITD6dNHtEc0VZOqqYC+Rm3RKTyEsE8SrP7EZa6M
 dt+SBRRWbEzrHL/T4Mz/lHPcFVN7q+DGN791YyYZ54ySYdmSFyWWtHXHHWma4T1VlXi4
 suXZWxbPQLuQbqhKsnVbJThptnYwjNElNts0W+4BpVi78Mu9NnSmAXdfpSPTVcj5GRdG
 gH8zWv0fJzoow76tmP4OkfZhmTTW5Gb/tBtGhi2tgfaagpWEVBTFlLIotX3yUUM1iqa4
 pQGA==
X-Gm-Message-State: AOJu0Ywdo3gf3f//1INqUXlhJYdwFN0oEvEgmdRoutP1m9z4m+o0aVB4
 UvnoZWP0CDoO74kj7IZYQYcaIR/GmYDNg2QV3Zc4o+6OzxyuezwuB7P4jnfHXryc4EWY5Vq1M8A
 CbmsD4+rFGvgOLEkrgjE0wLSHvRaEdLrDBWPOi1jLGslIRACe+vLfCOfRDX2wdWcWNg83Rec9U1
 vSSvhfEHUfPxLrKErvkdQpb/DEMz/YAqs=
X-Gm-Gg: ASbGnctL5fp9tXP8DRJKeFafT5zQpjgqv1F2BtN9MR4CWf0HvmTIKrS7bv82M5RCODD
 cqnzMpB0z+z3j75lA8c6QmOIseuJBIzY6jZm5kNmJIuGFjjfC8lQOTYU2V3FpIjslu2Qro5CukG
 Feyx2ksBmVMfWvutOC2AHWk1t8fZ6FeF1G7sHqOymScDu3w2DUyeG4
X-Received: by 2002:a17:902:c94d:b0:242:9bca:863d with SMTP id
 d9443c01a7336-242c2308142mr5181955ad.55.1754601994060; 
 Thu, 07 Aug 2025 14:26:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZzi1Ec0WlWsm7S0jMo1tuaDukxHcrxaVTv9AiRha5tipKUo+WML7LGFnqcQRg+ULIhRPbFhdWv3vKdP6AWh4=
X-Received: by 2002:a17:902:c94d:b0:242:9bca:863d with SMTP id
 d9443c01a7336-242c2308142mr5181745ad.55.1754601993654; Thu, 07 Aug 2025
 14:26:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250731054044.4011789-1-armbru@redhat.com>
 <20250731054044.4011789-2-armbru@redhat.com>
In-Reply-To: <20250731054044.4011789-2-armbru@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Thu, 7 Aug 2025 17:26:21 -0400
X-Gm-Features: Ac12FXxt-4_sijUJNYCmM-XRn9IHPTgdidrEE9p2pz_4HxieX7hUsCD-99HIuts
Message-ID: <CAFn=p-ZLAU-Z=7uCvqmWi-cmyBR0bbOaNJA7TehcQ9zxtK3_uA@mail.gmail.com>
Subject: Re: [PATCH 1/3] docs/devel/qapi-code-gen: Add two cross-references we
 missed
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, peter.maydell@linaro.org, 
 eblake@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jul 31, 2025 at 1:40=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Missed in commit 9c66762a601 (docs/qapi-code-gen: add
> cross-references).
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>

> ---
>  docs/devel/qapi-code-gen.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
> index dfdbeac5a5..138921b386 100644
> --- a/docs/devel/qapi-code-gen.rst
> +++ b/docs/devel/qapi-code-gen.rst
> @@ -646,9 +646,9 @@ Member 'event' names the event.  This is the event na=
me used in the
>  Client JSON Protocol.
>
>  Member 'data' defines the event-specific data.  It defaults to an
> -empty MEMBERS object.
> +empty MEMBERS_ object.

Admittedly, I forgot this was valid syntax - it's core to
restructuredtext and not a sphinxism, so it only works within the
scope of a single document. Quite suitable for this use case, just
slightly ashamed I didn't recognize it immediately.

>
> -If 'data' is a MEMBERS object, then MEMBERS defines event-specific
> +If 'data' is a MEMBERS_ object, then MEMBERS defines event-specific
>  data just like a struct type's 'data' defines struct type members.
>
>  If 'data' is a STRING, then STRING names a complex type whose members
> --
> 2.49.0
>


