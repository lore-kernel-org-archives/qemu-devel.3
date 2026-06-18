Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 234B2CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 13:41:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waCzr-0007dj-Oz; Thu, 18 Jun 2026 09:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1waCzq-0007dH-37
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 09:41:30 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1waCzo-0004PH-JM
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 09:41:29 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-45ef189aa1cso718307f8f.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 06:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781790087; x=1782394887; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ytziHivmZ3Ts986BXPALjqNqEstzsiyAR7DxAmCY5UI=;
 b=UbBV7e3Dc6cTl94FDjGDzbCtHTvQS/Nj4wDw7exJKTVaAuHb9M2AzE7Un98rjfjn0s
 l6FmIn85514rTnw6T6RLVKGuOC1w1z7qspXwlFtyWbiJygHu7s4udTsVwYaIctYOcbD3
 OLThBaIxHkDwCKLQM0WMtUZA3vKVMk4Sk2G2ej9V6Vpzs01lIBJgzWl62e0r/QEPPlCL
 ZZw3yMBmEXQaWs1CZ6VcugHGPQmAsQTZNxBlrkgydn2NLwPQltnO347wh6gKQk/lbR9h
 N6eNIMiXC15jMByrUlpDCjxqTlRC3OzdoroIgWSalS3ryMvAVX7F6iB9O22I9NncafA+
 uPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781790087; x=1782394887;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ytziHivmZ3Ts986BXPALjqNqEstzsiyAR7DxAmCY5UI=;
 b=rkeQQCP52IYkNFkPag1NHw3d1LAeWQqo7cBFNDy9acM6v691X94TeNYoM7bKL8y8CY
 ifepkF5LsYDz7i6fUXfZNtMSE62vFxsc6RYEqlNmlrKylubTEXIY6ijqy+Bpicgu7IMa
 K5n7FUG+FgoPImo0R4nCXt3Nzj4MIuBt0Fwl50KJADK1TWpNQ27/YUqQiwuTrK3zu2B2
 Yp6nZTBggIrd4jDrtHUeRa4JeRR4cviyTvGzMm5c/AH8g+eH3GBm/Fy91jG8n3CRSsME
 b8bweAxKMUDz95uvJuV2MHeXARoQ4eJmZeN4PujdiVRXQMjSzlr5wAyPVd7Mix2QaBCS
 CKRg==
X-Gm-Message-State: AOJu0YynLfDvyKjOOUUX42EZJiG0/PYIF2Re5PPQm2T9UnRzQftQXFaR
 GN8y6k4pkMHXWgdHd/SYR9k+RlQOwcJaprimVaszqFa8uKjigILK0c592e+/9AXVMQo=
X-Gm-Gg: AfdE7cnfrD+9UHl78q4Fw/46B42cGoGSV4l0HfOm4O+IXPsHdgUx3QuPPu/DFP7MyYz
 O1DKsO2b13RDzcU6oefBC6UBQaFDjEKd7AjEKv7Lesm9022s5mUdHFhUinVuyzBanwg5UYjUYEM
 atX/LHPSXwSWb+84WenLOgNCPI/na1ybDCl3Io9BqHxqtjhUUuElbQcrn97jEeJI9JR5kQK3A6a
 gPHpwdE7IRQFFodbMJAWxmaIDtKyGjshY8tjDH82v2xGuY0gkKzXXQy1BtxgKyZTvD8Kir03txn
 KvUPKnUJDDrYyvMl9W+sXxbaDL80UtzR2/13UuLFSFFLYTFxNPLvBa32dzThquLL59aZQtgRTRn
 VTNpOjtj3nYHt+PUgFEBcqZwTO+pLKJR8ATIQ8zXqUv0PY/660kWA7Z38ySNzViC0FdGzE23DQK
 NvfM2iAENVTNi5
X-Received: by 2002:a05:6000:184b:b0:460:3233:66fd with SMTP id
 ffacd0b85a97d-4623955ad19mr14477804f8f.40.1781790086874; 
 Thu, 18 Jun 2026 06:41:26 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f3dcsm59488631f8f.13.2026.06.18.06.41.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 06:41:26 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7969D5F905;
 Thu, 18 Jun 2026 14:41:25 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>,  Thomas Huth
 <thuth@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,  Mauro Matteo
 Cascella <mcascell@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [qemu-web PATCH v2 2/3] contribute: add automated tool
 disclosure to bug reporting
In-Reply-To: <20260618132058.1044341-3-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Thu, 18 Jun 2026 14:20:57
 +0100")
References: <20260618132058.1044341-1-berrange@redhat.com>
 <20260618132058.1044341-3-berrange@redhat.com>
User-Agent: mu4e 1.14.2-pre1; emacs 30.1
Date: Thu, 18 Jun 2026 14:41:25 +0100
Message-ID: <87wlvwezju.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> A while back we added a requirement to declare the use of any
> automated tooling used in discovery of security issues, and set
> a rule that the reporter must perform triage before submission
> rather than blindly reporting issues. This applies equally
> well to normal issue reporting, so copy it over from the
> security process guidance.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

