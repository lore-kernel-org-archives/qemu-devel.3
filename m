Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 308AA10A88E5
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 14:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w67ue-0008Fa-Af; Fri, 27 Mar 2026 10:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w67uc-0008E2-9E
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 10:11:46 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w67uZ-00069H-Me
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 10:11:46 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-64edb56b70cso1971575d50.1
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 07:11:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774620702; cv=none;
 d=google.com; s=arc-20240605;
 b=C1wrTsqaWF2XvSbGFdy9JggRojhceuSZJyJlRpTJFQ7Ximm/iarMZwJcbHE2o5nbHc
 fjmpMRaYwupvQmHiTGRizh5k9+DKpCipdhDmByPdv5c/Shnul1A3O1YkNbs6D9i+dHA3
 dFsTIGj5gRAFBzuLGiBw7H6gr/z+eH2Qva6kdoALZmCplQ13Odcu9BoqZcr31zeWzepp
 63/SktwCm7Hi0MP5g9KeYxHiUIcX9wt6kymrpWyXI9OW8oquLwKZvBQNu/b5swVOpWtk
 RdJ5YEdTZvtn4GcHhav4DOpy0ltJdOmkTpLpwX2r6Nz+v05fJUU5v7GJWfRDCvydQgCR
 WeLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=inifQfQgIY2IYfSgHyyln8KaB3fVOElqWi8O4mM7icU=;
 fh=ePxBs6Dyl6DVmQk2hM0BAX4+LAi88Kra5BTfysAUTkU=;
 b=F9Q1ctOG5Iy9j2g75A2oQrxEF7xODn+7ooCKse0m7mVWac6/V7gBhdlxP8rSX/S/6I
 Bi4jYXgdplvf1nEErq6/4I/Uj7L5Orq8jIbRn0k4wngmJ8MlNY/nvDxdU/D1lzpMlvt9
 knXBo4yQ1N2XnigWSbWDSQMDi1zLFe+8oKLdBGkiXtSFIcuVpVXEDT902MygGBJtcIph
 6iJ/F5vyum/o4kyawQBXhNoELtIZIqLv2eGGiwd85Oh6jc0oDi6dhKoSHRxwxJeKuft/
 a9O2nzzFct+tJwCqg+NK0/ehn2CjWPPD6o0ZWplX8Ne5X6WqLkOnj5ehqTfgmySYvtc2
 EAhg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774620702; x=1775225502; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=inifQfQgIY2IYfSgHyyln8KaB3fVOElqWi8O4mM7icU=;
 b=P+xVbmovlhjv6g/sDtSzKdUD6QyCva4EObkdh56z4cSgeC9Ks8kSmIVapBT4RhoKOp
 zVhoR6OgUlUxf0jSV/yhzgUKMMFG0oLLdkxRa9tlQskM5ERpiUpya/xzSwTHhamQwmNs
 T4S23egkcPbjFWlysu7qeQpja4oU/fduuaJwIj5ABYJflbzatPvj3zuWnd3aT9z6k4u0
 s3GEdIbwuN5rGt9Nlm1aDb8lW+2y0TdoUVoHqwQrS8UViXfw4GBLWYtRRUF0UA/urs2w
 jbTO4csb/Qaf3m66JCKzRA8kTN+n+ElSNLf5+NsimlYwj3fudXiMC86C0I5s4tx98T8r
 nPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774620702; x=1775225502;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=inifQfQgIY2IYfSgHyyln8KaB3fVOElqWi8O4mM7icU=;
 b=lf+BFrMJXjDJB7D8KWeyOg3NldmboeF4sUcb+aSZM3FGDj2imC0hh8FDN16lBf74Fz
 iJ/cpszVwFmXlVH4oj12MPwvJ33v5NYDsPE5AvXKaWlisrOKSnFGKTaZL0B3tCsCEUKU
 lztkGKYcoIIaaSRJnxMTIqzrMfL6V1cb6bigdlVbLvCCZIXh25dp7bBN+n1PNw3iF4mj
 8up46OOD5V1hMT7C/0CbT93y8UeE7xyT7owemDGj7dkDsFgex/yFoqg/hBLpAdYKyLI9
 qne8vxQhD6QntRN6t85Y57M2LGL20ve6iDFbcHhbfPEfTa1iqS561dbvnM4uGnn+Mlej
 pHeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuQKT68Ua3WHGldbhSwwmp29krY4m4h0Kesi6/Hii7DEpbvk3LFm05TlMrZV7i5/idCqBQguGN9o+j@nongnu.org
X-Gm-Message-State: AOJu0YxpuSSMLThS/Y3rQmM35u6ZTpd3YhxPvK9TdGbrPrK2qPrYlRrZ
 W/rbAsj+Hxrmpp0TasAhr+WGcfOul+TvSmQDr8xcI6fi9DINPxkbfo50mxNWRl3+TEigI6B43tr
 Cy+a4OWntBkKs/YfaVeqgVu7FZnLalQHLo6RvUukXUA==
X-Gm-Gg: ATEYQzyFIxU2Dga7j+YBxibingnOvc+ey4JFr5U+rKypknEOa07IRmbAc09aYAXyDRp
 gfTrUi3/4XFqczRjBeScMvXlIBjSvfeDOrgHSyQmrtuHX4PyqO7RpCy5Acyog+WGLwcqoC/dDIS
 J22wRqi7FWhI+j6sZ75vu/DuxQbXcla82jtozWi7Lihk8eW/JgFxIOxjqCYWGCuyGvNUi+KgHQM
 wMpyP0SvH9c1X1YFgFmPBJZsbLZlJxoz/hI5Z95yRj5w+2qAMIhTvJjQWFkHTlOcWFGVC9PY6PV
 R9StMd4fbOt4sZJ27VuL4jeoji6GnQZQzG6twN3COKS5ShDf3amb+IaNc+OR/LlGaf4=
X-Received: by 2002:a53:e101:0:b0:64e:f106:60f0 with SMTP id
 956f58d0204a3-64ff73cb80amr2139268d50.51.1774620702415; Fri, 27 Mar 2026
 07:11:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260327134401.270186-1-kkostiuk@redhat.com>
 <20260327134401.270186-4-kkostiuk@redhat.com>
In-Reply-To: <20260327134401.270186-4-kkostiuk@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Mar 2026 14:11:31 +0000
X-Gm-Features: AQROBzC-GF76seJ-pj6gXNfAn4m1CsFefNOgqbZYHJStea0S2XWUlyeb6quiHgw
Message-ID: <CAFEAcA-41M=AbGfk1Puxz_Tu9_mD2G1H-1h5ConJvcS4KCbOPw@mail.gmail.com>
Subject: Re: [PATCH v2 03/15] block: Use glib2 instead of
 strcasecmp/strncasecmp
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 qemu-ppc@nongnu.org, kvm@vger.kernel.org, qemu-riscv@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, 
 Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Fri, 27 Mar 2026 at 13:44, Kostiantyn Kostiuk <kkostiuk@redhat.com> wrote:
>
> This is a change in semantics. g_ascii_strcasecmp() doesn't honour
> locale but strcasecmp() does. But this is OK for at least one reason:
>  (1) QEMU always runs with the C locale so there's not an actual
>      behaviour change here
>  (2) we want the comparison on url prefix and it should be a plain ASCII
>      one, not to do weird things with "I" in Turkish locales,
>      so g_ascii_strcasecmp() is better as it's explicit about that
>
> Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

