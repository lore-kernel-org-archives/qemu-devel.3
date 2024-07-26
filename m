Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F83C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 13:50:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXLKx-0003tP-M3; Fri, 26 Jul 2024 09:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1sXLKw-0003pc-K9
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 09:50:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1sXLKu-0004y9-HT
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 09:50:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722001819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MjW2iTZfZtJVa6oukjsk2ESyNOqCkVA54LdoTKUyi4k=;
 b=R6VUQTMJTYKNf2S/s6MOF3iZjpoRZhHLKHIPg67wOKguLYNs0LaUGTSOeRYzmaRxKGPPZY
 onpAy9nDU2d+z4mzhzrGW/HObG33+uaQ+gDca7WbLT7krMVXNEcGDkBqnI85gz76b5OGW4
 0s57Eu9XeloyQniIwEZGW8+o+NUZOcs=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-JPDuSzo4NPK22eY9NisulQ-1; Fri, 26 Jul 2024 09:50:18 -0400
X-MC-Unique: JPDuSzo4NPK22eY9NisulQ-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-666010fb35cso36898087b3.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2024 06:50:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722001817; x=1722606617;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MjW2iTZfZtJVa6oukjsk2ESyNOqCkVA54LdoTKUyi4k=;
 b=ZZsPUaUSYAXkn3VuvwOnOrXDgzPn6rAotpQuyJO5+lFzNOnusFXFuZhgVlEIqSB7Yy
 S2ur8EZ7wCSCKMeo0BQo5UEATKz9W85Ga1ujaHR0PXkPzbMX8E3QHc9vukmKj5eSO/uF
 AfboBbqxxrcrAdi3ciQkcExBNwxmwSQk/e3e7Xmwmr8rI23jfjtG3iGKyIfDpKM5NASn
 emf8kY3eoSAoNcQ0y38Moej1mtnNgOryW374S2qu+/LgLjCbtQda1Z+Qs2lPOP2ar7K9
 qG8EdCminjQs8zYLz3gCKmWp443Y4QBaywE8usqjzC6a0mpjZBrV4ACr5qKYTJ+ETuL0
 hkdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVF3mwH6c/IU1EW0Ts0QGiOP9ppQ/4LTdnaQxBMALikP1zkxqd1rZbi+l/fFMatjbdSIsqOU2vDfuDsu2yK9M0knlfKVls=
X-Gm-Message-State: AOJu0Yyhffw9LLNwOQ3tTx6FVIyYaU0YgNhsM6kUrmsxROwg00nbK1NA
 aYmxUUDIxXINlRubUsBISAfVjnbHHPJIQR/Ho7RHkLCSwCBzq8BYAiD++NtI+4smZA7PYbIsWmy
 /FkunBscD04f9wrBwnz0aUE7wZPfzOEVflkQkfwBRWBpd/9NicgtteBi9XmAe7h+EJGTj9rhINo
 2hRUv/KQmAQWeJ6Zn+u9gJO49nt0dIvF8qxfZC+XTGI2k=
X-Received: by 2002:a0d:f744:0:b0:665:134e:d118 with SMTP id
 00721157ae682-672bcff580dmr69521447b3.9.1722001817493; 
 Fri, 26 Jul 2024 06:50:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+SZvsIWKMpZLxsNz+hMwkpPe6qoeyaB6zVOV+0i//8Jl7vCvkvLEJH97sdLU+8VBV6BxsXgLKcOoMQlQozKk=
X-Received: by 2002:a0d:f744:0:b0:665:134e:d118 with SMTP id
 00721157ae682-672bcff580dmr69521257b3.9.1722001817200; Fri, 26 Jul 2024
 06:50:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240724175248.1389201-1-thuth@redhat.com>
 <6d609ff1-c4df-4960-be5f-4b29c5911879@linaro.org>
 <ZqIhJSbT2qQKJ7lj@redhat.com>
 <df67c0be-e0d1-4ac2-9a88-2765417875ac@linaro.org>
 <ZqIx9kGMyUShbzUR@redhat.com>
 <c1cba52c-34fb-49f6-b362-abbb9439629e@redhat.com>
In-Reply-To: <c1cba52c-34fb-49f6-b362-abbb9439629e@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Date: Fri, 26 Jul 2024 09:50:03 -0400
Message-ID: <CA+bd_6KiSUHsTNLsxcF+gAiOHr6wCeZJpecdE1GWhWtbOh7nQg@mail.gmail.com>
Subject: Re: [PATCH v2 00/23] Convert avocado tests to normal Python unittests
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, 
 qemu-ppc@nongnu.org, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jul 26, 2024 at 9:04=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> On 25/07/2024 13.07, Daniel P. Berrang=C3=A9 wrote:
> > On Thu, Jul 25, 2024 at 08:42:31PM +1000, Richard Henderson wrote:
> >> On 7/25/24 19:55, Daniel P. Berrang=C3=A9 wrote:
> >>> On Thu, Jul 25, 2024 at 09:35:22AM +1000, Richard Henderson wrote:
> ...
> >> Avocado runs a first pass doing all of the downloads, and only afterwa=
rd
> >> runs the actual timed tests.  I don't know the specifics of how, but i=
t
> >> certainly obvious in the logging.
> >
> > Oh interesting, I found how it does it..
> >
> > The file avocado/plugins/assets.py will build an AST of the python
> > code in a test file, look for all 'fetch_asset' calls, then extract
> > the parameters to these calls, and donwload them. This is clever.
> > Basically avoids the refactoring that I suggested.
> >
> > So yeah, that is a gap.
> >
> > Practically speaking, we have a choice of either  calling into this
> > avocado python lib as is, or copying tthat python lib into QEMU.
>
> Honestly, I'd prefer to do some refactoring instead, something like you
> suggested in your earlier mail. Rationale: For the basic tests it would b=
e
> good if we would not depend on the Avacodo framework anymore, otherwise w=
e
> likely will continue to run into the situation that our test framework st=
ops
> working on some random new python versions and nobody within the QEMU
> community has a clue how to fix the situation since nobody is really
> familiar with the Avocado framework. Also, while that
> avocado/plugins/assets.py sounds like a very neat trick done by a skilled
> Python wizard, the average QEMU developer (like me) is just a skilled C
> coder with only basic Python knowledge, so I'd prefer if we could use a
> simpler mechanism instead that is easier to understand and to debug for
> everybody once we run into problems with it.
>

Hi Thomas,

That wizardry is indeed not nice, and has limitations.  It was
replaced in recent Avocado versions for the dependencies mechanism:

   https://avocado-framework.readthedocs.io/en/103.0/guides/user/chapters/d=
ependencies.html

Specifically for the assets (downloadable files), you can find the
documentation here:

   https://avocado-framework.readthedocs.io/en/103.0/guides/user/chapters/d=
ependencies.html#asset

Those are superior to the previous implementation because they compute
a dependency graph that works on the resolution while tests with
dependencies met (or no deps) start running right away.

Regards,
- Cleber.


