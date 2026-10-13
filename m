Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4035CC6B08
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 09:36:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGYvp-00050m-Vj; Tue, 13 Oct 2026 05:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xGYvl-0004z1-RQ
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 05:36:21 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xGYvi-0005P9-6D
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 05:36:20 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48c4207ac26so2624404f8f.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 02:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791884176; x=1792488976; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zJ2B3YGLqa/fTs2h9W0STgtWAyJ5ITdQTOb2BD8LgU4=;
 b=R3EMy2C0M7xnDVcfcQKmFsjO3H9drEOhYAXwZqk8GKli5XuVUpTCFFfkfByMG6VKuy
 eeQ94PwaNBUNDmsvpE+/IxQVVzR41ncEtdkqF3RInPiKXfn7znt3+7yCsjoZBPn9yUGz
 v+sO7Dt7ywNV65IdE065khxwbRJvIfkqhKhFd/eNVvhbDrFF2ZH4fMzOG4tzlMjkwakL
 5mOjzNHh3HFJlejUKLBDrd/34ZMECaX77L1rpUCmtxVlFFZ6KttuonvTTDVVt46ROHRo
 cHI1Xcj6HofDS4JijvqCDqrrQkmzL+aHDM1nzgFiQencBi7RXnFzxqTGhXKVpHorVdzT
 0emQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791884176; x=1792488976;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zJ2B3YGLqa/fTs2h9W0STgtWAyJ5ITdQTOb2BD8LgU4=;
 b=nzovQcz0ogWl1fYSw4j7Rlr+S9t+M4GF8dBqWIS7O5o3WdJx9EyRpgNVfZhWe21WkN
 VZk86joR/sDzNskd+0XmXsCO3nZGGDNYcvi4XGv8MolMxCr6xDaoc0cvwZBI2ZBgC0qm
 HtPX3E7jGWomV+m16xXY5Gh0EEVGUjAuFZYYXAxs7tWowJZHCZQVLNBGyzBSaTJxahri
 T3dY8XuqIPbdas8zXRY9JUYfPA1AbyuVWrEBPhtjLDZVKwEIsXanYP9IgwlzwbBWVSyJ
 XoO96eNXLjdHk8yoCdgTIqlLG3cTtyODOslBQh03WYBvjUivwqKuarNPgJlL/Sr+SITz
 pYZQ==
X-Gm-Message-State: AFq9FYKlPPVpBo7p49MdZpADb1QxdwqPbCqpiS4NyOhoq4WS0YtmQcTs
 g61WBHfw26EmFvzvUPPeWIQjtLFjo52rhdJMe/Y8AyYi+OBWDFFLBuSO8+SCvKF2MDs=
X-Gm-Gg: AYBFou2LqZzqXMz8gG5xMfLTyph0c4VHuBudpw8Wp3B6APBb9I88D3EBcZTVsLZkud2
 sZMZtCykvYv6O2wy7R/xvCRsEpTblc87IB4HxF9xMT26PaCUrAvAk73865ZoujeTqBI5Ybncwis
 7gmevRwrduRrSp/egWfAs4v5WkB53r9v7qTYkyCjNqD49XXmwyPwTtl0bpQDm/aBm7j/JyiQWI2
 i3Qu/A6SMN9ImJtV/SPpSPwIJ6hDPSY9SUdfNxHYu6cBLexHXIl7DQXR4DRr1Tb+3xgtJszA+Qn
 p3Tr594KV6yBNflE5bVUH1yBZAKJc2XwtiMj1qZI1DX6Xk1gROeIDLUKy/aljAChrBmNY52GekD
 5TSz9Bhh5IvtFB/Uy2335ToOw3qV3cGEXXuCjFv+/9rrG38fdvX8c8sDArme4B/ADmThcjQiwwU
 xVT+uKnh7tquuveNBm75s9X4wLHRLyHLmDZuTclG56lY34VYYjeu24yV8Vib1lDTcgh4n/uLNO1
 LQwjM/J
