Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A78CCA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 15:55:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBDhV-0000XG-Jt; Mon, 28 Sep 2026 11:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBDhS-0000S3-U3
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 11:55:30 -0400
Received: from mail-yx2-x11.google.com ([2607:f8b0:4864:41::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBDhR-0006DP-E9
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 11:55:30 -0400
Received: by mail-yx2-x11.google.com with SMTP id
 956f58d0204a3-66e4aa8d881so3176936d50.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 08:55:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790610928; cv=none;
 d=google.com; s=arc-20260327;
 b=haB7s6Inyq3jxKuR8q09oxrWKcBk1IuMMALs3VwEyUnphM3PwhAfyOF2FQdDaCY/qx
 u7DP9uvIZjvTbluUL8Evcv9+2YjQcD7gZX+h9Odgzuo+KBRDx6rlMSvj0Fo2VG6vDOdx
 U+VWTovNfBqIIJK4A9jIERP68Y0LoFat1QBx98cWQgdRDKoSGQCHAyD8DHyLbP2YK9Jn
 vpQXmI5uZz2LrWkglV10kO8Wu8gqX0B4XwZBeJ9pbqGCo4aCBtGXZs3riktFVVHNfW59
 ZfpSRUfGdH8o4lTo2dsyhdH7PyTP6AjbGyjCq7//QdcXmatXe+G2ZmU/vxkESVezOoIg
 R/aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qEhnR9xm4iKIjH/9JsEUOpJsPRWZSCxoPNER30ttDt8=;
 fh=i3rBYYijT2aYETyU4VvPNoz9Z8DK3pW4GWvZ1JKSgwc=;
 b=Vam9paPBl8N2eNyuXpbfqnoAfv8MkfJbvs5h5WoAbQirKM6X1gVT0iq8mYomqmnNdg
 eMr5RR+Kh8M/Bsn3a90W6QvXz4RZ8m5uKThc6YGW2FfE9/EuxzGWrsiHvCYcgxWxCvJa
 KHN8g5E2/GaWAOuPeiFWJl06HGghn4XN5Ebc/+E8aK8wDzhEw/NJOlUalGlUEoaJKand
 inlxC84aNXQicKDC9kJ1h3+zmqV0/NkH228NHJ2IWlwV3jjovgEiMFVY23Z3LNBJAx8+
 e0uP0ShJCJRCib170gQ998Xyy/+0ixGcNFP8951U71OdgqNZRPAREVoQ6VdDlKv2fHGm
 owpw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790610928; x=1791215728; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qEhnR9xm4iKIjH/9JsEUOpJsPRWZSCxoPNER30ttDt8=;
 b=ajaASGykLVyYwjwrM2YIgq4W3ZBiIR+Sfy11fdMQlYPCKXhPHgsESbUi4Tab10Ke6+
 +cb/4hmKnJsyTf8RODBfHy7n8z0bnmba8N3zTfpTGbDMQajcT8dmOYzUiouEIMCPtX3L
 3DbKGzL5zkerN8fqMnwwKseXt5x7NUGeGPYwymdRKoEassv+Q/kxCwLkovB6t1Ln3oXV
 thpfAm3oVkAU+0CSAdeV/Xp1LKlwr5mqfGyHbVG1Wisrw5wJuY01FHdC35KcntScQXB+
 49Ih3sbl6R7rheOI8EXT6qimlcXBIfSV8TO+yVnepbUBVuXg3J3RFwKb5XSmpMzY51Xf
 ysZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790610928; x=1791215728;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qEhnR9xm4iKIjH/9JsEUOpJsPRWZSCxoPNER30ttDt8=;
 b=sT3el/WjN6cGftUe3SRW7T+fnASJ8OAlba82G0qaOw1DmxY9ZVgrWwUG7TSeUZyYSo
 j0P9cnCWe2xNlZ+Hb9HXFrsP4i0rZHU4WLS1zqOEOfliU4pqHXkRTARrt/1VMAgNGmKa
 Fahhu+N9hYJuRLpOjozohjM1zvukgL33tvRnbDQpApRrn2+YJD0BRqhBLtsRso+ZGWe7
 w+pFvv9j2O0PmrElorqvvrymg5ey0Ha821gfMnlUO9dDgXCeg7eOPchk3S8lTAnDOSlK
 PUy3nLT3cMh7L4hbVPSLnw9R7q9b2IhnqVpSCWb5jo9nO17kthPzr8RGyJSPn/hvxg/l
 GPSw==
X-Gm-Message-State: AFq9FYJZ3TtzfxhXX8S2jxg3mfNTdGC7LCUz7Gp4qzgw6i3A5ZMXxOCz
 we5IDoGY56ltnHGf0Bq4Qy+cp4WVKQnzYJSyYxi3ftHXWjo7HRs57jT1TK/2VxV2lWuKqChpzi0
 o6hpHev9Gq/uLAZckZH64xI7IEk0VeTskDM8/nfDsAw==
X-Gm-Gg: AYBFou0a9UXjaBWtLWf8VvuMnwgKd9p1dDbV3kPCwjSiuGrfhVTxyC5VO6Y597TwDd8
 Ge3iFCcRRehE43i7yfLteKqygOG6rrNnyR2d+EBKCDZRlPTvCxoWenK8Djg7ivrx8QL8fWe02sH
 VbGpBlCvDFDD7iDt9AAfKjmpMmbVm/dXEmnhbkdCxnid611Y8CFK59nI0AMTXwWT02h8N6QpLgz
 CIVCLLqsZ24g62jZ0haSv9AMYHCL7ak1rGUKpeFzMjuvasvL5V7PPTBYhUBp+M1q3OwYImchWZe
 ucMpUwQeln357vvKmpUNNOuevvVOgv070FsrkLcxVP4KfM4DtfHuZwE4RdLYe97FzKSEnOfhrR1
 Rf4o0pRwd3EWmnd42Xhq1pn078EWLSPJCnZzsQ+o=
X-Received: by 2002:a05:690e:1246:b0:675:3b5b:3c4 with SMTP id
 956f58d0204a3-6753b5b0461mr2399674d50.106.1790610928180; Mon, 28 Sep 2026
 08:55:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260904043742.96613-1-mohamed@unpredictable.fr>
In-Reply-To: <20260904043742.96613-1-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Sep 2026 16:55:16 +0100
X-Gm-Features: AclHuK9kFQdVBSG5yzS1c6px1zSdv8gwtOzojkky-v-5N8O-sWFO7p8YK_Wlp8E
Message-ID: <CAFEAcA_mfey4ue_6vgBFxihnBXryKWspujyp43YYXf_XuV-CPw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] hvf: arm: add experimental VHE (x-vhe) toggle
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>, 
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::11;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Fri, 4 Sept 2026 at 05:37, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
> macOS 27.0 has a pre-release VHE implementation. Add support for it in QEMU.
>
> The first patch in the series is an independent bugfix that should be backported to QEMU 11.1 too.
>
> v2:
>
> Add:
> hvf: arm: expose E2H0
> hvf: arm: ignore accesses to CNTKCTL_EL12
>
> This is to have working KVM under the VHE configuration.
>
> Mohamed Mediouni (5):
>   hvf: arm: advertise ID_AA64PFR0_EL1.GIC
>   hvf: arm: add experimental VHE toggle
>   hvf: arm: advertise EL3 support when VHE is on
>   hvf: arm: expose E2H0
>   hvf: arm: ignore accesses to CNTKCTL_EL12

I would prefer to wait with this until the interface for
VHE is not a "private API you have to get at by playing
games with dlopen()" setup.

thanks
-- PMM

