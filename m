Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23CE0EE499D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:33:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMIV-000395-Ju; Wed, 11 Sep 2024 08:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1soMI4-0001oY-6S
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:17:52 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1soMHt-0007Y7-6E
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:17:42 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5c26852af8fso8689854a12.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726057036; x=1726661836; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3Aj1cv6VrGbENIMQvvUq6DYxQgavYLHyuixHCD7U248=;
 b=YLArWZ5w4Y9u1dsvUWEiRwF2v+c3MGr/pRqooukZOCBLD6FTt0Mf87mv2Ln++NxktT
 M0uRI40+8tkvKhrzlBVFSO3xEzXVJy/Dno7L7Pq2Amgs2j3QVU1hPeD1i8LL9/WBvLTj
 wm7QxBZQGgYbD6onDdGE1DaxvFd8x241sKTqVLY2iIk7ZzEzKIyDhi0zWDeg/6g5pEw/
 foUf31khhZhziqMwnQBD/BD8whdy9QlyguRP51Ga+XvDe7OIuRQXNx0U6P1qO4u//IFz
 4uW+Uqs6Rh7wbZ0ZjHioSLxmIKk49Cg17w1hQVJkRlvDOHkzI9bjEWiugOJEoboYHU2Y
 VkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726057036; x=1726661836;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3Aj1cv6VrGbENIMQvvUq6DYxQgavYLHyuixHCD7U248=;
 b=ZT7AmiDHQ8DJ679s6/wFnn1oPfJAHNSPe80q1GUOWSGh06CpBPSbrENRw802tSIZC/
 lxogGvkiEvGvEMLHd9JZY+Wr3MFijz0yLp/lKO+Yn/+gHdcqVSjrSHQLdIPPLj16mlsd
 vwUOGngdDZ1JTuZ8QfLgXCx8lbWzu2qmFRZFQUOCKhWDUJFghiusFZG3/GqZnNtLoyN5
 1QzGT//gDw9+y+aNdmtLhqk93Fo0NgHaRr0gW8ua6HmkMgkgJC2buAHTY9RbyVjgRSq7
 rOF4a9T2Urm/2Mc77m1xSBg51BtGhB/mO4NVD7tls9zdJ2+4I0JI943vT0WY0kASIZC9
 mi6Q==
X-Gm-Message-State: AOJu0Yy0WZwpqd9azTN5YVOsVDUrzOngUuF7T2uHHv3mZKKSbayDb22U
 AmM77lwtvNq1RHClqCtJDWDfjoAV189Z+aHSjN/mLPd7rSOuLlhrAsZQgEvK/R7dnoYTc2HE4Er
 5nwn1r9XyX60eCmKVOS1nSTkRQzqVUlvtKksWtRBavBNfpybF
X-Google-Smtp-Source: AGHT+IGGQeYz3mwQH+KGvJnWFhW1f+1uQmL4q24It7KYU+mztwN3PjkQhD1B5l0M9+tZzCdgUSII7AkLIGtm5LbGhLc=
X-Received: by 2002:a05:6402:388d:b0:5c3:d8fd:9a3b with SMTP id
 4fb4d7f45d1cf-5c3e964cae0mr12451847a12.28.1726057035645; Wed, 11 Sep 2024
 05:17:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240910164714.1993531-1-armbru@redhat.com>
In-Reply-To: <20240910164714.1993531-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Sep 2024 13:17:04 +0100
Message-ID: <CAFEAcA_-Jv2nc=x-nXT4jFHd0OdPMvCJSvCwdCSfx=0GWZRXDw@mail.gmail.com>
Subject: Re: [PULL 00/19] QAPI patches patches for 2024-09-10
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Tue, 10 Sept 2024 at 17:47, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit 7bbadc60b58b742494555f06cd342311ddab9351:
>
>   Merge tag 'crypto-fixes-pull-request' of https://gitlab.com/berrange/qemu into staging (2024-09-09 15:19:32 +0100)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2024-09-10
>
> for you to fetch changes up to 64f5e9db7706c8f4a7d7b521596caae9a1106337:
>
>   qapi/vfio: Rename VfioMigrationState to Qapi*, and drop prefix (2024-09-10 14:03:45 +0200)
>
> ----------------------------------------------------------------
> QAPI patches patches for 2024-09-10
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

