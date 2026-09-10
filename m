Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF45C79FB9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 11:05:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4cZw-0004kO-6m; Thu, 10 Sep 2026 07:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x4cZu-0004k7-RF
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 07:04:26 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x4cZt-0006KH-3b
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 07:04:26 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-87005a0e052so84300137b3.2
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 04:04:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789038263; cv=none;
 d=google.com; s=arc-20260327;
 b=U2UPKy7DX5sP2GhYQtFOfBGLzLEISJKMF9NAeMhmNnM1eA3+jDU4xM2XB7z69Cbxps
 /fVQ/IsT0TLljPSn/vjDA6e4IBBZvXt4SAPb5W2nFuv/rFxYEZWpmEm6Sctnt2zyBRAu
 /kUJQ8CVpUwQ/zub8plYOSVSGQ09jLMlEMMnHScH/eRRR3NyRoEv7AngCGfwcPHiS9WE
 c/WcCkJdHvtcy/gnWehWcNIE+7ZnlBdTIGRXz1qDK/ycwFw1M3w7cwMv2sf9ENZhv6qk
 HhFajilRY4iS1J3nNasH4F3e3JF6GnGiotMuU+DsbIfD6bj1PlXwtO2ZJ9j6Ah7PpCoj
 LoKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=y1DpiDcwcVxZnJupti1cSNma3xCB7QBpmm/Z0yCi9Fk=;
 fh=fVPfpHMeJX2gxPKYTBQCzQO60hB2p26ro2vRuUEPsJ4=;
 b=VDkjGiojdSrX3wNz/ajDNhuROraClFOXQXWVf5pnLk1GsRiF+IXsUKzg5htuzwP3vL
 cwxqh7Wrfq1hSzs9IyCUrRB13E5XRBSMLmnl8UvHctOS+YGYeMbYUrP0n3yp4GqglzYG
 UcrlQUhHHcOouX45NrRmyu0xk2zdznhoQA8yYrkLIB4H4M9iM2XcGNblWNv1UMDEKzOp
 wTg8vogyPpFEeqhYL5bbYrS2oVozupqg3QgGLcWHBzlg75mwz4Rw7nUqkCqxI3mwnHY1
 fldsbes38Mt6PySJZNYxT6r2QR/yf/MR33Wjd5//mfhrKGt7TTqKqCcY6arfQS7facJv
 g97g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789038263; x=1789643063; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=y1DpiDcwcVxZnJupti1cSNma3xCB7QBpmm/Z0yCi9Fk=;
 b=FeUycHCp6HW5oEHFByJog5+W0+h7P+oguTvSDOJ8dWG7wH5HJddwpstCKly8xuSq78
 xiEBfiNWZl8PIVWtUdrdUXN3OtuFxRnY4SMGvNomH25eW+cfhGWCcU6SxmDd98VX65Ne
 VruciKkK56biTgIKwaKEPDhRAKxuYWsGi2bacSxij1Va7yenS66XuLiQKOYORQRIP7eB
 ZuYu79zixcnjxDj6VzfpaoaXa1Mb+7kLtcuIJus6CfVglL2ila/jJW6oShF1lBHV8brn
 mg60wCTsNTOj5Fz9ipumyk1W46ofxomLO3RvY2qvN4+K9v3hdIc1NTVAPXXGC42QO/bN
 DJaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789038263; x=1789643063;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=y1DpiDcwcVxZnJupti1cSNma3xCB7QBpmm/Z0yCi9Fk=;
 b=Ey5qNZ0DuDK+PwRriCqixI4pqLLFAUVY5k9I+B6opAvW1M/P4xey22iNfnRnyRHNDM
 pVYU3fxTAU4McO/6ZN4GWEmuC6l8+I43HesWAZyXCicMwaSmf/PXaNIfzz3F6sKgSAYV
 btLg2276Js3VB002p1LXtPgVjpfgFRyNsz9QAavHOrJAuBmUMiWwpUmU6k7sx7r3J0sD
 AHf/rKvfFu7N6N1YlCBTgUUZI+hOmtYBl3u+gxL2g4N8SNwo2xEV/hHQGJUvtUwwc/tI
 n49ns3yU2EaKY8wqYxOXgpCJ36HmGDamBZuUmC7WQNcjJjrxWnf1XGHvvqPxgXlpaQT9
 BJ0Q==
