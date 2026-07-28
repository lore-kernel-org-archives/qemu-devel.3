Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3ACAC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:24:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wojes-0001gn-5Z; Tue, 28 Jul 2026 11:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wojer-0001fe-68
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:23:53 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wojep-0000RI-La
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:23:52 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c1c50c1e29bso565662866b.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:23:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785252230; cv=none;
 d=google.com; s=arc-20260327;
 b=LGlxzrGxZt8tHOQvfjs0pWb+uk5XUlz6fnEbx1x2yub0LjDA4z+SovNoyLbmL7fObK
 7u5OkkbQyQJS7pzujwI0VBTiPoLOaxqfE8RLKrmV6xluq47E3bOAPEtAsxmfAcYGBnG7
 BFgQ8o7/x852zHej54UB4qcd1WysFE/nfcfKApW4kKnrLzcyd5py47y7NptCUzO44rHw
 d6KdIzRpe6XyUpVCt+1NLUyogjy+sd3LjxbVcl+NEEa3e++fN9Pe8SBmK3vr9kSq7fIk
 F6v2d3NIwK7tdOxH5ui+5QokejYepOobEkVM0B1oG1uHkhlxcvs0vNvQXsnReWrvMcbk
 1pPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Ju/BwTJTrWRsQz4A/m4bJpmm3fjfHhSK8gGCKoeWa9U=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=OKpE5uhFbzHg7gzVhvch4ivnXdoICNtaZTJQn0FnZ9o7xiZFymxrlmbTydV0wNou8Y
 nFp8fe3eFRpw5NPl0cwBFJpRtxyA2Cb87qIgIVb78V3T87+VZsNGIOXixRksaXp0c355
 cU+hD3OvWdE+SUETViMjuc1YjYoUvOlx3PiOYtqmgfQz3MfHbpqnLT7Kfw9nbmDjYTd4
 2+MYHcXxzubWHj6rfcp28vSEKKjuayCL6DqnTJM61IZXLvdy3IvzezD1CNnxJKMmX6mO
 2NHTRTSNTZGj2R7bRLjaulsUt9BLZhI4LqLBEDq3m/VkCNiadxJiWEIqz3Zqd2mOVx+w
 WRuw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785252230; x=1785857030; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Ju/BwTJTrWRsQz4A/m4bJpmm3fjfHhSK8gGCKoeWa9U=;
 b=QMWEwQMRaASqrw80Tc1bOjZpSAVtW5i+mbAQ2Tfe/MHoawMVGttu35Jbfx5/kurtD/
 T+EDlc2Rg62DaWQh78EdLhi9VglkdvDL+ktcb1XwMXkZcp5O6h7pc0gdBzKHctp+Dvnm
 fc+xjpvZs+hOzmuaXhUBSwCmwzrBpKRwYdU1LzmVmsCWbrzWDOk16tUZXxPwHgzgaGJA
 zicOYYbZwK4q7szs6iA5AtsXnne9aTJxQttc1ssSRUUW2kkzurOVd21e8jkUvkwnCwTJ
 f+bhC9HRBBxA5p+UehckfRnSgxJSRJCm9ZIMvlRQvAd8yB67RG/VQRNnkb0OydwkN5t6
 92kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785252230; x=1785857030;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Ju/BwTJTrWRsQz4A/m4bJpmm3fjfHhSK8gGCKoeWa9U=;
 b=N9FnReW852dVcdzLJnpkikCRG1XT5U94UI2SrqxmQOBhVJ0P+pz2xi+8MGc9flTB4i
 6nwTfhLFsi6E+Mdi06y/yZUzywC3navX5RgKN4ArGLytLAa5cAeT0EiaMUaVIbh56Tq0
 JcTJKDWDJLKxu53pklmxXjm5OY6nWlwOxVUQwy+poy+BiPpvk18Ro+0WE2+Ikh4PixNg
 mu+hHo2swXU1+XnLfsrHrYRErecTRhimPA/RsKoXTPLTn6s8Z1LpCbIbA7fi1wM5W8MG
 ZnzXQoyU6xYrz2UaX1dDxH0uCTx2JC3rAo6NpZZqgRwSxWT/9h4nYadmMNaYz+QT6BCB
 A64g==
X-Gm-Message-State: AOJu0Yzp5c2p4A3NoJ+yKYST7MkIhfxQJOYaeh29N2V/YXYjetdPyXFl
 2gi8xUiLLKREto+sqcDL4I1nAjvWBU+YEucL5ae+sv69jIJTpNhCHOZDgfX9gQnmEGRMks9cvJx
 P0JfMm6etgZ0I5NLp+tEQ7fMELOm1dvOhN2BOe8ocRw==
X-Gm-Gg: AR+sD10pFp1LKA4JZMOEbTddj7qA96mDVMd84XpwzGhMSsrqkYklYtII9tMu17wkE6O
 x+md281a9Uh856ko5XJR2DNJcgfpCWlAstPAM/uaszVIqeVyd26JgbGG/hBUB8KPz/D2S2Tbd53
 1x1plJHP/VOReJaaLFY2oEAepwc9q93iBv7GEfo3VluWrVK/BiT23qoAT5KnilJoHTHFhFVvVbB
 jeY3TUXH9n3Bvhi7Uif7d5ljJYDaIAx7g6iaV5DTDGjJBZTtBL5iMcNOC/vbfRgUbyMAYoOqyam
 6LjKx5FeU2e/kNBRhpCKWbv57EBIvQvv8Q1GL+yUBkNV2SwaPPSRGUdvhaPo3z+JcIg=
X-Received: by 2002:a17:907:c80e:b0:c1c:25a2:45b with SMTP id
 a640c23a62f3a-c1f727c57efmr139498266b.63.1785252229658; Tue, 28 Jul 2026
 08:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260721184656.530230-1-richard.henderson@linaro.org>
 <20260721184656.530230-6-richard.henderson@linaro.org>
In-Reply-To: <20260721184656.530230-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2026 16:23:36 +0100
X-Gm-Features: AUfX_mwuY_zwTDPumOvLSmePIH4ezUKTaLBo3cMa2ve12KO4Hxt0xHPUl8w-PHw
Message-ID: <CAFEAcA-FrNMiU5WqqbXim-QZPNk-HL4a=CkAV5F65_wa1+=vLw@mail.gmail.com>
Subject: Re: [PATCH 05/20] target/arm: Split decode of BFloat SVE FADD, FSUB, 
 FMUL, FMIN*, FMAX*
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62b.google.com
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

On Tue, 21 Jul 2026 at 19:49, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Split decode so that feature detection can be handled
> external to gen_gvec_fpst_arg_zpzz
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

