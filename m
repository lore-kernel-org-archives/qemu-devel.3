Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CF5106ACCD
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 18:15:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0kZ8-0007V0-1d; Thu, 12 Mar 2026 14:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0kZ2-0007UP-3N
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 14:15:16 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0kZ0-0005MJ-DQ
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 14:15:15 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-64c9c8f8783so1622006d50.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 11:15:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773339313; cv=none;
 d=google.com; s=arc-20240605;
 b=IZmv/ry3As4fPsK0uQbAdFGI3oVZyzsBRAMFXnM9PUYP/OEVpurXG5QrCjvui/aE4J
 QV30Z0/M7TeoLSGo/37VWbiFWAZqzJFD48FpHobq7KL6mCXxZ1hkvSW/BVAWXhN/vo76
 1inGqBLRnDF7FsG/sOdbSSHdoN2Ue9kVwfu2e4BHqUWCJF6n5ULcn1UkND3SXw+3p3S4
 sdfiQGwwC9qra+5xQm9VmeIL3jUAPX/MXHd4YDTF7fYGvh5mLlpELoe1BKxyaCd2e0bi
 2485ZRjW/+436X5UB929claScr70PQCOmNx4+JsMKWZ9JyrW5CyVkWiz3MFZus3B973g
 a76w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rIAecA9ikb0DGqcEU2MA/bKVHbxoi6ICujU6nY02muk=;
 fh=e3Vyyr/1rc5Aw0xvprfx32OEOEsqrGxRuKyHlLy27L8=;
 b=UYCbHeB7id8cXbT+DCsI2/Eb25a3yWBR/vku7mpuiqgoOhAJEnxTFmbgBMZvTeB4tO
 1Y2WY1sE6sI2mnfdKPYwVi0doJcQrivQrDZx0TdsqQJJopzdm0lbtnruFr/clkMJKNop
 5CHYBwj/ImUgrBLoYOIgoXs8KDBkfrfM8tEMOkHqI+SV7WGOQjga22vj0XmfEr+8UFyh
 EEHQ0VcmsAnh/1DThUF6cNB5KFntwD5iHb6sw7VJr/KmPogBdKv4HyfnOEbgHFAol1e4
 YH/SiaDkP86w1wElZnfFyWf8z3B929oAOdU7b2liG1CyLmQrhaKv7/iGziGpwlrAGo4R
 BvlA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773339313; x=1773944113; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rIAecA9ikb0DGqcEU2MA/bKVHbxoi6ICujU6nY02muk=;
 b=fq3a7hY0w0xNJTPFYFJzNcRFDQU0GMMal0cSwYYn8Oi8Nyh+M7c/unjwiY1lHtoTrw
 E3WRJz7X3o96FT43W3QB7p3ZjmJxG2EnVmKuwngU9WiX89QJgXKb8lRzvSxhA58EGSrb
 FECknHWN7Kok3qxFkwhRODAaj9mWr3UBPi//cedZZ3GBGO6Yasf/BOq9eHPjns+2H4nX
 3GmeQHggGRK1W+x0sOhyewXVU7Aij0YKeCI4kw6YH/EDZRFXSbwQKXLEFalpg1W2i95x
 43Ew+WU/Bc6tx68Re9u90naVk3lSDvFpMx9SPbfKslYMmGGcn84KOYqlSJf7t9SzEvLA
 MJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773339313; x=1773944113;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rIAecA9ikb0DGqcEU2MA/bKVHbxoi6ICujU6nY02muk=;
 b=ryvc20ncBg+IgSj+KBjvEH9hFkKrzs9XkI+9c+bVB8d96QPVOBmimP+lg0lgQltY6t
 Wx6flM8LqwN1WBUBbS/iDlNZ0FMdU0LUMImghZ/2sn8dSz2q7P4SfUMxX8JSOBRNPhEu
 wFI+kU228K6JJhqF/dCOtWJBrmvFW4UljhSU8JlHtLgRVW6G1r6LEP+NK7vkjZO83v4F
 cIMm1WNecvbWr1AsuEyno72wSosKn+663dkciQgJq+CYOIz/vkEL/kgJsxc/nvzzfXZ/
 vMKTBjSXirApZ1+rcp3eh//ovXsbwl15YogyNgSDNg6ilWslCpCjROt08xm/bTF6Cijy
 BviA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWm6qUS4TvWCe/cpOxQvP2rj4NQxszOZ+tn6MjS5gN4bi5niuNZsWDYo1CVQYBIGzcva7ZGvG5EM5zg@nongnu.org
