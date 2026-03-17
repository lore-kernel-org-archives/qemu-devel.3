Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE9D6FED9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 15:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2WBw-0003vE-Hc; Tue, 17 Mar 2026 11:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w2WBu-0003uh-Jy
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 11:18:42 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w2WBs-00056s-A5
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 11:18:42 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-660dcafc85aso11373607a12.0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773760718; x=1774365518; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0g+qhOMUjotKFejKSNzeRvUunOhKK5R6v66N7rslz4Q=;
 b=lKfrdWaRnEiPtDapX1KwNTI8sF7X2jS2CKC0xK6X8sAhE941SCo93+u0XXO+4Pb7dv
 6ZHoyYwv1KtKcKu3T2Y51wH42Bfz9GBuZeMibprGdzoiaAjHuxqGN/aPrNCX21CdVSHE
 Xgoh6/+5ED5IB8TLxpu5BPqcu7QwKqw6OHc8XNTSKjKXki7q0ZQik5ONST8wnlHqRRn/
 Fuac97mlFKKkoeE/Obg1+rb2nr2s7F3QmLPRbTWPU8wcI8WpA7AaNTGF3eEst6gsGKSb
 7uGIv84+mYT/N/5UvVVktX2S1RoGZZ05LaGEtjF7pyHsa44iUwl2RoEGT/ZeO/rz2xJY
 STcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773760718; x=1774365518;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0g+qhOMUjotKFejKSNzeRvUunOhKK5R6v66N7rslz4Q=;
 b=OTjTbtbliPfNexitwPBNLvAxFOqkQSB6qONW4BfAtpLE15x0kDvrYTOB9UkzANZzM4
 sR/Ez1KPoZo1jvlwnzjThD+gCKdZ6zWAjoYd5mBcVBwRZYzD2pVTEDXXTZlDtDILAnxA
 eCJyv7WEexmEQ5Kruw/2EtHtcwfzOm0IEYYOxfKfBZX1z48YPI3L7PiWD+p4GXfuXPt/
 mgYtMDKPz7Dt75xCtHRQq+Xv/75ZCtAIvIZerXM6H9WS0o8h4+zHfxAS+EMrSlRJiSI1
 FVQ57q7kPlkjLUl2nKtGzEpWvbZPFXBvCnu6UJ8r6mUOpp9sQwOontPHKRYqesW8KxdU
 ZMUA==
X-Gm-Message-State: AOJu0Yy5F8sJm7TRqKea04VOX9QLJWE2TiiE6yqSqr9bwir7H+q2OkqN
 o2gnytsrElzF3rTg82psK1As8TigmR0GwRM6tR3pZ7ckqeybve5ymvfTFw9u3Vp3bXs=
X-Gm-Gg: ATEYQzxIdsyay0DP77srqjiVqUWC+/ux16NOw50UYO1BFujaHEd+RYUN2J8Ua1WfXdq
 1uFsq+g/At4IEXv1fO5yWLwoI3T4I/osHC66orwaQWB64rF5mCmoqrXCVk0djS793KO9roi5WPm
 ZRz3o966A8Ca7XyXbbFAuaq7jzK3F4b2mW/+waTj6Rw11T1rL+APMV1L9uwviWqFi0hIgwTjov+
 ou47ACdQVyasnKG2RZER1DDAxu91SrPUdfu/HR44KH7r7xsb4o8RIDsoA3PwWRVnSJeHMHTBHJQ
 2/S9JHjnhJNTPGoSs5a/1W3z4/OoLmxHBHGddedhIG2Dg+cm7DltzIVC9FxJPd0p4gsJvSZxim4
 pTvBqtpdv7uANdMQBYTunpBto/GLxZOANiekms7Y02cXZ4w76CnINxVWLM6X5dGPOHDXTYNmFh6
 nlqz4Hmx+UATV1KedaxtffDQY=
X-Received: by 2002:a05:6402:2744:b0:64b:5562:c8f4 with SMTP id
 4fb4d7f45d1cf-667b2342406mr22968a12.7.1773760718234; 
 Tue, 17 Mar 2026 08:18:38 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-667b12a0693sm34190a12.25.2026.03.17.08.18.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 08:18:37 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BBDDE5F806;
 Tue, 17 Mar 2026 15:18:36 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Daniel =?utf-8?Q?P=2EBerrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 2/3] tests/lcitool: Update openSUSE to version 16
In-Reply-To: <b4db6dcf-a55c-4c11-bae7-c19f8f03d755@redhat.com> (Thomas Huth's
 message of "Tue, 17 Mar 2026 15:51:08 +0100")
References: <20260316135407.209072-1-thuth@redhat.com>
 <20260316135407.209072-3-thuth@redhat.com>
 <877brbomx1.fsf@draig.linaro.org>
 <b4db6dcf-a55c-4c11-bae7-c19f8f03d755@redhat.com>
