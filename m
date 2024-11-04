Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8BF6D1BDCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:17:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80hB-0007NN-9o; Mon, 04 Nov 2024 12:16:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t80h8-0007Ml-Px
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:16:50 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t80h2-0007FL-B2
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:16:50 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-539fe76e802so5236473e87.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730740600; x=1731345400; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rFdMFrYFoj15tqQwMYYyirispPzAR+g2+flXApqn9fs=;
 b=pQt9y05zoggMIRq9tAbFA1R/+R8OEk6295YTWZZDG0O+wID6AA4bqqPjeVx2E+J2Fm
 ezF5p/tDR/aoEbj3OayGUGCvcGCGfHpQN1o0JusNpWYCsnuimaMjjWV1sxFoHhjpNJrd
 Eh/K6PW5FS9X725K3E8y2YRIVREpIKHoycCwCdPTkdunlqeKe9BkyZRy8iQIc5aY+jmX
 GVEHpjH2lYWBvuP1NE9KL4G2QfjKAdPRLK+3Cz4sn74qJSrl/syPzMpzpqYSORe3JLJF
 uQOAwtq19HoaLWZwpTnC5nF2asUKIhaYtX6vBn6xMZqk8jiMNZrCPfiguBGbhN2myYdl
 DNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730740600; x=1731345400;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rFdMFrYFoj15tqQwMYYyirispPzAR+g2+flXApqn9fs=;
 b=TWsCfBmSc7Y5XCJdpSHq79IY8JJUQ2ORTRxcYqyRZiDl9C3yQlfMtNDS5t+mPSt/dQ
 w5S6aw19Sa6U2iPFUizaI9jNNTtBAAQacNZ0QCekPli+pLe947SQ0eICwUzcUEBtJZM/
 AswUpK7O5BDJZuXVpWOpLZdlE+cAV0VPyjlBCaLsRs/SviWSGH19Dbz3S9+6MyoYd79/
 5jdN061Wfq6sY+l9HlDxaLBcZdSfhLwGBVna3znbq+22tNmOLj8pCO/pXe6NvnBu9e1Z
 Tn3E1E1HA4bOmw3mAwpueVLdP5vCF2XMxKFTOFwzLXX8AbCnyzmBAc7QG1VTCWC02LK5
 Cqfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVes3H/wjAacMh8Ngn94S52WbG2gGtsg9URTuQ3WKJHSxUFh051QwpkZQJqB6+vBT4hpIETOUgDk6Y/@nongnu.org
X-Gm-Message-State: AOJu0YzUPgXJDvKRbu8P3xA6RQ7D3lUl0CZ+9SksPnhglCiwPqcDmGTC
 l6I8XG83VIa1vJCrb2veVIigGZVLfOXLcbLhMxCeP1+mK9slU51lzzROgRKbzRS9WfjaKzTUlfE
 PiNlaH/xDQA/YdIGYky2twoB1nk/4ZruOMPlCQw==
X-Google-Smtp-Source: AGHT+IHqc//LHND71HOSioZxH9lExkg8+Iw31TJF5rdqABwfBOuOfwCGbLalw9AOmeFTDEbdLaw1Qkagq/4QeWTPqk4=
X-Received: by 2002:a2e:be08:0:b0:2fa:d9db:7bac with SMTP id
 38308e7fff4ca-2fedb757365mr58358051fa.3.1730740598449; Mon, 04 Nov 2024
 09:16:38 -0800 (PST)
MIME-Version: 1.0
References: <20241025101959.601048-1-eric.auger@redhat.com>
 <20241025101959.601048-19-eric.auger@redhat.com> <ZxuX4i9NjVRizB72@redhat.com>
 <cb6c8f62-c5dc-416d-865f-fbdf96164dac@redhat.com>
 <Zxub7ol4p8P_sWF8@redhat.com>
 <CAFEAcA_wQu17y0PyQwxw0wuf2H5y2VE5aX16nLP2-u7QUP2ggA@mail.gmail.com>
 <Zx-9WxXkmkMuGIlQ@redhat.com>
 <CAFEAcA9w0mb5bcU8p+fScQony-=oqLmNurGWpnL_sBneQCzxUg@mail.gmail.com>
 <Zx_CU9eeQByANMRW@linux.dev> <6c05fc4e-ce14-4000-bb2a-63496bce9e98@redhat.com>
In-Reply-To: <6c05fc4e-ce14-4000-bb2a-63496bce9e98@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Nov 2024 17:16:26 +0000
Message-ID: <CAFEAcA_XhkBrco=V3Ky+cgvyp3cwqHXjDkmm+dP7N2B2av03bA@mail.gmail.com>
Subject: Re: [RFC 18/21] arm/cpu: Introduce a customizable kvm host cpu model
To: eric.auger@redhat.com
Cc: Oliver Upton <oliver.upton@linux.dev>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 eric.auger.pro@gmail.com, cohuck@redhat.com, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, richard.henderson@linaro.org, 
 alex.bennee@linaro.org, maz@kernel.org, sebott@redhat.com, 
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com, abologna@redhat.com, 
 jdenemar@redhat.com, shahuang@redhat.com, mark.rutland@arm.com, 
 philmd@linaro.org, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12c.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 4 Nov 2024 at 17:09, Eric Auger <eric.auger@redhat.com> wrote:
> Was just wondering if all the writable ID reg fields were associated to
> an official FEAT_ listed in this feature list.
> Let's take for instance CTR_EL0.DIC. Is it associated to a given
> extension or is it just implementation defined?

CTR_EL0.DIC is IMPDEF choice of 0 or 1. There's no associated
FEAT_* -- as an implementation, you are effectively just
reporting here what your implementation's properties are.

(CTR_EL0 is not an ID register in the architectural sense.)

thanks
-- PMM

