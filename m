Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C73ECC6B12
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 15:30:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGeRn-0007Fa-AY; Tue, 13 Oct 2026 11:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xGeRe-0007F8-GU
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 11:29:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xGeRc-0002XE-Ii
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 11:29:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791905373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oBhDayz7n4MPunozcK6swbCSkeFih4p9JbBaeSQZwQI=;
 b=WrjnReotCGAr2O+uPBGp3/4WvHbY+fp6V/qTTXbKeE7a4Dyl4SWwrbrb7CVH1cAGJ5q63B
 xkO+vpV3jGVqYPpA/Fg9TGH0MENocA+GCu80PuwdVhU5D9GH9R15cSwV9sqea7QEJeUnGs
 tl+IMll5vKpLMnJh8mbUg64NJkb/5J0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-D90LQWlWNSi0Lte7tigVow-1; Tue, 13 Oct 2026 15:29:32 +0000
X-MC-Unique: D90LQWlWNSi0Lte7tigVow-1
X-Mimecast-MFC-AGG-ID: D90LQWlWNSi0Lte7tigVow_1791905371
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3a89dd31fdaso2684413a91.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 08:29:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791905371; cv=none;
 d=google.com; s=arc-20260327;
 b=U3A8XJdnxZwEyvUi5fnzeuNsnrXDpCxojtLKpvzatVX5hAqrtWjz3mcWGRwO+5bouG
 0q3ltbVL/FwOklCVFhrbRzxGfghG9rMI0OSGQUDaSoRouv33b+fymwVVyvylZcNO6l7W
 ksCSBaA/DLRYAHW8JMQBtPkZVBjURT9pO9ykl7HIdzksbTnHl4S9nf94WJIjhjXAuiy1
 RBZcmsYC4VEOnaZgWB0eTL/gEj8XDSFBftkb9RQum4H0Owe2FMeKwVl3SyCYRoMNde0y
 GdZIOOtXMBJd9Kw5xjX8+8IGJ6xsuTMJ1h0dtM+3t9PoqzpvGuKrdS5WGIVFBnHGpH7x
 4q/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oBhDayz7n4MPunozcK6swbCSkeFih4p9JbBaeSQZwQI=;
 fh=vR3iH5IUqSxBcZC3qE6t28jCm6GPo/CDwEFh7ntwqAA=;
 b=LTve71r6QCoUvy5kzfEDIx9tWOF/gL+2+aihvlBFOHBoE1svh/rbjoF4pq2Zh/TYvI
 4ZcKKSJ85eobORj99ZWB6cF44+Ve1r/UZIoCj6+3FrkgxDEFd5iomTLCm7dquo8AR9g6
 RUBullW/2RKgesG95z0kna3hA8Qz2GUl0kzU2TBYWWfig4OdJRTyBInvallezCNSUx4H
 zvn7ZwNoHWdrLCLZ+PIOpLQa9xrhN+QdoM3FO3pIu948ePlytNgqu3mXmPkN1FVnNc2B
 SrUq7/d5P4hxXJ6YceHlF6cyPMr51EcMYRYzqY3OOtdqKH58a1sYcqr0HFU3RXiknRLQ
 3jxQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791905371; x=1792510171; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oBhDayz7n4MPunozcK6swbCSkeFih4p9JbBaeSQZwQI=;
 b=T69ZwgxHxAWhuJFO6Vm2psw2PqPDlCXDyO5nF9Hk4Cbg9n6kjTEpEjV7fTZQHX4Jkb
 FTIKcdLgopT+S7CPk30VxTBWn+b3t1rwEy9LO/ADfKZX0HqmldN2rClsEphROFsu61/x
 HCSMWMoxUkBUgg4D4petUrpmVHN6ysdz3kYdeWbvEnnqN4Nad79o5IczcyMpfJT/oJtI
 3pQjRqx3Ap20NAt3JvRO1/imvcTMIcOznVm8Ph+R/nfAiGlDQGcHZFywXqRVFsAtK0X5
 Yf+g9fe2FGCxTOOI9y/MV5CulA7enZOhZwTXP1WuNKkFmEMbEq2yJy5T+BOQnBmYk16o
 zlWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791905371; x=1792510171;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oBhDayz7n4MPunozcK6swbCSkeFih4p9JbBaeSQZwQI=;
 b=J5P75eN/h1Aaewqm2A9R8dDa08tlWq+2RZCV13KnLZBlUlbi0H32X+MaWa5ePspX7n
 7XsYuQACzVeBD5umFQ7bSdlVrY3rxkB1YcIYmab0VmtaoSPGh4wS8atHvKb0/+OQdjrL
 7PYyLEg8UdUr8egLG/viJMROmkNFv82848Lij8HH8Y81yrjDFFEHi7D00bPQ/ZlbvU8V
 j5lerYsU6Z8iLyn3nrmPgm8V5u3eFt4p6d//xr9XWeuXd7fWiOIX3Z2Tsi2bw/8UCmdx
 6c3RuA35BluO/yVCcaoQp/f7NUsCrRyVOAr6JZd39w1AfUveHb+ilW4EcLzQXoaus0hM
 MAFg==
