Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4267D58B00
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 12:43:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4ecX-0003Kx-CX; Mon, 23 Mar 2026 08:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4ecV-0003KI-Cz
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 08:42:59 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4ecS-0003MB-Ct
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 08:42:58 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-79ab0e9c724so1198037b3.2
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 05:42:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774269775; cv=none;
 d=google.com; s=arc-20240605;
 b=El5/uqchh9Qlchco+E3VXYPaSF5GNBHU/8zCYeGmHWSn7UkRfbce79LHmNASxE7RXE
 aYQHDaxigz+iDYZFhfutEbaVUgmEGp/yidCV7Sy8TJCxu6SWVtiKtiOvQcpR8PAhaJm4
 Oht1KLTHcFrFnYPiGkSdYrtb61jjH8ur45ZS5cRgHwuCdqtSUkv47ahrgFiXt2lU7Yyq
 Bx1g/wmg+HTd967f2A0HWuM30iCCvUHMAD3hkonuD2AjKPmPt5QLOZpORvAPF53FY+hM
 IhUixRoyOtp+ppe/7rMs+2Q+aOlFHPzEeK5mTLgxS5oD0wIAhg4f6rR4Yadmyyx/Ci2d
 aU0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5AUFMg8d/nHt5nP34N8R+KJO9D45DjZhBL3sAoWBZ7s=;
 fh=gffcMCOUXtBOrrjZQMiDLavK++hmBvO7zO0yh09tQqI=;
 b=YC+afOpsZt3j5tIw7R8K7GMy2jTH3DyMMzSOSNQjbJzCnKPlEY7Zm6m5aJOeBXavbr
 zSmG6AT4A3zVWjXalJ3LdONKpVWvYWhUCijEl9dbaik6APm0aSwxl/mkvAhcpO2ubqyG
 OF+M/UyGg6fxVJASEXQFKdNryr1BT319ck3UJn0ugDe5e3O0bDcxdbMkEimvWYl+f2MW
 6k6GXowZMLewzcd3Ij4hijWmKLnjEfFVft9Jt8asL+IrAF0M4EfCz5/Nah0cOTnAfa+K
 AH8hNS4Oh3EH5PFbZUDND3k986hihvply+KNZGeI5eEvRBxkWhC5ULc67bzgVZaaoJXe
 0Mbg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774269775; x=1774874575; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5AUFMg8d/nHt5nP34N8R+KJO9D45DjZhBL3sAoWBZ7s=;
 b=fAy8SU17YwMPGEIZ9s3/0uJPZDMFbxfetebNXrwkWmUkkNHtVsLv85njRQ8VUVd98A
 W4+ffi/tjgMOV4YgVZc3/q+a0QwPB3JigpZX7xNxQqIDPTK8HVfLJOz8LlmvzR1uUXH+
 ODF2WGD3ZEaLfxV8TAN/O5tZwFQV48LrRElf6B2Fz4vc/do2CB2lsaPilIcFqUridU1+
 s5aNfnFK4Zr+LxZO2HGcWL47m10TLRrsO+Q8XgLIHBTyqsCNRkfl8Cn27zadLOK7tFns
 oh0IKxzeJkbesA0zsq3vNbnUfH1zEwwbUvkr7btM+a77IlP162ziefQ75hI6dzRWsioT
 EMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774269775; x=1774874575;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5AUFMg8d/nHt5nP34N8R+KJO9D45DjZhBL3sAoWBZ7s=;
 b=QsUQjQzrmKGPAy8vnhphbvfBirS1F0eLCJXuQMAeeumeWbg65Sf23mhhPil3drI6J2
 39WjNYXEAUKwGKCPsSh53QcEiCbJs8jac0gn0AFSJI3xjF8V0JFyOrO0B6HDT9mIbU0w
 zO+f0W/2eCpejxRgwW0q8DP9EK1v0gzA7yUxmLaU7y//xtykc2Xaosa9A7DPt+S9txB2
 47qlXISVHRt9dbw5ZfSUkocIUc97l90uYZv7Fp8Ctpmm9IAl+9kcZzJHom3Q2CIj1g+Z
 IPjXAFUpx3QkLg7WHN61V6HPxnQkFOWuk673SKM1aHC5BMXug5QyPa2IUDL7dlUXjzar
 CW4g==
X-Gm-Message-State: AOJu0Yx3Q3J/WsJAorLLFqOTdD42F5+QAqKcCu3zbEmHlDap3Qjxcyaa
 1HCTqGyDaPY2yIjJ/IK2OEQpmLCcdmz6+sKOuqqdqHTJ08Ji5TZd5k7SHneBZFYDQQidroy40Cx
 5vPT8edt7lpGnIpQzuRKSbjob5rBqPIn5bUDFWf1faACIwTkLdpwDsW8=
X-Gm-Gg: ATEYQzxgnH4wgJMVOJfY7/81GWdGqpCCOWP/c6oJEWH4aR+c6huJYStvX4OEjF0+Vrj
 t9pNmgepyNtLG29wO0IkCeDLY1IcXDb/rKAPkx/NdmnkQZh6fUP4yMgnKO28PIeFl/uhMkN9su3
 1T+5YXQ58lA5uBWD3VGTrBwFWrsv8W2+hRkBJ4lAWd8LQMj+WbUNkvQeMwUgbFXAEaw80+2JeQw
 E6zL9PywglGb7Tuk6sRF5ILUz0opmI4dLN8VoLqDiMA3eRhvibBMUGTiiOwSG0Z1Vq+KEFNedXf
 V27gLnmOHf/uPvmQrqfDRpgwMGs9fTbIh5WuR6Gj1+4Bz+eJxlhXgGBXfvdywPMXxefNv0qd8Tv
 c7A==
X-Received: by 2002:a05:690c:87:b0:797:f226:3a80 with SMTP id
 00721157ae682-79a90af4b11mr121232267b3.26.1774269775190; Mon, 23 Mar 2026
 05:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260323102920.25170-1-thuth@redhat.com>
In-Reply-To: <20260323102920.25170-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Mar 2026 12:42:44 +0000
X-Gm-Features: AaiRm50k-r6GSlddatQeHrCBu_FJE6ZNgHQjSf4lNjoK6O7Tlr2ePBqPU8lUUng
Message-ID: <CAFEAcA-u3kjw_KedvF2Ap8ywPiBSmeOJNWd1ZMxE0JFJLm_KPA@mail.gmail.com>
Subject: Re: [PULL 0/6] Various fixes for QEMU v11.0-rc1
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Mon, 23 Mar 2026 at 10:29, Thomas Huth <thuth@redhat.com> wrote:
>
> The following changes since commit 8e711856d7639cbffa51405f2cc2366e3d9e3a23:
>
>   Merge tag 'hppa-fixes-for-v11-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2026-03-20 10:04:48 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/thuth/qemu.git tags/pull-request-2026-03-23
>
> for you to fetch changes up to b86eff44ba09b4baea17d2b002afa221de753cc4:
>
>   tests/functional: remove heuristics for finding build dir (2026-03-23 08:16:07 +0100)
>
> ----------------------------------------------------------------
> * Fix various crashes that can happen when running QEMU with -device xyz,help
> * Improve detection of build directory in the functional patches



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

