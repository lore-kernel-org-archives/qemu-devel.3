Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A36BDC624CF
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 10:21:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Lbl-0006hy-AI; Tue, 01 Sep 2026 06:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1Lbk-0006hj-0T
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 06:20:48 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1Lbi-0002Xv-BP
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 06:20:47 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-81ecf499af9so54089097b3.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 03:20:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788258045; cv=none;
 d=google.com; s=arc-20260327;
 b=q8Uq3WPwNevLKr4DOUj/UFcXZdxilXyenOxSi5eAI4PoPABsVsJcdeKrqvrVqQ94f6
 Eb8t9wtJmyVzqT9l1umwcobM6XiVnJVDEaoIPDCiF7hX1I54Jdp1HHDbuCgH0yGE13Wx
 8yOId1yKgjKDoizPC2f2m/8S+Xt9O4awO4/UgpWgcTEnIhaxYr+dgkUIijSTxY0gPjU8
 4HWnehbc6Cchek7Yy/pd0Uj+Jyrfty7FvGxmBl554SRWoUwdsXUMd5ncrP3lTSKIXrjO
 SWWXqv5iqQ2tA31/Wk9Y6qdaKxajIgI4HynLUQrpcn2I+f5boVAeOe7/oGDwsBqHcztX
 Gd0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QNcckCwmmv60hnws8+62+nxtDz2VNaU9Y8eXf7nRzb0=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=mTJtRo0jNigYwWkOGcheK2vbYJdps4JdTx80ZAGQqWMGVj9Qw7Qe6f82U7OkwYP0Ui
 odH+6TsSel62E2vj+az+z88D0UsCkHaq+4m8vrAgWqMZE75h81EDw2TheALRSw5N0JSm
 s7c8Ak68+Rik5lJohWmGsXp4ZsBKhTpWlGYokAwmxF+fN4fW5wjgimfcUo2rjZvyuh0O
 ZhJioAx19BSug7U0Sydho9M8W81SlrizN0L9pG9gKFhFqXTn5ftxjlhkPGy5sKY6rzyx
 ezMc28rb7nULoHQlHyKKcFFE9IdAQk+jGPl/gsTot05dGwG21XnNmJVpcanf4Dtg3O7J
 tpBg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788258045; x=1788862845; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QNcckCwmmv60hnws8+62+nxtDz2VNaU9Y8eXf7nRzb0=;
 b=RSdFyxNCHe29TYEWg6VqUY1nJEn4tPnP+ggFyFgd461qYtBL9GDbvo5AaS43cLhIRC
 xy55CClJ/LfsSaXkxIzKwGZ88EWNErddiUCmuSsMiaAPpTDqcps4fued+HKvOlPWQB/e
 GspUbxmUvNN98PZdVE+SrKjirG4nP70teqs20l7qkiS/ChEij7tmTJuK5rN0RKebBPC1
 QOTUSrMg3zrr86uWIv4aUbTJBxLtIYQsPs3gEWJUNJMr8p5+fONIluGMUDL45KGygfBk
 X9knLz47WY61ymyfz5ApZNjBGRk9e6bGZFlOr+45M3ScqBEc7bfm2LXoX+5/08ipCApL
 RngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788258045; x=1788862845;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QNcckCwmmv60hnws8+62+nxtDz2VNaU9Y8eXf7nRzb0=;
 b=UCxG7toQlfPIzKRDDqfu0Jfrzkj3EF4F0kgpHIq0zm02bbUFmSxVJ/45kLRoJuO/e9
 YzeUcyQEoI0REr+pVyGUxFfEOvl3RuJCN2M/yAWTcdRbuP0u4bZsgpP6kZ8411bPZSpe
 +bMkzczwnrTMBuj5P5aSNvpUTRzatiWtbJXfqZ1Zjpewu0IXX5TZCUJTPBI9UfFzZd/3
 D/NYf1XRoDeMauIzssD7cCjO/vgXk+MyuWjDSzE7i4xZGyCP/sJijMZYGV2x508oBhFL
 rjU+iS16GKt00cYPPZVw81Ebud/SyPHl698Own53z3lB8S4sESCzf1dpO2FHi6NhJDh8
 Tsww==
X-Gm-Message-State: AFuF++kaNs+zV9dyZJzucWga4DVdyn3EMw9M2lIc5X7+Vz7ajYBRCWOZ
 OJVcZuWczopYErTwYt74A6piY5SFXntQPXmpGIGtgyG+fvml9mssmYXuJoYILkxD5EqSoD9nZL4
 t08YwTdxd7a16npMHeNw1a5SG/M5G4hBPSxxY7gGx6Q==
X-Gm-Gg: AYBFou0m1fMhTSSUuQxZlDPdTEEeymPHZQpA1KTNImM/VSWqvgksDwDQYLBW1gu6RKW
 H304d4fY6fC9gQ8K8rHUz3WmYRgwW9z46G4WymtX2B2kYTXk4ZEVWlV6s78oK2RJ7eUP7UkO5TE
 6W72FFmKt0uRl49ioljfI6XzpT03qIGi1OYbVcmk1yEwH60F6b6nJtkvDmtnExyPMadPhq4qzO8
 Gi1LV7xRrHTTZdlnuc2Ty94A0VNf9UZurEE90/yt00XQDfXo4BhlA0Y9+z+rIjdRJ5QbJYjVkZK
 A0S8yJlzfhjF9qdiHT7MkIjnr0HQcg3OBDph1jeLfMyWSb0F/8ESILhEk2CHcLDlPpT7dKOHV00
 Vqf/mJwWrmlu1hEoWy0+Os8XnVVyD
X-Received: by 2002:a05:690c:d91:b0:84f:cd89:30f1 with SMTP id
 00721157ae682-85d6a1ec0famr129707567b3.18.1788258044530; Tue, 01 Sep 2026
 03:20:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260806172709.333300-1-richard.henderson@linaro.org>
In-Reply-To: <20260806172709.333300-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Sep 2026 11:20:31 +0100
X-Gm-Features: AcwNN1Uylh42WQyiR1dQ8s9ahMwqx0YxIyDleKvAN3cfNCEVdZaxUF6ZpVBrUhk
Message-ID: <CAFEAcA_RTXJrwjsYGT5GOtmULbRNGFTTaokiqV031XqTtUXPEA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] target/arm: Implement FEAT_FGWTE3
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 6 Aug 2026 at 18:27, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Based-on: 20260806163939.328201-1-richard.henderson@linaro.org
> ("[PATCH 0/7] target/arm: Introduce cpu types max-v8 and max-v9")
>
> Changes for v2:
>   - Rebase on the max-v9 split.
>   - Review comment fixups.
>   - Set fgt for MECID_RL_A_EL3.
>
> r~
>
> Richard Henderson (6):
>   target/arm: Add FGWTE3_EL3
>   target/arm: Add FGWTE3_EL3 bit definitions
>   target/arm: Add FGWTE3 FGT bit definitions
>   target/arm: Implement FGWTE3 traps
>   target/arm: Set fgt in cpregs for FGWTE3
>   target/arm: Enable FEAT_FGWTE3 for -cpu max



Applied to target-arm.next, thanks.

-- PMM

