Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F066C44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 11:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vitKn-0006JV-Pd; Thu, 22 Jan 2026 06:58:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vitKe-0006F7-Fa
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 06:58:38 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vitKb-00059C-Rp
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 06:58:35 -0500
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-4801d21c411so4616165e9.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 03:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769083112; x=1769687912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gHfdd3PqXR+pNd5kr/XcJwuBr+hhdfms2ANVE1n3ues=;
 b=SxTpnzT4PcmZQL5Dei9vC04FDj2CwEtvBOfGb0oDyGi4SUA4AjXirQLKuhBKwAxYZJ
 1D9Z/VKckQUlXlqN881ANUclmqEilFMLk/I5r+mNrvxfTMPTQGkmzwF9hFoiMabpHOCO
 AXPRLX+myguyu6bUHe9IY/cxHm/psO3sAXyjbeQaoGTortZtOTbEOotqqrr7JqRkwflu
 hD/JyXjeupZ2hlOIOV2vPLDk28mpRBVVw+04DceZWA1yU0OE0ukIfJibQzkosoY6ppXh
 +NJ+fJ1RvHvL/aOuiU76abHBX456sJYCYUvC5xubeGDKN66gRhzAaW9DrbvntvCQpw5G
 sobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769083112; x=1769687912;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gHfdd3PqXR+pNd5kr/XcJwuBr+hhdfms2ANVE1n3ues=;
 b=ij+erTRPba6AxbwFA6HZDU7RciFmfZ2gyjuy6iRgPfzur8DGl40GkSIWTeVHSWArZQ
 0H30s4bC2bqauY9M1P19XKCwDckETF/BEV+0NA43oj3qyw5sczVR4IIFPfbskjHdxYTC
 ZQOTcbLY4EVzVxUFgTYmSJsCCTMIS3aw2pLHNKNfmazih0DFNMq0L95qNQtKiEwlGmUS
 sIVDA7K2Ob2V4tRS+62VoLHuxIs3D5kX1l0e4leCY0bN6cIrZQ39r4gDlibtl/a7WUaa
 nEUNYKTVslIHOQ1SuAVmdr/nwXvejy5i8ZUaMh/gUnNi0Ez4pj4YxS1o34MIbO0iHlL7
 MfPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9hLbM1e6VwpDWmNYH97Wg9TZfhLl4RoweBnanaHBy9Hyyqkk3e7I4UO2cJOF3TGzl5Q3dSVnR2nqN@nongnu.org
X-Gm-Message-State: AOJu0YxX6wRPBVl3jGFPGg0cbyaR+6gmkimK/MeyiinYugxkOcWVDLhT
 1u5vc8yxdzuhjIU1k5D2UCwb1u1qBPko9V9MRxk+QpXYgS00bUmnjbpdDuK3jRa2Tzw=
X-Gm-Gg: AZuq6aJ9+NRpQVEntaYb7WOEaTwXIlukOOnbtRQsvepoL/8tvC0+jmaFwmIHAJ+Eose
 FzNxMybD6BHvkC4Pbs3mzJURgM2VWlmb2xEtT8Sis0OnHqZUkbRJ+doBwZ77LpBM7/juJuCAPDn
 cg2yAqcXvEk2eMuZibrN6PbilPrr7Jv8kGtFsLYqcGCOmIO7xjVT6DwgOJygMRPEJavpkkjN7AB
 63GEsTzIavY/q0UOkH4cHFn3wtaoqKeeNFY1NS+lijB9eRHKQGYv8ESsuZ5LAkdnbZ9EKuGDIpC
 QwWYcHqMLQghLaBKHOhE+HbTD4WuDKXnY9NPBb3UiRV3k+K5EpxJDCTCgwA8KTqAqy5URKfoPF0
 v4Pkp3VIHrQJEElZb1k10TsCbcTjcZ5c1YMUdjcv0qwrr4BKkvaM2Z0DhVOx4qxWu88kK4jzrv4
 1g8xB6IlyEfqTUJBNA1XbqJG8=
