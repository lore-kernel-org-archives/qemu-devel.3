Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69413C5DF9C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 16:03:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyX7e-0002uQ-Gh; Mon, 24 Aug 2026 12:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wyX7S-0002nL-UY
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 12:02:00 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wyX7Q-0003Gj-K7
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 12:01:54 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6a36982a875so5511986a12.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 09:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787587311; x=1788192111; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+Jnhu5+PvC2KeRhTRV9ZI7CDYeUyxbjrSrClEiJEA1Y=;
 b=oxVOauDvazW41zGJfAVCU5BW5PzL2B0v5G6QWuxRHW2ZfFVEkSsBAIznhY0THjjH7i
 Tl6toSgpm/VBOs2QX8S/VVNN4Qybv3e/73FZ3J196c7ZeUKwvQcOhv0alno7EwUZhSNr
 Dy+EzGsIkdwPJvoEtl8cxuuElmAeIF3Ub086ROv9aWboNdBgsTQtHZROu6+nJ/Wia/Zs
 MjrSwiXcqX+1dXyM6YCJb3GDklfWDp441lOF0Bui5mquZvS0/M+8RO7z5k1jcM3Enirs
 Hl81ycdOJN7DG9B1dWukyfzu0wDY1sBSVIYKLP7K1n0oYshOa3MzEUw3yrLvrxrnd7CC
 5yVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787587311; x=1788192111;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+Jnhu5+PvC2KeRhTRV9ZI7CDYeUyxbjrSrClEiJEA1Y=;
 b=LA09+0Qc5pyFJEB36lXnotTEvGOfNgK5kPfm+PivOjKtWTgIw20OE0pspJjhV9plSD
 UgwcMucuUj4uzgoGZ1wwGoo+m0urBCYQtmCX4wcDXazEor5wvQS8xqvPAy/hcfouESBO
 tCnqFTIM+YLPHh10XCkOXB9KcvmRKwbAohebhRb0vgtGdVVVIpKE3uynJ1XM77NELzm+
 QGMAuIGxMrmRJMh42of6Ebx9z3pbdbEiZJq8p7c90ssr6JpdCwDOXj6+36D6nOlkLK5H
 YYXGQ/rULyUNLu6mnKp72G9rAykm1TODzRf/dDP1WxD9UM1VHBKFJ+xKjljN7ZiFU+qP
 0DBw==
X-Gm-Message-State: AFuF++k8XRpToyvUhMe1W68JcjoyVkNuFbg1GdtiIPqmZWWSkRw/tsbz
 KTc6zXnFI218gmDrbzEX6Tofm08xfrA8gvfefreN1G+ehHuuB4OdCGsax5NepsXTwYM=
X-Gm-Gg: AR+sD10a88w405cG7gZ6sJATvhhWT88TmX1S67k9LWKm4qi1O6xBjCT52NBBejDDwsm
 eiEHXzqjTf53RHnrBa9IdxB+EugA78Aheoxhjrc8gga3RxogNROf8213Sth55YwPHeXfIAMZbdz
 YAIwyVLOBQUfJEi73Eyj4iW2NRgxDXwoZfJevgYTtsgeetnhefyE4/n5e+s9LSf3lneL/RHOvu1
 ihoZYTwDPhpw0wp3RnC0sN1fHaPxMq73ik7ATaWoqSWpv4ROo5rzxGwMwowgbdJtbpFmaaDOJ81
 phGlKgb3Tqif54doywAN0lwoRWzx027FJyHOEeHv7u/2gBTKETsfeMvZyG158UDx0MQVOJia8MK
 AwpK+V9F2qmVO5ZDxCO2ouEG6ypHHomSWTNkqOmgllVEB+KyodD8tLTUf76Ux1DNLqbvpPBFry5
 Xc1CJvamm3jxZLeuB4eV2saqp2RNnPViIW9jI65TFlqR4bF+qoRh0TjP88S9ij
X-Received: by 2002:a05:6402:a0c5:b0:6a1:f26d:ba78 with SMTP id
 4fb4d7f45d1cf-6a42f1f2166mr32323230a12.11.1787587310624; 
 Mon, 24 Aug 2026 09:01:50 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e199c4asm9067932a12.14.2026.08.24.09.01.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 09:01:49 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2DCA05F7F5;
 Mon, 24 Aug 2026 17:01:48 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  qemu-arm@nongnu.org,  "Gonglei (Arei)"
 <arei.gonglei@huawei.com>,  zhenwei pi <zhenwei.pi@linux.dev>,  "Michael
 S. Tsirkin" <mst@redhat.com>,  Stefano Garzarella <sgarzare@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,  Amit Shah <amit@kernel.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  John Snow <jsnow@redhat.com>,  Kevin Wolf
 <kwolf@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org,  devel@lists.libvirt.org,  Fabiano Rosas
 <farosas@suse.de>
