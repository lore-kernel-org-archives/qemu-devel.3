Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F188BFCB61A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:45:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyXM8-0003FE-3O; Fri, 06 Mar 2026 10:44:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyXLk-00031h-E6
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:44:25 -0500
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyXLh-0001Ty-Fd
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:44:24 -0500
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-64ad8435f46so9058868d50.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 07:44:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772811860; cv=none;
 d=google.com; s=arc-20240605;
 b=TPePir+Ow7NAfHzl3Bd1c8u3YC7OmtQ3BUtRyvsuP7ZNyMCe0hKBLN9MyNGl+2Ytu6
 F3ReqIQHRazXQGyd7x7HbWqEESnSELfrs0uiMShrHX3qpsROmzi4W/Lht5ZURGqyeUrQ
 N7+0H7rbaoJdbfqmJQXhZzbp8TB1f98CMajc+GPPJO+5GKW5WijDMskVIJ3LiGosU366
 Z4PxE1O/G9adp+vREU0OEC1qFkcOAOVsfT8+5PiEf9cD5DFJj9O7VZ+h2lwgpQLVTj6L
 H0Dpiof2WBPmoBQcDrHM7RVS1gCKDwANg8h57jAZahkbZXqFYkWc4WoIrLAQgYTbB17o
 DOhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=pEgehalkeCNp10GuoaFl2X/abjVmlx4h7B5uiXqre5E=;
 fh=jUYsI/2acYShRiXxoUq/Pm9LQcAd+S5Ayx7Ab2mBfmk=;
 b=GUAgE2tph0ElS3X1W15Cx2lslWQrbURa4/9BwXbCvLq1XRlq3Fgu9cbPZMRIqmEq3e
 3FgDQ5QpTcs4R06m2O5w6kEDs4fv/QSSSLPNWqL/vqWKFaeLFlLPf8yxA6I67DCqRivn
 pafXLFbrIH6fRdKP+cSVD6hbmTCueLKBtcryv5XaDMqMIFK1x7RluwVDebAKh7YJ+KAG
 4+TGCMTwtRBPHFz0gygCcvLtaXA3dzyYF8XWiwuOR7frJJMuIBr78bRgz1EssOoeka4B
 mJHzYeBmmjCMz6u4J/f5yUeX6l2s2PZcTbLobk3mGaPTwbE3qOkCRT89m5q0nhFCZa2h
 GDiw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772811860; x=1773416660; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pEgehalkeCNp10GuoaFl2X/abjVmlx4h7B5uiXqre5E=;
 b=ZnaOcQO+ggmQ/m3U0LuIxja1ll8+D2f2j/zP4o9tZfV3pJBsBf5caF/KWtwMXbwFFZ
 7QKmZBMOe1F/auOOonXwt93/ePT7oSNzPyu37bVQnidJxTkSdEpe8Am4hDbgYTyn7TtQ
 yWnkFUn69JN3Q2tVb9EpyOiZtL6xZmgakY2KZJaGpvaPF2uhSJJLKBCJrBhPOVx+vrR/
 pEpQrPvbQgqUlnnZPbpyMCQu8AEYrCEif7ZuOZt5uuXevPyrvdIsZ0rZhw83iOYj9W8R
 yfCGbXT5zsRn3b/t96joy6BWWHzr1cfNU9Wxo6IOe54I0u+37KBES0tfsTvYprpnE6uV
 GJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772811860; x=1773416660;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pEgehalkeCNp10GuoaFl2X/abjVmlx4h7B5uiXqre5E=;
 b=JnGa208kNXT6FFO41IBTuDZBDwsLb4eQkl9QU+ugX7bt1+MJZUXC30SXnCddQ/+7QR
 UafUXFu6TORuFATs24MnbbllvEeLV9X66Z0Bprsshc5uaOt8ODzNnX+5eCFt6p5FEcJQ
 mfjJMwPeksx1hEGOoig1ZXwgPHrE4rBr0fFt4qQD36h/t0LKdVgsICHEXO0McJnCFS+4
 D8G3XWAP5cZQGZyzxnOVGT/o/k+EV4GEb09tXbAWfnuqqmxWPNebd0ivcW9shpAe5czL
 AGOMjo3pPGPFjavEGqw+SPGgzw+apfejDNcZ8rb1TBXpZi3zQbL46v0N0dODXEwukdTB
 DwoA==
