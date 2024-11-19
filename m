Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82CFED62072
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 10:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDLa1-0003yv-1H; Tue, 19 Nov 2024 05:35:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDLZy-0003yI-Vh
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 05:35:31 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDLZx-0003Ej-4U
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 05:35:30 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5cfa9979cd1so5310420a12.1
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 02:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732012527; x=1732617327; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H5SvD9grBLI3ASmPzyX6YG/cg8wlR0s7tnPel2kT7V4=;
 b=mHTx6AdfcGCzp8Tgm30/cDGU0UqV2mBGETw3unPxT8jcKgk0gKk0RaiXSY+VHG/Ah1
 KKIqcV0+kPMh6Od0D3Zw1zwgRh6YCa/wYFa14IbDZaMMcaUrjrfXS1z5q9xf9ayDonkO
 nILeEN4JWx4vjPRwBbZ8IHRLLoGXw2wQAGOsuSYoBxEtMT4zMXyK+gT5SP1Pirusrv3F
 0RXPgx6MZMD3bR11xA9eU9IB+sARLlTCMEXjjaLayoZKY3YKPvyO0Mr80CAyjoLIB4Y8
 2nVZBLzkOoDb05/NNB0alKUVB1zPf6UpTpH12xT2qfP54hnDVu32VMSARBSXDy3vAt0X
 jukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732012527; x=1732617327;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H5SvD9grBLI3ASmPzyX6YG/cg8wlR0s7tnPel2kT7V4=;
 b=hW8B2Rygg2YiM7vlwrpRXxfdi1vbyA+Fl2xsNTmJMiqfOR/6JoGlRMgxzIEN1YgXQc
 2SOJUfqFUy87ZRhmYsHwEzPGuHiaFqJz5JZpU6CiDF1hC+eyKsdtIUX3L3iB0A25G6TO
 6B0aKXA1VsTZnBiYC8sd5pia2vr5v06mBz7cxoDp4lbg68cwpOLKoBPOZuFhuOzCSqVH
 rnw83j/Hn8k4XQAA01DNCyuU68UQFWxXgQ1XaLHlIyHjwDkeaOVGtJRqtJbCVRK1yut3
 6RVCX3UlhAAuYhzd106p9brnCRjsOhmsNALnhjzAnWslBdC70MWM/DqP9KEq0EHYTfMK
 3WGA==
X-Gm-Message-State: AOJu0Yzgjyu41YH5D1W/18nQs+NS8qYZ8wXm4ClbfMgcMDk8SQIRW5tO
 6LW1CqZvU2jkIZSelYHtDpHqUhzd9pYULNcXJ+mDUMrabjrE/Q3UT6KKiUl3SJKkGcXf9xgV5U0
 8u9gLKxrHH0/duG5Nnc14WDYL8oeiMpObDXW7kLEtE/K1O/8D
X-Google-Smtp-Source: AGHT+IGlzF3z9cEpSKtMW68IdBv1lEBhbFARQFkFNHygRkITGely0vi5KXomp0I/9/T9IHXvP87udJcLaYMzNvNKDmM=
X-Received: by 2002:a05:6402:50d3:b0:5cf:bece:5037 with SMTP id
 4fb4d7f45d1cf-5cfde5cbb20mr2636317a12.4.1732012526731; Tue, 19 Nov 2024
 02:35:26 -0800 (PST)
MIME-Version: 1.0
References: <20241118173634.473532-1-thuth@redhat.com>
In-Reply-To: <20241118173634.473532-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Nov 2024 10:35:15 +0000
Message-ID: <CAFEAcA96c4sxoerS4yzgPr_Eb99qN_F=zCSB9N6eFMZNJznCLA@mail.gmail.com>
Subject: Re: [PULL 00/12] s390x and misc patches for QEMU 9.2-rc1
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Mon, 18 Nov 2024 at 17:36, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter!
>
> The following changes since commit abb1565d3d863cf210f18f70c4a42b0f39b8ccdb:
>
>   Merge tag 'pull-tcg-20241116' of https://gitlab.com/rth7680/qemu into staging (2024-11-16 18:16:46 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/thuth/qemu.git tags/pull-request-2024-11-18
>
> for you to fetch changes up to 4483d98ab82671165276026b09287053328c94d4:
>
>   .gitlab-ci.d: Raise timeout on cross-accel build jobs to 60m (2024-11-18 17:14:35 +0100)
>
> ----------------------------------------------------------------
> * Fixes & doc updates for the new "boot order" s390x bios feature
> * Provide a "loadparm" property for scsi-hd & scsi-cd devices on s390x
>   (required for the "boot order" feature)
> * Fix the floating-point multiply-and-add NaN rules on s390x
> * Raise timeout on cross-accel build jobs to 60m


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