X-Gm-Message-State: AFuF++mYVTaZxLFEnbhgZgYNTV+qoBI9ohrjlEV41uULDhkM43+OS3lQ
 ei/pkRUogvGgHLIQsJ7lztqIQJtPmqwFhamHY/oiKBcSRJiWYw1XCzPXIfyW6E01CH5FFJYbi5l
 nMKeVynDbK7zPL7j5DL+n8jApDXjxLqT79DxKYxxx3w==
X-Gm-Gg: AYBFou0xc2WoAHKz2VoMrUaQQOSx6jdKUFLu8ZlcpZQLi7+Sm86gCPUhht7btpNCkbj
 4d4Eoy7mDHgQ85S2jKdOGinjIA07dAZ+jaJ1YKiTmLgtwLpR8eCDkfpog/qX0Ubt2OSsDcuf7K8
 34R55rJFQbDtAzYD+JWjUbljNG+hDRqrON1PDJz1JPM/9UbejK3HG4MSQo7QDlkPDj0b3NOvULj
 FCSwPIQM5Lq6XQ/Cjsf57qxh5LMgcwx906ywkmDUcmrl7/5D4G3f/RSjjVnZtYle6mt3umdqgeA
 Cr6B5zOHdYiafHPjBDM5mrZkOGYN9hG1Gqpt6nbz7uq8QPy8a+h9rcYUv7XJd3Mw/H60OSeSA1T
 qerZRin3RZgJXQAa75RlSlynV0kENs8gD25RieL0=
X-Received: by 2002:a05:690c:31a:b0:871:8a81:a2c9 with SMTP id
 00721157ae682-8718a81b972mr182038267b3.22.1789038263341; Thu, 10 Sep 2026
 04:04:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260906194438.93046-1-gilles.grimaud@univ-lille.fr>
In-Reply-To: <20260906194438.93046-1-gilles.grimaud@univ-lille.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Sep 2026 12:04:11 +0100
X-Gm-Features: AcwNN1X6r3KOwglgBeJamxNql1SDCtWiEXPICRghG26PE3e-JWxzX8pzMuqBB6w
Message-ID: <CAFEAcA8s4UXp=hp9R=Pq1mMP6VvB8ergnsm7Yq1xooOGgTPsCg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/36] arm: add Raspberry Pi Pico/RP2040 machine
To: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Sun, 6 Sept 2026 at 20:44, Gilles Grimaud
<gilles.grimaud@univ-lille.fr> wrote:
>
> This RFC adds a Raspberry Pi Pico / RP2040 machine to QEMU.
>
> The work continues the RP2040/Pico RFC posted by Alex Bennee in 2022:
>
>   https://patchew.org/QEMU/20220110175104.2908956-1-alex.bennee%40linaro.org/
>
> The target is intended primarily for debugging bare-metal Pico firmware and
> for running firmware tests in CI without physical hardware. It provides a
> functional, test-oriented model rather than a cycle-accurate RP2040 model.

Something odd seems to have happened with the way you sent this
patchset. Instead of the expected structure where all the patch
emails are replies to the cover letter, instead, what we got was
that patches 18-30 are replies to patch 17, and patches 32-36 are
replies to patch 31. You can see this in the "thread overview" in
the mailing list archive:
https://lore.kernel.org/qemu-devel/20260906194438.93046-1-gilles.grimaud@univ-lille.fr/

The result is that automated tooling like patchew doesn't see the
whole series:
https://patchew.org/QEMU/20260906194438.93046-1-gilles.grimaud@univ-lille.fr/
(it thinks only 18 patches arrived).

If you could have a look at what went wrong there for your next
revision of the patchset that would be helpful.

thanks
-- PMM