X-Received: by 2002:a05:6000:60c:b0:48d:df08:307c with SMTP id
 ffacd0b85a97d-48ddf083082mr5615438f8f.44.1791884176073; 
 Tue, 13 Oct 2026 02:36:16 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0bd1843sm4170779f8f.56.2026.10.13.02.36.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 02:36:15 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4BB425F8E5;
 Tue, 13 Oct 2026 10:36:14 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,  Zhao Liu <zhao1.liu@intel.com>,  Kyle Evans
 <kevans@freebsd.org>,  Brian Cain <brian.cain@oss.qualcomm.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Brad Smith <brad@comstyle.com>,
 Ani Sinha <anisinha@redhat.com>,  Christian Borntraeger
 <borntraeger@linux.ibm.com>,  Thomas Huth <th.huth+qemu@posteo.eu>,  Keith
 Busch <kbusch@kernel.org>,  Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,  John Snow <jsnow@redhat.com>,  Eric
 Farman <farman@linux.ibm.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Anders Roxell
 <anders.roxell@linaro.org>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Warner Losh <imp@bsdimp.com>,  qemu-arm@nongnu.org,  Peter Maydell
 <peter.maydell@linaro.org>,  Yoshinori Sato <yoshinori.sato@nifty.com>,
 Peter Xu <peterx@redhat.com>,  Klaus Jensen <its@irrelevant.dk>,  Song
 Gao <gaosong@loongson.cn>,  qemu-s390x@nongnu.org,  Laurent Vivier
 <laurent@vivier.eu>,  Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH v2 12/16] tests/functional: update arm64 tuxrun images
In-Reply-To: <as3nV9VtVFRYlgUc@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 13 Oct 2026 09:09:59 +0100")
References: <20261012170330.1144446-1-alex.bennee@linaro.org>
 <20261012170330.1144446-13-alex.bennee@linaro.org>
 <as3nV9VtVFRYlgUc@redhat.com>
User-Agent: mu4e 1.14.4-pre6; emacs 30.1
Date: Tue, 13 Oct 2026 10:36:14 +0100
Message-ID: <877bjmgcxd.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

> On Mon, Oct 12, 2026 at 06:03:26PM +0100, Alex Benn=C3=A9e wrote:
>> We now split the fetching of the buildroot image from the kernel
>> itself. This is because we will want to access additional metadata in
>> future tests.
>
> The commit message looks unrelated

Could I word it more clearly?

>
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  tests/functional/aarch64/test_tuxrun.py | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/tests/functional/aarch64/test_tuxrun.py b/tests/functional/=
aarch64/test_tuxrun.py
>> index 0ef1b126fae..6de02e1d8b2 100755
>> --- a/tests/functional/aarch64/test_tuxrun.py
>> +++ b/tests/functional/aarch64/test_tuxrun.py
>> @@ -17,11 +17,11 @@
>>  class TuxRunAarch64Test(TuxRunBaselineTest):
>>=20=20
>>      ASSET_ARM64_KERNEL =3D Asset(
>> -        'https://storage.tuxboot.com/buildroot/20241119/arm64/Image',
>> -        'b74743c5e89e1cea0f73368d24ae0ae85c5204ff84be3b5e9610417417d2f2=
35')
>> +        'https://storage.tuxboot.com/kernels/6.18.54/arm64/Image.gz',
>> +        '39f4633bbcb444267d4d829bd28d8868a287c4c160cda64b0fd23fb090571c=
4e')
>>      ASSET_ARM64_ROOTFS =3D Asset(
>> -        'https://storage.tuxboot.com/buildroot/20241119/arm64/rootfs.ex=
t4.zst',
>> -        'a1acaaae2068df4648d04ff75f532aaa8c5edcd6b936122b6f0db4848a07b4=
65')
>> +        'https://storage.tuxboot.com/buildroot/20260924/arm64/rootfs.ex=
t4.zst',
>> +        '4ab8cec9d1e17dbb1abdf2ae1939ad4f9d0dc2466230f6a119a7c1845cdef0=
b1')
>>=20=20
>>      def test_arm64(self):
>>          self.set_machine('virt')
>> --=20
>> 2.47.3
>>=20
>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

