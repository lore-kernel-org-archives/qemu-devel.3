Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E7FC9833F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 12:40:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBAeY-0008H8-K0; Mon, 28 Sep 2026 08:40:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBAeV-0008Gc-HY
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 08:40:15 -0400
Received: from mail-yx2-x11.google.com ([2607:f8b0:4864:41::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBAeT-0001c2-Ty
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 08:40:15 -0400
Received: by mail-yx2-x11.google.com with SMTP id
 956f58d0204a3-66f7f72a284so2727808d50.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 05:40:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790599212; cv=none;
 d=google.com; s=arc-20260327;
 b=JFQCyPzGxIT/UlEorT2qjF0bPYUN8mK5fzMwkikUgtLejYrV4Nbz+m7SXeDhSoQcwY
 ywzIhExSmzBeDFJVLKghJnWDMYMYpBYATQNobfKVr6CQf2/5FXsnrOTI2WkS05z35HUt
 3BPuPkIYCDzSVduHjhW8Zhd//TxWRPN72QILYhg7DpZelVMoBRM0uQ+/4VqgwGXI5t45
 6eyWpxhriHQtqpnjFNLso4P5lpPoh1hrwNsvnaWCXcqH9jxs8PX6FuzGbjoYxpcTzgFe
 tU/M+L5wp1bVz8a7QyfRoaFx3K8DMx0NsCeC/sJilIzL4hvn6ao7T6xoy6TGOLDJp0V+
 RZTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LdGySBYbOYKph5JsskUEBkD0MZu/44MTdod1AGtx638=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=ho9qy5qPjKFDTX0FWXnAuttfRU3hHx6bGp4kQmtXTgaYQBk6wNKoLffhiP6+rAi6+x
 +aj/aAvISOvSFZWSn4IYh/OtPaK+x8CoFO9peE3xp3fGmDfxzJr/7Jq7CJ3nmgZYKI8z
 7VeNp7q3D6erFkSFlmxX9XBdfr6KjJn4cXR2PkkGyc9TXycL/ZxvwGJCzdUgsL02fU9P
 JPPbYoP0DkY5RMZ6dMVdUUOkTDBrpnBbmZaczVmQKcpVHrQI0+jMeADH3ye9TpvbABr4
 /G1E4rK9xgDvlDWDjpoUjdkJnxIu3MnhCV+LSGjdmyF8rCByON7cUVbqJqxEpN51Bpr9
 B4+A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790599212; x=1791204012; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LdGySBYbOYKph5JsskUEBkD0MZu/44MTdod1AGtx638=;
 b=gfjDLRWftoQRHbz7XHaBOn8ECAK7U1/6XvZGtaAGOeiEz6R63wWz5TMnLTeUaAZWxC
 uyqasq57LD0qbuFkcccppXz3z/kZhawswVM8RLBo4liH4xhV52a1jheFzhoHlJ0ac177
 N/30YEsM9O0QcMoPZT3N2ZLn+mAIhInu5UmfEn9wYJvkNwQ9W18CbEGTWASkaDnnEBUt
 33WNwb4R0Nbe5NmtLyQZlPOr/vT9o/35wzw6Iz2zBhl8eslzbb0K40M25g5lYlS5V/Vv
 otlbyEI3SN5DCRfi2YB51nkWk3J6VEjn8lRrw5jdcpvlgy4Gl3XEgOe0iHRfAfk6bKko
 25bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790599212; x=1791204012;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LdGySBYbOYKph5JsskUEBkD0MZu/44MTdod1AGtx638=;
 b=QoXBAk3uOKUbjUPljzxWdjKAai79oGamBL2pv9JSDEHBYulP7OkWHdfRJle1/BGNZO
 CZwEKJljfYCd4wmAO4ehcwKPeJ6iOrcDX2Cf+PyJFF6GamZm+q9dFbw3nES1ybQb5jnU
 6+GXdTfhBGH7GJR4S78T9CfRyCzyL2d73vXbd4LreBnBmgk5Hx2NfpBl+7ZHZaAUVF/x
 Q2NTcrngetOn17H6Xt/TLZw/0Z7quySOUQQeDU4zsyAjnO0xxDX//dSy/mBxEJgpV68w
 nKw4ewZKzIdrP93YQU/nUQfsT+nnSpxRlDIs8esC1k8uEX5xtsOQoWqflCexnKcdACbG
 6Mjg==
X-Gm-Message-State: AFuF++l1bgkMUFLp7zqGJ2T+gsJg8MYPA4CWw4FKYQju1sQsTrXtXLMK
 yPItwpO9sLiY7DsbhckgvhoV6qctC3SQUr46SF/f2djxOCvTc5UvWWbpeALexGeNCipCjLMIOm/
 VyYyF5YXg/ynTi60SgVK1KeTayYYWQMU3hZVvESDfbQ==
X-Gm-Gg: AYBFou1vmN5mmfks3KGYfvG2zxj+mptgPk3BnSFUPJ/SRI6GimTiCT28Tzfgs1v4mmh
 WRvv9f+cGGykPiUmrV7LcAmidTPktUSRp5ICU/sODVE+eZsUmwdHCP6uqfvcdd8/IdxUu1RV/1f
 ZfCl7exbkagrS2yKAvCLTfj+2O8JD7IH6NXtVL3RKf4BM3bDjN2yVMwDMvUfu9DRn4Z8W3g4bIL
 LDJzd2/s6jBy75YenaFMpRSTWWRbxDSU3xykyk9iXnE7Hp/MBHsPGA8BsZDjivqQvIrEFRD78w8
 NzdSXC0HOTpmhe9JiJj4V8Rh0d+RrVDfgY1evzFuv2eVyRftcJCASCPOerobLibjzTbFgkpKks5
 bxlpeDojWig2A10APsZBuuunC5y6ht8FA2Edk4YA=
X-Received: by 2002:a05:690e:dcd:b0:674:1e7a:726e with SMTP id
 956f58d0204a3-6741e7a749cmr2510729d50.9.1790599212230; Mon, 28 Sep 2026
 05:40:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260925162632.404001-1-richard.henderson@linaro.org>
 <CAFEAcA9GAqVM-G2EYrAcJ-xcAQUoHgGFVtkcMfaYYjG_78uetg@mail.gmail.com>
In-Reply-To: <CAFEAcA9GAqVM-G2EYrAcJ-xcAQUoHgGFVtkcMfaYYjG_78uetg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Sep 2026 13:40:00 +0100
X-Gm-Features: AclHuK84eWWLT7OaNsIKOIYTfHBN2JmGxWQrAziilKtyXU52dOdDSwMF_y4FWw4
Message-ID: <CAFEAcA9UGyZQDmuSWPfx5apVzrfYU2oBG_SwREyjUJ59OTb55A@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] target/arm: Implement FEAT_IDTE3
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::11;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x11.google.com
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

On Mon, 28 Sept 2026 at 13:18, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 25 Sept 2026 at 17:27, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > Changes for v3:
> >   - Drop helper_tid3_udef_el1, because the entire tid3 space has backing cpregs.
> >
> > r~
> >
> > Richard Henderson (5):
> >   target/arm: Rename isar_feature_aa64_idst
> >   target/arm: Enable writes to SCR_EL3.TID{3,5}
> >   target/arm: Implement SCR_EL3.TID3
> >   target/arm: Implement SCR_EL3.TID5
> >   target/arm: Enable FEAT_IDTE3 for -cpu max
> >
>
>
>
> Applied to target-arm.next, thanks.

...and unqueued: this causes "make check-tcg" to fail:

119/216 tcg+tcg-aarch64-linux-user - qemu:aarch64-linux-user-pauth-2
                                     FAIL             1.11s   killed
by signal 6 SIGABRT
137/216 tcg+tcg-aarch64-linux-user - qemu:aarch64-linux-user-pauth-4
                                     FAIL             2.11s   killed
by signal 6 SIGABRT
177/216 tcg+tcg-aarch64-linux-user - qemu:aarch64-linux-user-pauth-5
                                     FAIL             2.94s   killed
by signal 6 SIGABRT
183/216 tcg+tcg-aarch64-linux-user - qemu:aarch64-linux-user-sysregs
                                     FAIL             3.63s   killed
by signal 6 SIGABRT

because in linux-user mode we hit the assert in patch 3:

Bail out! ERROR:../../target/arm/helper.c:5974:access_v7a_tid3: code
should not be reached

thanks
-- PMM

