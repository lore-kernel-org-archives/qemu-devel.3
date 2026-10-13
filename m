Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA36CCC6B0E
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 15:11:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGe9K-0002JF-II; Tue, 13 Oct 2026 11:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGe9E-0002I6-H4
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 11:10:37 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGe9D-0000Ol-10
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 11:10:36 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-87ab6e5f91eso19739777b3.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 08:10:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791904233; cv=none;
 d=google.com; s=arc-20260327;
 b=KeYNg2858WrH78ihHxqhs+p/Mb5s7cYgCUX+AMgyA8Xai8TZ7SmGNnpGyeU//VunK3
 qcF6MMIQ83REbDdU3euRWe9IsiDSAF2vQJbmTH/MUsoXpRTOiaTIaDukx/OlQs/mDaBD
 oEjyCNGGjf2hgqtET1VGPM/aA3JUTLYvZKKKU304krLFQP4Zzu04aGUipSzHt35Z2qSQ
 MF91LiVb9J0w0Koqn6t55T/qZa13HJjwAOeVKGzdA5eWzJAmQbE07T6fh202nVwj4+tS
 ITcffmkBQqYuYYEUrtS6n4MVrTDTsGXB1RgdGlzQSXE62OQ1ZNubDyGpPY64PExPHHMR
 uMzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WHju8u2/XTadtpYrXRuQR3wlTp829/Wq0bxbYPJ1uLE=;
 fh=Lo6rZgc3RKiqxSP/Q7XwHPdPl4aEFi3KMChg+BxIXfc=;
 b=ixNYTcbsxcBnDqoGdHv8oVRoXPVXkIlvDXDihWoKdJ1nPRcIuPxgklcFbI0C7CQpuX
 L2J7OXspQIEDFc3ugawE+4tO/Gta93/Yn2ow9D/CYlNNvbHl/7qPaPM+9x0DcEU3TkKX
 jZcRkOnZwszgSXXtCrV1wCmdLIJkfhQd8GL5LhVwbs7Sw23jrTwhC/pSPTWvZwXC7iy3
 rBXbrWoqGcntZ9K9dkzIXhib3AXYHFrZCGPar0PcD69AOZMEMbh7WNf13I+7o6U3/WEI
 OWS5LFsUlRFX+AMO+alhbvS2PCZdOIxM2jDMhsBq9cf+duGgsG6hol7ukON8JfhwO3oA
 JMIA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791904233; x=1792509033; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WHju8u2/XTadtpYrXRuQR3wlTp829/Wq0bxbYPJ1uLE=;
 b=PToKU4unu3/a6zBPFVowg/mExJnpal1ztOgsRvFtk18uw46wX0eNnz3zm4krcINLPs
 6PLBBrYbVz+dIZA+ASUaztV5C462lUrR3IqIxfWXq1OSh74+T8DK07NwiqNQtrEKib36
 si+7jPGCWHrA3q7l2ZFuXG+1QEfyMkIWRUlXR9t/hWv0MblRXpTdT7k6UUUUNV4sgU5w
 TxWMKdyanmDHNn/zwZeAyHSrtfEhlrxF6c/2wMQ/Rq5GOQ6WPuM+j7/0EWDqKyHKwDaM
 +pdKcjESpfoJzvEHILCfmB1yOa766kuwQjOFD4cStiapQvE1hjumzA1RoGcHENuN7kVU
 Jrgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791904233; x=1792509033;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WHju8u2/XTadtpYrXRuQR3wlTp829/Wq0bxbYPJ1uLE=;
 b=Lk6LjhZzflwdihznxhQQA+1Sk8SHFEE2AjltJKtyI98M9Xqb4QEScCGtw1fDF2cgaM
 2YzCL6/NwLni2avkkWFvDH4a4oCZhwhRiKJp1FFM4mgA4jfc3s0lTSb4uqRcxcEDD6Cb
 sfsiICNkClPwLx0Szf46wtRtNLbScvcHVGxH9y7OkGXXsit4kUTJP3nshA3oqKPgypWD
 +XYGboiLC2/m2q3lEwsi68hwcW6ih+MST4KjRJPmxjHXUbxxxh0SrAkuwQ9Fu9TL5PBE
 cdreV7eEHpAUXOWuQwROh3objthu6XcgfTBzRCilRMRXLM2ihyFmDLpFqNCUglyZ0jCG
 wNlw==
X-Gm-Message-State: AFq9FYJi1Stz0Yd9j4Jv7sTzcI3OsASJZuZEpSq6CrTw6TYxvABptLNd
 PaQuKcQ0TOloZaXgjsbJMl1GyvmhTSNwnjsmFeWaDzhRinJi6b354lETOQvoezY2IGteL8D2o4t
 pjiw7IeCIIb4GLE5hfF0mFVaLznaWunoF/8PrLqSigQ==
X-Gm-Gg: AYBFou0dz5LUiIsjuJOG+gI+2w+kpgZEqVss+SiVz/vAJUGltHPYiWKg0s8aA0+VSqR
 eesAAFAG9Zd5E5JXEJquylaUqUk2YWF5/F3ssgPuYI+n67YvMuAVg15ycftVudWPkMgBT3E8Gzd
 YYZMI4Yyw1v5vOoLeS15PBRA78fP0WMd2mIAm3bNak0qG2/3Zl5TKezJv0GpKHCviwYUJrUZiCv
 WXf9aiGxVnHlbk4n7l2OcwQSPsO4usM/vmu4md4VlJRU3TdBuDXJU1VN+1QU10dLDhj1e8kVLl8
 U3lJGIfCDes7L+OXZ4/u1ksixrqXKasP6ZAlVWiqMBgbj2nkf3lk8PACxXSCD4SKvyLZQQvM1bK
 3Rx7jxP4PZD4QxZvxrBhe6c9ds43gI2QdanEC+Iw=
X-Received: by 2002:a05:690c:6d81:b0:8b0:a432:5668 with SMTP id
 00721157ae682-8b0a4327603mr25153687b3.58.1791904233053; Tue, 13 Oct 2026
 08:10:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260923153516.3615007-1-brian.cain@oss.qualcomm.com>
 <20260923153516.3615007-2-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260923153516.3615007-2-brian.cain@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Oct 2026 16:10:21 +0100
X-Gm-Features: AclHuK9AJLzijGRlE0PE6wfl5JmhnSAWcJILJvuKI-VvC36ZYd4XFrkh7SUY0gw
Message-ID: <CAFEAcA9YPi22UHrBpvih0YtWfa4M2a0RwbfyfWGparN3oUxm5w@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] target/hexagon: fix semihosting OPEN filename
 handling
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, philmd@oss.qualcomm.com, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Wed, 23 Sept 2026 at 16:35, Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>
> HEX_SYS_OPEN copied guest bytes into a fixed-size buffer until it found a
> NUL. A missing terminator could overrun that buffer. Use lock_user() with
> the ABI filename length and validate its terminating NUL before opening it.
>
> Replace hexagon_read_memory() with get_user_*() for semihosting argument
> accesses.

This is doing two things; it really ought to be two patches, I think.

thanks
-- PMM

