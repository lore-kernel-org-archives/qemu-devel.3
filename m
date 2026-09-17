Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BADFC982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 09:30:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x78RI-0003Kx-6J; Thu, 17 Sep 2026 05:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x78RG-0003KX-SY
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 05:29:54 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x78RE-0000kW-Vq
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 05:29:54 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e721b5503so5697535e9.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 02:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789637391; x=1790242191; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sEks+xmI2cYXYOrmCnHiN4R+W4iNqRXH5LMUgMCGvpY=;
 b=skP6jQgr/jhQTyAY0EBDUwov0V8FVVFBixylQjiVAQ0mlE8gZn028TFTuvy7D8fJxs
 6RheBY8a600CM+vR4XJjSj3c1bT3++IrEX3dJG4oyPbuew/s7LxGrI+CaApt7Aly9Ihs
 crb5n6QN/1NwI/WO1Pj5aVcAd75Bgu3s2NxuXZly6KnVwZ35a+ByTIwHAvhzBlJiaQpX
 W3qlYQWiVLLpALuT+LC6u78l1Qt7AANJDvKHWrnX27zL82Z6aRfxmSmWdaWlihGkhxIh
 qaUB/7M3RNbEY9Ee6oYON4Ie9Ofx9ZFLWWybDgCHTM/jp8yU3nXInnYF3vktsxMnK29j
 C26Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789637391; x=1790242191;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sEks+xmI2cYXYOrmCnHiN4R+W4iNqRXH5LMUgMCGvpY=;
 b=FvjaKp8TcviwMFOGNFt53Sw6tBnFjgmjD0nVNvcwLXO+S8oBBK6Sv4lOYUvUMw7bmz
 jf3IuMMCEHH5y51aESA1HfD8Bm2NSUbdRDBJcG3wySVImw/VBtnddsySPK+zkmUihBEy
 ZZaHGuQSbbt7wEra+sodW4Jn2jNEwbyUUBgNKFoYlc9nbdTYvBAI4W7HIr2vpvKlQ4D7
 Gptwp2YCdrM+m3pz54hQdahGHLAlUrTBY353SPwoYJhzq+HqEXqxfd5IXFQaxYczFR+/
 3QozaNAG92o2cjZqePtEIbaLPmYlmFIGA5WdBc/NxRCiklyhx2x7ODY4gLxrUr9NwawE
 Vh1g==
X-Gm-Message-State: AFuF++mr6DNHR+tOLAGmi+bAafOgQdkdDCpUq/6ehZWkiROZ7nfo1SWo
 Za/YZdsT/VWajbfltS8Kh9Wja3evgxGaz5Y/4ue4KqMgfZGX6eJ2WB3j8VhgerXRkw4=
X-Gm-Gg: AYBFou2fHUO6fIONRi0c6udZadLc/tmIcpMvnOTSi7avcbiDQ1xpQBBnIupvmFHWmNZ
 /HhnW4OhoiJD4PvPBfJE2ptgJRqoeQKisfJgCIgu3+zwlNcUVvhZJlvEPuAlwNBY7lOE6aTMS3c
 2rQDzM1v5rqUcmYIMpRV8fcD3fh7omgAUMH8ExPzgc7RP8/F+Wa5PPeE5ZyrNw5gMPi0M9rnyUa
 S48+2D1XpCwtif+AcYuVxuT3Lk+1Co03n+NgfD04lFkXUhETtDGPg95wyq4WnQfbu7Uod94yihJ
 xQ33fXchd9zAn+t8o1k8UbOTyRQBzhlR4hf+zY+0RCpkdqtFDBauLDVYa0f7IVun7NkXXKSJwBp
 fCBwME87jNOR412fjlribtKdXu2/LE80hHXP0UHJ2yiEtfL342cxaHGQ3lMEsULHXXxUL13PQU4
 zzl/9jpaxaLLlm/K3/eu+iICILdFpNy/29xAMDY5enc7iEQdTg/RDBmk8d/1DpqSQKd7AhCe0=
