Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED13606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=yS5VTtYZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVncu-0003x4-Oq; Tue, 24 Nov 2026 05:19:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVncs-0003wl-N1
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 05:19:50 -0500
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVncr-0007RR-0M
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 05:19:50 -0500
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-679a2b5fe87so4111381d50.3
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 02:19:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795515587; cv=none;
 d=google.com; s=arc-20260327;
 b=S+H0BrKQvcvz3LIak+Ab6EoOwRdhmDm3xEMISZNgICcFulJKrO0g3BHv5lc1s9c433
 Eamu5dX3u406H4prNcKHOwtN4CLSDEx4b68gcbMWg8sTnSPj2vuiYH4q3drxpZEgjXx/
 CV7kAaWKXAxJ+kFptmLzn+bsw7v9SjTRJEjiLNgxeKDG5JdHUtYOmqBbDpeyP8XlxZ02
 DlZqFlzpRSF40A0kPYhbQ1Fo6O1U2h+bH/7MhNBvKs4QfmWwBkTkZtwrej0CS4rYcSRC
 PS/NFGdYx86qpUwmbJFXUjIirF+7U4B3orwBLFmj7zJNnZ3cf0OE0YQTXF9jhaaaLhwB
 twyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nOkSFZ9DCJRzUjukGwLhgBbkWXA+7KZKXcsQdbhpKb8=;
 fh=FzZ3BvsmT+R7+S/QSSfvr5c8Wgi11LrLsVHAGdCaYGc=;
 b=fn0ZwEWA13WNgWkZXglSScnP3CvMl87grbWYCOiZ0xoCa8j8Fb5HDOduEk+GULSTaq
 HddqrEhUT/kVi6IXCJw96O3Kxr25SJPqmO3KuuShA+FtMF4FcXIgwIi98fASY8Zz2QvT
 9yKsjpONbFdTJCDNndvj+dF5F6fw5UCup9UIOnPlK7vJrxYgO3uOpjN/4T0PlPCmHL9w
 1ncCgYMs5c0go99eZzcxs8UNVqaQ4zTv4QU9KlCgYKVMgcbsrdV0honaLzIUhSqtp1X/
 faKyWt+2EhNy3jaD575Gy63ICQ/9bt1MySyzZhrB6I93xOri6zqvkBRuWeU3s0IGNA1l
 jL0g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795515587; x=1796120387; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nOkSFZ9DCJRzUjukGwLhgBbkWXA+7KZKXcsQdbhpKb8=;
 b=yS5VTtYZCHAdvdUDkmcnGYoFJ+Vvc9yEp0ybujlKRvrU0AsC9bLwXyk+WAyZp6GAZT
 bbPvsNKzkn+vZFUyaHMEacco9LXl3nbiqSUHfeu7TUDTPI2c7cZZgFJTGoxYJ82wk1q6
 TvBBihPZu+1nEhcZZzSSJt0RqCVkiNjNi734hjWDeX5ceg53q/nR8DNPqhD0AWyvQGoY
 jkYPg7K+POJ+IGxMQtGtfZm1ILlbQzaRVuw9UUTNfPPk1hosaQYGI9g0hHBfQHB62JTe
 IiqbteDtMmEXiw2Yp7m0qah+NtskCX89zVryJH+bj8QwtO9b5b55PpkOOCMxcaXxElJ/
 3qvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795515587; x=1796120387;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nOkSFZ9DCJRzUjukGwLhgBbkWXA+7KZKXcsQdbhpKb8=;
 b=QLpNF+u9F8BCcqTJ45TYGMcOS147ckQ9c7sIlGEdmwpg7bt33xvc4hpMRhWHzJJy5J
 Mwt/M8yRGH8+ctRkR8HesCNUQSRAt4SXqSPKZdkMA7edZ6SB6vGsopDupeVoH8OwDMuv
 F7jI6Py1TYeFvu4vXfX3SDo+BfF0ZeyEbkJPDAlyp1rm/UDae8yoTFyjZJLxcS9CkX4i
 58CFC+LCwNfeVDqMouzJl42zsuCys0Ihk4RA1dWIGf4Tj5CtlPG3oimu9yRn/RR/zxXQ
 /hUS2z88boyyiyYXVyGlmvCmUhpaGVKM4lLFog2tCh5vRQ27DqtqZ66JRShXUPoywby6
 RM6Q==
X-Forwarded-Encrypted: i=1;
 AL+hErEsWXS019NnWTRLlWiwtvPmVaZ9XkSopCbhw6No2+YX8SNS6HadTA7oZrZa/+3/n5wAp3syV/3VsXJw@nongnu.org
