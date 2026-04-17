Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F4DCF436B4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 16:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDmQM-0007vd-Ih; Fri, 17 Apr 2026 12:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wDmQK-0007v2-Hr
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 12:52:08 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wDmQJ-0006xy-58
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 12:52:08 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488971db0fdso9790475e9.0
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 09:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776444725; x=1777049525; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YT9gS9On7LLenSSPLX9dnx/7rlBrHnGqh5jdqZ3EM24=;
 b=EGsaJzhOj+jVWA2QbGGtx/bpA3vtU/cZLz378UHDjdNIirYJmnXAMX/1OoiaZOlKbe
 xzSPycIlqd3xA/zmvjmmaPBXADyKZwNN/XuUOvqDwGytaUQGL8TpS5k7rG+SoCeOkcGH
 i1vm98JSWEC+XsOMgRpkDZQ1rNRtee0LyWIHC9kG1q05ac7cWuEX7XXMJTzctNBFGJlg
 d9iWou2R7OfUWMK97TBWNYA4ZSJCbqudESII3HFObYC/imnTLQkNw9oQ4WAlZGJFn7Po
 YCB+4OFP3/RCy4RjT2KiH50EG4pb8QWmPWTwXkcuh3rxclrLG/Ho2LFPHjwGsrFxpGnG
 zepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776444725; x=1777049525;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YT9gS9On7LLenSSPLX9dnx/7rlBrHnGqh5jdqZ3EM24=;
 b=aNdEGLyBSVBMWhZgodh4qfLP9iMlsZXty3mhJdz9XQ64LlEm78ifAQeu8Ju8oacD7n
 FHIruZCvoGgYzYVWXJmftQl23GJ0J1bcyhtdl85tr3Uxp6gxEhuPj5ALsJMw9m6f9GyV
 ZXZjEUIohq/smpHjzgcazhLm9Zt2HBDuyQA1Z6vtpGHIGAMRBExTSqX/YxUxl1K+ltKw
 rvEOdAmOO5uCY4mL6eFRG2eQzkDRem0k5xeGQ1hyPgUzTcMtYXlBDEM2jxW3BR8C9FB/
 JP6gEClLHB/oMBYsffiZevkbw47F7+DgfmPTRO9uHew9E4Inouhjq8nh3WPCZEAkfzpO
 MHFw==
X-Gm-Message-State: AOJu0YzKvTBcQMRc23Kk7L5sE6VkhORQuf3zqjjOsnEyD/YUeu/U81bZ
 Al+z0fGwPDlij7veC9HPKFr4aFqkPeER9gJOju6TMF55VNaoqj70sAyJbI3ZajeRTxY=
X-Gm-Gg: AeBDies06skXdvZFdfR6DZzn6ypFs0TSLKaLTnhAg4ToSdEYJLlEFwXn/mkAw+kpY5p
 8M7EtCdhO4wtE0brzFXK8auLxHYWuR2bgtbLaerHze9S/iVQkMxa/s50nAyjB4ifm+6wrsl3Pnt
 hFHt18eZ0LeZvlhAI6BNIhVgkp5/yzIMABHiWgVpZhomGqHBm6rxYHA0le38icasndVOKyXb8Nb
 GsEOp6i397jb+RflcfrOMjRih01N9GOw69ymU4i+xaTqlsPbhmulctUvwPofKA7hq6lJZTWgQOQ
 go3OJyzngV0B3MnbAmWgelw3RON8TNnSuA4dDc/WZkcdQVDE4WD/a6DJtJEoD8cRFPRoognw/po
 q6PHyii/vmR6Sa615YYMma1UBlLPQqjshcCV+kLVX862OH+rgiMy2Pq7Amraxs7AV/eUDnwPth8
 oKQ32xo9ZjhsMUXzg6DGqteM4270AnbkbKk/0cm6kjbWW+
X-Received: by 2002:a05:600c:3150:b0:488:9fb7:376d with SMTP id
 5b1f17b1804b1-488fb792ce4mr54451805e9.28.1776444725338; 
 Fri, 17 Apr 2026 09:52:05 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb735d3dsm46695775e9.2.2026.04.17.09.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 09:52:04 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E48865F94F;
 Fri, 17 Apr 2026 17:52:03 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-stable@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,  Akihiko
 Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,  Dmitry Osipenko
 <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH v2] hw/display: don't accidentally autofree existing
 virgl resources
In-Reply-To: <20260417122703.845442-1-alex.bennee@linaro.org> ("Alex
 =?utf-8?Q?Benn=C3=A9e=22's?=
 message of "Fri, 17 Apr 2026 13:27:03 +0100")
References: <20260417122703.845442-1-alex.bennee@linaro.org>
User-Agent: mu4e 1.14.1-pre2; emacs 30.1
Date: Fri, 17 Apr 2026 17:52:03 +0100
Message-ID: <87tst9pm18.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> While sanity checking a create blob operation the use of the auto
> freed res variable could lead to inadvertently freeing an existing
> blob.
>
> Avoid this by in-lining the virtio_gpu_virgl_find_resource() check as
> the value is not needed anyway.
>
> While at it add a comment to the end and use g_steal_pointer to make
> it clearer the object lifetime exceeds the function bounds if we pass
> all the checks.

Queued to virtio-gpu/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

