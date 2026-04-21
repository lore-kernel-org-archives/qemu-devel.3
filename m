Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E7B1F94CB5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 22:40:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFJlD-0006dg-6y; Tue, 21 Apr 2026 18:40:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFJlA-0006cS-3I
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 18:40:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFJl6-0002TI-RT
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 18:39:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776811169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DDlJV8zCiL1cH2X4Tmrm8Rqqf5qne4decL7KsqjI5f8=;
 b=NTWliBncrkxe+jnB9EDByA2y1KSnO5j3PmLzCELoPGzswMlSeD361CgWSNvDMMiKPMubn7
 KGbIMlQebZcAsoLg5Y42kpHFonUVqvLzq81Hogct2F+z8bEZv/TK/dlVIAQb+J7sgGLZ0+
 7A7lkhGU65VavJkr9eIBNXrffOMgNLk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-a263I5l3MSWZhVk40H0BZw-1; Tue, 21 Apr 2026 18:39:28 -0400
X-MC-Unique: a263I5l3MSWZhVk40H0BZw-1
X-Mimecast-MFC-AGG-ID: a263I5l3MSWZhVk40H0BZw_1776811167
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-440d0d7872aso2272296f8f.2
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 15:39:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776811167; cv=none;
 d=google.com; s=arc-20240605;
 b=en4wAcyWIIN68B3fE43MVp13o8C9sbI7Y3JgcUMVB2Gm1ejDrFKov9lDKKp9fStEkW
 cRRMJhLXYuv1sq1jWMImhyolLeOpdXzxQq1sPdonSJFFRNyQaYnZXFskhyeQDOsnoSVT
 J884G+i5QOGrk3G2NwzFfks67BLLki+O098s1vrxEQqwxw6eImBE6JKmCLI3BRqQFFDI
 sKYrVcmTworpCjXEWFxtq2IWd5qa79mcUSSsGfGAGuAu/3FqY0qohaex1m5mcRjcQ2PE
 b4X3RW2w7plfs40if9+D5UVwiRfJB2SLnE8wgwMuZlYcccgIoNYxipFBInmHDVS0Pg2b
 QhOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DDlJV8zCiL1cH2X4Tmrm8Rqqf5qne4decL7KsqjI5f8=;
 fh=8aBEJY+feA7d7ThUvpzyIH9FOGeOtT6IdrliqPJEqPM=;
 b=RLdzO9lvS90gugVtVFrHcipYN5ETUnmM/GGE8ppEcheim7GS0HVpzNRtYgpp/xksLd
 OozDYJ5oQExl6OjPKgd6mCYiVvouIv5HHgThUa53So8fAXGXdfROSwEcfOlXJHxKOL08
 z93fdU/o01+hrypz1ukI/glGGmxgWdXFkCp/kYoPlZLdM6jNdfkC5tZ9VtPgXJ4JDfWa
 wtUJLkl6DvgL4vLgt+k1eiJ673V+QssVDksVbIBSsPxaKO04XNgGPxIIttAboRNgU2Gz
 mV1uxDbSD8+zK7bUU/yAWixArI6U/o/esoM3i/VUfb8PJp9SuCCNgZlOIeq77a8qjFzZ
 +6dA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776811167; x=1777415967; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DDlJV8zCiL1cH2X4Tmrm8Rqqf5qne4decL7KsqjI5f8=;
 b=dqLUVP9sYANAoIf3U+C/qRz3YbPboPqJOJ3Lkyw0iNRC6ATK/t//bcJr403AdK6kMf
 /Z3XsBkIuOWOLLQwGNPY6fCpfiByHFgl0c2XjwQDWcRSZaCheQJaY/XMvZRXfJBTR8Fo
 6iflQ0x7O6JiYUWuiymVvSEgRSmm6LVIafuj83+f0hEEufjdzs17SDXHA74ezcMWaf4d
 nhhKKIXIBB0Tmkk5jS6ltpD21BGartS9WmarU48uAfh9/IKSd4gaG2pnjPps16CJmRPm
 DUl5IFh7jMhHM7KsAqWU2Yl+QEV8BwCD3uiH6BvyjAIy0Vg32p0PUPglkEHtTIljQAiE
 UKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776811167; x=1777415967;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DDlJV8zCiL1cH2X4Tmrm8Rqqf5qne4decL7KsqjI5f8=;
 b=O9YWUetZqlo7JiF5iQDXHido9LCVZpHeyXVrrEHVIiaXf9xrbxzKHFjA7qfu+8BpGx
 kwxW3upT+Sz/bA8wnugeF4E98JLZBU7qnFkioZVNrmA+dppjbbk7CvU3cLSIfos8qDpo
 bKxjVnYJ7M+WoQycXKEfTP/HDLWjrysr4w93SmpKoACxItGtRKtsutsLbqLkrA0glYfc
 zDkoY19ZraApEUMZSw9q+LpmDfiXtYnWuZ2H8Uw6hVHWQDcp/7zbu21B5TiF2hEcUrPL
 xcGETkzwOAGoHWCKgGOnggP8GcLPubNziPlJbg8IL/TnTaGWwu1pa7B2QSDMsF35kmZ6
 wbTg==
