Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9778C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 18:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTmXB-0006yN-Dc; Tue, 16 Jul 2024 14:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTmX9-0006xp-Rz
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:04:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTmX7-00006x-CP
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:04:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721153051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YQPp5U2QLbC/D+OnCQf16OtbDu6xsfTKcpVrmFOI5Os=;
 b=PcliQHkM2IpbrmGuod1mJHz+XeBOwJIry3qihLTywD2sK5+lLqtmwpqSCsuGiHdDOB39yM
 IVcdFW2e8GhP1cQ/Fu4iAxIzHTHc6jMlSyjWvoaVLfq7QpWnUbkJlsn9XGX6Z6yhs2rHgT
 60zs5rqD3pfcvi0cTcC/O/NAHPQaBzc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-b7pN_TYjPaG6WLRj3_Qhiw-1; Tue, 16 Jul 2024 14:04:10 -0400
X-MC-Unique: b7pN_TYjPaG6WLRj3_Qhiw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-36785e6c1e6so2782343f8f.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 11:04:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721153049; x=1721757849;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YQPp5U2QLbC/D+OnCQf16OtbDu6xsfTKcpVrmFOI5Os=;
 b=gaVFiYTCCyiCety/xguyvylp3YswgURG4MHRcTIAiUeA21NQ4vl5JTAP5/K7+uAbrH
 EPy3/HZOrIkAWw8zJjxny2XpBgAiTp3Wfv56YaXO9yBFJUfeYENJGW6RyLR60sr/CNF+
 JDAdOCW+X8jf27tQC2oGlT0JAYIeP1clR3Hg+m5gUK75zgt7GgkXqhPHWW2HBgYJ/DD0
 mIQwHy3VgvwW9g3hHkLPYTMOjOEzB6hk4erg65YJpK1LkoejFbX38Uuffcgc2CjEu4d6
 ZF3ICQd9DB6GqSDbF8zqMc29OXLR4L7wLXLaL16dqK7GKb2z1HmePFfz17e/HuKY8sVR
 7HZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRzl3CUZaCT4e6yYNUnpZ6TOSFmRMK5uFQDf93pn0P2zn/yLfyJgzIc2CxoX3/cLbA2WghaRx0lm5h8+IQU5DWU6PUtcw=
X-Gm-Message-State: AOJu0YyV6ptOXOpMbx25+q1vlEVwCXN/LyRyDWGQebBfWr6EofsDhoYs
 3zuaF4lLq60AfCk7H6/8FyJDTjFbd7K1u9TNckSkOS/34SbAQK1upymVqSnrZ9Wy+uhz1wxrMu6
 lTkEICNghzSOyJJya4JiM9w/O+nTrazZKVCyS/blv4ITbLvU6p2/YGY4inCtuc+xjZBvvA5CaEm
 FCj20lzlyuaL/oCfw8yDRKvUxSk7w=
X-Received: by 2002:a05:6000:1e8e:b0:363:d980:9a9e with SMTP id
 ffacd0b85a97d-3682635c0f5mr1607366f8f.55.1721153048895; 
 Tue, 16 Jul 2024 11:04:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAfy0F7kxy4Pg8FBvHL4mCx09z9cLNoQWHIh/exGo0E6ySucbxYuxIE5LXNyTss0Y9gMWEN470hM6yIMl1xUg=
X-Received: by 2002:a05:6000:1e8e:b0:363:d980:9a9e with SMTP id
 ffacd0b85a97d-3682635c0f5mr1607357f8f.55.1721153048525; Tue, 16 Jul 2024
 11:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240711115546.40859-1-thuth@redhat.com>
 <CAFn=p-bMXm9qCD0hWiikyOmagFRryCZWrTx8xne9+x5j0QeNYQ@mail.gmail.com>
In-Reply-To: <CAFn=p-bMXm9qCD0hWiikyOmagFRryCZWrTx8xne9+x5j0QeNYQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 16 Jul 2024 20:03:54 +0200
Message-ID: <CABgObfbVdSDiJxNzv5TdUfOLLB=dLCkB0KgFQOxAcnG02gpDLA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/8] Convert avocado tests to normal Python unittests
To: John Snow <jsnow@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 "Daniel P . Berrange" <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000000fe0d0061d612cf1"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000000fe0d0061d612cf1
Content-Type: text/plain; charset="UTF-8"

Il mar 16 lug 2024, 18:45 John Snow <jsnow@redhat.com> ha scritto:

> My only ask is that we keep the tests running in the custom venv
> environment we set up at build time
>

Yes, they do, however pytest should also be added to pythondeps.toml if we
go this way.

If we move to pytest, it's possible we can eliminate that funkiness, which
> would be a win.
>

There is the pycotap dependency to produce TAP from pytest, but that's
probably something small enough to be vendored. And also it depends on what
the dependencies would be for the assets framework.

I'm also not so sure about recreating all of the framework that pulls vm
> images on demand, that sounds like it'd be a lot of work, but maybe I'm
> wrong about that.
>

