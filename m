Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D40C624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 13:25:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x27R2-0004oz-4b; Thu, 03 Sep 2026 09:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x27R0-0004oj-CD
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 09:24:54 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x27Qy-0002hq-Hi
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 09:24:54 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-861145fc841so25994677b3.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 06:24:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788441891; cv=none;
 d=google.com; s=arc-20260327;
 b=Er7U7poisKgC6Mr/XNJGE4Dg+JBrKOMFQiblIYdAMsbJqBn63VoXHKsKiQr9CegswW
 y+Oy1SIU+Olqw/O7bj59BSL4JWNjpTPmqjZ/pvCKmnP38vGOaGi/O2goQAbjViNYH+W6
 kEbFyZ2SHov9aMZkZdMo44O+PVXdkAo50MRBbws0H3yNeByJyvPxSIHbisHxddb6lDDT
 kY7i/Uht4KFSeGuQs92zAg4QqQj11np0AyNSDU0gOAuUiCZpJvOUAFQDtJm+ajXXHR1g
 NFvT8YkPdqwKWcQV4nbdGd+2yCYAOy9s18mO15nJLfqBEKSA4Ju7cYpCJVSac6X5/bbk
 gPqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=k/Ack6CiXU2J+w7YXb8UufGEotwzriWa8Gx1KAnT+n4=;
 fh=712ARKZE3PI9PpDlNLfPEtK9VJTHzkN1rcxrbG0UEeU=;
 b=dyEfNu/K0WFUwlZSN718542T3p/9gokKOybrO9x2oquIAX7d9nNSTq72q8fiP4jIL/
 F1tMcLMpVKcWNyWrLuDsg1dJsa/+K0kDUpxvOOKtrP9YjRDzjYPpybSusYCywhFVvtFW
 rrNoMW6waX5CuxcS0Ti0awdw4IG3a6/+N8ben3/N640TH2uEhNiyR6XJS7eKVCLvzvFR
 5Ov5BPTF2phe3YG0YVvjtyz/Zlk8x8VRs3LUdcwDSuWlCe4s4QBY3mIXtmezGfngattr
 0flPegqtzYTAtFA3Bg8z7/FwXAVxEx9pSX+F5l9xw5EcQAL1+rDR4sfo915yYYBGSucT
 6q6w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788441891; x=1789046691; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=k/Ack6CiXU2J+w7YXb8UufGEotwzriWa8Gx1KAnT+n4=;
 b=leGgi3LHdw+zi5n6rvWTn+lqtAb6/vzUJ5R5rY0pkE6L1PachLt7TEHPRYzBxYBNl9
 SIR3xkGokoyaKhWR8GvkNohGn462w4H9BkKdu8dl/1a3R1FbMb3ZyCaoyHH8QW4aOLX9
 kumLfbU3Lkl11/SR0p07ZtFiK0qCfW4tqvzVaq1z5zB1Uxf+/Vy0M4Aqk9btDlsqKSzn
 EiBF0O/SVq8845PWqH/4Mouh0gCsoPDJG4Tz+GrMILtQmDI+KWbBD7MqIoAD40x7TTOJ
 WV2u8VImmIdyMT2IHgo7kS8pQNV65Ytl3hmd9Q36hLmE8CucZCCi2R2omm+QyiQBQBFo
 o7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788441891; x=1789046691;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=k/Ack6CiXU2J+w7YXb8UufGEotwzriWa8Gx1KAnT+n4=;
 b=jUJUX1G2Xwqo2zk/C2EI1f3eW142BuQlieCpKRH1voPkj+kzOdNnnTUIl1eAdDZaUT
 GhmQPsfMOxoHkHi4sPRnU+fbMDltWarIsPSjhmZlk7uSlPh/h60bAyUOFGuLpgb+QIQ+
 EPxGBaSQDp+8elz1a8Z7tFG+Icw6YZoOaDxMJauL/x4jQn9vVzVBmGFQ7IffEpR5eG9q
 V1UvZbgE9SlaiH6osVrHvDPvAw5d/qcq+UQonqhtO96DSF0VC4WtDGwUoOAdLzQZQe9k
 UjJlWulWYvgzwXbJ5PzZhKu2V39PC3ZaEqbNQ1DkWDVzbSQNjVbUykvemprTxRcf1PQ0
 yrFA==
