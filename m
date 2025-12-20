Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B078E6748A
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Dec 2025 22:02:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vX51I-0002iL-82; Sat, 20 Dec 2025 17:01:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sertonix@posteo.net>)
 id 1vX51G-0002hO-8H
 for qemu-devel@nongnu.org; Sat, 20 Dec 2025 17:01:46 -0500
Received: from mout01.posteo.de ([185.67.36.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sertonix@posteo.net>)
 id 1vX51E-0003Io-2x
 for qemu-devel@nongnu.org; Sat, 20 Dec 2025 17:01:45 -0500
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id E2C07240027
 for <qemu-devel@nongnu.org>; Sat, 20 Dec 2025 23:01:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
 t=1766268099; bh=7GaFkjIa2JN+kPrC08CkXkCPi9N2ucm0l8e4I5kJAOo=;
 h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:
 Message-Id:From:To:Subject:From;
 b=DHVRdQD75UGUYzWpvh0CUbeFNJcCPOO76I8U0755JdGWdkCldUx8zj6xKypuWIAuN
 m+P7PRVB+Z6lwHmsZ54afKjZmhkAnv5Be9krrqdgr/n3uM0DuLC7y83tciCaVGAsQp
 yvyudZc0g/ediGKTNr6QObXCwDVaj2CSrG3khpMHV4to08k8MbGJ9TVJ2T9UZ3x6ns
 kYZnrw+0cH5GQoeZOYYW47QhZCtxFgtUQtUO543OqIfjnihmJjQwVw6r/vNKo9XD76
 PD/zrZveiwrQCc/lI78g3xKwcWxgDW9w7G9c4TC+Dgg3CGrvv8GZzaZLafzsbWlo7Y
 nGtTwPczQ22tg==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4dYdfC4LMSz9rxF
 for <qemu-devel@nongnu.org>; Sat, 20 Dec 2025 23:01:39 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 20 Dec 2025 22:01:39 +0000
Message-Id: <DF3DSB1UV6OU.1UGVGLO1RGPA9@posteo.net>
From: "Sertonix" <sertonix@posteo.net>
To: <qemu-devel@nongnu.org>
Subject: Using -netdev passt with -sandbox on
Received-SPF: pass client-ip=185.67.36.65; envelope-from=sertonix@posteo.net;
 helo=mout01.posteo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


Hi, I tried to follow the documentation at
https://www.qemu.org/docs/master/system/devices/net.html#using-passt-as-the=
-user-mode-network-stack
and have a slight issue which might be worth fixing. When I tried using
-netdev passt I got this error message:
	File '/tmp/passt-GURUH3.pid' did not contain a valid PID.

It seems to only happen with -sandbox on so I guess the combination
hasn't been tested yet.

Does it make sense to change something in QEMU (eg. using -f instead of
pid file) to allow using both options at the same time?

