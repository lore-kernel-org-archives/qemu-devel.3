Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73025CD8CA4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 08:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWsIF-0001Ja-Ol; Tue, 09 Jun 2026 04:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWsID-0001In-UX
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 04:58:41 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWsIA-0005jV-LW
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 04:58:39 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-66077e888b2so5464972d50.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 01:58:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780995517; cv=none;
 d=google.com; s=arc-20240605;
 b=CwxdJ6lNPKBnRkascvdwta5K0fLkiQe4/QNHEkJZMk5oVU1q3STuZSxut6vzS/YH2B
 bfFTi336yNmvFY3AYHXVwddL3bwuTW7vGxUiksfP8KbH+Jniw+CaHBf7yy5U9evmS046
 1ByokEVh9l09leojc9T11VgwkzTUpHGvQGCpKtwigyZCLQOU8YnXFAMJn8gQy/eLsprc
 y2NqU0mUVp8cywvTOrH9nAkLtxLWIOmzheo6C1178tp8J2zlGrSoWAS5Y2vAGsxbuDWk
 UlWixVHgtIYHP0zLsrND60ipHGjf5APNRRMZsWLm26DtTSyyVUO/g5uPpayKUb4EaB7X
 arag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=s+0BfXHM21QnV4863C6uImYyGFFQDfVOWFUWijIqoLk=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=APCfp/y/fsI32pV/OQPEcF/8EFMRZCGHIgLGH3O9GPvksLtCzV+pMMyID6KVQTA3Ib
 7gcok0J5AOfd93YJS70ZGkBwe58TCxhutbx5o29C2di9oWIjTmCozi3IA+is2dXxG3J+
 W8PfCE0lWC3dNh9k3c22316iUytFM2lIp5EmjpD5HirQTQE+QRZQ7SISqTlUZjEhZ7DY
 q/X0oMc3HDAiEDmmj6EHay66jr+OYsz2e0SLKsJ3I6lSigkSuKMx0+jkPbUCCWpl3Whk
 ED/5ANmoz9gU9sNKh+m2O5/UrXmydXS0D3gk7g5+JtCsoaT+UP4SIz2RvaNweFVLtjiM
 v9Og==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780995517; x=1781600317; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=s+0BfXHM21QnV4863C6uImYyGFFQDfVOWFUWijIqoLk=;
 b=OB/9kvzc3JdVAWuFzDO61ES9i4ektEYcqQB1YLcVT81EXbVs6vTf5q0mxtZc6lHkk0
 jLfFovCvj6thFHDJdGf+Eh/emJHF72SjWX9U5D56y7iK0oZ23KFAtq0aL42cmJYAoyIh
 MNohCZ8v4yqYCERgcDhIp/KLos1bjlgylwpvlXtQ6RAM60SWPrYZdTodkzd3y7bsmrbs
 slvOAB1vYy3i6PW6NwD4v6zXdMLlOhLaKX7PcgqRVHYfdPWB12g4WEEHG956zlIP+Aac
 AkNFz/h3EPZTQ8SiP7G0filjLcYORl+FXRvc3dWSEmlN/XoCDHY6JPGlvYs5vadUAwWY
 FgYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780995517; x=1781600317;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s+0BfXHM21QnV4863C6uImYyGFFQDfVOWFUWijIqoLk=;
 b=dJ2q/VSPjMzPfFone+YycT6J0A3+YIoZSxsSgG2o+b8YxRLfw1p7EVEVHFtwKwyyLD
 XZ3GzAoXFT/kQENR6Tp2nuJqIfaPVWLj5M+cOaPBPP1WJJjHjUdrmGkHzqLzs3rGjPKl
 CNQ9oz9DdhDsyBPVAlg4oLR007EGErUCu06de3nrDevSZWMdLJ+KjSYVay1ICr2DNw1n
 tAMwb8ErNzdsWWDx17iM3Tx5U0ykSP/iJUbgHhoi+XylSsW29f4dnwc47K3dwHfSLWsh
 Cp4RxGJq5rIyO3rRo/Iqw7JK4pz7Trg7OMYeE5AaKKHy9po1/w96jzqqRMLWwLCrLIKr
 nXJQ==
X-Gm-Message-State: AOJu0YwhdHS6jqHMjG+CmAQJJ63opYn0VB3yr/D6bKj6Q/UVTuzyPYN/
 lTYDzvhmhxFneB5lItaiQ/uGuAJXPaPtOvg2zdlzPO97A3z0h+J5ePjBvOwDXK48IRD3Aj+LONr
 rYJh+tPEu3cz5lI7cIeH5DB956ULkYuF+Rx7rHLid3w==
X-Gm-Gg: Acq92OEsM2/yvPZLnJqpa/u9/EKQgPnVDzzHdZoXxer7us00PF8BulKaq8H6aBH9aND
 m5QAAbcfhPHm8wD/r+/Ox5aIjxoMsORUIuTVH8eKk03061TDuJLPxicFLuYZUVpOcWo0SyLgbym
 fDObKnA+qPK1ilvwHWV4pgveT8hUsg04rToz2mpvb4S+pmXduvr1xXzbm8B/Y5A79HsNIxpZuSK
 5KHVs9/x31lzQvIZhz30rAMMS2ilJLlgP2ZWwJELrdtqUPZ2Kdl9PCFfTYno3XoNMeI3PI2LE2F
 50PdZAnxKmaDd2IoSg/per523obcDLZWsFX4Npdm9H07mXJ8A8m2svE4yR1gS9MsPM+AR+C+Xa6
 VCg==
X-Received: by 2002:a53:ac89:0:b0:64c:b81d:2cb7 with SMTP id
 956f58d0204a3-66106f42dfbmr13753643d50.39.1780995517549; Tue, 09 Jun 2026
 01:58:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260603032855.106930-1-richard.henderson@linaro.org>
 <20260603032855.106930-17-richard.henderson@linaro.org>
In-Reply-To: <20260603032855.106930-17-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jun 2026 09:58:25 +0100
X-Gm-Features: AVVi8CeKdZb0KOtwk_A8HvaMvOlQieBmiSHTNTY5q6tmQcCKj7K-krES9-JlxNM
Message-ID: <CAFEAcA_+Dhnco1c_-soOnkzuBppW5wzSSn4w_S9n9o+hBURcBg@mail.gmail.com>
Subject: Re: [PATCH v9 16/45] target/arm: Implement FCVTN, FCVTN2 (32- to
 8-bit fp) for AdvSIMD
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Wed, 3 Jun 2026 at 04:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