Yep, that's the part that I am a bit more doubtful about.

Paolo

Tacit ACK from me on this project in general, provided we are still using
> the configure venv.
>
>
>>  Thomas
>>
>>
>> Ani Sinha (1):
>>   tests/pytest: add pytest to the meson build system
>>
>> Thomas Huth (7):
>>   tests/pytest: Add base classes for the upcoming pytest-based tests
>>   tests/pytest: Convert some simple avocado tests into pytests
>>   tests/pytest: Convert info_usernet and version test with small
>>     adjustments
>>   tests_pytest: Implement fetch_asset() method for downloading assets
>>   tests/pytest: Convert some tests that download files via fetch_asset()
>>   tests/pytest: Add a function for extracting files from an archive
>>   tests/pytest: Convert avocado test that needed avocado.utils.archive
>>
>>  tests/Makefile.include                        |   4 +-
>>  tests/meson.build                             |   1 +
>>  tests/pytest/meson.build                      |  74 ++++
>>  tests/pytest/qemu_pytest/__init__.py          | 362 ++++++++++++++++++
>>  tests/pytest/qemu_pytest/utils.py             |  21 +
>>  .../test_arm_canona1100.py}                   |  16 +-
>>  .../test_cpu_queries.py}                      |   2 +-
>>  .../test_empty_cpu_model.py}                  |   2 +-
>>  .../test_info_usernet.py}                     |   6 +-
>>  .../test_machine_arm_n8x0.py}                 |  20 +-
>>  .../test_machine_avr6.py}                     |   7 +-
>>  .../test_machine_loongarch.py}                |  11 +-
>>  .../test_machine_mips_loongson3v.py}          |  19 +-
>>  .../test_mem_addr_space.py}                   |   3 +-
>>  .../test_ppc_bamboo.py}                       |  18 +-
>>  .../version.py => pytest/test_version.py}     |   8 +-
>>  .../test_virtio_version.py}                   |   2 +-
>>  17 files changed, 502 insertions(+), 74 deletions(-)
>>  create mode 100644 tests/pytest/meson.build
>>  create mode 100644 tests/pytest/qemu_pytest/__init__.py
>>  create mode 100644 tests/pytest/qemu_pytest/utils.py
>>  rename tests/{avocado/machine_arm_canona1100.py =>
>> pytest/test_arm_canona1100.py} (74%)
>>  rename tests/{avocado/cpu_queries.py => pytest/test_cpu_queries.py} (96%)
>>  rename tests/{avocado/empty_cpu_model.py =>
>> pytest/test_empty_cpu_model.py} (94%)
>>  rename tests/{avocado/info_usernet.py => pytest/test_info_usernet.py}
>> (91%)
>>  rename tests/{avocado/machine_arm_n8x0.py =>
>> pytest/test_machine_arm_n8x0.py} (71%)
>>  rename tests/{avocado/machine_avr6.py => pytest/test_machine_avr6.py}
>> (91%)
>>  rename tests/{avocado/machine_loongarch.py =>
>> pytest/test_machine_loongarch.py} (89%)
>>  rename tests/{avocado/machine_mips_loongson3v.py =>
>> pytest/test_machine_mips_loongson3v.py} (59%)
>>  rename tests/{avocado/mem-addr-space-check.py =>
>> pytest/test_mem_addr_space.py} (99%)
>>  rename tests/{avocado/ppc_bamboo.py => pytest/test_ppc_bamboo.py} (75%)
>>  rename tests/{avocado/version.py => pytest/test_version.py} (82%)
>>  rename tests/{avocado/virtio_version.py =>
>> pytest/test_virtio_version.py} (99%)
>>
>> --
>> 2.45.2
>>
>>
>>

--0000000000000fe0d0061d612cf1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><br><br><div class=3D"gmail_quote" dir=3D"auto"><div dir=
=3D"ltr" class=3D"gmail_attr">Il mar 16 lug 2024, 18:45 John Snow &lt;<a hr=
ef=3D"mailto:jsnow@redhat.com">jsnow@redhat.com</a>&gt; ha scritto:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"auto"><div>=
<div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">My only as=
k is that we keep the tests running in the custom venv environment we set u=
p at build time</div></div></div></div></blockquote></div><div dir=3D"auto"=
><br></div><div dir=3D"auto">Yes, they do, however pytest should also be ad=
ded to pythondeps.toml if we go this way.=C2=A0</div><div dir=3D"auto"><br>=
</div><div class=3D"gmail_quote" dir=3D"auto"><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex"><div dir=3D"auto"><div dir=3D"auto">If we move to pyte=
st, it&#39;s possible we can eliminate that funkiness, which would be a win=
.</div></div></blockquote></div><div dir=3D"auto"><br></div><div dir=3D"aut=
o">There is the pycotap dependency to produce TAP from pytest, but that&#39=
;s probably something small enough to be vendored. And also it depends on w=
hat the dependencies would be for the assets framework.</div><div dir=3D"au=
to"><br></div><div class=3D"gmail_quote" dir=3D"auto"><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex"><div dir=3D"auto"><div dir=3D"auto">I&#39;m al=
so not so sure about recreating all of the framework that pulls vm images o=
n demand, that sounds like it&#39;d be a lot of work, but maybe I&#39;m wro=
ng about that.</div></div></blockquote></div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">Yep, that&#39;s the part that I am a bit more doubtful abou=
t.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div=
 dir=3D"auto"><br></div><div class=3D"gmail_quote" dir=3D"auto"><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex"><div dir=3D"auto"><div dir=3D"auto">=
