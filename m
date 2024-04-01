Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F7EDCD1288
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 14:31:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrIg2-0004Cm-K6; Mon, 01 Apr 2024 10:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rrIg0-0004CM-Fv
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 10:30:20 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rrIfy-0000t2-1D
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 10:30:20 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-56bc5a3aeb9so5149223a12.3
 for <qemu-devel@nongnu.org>; Mon, 01 Apr 2024 07:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711981816; x=1712586616; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j3vzcP8Bfb696MzRqxQtVcIPGQfMopEnS6ySKVo2Sq4=;
 b=IDGGCSLz/QOahhDUiK5Ju3ffDxVDemg+88cFNgAcYGl+pj5jLJXg5g6hZBX3dw8aK4
 3bgap25m9cTyJd25S1JjajhrIG7xaVul4K4jWxUfTeNmfPCYjLzjsL52gHGe92ViEdXv
 1UhvYcDlyOxslrlTkT3OyYesO7AZ37POMljX/c6zMuoN5vHBIgxQs+IivEGSNv9QPr9Z
 /53D4f0f6Z7JEviCuVYo6RE+z/mwe8kdYW55Cxb1qIsxdD9DWsr2HGrOF8A4tZn01r0L
 T+cK72csc9w6awVW05EWEElCzgwmXFXnbZs/TYVynyosOlpX1jVW/Xex/SZbUHXRtcQt
 gAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711981816; x=1712586616;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j3vzcP8Bfb696MzRqxQtVcIPGQfMopEnS6ySKVo2Sq4=;
 b=uEKdh3Wf9obk5Y2w+6gMuHpZxM92ZPt38kFQzE+eVqp0k+hJI02tk0nPUzZIQjI9eJ
 BPaTENeHqIJu4ljoNlF0LeSJgKPHqn+HWZKhfao9U4Nyd4f2OyV0Lly/di5JxseKuBwZ
 +EA2aKhsRtBm+FlFioYcsMg1YwxkVU9inLHV+cBSC4grWOixbfHmYqa/UxbSLw6lRxq6
 sVFjM7QYNDA/iSegAwqXZskEq1zxDQR6evul+uy0CwUPRSsi3WMwd8OimQXQor0njBAu
 TMFrVW05QfY5kTZsjZ+xeFJGPF/vdSRVivGT48z5GqdcD0ZVwtswY+vu+l2rY9545A/O
 kzWg==
X-Gm-Message-State: AOJu0Yws29xti7m1b5BwtH7hDw4XcK+1mI+npjUB/hZA6EiJ1juTio7Q
 y63OFiu/ELdp+me/SJpWf94yC+oocw6HGVflvOthbJ26dFVl4Pi3GNZsedoRNm6cpPP+cEv1rbh
 IdEDyVkt2PbSLnnz9ggBO4G1aQzliw9BT22bmTQ==
X-Google-Smtp-Source: AGHT+IGBYcsMFksRdkzLhh2Z0jvIXbM0lUn6gXCslsiL8QSVWpgjppialNCJvhGGwHACu05OnlewgyLVigunrnwnF0I=
X-Received: by 2002:a05:6402:5114:b0:566:f81:41a1 with SMTP id
 m20-20020a056402511400b005660f8141a1mr7003764edd.22.1711981816029; Mon, 01
 Apr 2024 07:30:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240331183251.1045817-1-peterx@redhat.com>
In-Reply-To: <20240331183251.1045817-1-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Apr 2024 15:30:04 +0100
Message-ID: <CAFEAcA91xPipCybp1GQo2mdTt3_ZVE-ify90Bv=6LxrjWrC9nQ@mail.gmail.com>
Subject: Re: [PULL 0/2] Migration 20240331 patches
To: peterx@redhat.com
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Sun, 31 Mar 2024 at 19:32, <peterx@redhat.com> wrote:
>
> From: Peter Xu <peterx@redhat.com>
>
> The following changes since commit b9dbf6f9bf533564f6a4277d03906fcd32bb0245:
>
>   Merge tag 'pull-tcg-20240329' of https://gitlab.com/rth7680/qemu into staging (2024-03-30 14:54:57 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/peterx/qemu.git tags/migration-20240331-pull-request
>
> for you to fetch changes up to d0ad271a7613459bd0a3397c8071a4ad06f3f7eb:
>
>   migration/postcopy: Ensure postcopy_start() sets errp if it fails (2024-03-31 14:30:03 -0400)
>
> ----------------------------------------------------------------
> Migration pull for 9.0-rc2
>
> - Avihai's two fixes on error paths


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

