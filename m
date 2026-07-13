Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B105C44507
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 18:16:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjLC5-00074L-Hz; Mon, 13 Jul 2026 14:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjLC2-00073t-MN
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 14:15:51 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjLC0-0007tB-E2
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 14:15:50 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-668005ba03cso637926d50.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 11:15:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783966546; cv=none;
 d=google.com; s=arc-20260327;
 b=oW4VTRHqfuMZPO3hYz67E4efYnSyqR8hTsISeSdJmflXS8N4eG8DSIMqfJwplzhL0Z
 x9JYRtlf6jUDk+FQacLrgprBBaeyGbB4bBtf9RZh6jEKhH+6n7t8ZEUp1WsvFnUWdB9h
 He2vNwN7b4S2+KWSc0g3CXLnHO+GD7ZPDsMgAlTWl1Rim6ixtQiDXS5gaJvz7bo+AIZH
 qCOjcxRNT3TIbEv+O9NHwedPKyuAZtdScAXRtGpETdOGDCYoBphg4vtG//CqJRFsLiP4
 iwwhLA6JXobaIazDzqUEb9jbbKD3fzWTcssDDXrG56TCJ9tYDwTW62K/GwHV3af3Xx4p
 SuZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=iWNzBfS6lQMCzMa3MDqQvvovo2jlNXKqRLSYOesq5lQ=;
 fh=4RKNZylJSfgnGBDH/lC8k/Ijdws5ageKby55ntHfk+k=;
 b=JFdWBjXfDWyEvWhMudoe2F2PsxkZlV3N0wuAHLrYqkBJ16zLob0AwChaK0TtzHN/o8
 RM4IW0YVgsopDQVY00GdLHQ/Gyl027kOLHK0wi5GsaG7o+hkS+sft94KnPV+RB8urcUz
 pP8LRxG6IZbOwPoJx7CoXOE2lahxAvaBOJrklnBzCmDgYOuOHOEygKDKGDiECQzFtSOU
 l/hhps8jnimQqVScCLxfGHOUrbmfXFelOgTPfWJfUWIJ3OhNwoQyR2+yCN+fV1U6L2s1
 zZCYK/3N4QbCgvFL+ui9KnQCATSOtfp+zhWYnBQ9vu0L6AoYSJu8RuFt6xs1zFzUBq15
 1Ysg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783966546; x=1784571346; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=iWNzBfS6lQMCzMa3MDqQvvovo2jlNXKqRLSYOesq5lQ=;
 b=IsyZOyaQ5db5z3Fm/bhxJEAv5ai+9Gf8VPlB/JW6Hi+2tk0cBONn30vzFjlbZEnZdg
 zD7Rfsey0hK/S9L5NxdppRg4KwHWplnBlBCOFjRxTtnmmSCRcg7wwo5Drvmy1kzU5KMJ
 IvUmge5uiCZ2HSBe29rgbK7jaNYPmhU5MqBA9MefVZYwA3kTfTSDHCBTl1s7uz6QvCd4
 KqE0scdY0aA+9u1xpA8GbHwptrbzDM836mHEC7PrZOKQ0N4mFTNWnHuOdO0t1zPBF1BY
 0mGxZQY5M3XoeT6FPRUg6zNh6WrKhXLDJBIoZqZfnWhLXS1AKb7M5WwAvQrkAO060mi7
 HEZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783966546; x=1784571346;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=iWNzBfS6lQMCzMa3MDqQvvovo2jlNXKqRLSYOesq5lQ=;
 b=APe+aK6O1SV0TXtFi2kn5uoThyJFKH0Q44OReNrT98t9h6uNJapdanTW50M8dUXnh3
 wINzw0+Bdwn5fSKcRF5ZmkXCJeL6NMzTIQq5A39E0fK0VaAUHqs/oKlKYbRpqvJTNUZ+
 1ZOnK8N6M//RKnixRUk15nWlTsqI83DJjV4J2RHypFflMUQnDshrdJNdLhhK+XXOjWdD
 3vYzEcZYMa2EdQCVhBjSTAXtURAA0LcHSzsq/ZoPq+uw1XyQNhtB8S4jQ+YY1sET48Vf
 vC9tmMZCtAuPg+l5GEQI7XrlOBGrkDjGojCJ7E1PekUtyuVIJJ/16UTYKiIIEtqGAegL
 iJog==
X-Forwarded-Encrypted: i=1;
 AHgh+RpkeYvX+efAVDK8gV48rDlcUgR2/i+Rsmd33PGj24ABp4FYY9AfNaX8eAYcxXmftxfBL9a9Y2kc9T/f@nongnu.org
