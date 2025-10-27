Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54AACCF9EB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 08:04:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDID6-0002RZ-TR; Mon, 27 Oct 2025 04:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+c033f0.33e920-qemu-devel=nongnu.org@mail.yodel.dev>)
 id 1vDID4-0002Qn-5P
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 04:04:10 -0400
Received: from pc232-62.mailgun.net ([143.55.232.62])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+c033f0.33e920-qemu-devel=nongnu.org@mail.yodel.dev>)
 id 1vDID1-000425-Ak
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 04:04:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mail.yodel.dev;
 q=dns/txt; s=pdk1; t=1761552238; x=1761559438; 
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: From: Cc:
 References: To: To: Subject: Subject: MIME-Version: Date: Message-ID: Sender:
 Sender; bh=0WLE3DxUFVOeATVUeC4TxVYWPX4W/CmXXssaldPT9R8=;
 b=zoB9Mq+oPqDkGPOUQr8v2HNoIABPWQiRImYmVgTlvkkxba4+IgLj56ZDl80M5S6HHMcuvebCGdLtf20ZUlU52voDkDhFP19UPBobeLd3CUYYaX56CtH5y2OM98aasUaighbfQgJEDjqhDNCf421nZ+kuofnaaerT5xR8Y8A7beFvqp7uQ9aDPkneRZc+UAEtyFl3levaYL5Dh5DAkTQMUn6UrM6Dxx/bret5A1jQFg6KlMzFREwUl3RL+RFDNZOD+1CD1BkeDKk1UeuBe/MqEPfI255FIKvcRyYcEzMZ384Pbjy3l7AZV10VGzYqdMYO4rOEORWCkJqjfSQsD5/4cA==
X-Mailgun-Sid: WyJjZmM4NiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjMzZTkyMCJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 1c0e72b8493fb1117b349569fc7cd9a130bd4662bd6d6614c81fa7c8b69bbed9 with SMTP id
 68ff276ef9412124744d7feb; Mon, 27 Oct 2025 08:03:58 GMT
X-Mailgun-Sending-Ip: 143.55.232.62
Message-ID: <5972776a-69e7-4e80-b3f6-adbab62b3e4f@yodel.dev>
Date: Mon, 27 Oct 2025 03:03:56 -0500
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/3] gdbstub: Export helper to use GDB errno values
To: qemu-devel@nongnu.org
References: <20251017211149.163762-1-yodel.eldar@yodel.dev>
Content-Language: en-US
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 laurent@vivier.eu
Autocrypt: addr=yodel.eldar@yodel.dev; keydata=
 xjMEZxqXdhYJKwYBBAHaRw8BAQdAkletQdG3CLyANZyuf2t7Z9PK4b6HiT+DdSPUB2mHzmPN
 I1lvZGVsIEVsZGFyIDx5b2RlbC5lbGRhckB5b2RlbC5kZXY+wpkEExYKAEECGwMFCQOcG00F
 CwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQTTzRjNQG27imap+N+V7k+3NmVNrAUCaNWASwIZ
 AQAKCRCV7k+3NmVNrNnSAPoDjQXa6v7ZzdQSaLdRfAQy/5SsUucv+zp3WAP4pXdgJQEAzMMC
 Ctx4l6b13Fs2hZdRXEnF/4BZ9t1K68nwzZOV3QnOOARnGpd2EgorBgEEAZdVAQUBAQdAKPIy
 3W/DKFsm1e+31zoqmOY0pqz8vjIM846wM6lEY2QDAQgHwn4EGBYIACYCGwwWIQTTzRjNQG27
 imap+N+V7k+3NmVNrAUCaNWG7QUJA5wi9wAKCRCV7k+3NmVNrPusAQCQDQwETy7VT6UhHPho
 TkrQnsNqQfFU3tXqCTiViToktQD7B/U2/to97hQIJCWbK6yd3T+KPZJPMcHMg2XRyedUvgA=
In-Reply-To: <20251017211149.163762-1-yodel.eldar@yodel.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=143.55.232.62;
 envelope-from=bounce+c033f0.33e920-qemu-devel=nongnu.org@mail.yodel.dev;
 helo=pc232-62.mailgun.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Yodel Eldar <yodel.eldar@yodel.dev>
From:  Yodel Eldar via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 17/10/2025 16:11, Yodel Eldar via wrote:
> Currently, F reply packets in gdbstub/user-target.c emit the host's
> errno values [1], but to facilitate host<->target independence the GDB
> File-I/O protocol defines its own set of supported errno values that
> should be used in replies instead.
> 
> This series sees to that by:
> Patch 2: Exporting a mapping helper function statically defined in
> m68k-dependent code by declaring it in include/gdbstub/syscalls.h
> with the GDB File-I/O errno values, and moving the definition to
> gdbstub/syscalls.c.
> Patch 3: Passing the host errnos to the newly global mapping function
> before emitting the result in F reply packets. Please note that this
> patch resolves the final task remaining in GitLab issue #2751.
> 
> Patch 1 adds two GDB File-I/O errno values that were previously
> undocumented despite having support.
> 
> To Alex Bennée: Thanks for reviewing v1! I deliberately left out the
> Reviewed-by git trailer, because the patch underwent nontrivial
> changes, and I did not think I could include it in good faith. Your
> comment about the existing File-I/O errno values led me to the helper
> function in the target-dependent code.
> 
> Thanks!
> 
> Changes in v2:
> - Split into multiple commits
> - Use existing mapping function (host_to_gdb_errno) via exportation
> 
> Link to v1: https://lore.kernel.org/qemu-devel/20251015162520.15736-1-yodel.eldar@yodel.dev/
> 
> [1] https://gitlab.com/qemu-project/qemu/-/issues/2751
> 
> Yodel Eldar (3):
>    include/gdbstub/syscalls: Add GDB_{EIO,ENOSYS} errno values
>    gdbstub: Export host_to_gdb_errno File-I/O helper function
>    gdbstub/user-target: Convert host errno to GDB File-I/O errno
> 
>   gdbstub/syscalls.c         | 36 ++++++++++++++++++++++++++++++++++++
>   gdbstub/user-target.c      | 13 +++++++++----
>   include/gdbstub/syscalls.h | 11 +++++++++++
>   target/m68k/m68k-semi.c    | 29 -----------------------------
>   4 files changed, 56 insertions(+), 33 deletions(-)
> 

Ping, please?

Thanks,
Yodel

