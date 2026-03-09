Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58BCCEFCD72
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 09:42:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzX86-0003BL-Js; Mon, 09 Mar 2026 05:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzX85-0003B0-GK
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 05:42:25 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzX83-0007sF-U8
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 05:42:25 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-64ca09f2170so11665362d50.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 02:42:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773049342; cv=none;
 d=google.com; s=arc-20240605;
 b=hkS+cokHZ8Gb+ImfwVfPPh1G8st+Q8OSK41odQXpjbrqnNB++QrwIhGGzSi6f9uHNz
 g9oVxXhBBf4OqrCZQIYErHyC21SNryex6MkAieVjdJN8FuWWCipB3dnKfzXtlPpmVz9l
 Ugwsk489zxo9ygy4VJXwStCjKJb6JA5m4drQRM8wO22rYQi7EAe1L3LKLhWDfU3F3Ffa
 Jm1EPhDMY8jv5oJAgR45rLDdADFORhJOnnX1bvu6LQLRAPBOLBnmxb4lTwxGoJqMBe+2
 R3CVb8SIiejT/vfVN0KtxPa7wP91X1s4zADWHhSMKUJ2JgPfb4qbs+COhcg4SYiWsk9R
 qFTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=NWwP3Ue+alTqVv8klH3Uf3jiakxGCz93PJzD5pzzH9M=;
 fh=LjZC2//iffA7IpGIEUwHfyiPvMMVpvRVKyaQrPHJg+Y=;
 b=NWpkfMinAsjfLFtPeUaYbjnJLlJrH3PwfD2R1D/JLLy1EFsGmNTcRXdKJlwlR0dagP
 epL7ewmjH73/gdAXRRHQEI9G0G2aiHQcLxztAWaSeuL//a9xAJOMB3Zq1A490JXekspP
 lFumZS5/jT9UHEzvW4GGT0ZjZOZ2UbcgVad7IT1znWbLGA4qUOPrqXOvT6+IwHzshK+1
 fotN9+xT6FFr/JN67ED8+8zl6RID3tWY9IKIgI7FXckxZ3PJuQ6/yY5RPP7WzlUvVG3C
 45+c0E2ZkfwbBEyV3xGqWUkrd88wVTGk88sGJkbNK4dAC3NKPA2X1Fe4P//7n5qdRlBR
 ec3g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773049342; x=1773654142; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NWwP3Ue+alTqVv8klH3Uf3jiakxGCz93PJzD5pzzH9M=;
 b=RAVriTjAuP5ZGP5SnfArCfbIsFJpVSQcfOnvRfZm5njfrZX0ayfLMQx5KaEUOm1JuM
 jKczwwnL93dF9M3k7pBcnfbpAwU8r8wEQtgBbszFc4bgBOBnOIDNXMA36Hdl6pJ25Xwa
 5YFtX1bNwcAij3D1+6V0CqEdJBLEkpPsFmHPTi++lrAZlEuE+fe5MyZBVw95AEmnscAX
 1EwHPply6E2lDnLYUMiMAy1xuMhl1yWjC8k85w5IbgExrjd6IT3KQoUnnaY8aHgJMcBt
 2zBm82xDvrk/CM7+RrXpel6fDKxZf6bvnI2/8egCO5VFynShMA6yU/MF/sUDfkYQVa4u
 zbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773049342; x=1773654142;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NWwP3Ue+alTqVv8klH3Uf3jiakxGCz93PJzD5pzzH9M=;
 b=EUBWOJSSH2Tr/oGYRp7fjRZsM0bEc4pmiUa95jxtE2bfVTMJtJSjFBH6ppXxKPoKpw
 iXtF+iw9yXeGwOaDuiYW26i+z8fIFjOIxAA3VCj4Qy4BBR7l+Tha9rgqosm1/JEKuJ50
 lcma647WT6aOoH70c4s9wZ34Gn1ftQ7yM9h+2wdL5szSmAtpvgBqkFt4KyJBUhqnLYkx
 kwyx30NlevBNXhESgkVVfhEnBcvy2qrv/dpfgsXHZAq7VGYScdeuY+tL/Snqv3gfoU/F
 aiDfZq8VNkvConZwVTpFHBlEe+OKqDoGvqtsV4MFrzGMoAkFSKNI1BDTN6IGIlYyXSXd
 cu9g==