X-Gm-Message-State: AOJu0YyB1AjvoNTsxQD/meRKw4CiNeM1Ik5AioWOry2bg6CgPbZPFw03
 qZ/ckvTUOvuPSHw+P/aNI6EL8IQWZzsG/uWx+AElkHDvhURKDRi/BSmdB4crtIbIks9ylnS5Zcv
 u25c7sQwqcu2PZ4gglLqIxQ3WCWGO7Rlz5lpiNyygfD2UqXP9I1ea
X-Gm-Gg: ATEYQzzqeqDfz01A+qwnCBDAjn3wqRebATeczDRbHNdTqRBQPipr/ATEbb5URmGrRPc
 nH0xQkO5R5x/HDN5MEUJzfXq2WJWW84IsjJ/jG6N8hLw7dlYE36ZYCps6TZOPQvL+GhugOeRymu
 SobeSoiI49KJPiDF3mydC7n9AWj0OKcvm/pF7VUziPhGf7TQjIG/uvGsRTh4ZuDg4SdTdyNaMD7
 0CQgZdFs7zma7IW1RgMsG1jslRHlKGnIaDEDBi47LgPX7PqcQ8XUWjxmqwZG2DB6WexomeNySd+
 ORBagb01peks4wR5IQFq7KYW3F0XBcb1W22llVIWgezkJ3jPpufGEGl8p4JDJCb9tCs=
X-Received: by 2002:a05:690e:191c:b0:649:e440:26a8 with SMTP id
 956f58d0204a3-64e6236a860mr695097d50.0.1773339312679; Thu, 12 Mar 2026
 11:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260312121617.228654-1-vikingtc4@gmail.com>
 <4d7c6db3-0915-411d-ac1a-f26b5b38dc28@linaro.org>
 <CAFEAcA9m_0VCWzxFACJzHKw=WUQhmuXSEgHzfJs1a9NUzWm6SQ@mail.gmail.com>
 <3e8016a4-17cd-4d87-9210-2f67a2ab243d@linaro.org>
In-Reply-To: <3e8016a4-17cd-4d87-9210-2f67a2ab243d@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Mar 2026 18:15:01 +0000
X-Gm-Features: AaiRm53Cs3COvcCKPdprbASspfdGY5VOlD_RATp5IH1c0DtWv2V_w_WzAR0Wixg
Message-ID: <CAFEAcA_JVF49rphVFdQpBeY7O+nU3NKNqXPFgSNodx53JpfjWA@mail.gmail.com>
Subject: Re: [PATCH] plugins/api-system: Handle migrate_add_blocker() failure
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Trieu Huynh <vikingtc4@gmail.com>, qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Thu, 12 Mar 2026 at 18:12, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> On 3/12/26 11:08 AM, Peter Maydell wrote:
> > On Thu, 12 Mar 2026 at 18:02, Pierrick Bouvier
> > <pierrick.bouvier@linaro.org> wrote:
> >>
> >> On 3/12/26 5:16 AM, Trieu Huynh wrote:
> >>> migrate_add_blocker() can fail (e.g. if migration is already in
> >>> progress), in which case it returns a negative value and populates
> >>> its errp argument with the reason.
> >>>
> >>> The previous code ignored the return value, leaving state
> >>> inconsistent on failure. Fix this by:
> >>> - Passing a local Error ** so failure details can be reported.
> >>> - Checking the return value; on failure, report the error, free the
> >>>     migration_blocker Error object, and return NULL to the caller.
> >>>
> >>> Resolves: CID 1645470
> >>>
> >>> Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
> >>> ---
> >>>    plugins/api-system.c | 8 +++++++-
> >>>    1 file changed, 7 insertions(+), 1 deletion(-)
> >>>
> >>
> >> While the description makes sense, how would it happen in real world?
> >>
> >> Plugins usually will request time control on startup (so no migration is
> >> happening). In all cases, plugin who want to control time will have no
> >> other choice than abort.
> >> Maybe we could simply assert that migrate_add_blocker succeeded in this
> >> context.
> >
> > If the user starts QEMU with the --only-migratable option then
> > all attempts to install migration-blockers will fail. In this
> > case we need to report to the user that the thing they tried
> > to do (use a time-control plugin and also migrate) isn't possible,
> > i.e. exit cleanly with an error rather than falling over.
> >
>
> Reporting errors is useful when there is a possibility to recover from
> it, but in this case it seems like we can only stop when user try to
> request time control, so I'm not sure we should return anything from
> this function at all instead of crashing.

When the user does something that is misguided QEMU should (as an ideal)
never crash -- a crash indicates a bug in QEMU. User mistakes should
cause QEMU to produce (hopefully helpful) error messages.

If we want to say "there is no sensible way for the plugin to recover
from this failure, we should just print the error message and exit QEMU"
then that is what error_fatal is for.

thanks
-- PMM

