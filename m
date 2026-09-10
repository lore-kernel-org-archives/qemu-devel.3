Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E78C79FB9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 12:02:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4dUG-00035b-HA; Thu, 10 Sep 2026 08:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x4dUF-00034A-GP
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 08:02:39 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x4dUD-0003zQ-Gd
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 08:02:39 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-85a50f6a7f7so99372027b3.2
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 05:02:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789041756; cv=none;
 d=google.com; s=arc-20260327;
 b=d3hWOBKmPqj1jBrurGxYondyVIoIAkuiYa/SnQCdFPPZ+R5CiJkj+1oDNfVTkD1FVU
 7GFdqPFG2Dst7o6/0BuCcaKPYkFCKMSmvo6S3RWg3TTcu0C0GqvO5iI38BMVw84D3WVQ
 npyI5HRICwrEQINGuqauvs5jMnI6n30N4GqR+uSBXTvNe7ukyQFyRmZRA/59AvYUIAup
 vIQhLPuJfz/ALD9fBk8a3Ct5L3acQKdmW3WmQToO6cWfjJIAkGDsUWxeQystd/LZXkr0
 uNgFPXW8BAqq/iTgUIadxZuHGIM7wUHYCB+VGRH5WNp+f0JsUlx2j/n3CZU9w3mVtaT9
 h1ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PvUJxyQ2slFR8c+qOKfR7NSaYjN7rIkolrrs6/A7d2E=;
 fh=B22JtR9ZUsXUrdiOg5Iw9LSBCcKra7oUC9BuSyZP/90=;
 b=lWSfNv47EzkgE9EIdUwut62dyy22wlFvv4VsXjXyekbN9fzvz0nwlWIkKmasKG5TV8
 YWtTsixv+HocGjhQU9E45QtQU5NqbE9B8/BTqm/zwBjzbT8ebChAYFUxsYkpuBCmprj1
 KM3ce3yYNewBkKOxzvM19hFliVtkO8q+dPHzCau/DgEzoBMDJIxoJGneouTUtI1vAsf4
 8H4LZKAZCOgK47+ybmvlYw0/4AArLQc44phQr6e5hl4FChRsdIUvysYZpe4jWDZrq20l
 uR9dNhCG3snw4ePNQdwVC7GqEgjklj1aYUO6CwwFG8iTP3fI1AZu5M3Yev4GEoPmVRRW
 Lisw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789041756; x=1789646556; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PvUJxyQ2slFR8c+qOKfR7NSaYjN7rIkolrrs6/A7d2E=;
 b=d5UVtF69ZZ2QffC6WXxF1KP5j3hizz3KF7BEFpaY6eRO7Cu9jrfTr/ucF2LlxY8XrY
 +TdyGvxROP0Kh5xGmNVD53eYWomkPWyoYuO8Nzo/d7xgEaoweQU2GuvplZwJyies/1ss
 ghikFuejddf9+eQ3jcrz2dwndcWscMjxDYUxs9CirG8Ed5/6fPF54wLZ7/UXWPj5YEaf
 CYphH4brAnLphamrCPZprj0MaXUplZl4NeFpMVsnswlg89yN2ZQHpQsq9scI3C3khdjI
 93lLiIQ94GXww5IRmZ1mSt4WpWqsK09k1goBoXlqjpkNAAT5iFKz9QjmhCSNMUG1wPaK
 S2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789041756; x=1789646556;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PvUJxyQ2slFR8c+qOKfR7NSaYjN7rIkolrrs6/A7d2E=;
 b=gRhW+h7oyIu9nXY5FQhOBzE9BSsUGjEvIPBOPaeg4rL4p2worPzRk5PHPxSG1sbuPS
 3TVYZjEUrHqD9f7nVJi4a5/GhEWfZObbv8I9/ZBniReJWMBkyb6ZZVXst9g21iGoZxmZ
 nC2wD22Boy+JL3+H8ZKvHvQU9Ot0V6xR8XUUHyI8ubftBgBA5RG17CJzVgSbOLmWvFK/
 TNr3rnLZyf2+gd1Yqw0zhXZmIBDTiv2TBzE9lgVxuDw6R4p5ePzyzjFSsoSVYY4qVvZR
 En9b9E+W1a/dwJXwhWGFsYolz4u+jrmUdRlIr/ohfjhNCh1nJGmRDJ3Q1+li7Lli/5us
 OBCQ==
X-Gm-Message-State: AFuF++nIdQeSl6qg7W1q617X0KCYr/MTNlFUkZWxNdmHKVnFdz1EgGgV
 gaEuk++aOrq+7zfpJODRtyl/Hv8ukTvfzJn8UQwlzY6qp+7o/RjsbNb6WuANo55UlxcoYbSGnUM
 EVhDPVpLeEFWPT0o6fro/2uQODwaYTmo+HEXTCkPyVQ==
X-Gm-Gg: AYBFou0rPmSUgEdpIhboVlU45ZjtH2hw0PdDTRuXWpstciILG6Oqh357LNKxM1bq8xO
 ssSNsdiqldITd43JsG33z3Wa0RI5DzCTao8WAyC9X+EdirzWUTy2sfUmyTVJ9e9A2AdCEnouZmX
 alV2AkZDh6tyxNHZJkV0WBpllu/qtNTsiUu4xFv1HpVhCaYNVKHPSbhnS327vpEv1nHgvuyTzyQ
 j+q+tLPuHMXq3dLeNSpO0Zw0YTCsD4cRPO/Jsqm3FCqtxpQU0Ez7+ainqmCNdD6k313UIqNkgQB
 aAYVeveh2i5xnFYhIqCGiHEChou1T6r8u3T53bJpW53IzpaAQpNprK4OmLVq87YP3h2aS26XqAt
 F69gnANBfxH420Tddiu8a18+p4V7zB+DeVShWq3o=
X-Received: by 2002:a05:690c:c4e5:b0:873:5c7b:c0ee with SMTP id
 00721157ae682-8735c7bc21emr127128287b3.38.1789041736799; Thu, 10 Sep 2026
 05:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260909155624.1082893-1-pbonzini@redhat.com>
In-Reply-To: <20260909155624.1082893-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Sep 2026 13:02:05 +0100
X-Gm-Features: AcwNN1V5H--eG1LZTcfRYfXgUX97F-MkHxrlwN-5wE102p6XdoJD3u03hEHPwuM
Message-ID: <CAFEAcA_h=PuhxaCrTGiyAH=cR3k6PZ1RjrmepJf-+qQoH_PcdQ@mail.gmail.com>
Subject: Re: [PULL 00/12] Misc patches for 2026-09-09
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Wed, 9 Sept 2026 at 16:57, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit d2843fbf80260e4346c856819e8cea11768c9d0e:
>
>   Merge tag 'pull-riscv-to-apply-20260904' of https://github.com/alistair23/qemu into staging (2026-09-04 09:43:27 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 0937f8a26c159d710ac6a122cc99f9661e739950:
>
>   rust: bindings: disable more clippy warnings (2026-09-08 19:36:25 +0200)
>
> ----------------------------------------------------------------
> * AGENTS.md: basic bare minimal guide
> * target/i386: TCG fixes
> * scripts/checkpatch: warn on duplicate trailers, self-review, crediting AI
> * docs: link to website for IRC and mailing list
> * rust: qemu-macros: remove redundant clone()
> * rust: qemu-macros: silence more warnings for bindgen crates
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.2
for any user-visible changes.

-- PMM