Tacit ACK from me on this project in general, provided we are still using t=
he configure venv.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div =
class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
=C2=A0Thomas<br>
<br>
<br>
Ani Sinha (1):<br>
=C2=A0 tests/pytest: add pytest to the meson build system<br>
<br>
Thomas Huth (7):<br>
=C2=A0 tests/pytest: Add base classes for the upcoming pytest-based tests<b=
r>
=C2=A0 tests/pytest: Convert some simple avocado tests into pytests<br>
=C2=A0 tests/pytest: Convert info_usernet and version test with small<br>
=C2=A0 =C2=A0 adjustments<br>
=C2=A0 tests_pytest: Implement fetch_asset() method for downloading assets<=
br>
=C2=A0 tests/pytest: Convert some tests that download files via fetch_asset=
()<br>
=C2=A0 tests/pytest: Add a function for extracting files from an archive<br=
>
=C2=A0 tests/pytest: Convert avocado test that needed avocado.utils.archive=
<br>
<br>
=C2=A0tests/Makefile.include=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A04 +-<br>
=C2=A0tests/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A0tests/pytest/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 74 ++++<br>
=C2=A0tests/pytest/qemu_pytest/__init__.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 362 ++++++++++++++++++<br>
=C2=A0tests/pytest/qemu_pytest/utils.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 21 +<br>
=C2=A0.../test_arm_canona1100.py}=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 16 +-<br>
=C2=A0.../test_cpu_queries.py}=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
=C2=A0.../test_empty_cpu_model.py}=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
=C2=A0.../test_info_usernet.py}=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A06 +-<br>
=C2=A0.../test_machine_arm_n8x0.py}=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 20 +-<br>
=C2=A0.../test_machine_avr6.py}=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A07 +-<br>
=C2=A0.../test_machine_loongarch.py}=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 11 +-<br>
=C2=A0.../test_machine_mips_loongson3v.py}=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 19 +-<br>
=C2=A0.../test_mem_addr_space.py}=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A03 +-<br>
=C2=A0.../test_ppc_bamboo.py}=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 18 +-<br>
=C2=A0.../version.py =3D&gt; pytest/test_version.py}=C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A08 +-<br>
=C2=A0.../test_virtio_version.py}=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
=C2=A017 files changed, 502 insertions(+), 74 deletions(-)<br>
=C2=A0create mode 100644 tests/pytest/meson.build<br>
=C2=A0create mode 100644 tests/pytest/qemu_pytest/__init__.py<br>
=C2=A0create mode 100644 tests/pytest/qemu_pytest/utils.py<br>
=C2=A0rename tests/{avocado/machine_arm_canona1100.py =3D&gt; pytest/test_a=
rm_canona1100.py} (74%)<br>
=C2=A0rename tests/{avocado/cpu_queries.py =3D&gt; pytest/test_cpu_queries.=
py} (96%)<br>
=C2=A0rename tests/{avocado/empty_cpu_model.py =3D&gt; pytest/test_empty_cp=
u_model.py} (94%)<br>
=C2=A0rename tests/{avocado/info_usernet.py =3D&gt; pytest/test_info_userne=
t.py} (91%)<br>
=C2=A0rename tests/{avocado/machine_arm_n8x0.py =3D&gt; pytest/test_machine=
_arm_n8x0.py} (71%)<br>
=C2=A0rename tests/{avocado/machine_avr6.py =3D&gt; pytest/test_machine_avr=
6.py} (91%)<br>
=C2=A0rename tests/{avocado/machine_loongarch.py =3D&gt; pytest/test_machin=
e_loongarch.py} (89%)<br>
=C2=A0rename tests/{avocado/machine_mips_loongson3v.py =3D&gt; pytest/test_=
machine_mips_loongson3v.py} (59%)<br>
=C2=A0rename tests/{avocado/mem-addr-space-check.py =3D&gt; pytest/test_mem=
_addr_space.py} (99%)<br>
=C2=A0rename tests/{avocado/ppc_bamboo.py =3D&gt; pytest/test_ppc_bamboo.py=
} (75%)<br>
=C2=A0rename tests/{avocado/version.py =3D&gt; pytest/test_version.py} (82%=
)<br>
=C2=A0rename tests/{avocado/virtio_version.py =3D&gt; pytest/test_virtio_ve=
rsion.py} (99%)<br>
<br>
-- <br>
2.45.2<br>
<br><br>
</blockquote></div></div></div>
</blockquote></div></div>

--0000000000000fe0d0061d612cf1--