X-Gm-Message-State: AOJu0Yx6jSF8xonmg5am7jalVv2KG7MoB8h1XsfheShFLVV481yxOLeK
 ZPFEqec2c+P5lMMGGkI5ONrpQ/LORYX4yg/n6eJD6BgodzAEFo65gdaXkbVeVVdGDeuIEI9M/aa
 A797E/O0O22F1YMFkST7ZtyYrF+zbClf4f6DkB1rn9sgUJd6LA8YQM4RxzX570F0c/JTmHH/1Tu
 v8EMGbg6M3EgGANSAO4uC9HN7LxroeO7g=
X-Gm-Gg: AeBDievyVRAHHG8fQeV8VWNcCwMHsiw4r9DS1x9WRkmJREwdWd8GxTj44uV18N3ApNg
 akZ7kdEs6ogRByFOYNoWCGu0L9UpkLnDXN9E4MnlGj2qg8weGKCTfobU6ZOQlGaz5MjU8GW0V75
 fYISLzzu8Hh/vXnUClM4fP2Eluxe/h8RnorB/HMiclafMwJU52e3pS6hy+aFGCTsVVlg32FBxl9
 Afm5/0edWAUr83JKuqh6WRBo9xP5fqrYtBBHpmx4ai3zTsMwagyd3HEeIIyzSjmO5nhTiJKA/n/
 gEaSJCumqXr2vg==
X-Received: by 2002:a5d:64e6:0:b0:43d:26a2:f8c3 with SMTP id
 ffacd0b85a97d-43fe3e14047mr32184050f8f.35.1776811166920; 
 Tue, 21 Apr 2026 15:39:26 -0700 (PDT)
X-Received: by 2002:a5d:64e6:0:b0:43d:26a2:f8c3 with SMTP id
 ffacd0b85a97d-43fe3e14047mr32184028f8f.35.1776811166423; Tue, 21 Apr 2026
 15:39:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260331095950.512326-1-pbonzini@redhat.com>
 <871pg87dr7.fsf@pond.sub.org>
In-Reply-To: <871pg87dr7.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Apr 2026 23:39:14 +0100
X-Gm-Features: AQROBzDXrRk884QYJn1PyCo6sC2825s138S6Fy_6H6Bw6JLOXZbnQjrv5LvDdBs
Message-ID: <CABgObfYRLUs96voXsxmSp-2fQD_UV6Yq3reaSYMbrf9gDp+DRA@mail.gmail.com>
Subject: Re: [PATCH] tests: add test for json-streamer.c error recovery
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Apr 21, 2026 at 12:29=E2=80=AFPM Markus Armbruster <armbru@redhat.c=
om> wrote:
> > +static void parse_emit(void *opaque, QObject *json, Error *err)
> > +{
> > +    ParseResult *r =3D opaque;
> > +
>
> Recommend
>
>        assert(!json !=3D !err);

Makes sense.

> > +static void test_simple(void)
> > +{
> > +    check_result("false", 0, QTYPE_QBOOL);
> > +}
>
> This one isn't about error recovery.  It's arguably redundant with
> check-qjson.c's keyword_literal().

Or the other way round. :)  They test different APIs which makes both
of them worthwhile.

> > +
> > +static void test_extra_closing_braces(void)
> > +{
> > +    check_result("}}false", 2, QTYPE_QBOOL);
> > +}
>
> Overlap with check-qjson.c's multiple_values().

Overlapping input but completely different test, because this checks
for success (after error) whereas multiple_values() checks for an
error condition.  This also shows the difference between the two test
files and APIs.

> > +
> > +static void test_bad_dict(void)
> > +{
> > +    check_result("{ 'abc' }false", 1, QTYPE_QBOOL);
> > +}
>
> Interesting: just one error, because error recovery eats false.

Why would it eat false here? The error is recovered after "{ 'abc' }"
and then "false" is parsed successfully. One error and one successful
value, as indicated by the arguments to check_result().

> > +
> > +static void test_lexer_recovery(void)
> > +{
> > +    check_result("\f{}", 1, QTYPE_QDICT);
> > +    check_result("\f[]", 1, QTYPE_QLIST);
> > +    check_result("\f:false", 2, QTYPE_QBOOL);
> > +    check_result("\f,false", 2, QTYPE_QBOOL);
> > +
> > +    /*
> > +     * alphabetic characters do not start a new parsing, this is sligh=
tly weird
> > +     * but it keeps the lexer simple and works well for QMP (where val=
id input
> > +     * is a sequence of dictionaries)
> > +     */
>
> Please wrap comment lines a bit earlier for legibility:

79 characters are Just Fine.  While I appreciate careful reviews, and
I will apply your suggested edit, this is perhaps a bit too much?

> > +    /* same as test_lexer_recovery */
> > +    check_result_error("{[{\ffalse", 1);
>
> Really?

Same comment about alphabetic characters not starting a new parsing after \=
f.

> check-json-parser.c and check-qjson.c both test the JSON parser.
>
> check-json-parser.c tests at the json-parser.h level, and focuses on
> error recovery.

That's what I focused on _for now_, because that's where the push
parser changes are more tricky, but it doesn't have to be that way.

> check-qjson.c tests one level up at the qjson.h level, where error
> recovery is not testable.
>
> Perhaps the JSON parser tests should all be in one place.  This is not a
> demand :)

Objection, your honor - different APIs, different test files. :)

Paolo