User-Agent: mu4e 1.14.0-pre2; emacs 30.1
Date: Tue, 17 Mar 2026 15:18:36 +0000
Message-ID: <87jyvacwmr.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
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

> On 16/03/2026 15.43, Alex Benn=C3=A9e wrote:
>> Thomas Huth <thuth@redhat.com> writes:
>>=20
>>> From: Thomas Huth <thuth@redhat.com>
>>>
>>> The first version of openSUSE 15 has been released in 2018, and
>>> according to our support policy, we "support the most recent major
>>> version at all times for up to five years after its initial release."
>>>
>>> Since openSUSE 16 has been released a while ago, and openSUSE is
>>> clearly older than 5 years already, it's time to update to version 16
>>> now.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   configure                  |  1 -
>>>   tests/lcitool/mappings.yml | 58 --------------------------------------
>>>   tests/lcitool/refresh      |  2 +-
>>>   3 files changed, 1 insertion(+), 60 deletions(-)
>>>
>>> diff --git a/configure b/configure
>>> index cd1dadd8bb2..f3603fd9160 100755
>>> --- a/configure
>>> +++ b/configure
>>> @@ -929,7 +929,6 @@ if ! check_py_version "$python"; then
>>>     error_exit "Cannot use '$python', Python >=3D 3.9 is required." \
>>>                "Use --python=3D/path/to/python to specify a supported P=
ython." \
>>>                "Maybe try:" \
>>> -             "  openSUSE Leap 15.3+: zypper install python39" \
>>>                "  CentOS: dnf install python3.12"
>>>   fi
>>>   diff --git a/tests/lcitool/mappings.yml
>>> b/tests/lcitool/mappings.yml
>>> index 60618971584..62fe60d047f 100644
>>> --- a/tests/lcitool/mappings.yml
>>> +++ b/tests/lcitool/mappings.yml
>>> @@ -3,70 +3,17 @@ mappings:
>>>     bindgen:
>>>       Ubuntu2204:
>>>   -  flake8:
>>> -    OpenSUSELeap15:
>>> -
>>>     meson:
>>> -    OpenSUSELeap15:
>>>       # Use Meson from PyPI wherever Rust is enabled
>>>       Debian:
>>>       Fedora:
>>>       Ubuntu:
>>>   -  python3:
>>> -    OpenSUSELeap15: python311-base
>>> -
>>> -  python3-PyYAML:
>>> -    OpenSUSELeap15:
>>> -
>>> -  python3-devel:
>>> -    OpenSUSELeap15: python311-devel
>>> -
>>> -  python3-docutils:
>>> -    OpenSUSELeap15:
>>> -
>>> -  python3-numpy:
>>> -    OpenSUSELeap15:
>>> -
>>> -  python3-opencv:
>>> -    OpenSUSELeap15:
>>> -
>>> -  python3-pillow:
>>> -    OpenSUSELeap15:
>>> -
>>> -  python3-pip:
>>> -    OpenSUSELeap15: python311-pip
>>> -
>>> -  python3-pillow:
>>> -    OpenSUSELeap15:
>>> -
>>> -  python3-selinux:
>>> -    OpenSUSELeap15:
>>> -
>>> -  python3-setuptools:
>>> -    OpenSUSELeap15: python311-setuptools
>>> -
>>> -  python3-sphinx:
>>> -    OpenSUSELeap15:
>>> -
>>> -  python3-sphinx-rtd-theme:
>>> -    OpenSUSELeap15:
>>> -
>>> -  python3-sqlite3:
>>> -    OpenSUSELeap15: python311
>>> -
>>>     python3-tomli:
>>>       # test using tomllib
>>>       apk:
>>>       Fedora:
>>>       Debian12:
>>> -    OpenSUSELeap15:
>>> -
>>> -  python3-venv:
>>> -    OpenSUSELeap15: python311-base
>>> -
>>> -  python3-wheel:
>>> -    OpenSUSELeap15: python311-wheel
>>>       rust:
>>>       Debian12: rustc-web
>>> @@ -79,12 +26,7 @@ pypi_mappings:
>>>       default: meson=3D=3D1.8.1
>>>       # Drop packages that need devel headers
>>> -  python3-numpy:
>>> -    OpenSUSELeap15:
>>> -
>>> -  # see above
>>>     python3-tomli:
>>>       apk:
>>>       Fedora:
>>>       Debian12:
>>> -    OpenSUSELeap15:
>> I'm unsure about the mappings stuff just because I'm not sure what
>> it is
>> for. Does it supplement the mappings in libvirt-ci itself?
>
> Yes, that's how I understood it. Since this is just an extension to
> the mappings from libvirt-ci, I think we can safely remove those
> mappings on the QEMU side now.

Ahh ok - I've always been waiting for the libvirt-ci MRs to go through.

>
>  Thomas

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

