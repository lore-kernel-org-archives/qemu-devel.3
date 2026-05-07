Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F10ECD3427
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 11:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKxMm-0006Fc-9t; Thu, 07 May 2026 07:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wKxMQ-0006Eu-5T
 for qemu-devel@nongnu.org; Thu, 07 May 2026 07:57:49 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wKxMO-000059-1K
 for qemu-devel@nongnu.org; Thu, 07 May 2026 07:57:45 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso6642615e9.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 04:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778155059; x=1778759859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G+sYMrxHIgI0XOwonv+5WFlvfPITzxng7xWOjoLsXsw=;
 b=a/w8VeB97v7u16OT7GoRX47SisECLLVMWMhbb8xUdKXqKoYrr5d0Kd4Q9R9dq1xGpY
 fToL60TCsR+oBRZlLMwxiiLGnnnNF7tK/nnrLQbBC9tmtoPNkzJb9FgfWJwkOvd3NUD6
 cVoZvix7QErs6KgtjQr5gVQUSW1lDMMVLR7ihmJKR9gjScCVYzZhdJmTDC1k/IkcT5Y7
 N1AR2mhaHllmNpfsdi0sk/O7xfWuXP24SLhZHQ6E3bDaJ9emMYJAO80IBdqJJn+f6jsd
 smJmLAkFyUzIXSM2bskHJZtDIagtl6na2dfUDTv0VPJPSy7t44/+KOzXvlEwjpVoZt+2
 be9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778155059; x=1778759859;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G+sYMrxHIgI0XOwonv+5WFlvfPITzxng7xWOjoLsXsw=;
 b=AC6Wf3HS21+oL9TCYZZhS3ScmpckyOQ+W3d1+AiF9fp9k07MyBOVZZxrdp78dlWlbU
 JbQXiCEQZ63lu2VgPPfhLK2VNpzx4tnaen2O1eeaPmNNfYDyJCKCdzkXEADF0nzAu0XJ
 Cpyf7OwT/G+AQFqHTpCHoMVBRs1T3VIMviuHqYMolg60CJxMvfcOkM62MGCKZcklVQW1
 gy6VYumGyDdbx4D2xsKdBxZ4AwNE/AOFv6oMhnMUl0t3LRAMZvIS0P+MFUMr5113sqlg
 TxuWRixS+40HFK9dnQh0+TUWJW+xWQ5mYjn+RgMhSYIoVPY43eben2CMkJY9Y05p6Inx
 7fcQ==
X-Gm-Message-State: AOJu0YyJhC06WM905hpLURdwuYtnybCd8r3XrznRFsmEaY0mUw10T7mG
 CHOKY9orAw2hhXUBXROOWG+XYigNI4tHBHk+vgvYn4zKBa2tF1x5mDutBl6ZfgySVZ+YiWG1/H+
 hQGKoViw=
X-Gm-Gg: AeBDiesNtvR+/PQlzUk88BeVc1f3I+rBl9VSbUwKG84CHlJsvukJOibhk22mo5T/tW/
 nI+Niy/K+phOzOjEsfRYF5ADmlln8r+jcfNWgg5tqRPiPn/Okmqz1inPr1K6hRDaobxn0/ysVDJ
 bCIPzRwlBRAwHRUB4tD3VDVzcvfKa2l4pgtiQBRgKGqkPXrW/4Va2NiPAF6Jxf4CJQorXKhHOhm
 Tl8WmB89tn1PeSIVuGbEjXtojsFWG4U1iCQbv65huAi/KK7DG7CgJAOUjm1C+O+Ni0V8jaa+CaA
 Fmgj4OsGjupt23Id3u9PZeLPFTwP+BwpzlZJ9PD5AXs3DIjf4co8p9czXdPe1aPIob9HdH/qgjX
 iv3QiTBOqprOgEjyUymYRgCH1K9ymc09bLRkh2NRfE1YKgGSvh/x9UE6kMgruRsq764DKPfyTCc
 2GFdQ84RZBllk49zXBsN6vyHQ/OwfBw1220Q==
X-Received: by 2002:a05:600c:a110:b0:488:9e43:9690 with SMTP id
 5b1f17b1804b1-48e51e17746mr96330095e9.10.1778155058841; 
 Thu, 07 May 2026 04:57:38 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e52f5c1cfsm77711335e9.0.2026.05.07.04.57.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 04:57:38 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 217C15F870;
 Thu, 07 May 2026 12:57:37 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 06/10] .agents/skills: add qemu-testing skill
In-Reply-To: <afxHRn6ft1ABjWDw@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Thu, 7 May 2026 09:03:18 +0100")
References: <20260505170105.228162-1-alex.bennee@linaro.org>
 <20260505170105.228162-7-alex.bennee@linaro.org>
 <afxHRn6ft1ABjWDw@redhat.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Thu, 07 May 2026 12:57:37 +0100