X-Gm-Message-State: AFuF++malO44b7wXYik6/r0q154aGUasUUs+tJ4ZDgCW0vhhveQfCfFc
 YdpSIJnBBZPLQM6XFQ2XHNSXBOF3L5+1EGx7/r0/v8MIdRNhePgL9ByXfVFKf4O5ajAKTtB4q17
 +W1R3uIEmOAtxfl0AYlG5QiVcIDLGSLV5r0cP+BwBQQ==
X-Gm-Gg: AYBFou1ZQhShDqbpZ97tmLAhoM8FGXyoHG61YE97HUbrJO+LWDPKknRIKnbiAPnBza4
 ATST4yv667dOy0DmYZqoJx03a5BmSnrpcba5cKpmYbSBWgJuY2o8pKA2HPAcjRt/9MRY3TGyJXs
 j2xyQl/cP9w+mf3FfflvDptVtENG2xsv/rxtpBuahgSyvVZkysPB2Q0VhSxSvReyIBCGN8Rm8CM
 Gt5aXpzW1dWVNUZ4xuMPV9HaSnmoKmn0asMZRaRbz7/fjRcZY362eY1tz6MCADMaWGXeAglcUiu
 Q+uLNcq3UOFC9xEcpqLNtIeIEr+t5Z9Fhx4TDm1iY3z8XffZ3n1wxSXNtMZwU7aMPAKhNstAUih
 g9FucCscSwbpVU6HXajbKMH6UrZ1p
X-Received: by 2002:a05:690c:dc5:b0:858:41d4:c28 with SMTP id
 00721157ae682-86c4e3f66bemr58241607b3.8.1788441890485; Thu, 03 Sep 2026
 06:24:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260903122516.1377717-1-alex.bennee@linaro.org>
In-Reply-To: <20260903122516.1377717-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Sep 2026 14:24:39 +0100
X-Gm-Features: AcwNN1X8BwAaKXQBQRiQVYkFUGCGzdhw9sadS5yOtZHQ65WqvfhjgrZ1U9AX428
Message-ID: <CAFEAcA_TaGW+7jvtp8OXjvGeJMce75MzZrimCWyaHrfa+ttx7w@mail.gmail.com>
Subject: Re: [RFC PATCH v3] AGENTS.md: basic bare minimal guide
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Thu, 3 Sept 2026 at 13:25, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Currently people may be inadvertently not following our documented
> process for code submissions because people often don't read the docs.
> However AI Agents do tend to try and follow instructions so lets help
> them out.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> diff --git a/.claude/CLAUDE.md b/.claude/CLAUDE.md
> new file mode 120000
> index 00000000000..be77ac83a18
> --- /dev/null
> +++ b/.claude/CLAUDE.md
> @@ -0,0 +1 @@
> +../AGENTS.md
> \ No newline at end of file

Missing newline, as git notes.

> +## Security Policy (see `docs/system/security.rst`)
> +
> +You MUST NOT report potential security vulnerabilities to the public
> +GitLab issue tracker as a normal issue. They should be reported as a
> +GitLab "confidential" work item, as described at
> +https://www.qemu.org/contribute/security-process/
> +
> +**Crucial for AI Triage**: Not every crash, assertion failure, or
> +buffer overrun is a security vulnerability. Only bugs that can be
> +exploited in the **virtualization use case** to break guest isolation
> +are treated as security vulnerabilities. In brief these are:
> +- **Hardware Accelerators**: e.g. KVM and Xen, TCG is explicitly exclude=
d.

"Xen. TCG", not a comma. Otherwise it's unclear whether you're
including or excluding KVM and Xen.

thanks
-- PMM

