Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A7A5C54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 12:01:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI4at-0004yG-EM; Thu, 22 May 2025 08:00:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uI4ap-0004wx-89
 for qemu-devel@nongnu.org; Thu, 22 May 2025 08:00:12 -0400
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uI4ak-0003m3-2N
 for qemu-devel@nongnu.org; Thu, 22 May 2025 08:00:09 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 2C8151802F6
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 13:59:53 +0200 (CEST)
Received: (qmail 29660 invoked by uid 990); 22 May 2025 11:59:53 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Thu, 22 May 2025 13:59:52 +0200
From: Julian Ganz <neither@nut.email>
To: Rowan Hart <rowanbhart@gmail.com>
Cc: Julian Ganz <neither@nut.email>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 1/8] Expose gdb_write_register function to consumers of
 gdbstub
Date: Thu, 22 May 2025 13:59:30 +0200
Message-ID: <20250522115935.34716-1-neither@nut.email>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250521094333.4075796-2-rowanbhart@gmail.com>
References: <20250521094333.4075796-1-rowanbhart@gmail.com>
 <20250521094333.4075796-2-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: ++
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-0.01156)
 MID_CONTAINS_FROM(1) MIME_GOOD(-0.1)
X-Rspamd-Score: 2.388439
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=+1vetvm9cQqSzD4/InBZJvm2127GQIH+Ws0LgCmssrM=;
 b=yFWYrnQ1iKeJFzjJIDOR7C7Fw9G/6GIf56P4NkpmPIBCQsxeOpNr9W9nHno61+ETA0CGO/tU2b
 lLtLZxsbMhd06skVVzwIjrTJkZwjN6Mkdy/HdXrkisdtf90At6LtmSHg1kkJKPJHOWMfpMiqQLc/
 /PSfvFliZ3zlHhgiOxWbLyWi+BzU+2LmZEUTqtzc4hQuRHi2fHenuWuLzv6jdaFRPbXkRi2YDO2U
 2444dPzgiFYV/zCMTTrZ9CVz39dCDlTdVoy8mIENBsL8axlg0SLT0mB9K3A4cLhApyB1Iqw9y60R
 cwjXcf1Mox9d5UDRj/3n3i6Nuff9yA6nkUH5sEU7ZpoZAZiN4Zv5w1m4s515fuKkTnJQH9FpreeH
 rxzk5mbO0E1na9sRQePDYuvL28FEpSqOgoMYkhw+yweApUH5ElWRTdRcAjn06u6Bet/Kt3Ebmx1Y
 srEoKTuC4CtaBR2C1g+maDuIRIadoeUN3DIJrlZjv/PI0L0I0QIwF+GSd+JbXdaJl4iwjP6rFn2B
 j212BiJvcVYQmIMZyr14kvyRsjOH0gKYJWCS1FfoowxcQuXphpK51jtjzLojgFX4wm6LqaBm9AmV
 syr58+tokIaan6Q6ULhdz9sL6M2Ic9FBnDdkqvMH/l3AGnmI4cyLJAD+kfF69gD9HK/i0ETZ2oHT
 o=
Received-SPF: pass client-ip=185.26.156.114; envelope-from=neither@nut.email;
 helo=mailgate02.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Rowan,

> From: novafacing <rowanbhart@gmail.com>
> 
> Signed-off-by: novafacing <rowanbhart@gmail.com>
> Signed-off-by: Rowan Hart <rowanbhart@gmail.com>

As I understand it, the commit subject should be prefixed with the
subsystem the patch (mainly) touches. In this case "plugins".

Commit message bodies would also be appreciated. In this case maybe one
motivating the change in one or two sentences. It's obvious enough from
context here, but you want at least some context when stumbling accross
a commit in isolation (e.g. after consulting git blame).

Reviewed-By: Julian Ganz <neither@nut.email>

Regards,
Julian