Message-ID: <875x4zmnym.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, May 05, 2026 at 06:01:01PM +0100, Alex Benn=C3=A9e wrote:
>> This provides basic instructions for running tests.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  .agents/skills/qemu-testing/SKILL.md | 53 ++++++++++++++++++++++++++++
>>  1 file changed, 53 insertions(+)
>>  create mode 100644 .agents/skills/qemu-testing/SKILL.md
>>=20
>> diff --git a/.agents/skills/qemu-testing/SKILL.md b/.agents/skills/qemu-=
testing/SKILL.md
>> new file mode 100644
>> index 00000000000..3b7b42109e1
>> --- /dev/null
>> +++ b/.agents/skills/qemu-testing/SKILL.md
>> @@ -0,0 +1,53 @@
>> +---
>> +name: qemu-testing
>> +description: Provides instructions on how to find, list, and run
>> individual tests for QEMU (Unit, QTest, Functional, TCG). You MUST
>> use this skill whenever the user asks about tests, wants to list
>> available tests, or wants to run any test in a build directory, even
>> for simple exploratory queries like "what tests can I run". It
>> includes details about spawning sub-agents.
>> +license: GPL-2.0-or-later
>> +---
>> +
>> +# Instructions
>> +To run QEMU tests, you can use several different suites depending
>> on what you are testing. **Note**: Ensure you have a recent build of
>> QEMU before running tests. Use the `qemu-build` skill if you need to
>> configure or run a build.
>> +
>> +## General Test Suites
>> +- **Unit Tests**: `make check-unit`
>> +- **QTest (Device emulation)**: `make check-qtest`
>> +- **Functional Tests (Python based)**: `make check-functional`
>> +- **TCG Tests (CPU instruction tests)**: `make check-tcg`
>> +
>> +## Launching Tests
>> +**Crucial**: You MUST NEVER run a test suites directly in the main
>> agent context. You MUST ALWAYS launch them by spawning a sub-agent.
>> Pass the specific build or test commands, along with the required
>> build directory, in the `task` argument. Give the subagent explicit
>> instructions on what to verify and what to report back to you.
>> +For example: `task: "Navigate to builds/debug and check what meson test=
s touch replay and report back."` or `task: "Run make check-tcg in builds/a=
rm and summarize any failing tests."`
>> +
>> +### From the Build Directory
>> +Most individual tests from within a build directory. Most (unit, qtest,=
 block, functional) can be individually selected and run via meson.
>> +
>> +As QEMU often needs a newer meson than the build host you should use th=
e build `pyenv` to launch it:
>> +- **Example**: `./pyvenv/bin/meson test --suite thorough --list` to see=
 what tests are in the thorough test suite
>> +
>> +## Running Individual Tests
>> +
>> +### Meson Test Runner (Unit, QTest, Functional, softfloat etc)
>> +To run a single test, you can use the meson test runner from within you=
r pyvenv:
>> +`./pyvenv/bin/meson test [testname]`
>> +Example: `./pyvenv/bin/meson test qtest-x86_64/boot-serial-test`
>> +
>> +### TCG Tests
>> +To run individual TCG tests for a specific architecture:
>> +1. Navigate to the relevant build directory, e.g.: `cd tests/tcg/aarch6=
4-softmmu`
>> +2. Run a specific test with make: `make run-[testname]`
>> +   Example: `make run-memory-sve`
>> +3. Use `make help` within the architecture directory to see the full li=
st of available tests.
>> +
>> +### Functional Tests
>> +Individual functional tests can be run directly using the run script al=
though from the source directory:
>> +- **Example**: `./builds/all/run tests/functional/aarch64/test_virt_vbs=
a.py`
>> +
>> +### Environment Variables
>> +- `V=3D1` for verbose output from tests.
>> +- `SPEED=3Dslow` to run slower tests that are normally skipped.
>
> When I read this, I note there is some significant overlap with what
> we write in docs/devel/testing/.=20
>
> Would it still be effective enough to merely point the agents to
> docs/devel/testing and get rid of most text in this section ?

The intention of skills is to be as concise as possible to save on token
cost. We could certainly put a link to the main document so it can read
it for more details if needed.

>
>> +
>> +## Reporting Results
>> +**Crucial**: After completing the build and test tasks, provide a conci=
se summary of the results to the calling agent.
>> +1. **Summary**: State whether the build and tests passed or failed.
>> +2. **Failure Excerpts**: If any task fails, include relevant excerpts f=
rom the logs (e.g., compiler errors, test failures).
>> +3. **Full Paths**: Always provide the **absolute file paths** to the fu=
ll logs and result sets for further inspection.
>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

