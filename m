Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0C6C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 14:58:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3xGz-0001bl-C1; Tue, 08 Sep 2026 10:58:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3xGx-0001bS-VA
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 10:58:07 -0400
Received: from mail-yx2-x10.google.com ([2607:f8b0:4864:41::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3xGw-00067W-Ej
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 10:58:07 -0400
Received: by mail-yx2-x10.google.com with SMTP id
 956f58d0204a3-66e56a1b327so34872d50.0
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 07:58:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788879485; cv=none;
 d=google.com; s=arc-20260327;
 b=GNauN2nfmQ1Z3HIgYOsCAo4OpvWuDZujiQVPhJHpwuDAtry4nZ2Dl+br7JnzvK1EC0
 ZBRRbDgt0c/1z/RHyCjOJmYZ6H8ufyhUrkSSgBDJwQwnHRBh61AkH6SvbPwegSFsFOQk
 6u6hHzNJrsA7gGsQc03q9agsM1on0GQUj9GGlACPLEvumbZd4ATy1CUCC7DfpbEqZPLI
 tPC0T9RPBzZoNBE6VgjTO+5z0G95VeyX3HZNvSW54pChKImTjFZprMf7uXzbRl9dM7Vp
 w8Qwe3VRZkE97Y6Teg0e4lSP00WI4PMPbIvfIe/VAZSeBv1Aie9/mBoIOaSurNGedAoQ
 q4Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ap+GdGer3/HCGhNx4Mq8lM16w3xHRPE9D7RY1HlcJU0=;
 fh=ieLaz7e/0RpAqfE5XLQ1RcBHWjTUv1z6arE2SouQh04=;
 b=H1XqCPO+lh81Bm092uwlF97WpSjjMlWKw5LYGxGVvCP+B7XWVbCi+wQdjnWh5B13UN
 RshCDctaOgQo4S152v61pncOzcQAIgFI2w4anOekeh3esCV4ak8hQGeYFhPGyCwUHVVP
 CfL0/rmLgwdx/yfW2Fon2YRbhViVKr7j5ymIgjyA0vbRz+I5R8kxQOWPNb3TVZwiKv61
 vyDmwMYVnkR5gGoJh0GjDPrIsqGkiHM27doMAfY5dyh+CvBM22+dBFTSIe/QXobip+Zj
 kuNlfog5sjTdr5BMeQVTTI8ozdXJCEnyPwMtFa278jxTlQAt2dIiY6pZrxX3OkDYvFK0
 6MIQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788879485; x=1789484285; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ap+GdGer3/HCGhNx4Mq8lM16w3xHRPE9D7RY1HlcJU0=;
 b=m88WQIcDoRcqBsHimM5ZVFI9ZGPf0xUZPw4xmliOa9mPgeoi7AHrPQ7lAbGcQK9OGl
 1E7xoRuWA5EATeUWrMsNdr8WbwD+hWntcqxB6gzzOMizPpGQRZNFYSyiPguZ92f1iw1d
 Xk+wlQLuzjP0Y3Sd6vv4Z3uZQTj//HLH0N8jwIixwtJDWpNAmCnD7U0IfTzYGewk0oaj
 LJ0PqrO1zcVZEZ5h5d1K4W7UGdOoIwbIhRZCaq8Qys1zZ0seFHgl6uGayH2vQ8j+hXqS
 WOnzluSZFAlGa1UhS0gTF8xhBy7CD5AnmDTw2Po991wtGQoaEWRdKFdskrgSMkfAAXUe
 NuiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788879485; x=1789484285;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ap+GdGer3/HCGhNx4Mq8lM16w3xHRPE9D7RY1HlcJU0=;
 b=qKtZxlm/4f7HSHX1vMnT84vBUvIPli3DuZEajNnj399MEs5p2qWINYWw6qY7XZtp43
 lgGUHzX0WgHTXJThK/wSZxypuN+P5yEpo5ON8jbzkJiiVz1aR1VLmAscsBMam/L30dXy
 jAmgsPHoiGmxcfjhk4aAEjtFPPk0S+IOV1kH4YtQLweUBmimv/27NYp0Y+vFA8wBPJCi
 U6hw+rx0ugkmg/gQf3yvvaTIN+MOkXZru6So/Nvbyb0OpeW5u9nmRXV+UCVm/Esf7X+C
 5j+S3oH1S6gLBgn9oTo8SxCRUqOsa+heOnxxsiHFmZtp0kCa+fypRvLxsCaUP4a4yKpS
 Haxw==
X-Gm-Message-State: AFuF++mtXB8WepFvJNzqDgUZPVI7hjh2ykop4cqP9MQkvq7KS4/v+FFM
 z2BDx6XrTmFD/v+d3x4BEUcQu+xV+bHsgrGP8bzEivrpmmDfMSk11kVtDnU65ZTcLePHfaRWPPp
 OV/969DnKAC842y2LmvnwSdofQRg7EO1P3PzOexIpCA==
X-Gm-Gg: AYBFou1KU7VvTsmCkNr2KOGQwgPuqolcvdUGiVTcmBc5oOxcuR4ZpEvlXhBchYeZ2F8
 pSnEznIgJCgq0rs4XHl35E3GCklIeI6OSOi2xD79oJjMmi5Sd5a8L8CAJyGBs1UmVUXiYM3eQxr
 pKwhqloN8gP9po281Hv6GU73nwVeDXMLGxZ+c9zNZyrFhS0LPvaf+dHMsgk8ZeBfU14XUhJofu5
 1TOilFk4wF+oHAKoCjcn01+fctuxdD1MVwGLTDMPYjqbYeKB8oTZ8Yir9Jp2g85Tho+spMzCh1D
 RTzzeGz2xFboGZCHxnBgdW530EjsMhSOGf1NgA94m4r4cl++UaNm2Ray9XmH+kSn/VRff8gY+Xf
 56eWiQDQstau1l+29jXiq5bf0KDT6
X-Received: by 2002:a05:690c:e199:20b0:81d:6af3:b9b5 with SMTP id
 00721157ae682-87f23a0df93mr1322467b3.9.1788879484809; Tue, 08 Sep 2026
 07:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260902122646.2848464-1-imammedo@redhat.com>
 <20260902122646.2848464-7-imammedo@redhat.com>
In-Reply-To: <20260902122646.2848464-7-imammedo@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Sep 2026 15:57:52 +0100
X-Gm-Features: AcwNN1VL-rjyCfI_tovs__pYH9Saj5c4cXUW5-Y5bnirO5LIVom9_GeWjCw9upg
Message-ID: <CAFEAcA_zLdxcDismxgP5YjK4UT=EBYES1995wppFVRw41CxJyQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] sbsa-gwdt: reschedule timer on direct WCV load
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, leif.lindholm@oss.qualcomm.com, eauger@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:41::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x10.google.com
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

On Wed, 2 Sept 2026 at 13:27, Igor Mammedov <imammedo@redhat.com> wrote:
>
> According to spec[1]:
>
>  "The compare value can either be loaded directly or indirectly on an
>   explicit refresh or timeout refresh"
>
> QEMU accepts writes to WCV but doesn't reschedule the timer,
> which it should per the spec pseudo code:
>
>  "TimeoutRefresh =3D ( SystemCounter [63:0] > CompareValue [63:0])"
>
> Fix it by updating the timer on WCV write.
>
> partialy[2] fixes Windows in GTDT mode, which never issues a WRR refresh.
> Instead, it programs WOR to ~4 sec, enables WCS, and immediately
> writes a large absolute value into WCV to push the timeout far
> into the future. Without this, QEMU ignores the WCV write,
> the short WOR expires, and the guest reboots unexpectedly.
>
> 1) Arm=C2=AE Server Base System Architecture 6.0
>    Platform Design Document
>    DEN0029D 6.0
>    "A.2 Watchdog Operation"
> 2) under KVM system counter (CNTPCT) as read by guest apprears to
>    produce host's value, so watchdog timeout effectively gets
>    extended on host uptime offset. But that's a separate issue
>    to be fixed.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

