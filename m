Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F60BC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 15:16:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woN3m-0001zo-2c; Mon, 27 Jul 2026 11:16:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1woN3W-0001sC-AT
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 11:15:58 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1woN3K-0000Oo-0y
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 11:15:49 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 27D6D7BC89;
 Mon, 27 Jul 2026 15:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785165329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Z1tU7YA2oQeCt6K4oDpOZ7+jb7KYPpv16Eo+KL6jHU=;
 b=Rw3wtXo/jZoRcbMTpM24XE8Aoclfp7nbtER9muwvVstbM7JCb2+4DGM00MKJHKZ4v7lL9k
 Mq/XV/9kW3fxmrS0mN/EKmTemgb+1hnbf6EBXPLX8iqciotv/xfbsQtxn64eI4eJYvOWn1
 pXY/oPMpATvNfNgKVXTnUqpcpWxffyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785165329;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Z1tU7YA2oQeCt6K4oDpOZ7+jb7KYPpv16Eo+KL6jHU=;
 b=cH7UioFXJZBLm99Dr85qWqjr7JcDk8O4NU5GoUCs6rcatm22lD/lc93pIRuUbPjOl3bdrO
 jUN5eGT2ey+3JzBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785165325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Z1tU7YA2oQeCt6K4oDpOZ7+jb7KYPpv16Eo+KL6jHU=;
 b=OaUD7xiq4Dvl1cGFBCo2ULVBzZDQxicLtsbnBCdhq+4RMWrQf2B1nAyXbkPy8ZnJvAlvwr
 GPfzshau7VummlUhOplnu8/ayNmCIt+YBD2xKQSSI89axxYHW1fB1sgPqrX4mIdXXe2Vi3
 nc3s8Ci7XXufse0+DYM5yncsM8cot9s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785165325;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Z1tU7YA2oQeCt6K4oDpOZ7+jb7KYPpv16Eo+KL6jHU=;
 b=FP1akH2H//AnYxpQaWIgEQtvld/pJBstMjocO2eK9u33Tzqj9zDX1ic1GYR+6FL4Jd+ZFi
 kw2FimqbDMHnXVCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B372E779B9;
 Mon, 27 Jul 2026 15:15:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hE8VIQx2Z2oXcAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 27 Jul 2026 15:15:24 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Thomas Huth <thuth@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, Florian Schmidt
 <flosch@nutanix.com>, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Marc?=
 =?utf-8?Q?-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH] Add option to disable building tests
In-Reply-To: <3677fd2b-64fc-45fe-8bb7-04f84773c77e@oss.qualcomm.com>
References: <20260724135413.1716872-1-flosch@nutanix.com>
 <708798a8-3d43-48d9-a4f6-210eb88a88cb@oss.qualcomm.com>
 <92358092-080b-4b1d-82e5-733d2531ff38@oss.qualcomm.com>
 <c68be7c9-113d-4de1-8ab5-bee142e8db15@redhat.com>
 <6b432df2-b318-75ec-e26d-e1134baa06ca@eik.bme.hu>
 <3677fd2b-64fc-45fe-8bb7-04f84773c77e@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 12:15:18 -0300
Message-ID: <87bjbspipl.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[11]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 qualcomm.com:email]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com> writes:

