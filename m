Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF8BC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 21:16:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhFf2-0000rD-VP; Mon, 04 Mar 2024 16:15:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhFf1-0000qP-5N
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 16:15:47 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhFey-0007br-MM
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 16:15:46 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33d2b354c72so3744853f8f.1
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 13:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709586943; x=1710191743; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pzuZx5aNACkw+s0uZ08Y5q1cqQl3ruALEWPObHZRbSc=;
 b=uOtg0atQSV+oAF4+Xl1cgVx+o5cfDzIkZBqRXS+m+uiEmK2dsX/2QGDZmbI4bp1E0x
 iF9xRRKaLZaPnZt6253WxN4kBbRf3xPOzQLOxPFtaukJAM3n3eu/DbxEE5c1PtQKBGmM
 Kn5aKg7oUxha3nAm4lwtcAa5kABp8aDJRfEYIjTXfcsLsS3NVjZQzqqIgoU5J+AgTfoH
 oGCeS49m97kHmXKep/qyJ8fRYlFFhqkAf3ehEJ6kRb1vXef5kTHGpihMUZeOW/egv2oM
 hsq80fHdJdHh9sFM/AV422I0kue1cS+6ZxVvEPvlcIGwXjWDta0H80B1VZ2DOrhehc/F
 CAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709586943; x=1710191743;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pzuZx5aNACkw+s0uZ08Y5q1cqQl3ruALEWPObHZRbSc=;
 b=EFWA332xbjMqfIKlXEim0WpHDpBU/K81NhJ9lzY6eA4ZtmOHasRcLMCENhBHpa8MBh
 XV1OV3a4cRBDES0JkfDhsUJBZpGTmn13EW1bmT9OmR9hPGPQ4fjyV/S15WLCft0J5y3a
 /ubpeVkE+BmmqOTDzdNoUw3zFADwxhJIHdVIRn6dIafjd0zZFiUUoTYsAe3fyKNNnGxW
 iv1jzgJTCjTioZGWGdeChgwxa6ns+kRm+uT3JyErkOEZOCEAg3hh/akY+wJaiWV8WFsO
 Jcz/VJgi3fS72ta8s4hTixqfkOnjZD0hoSuXfynJOjNbWGGQmX+mK9kLg2MVLH2UlGHA
 nDCg==
X-Gm-Message-State: AOJu0YxbuJpDuU+wi/HsPTmza2Qosvi/EuQ/SqN2yD6xa7V26lM5ZnmG
 HKRgU8RC/B6GE3YjvbqulU+u4hrxiqqN0X/jdon8pfT3Srh3U4+R1X0axWVLF4jfFNYMdZj15Z/
 0
X-Google-Smtp-Source: AGHT+IFuOP26Njz2v1mNgOSUfrMA9SGKIASgi9SP5EnsB8fBpbZYohwW3og0OHA0sqG1USNJD3dCCA==
X-Received: by 2002:adf:b601:0:b0:33d:b03a:5e2f with SMTP id
 f1-20020adfb601000000b0033db03a5e2fmr7564947wre.10.1709586943070; 
 Mon, 04 Mar 2024 13:15:43 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 n15-20020a5d484f000000b0033dec836ea6sm13145332wrs.99.2024.03.04.13.15.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 13:15:42 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 60B195F881;
 Mon,  4 Mar 2024 21:15:42 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 qemu-stable@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH v2] docs/conf.py: Remove usage of distutils
In-Reply-To: <20240304130403.129543-1-thuth@redhat.com> (Thomas Huth's message
 of "Mon, 4 Mar 2024 14:04:03 +0100")
References: <20240304130403.129543-1-thuth@redhat.com>
User-Agent: mu4e 1.12.1; emacs 29.1
Date: Mon, 04 Mar 2024 21:15:42 +0000
Message-ID: <87plw9wvep.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Thomas Huth <thuth@redhat.com> writes:

> The macOS jobs in our CI recently started failing, complaining that
> the distutils module is not available anymore. And indeed, according to
> https://peps.python.org/pep-0632/ it's been deprecated since a while
> and now likely got removed in recent Python versions.
>
> Fortunately, we only use it for a version check via LooseVersion here
> which we don't really need anymore - according to Repology.org, these
> are the versions of sphinx-rtd-theme that are currently used by the
> various distros:
>
>  centos_stream_8: 0.3.1
>  centos_stream_9: 0.5.1
>  fedora_38: 1.1.1
>  fedora_39: 1.2.2
>  freebsd: 1.0.0
>  haikuports_master: 1.2.1
>  openbsd: 1.2.2
>  opensuse_leap_15_5: 0.5.1
>  pkgsrc_current: 2.0.0
>  debian_11: 0.5.1
>  debian_12: 1.2.0
>  ubuntu_20_04: 0.4.3
>  ubuntu_22_04: 1.0.0
>  ubuntu_24_04: 2.0.0
>
> So except for CentOS 8, all distros are using a newer version of
> sphinx-rtd-theme, and for CentOS 8 we don't support compiling with
> the Sphinx of the distro anymore anyway, since it's based on the
> Python 3.6 interpreter there. For compiling on CentOS 8, you have
> to use the alternative Python 3.8 interpreter which comes without
> Sphinx, so that needs the Sphinx installed via pip in the venv
> instead, and that is using a newer version, too, according to our
> pythondeps.toml file.
>
> Thus we can simply drop the version check now to get rid of the
> distutils dependency here.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Queued to testing/next, thanks.
--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