Subject: Re: [PATCH v2 6/8] tests/qtest: add test case for fdc sector overflow
In-Reply-To: <aoxjLcRuc7sHnIPz@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 24 Aug 2026 16:28:45 +0100")
References: <20260824-fixes-for-11-2-v2-0-352c6b890402@linaro.org>
 <20260824-fixes-for-11-2-v2-6-352c6b890402@linaro.org>
 <aoxjLcRuc7sHnIPz@redhat.com>
User-Agent: mu4e 1.14.4-pre1; emacs 30.1
Date: Mon, 24 Aug 2026 17:01:48 +0100
Message-ID: <87pkz7qzgz.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, Aug 24, 2026 at 04:24:53PM +0100, Alex Benn=C3=A9e wrote:
>> Add a test case for #3800 where we check that the last sector is
>> properly bounded by the physical media that is inserted.
>>=20
>> Link: https://gitlab.com/qemu-project/qemu/-/issues/3800
>> AI-used-for: initial draft of test
>
> Wasn't the change in AI policy still pending a new patch
> proposal from Paolo ?

Yes it is, however given I was rushed and am not super familiar with the
fdc qtest code I took a shortcut to get something posted. FWIW it's mostly
as the original prompt created apart from:

  - I added the TEST_IMAGE_xxx changes
  - I suggested fake_lastsect/fake_getsect naming over the original suggest=
ion
  - I asked it to expand the comments on using RESTORE/SAVE after
    consulting the datasheet myself when reviewing the code

Think of it as a road test for the proposal...

>
<snip>
>>=20=20
>> -#define TEST_IMAGE_SIZE 1440 * 1024
>> +#define TEST_IMAGE_1440KB (1440 * 1024)
>> +#define TEST_IMAGE_720KB (720 * 1024)
>>=20=20
<snip>
>>=20=20
>> +/*
>> + * Query cur_drv->last_sect using the SAVE command (CMD_SAVE, 0x2e).
>> + * Byte 8 of the 15 result bytes returned by CMD_SAVE holds last_sect.
>> + */
>> +static uint8_t get_lastsect(void)
>> +{
>> +    uint8_t res[15];
>> +    int i;
>> +
>> +    floppy_send(CMD_SAVE);
>> +    for (i =3D 0; i < 15; i++) {
>> +        res[i] =3D floppy_recv();
>> +    }
>> +    return res[8];
>> +}
>> +
>> +/*
>> + * Attempt to set cur_drv->last_sect directly using the RESTORE command
>> + * (CMD_RESTORE, 0x4e).
>> + * While the 82078 datasheet describes RESTORE for restoring a previous=
ly
>> + * saved state, a guest can issue raw RESTORE commands with arbitrary
>> + * parameters without having issued SAVE. Parameter byte 9 is used by t=
he
>> + * controller to restore cur_drv->last_sect.
>> + */
>> +static void fake_lastsect(uint8_t last_sect)
>> +{
>> +    floppy_send(CMD_RESTORE);
>> +    floppy_send(0); /* fifo[1] */
>> +    floppy_send(0); /* fifo[2] */
>> +    floppy_send(0); /* fifo[3]: drv0 track */
>> +    floppy_send(0); /* fifo[4]: drv1 track */
>> +    floppy_send(0); /* fifo[5]: drv2 track */
>> +    floppy_send(0); /* fifo[6]: drv3 track */
>> +    floppy_send(0); /* fifo[7]: timer0 */
>> +    floppy_send(0); /* fifo[8]: timer1 */
>> +    floppy_send(last_sect); /* fifo[9]: last_sect */
>> +    floppy_send(0); /* fifo[10]: lock/perpendicular */
>> +    floppy_send(0); /* fifo[11]: config */
>> +    floppy_send(0); /* fifo[12]: precomp_trk */
>> +    floppy_send(0); /* fifo[13]: pwrd */
>> +    floppy_send(0); /* fifo[14] */
>> +    floppy_send(0); /* fifo[15] */
>> +    floppy_send(0); /* fifo[16] */
>> +    floppy_send(0); /* fifo[17] */
>> +}
>> +
<snip>
>>=20=20
>> -    /* Create a temporary raw image */
>> +    /* Create temporary raw images */
>>      fd =3D g_file_open_tmp("qtest.XXXXXX", &test_image, NULL);
>>      g_assert(fd >=3D 0);
>> -    ret =3D ftruncate(fd, TEST_IMAGE_SIZE);
>> +    ret =3D ftruncate(fd, TEST_IMAGE_1440KB);
>> +    g_assert(ret =3D=3D 0);
>> +    close(fd);
>> +
>> +    fd =3D g_file_open_tmp("qtest720.XXXXXX", &test_image_720k, NULL);
>> +    g_assert(fd >=3D 0);
>> +    ret =3D ftruncate(fd, TEST_IMAGE_720KB);
>>      g_assert(ret =3D=3D 0);
>>      close(fd);
<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

