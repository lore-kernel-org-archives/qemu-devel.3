Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1072BCD5BC9
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 14:02:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRVsH-0003um-QI; Mon, 25 May 2026 10:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wRVsE-0003tu-9e
 for qemu-devel@nongnu.org; Mon, 25 May 2026 10:01:43 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wRVsB-0005XB-1E
 for qemu-devel@nongnu.org; Mon, 25 May 2026 10:01:41 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6886be3d39bso5648508a12.3
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 07:01:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779717697; cv=none;
 d=google.com; s=arc-20240605;
 b=iiDZK4tidl+pGYnz2oA5RvRpw7r3DYVFLeJ3uyjsloOKMmMbBdM07csjFhXMvYchXa
 DJ5qz9SyhqcxkATWez61hgYPsgGFQzRDaAMfVHkMGw5fYzaUI2vOGaijgG95LeCyo6/r
 yXLnIe82q/KWySJVFMYHq42TVzauoYlAjpsrqCI58u7XRJ7GmMnoWphS/lqK2E32vlHq
 817wTEVUzmQgmE55OLCtYbJKxB/kr/X+leoTkP7PtOY7FJ89VjMalYLlGSrqlIn3WqBO
 0f4aSHnEE+ZasodSVRPyBEB1tpKQXnFfYSecfVMsN6QqnLyR3kJxd43H7KmsZob6isxo
 tyoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=0wdcJkVGUx5p96tfuTzBh6BnrBYvfcM4iXQL2CkZrzw=;
 fh=U30oS2K1AS2rrMuWnjI4nrXCpFJ9SBQFwYT2t8/2HDI=;
 b=i3nyX0RDeJeAQPveL8J0K4pL8QmufI1FaogihApCuiNiI5GY1SDl6Ge/rNIcI1nwTB
 Zk7cCAYIbHSUe90mhKKFYvf0WKJvSQy0M7+9RdYjb8xAyEsx40S6Z80ndJ4hUw7Ym93/
 TLfAOmv8r0pMPutETcbFOPK0uAxvGOa0v02KzApzDJeO6gfLTuGDCEdIG234Cg+O3qjj
 tExSF2WOvpv3gAdouAemmliDb/jTM4E7+J5ky93EIJgVZ5btCRL0N++0oMLK8x2dlGzu
 Wl9rCWPxM2Y1pKw46oPTEEoeazRX4e5cJ3B0CwFJknWJ2NbXBuiDB1NjbLZkAn192X/B
 AtEw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779717697; x=1780322497; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=0wdcJkVGUx5p96tfuTzBh6BnrBYvfcM4iXQL2CkZrzw=;
 b=e7I1vMvqCqYEMXmyDZwsgTeMeTJsMJI0WNWNNep9iwyA5vGRpful8D+K0BSwyem9Cs
 e/wfE4aCD4NYSTjdqu53USlRpdagl23gZXCCBLFY3kqGC5UyP7Ru1FeR/c36rt4v+Rw6
 wYSg2/9I5nUVUANB+xDb16tAyOFJWrO0Q91pdj/xlsVqj0p7UE2AUNtMzCydMmZvXDjT
 PcjBVM3UOvvusgXB6j6z9nTyuusJMFwVhnrRUjsFynsieoX2SU9PV9WMwILXa+yt3XoB
 ERMSj+v0yF4D2ZfiNZZbcTQtM5tN3zqW8hZ8bSZGupaKpsTrc/cPbGaHud20cG0gOWo+
 NBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779717697; x=1780322497;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0wdcJkVGUx5p96tfuTzBh6BnrBYvfcM4iXQL2CkZrzw=;
 b=Ea73vKvBH7EB0/OGaYQcA9IThitF499nIihnlHW+aTztq9tMNfLgrLeVhDG33YY3T+
 SMFj25NLoqK911hUiT/9v7JACvWW7/H/umcnc/LUsNV8NFfz0VCnZ1xSktwvuB4pu6Oz
 lEODaXZlU9ZxZPvFMcFOuGWX8Fg+EaHn4FU1czL1lGPuma9VKtf54a/qDjKREN+tVpbQ
 0hB5FLd+pebeh/MuZrwCnWiH9mpCGCCFPZaeb70niQP62q1O48q1j3wd7DTrV6KbTnnI
 Jt43HMjGnziW7sujCw/xeN/Y62GldLW7cgRhl3gTAplBGY9qvSOt1NQgEVAE5dPLULKM
 tvKA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+tou//YBhtBF2PWq7B7SIWKyu5kw4Y2Ja3YyoLl2XZdrrG1p4iur+SsgOzSS3SDbgPYtSeNhV5xCgD@nongnu.org
X-Gm-Message-State: AOJu0YyEOmHcuwSZiqiyw/q2TVav9m1QnMR3cSpLwQ/NR35Qa14jLjIR
 MYAHOZbJIudRIj+0AxVqj4WzCCwMrdtXupzlgTo8S59y2N1e1JmfVTbo2fSDqnTyspUbWE6zxsG
 yH7mJ1DQYFu8VYzKAmkxNeWKm9ryAia8clXyy
X-Gm-Gg: Acq92OFuV7aDQkVwpLiBFKew0DLtvstnq2IiM0sUU5KFihWRRrmL38g+XD3v+a/On90
 Zaz1S6B136yZdf0EsxtF0fib0ZKeQqW52calHbMcIUGaEVqGhzWAlO+PrXLBzm29T/6FlS7ZaGh
 qRVEyzmnHgwkxR7kyIeDJq4EyNygF+aWWTWzbe73NgSs0MRFvjFV7s17J1VjVx0G0zPVMlwz4sB
 XJQKsyOxWdbftISOd6VUnheLUCJb09+lpze8ScO0EdSMmk8ksXAzaY9YFDZ2iYuD/43q74rK53k
 C1olstF8OSssA7VYj/Zx5kOZOzeEC87e1q3nhCSaFw==
X-Received: by 2002:a05:6402:320f:b0:67d:5c3d:8633 with SMTP id
 4fb4d7f45d1cf-6889cc6f56fmr7520210a12.26.1779717696895; Mon, 25 May 2026
 07:01:36 -0700 (PDT)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 25 May 2026 10:01:24 -0400
X-Gm-Features: AVHnY4K3xXGZKJx5sIoEME_sKAlLP1fJ94NIci0TrUcUHe-5IcHB7SoRUWBk7Ws
Message-ID: <CAJSP0QULyy5C0YEaxz2ChNy3_zfc5VwaMhB18R=yHDgnhBYo9w@mail.gmail.com>
Subject: FreeBSD CI after Cirrus shuts down?
To: Li-Wen Hsu <lwhsu@freebsd.org>
Cc: Warner Losh <imp@bsdimp.com>, Alex Bennee <alex.bennee@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Li-Wen,
Cirrus CI is shutting down on June 1st 2026:
https://circleci.com/blog/cirrus-ci-alternative/

Do you have a replacement in mind?

GitLab does not offer FreeBSD hosted runners
(https://docs.gitlab.com/ci/runners/hosted_runners/) so it would be
necessary to find somewhere else to host a FreeBSD gitlab-runner
(https://docs.gitlab.com/runner/install/freebsd/).

If you have a FreeBSD build host available, you could install
gitlab-runner on it and I can configure GitLab CI to send QEMU FreeBSD
build jobs to your runner.

If we cannot find alternative infrastructure, it will be necessary to
disable the freebsd-14 build job that QEMU's CI currently runs.

Stefan

