Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67FACC5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 14:16:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyVSz-0005ya-N9; Mon, 24 Aug 2026 10:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wyVSw-0005xz-Br
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 10:15:58 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wyVSt-0006rK-HR
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 10:15:58 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-66d06b5f023so1573396d50.2
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 07:15:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787580953; cv=none;
 d=google.com; s=arc-20260327;
 b=qFVDfLFSMYs8VNzSNK5Yr4aqgY9ZYeDoU9MFrljIEJT6ONGS3ULxOPKYljGzIGlkCv
 XCZPcR/o8YIkglBHXmxEZgKvF/vsYs5kLa+CjpvgTN4TKnUmYHaWPFrANx8UMjpZziO2
 BhZI0QbR4mX8hG9MvDcxM/tvGy6yyQJ4ihk1dtLFLU4go+TSHdYqurTFBM4FC2weonwJ
 jfDQrtfT+e5L4XV5YQ3nECTswkxIzDWfwsuYsGQ90uCf70BQEKh+h76oznuYt6qOOv0F
 N0yGuZte+6qXD8x+aHbYtlheWoPpaszriTEhK7s1yndJtUyhi8RjhVyqmU8TLDAHmbso
 YFbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bOE19ddvt3OiBdu36MUo3HBusa8hq0RDUQcKaDJOVPg=;
 fh=RFUZr2g0Shx/zBEdYDZ12ZgHpKgJjBHF53h2Dsal6O8=;
 b=ZlCOHCXNT01Xw4509QvXWJWkRhhNj4VDL09Wj0HB8jR7gbbc2NrM/MNsR+5xRYMx/v
 2R/uWDKtUS7rYi5SW4n2lILeGFydRpiZNxO9lQ1VsGAjt3BzvaP9iYF5lWM9eWYKZ4LF
 Fhsat3I5awtXfKqIQHeDUVAbG8eGiRSOIgqq3m1zhiusdYJ4e31V6knzEYXaIPUxAeGW
 pSoA6sT7XmiXJ/rquGbMzp23voVm8bGedfwKc/rPu00aTUpbgfWBB30lVp+TPZgy9PLZ
 XRxaaDThEiUt3m5IghZxOTzOLs6gnSVoQLoUru8Ws+BdQi6dqH1O/ommXRE4/Ei8MQ/b
 MHzw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787580953; x=1788185753; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bOE19ddvt3OiBdu36MUo3HBusa8hq0RDUQcKaDJOVPg=;
 b=nGSs81BxnkggcsP8tpD4VcmDSzwCJ/2mb8cZjwGUKuA4PlxydZc0EA/eoerFpUSOj6
 3MlJrFOkIDUzDrARdwRjBdQWI4L6IrkNLIpJ1svLNFnzkLSSkUkSVuHzj/KsxmY0Y3Jz
 ytnpXbjT+uvCgoC9k7xk0IXtdfG2X79kF2tBos3TfZxDnN6e2Q0K4Mez1JF0ccqRcpJU
 VGXjtX8GxbwvQyOH7pas4VlzZrQWyOPHSp7eaNmzHCpwuN9TIfePb1yC00d946PlAcO8
 1r5UbWVaX7OXGmuHy54kBEmZveZbJd1ac2STinfSefL3vOcAlSAaFeVYG7SIkWLn/NJh
 wyRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787580953; x=1788185753;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bOE19ddvt3OiBdu36MUo3HBusa8hq0RDUQcKaDJOVPg=;
 b=UKQeDDH5iYPcv/H13vQdVmjkq0LszESAJkkvfo7tQB5oCyT2/BcrOZCDtv+ACXS/au
 LxjLpnSDSEaMig5NcMEz0HfNBi0vbtD+1AEfP1ekgF5Z6aJG4pfLbsffdb8ALzKm3uKk
 7y+vqIynKHun6Flo+DKOzKOZE8olHtFv2LTIbHsnmAEoUXnzog5cPY3WDwJPiSwBHdVj
 i/DhqqvT5uNYirUWAQp1og9Frk13pKdXkhlYQLw9p2u7Eg57f/SZXdX4+nArEysw0u9m
 vz17PjMgjtw5lKmCGdZVx4+wBSSxzDlNbyYpd6TIb5MVDMm8ATPatFXqTrlJhhVoKimo
 K+Sw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrNG8HAhwC8KR5FD2rVPAvs4WOEPYEW/ybETBpyD9DYbpzbCgTxjQ+3/4Lo7BXkQrVPEmoYcmY4EWRz@nongnu.org
X-Gm-Message-State: AFuF++n/8u7/yvo07oymjsn1gTdVDSNfqtBaAOaIWuWUm5CJjPd7yq5I
 z4M/zC8Yc54ue3PWT9WwIW4bzKgLQgi0yV1Ik6cqAYYPVxDXp3YdHeF8kMJovTu025FOe8J6/fm
 sv1oe2HRpaHQSu5N2VtrCYbSHTBSowPuIg1PFlcmTPA==
X-Gm-Gg: AR+sD124rwHZZfNjYzAZOn6AmkpfIYAjStbg2lpSgSI/oIlQm/kLgbN3XjTEW4FmU0X
 KhTCt0EwK2FHD7yyYOIiS7ZdqtRWtr/B7Ux5nuLvtHzw8d7kxiN87aIttl7h8N7ptxpISGQB59n
 p3h6p2vso1NZk7afRUgmUZafMKm6Z6QU6KqVi7awefGIeVcMm2cV8Yp5WA8/jZBPGzDxPwy9o3m
 3SyBnMmlauceVoDWhAWpp6cuXGbhzjwI2LhPvlePFW/WIcAHmDmdJWLhQi4viNlOeTXlFD4ia6N
 CWxkVANd3goPewJ3zsii4boKdOq3X/Dg7pF1v2qQgjiIz6SF86o2zFlU+ooqTplSrQnVwQtMFVq
 dApvklNes0w1hgAbBHB3+WMyGRTsD
X-Received: by 2002:a53:bbcb:0:b0:668:8acd:14df with SMTP id
 956f58d0204a3-66ce4b8d8femr6465718d50.54.1787580953113; Mon, 24 Aug 2026
 07:15:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260824102805.639072-1-peter.maydell@linaro.org>
 <20260824102805.639072-6-peter.maydell@linaro.org>
 <03dfa51a-64c2-4b79-b524-2bac3e53335c@oss.qualcomm.com>
In-Reply-To: <03dfa51a-64c2-4b79-b524-2bac3e53335c@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Aug 2026 15:15:40 +0100
X-Gm-Features: AcwNN1XIdjJmFRvIiK6phJWJ4XpuAWCRNEG52YayHrDMB-K21_FpubgxphzL82A
Message-ID: <CAFEAcA8HOx3nQN00LTtqRVLqBGuQTT8bu7gaSntJyeot=hzcHQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] hw/intc/arm_gicv5: Free memory in finalize
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Mon, 24 Aug 2026 at 14:55, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> Hi Peter,
>
> On 24/8/26 12:28, Peter Maydell wrote:
> > The GICv5 allocates memory and creates hashtables during realize and
> > as part of its operation.  Free those resources in finalize.
>
> Why not in unrealize() path?

No particular strong reason. Do we have some life-cycle/style
guidance on when we should put things in unrealize vs finalize ?

-- PMM

