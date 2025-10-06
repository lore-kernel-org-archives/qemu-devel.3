Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09CA2CAC5B8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 10:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5iEK-0002Sh-3r; Mon, 06 Oct 2025 06:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v5iEG-0002OO-7T
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 06:14:04 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v5iEC-0006Sf-LA
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 06:14:02 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3f0ae439bc3so2317146f8f.1
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 03:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759745638; x=1760350438; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r0bNarigZEgbemk+5mzAoK/LWW+rtg0TJaG5TSrT740=;
 b=mfDkuv79qR0E10VYXLa0Ggt3MC0QeMsAuIP0BlHvDEz7DyR6xGUqcMZAcBGbyfhZtZ
 t6H6KsVPHYwMbmGmWFCCsoLcFbgUCPI3eJQ3tylmb/bbyPAsotIZEY+4453XCWOu5jNT
 qXMPVLgnNQEiBn2rRGhxPa9dWs06gYTXeXOMouusPDlusU4rhOBwVGjpCsA/kWfibvbd
 3Me+vyffMuGeTBYR92yWQTYqB0JVIi7y4VD/XHfBNhzdoequW6QddPuZfUPLsl3ukvZD
 bPUpXrkBZ1H0ZWzSbIHySB0vidE/U9Mh7TGx+jL4i+EsRhu4/+31KsVw+msJLc+Tm9i9
 va/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759745638; x=1760350438;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r0bNarigZEgbemk+5mzAoK/LWW+rtg0TJaG5TSrT740=;
 b=omcHb18JibXNHtF0AxV+TFNt4myGuRI/CE6FV8e8Y+fMv4Znxiko2x27t+mW1g+S0R
 Wc5XvCr71d1jjDSwhM2wf5oUGH+gAoW9HIeuK71BOJT4DhD711Oe3cY3id0mLj5X20m8
 eTUY5rF4iswGwmz1PpkhJSZbXkpaREnzBsnvNqmWK3vrTrvE0Ea27MkptUYfaJqsjQ7d
 5jcvolpsK5hA66DMpiTNWoTZFZImeUPEQZCEHVftNXj3LzyYTa/F3NOqUve79h33dLoy
 ZUc71rbHY0W9rPN4j+GSxeX4zzEma4QlWCHsDtAS9hm5Mtpr7NyuCtAJh3QeH4HOAfUR
 VLyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdegs8iGQJdtnrELIiH3c7QIUGSRPtQf2NOwkg0i9NCQLf7RHIh8eLVjjRnoecsFW0JLnY+2EIZtFO@nongnu.org
X-Gm-Message-State: AOJu0YzIvxHuMNvvNkh2GRUqfrlmW8iAw4b6id45nl6NCQFZqsQBQyV5
 UClQEd7C+Vwp/1Wxpb+uLHJpYprUgTGpht6NyZCjtiBZ1z/B1XDuAaAfPsYoWXG4n/k=
X-Gm-Gg: ASbGncvrIguq6+HWu/sIlo4K34rh1a0IiqudI3jhmzZWo24ti6Zrj0cuSfIhNeJ3FLN
 LFWlw67G7lJgpbOluIke9BkojL5abvt+JIwN/LDvccYsc59w3bTfefQs6oPEB1MqwccHHaN+fSb
 VcgnzfycmuZ+FrgBw5AIEiMj6Cbu0rKoBh9ODo2WW8dzfNxWf1xcKymHHEcHPYu2/wNidE3ljRn
 BtogHvJTghFlUGd2Num7wqdNiO2bXTMAazzoJp/ieCrLZcMh6pQNFW1seUwEmQn2zmKXWXNd90q
 ov6cT46zSTVay7LPzDmhJv+RUb06WR5NUPoevvXTpCJcHL4htAA07J818rnm2ayeUXwy00C36xi
 RuV1a/z/gs1I+qFWu6UIp+++OgVuOT6Bn1YU5hN4UgK1Iy0OFu9o=
X-Google-Smtp-Source: AGHT+IFf+BQ5LDbwkxM+4Mp+c2QOx01KywDGnJyvUWc5ZlxwitnMKRIKFaHdOlfjAIdhLsvSn7md1w==
X-Received: by 2002:a05:6000:250c:b0:3e7:492f:72b4 with SMTP id
 ffacd0b85a97d-425671b0b13mr7435773f8f.42.1759745637915; 
 Mon, 06 Oct 2025 03:13:57 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8a6c3esm20377132f8f.1.2025.10.06.03.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Oct 2025 03:13:57 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8BF905F845;
 Mon, 06 Oct 2025 11:13:56 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Gustavo Romero <gustavo.romero@linaro.org>,  qemu-devel@nongnu.org,
 berrange@redhat.com,  qemu-arm@nongnu.org