X-Gm-Message-State: AOJu0YzpVKP5KXX/Kpi3HLlt90thJ5OZm75Ku6OsovZaiquXEdUYOMWE
 mNI76rspVmaitxVy4/Rxx0apmbV8NcPrplU3f7SPBd7EXWlBIyTxlY6gaBZ3OkN1m9qyzmDuEcT
 IeDGpIsEV2QM14UiofjaGCQMDPBDda47yoy4fnceTGw==
X-Gm-Gg: ATEYQzxBNjA/hO1gxQSCuUzuBWn1D6hOp5RF4HoSQgqSdHd2gkCmpu7VZi+WFISinx1
 Z+uDZtMEQ1mvlD1LOf7/9rtzq1kvya2k9BRYrM6RrmwDyGb4AGr10gn2rYR3cqgIhBxjJdZQQM2
 luGGFDNlicthcKUNwSudVMewwSD2alWmdyR9bI3x6PeE561NinNqmaXfG8OGazQM5IiFD/G8LHG
 RuDszwX+EHOxM0LqQGVMZt97R9D1Zwx5quT+tSE/KnOkxlUuM8HdVZgRCom/v9AZUO83R/n/PzN
 lCXKyJ7kouyYFlaNZNAty6WHtnOohI4DiU/CnosC1e7/fviF206JvPIxE3EwqpD1gFM=
X-Received: by 2002:a53:b10a:0:b0:64c:a048:9cf2 with SMTP id
 956f58d0204a3-64d1414f4f3mr9040877d50.27.1773049342497; Mon, 09 Mar 2026
 02:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA_3ed-jb+P8SVh6Pj8uGM+aYcCHTZgvzzHEUFW5zSn3rQ@mail.gmail.com>
 <321e8b29-7879-4778-8734-0c2a6a2dadf3@linaro.org>
In-Reply-To: <321e8b29-7879-4778-8734-0c2a6a2dadf3@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Mar 2026 09:42:10 +0000
X-Gm-Features: AaiRm50_aGh6f7QZRDcJ-dp5x3b2MYB4dyCZ28ESbGL-x3E-VWKbkXceyGudnFU
Message-ID: <CAFEAcA-zd=k0xioNOKgpe6hAsY76ux04=VkHeQWkngkBnTXTVw@mail.gmail.com>
Subject: Re: leaks in migration-test
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Sun, 8 Mar 2026 at 23:42, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> On 3/8/26 12:22 PM, Peter Maydell wrote:
> > I'm continuing to work through leaks reported during "make check".
> > Some of them come from the migration-test. (For these to actually
> > appear in the log you need to run with QTEST_LOG=1, otherwise the
> > migration test framework will send stderr to /dev/null and the
> > tests will fail without printing the leak report.)
> >
> > I did find this comment in qmp_migrate_incoming():
> >
> >       * NOTE: QEMU _might_ leak this refcount in some failure paths, but
> >       * that's OK.  This is the minimum change we need to at least making
> >       * sure success case is clean on the refcount.  We can try harder to
> >       * make it accurate for any kind of failures, but it might be an
> >       * overkill and doesn't bring us much benefit.
> >
> > The issue with this is that it means we need to suppress leak
> > reports in the whole migration-test binary, which means the
> > migration code will get no leak-detection coverage at all.
> > (Not all the leak paths have qmp_migrate_incoming() in their backtrace,
> > as you can see below.)
> >
> > We're getting pretty close to being able to get a complete "make check"
> > run with the leak sanitizer enabled, so it would be nice to not have
> > to suppress leak reports for this test at some point.
> >
>
> That's a nice thing in itself.
>
> Is the end goal is to enable that in CI? If not, I doubt there is a
> strong value in reaching that state today. You'll run out of steam and
> motivation to fix that yourself in the end.
> Same goes for all other sanitizer errors.

Yes, I'd like to be able to get this into CI at some point.
I periodically have a look through some of these things and
whittle down the number of failures.

-- PMM

