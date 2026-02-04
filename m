Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C99E9D416
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 16:56:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vngA9-0000n4-Pa; Wed, 04 Feb 2026 11:55:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vngA6-0000mh-U6
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 11:55:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vngA4-0006V2-CT
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 11:55:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770224126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lw+5RwHfWwWY5wYINuc/4rkAx8WGDfNU4a2kNgjbhpw=;
 b=dKeLY5MQ/OtDIOWUFWdOXoUOAEnVG560703Oh26Yy7t4+HunJRm6XMEchdrT7RuqQoYft8
 3vNElNPbB+Mb96IR20mPq+lJLY0qCDuhNLjyFzxMgxz8OLAP96MzljaE1PMRMfWWYwcfNq
 Z6OPYjnp03zcp52T6A/VoI+wx0tTlYA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-L4DteRWWPBWeKPkux8S68A-1; Wed, 04 Feb 2026 11:55:24 -0500
X-MC-Unique: L4DteRWWPBWeKPkux8S68A-1
X-Mimecast-MFC-AGG-ID: L4DteRWWPBWeKPkux8S68A_1770224124
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4804157a3c9so99365e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 08:55:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770224124; cv=none;
 d=google.com; s=arc-20240605;
 b=kTm2Pt+njoi4M0fN0jcLPfiWEUEktVx0VO4OqxwBbMgI26S61hRhyQg8ckuEIYBocw
 PIR1idNyi6oBOGTQV7v8AFWjufP2aCihyZ6rKks+WPfdB3ck/3bvNerwUd3FPqFtwb4W
 YBHqvrpXsx8qsVHqAelo86y3Ys5uXJobbFuJE1WUvt7Wf9R90CIlibatiTLDJTZVfNIS
 ZSY0tU3DCn7EZYUczudxTOVTmOuHPHA9Re5lR6KJlTMYjYAKf5RheoOL3PIe2wqm7cRe
 oetoednMaqREiBRQSMQ7SP29FA/CUM3BDOExRxwgIgcqy/0f0lwOMUXyD4O22/4NyBve
 s2ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lw+5RwHfWwWY5wYINuc/4rkAx8WGDfNU4a2kNgjbhpw=;
 fh=Aqbdj/jSz5Po3e1fl7F41zRPtpJ1ExtfkaWo4ELQX9M=;
 b=RsfC6OzTkrhNwRCFYMLAbDOKOTBLZZF4N/KW8brtEYYyAJVdYlpI6UGUXNWRDLQisc
 6a2j0dapJNIy/VKbkWwnFOsZVGPfTjTWirfyLv/eC1AEoamwXbbOrB8r3CbEuY39fYjR
 11IfvaSFndLowIUpFJYv33jtwiG4kS4YyHfAg3fqbVn72OCH14gFP0R3KrXCKL6Ebi93
 f+9aLxbEzNJr2Lxvvz80ntU6gpX1w34bCus02OszJ3Sobv7uCHzUzygFEvkKXEpxCixi
 1eLNY8g6MWacpxz9JKui/n84tvG3enUytHycIsTj3JJ9u3Xku+2jYWGm7jmGLLYdoXu3
 9ngw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770224124; x=1770828924; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lw+5RwHfWwWY5wYINuc/4rkAx8WGDfNU4a2kNgjbhpw=;
 b=LjQUyTmSPhf8Hq/qdhad7vuQVOUP32aMCopNGbnmDff99ry9KI41uDeVEOJyFNWy+4
 w/+ON0gP1H1Kx7ve4aSEHn77EOA7rlk/SZoryP7GYr82XvouNGlBiVW8KOeCQs6O5BTZ
 kR5TriGuyfeOwMdkSo4yf5XEKnA3Tti+El8br/ZsUXcDqkFySX+QGitc/WM5c8l3LPWW
 fMVXmY77ARkrJnB3zspGC1IfX2m7LdOc0FGP85kxcuS9l543fZX96bHIHBJPljjF1sJx
 hJDTpsFP6TLSAKuokkEp/vRcNCnxpKMlJhZO7WAfgjziidz/+iewkTQOAYTteWLprA62
 z8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770224124; x=1770828924;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lw+5RwHfWwWY5wYINuc/4rkAx8WGDfNU4a2kNgjbhpw=;
 b=VIBj2dLVfdIQ2PLYSNRsWgBaGfYckljM9eRTlzLlFMfhx9dxkoLgUP+4gXE0IvoSBU
 XDRWfeSPiLYOZZq2iuNFkL8FFAC+OXB9rKgvJ3pbuvDmBiUD5j7C4Ug4qnlsLI5OQ7Qv
 WhC/y8zJqWbNyQowJwn2034SNP3Qk7BRTSAcOHUDFHmOSOyKNU4WyYsm0kMa8cdfWJF4
 TRvOYet1W3JGnvvwBOYPK/AvW/aSZQHXizRM3hFo/8EziMTmP0wIzzjeoMsGBwC1tXHQ
 Q7MkhMjY/oO4SBSnW5P/Y+9AIZNWBRxsO/t2tX3abPMkANrUWif7kQDTVZ96Tn3fPnsS
 lDGQ==