X-Gm-Message-State: APuU4Z8ppU2SPXmc9fN9suirV60NJiLZrASNpD6iewjqrp1I6Y7mlP9t
 mV8iVkOo3A4PdZMdVGD5gQ+ObxMKG+fLu7yVmFMhKV1vceolaOFsdI7Idir5RXhidg/kxCU3OkS
 ZCm7R0wLElu4KmyWlmhbQEroE9phmMsZpX57ED3e8ng==
X-Gm-Gg: AZFdTZfD5afQZuq3wuMnaXhMHCigcHXSNGQmBDCFIfKzj7o/y+hKoQU0A2+3RYIZs4C
 jzIV9PmMQNniPawfwsTjt9Ljbh8bXVTlGy/pFXwVYE+fUj0T4LoGa22Ttu2SvKLWhm9S+8qFAy4
 FhYB73Ky7LNF2heFizh7vZVBLngGHbJLbJaHbOH1ssez46keGsB4nvmO4KL5NzpwjHTQRZYmYHw
 1aUsgB7EakWnb9Wt9bkQxIwrdvCj8FRy2Ccc6vZtpK1sT248aDOVkxnCN2dlb1GAhOjlHho2uZM
 nx3FHsrvaUg4LR8Yo69M4Q7N7yxysz9aRS4uKJiiVG22DfqlupPaIlVqyhvLgS19CwjYz8tQZYx
 sbDxc5q9Bf2LVh6SK3KAYBXgwcC3rX13sCPwjZCOTfzINvofCxcpgn5M11zgBWcqwhGsvvWD5Qk
 OHxP0SWmnhu+c5QlXev1jA
X-Received: by 2002:a05:690e:4145:b0:67c:33ba:4367 with SMTP id
 956f58d0204a3-67e314b00d2mr1207508d50.123.1795515587534; Tue, 24 Nov 2026
 02:19:47 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <250f899a-51c0-4007-99dc-54bd336f0693@linux.ibm.com>
 <e29c8bc1-0a25-4dfc-b429-6805c373b5cd@oss.qualcomm.com>
 <7672e73a-2945-49d9-94a8-a3d187be300d@linux.ibm.com>
 <87mrqyhb7l.fsf@pond.sub.org>
 <1fc28def-9c77-45a8-99d4-c1de8dd2d477@oss.qualcomm.com>
In-Reply-To: <1fc28def-9c77-45a8-99d4-c1de8dd2d477@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Nov 2026 10:19:35 +0000
X-Gm-Features: Aa3M54qZV3do6VLCattc0O3u0SKaIU2Z1-fpz0azQc995gIgLjIJo62EzaNP4-w
Message-ID: <CAFEAcA88U2ef+1LWP7rP7d9=t8gtv8nOkzULBbTGG3D+ixOCSw@mail.gmail.com>
Subject: Re: [PReP] Maintainer status check for PReP machine
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Markus Armbruster <armbru@pond.sub.org>,
 Utkarsh Verma <uverma@linux.ibm.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org, 
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Thomas Huth <huth@tuxfamily.org>, 
 Laurent Vivier <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>,
 Helge Deller <deller@gmx.de>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 BALATON Zoltan <balaton@eik.bme.hu>, 
 Chinmay Rath <rathc@linux.ibm.com>, Amit Machhiwal <amachhiw@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 24 Nov 2026 at 10:06, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
> I'm probably missing the point here, I'd rather look to help maintaining
> unmaintained / broken subsystems. Why care about a well working area and
> ask the maintainer to step down? Why not ask the same to ARM / RISCV /
> X86 maintainers? What is the underlying problem?

The underlying problem is that it gives a misleading view of
whether something's actually maintained if you look at
MAINTAINERS and there's an "S: Maintained" label but in fact
that person hasn't been actively involved with the project
for years and is probably not reading their qemu-devel email.
If the real situation on the ground is "effectively this is
Orphan and patches for it are unlikely to get review" then I
think it's better to have MAINTAINERS say so.

This is why at the beginning of the year I did a run through the
MAINTAINERS file to look for "stale" entries and query whether
the people listed still wished to be listed. (It was about 50:50
whether they said "yeah, it would be better to not list me" versus
"I do still want to be listed".)

I don't view this as "kicking out maintainers" but rather trying
to make our maintainer docs match reality: if anybody I contacted
in my run through the MAINTAINERS file requested to retain their
listing I did so.

We can discuss whether it's better to do this as a coordinated
process over the whole file versus single subsystems and who
is best placed to be sending out the queries and whether that
works better as private email vs cc to qemu-devel, but I think
the general principle is right: many people who drift away from
the project do not actively send us a MAINTAINERS update and
so we do have to do a little active housekeeping on it from
time to time.

thanks
-- PMM