X-Gm-Message-State: AOJu0YzcavHuAovxSlanLkXBzTcXKYgWuHKAIJtAAccp+H78XWpHWeHI
 sd0Lbi/rwZYeltLfJcJ/La+O/Qvu4pBTopmrZQ1aLM3nlITTMpQkHzsSB+WviBuaylzv0XcCu5k
 7XjpfRzSneBZtDMMNtZaKGlPt7T3D0cQ61mGgYISJqw==
X-Gm-Gg: ATEYQzzdyproEzRRjNKWE3juvGF9bNd3P6voBXi6iQBH8RqJ9M+5iqkg7wRti4xM/ap
 jETrZaf/qlKCoSouapfR0wkf0jNZnFPgXo1xOkk0y+2bNBSV426F2IwOu1uua1S9NgmUcu2RAXq
 qysFWN05LQneSSCAI7gs4ws0KsRZcm3HiruCPaFzN26ZZk6U+CvMhr2gBLn8oS8q0/rMbxS+hJ7
 swouXST2AWbT9kF15yH1/9RXSMS0lGuFJaxd72Rw+9AgCRqIY5msMmCRIG3FIKtieZMBAX4FT99
 OFJG1CoDeLDPXebbY6O87x9kJgwWyrQmfvd6V+880aNs3Bj6+HkBFpLurHXPJl9rM2xRdSvTYz0
 piw==
X-Received: by 2002:a53:b602:0:b0:64c:9ec3:d71a with SMTP id
 956f58d0204a3-64d1429cb1bmr1608987d50.48.1772811860064; Fri, 06 Mar 2026
 07:44:20 -0800 (PST)
MIME-Version: 1.0
References: <20260306130107.35359-1-mohamed@unpredictable.fr>
 <CAFEAcA-e4GZB_TRG7Jm3O-RNJneUtk_WufiXNn6=UDHsgG4kdw@mail.gmail.com>
In-Reply-To: <CAFEAcA-e4GZB_TRG7Jm3O-RNJneUtk_WufiXNn6=UDHsgG4kdw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Mar 2026 15:44:08 +0000
X-Gm-Features: AaiRm52O3QsEtKOSRK7EBWX59_vg_qMWiqyyqakDBp4BtQoNNqFRBsOcbaRg_k0
Message-ID: <CAFEAcA8gB-36c1TvJSwJ0MkVMy5z_dqKpVY7KTJ-cMV5rAX1_w@mail.gmail.com>
Subject: Re: [PATCH v15 00/17] HVF: Add support for platform vGIC and nested
 virtualisation
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Cameron Esfahani <dirty@apple.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Fri, 6 Mar 2026 at 14:58, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 6 Mar 2026 at 13:01, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
> >
> > Link to branch: https://github.com/mediouni-m/qemu hvf-irqchip-and-nested
> > (tag for this submission: hvf-irqchip-and-nested-v15)
> >
> > This series adds supports for nested virtualisation when using HVF on arm64 Macs.
> >
> > Reviews would be very welcome :-) It's maybe a bit unlikely that this will make
> > it to QEMU 11.0 I might as well try.
> >
> > The first two patches are from the SME enablement series and are present for the
> > series to be buildable on its own.
>
>
>
> Applied to target-arm.next, thanks.

I'm afraid this failed to build in our gitlab CI job for macos:

https://gitlab.com/qemu-project/qemu/-/jobs/13388426185

In file included from ../target/arm/hvf/hvf.c:489:
../target/arm/hvf/sysreg.c.inc:174:21: error: 'HV_SYS_REG_CNTHCTL_EL2'
is only available on macOS 15.0 or newer
[-Werror,-Wunguarded-availability-new]
174 | DEF_SYSREG_VGIC_EL2(HV_SYS_REG_CNTHCTL_EL2, 3, 4, 14, 1, 0)
| ^
/Applications/Xcode_16.1.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/System/Library/Frameworks/Hypervisor.framework/Headers/hv_vcpu_types.h:312:5:
note: 'HV_SYS_REG_CNTHCTL_EL2' has been marked as being introduced in
macOS 15.0 here, but the deployment target is macOS 14.0.0
312 | HV_SYS_REG_CNTHCTL_EL2 API_AVAILABLE(macos(15.0))
API_UNAVAILABLE(ios, tvos) = 0xe708,
| ^

and similarly for other registers.

I'm going to drop the last 4 patches from the series, which I hope will
fix the CI problems.

-- PMM