X-Gm-Message-State: AFq9FYKmh8pORJpyDyCioMwWBYtAKYeLn/kX7fh9ZarHld/5aa5ZVx2O
 s7Yt/PdXC2QdhOeBWZJAkmAzJHc2t4JlgZ169rj8YvdDKkQWWEyo8nGHwTPts7wcWBoeTJAf9qH
 QWDcof056EzEnRqJ2ocIErZ4FxWWcaFQ2/ZYxFCNJQfKoLPuzRexaSXU3fzVC9X7hUJuoTAlRIz
 d9z/X9uEe7uvwCj5tCOy+rpfT1/Xi6SuU=
X-Gm-Gg: AYBFou3ZMqjyMJsygJM0dMv+mqWVahyQ+7Ea/jHPwOyQVMz6yxXkqZILmczBgjm+w/b
 iJDREMpDoYT354fvVHX6oOqxCglyLhRD93lW1kxjSXIEW0xWwfsaywni1Sn/fgmPc+uw/kDOrkC
 kjD9LmvLp4lGux4khh0SKkQ1oRCAIQnwBPp/6lW9UHs0g7Y94hNUUeFHTAHyhD3RObps6NUbbKF
 Y3/Sm8tRAvKmCu7p0EA1iJiMh+LLwHwwb6p3dh1aCc3y2fthe+SS8SGt45hbLucp5rQTBdQ7ty+
 wA==
X-Received: by 2002:a17:90b:224c:b0:3ab:b64:5893 with SMTP id
 98e67ed59e1d1-3ab3ac5ecc6mr10738605a91.53.1791905371328; 
 Tue, 13 Oct 2026 08:29:31 -0700 (PDT)
X-Received: by 2002:a17:90b:224c:b0:3ab:b64:5893 with SMTP id
 98e67ed59e1d1-3ab3ac5ecc6mr10738576a91.53.1791905370758; Tue, 13 Oct 2026
 08:29:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
 <20260911-qom-qapi-v5-60-7732a55b7760@redhat.com>
 <8733u9ya8v.fsf@pond.sub.org>
In-Reply-To: <8733u9ya8v.fsf@pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 19:29:19 +0400
X-Gm-Features: AclHuK-Wx4ZwfUfkPPZRRFyNByW-tl3PXQUoqMLOwgO3zUbwQwPYar9L4F5WrBY
Message-ID: <CAMxuvax65ysmLnOEWbC87GrZxfc86a+7dOb6ZVwenz-NWwvNQQ@mail.gmail.com>
Subject: Re: [PATCH v5 60/62] qapi: expose integer signedness and width in
 introspection
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On Tue, Oct 13, 2026 at 5:56=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Integer built-in types are currently canonicalized to "int" in
> > query-qmp-schema. Consequently, clients cannot distinguish types such
> > as int8, uint64, and size, even though they accept different ranges.
>
> This is by design.
>
> Width and signedness are an implementation detail.  We can change them
> freely without affecting syntactic compatibility of the wire protocol.
>
> If we expose them, we can't anymore, and docs/devel/qapi-code-gen.rst
> section "Compatibility considerations" needs an update.
>
> Why would this be useful?  Knowing width and signedness narrows down the
> possible values some, but it need not be tight.

Well, this was just a first step toward a better introspection support
for constaints. I understand the wire format is just json int, but we
may want to express ranges, enumeration of valid values, alignment,
string format etc.. Exposing signdness and width is the basics, and
establishes a pattern for carrying type-level metadata beyond just
"json-type". This enable clients to do proper validation and UI
generation without knowledge of commands and internals.

>
> > Preserve the individual integer types during schema analysis and add an
> > optional "integer" member to SchemaInfoBuiltin. It reports whether the
> > type is signed and its width in bits. This also preserves the actual
> > element type for arrays of integers.
> >
> > Teach the introspection generator to emit integer values and update the
> > documentation to describe the extended schema information.
> >
> > For example for introspection, for all kind of int, before:
> > {"name": "int", "json-type": "int", "meta-type": "builtin"}
> >
> > After, there are various int types such as:
> > {"name": "int64", "integer": {"bits": 64, "signed": true}, "json-type":
> > "int", "meta-type": "builtin"}
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>