X-Received: by 2002:a05:600c:630e:b0:479:3a86:dc1e with SMTP id
 5b1f17b1804b1-4801e34f6e7mr326379705e9.36.1769083111644; 
 Thu, 22 Jan 2026 03:58:31 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804702fab2sm60597375e9.1.2026.01.22.03.58.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 03:58:31 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 51C8D5F7C3;
 Thu, 22 Jan 2026 11:58:30 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Stefan Hajnoczi
 <stefanha@gmail.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,  kvm <kvm@vger.kernel.org>,  Helge
 Deller <deller@gmx.de>,  Oliver Steffen <osteffen@redhat.com>,  Stefano
 Garzarella <sgarzare@redhat.com>,  Matias Ezequiel Vara Larsen
 <mvaralar@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  German Maglione
 <gmaglione@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Mark
 Cave-Ayland <mark.cave-ayland@ilande.co.uk>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,  =?utf-8?Q?C=C3=A9dric?= Le
 Goater <clg@redhat.com>
Subject: Re: Call for GSoC internship project ideas
In-Reply-To: <995d4aaf-bbff-42be-9114-1f04bb51e37c@redhat.com> (Thomas Huth's
 message of "Thu, 22 Jan 2026 12:05:14 +0100")
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
 <CAMxuvaz8hm1dc6XdsbK99Ng5sOBNxwWg_-UJdBhyptwgUYjcrw@mail.gmail.com>
 <CAJSP0QVQNExn01ipcu4KTQJrmnXGVmvFyKzXe5m9P3_jQwJ6cA@mail.gmail.com>
 <CAJSP0QW4bMO8-iYODO_6oaDn44efPeV6e00AfD5A42pQ9d+REQ@mail.gmail.com>
 <aXH4PpkC4AtccsOE@redhat.com>
 <130b8f26-2369-48f5-bbd6-e27210707b9f@redhat.com>
 <aXIAmeEWMFjQM84o@redhat.com>
 <995d4aaf-bbff-42be-9114-1f04bb51e37c@redhat.com>
User-Agent: mu4e 1.12.15; emacs 30.1
Date: Thu, 22 Jan 2026 11:58:30 +0000
Message-ID: <87a4y5oo49.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
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

Thomas Huth <thuth@redhat.com> writes:

> On 22/01/2026 11.48, Daniel P. Berrang=C3=A9 wrote:
>> On Thu, Jan 22, 2026 at 11:43:35AM +0100, Thomas Huth wrote:
>>> On 22/01/2026 11.14, Daniel P. Berrang=C3=A9 wrote:
>>>> On Tue, Jan 20, 2026 at 04:42:38PM -0500, Stefan Hajnoczi wrote:
>>>>> Hi Marc-Andr=C3=A9,
>>>>> I haven't seen discussion about the project ideas you posted, so I'll
>>>>> try to kick it off here for the mkosi idea here.
>>>>>
>>>>> Thomas: Would you like to co-mentor the following project with
>>>>> Marc-Andr=C3=A9? Also, do you have any concerns about the project ide=
a from
>>>>> the maintainer perspective?
>>>
>>> I'm fine with co-mentoring the project, but could you do me a favour an=
d add
>>> some wording about AI tools to
>>> https://wiki.qemu.org/Google_Summer_of_Code_2026 to set the expectations
>>> right? Since we don't allow AI generated code in QEMU, I'd appreciate i=
f we
>>> could state this in a prominent place here to avoid that some people th=
ink
>>> they could get some quick money here by using AI tools, just to finally
>>> discover that AI generated code is not allowed in the QEMU project. Tha=
nks!
>>>
>>>> IMHO, our baseline for functional testing images ought to be
>>>> a Linux Kconfig recipe used to build a dedicate kernel, plus
>>>> a busybox build for the target.
>>>
>>> Not sure if we want to add kernel compilation time to the functional te=
sts
>>> (even if it's only done once during the initial build)...? That could e=
asily
>>> sum up to a couple of hours for a fresh checkout of QEMU...
>> That's absolutely *NOT* what I was suggesting.
>> We should have a 'qemu-test-images.git' repository that maintains
>> all
>> the recipes, with CI jobs to build and publish them (along with correspo=
nding
>> source). Those prebuilt images would be consumed by QEMU functional test=
s.
>> This would be quicker than what we have today, as the images downloaded =
by
>> functional tests could be an order of magnitude smaller, and boot more
>> quickly too.
>
> Ah, sorry for getting that wrong!
>
> Ok, so this sounds basically just like a gitlab-CI wrapper around what
> buildroot.org already provides. ... not sure whether that's
> challenging enough for a GSoC project?
>
> Also, adding this as a separate repository will easily burn your
> gitlab-CI minutes if you don't have a dedicated runner for this, so
> developing this feature might be no fun at all...

My intention was to get the test images as part of buildroots own
testing setup and re-use them for QEMU.

>
>  Thomas
>
>
>  Thomas

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