X-Gm-Message-State: AOJu0YxBWYxwz+EBY1OcMjPLTH3bB3nQJLpUxTwrIdS6Xz9+DFe4jk8b
 WztY0VLl0M7E7iXr3pYIo7ByAl2JXzf7LVCWeAQJHfbvExj7UCJknlTbzMYs6khrSjwXouC1IOo
 7ivRfz39/ki45U5CAMOSYvPSbugASycKiWAGvH6WGjw==
X-Gm-Gg: AfdE7cmuARlNRTkt5w0mFWSta+xxTUuRtoIrEg3GEInAi6QKPe/VYZIXdRZpdjBGVYW
 8vRF8fgmeKNEsWLoWqZmFUsn3bU5MH9Rt7wLb5wqgzBivj4EE9LlVT4V78tvKkrUS/5itU5r/Ca
 VWgYAz+Lau0V5Y1q0lrkC5t+nWJhkyE83oq8K7NQodgebkMMZss6SOS7Eu+qM9B9rLo7XolUrnm
 8pnSN8MyTUbEB7L7Fqp7inyIMoMOXsQFs+8mUkvkogVFZzgrUAHN7IifXQd85br5tLKULIlrZ9P
 2VGqKeUow94Ax6ZFPU1Yj2Zu4kuOc7Yb/heyLCikmp8AkDBNh+XvR/3y
X-Received: by 2002:a05:690e:4891:20b0:663:b0e:ad28 with SMTP id
 956f58d0204a3-66802a28dffmr403973d50.38.1783966546227; Mon, 13 Jul 2026
 11:15:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260711223707.42139-1-graf@amazon.com>
 <20260711223707.42139-2-graf@amazon.com>
 <12d544b3-5c68-488a-91e5-ac64d1a27338@linaro.org>
In-Reply-To: <12d544b3-5c68-488a-91e5-ac64d1a27338@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Jul 2026 19:15:34 +0100
X-Gm-Features: AVVi8CeALJCtl8iJcOb5C83VYoheqyEfuuLtGJRdUosEmJqlHMq0Irj5XY7N5OQ
Message-ID: <CAFEAcA9wRhZPyiAym26DQWEyb2AS=QBpvRi9wBEJKsHEw+j0sQ@mail.gmail.com>
Subject: Re: [RFC PATCH 001/134] qom: Introduce object_new_child()
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Alexander Graf <graf@amazon.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, 13 Jul 2026 at 17:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 7/11/26 15:34, Alexander Graf wrote:
> > We already have two ways of creating a QOM object with a parent set
> > from birth: object_initialize_child() for objects embedded in the
> > parent struct, and object_new_with_props() for heap-allocated objects
> > that also want a list of string properties applied.  What we do not
> > have is the plain heap-allocated dual of object_initialize_child():
> > create the object, add it as a child<> of a given parent under a given
> > name, and hand the reference to the parent.
> >
> > Board and composite-device code that heap-allocates children today
> > therefore either open-codes object_new()+object_property_add_child()
> > +object_unref(), or skips the parenting step entirely and lets
> > device_set_realized() dump the object into /machine/unattached.
> >
> > Add object_new_child(parent, id, typename) as that missing primitive.
> > The reference created by object_new() is transferred to the parent's
> > child<> property, so on return the sole reference is held by @parent
> > and the caller does not need to unref.  Later patches build the qdev
> > and per-bus creation helpers on top of this.
> >
> > Suggested-by: Markus Armbruster <armbru@redhat.com>
> > Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
> > Assisted-by: Kiro
> > Signed-off-by: Alexander Graf <graf@amazon.com>
> > ---
> >   include/qom/object.h | 25 +++++++++++++++++++++++++
> >   qom/object.c         | 13 +++++++++++++
> >   2 files changed, 38 insertions(+)
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> > +Object *object_new_child(Object *parent, const char *id,
> > +                          const char *typename)
> > +{
> > +    Object *obj;
> > +
> > +    g_assert(parent);
> > +    g_assert(id);
>
> Of course, typename can't be null either.

These asserts are of the "not very useful" kind, as well --
if either of these are NULL we're going to crash pretty quickly,
and then the debugger backtrace will point you at your programming
error. Asserts are most useful when they turn non-obvious bugs
into obvious bugs or turn "happens a long time later than when the
problem is" bugs into "happens very close to when the problem is".
bugs.

-- PMM

