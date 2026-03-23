Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55BD1EC01A5
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 08:46:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4avD-0002wo-Dl; Mon, 23 Mar 2026 04:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1w4av1-0002rm-GY
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 04:45:51 -0400
Received: from mail-dl1-x1234.google.com ([2607:f8b0:4864:20::1234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1w4auz-0001wH-CF
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 04:45:50 -0400
Received: by mail-dl1-x1234.google.com with SMTP id
 a92af1059eb24-12a71ade78cso3034322c88.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 01:45:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774255547; cv=none;
 d=google.com; s=arc-20240605;
 b=YmUDSw6FLzFeKMoq1k7JWCZPj8alaJIas/czaaFCbRPxCAKkrRGAU8emS1ZS7Dbh/l
 AGrbNJhxCuG44HMQORZKn6zWq887M2sR9hqh7DlrlGUCmUArIwQWEmXanDl4x+C0Dzqz
 cE6wWIDJdaVEfc/Bpm6u71eU2u8lwojL59fPTlUVFyHWZrd9nQAvsGdN5NXXJEs1xC6x
 wzcR8wdlK8+3QVxmy8w3t+EwvSJJ0aEQhMQ+xpO7YcFkhk7LFny4asw/uuuuTowRvoJp
 RHxky6NgpdFhvHyUj99DLDlE33w7Al4/5XJGJBwLQp/+foinPnRIuLw1bUgXM+e7Z2FA
 k1DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oWELl6eArAQdDQJ3lpu/o5eM21u1lCrRBSAETaQgXvM=;
 fh=gogkjo7Kd2IF2Dzbu8MyraoP0lpaqyCJnuKsD6IlXUI=;
 b=Oa00C9B+PvFakmvKvkcBbk96d6/npB5jpmPEWDCnelTlJg0P3ys0qLJ+6gJLeHguDv
 bv1uIk/8x4m3NIRveKA8A0qqRdhnL7JOjOyaMDAuqpQcW2RDwvdAEfEULZQtCoiRw1//
 N7mK2e0qs5pne+Qry0iQ7JnRDryQjk22kqp0Vc6aez4PjFOk95QBHxvPx/xZukFBXfFp
 lZ25lEyIuIQwdEuB6kstYEnUnMZc4RwOKBVdUMKCpZw5KpgHdUqGpbd0OBYfNocA6rZQ
 YnUM6J/XeZb3j4BJjAQ8VF2fCxoGGS/pdSY5WlJLTpjNxVyqkhqK0tyg8h3B2gMCUVo/
 jfrw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774255547; x=1774860347; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oWELl6eArAQdDQJ3lpu/o5eM21u1lCrRBSAETaQgXvM=;
 b=ck3RtpepGMacycsVnGcuU1zTCuvK3Q8xqflAb4tVsYeBGmrbyVshLemvJ7GHfitx8Y
 EADh6Fx+VGpP6wzzLse5/C633o3QJZJo5GMr+aHcosyVfQlACJjTiJ9VyqQisUp5lSQC
 UdQSQYLxxkFam2TAyCGnPmrrJLJYBG+5Teyadlvwgn/chaC27aS+OrOiDNu4c1FbO7BP
 CRVOZS5b7ovLDafgPmxYoOudlQJK6d7wlHDlHg2yucN3KG6GIW6EUQ57wD9O6P5gGroi
 NwvLkvx4D/kGko8n++SM4lHkVIRLQsGH44mJpFtMvxbIWFgoVVXInpFiniUPSwG6vi2u
 qjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774255547; x=1774860347;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oWELl6eArAQdDQJ3lpu/o5eM21u1lCrRBSAETaQgXvM=;
 b=DRrw6Foy1Hvguq8wy+Mr5z5NetAcaOjKeBsHtKNbNOx/tTzjq3yB4OmkEUuMPkMfTV
 GzshqKSw0LTlvPyLu+8znzs8kLKOtnnqxAAMI/aQhEO3OVTCpJr7EH4gxuvxMeOsA5E4
 9DH7Ic9kzXXvxwm3BZhTlQa6nPW2YEaFFbOl/CpS0MvLV5jltLnDH6sCl6/ncthBQH1C
 pVzznokhJQnGjToSpDmPc9Z1l4N/MNXFt3FnU20lKZlJXK28UvMIxGmjRoYg64NKN+2j
 jOQ+3aw4ddZMLUz3x19QtN1xi70owCcDiyL/R1HScLDUCUGoLfmWFo9Eo1M5+8FkEYha
 wbGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKGTCyK/2ycWqAaKD8mPF8BMEm24DLx7dmOluMKjPIpuSyt/lAFb/VIhsJjPQdkm9RrrBTn2hr74WI@nongnu.org
X-Gm-Message-State: AOJu0YwfabGLcnNdD2djR3EsmUCRIaGR8ApsIQvudpFhGS9rqFaDxc6M
 uvLN7PQtApb3A//ZorW6oui3CmEyiXmwJs7+B/Aorcp0h6/+bRXYVezn6C+1+uQqEdlDZgxgwqo
 pE04B6jIeFxWDbpae7RmD52iyD/XFiCY=
X-Gm-Gg: ATEYQzzMSy5bTz09wHNc3P0HHKYHPA1ySFYg4E2Ov5ifCR7FYgyOjSpVMbXQ7laPhiw
 /azz/CLp58vHh/ci2w5itIz0rV2gjGJxKa8f8M+AXWMD/ilmsLknS6BHtfORRur1MiI9DUetvJ9
 WmmiXbuVAwF4M3RuVQePn0JGDIyArEtybRHkSe3bf1+obm09+rbU51M23XGpJC8lr+eHAbeu3Ck
 VpyWix/ITk5M/U67+u4V+9P8O/oXShXGrFyfjG8ORTgG7+TNBu4iVWsK5aiMk4ZefL5u1P6F91Y
 chpMLm80tasU6JufeZyTO3FMwHAmftLn/7sbIYE=
X-Received: by 2002:a05:7022:ebc7:b0:128:d450:bc76 with SMTP id
 a92af1059eb24-12a726dc1c0mr5115642c88.26.1774255546939; Mon, 23 Mar 2026
 01:45:46 -0700 (PDT)
MIME-Version: 1.0
References: <20251112134143.27194-1-philmd@linaro.org>
 <0faef1dc-6fde-41b1-bf1e-8ecfe49033f7@tls.msk.ru>
 <a50b8ccb-4d13-431b-836e-b08e5add71bd@linaro.org>
 <95e61064-c8e8-4c36-9371-cbd28ab737c8@tls.msk.ru>
 <17f7b53d-dbb7-4090-a6ac-671c85dd611d@linaro.org>
 <8ca786b1-765b-4dc4-92fd-6ba6aeedf098@tls.msk.ru>
 <c8536f00-efbc-441a-8725-bfe80aa8666c@linaro.org>
In-Reply-To: <c8536f00-efbc-441a-8725-bfe80aa8666c@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 23 Mar 2026 12:45:35 +0400
X-Gm-Features: AQROBzA1ujWORgZ1Eu_xaHgFh8j95zDTxQNqMRN9r7ZpbNrANbFcyffZ35cxKaI
Message-ID: <CAJ+F1CKkpcYCAnv1YACrnySodumarEQy0Ff-UedWY_Q4u3C7vg@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] chardev: Improve @docstring and clarify
 qemu_chr_write() uses
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1234;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dl1-x1234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi

On Mon, Mar 23, 2026 at 6:05=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> On 3/21/26 11:15 PM, Michael Tokarev wrote:
> > On 12.02.2026 23:13, Philippe Mathieu-Daud=C3=A9 wrote:
> >
> >>>>>   From this patchset, 1 change has now found its way to the master
> >>>>> branch:
> >>>>>
> >>>>>    chardev/char-pty: Do not ignore chr_write() failures
> >>>>>
> >>>>> Besides it, the following 2 changes were marked for-stable:
> >>>>>
> >>>>>    chardev/char: Allow partial writes in qemu_chr_write()
> >>>>>    chardev/char: Preserve %errno in qemu_chr_write()
> >>>>>
> >>>>> Are other changes (including the above 2) not needed anymore?
> >>>>
> >>>> They are, I need to reply to Marc-Andr=C3=A9 and respin a v4...

What was that for?

> >>>>
> >>>> Old bugs so can wait 11.0 :S
> >>>
> >>> Found an old(ish) thread...  ping? :))
> >>
> >> Cc'ing new docs/ maintainer :P
> >
> > Ping *N?  11.0 is almost out already..
> >
> > /mjt
>
> I didn't answer previously, since it was touching code in addition to
> docs, and was expecting this to be picked up by chardev maintainer
> (Marc-Andr=C3=A9 in this case if I'm right). So I assumed it fell back to=
 a
> subsystem documentation change and not a general one I was supposed to ta=
ke.
>

I think we missed the boat for 11.0.

Philippe, maybe you can rebase, and I will queue for 11.1?

--=20
Marc-Andr=C3=A9 Lureau