X-Received: by 2002:a05:600c:1f83:b0:49c:c96a:d36b with SMTP id
 5b1f17b1804b1-49eb7306966mr67693145e9.12.1789637391491; 
 Thu, 17 Sep 2026 02:29:51 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbbd83e39sm87305895e9.4.2026.09.17.02.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 02:29:50 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C48705F834;
 Thu, 17 Sep 2026 10:29:49 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-arm@nongnu.org,  Cornelia Huck <cohuck@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,
 John Snow <jsnow@redhat.com>,  David Hildenbrand <david@kernel.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Cleber Rosa <crosa@redhat.com>,  Warner Losh
 <imp@bsdimp.com>,  Song Gao <gaosong@loongson.cn>,  Kyle Evans
 <kevans@freebsd.org>,  Eric Farman <farman@linux.ibm.com>,  Brad Smith
 <brad@comstyle.com>,  Fabiano Rosas <farosas@suse.de>,  Helge Deller
 <deller@gmx.de>,  Laurent Vivier <laurent@vivier.eu>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-s390x@nongnu.org,  Matthew Rosato <mjrosato@linux.ibm.com>,  Brian
 Cain <brian.cain@oss.qualcomm.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 17/19] scripts/make2mtest: add docker dependencies
 for check-tcg-% targets
