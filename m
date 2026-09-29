Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3423CC9832A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 15:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBa06-0003Ux-2p; Tue, 29 Sep 2026 11:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xBa04-0003Sx-2S
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:44:12 -0400
Received: from mail-pz2-x0d.google.com ([2607:f8b0:4864:3b::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xBa02-0000gT-Fb
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:44:11 -0400
Received: by mail-pz2-x0d.google.com with SMTP id
 d2e1a72fcca58-86e6d007703so2033294b3a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 08:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1790696649; x=1791301449; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=N4kEFt36TW5JGe1FwbWriX3cQQwwxlGel/06QpjqTSQ=;
 b=cl2WN9g+T1MQgjIE51MPCIxdVdYXWfJycPnW0BI/LXgygqa+iWiup9GZxY3fbx+9Hj
 XPSa8pEF1x2oC1p/lbNQ47wZsDAOvhaLFTNouQceSA+uUxMy8av5vVJJBpLhcLnW4qy1
 nF3NfSAjAZ0ASzBDrKxylrmhEznnrgMY8Sivn0lVvZ8OtiYmLTAslQR05OVVQOq0ag08
 3yJRnqtkTd0ZrvhTkgkspA+JnZkQYJlQanYUz/inqNIT4ZOdSA941QUsX2xbH2LjIPhI
 Pqp9Pth7kZU2Xp7nLm6NtZ5PS/si0KVbxx9lvgz/3gvmmpioNWmBXvK9m2FZ2Q6/jV+3
 dIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790696649; x=1791301449;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N4kEFt36TW5JGe1FwbWriX3cQQwwxlGel/06QpjqTSQ=;
 b=0qsMEw0b/l40Fm/WLrX8aHRuzIkM6ACgZafJ5VRPgU03fCpLLHXYb8O5PDbYO9hW/0
 r/WfVkUy0zLDw9yOTkwbGyEvTl2x0iAxWnRIBzkVcFFx4rlwAbHGN0af4vwoQ1vxYJuJ
 lRb8h4ez5lPIL9E1Yvx3k+gjgGyEq5viXcS4hWw6J+4WD7yC5rf2FP77YNHX6vJ/63XW
 EKxa7HUGw/htXhZ8aIk/oKpOuZBz4Ku3TFxk3OHRhGoJk0hT006e/lWXewQyv1NRHzEj
 ThsGhr3Th44t624I3C1L4Ocufmn9JX4dceaI9n/7rJJD4EHrD9MDZ1SekBju+u2rWr2+
 bw1w==
X-Gm-Message-State: AFuF++nBKan4KV81wt7p2HISIC09/l7FD7dN9J9yL3qZ4kvmbw/d89Il
 RyD4VJEgqRol+5zECyEMbwq1PWzLzUthia28AXomJtHIBw4yEne+URMBPyimGdV7W0s=
X-Gm-Gg: AYBFou2P6mfdnFCQQiK8HFK9IA2wUKBvY2Gj6mQTK/jLDlkusWLRW7eRB2iRtlssptv
 51Hrckvn/oSFZFJiBvU3DcOva1kW/ZuooK8ETb/bS+Fqjk9Y4RpcbrN85agqa9UncuUSGzuGfKl
 YrN/6QSDTcBIjaVg/sQybx4CKijO8rQkpd1C6hQrhj7uvFm9hn4FsBSYlU1oHB3nmjxQwP2Swj5
 gB6mzQwRdoxRpFICdRcMQO53mAzawlOb/vP0JC05J6BBzvSJmW+gzD/LEZdLA+Rn8K4T+fDAjy1
 xv7+s87Yth5rpBds9YCw4tccVd2Zfz6tLXpVT7s26l9o/NYvfgi59sm4UPCq/pSku53e9XbPsyI
 e+Rcku++NJD4marKkEn7pAOndrNIR7LRNNjWb2MTBgdnFYly7NfyB3/5n4WW5uJo58afb+URTXF
 kJRfa83mZa+zcq6nwddLOy7IcLPMCYeoGQqBMmLqt39v8HT2r+SEmNZp2axRE3VpR+LjEPc8UzS
 mf49nIyM8Fh8p45ksuWgtU=
X-Received: by 2002:a05:6a00:4c97:b0:874:706d:8574 with SMTP id
 d2e1a72fcca58-87e9f0543cfmr12096283b3a.28.1790696648922; 
 Tue, 29 Sep 2026 08:44:08 -0700 (PDT)
Received: from sifive.com ([136.226.240.165]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868c0ef466sm154844b3a.32.2026.09.29.08.44.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 08:44:08 -0700 (PDT)
Date: Tue, 29 Sep 2026 23:44:06 +0800
From: Max Chou <max.chou@sifive.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, palmer@dabbelt.com, 
 daniel.barboza@oss.qualcomm.com, Alistair.Francis@wdc.com,
 philmd@oss.qualcomm.com
Subject: Re: [PATCH v3 03/11] tcg/riscv64: Rename uj-type to j-type format
Message-ID: <arvcsMKCU9XQLrNC@sifive.com>
References: <20260914000814.785155-1-richard.henderson@linaro.org>
 <20260914000814.785155-4-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260914000814.785155-4-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:3b::d;
 envelope-from=max.chou@sifive.com; helo=mail-pz2-x0d.google.com
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

On 2026-09-13 14:08, Richard Henderson wrote:
> The current riscv documentation calls this j-type.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/riscv64/tcg-target.c.inc | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 

Reviewed-by: Max Chou <max.chou@sifive.com>

Thanks,
rnax