X-Gm-Message-State: AOJu0Yzh6wjMuhIpMkyTRNIIpZoP/bp5HdjR3H5US8YM5HSSUan7S+hU
 cDyOLQHUbdVZ5N1Rpl6vcX2ZTUHLmVv3huNpiRj9AU8CUeD/t/bVVZwXr9w9DzVwy3Sfok4mpAR
 7IDhwQZGmR9Cz8UfSw0MPHoXj/qFHAcEwfe5+jw0d4uGeNyF94jHWm5Kl/a75vuPypFX9oHty+E
 xA4NBzRm4ea6WA4tUADzMfez9iyo4iaPs=
X-Gm-Gg: AZuq6aLvTeNp01ngV44d1i9Z0VTzQKsnU/NiTIAqvDA1C2beuCzKTXTZfXiFs8CLH0T
 ubLSBsjZV4/vdLM8gONqb5cPmOd3Lwk1p5DgVYJ24Ff/b2RVg/8Tx7l4GmNujEdbQCF+EIG5d3H
 YW5Q9Zb4rfRBSLBP9gVrPhKFsmHyaINplF56G57U8SXE4sfG1yxZBPiNU79vezi34fZbaEA8yBK
 cicM9RHu4bxNa9lypC521dboZD5rxOOp1KX7Umwa7jMCIO99HeWKVAQgGA0B4c03tXU1g==
X-Received: by 2002:a05:600c:8718:b0:47d:403e:4eaf with SMTP id
 5b1f17b1804b1-4830e9335c4mr47169375e9.10.1770224123557; 
 Wed, 04 Feb 2026 08:55:23 -0800 (PST)
X-Received: by 2002:a05:600c:8718:b0:47d:403e:4eaf with SMTP id
 5b1f17b1804b1-4830e9335c4mr47168975e9.10.1770224123178; Wed, 04 Feb 2026
 08:55:23 -0800 (PST)
MIME-Version: 1.0
References: <20260203203512.672552-1-jsnow@redhat.com>
 <20260203203512.672552-12-jsnow@redhat.com>
 <CABgObfYtKr88BvhPUL4KfX464u=T4d7BP70XRLMdn28sXSKU4g@mail.gmail.com>
 <CAFn=p-bq8siBh0f2bs=x6ZeHQn6y2_2RuwKVnVrH+CvOTe-4ig@mail.gmail.com>
In-Reply-To: <CAFn=p-bq8siBh0f2bs=x6ZeHQn6y2_2RuwKVnVrH+CvOTe-4ig@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 4 Feb 2026 17:55:10 +0100
X-Gm-Features: AZwV_QjfPTOFBNkuWhBrqhUkAY1Njh6ZJuNBYD5v1KB-mUGUy0aUHy_cjrHlk04
Message-ID: <CABgObfYA12a08yXPsn84hX8dv59x7DDDLW0X3u5Cre3od6iMFw@mail.gmail.com>
Subject: Re: [PATCH v5 11/16] meson, mkvenv: add qemu.git/python/qemu package
 to pythondeps.toml
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Thomas Huth <thuth@redhat.com>, 
 Maksim Davydov <davydov-max@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Michael Roth <michael.roth@amd.com>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Feb 3, 2026 at 10:28=E2=80=AFPM John Snow <jsnow@redhat.com> wrote:
>
> On Tue, Feb 3, 2026 at 4:08=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
> >
> >
> >
> > Il mar 3 feb 2026, 21:36 John Snow <jsnow@redhat.com> ha scritto:
> >>
> >> Add the local python package group into pythondeps.toml for the
> >> tooling This makes qemu.qmp, qemu.machine and qemu.utils
> >> packages unconditionally available for tests and scripts.
> >
> >
> > Out of curiosity why not add setuptools and wheel to the group, at this=
 point? Can be done on top of course.
>
> Hm. If we're operating offline, it would only really serve as a

s/only/also/ :)

> configure check. Online it might actually be a help. I'll do it as a
> follow up, I just need to figure out which versions meet our needs and
> do testing to choose the accepted values.

Use whatever is in bookworm or 22.04?

Paolo