In-Reply-To: <36cbf64f-e187-4d15-b710-7d4e6124ca07@oss.qualcomm.com> (Pierrick
 Bouvier's message of "Wed, 16 Sep 2026 09:30:27 -0700")
References: <20260916153013.2134555-1-alex.bennee@linaro.org>
 <20260916153013.2134555-18-alex.bennee@linaro.org>
 <36cbf64f-e187-4d15-b710-7d4e6124ca07@oss.qualcomm.com>
User-Agent: mu4e 1.14.4-pre3; emacs 30.1
Date: Thu, 17 Sep 2026 10:29:49 +0100
Message-ID: <878q508bua.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> On 9/16/2026 8:30 AM, Alex Benn=C3=A9e wrote:
>> This should trigger the building of the docker image when the user
>> calls "make check-tcg" or one of the arch specific targets such as
>> "make check-tcg-m68k-linux-user".
>>=20
>> We still keep the internal meson dependency so individual tests can
>> launched and the docker build verified.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  scripts/mtest2make.py | 35 +++++++++++++++++++++++++++++------
>>  1 file changed, 29 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
>> index 383ea68b16d..ab894d90d47 100644
>> --- a/scripts/mtest2make.py
>> +++ b/scripts/mtest2make.py
>> @@ -14,6 +14,7 @@ class Suite(object):
>>      def __init__(self):
>>          self.deps =3D set()
>>          self.speeds =3D set()
>> +        self.docker_deps =3D set()
>>=20=20
>>      def names(self, base):
>>          return [f'{base}-{speed}' for speed in self.speeds]
>> @@ -40,7 +41,22 @@ def names(self, base):
>>=20=20
>>  introspect =3D json.load(sys.stdin)
>>=20=20
>> -def process_tests(test, targets, suites):
>> +targets =3D {t['id']: [os.path.relpath(f) for f in t['filename']]
>> +           for t in introspect['targets']}
>> +
>> +# collect the docker images uses by the tests. This is totally a hacky
>> +# heuristic that fishes the images out of the test custom commands by
>> +# looking for the qemu/image pattern.
>> +targets_docker =3D {}
>> +for t in introspect['targets']:
>> +    for src in t.get('target_sources', []):
>> +        for arg in src.get('compiler', []):
>> +            if arg.startswith('qemu/'):
>> +                img =3D arg.split('/', 1)[1]
>> +                targets_docker[t['id']] =3D f'docker-image-{img}'
>> +                break
>> +
>> +def process_tests(test, targets, targets_docker, suites):
>>      executable =3D test['cmd'][0]
>>      try:
>>          executable =3D os.path.relpath(executable)
>> @@ -51,6 +67,8 @@ def process_tests(test, targets, suites):
>>      deps =3D itertools.chain.from_iterable(deps)
>>      deps =3D list(deps)
>>=20=20
>> +    docker_deps =3D [targets_docker[x] for x in test['depends'] if x in=
 targets_docker]
>> +
>>      test_suites =3D test['suite'] or ['default']
>>      for s in test_suites:
>>          # The suite name in the introspection info is "PROJECT" or "PRO=
JECT:SUITE"
>> @@ -59,6 +77,7 @@ def process_tests(test, targets, suites):
>>              if s =3D=3D 'slow' or s =3D=3D 'thorough':
>>                  continue
>>          suites[s].deps.update(deps)
>> +        suites[s].docker_deps.update(docker_deps)
>>          if s.endswith('-slow'):
>>              s =3D s[:-5]
>>              suites[s].speeds.add('slow')
>> @@ -81,6 +100,9 @@ def emit_prolog(suites, prefix):
>>      print(f'all-{prefix}-xml =3D {all_xml}')
>>      print(f'.PHONY: {prefix} do-meson-{prefix} {prefix}-report.junit.xm=
l $(all-{prefix}-targets) $(all-{prefix}-xml)')
>>      print(f'ninja-cmd-goals +=3D $(foreach s, $(.{prefix}.mtest-suites)=
, $(.{prefix}-$s.deps))')
>> +    print(f'docker-cmd-goals +=3D $(foreach s, $(.{prefix}.mtest-suites=
), $(.{prefix}-$s.docker-deps))')
>> +    print(f'docker-cmd-goals +=3D $(foreach g, $(MAKECMDGOALS), $(.dock=
er-goals.$g))')
>> +    print(f'run-ninja: $(sort $(docker-cmd-goals))')
>>      print(f'{prefix}-build: run-ninja')
>>      print(f'{prefix} $(all-{prefix}-targets): do-meson-{prefix}')
>>      print(f'do-meson-{prefix}: run-ninja; $(if $(MAKE.n),,+)$(MESON) te=
st $(.{prefix}.mtestargs)')
>> @@ -93,6 +115,10 @@ def emit_suite(name, suite, prefix):
>>      print()
>>      print(f'.{prefix}-{tgtname}.deps =3D {deps}')
>>      print(f'.ninja-goals.check-build +=3D $(.{prefix}-{tgtname}.deps)')
>> +    if suite.docker_deps:
>> +        docker_deps =3D ' '.join(sorted(suite.docker_deps))
>> +        print(f'.{prefix}-{tgtname}.docker-deps =3D {docker_deps}')
>> +        print(f'.docker-goals.check-build +=3D $(.{prefix}-{tgtname}.do=
cker-deps)')
>>=20=20
>>      names =3D ' '.join(sorted(suite.names(name)))
>>      targets =3D f'{prefix}-{tgtname} {prefix}-report-{tgtname}.junit.xm=
l'
>> @@ -105,19 +131,16 @@ def emit_suite(name, suite, prefix):
>>      print(f".{prefix}.mtest-suites +=3D {name} $(call .speed.$(SPEED), =
{names})")
>>      print(f'endif')
>>=20=20
>> -targets =3D {t['id']: [os.path.relpath(f) for f in t['filename']]
>> -           for t in introspect['targets']}
>> -
>>  testsuites =3D defaultdict(Suite)
>>  for test in introspect['tests']:
>> -    process_tests(test, targets, testsuites)
>> +    process_tests(test, targets, targets_docker, testsuites)
>>  emit_prolog(testsuites, 'check')
>>  for name, suite in testsuites.items():
>>      emit_suite(name, suite, 'check')
>>=20=20
>>  benchsuites =3D defaultdict(Suite)
>>  for test in introspect['benchmarks']:
>> -    process_tests(test, targets, benchsuites)
>> +    process_tests(test, targets, targets_docker, benchsuites)
>>  emit_prolog(benchsuites, 'bench')
>>  for name, suite in benchsuites.items():
>>      emit_suite(name, suite, 'bench')
>
> From previous answer on v3, this patch does duplicate existing
> dependencies. If we don't have a specific reason to repeat it on
> Makefile side, it should not be included in this series.

The reason was to trigger the build outside meson where it doesn't stall
the output. Maybe we can drop not we have the console fix.

>
> Regards,
> Pierrick

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

