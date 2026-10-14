Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D4AC3DA7A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 19:15:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH4Qj-0000gl-NX; Wed, 14 Oct 2026 15:14:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xH4Qh-0000gc-Iv
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:14:23 -0400
Received: from mail-dy1-x1331.google.com ([2607:f8b0:4864:20::1331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xH4Qf-0006ij-JA
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:14:23 -0400
Received: by mail-dy1-x1331.google.com with SMTP id
 5a478bee46e88-35943f55c06so1231018eec.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 12:14:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792005258; cv=none;
 d=google.com; s=arc-20260327;
 b=ih6obJWlIk5w0DIKQdF2aKl6u0DSLoTZI2iJcIDbPR9020gXIqUDrAWgIlAItSFWm7
 fpTWmnDA6e6Zwseo+7IbuefpZTlPmfAEpgXrcOMe11SVdl0jRVpvuxIaUZFdKoFVDwPA
 zDCTramXJfhLdYo55590K7Z+bK0d3quA0NhgmpHGVgd5Qi+bzLJ1gZm5FdH0PqXWvdqI
 DLTbeaD+iaRps8A+/vXU216Y2AWmgeu/1E8QLvwXGcdI9t9g0F8V9sFsQoeevCPE1AmS
 l5zLdzVw19+pagfBtuSrEhxNBRx1kOdM7pOTpcXSIova2ll08IWcmP3MpcO7gy2fQpX4
 zr4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=735Ls1q+8Y+fvq3kiaRsYoKzWNJ+NsaEKJXUCbSDGiQ=;
 fh=vR3iH5IUqSxBcZC3qE6t28jCm6GPo/CDwEFh7ntwqAA=;
 b=A0SOdAswqD9lkz62V9MLNk/ots/bKXlmWZhRnvFclaWp2rzMpMoW8jdPHIFs1gtJgW
 hy6WTIVxpE8N93ahF0H17j0QYCslOpelRVQfTFGxq1mw0aAtPB+ICyZnAo3wiJ41xHyJ
 H0WYi2XqHpS8GT1oPUJzEMnkaRM5A56oVxPuD//UEkwMfxiInmLBur6jt+3kvQLos98I
 1oPlaCkhIhE+vNPijTkLmZ8RaMCG1k59a6yCCqpIWyafUaMbUKzY2HL+gKgiVW+9uMuR
 UfltpxA/ym+MgY6kCx42c/T/+XPtTyh+MLFOSpAxZrS5uc7scY3CyHIdIe+KyAgnHQ8P
 GIww==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792005258; x=1792610058; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=735Ls1q+8Y+fvq3kiaRsYoKzWNJ+NsaEKJXUCbSDGiQ=;
 b=Y8aMmjKdAeblUnOCbM3wkQ/i8zK58xorK1Y3f4WcZTId3DoKEB82FaKsBtgvO+uPe8
 /8p5JgArGpbWhPHXYx+wsXUTsu+rC2b8qkS8upDcPR824xKEv/Du7a/nuohqoItL3ynI
 9qxVIBAugUME0DYDHZmt4AuAAICHgr2PD7ByD18uNBq0KiPQt7en9giZ6FeBq9oQIZxE
 R0JkYKs5kpI26RH8pM0a2Ch3DddZ/IOP7KqXXnCC2S+h7nbqujaFP4ihXgLr6H0ucSlb
 YQZ9QaXtJcHNf0/yqkJH2O6hkktOtuQY8FH2PYia7Pi/cEm3+/UCkuxXOP3A0Pfotjcp
 NE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792005258; x=1792610058;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=735Ls1q+8Y+fvq3kiaRsYoKzWNJ+NsaEKJXUCbSDGiQ=;
 b=0Pzg941Udp0MVf1hyBFHaUq//vvcqzKETIi39Tmuz93HKfTWrpLbklJpB4hiWT+igh
 WckFkmK4unAxJSb6PvCb7BJnoxJ+F+FJ+ldFZi+7kGiDh8OiAMea8ySIQ+8+WdmT4P3a
 JJ7zUjplfZmm4vgxxHl+7MwTo7XCwT2y4GGWxHNNoaxhHUPHt5JzJ1042AhhXw2Kw5mv
 aDxmVWLn57n/sKjOzxr3rh8zXj0ZohCZTazy8Zx2oIalx2k+nh3zfAGb9/KroViAV8mC
 Ot2BvYh58vDnyu2p6QSluj4XqkJvWXL0GviogB3YDUNIEVJ3ux6ko026Z5l0mnIJ9bko
 4COg==
X-Gm-Message-State: AFq9FYKJ2VwEQ56zvQn8+zDDNE46IOdtNYPpW0jLoxm+ok2Lbk5K6fuI
 vaElTYj45IWx31UNLxg0QLlslMlv/PhkpLsN+1Q23vuiOFKiEYVtBfCa7RUaaAJvm4sMvVFgTIf
 0PIkQagPIfCk2aptu3kxyCNm1tWfjTFs=
X-Gm-Gg: AYBFou25UC+8taYLeGH5UWRn46ax3UCLGCCPaacouLVlN3C0rVIE5Me+DQ5izCKJuDN
 HcjZe1dc48/Xiopl3QvmLsSYsk2WqrUxrnHI09i8RXU3sY1BODdlZcmzFrb0odMQcUJCNWsyWFF
 zRUrmkMnGtA7SKj0Jph3Oq4AVE749laNIfscOgM/RIp1np3PsXsX6B3x9uXuU72Uy36GJGFq5zp
 7rSK7GLUTBvyODJzDG6Mr3FmatRRXUPXo02CQG/rUTzbkOzaPiY4I5dmYNymSsFBEigU9dQVIIm
 sZ4Tu1H15XJA4/lvRo/j/KGProDQQBS1DlPaOBAMrI857Smbo1FBw83NV1xRCE+dF3MC6Vdqo03
 s7D1LD5d+lMo=
X-Received: by 2002:a05:7301:6794:b0:351:606f:2832 with SMTP id
 5a478bee46e88-3537df77e03mr30710969eec.3.1792005258432; Wed, 14 Oct 2026
 12:14:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
 <20260911-qom-qapi-v5-60-7732a55b7760@redhat.com>
 <8733u9ya8v.fsf@pond.sub.org>
 <CAMxuvax65ysmLnOEWbC87GrZxfc86a+7dOb6ZVwenz-NWwvNQQ@mail.gmail.com>
 <87tsmou89o.fsf@pond.sub.org>
In-Reply-To: <87tsmou89o.fsf@pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 14 Oct 2026 23:14:06 +0400
X-Gm-Features: AclHuK91a6JztaPsnbvj5C6PnuvMKCLfkDHaqQu5YZPK83fu5ejZebD7nIr3ucE
Message-ID: <CAJ+F1CLaQjgT+fmp1SLLvgcWuUAq05u9aQfcjdJe0nW47OOVfw@mail.gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::1331;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1331.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi

On Wed, Oct 14, 2026 at 10:06=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Hi
> >
> > On Tue, Oct 13, 2026 at 5:56=E2=80=AFPM Markus Armbruster <armbru@redha=
t.com> wrote:
> >>
> >> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
> >>
> >> > Integer built-in types are currently canonicalized to "int" in
> >> > query-qmp-schema. Consequently, clients cannot distinguish types suc=
h
> >> > as int8, uint64, and size, even though they accept different ranges.
> >>
> >> This is by design.
> >>
> >> Width and signedness are an implementation detail.  We can change them
> >> freely without affecting syntactic compatibility of the wire protocol.
> >>
> >> If we expose them, we can't anymore, and docs/devel/qapi-code-gen.rst
> >> section "Compatibility considerations" needs an update.
> >>
> >> Why would this be useful?  Knowing width and signedness narrows down t=
he
> >> possible values some, but it need not be tight.
> >
> > Well, this was just a first step toward a better introspection support
> > for constaints. I understand the wire format is just json int, but we
> > may want to express ranges, enumeration of valid values, alignment,
> > string format etc.. Exposing signdness and width is the basics, and
> > establishes a pattern for carrying type-level metadata beyond just
> > "json-type". This enable clients to do proper validation and UI
> > generation without knowledge of commands and internals.
>
> Let's assume for the sake of the argument we want to do this.
>
> How to best communicate constraints to clients is not obvious.  Not
> least because our idea on what constraints exactly we want to
> communicate is little more than hand-waving so far.
>
> Constraints on acceptable values for integer types could be encoded in
> type names.  This is one way to communicate constraints.  Whether it's a
> good way is not obvious.  But let's think about it some more.y

The patch doesn't use type names to communicate constraints. They are
just identifiers - the spec already says they're meaningless strings.
Constraints are communicated with the "integer" member (signed/bits),
purely additive to SchemaInfoBuiltin.

>
> We'd move from the single type name "int" to multiple ones.  In theory,
> existing clients use type name "int" only to lookup the SchemaInfo, then
> recognize "meta-type": "builtin", "json-type": "int".  Splitting up
> built-in type "int" into several types does not affect such clients as
> long as the @json-type value remains the same.  In practice, Hyrum's law
> applies, and we'd have to work with client developers to make sure we're
> not breaking existing clients.

I don't understand how that could confuse existing clients, it should
be a compatible change.

>
> Signedness and width are a crude approximation of the actual
> constraints.  I doubt it's useful by itself, and I'm unwilling to commit
> to a way to communicate constraints just for that.

It's useful to do client-side input validation, and present appropriate UI

Again, this is the foundation, width and signedness are inherent
properties. Future constraint systems (explicit ranges, alignment etc)
would naturally extend SchemaInfoBuiltin. The "integer" member doesn't
conflict with any design direction for richer additions.

> Fortunately, this patch is only losely connected to what your series is
> about, namely to "associate properties with QAPI schema types".  We can
> simply drop it.  If you'd like to work on communicating constraints, we
> can talk about scope and interface design separately.
>
> [...]
>
>

