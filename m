Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15705C982CF
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 13:25:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7C6j-0007Cl-Oj; Thu, 17 Sep 2026 09:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7C6e-0007B5-LM
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 09:24:53 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7C6a-0001cF-Q8
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 09:24:51 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49e69b9e16aso8239805e9.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 06:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789651486; x=1790256286; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Ga8Fn+E2e0/kenWcJ7v5mMLDb0i5OVxx3dxW9Oyn8Mw=;
 b=z6+6sdpotTHS/4fvali+gm5lFvzFWboHkqua/RZKdrFfRc1QqKB8s1usUPtlkwWfdm
 nbP+cAFP+GCgf79MJPAWYCodb995Ro3Rop52OpgDs6TbzC5kP5lfZ14khZCMUVLE1Bng
 nsbivg60TmW8VEY5IsblQyH79Pd8DFgi5O6uE6qH3j1Hk+v9utqt3mvgUxDvDcE+F8Hi
 3BhqEBIihe4AYORLxKj3ujhqVwuwoRzB+4GaPxfUV7BIk2v29iBRMU7lj0q1nVOLfZ2a
 Etd4RDd4NK3uKqZOMpUqZ7ZHWghO+I9Zv7uLjBPyexP+OH01HuYupBgn+M2x75w0vYWz
 XCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789651486; x=1790256286;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ga8Fn+E2e0/kenWcJ7v5mMLDb0i5OVxx3dxW9Oyn8Mw=;
 b=tpjgJwc2YxXpZYpWfo4stQmykDBNtsUF90cZqTrbQHwT9BrWKlVdPgbgE3FbkApfMz
 QFaa3yVweueE2A4Xfd/Duxa6DiiYRhd21cigqqDfDol3/v7KHbHRETZh6shqRvRIEmOD
 X2AN/er/a4lqkvSj3nNTT0pb8xzAdjT5BB80HT/hwelWBZw/eaVl5iVEDtYr5ySjBHVN
 2vOE3VQIvAf7Id3bewRytSLNZgjrEAZdzHBS326NrHfMK6qTCATQNculJxckDedZdnWG
 GTLjYqMS86uQDizPr+AEGZPRlhQ4JgQHcmowFByz12778VJGcO+4oO+C3m2OP1/oDP5i
 xe4g==
X-Gm-Message-State: AFuF++meSlqu/G1zYlnqDsgYea0g9Zd+F2pjrfRBeVkmzEYyzMFyW6er
 Oj16Ph+wB10f5Ydzq2n9NDYhAIB4rAbRNTZpF2VVfuGXrHN4yaUwaDP+/j4Vx+EzSEY=
X-Gm-Gg: AYBFou0fwIfvON3871hFbgDfJNY/kM0i6E3r0IAtLjJJU/5ZclhmYyxzf2FiUjWBFN4
 eDzOxTmeYe9xx1MqcsL2ZPyxWjsrAOi1jB2VthKJnJSzvtLvtET+Y+dwQB8zJOrKXIn5JTijzgt
 ftklopgqV6VnH8KET27TPXqkYJBWgejQD4835KKSBlF8TZcfmmeQd/gn6KK1905g1dawKLWnzsl
 HqEJcB0kaVgUGVToNUuiXxX5143nZQzdqSn2ln+aLBIxtVmPEK6lOCT0++P0XiWSqtI/dXeWBOW
 5X1RS7b9QOXdtYD64hed8SmRA1eJbLN/qJb79bDRviSmkJOymdpbJ93VHt/NmeRqff+EkucxopT
 6FWp4pdxoshyd7yQy9IBzC+mlpI9HVT7Xh2Axyajo3Afy0vVfGeTjFZI15CMt3ankFtZTujAWzO
 YdSPyVmzsUe5NRDWHaQRaIflqIVpjrynSUdpx7l8wr5CMROQFfpBqQnnr1x1X6koHaYIgu6Mc=
X-Received: by 2002:a05:600c:8518:b0:49c:fa21:1c86 with SMTP id
 5b1f17b1804b1-49eb73308b1mr84792035e9.27.1789651485872; 
 Thu, 17 Sep 2026 06:24:45 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd23f4e6sm91676035e9.8.2026.09.17.06.24.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 06:24:45 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E981F5F834;
 Thu, 17 Sep 2026 14:24:43 +0100 (BST)
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
Subject: Re: [PATCH v4 02/19] Revert "tests/tcg/meson.build: implement
 ./configure -cross-cc-* options"
In-Reply-To: <65a743c6-54ae-4e2c-ae4d-08e1d6f87ef3@oss.qualcomm.com> (Pierrick
 Bouvier's message of "Wed, 16 Sep 2026 09:31:45 -0700")
References: <20260916153013.2134555-1-alex.bennee@linaro.org>
 <20260916153013.2134555-3-alex.bennee@linaro.org>
 <65a743c6-54ae-4e2c-ae4d-08e1d6f87ef3@oss.qualcomm.com>
User-Agent: mu4e 1.14.4-pre3; emacs 30.1
Date: Thu, 17 Sep 2026 14:24:43 +0100
Message-ID: <87wlsk6mec.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x10.google.com
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> On 9/16/2026 8:29 AM, Alex Benn=C3=A9e wrote:
>> We want to keep configuring of the cross compiler within configure so
>> it can be used by the firmware.
>>
>
> Would that be possible to add in command message that it disable effect
> of those options for tcg-tests?

I'm wondering if we should revert this at all, or just merge with the
meson commands (because currently this breaks the MacOS tcg checks)
>
>> This reverts commit 7e1d54da6faf10e1fc70f6b3d8247068b80b1597.
>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>=20
>> ---
>> v3
>>   - declare empty container_command/use_containers to avoid unref var
>> ---
>>  configure             | 31 ++++++++-------
>>  meson_options.txt     | 89 -------------------------------------------
>>  tests/tcg/meson.build | 31 +++------------
>>  3 files changed, 23 insertions(+), 128 deletions(-)
>>=20
>
> For the rest,
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>
> Regards,
> Pierrick

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