> On 27/7/26 13:19, BALATON Zoltan wrote:
>> On Mon, 27 Jul 2026, Thomas Huth wrote:
>>> On 27/07/2026 10.12, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> On 24/7/26 18:45, Pierrick Bouvier wrote:
>>>>> On 7/24/2026 6:54 AM, Florian Schmidt wrote:
>>>>>> There are situations in which you might want to build QEMU without
>>>>>> building the full test suite, which in some configurations can take a
>>>>>> considerable amount of time to build. This is especially true when=20
>>>>>> using
>>>>>> LTO with clang. For example:
>>>>>>
>>>>>> $ ../configure --cc=3Dclang '--extra-ldflags=3D-flto=3Dthin -ffat-lt=
o-=20
>>>>>> objects' '--extra-cflags=3D-flto=3Dthin -ffat-lto-objects' --target-=
=20
>>>>>> list=3Dx86_64-softmmu
>>>>>> [...]
>>>>>> $ time make -j8
>>>>>> [...]
>>>>>> [3078/3078] Linking target tests/qtest/qos-test
>>>>>> real=C2=A0=C2=A0=C2=A0 6m43.250s
>>>>>> user=C2=A0=C2=A0=C2=A0 101m15.967s
>>>>>> sys=C2=A0=C2=A0=C2=A0=C2=A0 4m3.813s
>>>>>>
>>>>>> $ ../configure --cc=3Dclang '--extra-ldflags=3D-flto=3Dthin -ffat-lt=
o-=20
>>>>>> objects' '--extra-cflags=3D-flto=3Dthin -ffat-lto-objects' --target-=
=20
>>>>>> list=3Dx86_64- softmmu --disable-tests
>>>>>> [...]
>>>>>> $ time make -j8
>>>>>> [...]
>>>>>> [2024/2024] Linking target qemu-system-x86_64
>>>>>>
>>>>>> real=C2=A0=C2=A0=C2=A0 3m14.277s
>>>>>> user=C2=A0=C2=A0=C2=A0 33m13.174s
>>>>>> sys=C2=A0=C2=A0=C2=A0=C2=A0 1m36.642s
>>>>>>
>>>>>> Add a toggle to optionally disable building tests.
>>>>>>
>>>>>> Signed-off-by: Florian Schmidt <flosch@nutanix.com>
>>>>>> ---
>>>>>> =C2=A0 meson.build=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
>>>>>> =C2=A0 meson_options.txt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 ++
>>>>>> =C2=A0 scripts/meson-buildoptions.sh | 3 +++
>>>>>> =C2=A0 3 files changed, 6 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/meson.build b/meson.build
>>>>>> index 49a5baf5b5..ad728c26ec 100644
>>>>>> --- a/meson.build
>>>>>> +++ b/meson.build
>>>>>> @@ -4605,7 +4605,7 @@ subdir('docs')
>>>>>> =C2=A0 subdir('pyvenv')
>>>>>> =C2=A0 # Tests are disabled on emscripten because they rely on host=
=20
>>>>>> features that aren't
>>>>>> =C2=A0 # supported by emscripten (e.g. fork and unix socket).
>>>>>> -if host_os !=3D 'emscripten'
>>>>>> +if get_option('tests').allowed() and host_os !=3D 'emscripten'
>>>>>> =C2=A0=C2=A0=C2=A0 subdir('tests')
>>>>>> =C2=A0 endif
>>>>>> =C2=A0 if gtk.found()
>>>>>> diff --git a/meson_options.txt b/meson_options.txt
>>>>>> index a07cb47d35..68333ca402 100644
>>>>>> --- a/meson_options.txt
>>>>>> +++ b/meson_options.txt
>>>>>> @@ -43,6 +43,8 @@ option('gdb', type: 'string', value: '',
>>>>>> =C2=A0 # on the configure script command line.=C2=A0 After adding an=
 option
>>>>>> =C2=A0 # here make sure to run "make update-buildoptions".
>>>>>> +option('tests', type: 'feature', value: 'auto',
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description: 'Build the test s=
uite')
>>>>>> =C2=A0 option('docs', type : 'feature', value : 'auto',
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description: 'Docum=
entations build support')
>>>>>> =C2=A0 option('fuzzing', type : 'boolean', value: false,
>>>>>> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-=20
>>>>>> buildoptions.sh
>>>>>> index c003985047..3fec13a336 100644
>>>>>> --- a/scripts/meson-buildoptions.sh
>>>>>> +++ b/scripts/meson-buildoptions.sh
>>>>>> @@ -194,6 +194,7 @@ meson_options_help() {
>>>>>> =C2=A0=C2=A0=C2=A0 printf "%s\n" '=C2=A0 spice-protocol=C2=A0 Spice =
protocol support'
>>>>>> =C2=A0=C2=A0=C2=A0 printf "%s\n" '=C2=A0 stack-protector compiler-pr=
ovided stack=20
>>>>>> protection'
>>>>>> =C2=A0=C2=A0=C2=A0 printf "%s\n" '=C2=A0 tcg=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TCG support'
>>>>>> +=C2=A0 printf "%s\n" '=C2=A0 tests=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 build test suite'
>>>>>> =C2=A0=C2=A0=C2=A0 printf "%s\n" '=C2=A0 tools=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 build support utilities that=20
>>>>>> come with QEMU'
>>>>>> =C2=A0=C2=A0=C2=A0 printf "%s\n" '=C2=A0 tpm=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TPM support'
>>>>>> =C2=A0=C2=A0=C2=A0 printf "%s\n" '=C2=A0 u2f=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 U2F emulation support'
>>>>>> @@ -515,6 +516,8 @@ _meson_option_parse() {
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --enable-tcg-interpreter) printf "%s"=
 -Dtcg_interpreter=3Dtrue ;;
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --disable-tcg-interpreter) printf "%s=
" -=20
>>>>>> Dtcg_interpreter=3Dfalse ;;
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --tls-priority=3D*) quote_sh "-Dtls_p=
riority=3D$2" ;;
>>>>>> +=C2=A0=C2=A0=C2=A0 --enable-tests) printf "%s" -Dtests=3Denabled ;;
>>>>>> +=C2=A0=C2=A0=C2=A0 --disable-tests) printf "%s" -Dtests=3Ddisabled =
;;
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --enable-tools) printf "%s" -Dtools=
=3Denabled ;;
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --disable-tools) printf "%s" -Dtools=
=3Ddisabled ;;
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --enable-tpm) printf "%s" -Dtpm=3Dena=
bled ;;
>>>>>
>>>>> That's a great addition, including just for speeding up normal builds.
>>>>>
>>>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>>> Tested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>>>
>>>>> If we want to overengineer the thing, it could be possible to still
>>>>> declare all tests, but not build them by default. However, it's=20
>>>>> probably
>>>>> too error prone and much less simple than this patch. So I don't think
>>>>> it's a good idea.
>>>>>
>>>>> Regards,
>>>>> Pierrick
>>>>>
>>>>
>>>> When is it useful to build without the provided test suite?
>>> I sometimes wished indeed for a --disable-tests switch in the past=20
>>> already (was just too lazy to contribute a patch): I'm sometimes=20
>>> building QEMU in a separate directory, just for a very special case=20
>>> like testing a patch with an --enable-asan build, or for doing a "git=20
>>> bisect". In such cases, I never want to run the normal tests since=20
>>> it's simply not necessary. I run the tests from my main build=20
>>> directory instead once I have a final patch and want to contribute it=20
>>> to upstream. So IMHO this patch is a good idea.
>>=20
>> I similarly have a local patch for this for such usage, that I never=20
>> cleaned up to submit but I think it's a good idea.
>
> I'm not saying this patch is a bad idea, I'll likely use it too;
> I want to clarify what are the valid use cases the community sees
> here. Building pointless things clearly has a negative impact on
> resources and our time, but not testing changes also has.

Perhaps we could add something to checkpatch that emits an error if
config-status has --disable-tests.

> IOW in somes cases this change is acceptable, but I'm a little wary
> on massive use by default.
>
> Anyway I didn't wanted to start yet another endless discussion so I
> won't intervene further in this thread, sorry for the usual noise.

I think we'd rather have your comments and everyone else's, there's no
deadline for anything.