Subject: Re: [PATCH v6 0/9] tests/functional: Adapt reverse_debugging to run
 w/o Avocado
In-Reply-To: <8cdf9d77-8801-4c25-93a2-06c81b9d1f3d@redhat.com> (Thomas Huth's
 message of "Mon, 6 Oct 2025 09:43:15 +0200")
References: <20251003141820.85278-1-gustavo.romero@linaro.org>
 <8cdf9d77-8801-4c25-93a2-06c81b9d1f3d@redhat.com>
User-Agent: mu4e 1.12.14-dev1; emacs 30.1
Date: Mon, 06 Oct 2025 11:13:56 +0100
Message-ID: <87a5241gnv.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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

Thomas Huth <thuth@redhat.com> writes:

> On 03/10/2025 16.18, Gustavo Romero wrote:
>> The goal of this series is to remove Avocado as a dependency for running
>> the reverse_debugging functional test.
>> After several rounds of discussions about v1 and v2, and experiments
>> done by Daniel and Thomas (thanks for all the experiments and comments
>> so far), I've taken a new approach and moved away from using a runner
>> for GDB. The changes, I believe, are much simpler now.
>> This new series uses GDB's machine interface (MI) via the pygdbmi
>> module
>> (thanks Manos and Peter for the inputs). pygdbmi provides a controller
>> to start GDB and communicate with it through MI, so there is no longer a
>> risk of version clashes between libpython in GDB and Python modules in
>> the pyvenv, as it could, in theory, happen when GDB executes the test
>> script via -x option.
>> Also, as Daniel pointed out, the overall test output is pretty bad
>> and
>> currently does not allow one to easily follow the sequence of GDB
>> commands used in the test. I took this opportunity to improve the output
>> and it now prints the sequence in a format that can be copied and pasted
>> directly into GDB.
>> The TAP protocol is respected, and Meson correctly displays GDB's
>> test
>> output in testlog-thorough.txt.
>> Because the pygdbmi "shim" is so thin, I had to write a trivial GDB
>> class around it to easily capture and print the payloads returned by its
>> write() method. The GDB class allows clean, single-line commands to be
>> used in the tests through method chaining, making them easier to follow,
>> for example:
>> pc =3D gdb.cli("print $pc").get_add()
>> The test is kept =E2=80=9Cskipped=E2=80=9D for aarch64, ppc64, and x86_6=
4, so it is
>> necessary to set QEMU_TEST_FLAKY_TESTS=3D1 in the test environment to
>> effectively run the test on these archs.
>> On aarch64, the test is flaky, but there is a fix that I=E2=80=99ve test=
ed
>> while
>> writing this series [0] that resolves it. On ppc64 and x86_64, the test
>> always fails: on ppc64, GDB gets a bogus PC, and on x86_64, the last
>> part of the test (reverse-continue) does not hit the last executed PC
>> (as it should happen) but instead jumps to the beginning of the code
>> (first PC in forward order).
>> Thus, to effectively run the reverse_debugging test on aarch64:
>> $ export QEMU_TEST_FLAKY_TESTS=3D1
>> $ make check-functional
>> or:
>> $ make check-functional-aarch64
>> or even, to run only the reverse_debug test after 'make
>> check-functional':
>> $ ./pyvenv/bin/meson test --verbose --no-rebuild -t 1 --setup thorough -=
-suite func-thorough func-aarch64-reverse_debug
>> Cheers,
>> Gustavo
>> v1:
>> https://patchew.org/QEMU/20250819143916.4138035-1-gustavo.romero@linaro.=
org/
>> v2:
>> https://patchew.org/QEMU/20250904154640.52687-1-gustavo.romero@linaro.or=
g/
>> v3:
>> https://patchew.org/QEMU/20250922054351.14289-1-gustavo.romero@linaro.or=
g/
>> v4:
>> https://patchew.org/QEMU/20250926051542.104432-1-gustavo.romero@linaro.o=
rg/
>> v5:
>> https://patchew.org/QEMU/20251002020432.54443-1-gustavo.romero@linaro.or=
g/
>> v6:
>> - Fixed skipping test when no GDB is installed in the test environment
>
> With this v6, the test now gets skipped in my incremental build
> directory, and it works when I compile QEMU in a new folder. I guess
> that's good enough, so from my side, it's fine to include this now:
>
> Tested-by: Thomas Huth <thuth@redhat.com>
>
> Alex, will you queue the patches?

Yep - I'm just doing the final checks with my personal gitlab runners
before posting.

>
>  Thomas

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

